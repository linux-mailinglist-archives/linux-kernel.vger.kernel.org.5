Return-Path: <linux-kernel+bounces-167902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7DF8BB0D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED22B20B1D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E101553B2;
	Fri,  3 May 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRUzpHcy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12F155359
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753513; cv=none; b=revEaNCayXJyLeAJTR5pAv6Sd+giJ68QEoHtj6Ud4kVTuehAkl3OwbirHEOdllqReihAMVCkCPuCqjl4VNclvknSbmmdSch83qQTbkMbOZvtzhC/YvL3RndFIxeGdn7bipDOmtMfsnEdqD9G6FWzXB1GIr2h/rvG/343xR/RZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753513; c=relaxed/simple;
	bh=RoF676vuyFm27DHY4XwxyZaQwzrnj2uD1HQnRhgi47M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1tzNhliOKQpLdbicLlvFeVjPnU2ABSfaO586KQ3S796Xbcf6f+hYyKMTKd8fR+I3cUNA9DlTRSF1ES6AZv0njse7avgmkHVu4HT5Puab7Gq4G15S9vPD3e/K7dr5giobkxqHznWOfIj2ElsKplISNpjuUKHXDUyF4w+bH7QY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRUzpHcy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714753510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqE9UjZMAlqhqqJ6rt/S7AmYw8z0wQLatEs+TgaWqbw=;
	b=PRUzpHcyMJhFHSQ/rzV6+4VKZeYMtxEqnvDTUM2uPOWkFbEPAMJTfXD8vpbQFLHyQ/iUAg
	I7UEm3iMrKiNa9kt+CPjTng/SYzPmm7p8roQ70chEzC0DNrGX4ZSB07sa9sPiOctlsudu7
	qp3M98uECtcECjSYiloh4bESvDhnZqk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-WShWJCCjOFqhCipxyuByNQ-1; Fri, 03 May 2024 12:25:09 -0400
X-MC-Unique: WShWJCCjOFqhCipxyuByNQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c5ec76c08so27360055ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753508; x=1715358308;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqE9UjZMAlqhqqJ6rt/S7AmYw8z0wQLatEs+TgaWqbw=;
        b=n+Fs3aJc3n7mmbiKv6jqpJawJsZd4hO3dRiui5Vfc01YoMdx2D+/NT+OxTYfBaRki6
         C/3If2hqoJnDG3XHXGlqjeirGACp3UE95sQQvDJbgWbO644CgDQI7J0xEOfLWHrWTY39
         oc+I101ZGe++Btjj2znwgfcs8bd7ExhaX+OH6t68Ip9KRkj+kYw/GP1vf2UxVTJcF2st
         jbac6RAhr0BQYGrtRH+PrVh7AquzC6BHR15FRCdLA1mEHTkjnpo16MoAX0YhP9caT2xv
         vrd6QyooMUydGkdIv38zWnwo2KQ6peZmTCEmM2boa3UR0EgdJqQkedo0tEMl+64jFnhR
         Q76g==
X-Forwarded-Encrypted: i=1; AJvYcCWpSGhjGWMKYEPPijIQdOth9AaVSk+PDxkt8CfROqSQIKBqvLCWFibV/pm3bZ4Hi5x91n5nUl6PCPJAxQyXNYGEkzxbr+PiNpkm+02J
X-Gm-Message-State: AOJu0Yxfezc7XOpj2oLeEHK1dC3Sc2LLuT2PVsZwFxn75CzfSVbeXq5t
	PzG/fe9QOlpB9zKd9Xj0wGQC05emL8ofWmJM6wqujjlNOSJTXK7XAi9a9Vy8u0fdpZok/x1Z1TD
	iK/WP8CyUTyBxeK2IOj2rAyFtYofmLhYfxj4ZYD2Rg3QgUeXYkN50qpadkvsQEQ==
X-Received: by 2002:a05:6e02:b28:b0:36b:3b43:e3c3 with SMTP id e8-20020a056e020b2800b0036b3b43e3c3mr3818908ilu.14.1714753508375;
        Fri, 03 May 2024 09:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMHUNldeUszv7dyi3lt7U394Ez+ASLW0Y20RcLJK82P2cm6dyI2rq2WHK/yL+YRrrvT6vO2Q==
X-Received: by 2002:a05:6e02:b28:b0:36b:3b43:e3c3 with SMTP id e8-20020a056e020b2800b0036b3b43e3c3mr3818886ilu.14.1714753508028;
        Fri, 03 May 2024 09:25:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id dv14-20020a056638608e00b00487909f7416sm866115jab.5.2024.05.03.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:25:07 -0700 (PDT)
Date: Fri, 3 May 2024 10:25:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v6 3/5] hisi_acc_vfio_pci: create subfunction for data
 reading
Message-ID: <20240503102506.5b7a41ef.alex.williamson@redhat.com>
In-Reply-To: <20240425132322.12041-4-liulongfang@huawei.com>
References: <20240425132322.12041-1-liulongfang@huawei.com>
	<20240425132322.12041-4-liulongfang@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 21:23:20 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> During the live migration process.

This is not a complete sentence.

> It needs to obtain various status
> data of drivers and devices.

What's "It" describing here?

> In order to facilitate calling it in the
> debugfs function.

Also not a complete sentence.

> For all operations that read data from device registers,
> the driver creates a subfunction.

There's only one sub-function.

> Also fixed the location of address data.

I think this is addressed in the previous patch now?  Thanks,

Alex

> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 54 +++++++++++--------
>  1 file changed, 33 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 0c7e31076ff4..bf358ba94b5d 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -486,31 +486,11 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  	return 0;
>  }
>  
> -static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> -			    struct hisi_acc_vf_migration_file *migf)
> +static int vf_qm_read_data(struct hisi_qm *vf_qm, struct acc_vf_data *vf_data)
>  {
> -	struct acc_vf_data *vf_data = &migf->vf_data;
> -	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>  	struct device *dev = &vf_qm->pdev->dev;
>  	int ret;
>  
> -	if (unlikely(qm_wait_dev_not_ready(vf_qm))) {
> -		/* Update state and return with match data */
> -		vf_data->vf_qm_state = QM_NOT_READY;
> -		hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
> -		migf->total_length = QM_MATCH_SIZE;
> -		return 0;
> -	}
> -
> -	vf_data->vf_qm_state = QM_READY;
> -	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
> -
> -	ret = vf_qm_cache_wb(vf_qm);
> -	if (ret) {
> -		dev_err(dev, "failed to writeback QM Cache!\n");
> -		return ret;
> -	}
> -
>  	ret = qm_get_regs(vf_qm, vf_data);
>  	if (ret)
>  		return -EINVAL;
> @@ -536,6 +516,38 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> +			    struct hisi_acc_vf_migration_file *migf)
> +{
> +	struct acc_vf_data *vf_data = &migf->vf_data;
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	struct device *dev = &vf_qm->pdev->dev;
> +	int ret;
> +
> +	if (unlikely(qm_wait_dev_not_ready(vf_qm))) {
> +		/* Update state and return with match data */
> +		vf_data->vf_qm_state = QM_NOT_READY;
> +		hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
> +		migf->total_length = QM_MATCH_SIZE;
> +		return 0;
> +	}
> +
> +	vf_data->vf_qm_state = QM_READY;
> +	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
> +
> +	ret = vf_qm_cache_wb(vf_qm);
> +	if (ret) {
> +		dev_err(dev, "failed to writeback QM Cache!\n");
> +		return ret;
> +	}
> +
> +	ret = vf_qm_read_data(vf_qm, vf_data);
> +	if (ret)
> +		return -EINVAL;
> +
>  	migf->total_length = sizeof(struct acc_vf_data);
>  	return 0;
>  }


