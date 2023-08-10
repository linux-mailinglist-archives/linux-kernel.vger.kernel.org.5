Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB07781C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjHJTpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHJTps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69F12B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691696702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y1eDr4DPmIUm/uxGGW2mKYAd0wEheDzbeEmS3Ghlc2E=;
        b=XBAy79kbDoDVAddDtuJPx9eY5mMX8+dwol+Ykz4V9eOD5ng7CmyHrYhp+RaALAXxcPe+qR
        NMLJUNGkWZ2rhaOdcH3iOjYBPHUqcN/brY+n9iss6bQK40TxJ568NAEwuS/bL3qXkpmPEp
        9rzW67pak6ctNW3+4aBPFunK4iQFwq0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-cC_hI3OlNkyNlWwyQqhl4Q-1; Thu, 10 Aug 2023 15:45:01 -0400
X-MC-Unique: cC_hI3OlNkyNlWwyQqhl4Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c01c680beso89472266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696700; x=1692301500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1eDr4DPmIUm/uxGGW2mKYAd0wEheDzbeEmS3Ghlc2E=;
        b=goVNitDgHYRqwN/Dv48uTh6VoaWb0kogJAbduSBrK2jhNAatCSdmRcky3o52q/QuUK
         KG9B7NzZhqeB64j6ObSo4bTsoJW0p9VcAWU5doKNvRgPPhNpFbdDmmDQvocmK73mLmT4
         vOf3FPG22Z3djhDJv3uOD6fLtgW3ItmFg+YrFCiachqPqmxhRhCeaBEtQNuZlTNhl8mm
         qCcAIddR2wTqhlTpBRsWOjxiBR1KXbiKVuuChzDvA1jeZjJBOkMWFpgQrH+v3xKmdT86
         z5J9biPbB0VDulOrjurrsfaifGTflYAOZKIoTB3257D/wjdc36PatyBxjRA5aONq9jES
         srHw==
X-Gm-Message-State: AOJu0YzBHfvCnaA5ThF9fS31cAobimg5zKRRI3JhZwmiNG3V/0e5QHC2
        Hgleh+ivqFP/7PoyO430z29et01S+KcPUPn4WO02sDvO2ZnVRQgX1c+dQZH8ykp7gm6+3aMMN1O
        fkg9MJCcN2CKaechAihNrt5VD
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id jx27-20020a170907761b00b0099beca247a8mr3005395ejc.38.1691696700479;
        Thu, 10 Aug 2023 12:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz/FTg2onKMWAYHjvEIScnz+vcyBXPbJMtlVoN+8/Fj4f8UXrZZW5UvjYwwj0QfZbxYTzE0w==
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id jx27-20020a170907761b00b0099beca247a8mr3005380ejc.38.1691696700149;
        Thu, 10 Aug 2023 12:45:00 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b0099d0a8ccb5fsm1325255ejb.152.2023.08.10.12.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:44:59 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:44:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_mmio: add suspend and resume calls for
 virtio_mmio devices
Message-ID: <20230810154334-mutt-send-email-mst@kernel.org>
References: <20230728070127.18452-1-quic_ajainp@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728070127.18452-1-quic_ajainp@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 12:31:27PM +0530, Anvesh Jain P wrote:
> Handle suspend and resume calls for virtio mmio devices from
> PM core. Expose these notifications to virtio drivers that can quiesce and
> resume vq operations. Update virtio pm ops to handle freeze& restore and
> suspend & resume callbacks separately.
> 
> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>

okey but what is the motivation? does this addition of 200 LOC
achieve something new? what is the issue fixed here?


> ---
>  drivers/virtio/virtio.c      | 112 +++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_mmio.c |  50 +++++++++++++++-
>  include/linux/virtio.h       |  12 ++++
>  3 files changed, 173 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 3893dc29eb26..c6f25a267600 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -551,6 +551,118 @@ int virtio_device_restore(struct virtio_device *dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(virtio_device_restore);
> +
> +int virtio_device_suspend(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	virtio_config_disable(dev);
> +
> +	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
> +
> +	if (drv && drv->suspend)
> +		return drv->suspend(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend);
> +
> +int virtio_device_resume(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	int ret;
> +
> +	if (drv && drv->resume) {
> +		ret = drv->resume(dev);
> +		if (ret)
> +			goto err;
> +
> +		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +			virtio_device_ready(dev);
> +
> +		virtio_config_enable(dev);
> +	}
> +
> +	return 0;
> +err:
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume);
> +
> +int virtio_device_suspend_late(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	virtio_config_disable(dev);
> +
> +	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
> +
> +	if (drv && drv->suspend_late)
> +		return drv->suspend_late(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend_late);
> +
> +int virtio_device_resume_early(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	int ret;
> +
> +	if (drv && drv->resume_early) {
> +		ret = drv->resume_early(dev);
> +		if (ret)
> +			goto err;
> +		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +			virtio_device_ready(dev);
> +
> +		virtio_config_enable(dev);
> +	}
> +
> +	return 0;
> +err:
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume_early);
> +
> +int virtio_device_suspend_noirq(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	virtio_config_disable(dev);
> +
> +	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
> +
> +	if (drv && drv->suspend_noirq)
> +		return drv->suspend_noirq(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend_noirq);
> +
> +int virtio_device_resume_noirq(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	int ret;
> +
> +	if (drv && drv->resume_noirq) {
> +		ret = drv->resume_noirq(dev);
> +		if (ret)
> +			goto err;
> +		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +			virtio_device_ready(dev);
> +
> +		virtio_config_enable(dev);
> +	}
> +
> +	return 0;
> +err:
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume_noirq);
>  #endif
>  
>  static int virtio_init(void)
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index a46a4a29e929..9385c7e65da9 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -596,9 +596,57 @@ static int virtio_mmio_restore(struct device *dev)
>  
>  	return virtio_device_restore(&vm_dev->vdev);
>  }
> +static int virtio_mmio_suspend(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_suspend(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_resume(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_resume(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_suspend_late(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_suspend_late(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_resume_early(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_resume_early(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_suspend_noirq(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_suspend_noirq(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_resume_noirq(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_resume_noirq(&vm_dev->vdev);
> +}
>  
>  static const struct dev_pm_ops virtio_mmio_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
> +       .freeze         = virtio_mmio_freeze,
> +       .restore        = virtio_mmio_restore,
> +       .suspend        = virtio_mmio_suspend,
> +       .resume         = virtio_mmio_resume,
> +       .suspend_late   = virtio_mmio_suspend_late,
> +       .resume_early   = virtio_mmio_resume_early,
> +       .suspend_noirq  = virtio_mmio_suspend_noirq,
> +       .resume_noirq   = virtio_mmio_resume_noirq,
>  };
>  #endif
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index de6041deee37..e88b321408e9 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -145,6 +145,12 @@ void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
>  int virtio_device_freeze(struct virtio_device *dev);
>  int virtio_device_restore(struct virtio_device *dev);
> +int virtio_device_suspend(struct virtio_device *dev);
> +int virtio_device_resume(struct virtio_device *dev);
> +int virtio_device_suspend_late(struct virtio_device *dev);
> +int virtio_device_resume_early(struct virtio_device *dev);
> +int virtio_device_suspend_noirq(struct virtio_device *dev);
> +int virtio_device_resume_noirq(struct virtio_device *dev);
>  #endif
>  void virtio_reset_device(struct virtio_device *dev);
>  
> @@ -187,6 +193,12 @@ struct virtio_driver {
>  #ifdef CONFIG_PM
>  	int (*freeze)(struct virtio_device *dev);
>  	int (*restore)(struct virtio_device *dev);
> +	int (*suspend)(struct virtio_device *dev);
> +	int (*resume)(struct virtio_device *dev);
> +	int (*suspend_late)(struct virtio_device *dev);
> +	int (*resume_early)(struct virtio_device *dev);
> +	int (*suspend_noirq)(struct virtio_device *dev);
> +	int (*resume_noirq)(struct virtio_device *dev);
>  #endif
>  };
>  
> 
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> -- 
> 2.17.1

