Return-Path: <linux-kernel+bounces-40328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAB83DE95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0664E2882A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5E1DA53;
	Fri, 26 Jan 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXa9OMqL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352E1D6A5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286236; cv=none; b=tHH/gSdmBTipItnqLCcY7wX/nmbUsS9TuHLadNlivnkpeozDtSJjCgfe0xryF8PBDTm/V/0YiXfLgxoHZxJPN0NnVJo2/01Yfoyw3HsUz4Yn1S/p0z4Cy8Of1vo54jukzFD6w0AjGeuxCAKutHj2jj3nN8E6B6lM1EhVZD9c4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286236; c=relaxed/simple;
	bh=bgqYBRdXDBjnLZ9RDk6qeuH1qHvE6bf3kTpXW6mzD/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jIdut5vNgbD0e41N7kH4pMRcNl6vsPBM3O3N16pLbqUp4joI43FnvUk501a1Nj2yTGlWQhqX8sK9Rlnhj+K/+5SuMxCOTydF9ntFuQmBUCkcATeHog+NcNdMstWjTsyHIAfNonQe1L/soDhfQGUnGVDP4MnvwHunZ921nE8/I9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXa9OMqL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706286234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qbqe4L6rDvckU/fkkWd/sccBKZMMWe7mYS63GRQ117I=;
	b=GXa9OMqLzDcluiCIHEplbtCOF3AiTM3Lt9GKPj65vzl3VHY+8WT2cZPbYnHuHvuv4znUfH
	ur//zxu/o3tZTT95I6yAoLvZubXDPyVCvezr7KRSZ0GXV+72AqdExT43XFLJU6x3WJzRcF
	hBCVlhh7y3AM6+pOtHdWsO2ldnMeWEI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-5oqoCXUePEa5qeYe3B5GKg-1; Fri, 26 Jan 2024 11:23:52 -0500
X-MC-Unique: 5oqoCXUePEa5qeYe3B5GKg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-783ce4c56fbso80120085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706286232; x=1706891032;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qbqe4L6rDvckU/fkkWd/sccBKZMMWe7mYS63GRQ117I=;
        b=h6yc+UV1UiIXQ0OpPlTWW4mC/vF6kwVWVuvizhmVYtLEXXe254RmEdVm4+AjfT+fE+
         2CvJIpCSLhfiU58JZvUvjb59ncL+7rFGbOuS/8/KpBzjv3cKg4uXU4g15bVN7xLsHKhm
         Pg+aMzGOGKCf8F5anmJ424sJeOLKLiBg5sk5wdZHFEBl9ZbWfsGgKqlGoVf2k1E37iie
         pxB5h2TxFGL4b8nOgKH+Vh7bM4SerJJxfjX2X+R5miV9vC1Qey3QRlaOMzrPHsgquBZY
         u0S1oPnJcEvgG+9r8349BEW8TOd770y9eNpC0MrByUSUHi4bzsznKI23GTqt18uPfTsl
         QdeA==
X-Gm-Message-State: AOJu0YxHk9E2ILKfkxyMu5dMjFwupTu3MdZX9u6J5NtTppzTc00ClbZx
	S6Fuwp7JRf//wcayubaMYOxZeXCV+hlTwqBZWWTs9NU9ZT+CQ4jiPuRfiq0Qv09lEBE+PoBGEDh
	cbJKYNMc6zwRzI95MFgTn/03ZjSbOFJHRomqD3hA5bDY9JbadbgDolZGN+b158g==
X-Received: by 2002:a05:620a:2891:b0:783:949f:cbe2 with SMTP id j17-20020a05620a289100b00783949fcbe2mr2255168qkp.150.1706286232500;
        Fri, 26 Jan 2024 08:23:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGF3dN9qtg6egUH2aS6+684NdDZ6pBK5ibcmlDm0vpeIuUBL56vEfKOv6yuKmL8pIJhCyBbg==
X-Received: by 2002:a05:620a:2891:b0:783:949f:cbe2 with SMTP id j17-20020a05620a289100b00783949fcbe2mr2255155qkp.150.1706286232267;
        Fri, 26 Jan 2024 08:23:52 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id v25-20020a05620a091900b00783cd28876bsm693520qkv.101.2024.01.26.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 08:23:51 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, David Matlack
 <dmatlack@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH 2/4] KVM: Put mm immediately after async #PF worker
 completes remote gup()
In-Reply-To: <20240110011533.503302-3-seanjc@google.com>
References: <20240110011533.503302-1-seanjc@google.com>
 <20240110011533.503302-3-seanjc@google.com>
Date: Fri, 26 Jan 2024 17:23:48 +0100
Message-ID: <87plxo83mz.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Put the async #PF worker's reference to the VM's address space as soon as
> the worker is done with the mm.  This will allow deferring getting a
> reference to the worker itself without having to track whether or not
> getting a reference succeeded.
>
> Note, if the vCPU is still alive, there is no danger of the worker getting
> stuck with tearing down the host page tables, as userspace also holds a
> reference (obviously), i.e. there is no risk of delaying the page-present
> notification due to triggering the slow path in mmput().
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/async_pf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> index 876927a558ad..d5dc50318aa6 100644
> --- a/virt/kvm/async_pf.c
> +++ b/virt/kvm/async_pf.c
> @@ -64,6 +64,7 @@ static void async_pf_execute(struct work_struct *work)
>  	get_user_pages_remote(mm, addr, 1, FOLL_WRITE, NULL, &locked);
>  	if (locked)
>  		mmap_read_unlock(mm);
> +	mmput(mm);
>  
>  	if (IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC))
>  		kvm_arch_async_page_present(vcpu, apf);
> @@ -85,8 +86,6 @@ static void async_pf_execute(struct work_struct *work)
>  	trace_kvm_async_pf_completed(addr, cr2_or_gpa);
>  
>  	__kvm_vcpu_wake_up(vcpu);
> -
> -	mmput(mm);
>  }
>  
>  static void kvm_flush_and_free_async_pf_work(struct kvm_async_pf *work)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


