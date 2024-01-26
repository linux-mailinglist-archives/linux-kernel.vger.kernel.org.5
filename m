Return-Path: <linux-kernel+bounces-40339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B983DEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE1828BC90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143691C29C;
	Fri, 26 Jan 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfBZq2dD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52E6AB8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286641; cv=none; b=qW978YaISBepMi3A2jTJND51eZ7sZ6X83kj4ZjNesAbmfQU2DSnV1yBQi5CszlPRNQJd6Yo92XtysmrzaVY1hDDsbh75EmPj+Nw7rfpzTUbxDagO0mve5QZzn7CKXwMaKa0M5v24GlMnloyqegjcvVtDABN3ZDdKDU3ZvkDxqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286641; c=relaxed/simple;
	bh=IMZwz/sIak+ni3fCNG9vvy04t1J1gARfaSt2wuyb8BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pkubuMclfv4fwCqEhhU4DSpYe62BJ/jbC8oRzP5KgqtCyyvdu/mgwezUDdWH4E2q4MtmYgD/DGic4MjyK5XOtHGYdP1i2tz9Ol5Y0vs7lHTft/M39TYglg3t3+G+nXNbfYcfxhMs3QHSlLv7Zjk2xC5GTAXrKPxmiaZRIJY5I6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfBZq2dD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706286636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gY4l6x5sIVmCVLmLQTixMhgQJ/BHDFv5tgeYWPd82o=;
	b=FfBZq2dDe5MlHSAg7t1X/TjIMsbRSKIuX/BQriBtOeZI+nLfwLQp+znpsZQPlLGJohzfrV
	sIJXCgsji/9vsTCg7lZQTmSStB5Izmv6JfZHL/3mPikGoRdBYjOHi3LCPLy5GTmOKFS1UL
	gVCQzXk6PYDMu8vVDvd0ON8yJs0QnAk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-FuDr_iDfNeefbGaNXFS13g-1; Fri, 26 Jan 2024 11:30:30 -0500
X-MC-Unique: FuDr_iDfNeefbGaNXFS13g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6887759ff05so10075806d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706286628; x=1706891428;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gY4l6x5sIVmCVLmLQTixMhgQJ/BHDFv5tgeYWPd82o=;
        b=BehKhfzLzc1KLKt6/zb0DeusLUagF4oLWUIDYIOLnrsdlu9jAoETVyutlR+Ufx/IUo
         /1YDVnq+vUbGq26n422268cvVJ0jY47hA615/ja/vytHEn8RSwgDAfJGgfL/EB4n3Txf
         8CVpUQFl2aXEn8kmjBrQSKc8ifzO5UUu+zMdIZxUcG+dxVSxS3OWDw/+L7tLmYmzQzoZ
         /APRt/iNUfuva3KYpWYmTr1myvC8sBtsVhWMnDTgKftGT+2SUG3eNsr43MRh33lVS/jx
         1TWoQDumpYSnO2H0F8REID87HWTXBzl79lKgf4qewWEKJ257oJEGl2MkMan2biTq6TFx
         DANA==
X-Gm-Message-State: AOJu0YzuNYP2HBlQneGJSuKoiiLjkAoLPV60qoOto5azGRk6spEjas8B
	aeEjAo7OJdjGhFlH6NF7HctNSE27ONGkfIU0t9dCyTlwp6LPrFV0q42WcW6t7/AWrXhTGH7FBhM
	BwtCYNZAwZosX3m8PkD54tf40u/lVhfui58FI9MHdA0BR7bKI7sLEd860sP+UCQ==
X-Received: by 2002:a0c:e382:0:b0:686:abd8:7758 with SMTP id a2-20020a0ce382000000b00686abd87758mr1897438qvl.54.1706286628360;
        Fri, 26 Jan 2024 08:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkhyUOu8XVHFCRVUlx+Ps+2zcJ2CYKCZJ63CVwXORpu9jpEVTmo8zVKyAWMSU3QRu+q5ypsg==
X-Received: by 2002:a0c:e382:0:b0:686:abd8:7758 with SMTP id a2-20020a0ce382000000b00686abd87758mr1897421qvl.54.1706286628109;
        Fri, 26 Jan 2024 08:30:28 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id dn11-20020a056214094b00b0068179afede6sm621527qvb.100.2024.01.26.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 08:30:27 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, David Matlack
 <dmatlack@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH 4/4] KVM: Nullify async #PF worker's "apf" pointer as
 soon as it might be freed
In-Reply-To: <20240110011533.503302-5-seanjc@google.com>
References: <20240110011533.503302-1-seanjc@google.com>
 <20240110011533.503302-5-seanjc@google.com>
Date: Fri, 26 Jan 2024 17:30:24 +0100
Message-ID: <87o7d883bz.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Nullify the async #PF worker's local "apf" pointer immediately after the
> point where the structure can be freed by the vCPU.  The existing comment
> is helpful, but easy to overlook as there is no associated code.
>
> Update the comment to clarify that it can be freed by as soon as the lock
> is dropped, as "after this point" isn't strictly accurate, nor does it
> help understand what prevents the structure from being freed earlier.
>

"No functional change intended." must be made a requirement, especially
for those who made it their trademark)

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/async_pf.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> index c3f4f351a2ae..1088c6628de9 100644
> --- a/virt/kvm/async_pf.c
> +++ b/virt/kvm/async_pf.c
> @@ -83,13 +83,14 @@ static void async_pf_execute(struct work_struct *work)
>  	apf->vcpu = NULL;
>  	spin_unlock(&vcpu->async_pf.lock);
>  
> -	if (!IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC) && first)
> -		kvm_arch_async_page_present_queued(vcpu);
> -
>  	/*
> -	 * apf may be freed by kvm_check_async_pf_completion() after
> -	 * this point
> +	 * The apf struct may freed by kvm_check_async_pf_completion() as soon

Nit: "may be freed"/"may get freed" maybe?

> +	 * as the lock is dropped.  Nullify it to prevent improper usage.
>  	 */
> +	apf = NULL;
> +
> +	if (!IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC) && first)
> +		kvm_arch_async_page_present_queued(vcpu);
>  
>  	trace_kvm_async_pf_completed(addr, cr2_or_gpa);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


