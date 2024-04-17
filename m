Return-Path: <linux-kernel+bounces-149296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0CB8A8F02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529291F21F72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312384FAC;
	Wed, 17 Apr 2024 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NXJO9Dyb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B58172F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394529; cv=none; b=eTAr8kgC09mhSggSxaX90kRGM9LWr028Nxks8gZbyo1qP4z0uBgolAjIP6739aejbX2srrYJGGygc08Da2LImcj3pkYEXxGGpTzZtlEB5nuvuDB9uKRPizKsGZzMLkH1ggJ4lvcgyuPD1c/Az8McwXJMJZxXiMaO4bUU5DEMQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394529; c=relaxed/simple;
	bh=kW40dB2yzYDh9x/80/nbPntsw8+rODtFNEB62eheGQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r+Yef8/ioiWaSMmBr0t+qK46JImoiqhHdA5Ig0CWLu22S6zXlZPxqNlMKeCIrReq6SWr0TQKl3BXC60m6u5uW3oi4adOmkjabOvKKHm8Pl/je4r5V/k+DjiP6vkt2ha3Xs7VzP4tNjNjHxiTNGb4/peQ9+4kdgJT+/1gFgJngds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXJO9Dyb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615372710c4so3778137b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713394526; x=1713999326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpKfRr7nHqZVnUOIa8FKZEgT0nhWFfdfiT383hevLqs=;
        b=NXJO9Dyb0YY38wOV4iJ1egf0+dbUvm5ODLlDkc0BAi0d3DitllrhvkxKt3EQiRcOPI
         9AldwclgHdbqTrbHZUEeWDbUvhxNSovmIO4Dt/mod+t8xytKeNPAEbsekn9XdlhAxFad
         9JIVqpumymb3fbSS7hNVuLi8+JU6Pzsovz0m23tRBlnJnn04dUFlucJRQCaJwq21SN2U
         QbcN6FXVtZNx7Rs/4tPGBRx9+zDGGIpNfc3OcKoFJnyzHpnW2BtR2BUhGo8f10dt41+x
         LZ/0AtkD/BhAH8+bNDWVW0YzAm9rFU1BSnQeEB8cBURAVPuiQ2uS40aGCw7Jp69qGUep
         mjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713394526; x=1713999326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpKfRr7nHqZVnUOIa8FKZEgT0nhWFfdfiT383hevLqs=;
        b=EBav2tqMsiz/lO5hcv57t3W0Q93e+XCghCA6Tu8JftErGTSupB9/+05cgbtn1xdXaX
         Zfpf7l4pstzx+SYwmXxEBPsZoS+Mupe1rpPjnClyKf6+QEep9RUMuykweRjZNaNZ49ZO
         tTvVfCyQdkfeu5BbHPFSyxwdszoYx3zBUoW7+smeNGxJmpqoSQ66MlmMdLQyJU/fvloY
         LJK4ai+tsq27C360v9geqea2CHOnOzjHh9vM8oV077morqV4ISHMD0sRfGQZXyTGwwjt
         60iqrRKiXlWttyfyXUdVOROO6qK0M4r6FH7nic2/jIhn+QyiSuB02WPxJ7bZcR3M2Eac
         1eww==
X-Gm-Message-State: AOJu0YzFrVvPfbLMMZdcAP0SSsa5SLreyV5RN7qgyMDF7Yd3OL4KozO3
	Il5y6ZK1GF+VWyNURsGNWd7I2hSJuP4dDoebwQa1fsYAbxIqh1OBrlC17W9PMXeV5UN5WunYcqY
	+Dg==
X-Google-Smtp-Source: AGHT+IHJ0iLNfROqYe66iLC/IXW1ywQ/p3raaa2b23Ub+dXY3VtAYrWEn++SJ/FxqTYKzhUdCmNrk+Y9ZQ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a097:0:b0:61a:d0d1:1813 with SMTP id
 x145-20020a81a097000000b0061ad0d11813mr140176ywg.2.1713394526306; Wed, 17 Apr
 2024 15:55:26 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:55:24 -0700
In-Reply-To: <20240416201935.3525739-7-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416201935.3525739-1-pbonzini@redhat.com> <20240416201935.3525739-7-pbonzini@redhat.com>
Message-ID: <ZiBTXPqx8qsf75IK@google.com>
Subject: Re: [PATCH v2 06/10] KVM, x86: add architectural support code for #VE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

KVM: x86:

On Tue, Apr 16, 2024, Paolo Bonzini wrote:
> Dump the contents of the #VE info data structure and assert that #VE does
> not happen, but do not yet do anything with it.
> 
> No functional change intended, separated for clarity only.
> 
> Extracted from a patch by Isaku Yamahata <isaku.yamahata@intel.com>.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

..

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6780313914f8..2c746318c6c3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6408,6 +6408,18 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>  	if (secondary_exec_control & SECONDARY_EXEC_ENABLE_VPID)
>  		pr_err("Virtual processor ID = 0x%04x\n",
>  		       vmcs_read16(VIRTUAL_PROCESSOR_ID));
> +	if (secondary_exec_control & SECONDARY_EXEC_EPT_VIOLATION_VE) {
> +		struct vmx_ve_information *ve_info;
> +
> +		pr_err("VE info address = 0x%016llx\n",
> +		       vmcs_read64(VE_INFORMATION_ADDRESS));
> +		ve_info = __va(vmcs_read64(VE_INFORMATION_ADDRESS));

As I pointed out in v1[*], pulling the PA->VA from the VMCS is a bad idea.  Just
use vmx->ve_info.

 : If KVM is dumping the VMCS, then something has gone wrong, possible in
 : hardware or ucode. Derefencing an address from the VMCS, which could very
 : well be corrupted, is a terrible idea.  This could easily escalate from a
 : dead VM into a dead host. 

[*] https://lore.kernel.org/all/Zd6Sy_PujXJVji0n@google.com

