Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8180D209
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbjLKQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344874AbjLKQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683C595
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702312673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dVilu1XfoAUvH6IB8U//hkpAqxI7bnvmhbzG6eO/9yo=;
        b=BCKtJ3Ke05SFmvYqBhdGC4j5qE2nNOOqYiPQ/RzLHSkUX7/1V/0lGz/afHnSJ+14ZbFiR8
        4bvaaNnCFRvWvtdRx0DBR3CpuFfNzBFlh9EPtdDHvgFc+atKoAN4orviBg4J/f2R6e9tSe
        kzYUzFA1iAG2ub9cY+x9IgrWt9P0rgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-TemOrbLGMyOkFoZAi4d8gA-1; Mon, 11 Dec 2023 11:37:52 -0500
X-MC-Unique: TemOrbLGMyOkFoZAi4d8gA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c3307ccf4so25061405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312670; x=1702917470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVilu1XfoAUvH6IB8U//hkpAqxI7bnvmhbzG6eO/9yo=;
        b=qcqTbZO1p5CzLM8MZMJo36YhoMwtoPgTBNzdRUR+i9LLKuQEFEIbs3auvAerSYX59P
         EzrstQVIvHdiN2v4ByKf0BkPpWmLCjJ7HLMgHsC4b9b/XJ0KoqV6YTr8P0iWPyLMyiMC
         ne1UQoGw0ZncG6rNQs4XSTSJUa/Qxc7Iae2CfDKWwn0pSMfo3aGWzJKxV9yWcs9w/LpM
         77ex04Zl8+IbIyaJZseI0WdI73V1iI+Rd/zN0NPh/hGw8jXmyuUYXVrZzVXulMmgDcmJ
         wzRxE793QS38TMOZuSVeke7fXt9mG3dValSsBDnpuNiT2fro4T0ViTskwjKHj7WXUAwc
         7BAg==
X-Gm-Message-State: AOJu0YyvQiXYaikI8w3s6OseEMg6UPQx2zlzh9rjm8I3SpU4QcJsqULt
        mVN3Xk0B4IejnI9CKFztsb0FglNw8fi4yy7bEG5CV5tejt4VJVyJL/MzEkLOG8GPkTXiIO+3poZ
        fl0U2DmTOEJj9Zzyi4g4ffaMOTvQFJNaB
X-Received: by 2002:a05:600c:2319:b0:40c:347b:b5c1 with SMTP id 25-20020a05600c231900b0040c347bb5c1mr2177781wmo.157.1702312670427;
        Mon, 11 Dec 2023 08:37:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQq+HFXFZ1Mz3I9TqHai3Z8E01pvu1tPCn8KfPwQXzyUPoWuse2huLkuajrCr5e1OJvklZcw==
X-Received: by 2002:a05:600c:2319:b0:40c:347b:b5c1 with SMTP id 25-20020a05600c231900b0040c347bb5c1mr2177772wmo.157.1702312670083;
        Mon, 11 Dec 2023 08:37:50 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm5746268wmb.46.2023.12.11.08.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:37:49 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:37:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
Message-ID: <20231211113710-mutt-send-email-mst@kernel.org>
References: <20231208070754.3132339-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208070754.3132339-1-stevensd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 04:07:54PM +0900, David Stevens wrote:
> If a virtio_pci_device supports native PCI power management and has the
> No_Soft_Reset bit set, then skip resetting and reinitializing the device
> when suspending and restoring the device. This allows system-wide low
> power states like s2idle to be used in systems with stateful virtio
> devices that can't simply be re-initialized (e.g. virtio-fs).
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>

tagged, thanks!
I'm still debating with myself whether we can classify this
as a bugfix ... better not risk it I guess.

> ---
> v1 -> v2:
>  - Check the No_Soft_Reset bit
> 
>  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..3a95ecaf12dc 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
>  	return virtio_device_restore(&vp_dev->vdev);
>  }
>  
> +static bool vp_supports_pm_no_reset(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u16 pmcsr;
> +
> +	if (!pci_dev->pm_cap)
> +		return false;
> +
> +	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +		dev_err(dev, "Unable to query pmcsr");
> +		return false;
> +	}
> +
> +	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> +}
> +
> +static int virtio_pci_suspend(struct device *dev)
> +{
> +	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> +}
> +
> +static int virtio_pci_resume(struct device *dev)
> +{
> +	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> +}
> +
>  static const struct dev_pm_ops virtio_pci_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> +	.suspend = virtio_pci_suspend,
> +	.resume = virtio_pci_resume,
> +	.freeze = virtio_pci_freeze,
> +	.thaw = virtio_pci_restore,
> +	.poweroff = virtio_pci_freeze,
> +	.restore = virtio_pci_restore,
>  };
>  #endif
>  
> -- 
> 2.43.0.472.g3155946c3a-goog

