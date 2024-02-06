Return-Path: <linux-kernel+bounces-55638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A034A84BF52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C94B2893F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEE1BC20;
	Tue,  6 Feb 2024 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuSsaJyd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFD1B94A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255507; cv=none; b=mrMlHjl5a0JAjAFwMvVJLO7Y0RVs9Dpimd9QkcSE7TdZA1SRQ+6lj4N80bOK/qLIxZIr9io1d2MdBIJqGvr2vcHvyBRWP3UdYC9+PkNpcMm5/kBuL3Zf2MqqT5VKGIjo125mBht8zC9a5N1H+YhwfvECvBL2HXFXiq09RddyI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255507; c=relaxed/simple;
	bh=rE4YXZTAK8/K6LqNrGEBVaV4tM2xdV6G/bZSYUoWLqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLkNxeumY+w0UAe32eVkppUNVxsVis2VZt8P0e1uu11pnX+bZ7Wx2I5yZvpPccEQQPXzEDsRJVcY+OsaOTgXeszCuX4EkUmSL5vBTZ2lShRaTsi3W5ZFhVcDoxA0PFlqUV8Z621bneKfbhGdosSEFgZ4W5saCTD/4h+G2NFldZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuSsaJyd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60484a61250so10594157b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707255505; x=1707860305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W66wF3cG1Mm+5SO6bdtwwNhlqwZrH3jtwW2DZbOYgAM=;
        b=YuSsaJyd9Q8Qab03RUZVuq9kMqGgInPwBXESAkt2nTtYjUBwv5qdZRlRYP2qzcDW1x
         LRAxut0cV1syylJnFneBzu1iL2mDx7JP+abj7/aPLUbzeGyzVYWtduR2xnClvau5a/p4
         1ZHge+uvpH88EpY1mSngy5iYWi2gX9Y5WbErRmDgzRNwQeCQm3mwOonpzikoPAXINQ3h
         RmIqTM6deN5NGtUBC9FwX5EMG8ZrzNLwinA6c+zIq8WxQbi2DAFHKb1DNLj/ewRpwr5i
         t2vlhIpz4Yms2VpNdF9wxUtRjC1pwc+Kha79nrAOdEWZWHE88+AKL8noD4qmzZhYvkHL
         op+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255505; x=1707860305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W66wF3cG1Mm+5SO6bdtwwNhlqwZrH3jtwW2DZbOYgAM=;
        b=LgQ+WEq7PhjrLmHWN0M4HWOp49BgGFZ2OjfjFt2/SZ0s3frgM2uPmXSRJGSoLfkNW7
         kbStft6sFlMlENJxmyKILQjNPssYrg4LtQzRnRuWkmqtsXZzsegJLklPScVlxzCJDkAv
         nLQKspeu/aFsnIbUqfheH9wddGu1A8jScVHY2tptPYxhwWTZRHkySLC9TpleONi4sv9Y
         KoNLbfNXbtupFksswG8yQ5V3wkrT77hrIYxISnlzH+i8FivbHc8BIAOzhASGBfmjffOU
         saSxUo1K/ZwAeqcynKBGGtgAccMYQJ5cPsEjQ4sjux+krXDSu12WfsW2571U9upRfQVz
         J71g==
X-Forwarded-Encrypted: i=1; AJvYcCXV8PW3vb4VzQWdniRu69eVjqArxSIFL1mozvn3fpFG0xycb06x/jgz/8h4WZyuY+qQuCSQ4EYc3uyokNymHlF7jWe4VdISNHMQ0nko
X-Gm-Message-State: AOJu0Yzo+HFsF+yq+FJ9VRdqejqMZeZP3T8Yxi8lxzgm6Q4kObUikMhP
	7Yc7H6SIQaPy7LeUxvm7XwWVCF5lhHNgwEhj1eOr3SPMoM/fouXreB5TCJrelSokn8qmFwPoCjK
	dSg==
X-Google-Smtp-Source: AGHT+IHiAeKmFgSzCkoOpBNQOQAxd5iRG0YByzFAF2dlNYCd2mhXEpVl5aBPq6EtET+9y33q9uXgZT4FCpI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:7:b0:5ff:a9fa:2722 with SMTP id
 bc7-20020a05690c000700b005ffa9fa2722mr608095ywb.3.1707255505257; Tue, 06 Feb
 2024 13:38:25 -0800 (PST)
Date: Tue,  6 Feb 2024 13:36:19 -0800
In-Reply-To: <20240131235609.4161407-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240131235609.4161407-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <170724672284.392752.13925879466423785912.b4-ty@google.com>
Subject: Re: [PATCH v4 0/4] Add support for allowing zero SEV ASIDs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 31 Jan 2024 15:56:05 -0800, Sean Christopherson wrote:
> Play nice with systems where SEV and SEV-ES are enabled, but all ASIDs
> have been carved out for SEV-eS, i.e. where actually running SEV guests
> is impossible.
> 
> v4:
>  - Convert all ASID usage to unsigned integers.
>  - Clean up sev_asid_new() so that it doesn't needlessly overload its
>    return value.
>  - Split out the -EBUSY=>-EINVAL change to a separate patch.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/4] KVM: SVM: Set sev->asid in sev_asid_new() instead of overloading the return
      https://github.com/kvm-x86/linux/commit/cc4ce37bed85
[2/4] KVM: SVM: Use unsigned integers when dealing with ASIDs
      https://github.com/kvm-x86/linux/commit/466eec4a22a7
[3/4] KVM: SVM: Add support for allowing zero SEV ASIDs
      https://github.com/kvm-x86/linux/commit/0aa6b90ef9d7
[4/4] KVM: SVM: Return -EINVAL instead of -EBUSY on attempt to re-init SEV/SEV-ES
      https://github.com/kvm-x86/linux/commit/fdd58834d132

--
https://github.com/kvm-x86/linux/tree/next

