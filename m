Return-Path: <linux-kernel+bounces-165845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477A38B9247
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2492282929
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26927168B11;
	Wed,  1 May 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArCAS5Ae"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F305165FD0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605867; cv=none; b=BC8r9kSZOJ2Dd7JFHCyCf8OrFkKcbEdmNeFvoSew1f+BIqYZ12J5VobWTrSbGPCcc+yqjkkYmuhO5RhscY/AyGsM/mUZ1asKYxrlMFpaZUdsMucGPiz2tObB5bMcq6VgoNe6Kuu7B6/QYiqhSm5By97ulkdmMufYo8xxW59bl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605867; c=relaxed/simple;
	bh=VifpY+xyW/gzCq3YicTXEVs9yPdN1FHL2KKa6ZE287Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DZNgAo+VjG8hYsryo+383M8lg1EmuiNWfzeiJJBU+WxBg7YW6hb2tHbkmqR/FDHBcQ8p/Rf3HqoywTWEv5dwbP50ePvR3ES+rWn7hSm+dtBU3tZghAtmusYjbapv8A4dHLhrsRBRvvtAcjvcyNclKjPg5J5WLlOhoNz+H4t6s5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArCAS5Ae; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f9ca09so47017567b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605865; x=1715210665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5vosIo0gMRH6qTCFu6LsPALv1eiNHRipwdDGqxFopXI=;
        b=ArCAS5AeOAfSa6uJFwBL0B23IHes8YRZcv91bwIunzeqQPL6Iq1CIrUgPfq/yRLrnE
         j1Dug4gx7jKX9AxjsK7YVg2H/Fo8CrNvahiSISl/VL4Z2TnWVY47iEGdVTqZhXob3Eag
         a2yxCnhFUpeg8s7dHi9UqRH9DjqKw2l/QEcyi3pIpBx2zKtuSlWMPcJj5TsdNC/gS6fv
         Wait+jnb1zQsGXmgphYmZcuAI+TjLVvaSaxQasSyQ1zhVcfWXJCDB8GHmRAOgQKOoIl5
         h2r8W91n4eRbgRbRnlDkmf/oMogp0OmUxrrhu8esvF4rs52GWoOaYNl18Q2wuzS8/F92
         hKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605865; x=1715210665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vosIo0gMRH6qTCFu6LsPALv1eiNHRipwdDGqxFopXI=;
        b=glHRs5PXTto2eh1x1Luhoe/liVudePwbpCu1KpGOYXO/N1s6/2AgGjbSejH8T+CKyY
         qvSO/RJX7VOowL/lfqvV7N6TjjmypbDb1cdgdYu4vQU/LKxJgOehs9rxLWtgHyEXdllv
         VS5uJgPCzeH+CyJ/bJHDFhtRdST/5mQlCIp2n0mwlqwcolYaYikWLfq73b6Xw3PRe5z8
         +S26jdjw+pbt2XHnZGaO3pczfYEk4CIfC8BFjrXmQtnrnxekgVrpjPgKGiof+C/HAOmJ
         baMDlOEFYRPu4Dfp64lFEqOC/sX8I9QN8rENVsCosoDo1YLc6gcoKrNRApuYgxhL9SBf
         surg==
X-Forwarded-Encrypted: i=1; AJvYcCUoJHtmL3JDBqNmxSmguetvL4YH0SY65rhGO/CNnQf0mPm8v5Bslvs79PUsXW28BL/2E8G4rd6qJjrY1LcHAuwXxN5NiPT27BsQu3wT
X-Gm-Message-State: AOJu0Yx+M6OLIiRP+pGatPx9KNiAv5X0FYHrqNRf38OPXTAg7yyXm++8
	wfhRdgghl/1nrIWJDfbPGlYTEEP6+ynMe0wpRfIGGbYj9Jpp5R+NcDOuY7BvTX3tDwQqQwvK8hf
	Q/A==
X-Google-Smtp-Source: AGHT+IEnnNfHAIbfq9BzuSdEg+vee5vGVZU7dbAGHJbCSnMRbQ/oZ8RorZQopLDKa1hgOqEp4OXgxsEx3uU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8448:0:b0:61c:a9de:471c with SMTP id
 u69-20020a818448000000b0061ca9de471cmr1111986ywf.9.1714605865193; Wed, 01 May
 2024 16:24:25 -0700 (PDT)
Date: Wed, 1 May 2024 16:24:23 -0700
In-Reply-To: <20240219074733.122080-28-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-28-weijiang.yang@intel.com>
Message-ID: <ZjLPJzh2OmrYW-JN@google.com>
Subject: Re: [PATCH v10 27/27] KVM: x86: Don't emulate instructions guarded by CET
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 18, 2024, Yang Weijiang wrote:
> Don't emulate the branch instructions, e.g., CALL/RET/JMP etc., when CET
> is active in guest, return KVM_INTERNAL_ERROR_EMULATION to userspace to
> handle it.
> 
> KVM doesn't emulate CPU behaviors to check CET protected stuffs while
> emulating guest instructions, instead it stops emulation on detecting
> the instructions in process are CET protected. By doing so, it can avoid
> generating bogus #CP in guest and preventing CET protected execution flow
> subversion from guest side.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---

This should be ordered before CET is exposed to userspace, e.g. so that KVM's
ABI is well defined when CET support because usable.

