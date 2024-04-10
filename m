Return-Path: <linux-kernel+bounces-137757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642189E6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9766E1C2104C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BEFA55;
	Wed, 10 Apr 2024 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waO3yEnq"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112672900
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708584; cv=none; b=CC+oUz1qj7zGA8g1vYyGGf+h5zqY4CM4O3HrevUOpbyrLCSRQ4COtXTH44CKXmyc5Gnw3k45NaoAqSaUBvLwSRgDapwNSYXU9eU2GLgAYkPOLTMT55ruSS5yyP2pxScVJVFqpeR57EJHSOzEBP6TYeKHXZEwuDNVPca5j7xZUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708584; c=relaxed/simple;
	bh=qbAllYoFjx9HxUgTfIOlCWsC0dWo4XP1/Rh0PT3FHPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kj50qBg7tR9WOwBPeLirjogeUF6Ktnv3v+rncU5Eo6r51DDzxX9ERiCy4tTplL/6xWHkPxr0w1HznHTV3aFPnXesd8Wb3MBFX8DKoquCaXmhxuHkhYTQr01riwsr/ThSMEdUEjkrW7tVC/mh7IDadyqQyOPJY0znzcVBPhvG6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waO3yEnq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so5602242a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712708581; x=1713313381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODgFnzZURolTJcv5yfCxGgoh6Ey8Xg9T/7xWu6AFDU4=;
        b=waO3yEnqK+TpTUTw5lOYaQBgixdRqcbXYCI/XLqddaHPAOC3dyOYbRW7qZVu9RbYYJ
         SEFh0ENA3e8nlYqOxo4b6ut+43yTTjFFEAUz6QA63fY3tOe1UtoONeGdJBqHl/8oaFW4
         JmAorr1SjatgSnSfUGohHaP2ACdtBNJ5ce1+J9qeGEpxTp497lG0B9vhYTolGrKBG2/b
         J3ZtbTothoNvEjwHjg+czf47rI81+v7Jb3xJaLrdHbbnlupbS8YWDiUEE0nveGupl/4b
         DWq4tVIHEIHaUeKIg+JkVY8q+HWeADk2taWGJnIejx8xGzkq9SUwDqJYZ3GYXvyNVKhn
         dyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708581; x=1713313381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODgFnzZURolTJcv5yfCxGgoh6Ey8Xg9T/7xWu6AFDU4=;
        b=cemBSHVOWBmlphiNptiUEuXcvSEjR68C0vZW4HW+/PRfeq8sF654iFlbUV2PT4g6nN
         yq99V1PzIkLmXuoap/na3mr2YtV2i8WXDlat4E5KywET3BLJH3ouWOkQxgXaU1pSqko1
         3FHdO3lPsCc9qUCg+yOPePtLl+qujJe8YEN5i5kPFusTOsasNmkE43iAjvjkIZqevZ9r
         Bn0bPQI2AGPni5Ft4AgqK9ZxMGBzFqNknZQLDwjaLocpaLq0UA/wr4R7kcgGDmEGfzjV
         sEoEC/YY6vZlx5w99L13aL/ialMHBc9cp27j7c/WjevGAi72lYhq/iVXKslGtYGJ/NXF
         35kg==
X-Gm-Message-State: AOJu0Yz07qeE4AECqYzIejU8wFR/1TVl214iPVwDGLYGaLEXO873Omjf
	0dhtuxfAq5NrSj+CyTDAxqqiXOzUwhVt3dYw5lY+pACtVEx9v7DMGbh277Q+RrTPMtqi2FAdTbC
	3Qw==
X-Google-Smtp-Source: AGHT+IFxZ4YIeHwrsOIP8qB4kNY13/pCHAeW1+dcdPCjqmbXj6Q6la1p/S+Rr6uQ7F+iCZNNDwqyU2Eqsac=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4e54:0:b0:5dc:1b02:5a56 with SMTP id
 o20-20020a634e54000000b005dc1b025a56mr3245pgl.1.1712708581274; Tue, 09 Apr
 2024 17:23:01 -0700 (PDT)
Date: Tue,  9 Apr 2024 17:19:57 -0700
In-Reply-To: <c7619a3d3cbb36463531a7c73ccbde9db587986c.1710004509.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c7619a3d3cbb36463531a7c73ccbde9db587986c.1710004509.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <171270501999.1589908.16513783638221600780.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Remove a useless zeroing of allocated memory
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 09 Mar 2024 18:15:45 +0100, Christophe JAILLET wrote:
> Depending of the memory size needed, we clear or not the allocated memory.
> This is not consistent.
> 
> So remove the zeroing of the memory in the __vmalloc() case.

Applied to kvm-x86 svm, with a massaged changelog to unequivocally state that
not zeroing the memory is a-ok.  Thanks!

[1/1] KVM: SVM: Remove a useless zeroing of allocated memory
      https://github.com/kvm-x86/linux/commit/4710e4fc3e2a

--
https://github.com/kvm-x86/linux/tree/next

