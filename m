Return-Path: <linux-kernel+bounces-131725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09395898B19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B785E2841B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2F12B95;
	Thu,  4 Apr 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6DCm33j"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B071BC57
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244443; cv=none; b=aa8YG2o+rImNVRWkvqqcetBw9hQA6EpqpVzLaVux5cOUlcwoQssKiqoqxtdsapqKtCPpSo435sNftNUvgG6DoSVBc2Nkfl43OiRDIDRaAo8nS8ys5XPXR545FN5j4m3QVIl76C73TdSVd+9mUfodpNcade7bpN9SKmlBa/+n+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244443; c=relaxed/simple;
	bh=KlM9F5O2juNJvFN5w2zo6JBv66qSLzYdQMnQy5Vksjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y8CzVPPT4MvkvYgddvejXRpcizM1qlZ6/zGzQuUeIFNGlovWmdu6ZZH4t/oZjwT+sIU05C3kb24n2aUu2ymgCfJnpeFzssYeoRKi9HmlbHmh2mY4Ar3PYZs4QOHWxxSj+kpUjFyPnDAMVJ1H1+4sWkBAHlqWq9uo5V5RUj14xe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6DCm33j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so1933052276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712244441; x=1712849241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPWb5VaUAp+WW9QZVpACL9cJTSomAzakoGZOvthGQ5w=;
        b=n6DCm33jhRn0PSn28HWas/cV+WwdvtKxpkOtjAfuEUGbEzIFpHLAy2s+gD/Df7NgzF
         tkxxDSe52HXDgdDKRlW2DKXCYUaBFDeK3QOE0+Wcdn4no9me2ai1LS4mFHfSWnF6+K52
         qcIMJUnEUgn939Je2bCx5Ant1NyP2HeMT3wc6xS9QlDRQr3+NOEPWEVq/2+OZvZkbHuQ
         tHuTw+J3t9ierxCpWNvJoy7AAOG/GUqauvgPbaiSVkwXK+edneOeFPkGWQiXgfR29F28
         0wdwgA4FZbPV6UvaqYgMpQMkmTq3NugK/KhvMzYhG2KDSYuhy8CfYAUbWd2yDfuhSRbz
         A3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712244441; x=1712849241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPWb5VaUAp+WW9QZVpACL9cJTSomAzakoGZOvthGQ5w=;
        b=g9pxYrEa7GY46w+bIZPhm5yEEEFBy72iZqSDnrUq5fH23O0eQb1Wq7saq8Ab2bchf0
         ZlWLgDNzf8vkoPJu3SPnBcuap+zHjwiXfdtHEDtl9wxR/VRR3LEjAIFABrFLcy9F47j+
         GrNQEm0Oja/qzpH1Un0Jg9NBb8gofZ5ForgQQFWSgI+1g+JKDlT0a+r20jEkkc5CiuK9
         J90Fg4v2TlWxxbdgFwqnBechgHrviPEXunoWIde12NVqybUB5pWctCDApxn73jNHNKQM
         9gC9x5G3pHZn3T/KJBljSCDxXpklB7yIagPMrHGhT/qVIjCOy39Unq4/YvNj0KZ8aDaW
         ASeg==
X-Forwarded-Encrypted: i=1; AJvYcCWjgqEWWyusjI+FTh9OUfHEjLzSh8O78KFi6GxzctthUDhHAiIClDIkSZJI+bIiOknamCC3hlGtLmM32D8Jeu2s9MV/djzhq44h8UFq
X-Gm-Message-State: AOJu0YycxDeBBSF1K+iScwn2rExznOVpLwWupRG0ybOuWlzAnnfa2u00
	PAu1lJwf6Hmc4gFUV49zhSSApGqoiU0jYfr7IvLvrSa6JsZQCbFL3MJ9wNUxOTowFt7usLiG94/
	S+w==
X-Google-Smtp-Source: AGHT+IGSCyL+A/5ZYdhEc2pyPuzhfDwqnuyR5mmOaZEtM/J3Mu5DvsGLC97PQtk9OMgTEW7Aeeqx/ML6e9w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100c:b0:dc6:e20f:80cb with SMTP id
 w12-20020a056902100c00b00dc6e20f80cbmr260086ybt.3.1712244441537; Thu, 04 Apr
 2024 08:27:21 -0700 (PDT)
Date: Thu, 4 Apr 2024 08:26:29 -0700
In-Reply-To: <7db8d0a8-c668-44be-a348-58120a97fc2b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
 <20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu> <8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
 <20240402192314.a9b4e05637444314f47557e4@otheo.eu> <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
 <20240403175407.f81ebc5cc3300ffa0c39f597@otheo.eu> <7db8d0a8-c668-44be-a348-58120a97fc2b@intel.com>
Message-ID: <Zg7GpY0_U_7yhe6P@google.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t
 to avoid split locks
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Javier Pello <devel@otheo.eu>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 03, 2024, Dave Hansen wrote:
> On 4/3/24 08:54, Javier Pello wrote:
> > - The third way would be to disable split lock detection on x86-32.
> > This can be as simple as setting the default to "none" in
> > sld_state_setup(). Not the most elegant of solutions, but beats
> > having unresponsive tasks.
> > 
> > Would going for the first one be worth the trouble?
> 
> No, it's not worth it.  Let's just disable split lock detection on
> 32-bit and move on with life.

Please don't paper over the kernel flaw by disabling split lock detection.  As
Brian alluded to with his question:

 : What would happen if you ran a 32-bit VM on such hardware?  If the
 : split lock detection on the guest were disabled, would the host get
 : the fault instead?

running these kernels under a hypervisor that has enabled split-lock detection,
or Intel's newfangled BUS_LOCK_DETECTION VM-Exit, will result in silently
degraded performance for the guest kernel.  The split-lock will trap to the
hypervisor, which will likely throttle the vCPU to guard against a DoS attack,
e.g. under KVM, IIRC the default behavior for split-lock is to stall the task
for 10 _milliseconds_.

In other words, practically speaking this isn't about supporting a new hardware
feature on 32-bit kernels, it's about preserving performance in real world
scenarios when running 32-bit kernels on new hardware.  And that means keeping
split-lock detection enabled on 32-bit kernels is a good thing, as kernels bugs
that would cause hard-to-debug _customer_ issues when running 32-bit Linux in a
VM will show up as easy-to-debug splats when running 32-bit kernels on bare
metal.   I doubt there are many people that are still running 32-bit kernels on
bare metal, but any coverage we can get would be very nice to have.

