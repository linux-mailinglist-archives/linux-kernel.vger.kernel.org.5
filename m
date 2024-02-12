Return-Path: <linux-kernel+bounces-61814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062748516DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72151F21E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56D3A8F2;
	Mon, 12 Feb 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCrDJtbp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8C28389
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747513; cv=none; b=mQz6vJBTt4YH0gO3hcUDIZDMjmwjF+CGwMTO8irF1L+4kVNyzlag4+RzUv5ZQ2baOcYppCPfpKl7pmm7l1gi2/1W0NrTEcU+e5cINwH2KIMpna+zuB+C3qarX9DWakgnQnnHHM028rjZe6D+FpzVKb1d47IQFtqvgaBVdn3g+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747513; c=relaxed/simple;
	bh=ORaM05u+SQpYXSj+eXNwTONcLStVssJo6HLOruOJg0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op0tEQbqyjUg27+ESZz/vnBZ2vfWh6zIFKF80WVuF05oe8ZrMsrRZmSH+f+4UMcMUwnk6NznncklllGj6Gj7k6ghgJ2Mgc3Q/A/NGY1iw7RKtWFBYtiMsfnnONHmpKHKLBSKZ+XI+pOuHrg0oSSLmBcKUnilLtMD8ijhUDxj74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCrDJtbp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707747510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W48aKMa8BxxJLlskfhsAFGXteeZPFQl7GxLayCGIEtY=;
	b=CCrDJtbpjGU39ikBuQL2mnooEc6W46AIhMQVqVZ+abFzwzLXT0NytPpZ6y8eoAVuIEYEnk
	w/vzW/vFokUpTqzjf11g30TMIYCtIuxnkFgFoH9J+mIzV0+dG8Dq9Q9i2aMWWO/QJtWgEO
	WlDWIucC6UKmLSIJ/yeqDB/CNVXQD0c=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Hg2BGmgCNRGLsj3pPOnvnw-1; Mon, 12 Feb 2024 09:18:27 -0500
X-MC-Unique: Hg2BGmgCNRGLsj3pPOnvnw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-603c0e020a6so39215717b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747506; x=1708352306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W48aKMa8BxxJLlskfhsAFGXteeZPFQl7GxLayCGIEtY=;
        b=lVeeHmZQuXhwonN1SZB0F7iNFUozhyAAm5XCww2OYSqlldZwLowbcoaiAn6NxSSTcW
         Iv22Xe6cftOij3X3VzOWbH6Fn6pZ876uPOC9iGOo3btJ5ZK/i3DHS9OO4pl4wqy/oFVd
         qmwV9LslBImhaapw9Tygt9//bWb85qd8veRo6OTJStN5kmGJsKheQ6eBKDCfQrhdsH2P
         WIfDZ+ZDzLhfqAty1LnvmfuU8+k/er0qcUawY62T+lVBFDii5sLsgDwIIKqw6TnzjIQv
         IrvqgoziBfaAldAiwiT0bSU27OCYVbpSRYXPwJytmvoaRJYXm4g2oewz8pS7X5jYikAA
         G+xg==
X-Gm-Message-State: AOJu0YwlH2P2UD7bNPFZoc5S4wLRHq+lYDUGdKutCKAkBZgUWZG0CFrf
	if23q1GsFrEpOwgwdYc0mcXGgzmH2N56TFBTo2SoekEB+vF+9acbDIAdAiYsUu0Ivhg0Qs+0egq
	7qVwBH7wB8yuyFojqrwxhvYPnrHHLqw6PiOCQf+gz2TH7RMZI5a9NkYAUUA8FGpMT9FVjosKdl7
	k5Fjym4kbUGDWL7KP/c+KIbHWDu4UP9gZyG1ei
X-Received: by 2002:a0d:e808:0:b0:604:9ba3:13d1 with SMTP id r8-20020a0de808000000b006049ba313d1mr3962561ywe.14.1707747506598;
        Mon, 12 Feb 2024 06:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr9iriaDlN5vdu7HHXbv+WvkPOeyIm6i1I5aenOm4DuBm2bZsCuFFJQ/BqNH+IhMX4V+hLMHFdpKxBMHEsEqU=
X-Received: by 2002:a0d:e808:0:b0:604:9ba3:13d1 with SMTP id
 r8-20020a0de808000000b006049ba313d1mr3962543ywe.14.1707747506283; Mon, 12 Feb
 2024 06:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <591420ca62f0a9ac2478c2715181201c23f8acf0.1705965635.git.isaku.yamahata@intel.com>
In-Reply-To: <591420ca62f0a9ac2478c2715181201c23f8acf0.1705965635.git.isaku.yamahata@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Feb 2024 15:18:14 +0100
Message-ID: <CABgObfaEz8zmdqy4QatCKKqjugMxW+AsnLDAg6PN+BX1QyV01A@mail.gmail.com>
Subject: Re: [PATCH v18 032/121] KVM: x86/mmu: introduce config for PRIVATE
 KVM MMU
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, 
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:55=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> To keep the case of non TDX intact, introduce a new config option for
> private KVM MMU support.  At the moment, this is synonym for
> CONFIG_INTEL_TDX_HOST && CONFIG_KVM_INTEL.  The config makes it clear
> that the config is only for x86 KVM MMU.

Better, just put this as:

config KVM_MMU_PRIVATE
    bool

but also add a reverse dependency to KVM_INTEL:

config KVM_INTEL
     tristate "KVM for Intel (and compatible) processors support"
     depends on KVM && IA32_FEAT_CTL
     select KVM_MMU_PRIVATE if INTEL_TDX_HOST
     ...

This matches the usage of kvm-intel-$(INTEL_TDX_HOST) in the Makefile.

Paolo

> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/kvm/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index cd3de7b9a665..fa00abb9ab39 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -189,4 +189,8 @@ config KVM_MAX_NR_VCPUS
>           the memory footprint of each KVM guest, regardless of how many =
vCPUs are
>           created for a given VM.
>
> +config KVM_MMU_PRIVATE
> +       def_bool y
> +       depends on INTEL_TDX_HOST && KVM_INTEL
> +
>  endif # VIRTUALIZATION
> --
> 2.25.1
>


