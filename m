Return-Path: <linux-kernel+bounces-138364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C894F89F023
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AEA1F2318F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF015956B;
	Wed, 10 Apr 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S45IxfyM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0E156F2F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746097; cv=none; b=GDZnFB5Qaq9mCcVOlRC4RWZn9tIcNOdArwluYuqQKVNXOAKznEzaVO+9WAOgzeF5pX9Oo73BPQQxq6+N2azKpgKbYlkU8Fy8vYy1GTjC71M33kcckBDRJ6SDeGLUW2H09yD3xP5Bi5Vp612OMM3KuegCXUVpVRTrFJL5uj6ULAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746097; c=relaxed/simple;
	bh=3Yb1ghpPTQ86XpldcVJrb9JNr752HZfwLU+Be/0ePOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW6YCTsotPO8M7v0+UzGZFRUFpbHnyIfA2v8ogpjil9Q3IxIv6ABfdMw1RRISDFKMOH2T/DhcApheWtwdx0dFFYZMgDKtjtHhhhrTRXgdfJ0KAdBPXRLHPk6H83W2l8R6e76AwE0F7iHr/xFhbJzW83+a7RajKn84DWO40V+vpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S45IxfyM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712746094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3VI9T4uivNjRj5++S1JJ33tXKS8Bk1Y/4/7XhHNepY=;
	b=S45IxfyMoSSGGbpt8tZiTqcbVroDfHpK1BwoxgfgWOl4i0dRwI0Zj2UWxXagUJvI8zHabJ
	2uEngW/356SWMuMY9LYxzktJNY+xHLIQo8m5SCx7rkhPtxQWrxw9dE6bIlZCOP+rBR5xYE
	kZ48+G4xKxg+lZP1tStcN3ZIETwFgj0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Widrt95JOr-kSiYUC8RQUw-1; Wed, 10 Apr 2024 06:48:12 -0400
X-MC-Unique: Widrt95JOr-kSiYUC8RQUw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a45acc7f191so425683866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746091; x=1713350891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3VI9T4uivNjRj5++S1JJ33tXKS8Bk1Y/4/7XhHNepY=;
        b=RbkTs1NCkWX4Q+b8oAPp3qB2iHZPjU5o/SfYRsnGcyze2UxErjevXM5covvbHwQbns
         zqXQKu9BU6Gudz5ugJBAP0O3LDiJ5bH2hn6MSpDVOMxPoZTUHmdf4Ap486+sAPH78wz1
         ubr51Y0EJcy9Ux6utt5BjzJXJpRxgIlG5T/9Ub91G+WKlWQ2ZyFrUCq2NNXiPb5uSabL
         0WZz50tY8+u1KiNIliiRsINqRnpBESrhxunmojrhL9pnmxXJUSr+Opk31ofuBYemP+OC
         mmhYYBoKYJHzNczbO3jjKqc3kjZmbIKoTeY+vrdEcSJsjMOl8tkR/GZFTiFqsffDHNiY
         3DPw==
X-Forwarded-Encrypted: i=1; AJvYcCVqCXvrC9R3kIKuzzpa408PmQYs+4gakAm42+LWsJzjbYTMsQ3glV+B5EHjLL9r7JpI+rjRP+4YNXNiBbWT4gdjWeH681wU0ncnl8mv
X-Gm-Message-State: AOJu0Yz8cJ7WdPNjz/d+YhN9fKglnfxwW4+B9QNMh91IDNQlECvKT+gj
	bgS6enwJQv0h5l9TFulBY8hXHPGdYH60BCZZrR+JRp/acGZRZNVdjH7N+95CNvJyJjiotySHUEE
	SSyeF6jmLEsw4+xi1dXeDor1nGr6/Ji6dmRP2gt2yWerZHhEv9Oz4oGP0evXjtQ==
X-Received: by 2002:a50:8a84:0:b0:56d:c722:93a3 with SMTP id j4-20020a508a84000000b0056dc72293a3mr1740112edj.21.1712746091324;
        Wed, 10 Apr 2024 03:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0AVH2rE/fy4MIBSvrtzt9zQf1zOiezMHKpxPj3u+E8iYjX4bJ6t8tKVOrC8dvkLrwFtFHXg==
X-Received: by 2002:a50:8a84:0:b0:56d:c722:93a3 with SMTP id j4-20020a508a84000000b0056dc72293a3mr1740099edj.21.1712746090984;
        Wed, 10 Apr 2024 03:48:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fe10-20020a056402390a00b0056e4556834csm4964425edb.66.2024.04.10.03.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 03:48:10 -0700 (PDT)
Message-ID: <38dd4c60-e951-4951-bbad-90116af4603e@redhat.com>
Date: Wed, 10 Apr 2024 12:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] media: atomisp: Get rid of PCI device ID hack
 check
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240402204447.294280-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240402204447.294280-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 4/2/24 10:44 PM, Andy Shevchenko wrote:
> Always check exact PCI ID match and drop hack checks.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans



> ---
>  .../media/atomisp/pci/atomisp_internal.h      |  3 +-
>  .../staging/media/atomisp/pci/atomisp_v4l2.c  | 40 +++++++++----------
>  2 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_internal.h b/drivers/staging/media/atomisp/pci/atomisp_internal.h
> index bba9bc64d447..e6a090d9f310 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_internal.h
> +++ b/drivers/staging/media/atomisp/pci/atomisp_internal.h
> @@ -49,14 +49,13 @@
>  	(((isp)->media_dev.hw_revision & ATOMISP_HW_REVISION_MASK) == \
>  	 ((rev) << ATOMISP_HW_REVISION_SHIFT))
>  
> -#define ATOMISP_PCI_DEVICE_SOC_MASK	0xfff8
> +#define ATOMISP_PCI_DEVICE_SOC_BYT	0x0f38
>  /* MRFLD with 0x1178: ISP freq can burst to 457MHz */
>  #define ATOMISP_PCI_DEVICE_SOC_MRFLD	0x1178
>  /* MRFLD with 0x1179: max ISP freq limited to 400MHz */
>  #define ATOMISP_PCI_DEVICE_SOC_MRFLD_1179	0x1179
>  /* MRFLD with 0x117a: max ISP freq is 400MHz and max freq at Vmin is 200MHz */
>  #define ATOMISP_PCI_DEVICE_SOC_MRFLD_117A	0x117a
> -#define ATOMISP_PCI_DEVICE_SOC_BYT	0x0f38
>  #define ATOMISP_PCI_DEVICE_SOC_ANN	0x1478
>  #define ATOMISP_PCI_DEVICE_SOC_CHT	0x22b8
>  
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> index f736e54c7df3..4f414b812408 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> @@ -1238,7 +1238,8 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  	const struct atomisp_platform_data *pdata;
>  	struct atomisp_device *isp;
>  	unsigned int start;
> -	int err, val;
> +	u32 val;
> +	int err;
>  
>  	/* Pointer to struct device. */
>  	atomisp_dev = &pdev->dev;
> @@ -1266,8 +1267,10 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  
>  	pci_set_drvdata(pdev, isp);
>  
> -	switch (id->device & ATOMISP_PCI_DEVICE_SOC_MASK) {
> +	switch (id->device) {
>  	case ATOMISP_PCI_DEVICE_SOC_MRFLD:
> +	case ATOMISP_PCI_DEVICE_SOC_MRFLD_1179:
> +	case ATOMISP_PCI_DEVICE_SOC_MRFLD_117A:
>  		isp->media_dev.hw_revision =
>  		    (ATOMISP_HW_REVISION_ISP2400
>  		     << ATOMISP_HW_REVISION_SHIFT) |
> @@ -1420,28 +1423,25 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  	 */
>  	atomisp_css2_hw_store_32(MRFLD_CSI_RECEIVER_SELECTION_REG, 1);
>  
> -	if ((id->device & ATOMISP_PCI_DEVICE_SOC_MASK) ==
> -	    ATOMISP_PCI_DEVICE_SOC_MRFLD) {
> -		u32 csi_afe_trim;
> -
> +	switch (id->device) {
> +	case ATOMISP_PCI_DEVICE_SOC_MRFLD:
> +	case ATOMISP_PCI_DEVICE_SOC_MRFLD_1179:
> +	case ATOMISP_PCI_DEVICE_SOC_MRFLD_117A:
>  		/*
>  		 * Workaround for imbalance data eye issue which is observed
>  		 * on TNG B0.
>  		 */
> -		pci_read_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, &csi_afe_trim);
> -		csi_afe_trim &= ~((MRFLD_PCI_CSI_HSRXCLKTRIM_MASK <<
> -				   MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
> -				  (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK <<
> -				   MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
> -				  (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK <<
> -				   MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT));
> -		csi_afe_trim |= (MRFLD_PCI_CSI1_HSRXCLKTRIM <<
> -				 MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
> -				(MRFLD_PCI_CSI2_HSRXCLKTRIM <<
> -				 MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
> -				(MRFLD_PCI_CSI3_HSRXCLKTRIM <<
> -				 MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT);
> -		pci_write_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, csi_afe_trim);
> +		pci_read_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, &val);
> +		val &= ~((MRFLD_PCI_CSI_HSRXCLKTRIM_MASK << MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
> +			 (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK << MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
> +			 (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK << MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT));
> +		val |= (MRFLD_PCI_CSI1_HSRXCLKTRIM << MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
> +		       (MRFLD_PCI_CSI2_HSRXCLKTRIM << MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
> +		       (MRFLD_PCI_CSI3_HSRXCLKTRIM << MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT);
> +		pci_write_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, val);
> +		break;
> +	default:
> +		break;
>  	}
>  
>  	err = atomisp_initialize_modules(isp);


