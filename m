Return-Path: <linux-kernel+bounces-167876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E128BB09C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A08D2818B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C74D9FD;
	Fri,  3 May 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6StspMX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E515531C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752707; cv=none; b=lIh4KKxTRNrxEVGZysHbSbZ0pz9ux9qxU7p4+l30SJKbxgCW37UiGZBmiHZn1kb0+54VBXpkihEU9ydUkxU+Lz4217z9m2peHMkPyG7NEJA7lWTDRWzLDiuxEL3tzsWEGEoPZkA4h5mClJIfSc8O+Mmn5/nULlE82AUUFkHIN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752707; c=relaxed/simple;
	bh=lBc8mIGqc0Pyzb4/0nOXv6g1qY48kquuboJ7JtBmRDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD1bKj8HuldYgZMFvNUDSOcjyylFQPTIpk7gozkK5jzcl589CcNrmJJ1Iavmas/+hsaKmA0wBiyi+LZJIZcxSQxTevpjl5+W1uFf5LS3SQKtr1Cs+pFZwOls9mtaGrO/H4PoY00WPQXvcyn6CoiWl3d07Y/t+ZDTSyPT5FbDNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6StspMX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714752704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZOiOpZyBKuObIgtTt9nNi/hSpkFKeeLY85af4HJ/a4=;
	b=M6StspMXWxDtjYNCJHLKmyH56gq+sTqScXZyZk0/hpMq3GXDDSZGihVSxKGRHlPtXXkjij
	aZaImnUGCg1U1CPtwo/VDbQqfNMdEwoGa97RxSqYpMCGsFI3odhpdLWxfwBklt0l+NC6/3
	SoKSa5wg37PrHmwzr99N6cr9Dr2z7QI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-VCsHwfooNLqb5FFfV94hvw-1; Fri, 03 May 2024 12:11:43 -0400
X-MC-Unique: VCsHwfooNLqb5FFfV94hvw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5aa338a43c8so9605124eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752703; x=1715357503;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZOiOpZyBKuObIgtTt9nNi/hSpkFKeeLY85af4HJ/a4=;
        b=ngihcqywp4aq5ucryZfYDbtVd2TlFA1VQ3ePMMzufKhmf/dVrRfvG//0l91GUzi8Ix
         Np79Ft44rlviCgSBxItC9gNSNBOqx8U3vHSRGnWZCWWuxAlNcUIKIZdwtotJy6Jdhb52
         CkyOwbKsveO9fv6Lverj4NCcOt7/uRB/qkMiRRbNncr3hb6srNd0rjpxhU3/SvSUU7Z5
         AqDkYXvcz6LFsBrvSpODmIhBNI1rICaJ/1edEMEm2l7IrN39zuAYP7iAIlXr5yUfYweC
         Nlg5941cOwct2ZWnCGlU0F3ef8dBLKU1XX/UenR5oNjCb9fZu7VAuQBPvRR3TSgcqCtK
         0umA==
X-Forwarded-Encrypted: i=1; AJvYcCU361ARhcitQLHEdgpQBsEWt/z1BcnOTdN1kxa9mHB+ICIaWP7SHnAJgPq2nNcpDIaa8HF4ZUeU/aWVmEhu8finw8a9Qj9VHFNWiJqw
X-Gm-Message-State: AOJu0YyhdTg/P7f+iJ8dXpUy5xD9Ph+jzGEAZDHBsrNrGYzqPQjD9rTQ
	ULnWpCB+/vzs0DBusY5bveLL4AuToQ7Y38w+KDP2wrvFozRIZG0vBEDAGKLnYEMbk8AJDVb973h
	fis3aOzrCnpBebyOcQmqPl2OzhbVIGWY5FTHGmgo1m6wUbcyJADAbdzblWQa23g==
X-Received: by 2002:a4a:d888:0:b0:5ac:bdbf:8a31 with SMTP id b8-20020a4ad888000000b005acbdbf8a31mr3298912oov.8.1714752702772;
        Fri, 03 May 2024 09:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENI13JqeWl+3nRXkEgDH9DAZfXX8Y7O0g+Kcb7NHM7u5AIluDQAEa1B47G9dtTONyGkn4Qkw==
X-Received: by 2002:a4a:d888:0:b0:5ac:bdbf:8a31 with SMTP id b8-20020a4ad888000000b005acbdbf8a31mr3298888oov.8.1714752702398;
        Fri, 03 May 2024 09:11:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id cg12-20020a056820098c00b005b1da7520c9sm358982oob.7.2024.05.03.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:11:42 -0700 (PDT)
Date: Fri, 3 May 2024 10:11:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v6 2/5] hisi_acc_vfio_pci: modify the register location
 of the XQC address
Message-ID: <20240503101138.7921401f.alex.williamson@redhat.com>
In-Reply-To: <20240425132322.12041-3-liulongfang@huawei.com>
References: <20240425132322.12041-1-liulongfang@huawei.com>
	<20240425132322.12041-3-liulongfang@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 21:23:19 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> According to the latest hardware register specification. The DMA
> addresses of EQE and AEQE are not at the front of their respective
> register groups, but start from the second.
> So, previously fetching the value starting from the first register
> would result in an incorrect address.
> 
> Therefore, the register location from which the address is obtained
> needs to be modified.

How does this affect migration?  Has it ever worked?  Does this make
the migration data incompatible?

Fixes: ???

> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 8 ++++----
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h | 3 +++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 45351be8e270..0c7e31076ff4 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -516,12 +516,12 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  		return -EINVAL;
>  
>  	/* Every reg is 32 bit, the dma address is 64 bit. */
> -	vf_data->eqe_dma = vf_data->qm_eqc_dw[1];
> +	vf_data->eqe_dma = vf_data->qm_eqc_dw[QM_XQC_ADDR_HIGH];
>  	vf_data->eqe_dma <<= QM_XQC_ADDR_OFFSET;
> -	vf_data->eqe_dma |= vf_data->qm_eqc_dw[0];
> -	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[1];
> +	vf_data->eqe_dma |= vf_data->qm_eqc_dw[QM_XQC_ADDR_LOW];
> +	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[QM_XQC_ADDR_HIGH];
>  	vf_data->aeqe_dma <<= QM_XQC_ADDR_OFFSET;
> -	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[0];
> +	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[QM_XQC_ADDR_LOW];
>  
>  	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
>  	ret = qm_get_sqc(vf_qm, &vf_data->sqc_dma);
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> index 5bab46602fad..f887ab98581c 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> @@ -38,6 +38,9 @@
>  #define QM_REG_ADDR_OFFSET	0x0004
>  
>  #define QM_XQC_ADDR_OFFSET	32U
> +#define QM_XQC_ADDR_LOW	0x1
> +#define QM_XQC_ADDR_HIGH	0x2
> +
>  #define QM_VF_AEQ_INT_MASK	0x0004
>  #define QM_VF_EQ_INT_MASK	0x000c
>  #define QM_IFC_INT_SOURCE_V	0x0020


