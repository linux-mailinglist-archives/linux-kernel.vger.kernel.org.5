Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080BE782A51
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjHUNTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjHUNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:19:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56268B1;
        Mon, 21 Aug 2023 06:18:58 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 37842B75;
        Mon, 21 Aug 2023 15:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692623860;
        bh=S5ypuXYh390YEeJE0UqVpKoqDBg1852Ptd6aui4fkS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+9LPp42pQavwnfm0WcCEFXzNe/d64SX0oqch7h3a6ttiK44EJ37wOcaMonoUgWWw
         0TZYgfeOAmOrtGQzQmb556G3pD7rHgFH4afSW3OX14HF9SVpmwATN8ZsIBYGGbmNdM
         PK7gGZNgySFe7O7WhcrhTsfzL2wA07Ka+b/gad8Y=
Date:   Mon, 21 Aug 2023 16:19:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     yuji2.ishikawa@toshiba.co.jp
Cc:     krzysztof.kozlowski@linaro.org, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, broonie@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Message-ID: <20230821131903.GI10135@pendragon.ideasonboard.com>
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
 <20230714015059.18775-3-yuji2.ishikawa@toshiba.co.jp>
 <0d0cec7f-030f-ebc1-11f0-06214197a351@linaro.org>
 <TYAPR01MB620105AC2EDF36751EE654C89203A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYAPR01MB620105AC2EDF36751EE654C89203A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(CC'ing Christoph, Marek and Robin)

On Tue, Jul 25, 2023 at 06:10:03AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> On Friday, July 14, 2023 5:00 PM, Krzysztof Kozlowski wrote:
> > On 14/07/2023 03:50, Yuji Ishikawa wrote:
> > > Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
> > > The interface device includes CSI2 Receiver, frame grabber, video DMAC
> > > and image signal processor.
> > >
> > > A driver instance provides three /dev/videoX device files; one for RGB
> > > image capture, another one for optional RGB capture with different
> > > parameters and the last one for RAW capture.
> > 
> > ...

[snip]

> > > +static int visconti_viif_probe(struct platform_device *pdev) {
> > > +	struct device *dev = &pdev->dev;
> > > +	struct viif_device *viif_dev;
> > > +	dma_addr_t tables_dma;
> > > +	int ret, i, num_sd;
> > > +
> > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	viif_dev = devm_kzalloc(dev, sizeof(*viif_dev), GFP_KERNEL);
> > > +	if (!viif_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	platform_set_drvdata(pdev, viif_dev);
> > > +	viif_dev->dev = dev;
> > > +
> > > +	spin_lock_init(&viif_dev->regbuf_lock);
> > > +	mutex_init(&viif_dev->pow_lock);
> > > +	mutex_init(&viif_dev->stream_lock);
> > > +
> > > +	viif_dev->capture_reg = devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(viif_dev->capture_reg))
> > > +		return PTR_ERR(viif_dev->capture_reg);
> > > +
> > > +	viif_dev->csi2host_reg = devm_platform_ioremap_resource(pdev, 1);
> > > +	if (IS_ERR(viif_dev->csi2host_reg))
> > > +		return PTR_ERR(viif_dev->csi2host_reg);
> > > +
> > > +	viif_dev->hwaif_reg = devm_platform_ioremap_resource(pdev, 2);
> > > +	if (IS_ERR(viif_dev->hwaif_reg))
> > > +		return PTR_ERR(viif_dev->hwaif_reg);
> > > +
> > > +	viif_dev->mpu_reg = devm_platform_ioremap_resource(pdev, 3);
> > > +	if (IS_ERR(viif_dev->mpu_reg))
> > > +		return PTR_ERR(viif_dev->mpu_reg);
> > > +
> > > +	viif_dev->run_flag_main = false;
> > > +
> > > +	for (i = 0; i < NUM_IRQS; i++) {
> > > +		ret = platform_get_irq(pdev, i);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "failed to acquire irq resource\n");
> > > +			return ret;
> > 
> > return dev_err_probe()
> 
> I'll use dev_err_probe().
> Same for other suggestions.
> 
> > > +		}
> > > +		viif_dev->irq[i] = ret;
> > > +		ret = devm_request_irq(dev, viif_dev->irq[i], visconti_viif_irq, 0, IRQ_ID_STR,
> > > +				       viif_dev);
> > > +		if (ret) {
> > > +			dev_err(dev, "irq request failed\n");
> > 
> > return dev_err_probe()
> 
> I'll use dev_err_probe().
> 
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	viif_dev->tables =
> > > +		dma_alloc_wc(dev, sizeof(struct viif_table_area), &tables_dma, GFP_KERNEL);
> > > +	if (!viif_dev->tables) {
> > > +		dev_err(dev, "dma_alloc_wc failed\n");
> > 
> > Are you sure DMA memory allocation errors shall be printed?
> 
> Printing this error is useless for users in general?
> If so, I'll drop this debug output.

Failures to allocate memory in the kernel generally result in warning
messages being printed by the allocation function, so there's no need to
do so manually in drivers. This being said, I check dma_alloc_wc()
(which is a wrapper around dma_alloc_attrs()), and unless I'm missing
something, it can return NULL without printing any error. I don't know
if this is an oversight in some code paths taken by dma_alloc_attrs() or
if it's on purpose. Maybe Christoph, Marek or Roben will known.

> > > +		return -ENOMEM;
> > > +	}
> > > +	viif_dev->tables_dma = (struct viif_table_area *)tables_dma;
> > > +
> > > +	/* power control */
> > 
> > Drop the comment, it is useless.
> 
> I'll drop the comment
> 
> > > +	pm_runtime_enable(dev);
> > > +
> > > +	/* build media_dev */
> > > +	viif_dev->media_dev.hw_revision = 0;
> > > +	strscpy(viif_dev->media_dev.model, VIIF_DRIVER_NAME, sizeof(viif_dev->media_dev.model));
> > > +	viif_dev->media_dev.dev = dev;
> > > +	/* TODO: platform:visconti-viif-0,1,2,3 for each VIIF driver instance */
> > > +	snprintf(viif_dev->media_dev.bus_info, sizeof(viif_dev->media_dev.bus_info), "%s-0",
> > > +		 VIIF_BUS_INFO_BASE);
> > > +	media_device_init(&viif_dev->media_dev);
> > > +
> > > +	/* build v4l2_dev */
> > > +	viif_dev->v4l2_dev.mdev = &viif_dev->media_dev;
> > > +	ret = v4l2_device_register(dev, &viif_dev->v4l2_dev);
> > > +	if (ret)
> > > +		goto error_dma_free;
> > > +
> > > +	ret = media_device_register(&viif_dev->media_dev);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to register media device: %d\n", ret);
> > > +		goto error_v4l2_unregister;
> > 
> > dev_err_probe
> 
> I'll use dev_err_probe().
> 
> > > +	}
> > > +
> > > +	ret = visconti_viif_csi2rx_register(viif_dev);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to register csi2rx sub node: %d\n", ret);
> > 
> > dev_err_probe
> 
> I'll use dev_err_probe().
> 
> > > +		goto error_media_unregister;
> > > +	}
> > > +
> > > +	ret = visconti_viif_isp_register(viif_dev);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to register isp sub node: %d\n", ret);
> > 
> > dev_err_probe
> 
> I'll use dev_err_probe().
> 
> > > +		goto error_media_unregister;
> > > +	}
> > > +	ret = visconti_viif_capture_register(viif_dev);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to register capture node: %d\n", ret);
> > 
> > dev_err_probe
> 
> I'll use dev_err_probe().
> 
> > > +		goto error_media_unregister;
> > > +	}
> > > +
> > > +	/* handle subdevices in device tree */
> > > +	num_sd = visconti_viif_parse_dt(viif_dev);
> > > +	if (ret < 0) {
> > > +		ret = num_sd;
> > 
> > ret = dev_err_probe
> 
> I'll use dev_err_probe().
> 
> > > +		goto error_media_unregister;
> > > +	}
> > > +
> > > +	viif_dev->notifier.v4l2_dev = &viif_dev->v4l2_dev;
> > > +	v4l2_async_nf_init(&viif_dev->notifier);
> > > +	for (i = 0; i < num_sd; i++)
> > > +		__v4l2_async_nf_add_subdev(&viif_dev->notifier, viif_dev->asds[i]);
> > > +	viif_dev->notifier.ops = &viif_notify_ops;
> > > +	ret = v4l2_async_nf_register(&viif_dev->v4l2_dev, &viif_dev->notifier);
> > > +	if (ret)
> > > +		goto error_media_unregister;
> > > +
> > > +	viif_dev->wq = create_workqueue("visconti-viif");
> > > +	if (!viif_dev->wq)
> > > +		return -ENOMEM;
> > 
> > No error cleanup?
> 
> There should be. I'll add cleanup operations.
> 
> > > +	INIT_WORK(&viif_dev->work, visconti_viif_wthread_l1info);
> > > +
> > > +	return 0;
> > > +
> > > +error_media_unregister:
> > > +	media_device_unregister(&viif_dev->media_dev);
> > > +error_v4l2_unregister:
> > > +	v4l2_device_unregister(&viif_dev->v4l2_dev);
> > > +error_dma_free:
> > > +	pm_runtime_disable(dev);
> > > +	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->tables,
> > > +		    (dma_addr_t)viif_dev->tables_dma);
> > > +	return ret;
> > > +}

[snip]

-- 
Regards,

Laurent Pinchart
