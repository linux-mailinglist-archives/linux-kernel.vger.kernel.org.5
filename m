Return-Path: <linux-kernel+bounces-45560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84521843265
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFEF1F26F59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146D1F5F5;
	Wed, 31 Jan 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FeB8IdHX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E731DFE5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662822; cv=none; b=p3j+zEH4k/J683DAs7cpMPAaQnocYOSDqA/XEB/kb71q3YcVtQbDxvqRFsvILAEZpA4UXI4Ag7EA5To3sAFn3jnoS+WKJ9oH3TsrG5qOMLuIZukdP+fCVWOACqwy8rEEnApgSWWgZQFzo9k1v2UKcXQZSfUK73+AdASEIP0Aceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662822; c=relaxed/simple;
	bh=W81WAwbpwNinHckyfmuSp2lMOLfp9DwyrmSp+33sI1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jdDBOrxILYhL7xDkTpwYcqFMwX+3Ay6twsEHJZOZ+wgDsz7MfQCO31Pw5Zq32nhJySfU3Db54UCuYJu/FM531HgHYRMsNQ00KhJbVZMpL+iAolaOKPMnMk7cz/j6zW9lIVegAyQvafwMTntG2WRewqVb+GLOGHm5jw5BiRF3SVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FeB8IdHX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d43d0d6024so3066977a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706662820; x=1707267620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKWIiu7uHz0RVP6+wAtO6U5GdJZCiWNuIT4RisPJ4tc=;
        b=FeB8IdHXj7cIuFfSYeci3ynBgl5HLXN1rmDHHAF/O/e4GaIawfOxki1VOL+uuhBmKO
         YE8Zj6PLMABeQCEyYFlboN83SzaKbbScUpHchQEKP/c4l3FNZdluRS8cux7RUNsX2OGm
         hXEd/2GgUbWxIoLCC31Xj/yVmB3tcH67ExAeVizJomTgLp6/csNBhIdSVrVDqGp69zu4
         UX3ZK2agyw8gp6gr0KHRUoqA8/PrPj135u5XwVPX07iI+L2oq9vKlu1AdJmeIFget05W
         TjV+wYr0zvR4ro241BBfrQWv4KhI9AmR6L+d9pjmBaQoV6QvNggr7Aj79j4+DmfIqSi2
         7yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662820; x=1707267620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKWIiu7uHz0RVP6+wAtO6U5GdJZCiWNuIT4RisPJ4tc=;
        b=qj+KI750+EpX8d5GSyOyldXLL/GI5oos4Lom9zymi7vSdhxjcE2aB4hom4Y92fUGYE
         EuE2nKdhhL6qJV/fUIUnec7a0gKVTlpRMPaZXEESAEVxlpWzGGjEkenNuXK00NeXvHwM
         HQOtqeYh9gtvTZp4Xb8acfN69MVUjrfDzUXu9UOM4sDPmNaRT9hTWDuKhBAqCUpSWQMa
         tfF8QPabQhE1dIyN1tfSWTXXlz0ZEgoaReNrQq/8fVO0B6uk9QgeMRuEJfb14JLo+pRW
         Vj236wcx4hP5kIzum7xRfidI7BWmwOTYt2XD/3t6CHEqYMk6L1DlaGtrb78J7o19jvda
         KLcg==
X-Gm-Message-State: AOJu0YzYmDZJTcuCfV0V2nGHfom6GQYeUl+3b/BOjTeZtEzRM4rHuLMx
	E/TZuWzB4xoz9hJ0akjRl4ZDbD7HwguKj4rkpS7OnRT7HJmWY7+Qgs8NJXKix22MEYNDQ3EioyK
	PbQ==
X-Google-Smtp-Source: AGHT+IEM1cso6fIfX03D7X87/AGdU86vxPOMTGT+qtgZw5no5IqwR/Eri9aeoz2kcYXs7sCN2nfhVwOS0sM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f748:b0:1d8:d3d4:4ee9 with SMTP id
 g8-20020a170902f74800b001d8d3d44ee9mr699plw.1.1706662819214; Tue, 30 Jan 2024
 17:00:19 -0800 (PST)
Date: Tue, 30 Jan 2024 16:59:23 -0800
In-Reply-To: <20240109220302.399296-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109220302.399296-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <170629088602.3096343.7212872953446337485.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Delete superfluous, unused "stage"
 variable in AMX test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 09 Jan 2024 14:03:02 -0800, Sean Christopherson wrote:
> Delete the AMX's tests "stage" counter, as the counter is no longer used,
> which makes clang unhappy:
> 
>   x86_64/amx_test.c:224:6: error: variable 'stage' set but not used
>           int stage, ret;
>               ^
>   1 error generated.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Delete superfluous, unused "stage" variable in AMX test
      https://github.com/kvm-x86/linux/commit/46fee9e38995

--
https://github.com/kvm-x86/linux/tree/next

