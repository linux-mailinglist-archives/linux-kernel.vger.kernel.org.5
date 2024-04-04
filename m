Return-Path: <linux-kernel+bounces-132076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FDE898F62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8C21C27D73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227E1350CF;
	Thu,  4 Apr 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/wn9siB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593681BC46
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261260; cv=none; b=Jlq5qV3yHRqKQLC5BV91rqC9gclPC6I9nug+rBfmf9Z0Sij8kJg0lZhjUhhasuPigED48Q6MzyQ9DbmvnynSElMfGwP0YCdaogH9awAJOs8bjfEAfsmwJSy8rLbM7TpSwvjmy7bRi93MOdhHKY9agTORZTSgRMSUscNJq4CNwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261260; c=relaxed/simple;
	bh=H2PgplW4yHSIdo8CDgwMqqNoCYzCazA7fv20bb7mMQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2RnOv96MGNxj6IjY8rVPk7SY+Cfy9FxoFvARm7VFU1ZjXViIofvfjIXFXaRna916RO4hj9aGrz/JmvxoA39dYnxHwff7RWEDbNLoO9U2fF6++8XPnWuKv3xxaZgiluAtUBe7KDzvpnFTXdC/8NmhwFztwRLczHFym2K3NZ+R2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/wn9siB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712261257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7fjGhenDlbWaU5zor+1smq7yzHNYmLfEO1lExvtio8=;
	b=G/wn9siBSFRlnJHL+IX+2O6Dik8YG0X5ENjojorrPq7c/5IkmPKknP3rGcLEGOtXl/hANi
	FGqWURT3gSRNgmHdQSPiJXGV2oSMXUsuFhXTB5rhEzE6p+JBNoY0nPN11YCuWBVL5zT2gG
	mXPef8esAP0BIH1x3B/Okl0cK029oYA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-RlLOEYDHMEK8DTB3AdQQWg-1; Thu, 04 Apr 2024 16:07:35 -0400
X-MC-Unique: RlLOEYDHMEK8DTB3AdQQWg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a6a04d9so171445639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261255; x=1712866055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7fjGhenDlbWaU5zor+1smq7yzHNYmLfEO1lExvtio8=;
        b=PV+1hD2eKcC31Nd6tHu8zcR/QzJhTTpdvPTEZrrpP1UA1eMdBKZJKXq6FVzpsMPsKC
         8gfQn4J2DBLB/BA2N5bHADF9z6JeEBWB+3bBhaO1H0hqINXlf5Ir41fJuRlwH4mxeTan
         AoYHvAwP+LxtPqQCUbSStY+LfwkXfb7ank6AHDI8GVwEKTFUVvY8VYj1UAQvDLT+IRHz
         nxUU+IDc2yjzp0FYJAadjL1pR3o9p1tHf53pCx2QxIIhelrrQgIWuayQ5gIxM7e1SJCS
         NEBIRWXEgZQ7IeBMLTeN2IrDXcV1qBwc7vCIHjNLPP0VkNzU5CfkKfChvsQBkldHbqOh
         wY6w==
X-Forwarded-Encrypted: i=1; AJvYcCWGiXU2Ijsk2aph9D5Gprnj9ocdbzEn1A0qTyED4WNvB41/XH7OthyGulHJZjy9TFpEIBt1YzC+dv0fFvLhi+2czLqJbIzuE54kU41E
X-Gm-Message-State: AOJu0YzUvEVjKJ0iAH8I8Kll1aFxpvzZ7beLsQGtQ2G46T0nKRPCE4M2
	kaASBsgoeOzGXUZ/GB3hn8xEnZyFDbrfvVmbqEvg8gCLV2N0nx9wmwoqreOqEG/USTMRNiJpyqR
	GY9bQa5hdEALzDymZ+z5v2FnasiN8y9CFWi50U0Ymp8VdRvHLTbn7Y//1iVkjbA==
X-Received: by 2002:a6b:6110:0:b0:7d5:7ea9:42d1 with SMTP id v16-20020a6b6110000000b007d57ea942d1mr472643iob.14.1712261254462;
        Thu, 04 Apr 2024 13:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZk+PQap7GRIEBSjt4tIDcZndUptl0BWU5rVStDj4SPN+Wy1PHBKbdkvA0+Pg0j37b6i6YQw==
X-Received: by 2002:a6b:6110:0:b0:7d5:7ea9:42d1 with SMTP id v16-20020a6b6110000000b007d57ea942d1mr472571iob.14.1712261253357;
        Thu, 04 Apr 2024 13:07:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id k15-20020a056638140f00b0047ec126cda5sm78846jad.74.2024.04.04.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:07:32 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:07:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>, =?UTF-8?B?Q8Op?=
 =?UTF-8?B?ZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v4 2/4] hisi_acc_vfio_pci: Create subfunction for data
 reading
Message-ID: <20240404140731.2b75cb80.alex.williamson@redhat.com>
In-Reply-To: <20240402032432.41004-3-liulongfang@huawei.com>
References: <20240402032432.41004-1-liulongfang@huawei.com>
	<20240402032432.41004-3-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 11:24:30 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> During the live migration process. It needs to obtain various status
> data of drivers and devices. In order to facilitate calling it in the
> debugfs function. For all operations that read data from device registers,
> the driver creates a subfunction.
> Also fixed the location of address data.

C=C3=A9dric noted privately and I agree, 1) fixes should be provided in
separate patches with a Fixes: tag rather than subtly included in a
minor refactoring, and 2) what does this imply about the existing
functionality of migration?  This would seem to suggest existing
migration data is bogus if we're offset by a register reading the DMA
address.  The commit log for the Fixes patch should describe this.

>=20
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 56 +++++++++++--------
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  3 +
>  2 files changed, 37 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index 45351be8e270..bf358ba94b5d 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -486,6 +486,39 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_d=
evice *hisi_acc_vdev,
>  	return 0;
>  }
> =20
> +static int vf_qm_read_data(struct hisi_qm *vf_qm, struct acc_vf_data *vf=
_data)
> +{
> +	struct device *dev =3D &vf_qm->pdev->dev;
> +	int ret;
> +
> +	ret =3D qm_get_regs(vf_qm, vf_data);
> +	if (ret)
> +		return -EINVAL;
> +
> +	/* Every reg is 32 bit, the dma address is 64 bit. */
> +	vf_data->eqe_dma =3D vf_data->qm_eqc_dw[QM_XQC_ADDR_HIGH];
> +	vf_data->eqe_dma <<=3D QM_XQC_ADDR_OFFSET;
> +	vf_data->eqe_dma |=3D vf_data->qm_eqc_dw[QM_XQC_ADDR_LOW];
> +	vf_data->aeqe_dma =3D vf_data->qm_aeqc_dw[QM_XQC_ADDR_HIGH];
> +	vf_data->aeqe_dma <<=3D QM_XQC_ADDR_OFFSET;
> +	vf_data->aeqe_dma |=3D vf_data->qm_aeqc_dw[QM_XQC_ADDR_LOW];
> +
> +	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
> +	ret =3D qm_get_sqc(vf_qm, &vf_data->sqc_dma);
> +	if (ret) {
> +		dev_err(dev, "failed to read SQC addr!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D qm_get_cqc(vf_qm, &vf_data->cqc_dma);
> +	if (ret) {
> +		dev_err(dev, "failed to read CQC addr!\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vde=
v,
>  			    struct hisi_acc_vf_migration_file *migf)
>  {
> @@ -511,31 +544,10 @@ static int vf_qm_state_save(struct hisi_acc_vf_core=
_device *hisi_acc_vdev,
>  		return ret;
>  	}
> =20
> -	ret =3D qm_get_regs(vf_qm, vf_data);
> +	ret =3D vf_qm_read_data(vf_qm, vf_data);
>  	if (ret)
>  		return -EINVAL;
> =20
> -	/* Every reg is 32 bit, the dma address is 64 bit. */
> -	vf_data->eqe_dma =3D vf_data->qm_eqc_dw[1];
> -	vf_data->eqe_dma <<=3D QM_XQC_ADDR_OFFSET;
> -	vf_data->eqe_dma |=3D vf_data->qm_eqc_dw[0];
> -	vf_data->aeqe_dma =3D vf_data->qm_aeqc_dw[1];
> -	vf_data->aeqe_dma <<=3D QM_XQC_ADDR_OFFSET;
> -	vf_data->aeqe_dma |=3D vf_data->qm_aeqc_dw[0];
> -
> -	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
> -	ret =3D qm_get_sqc(vf_qm, &vf_data->sqc_dma);
> -	if (ret) {
> -		dev_err(dev, "failed to read SQC addr!\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D qm_get_cqc(vf_qm, &vf_data->cqc_dma);
> -	if (ret) {
> -		dev_err(dev, "failed to read CQC addr!\n");
> -		return -EINVAL;
> -	}
> -
>  	migf->total_length =3D sizeof(struct acc_vf_data);
>  	return 0;
>  }
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.h
> index 5bab46602fad..7a9dc87627cd 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> @@ -38,6 +38,9 @@
>  #define QM_REG_ADDR_OFFSET	0x0004
> =20
>  #define QM_XQC_ADDR_OFFSET	32U
> +#define QM_XQC_ADDR_LOW		0x1
> +#define QM_XQC_ADDR_HIGH	0x2
> +
>  #define QM_VF_AEQ_INT_MASK	0x0004
>  #define QM_VF_EQ_INT_MASK	0x000c
>  #define QM_IFC_INT_SOURCE_V	0x0020


