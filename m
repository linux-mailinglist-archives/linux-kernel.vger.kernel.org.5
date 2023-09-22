Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9EB7AAAE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjIVHzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjIVHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:55:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73976CA;
        Fri, 22 Sep 2023 00:54:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CDBC433C7;
        Fri, 22 Sep 2023 07:54:53 +0000 (UTC)
Message-ID: <e6a0eda7-cd54-403f-9d7b-2445c89162fc@xs4all.nl>
Date:   Fri, 22 Sep 2023 09:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] Added Digiteq Automotive MGB4 driver
Content-Language: en-US, nl
To:     tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20230919165923.2509-1-tumic@gpxsee.org>
 <20230919165923.2509-2-tumic@gpxsee.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230919165923.2509-2-tumic@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

One more thing that I forgot to mention:

On 19/09/2023 18:59, tumic@gpxsee.org wrote:
> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
> 
> Digiteq Automotive MGB4 is a modular frame grabber PCIe card for automotive
> video interfaces. As for now, two modules - FPD-Link and GMSL - are
> available and supported by the driver. The card has two inputs and two
> outputs (FPD-Link only).
> 
> In addition to the video interfaces it also provides a trigger signal
> interface and a MTD interface for FPGA firmware upload.
> 
> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
> ---

<snip>

> +static ssize_t video_source_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct video_device *vdev = to_video_device(dev);
> +	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
> +	struct mgb4_dev *mgbdev = voutdev->mgbdev;
> +	struct mgb4_vin_dev *loopin_new = NULL, *loopin_old = NULL;
> +	unsigned long val;
> +	ssize_t ret;
> +	u32 config;
> +	int i;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +	if (val > 3)
> +		return -EINVAL;
> +
> +	if (test_and_set_bit(0, &mgbdev->io_reconfig))
> +		return -EBUSY;

You need some documentation here on how and why io_reconfig is used, with a reference
to the queue_setup functions, and there you need a reference back to this function.

It is something unusual, and unusual code needs documentation.

> +
> +	ret = -EBUSY;
> +	for (i = 0; i < MGB4_VIN_DEVICES; i++)
> +		if (mgbdev->vin[i] && is_busy(&mgbdev->vin[i]->vdev))
> +			goto end;
> +	for (i = 0; i < MGB4_VOUT_DEVICES; i++)
> +		if (mgbdev->vout[i] && is_busy(&mgbdev->vout[i]->vdev))
> +			goto end;
> +
> +	config = mgb4_read_reg(&mgbdev->video, voutdev->config->regs.config);
> +
> +	if (((config & 0xc) >> 2) < MGB4_VIN_DEVICES)
> +		loopin_old = mgbdev->vin[(config & 0xc) >> 2];
> +	if (val < MGB4_VIN_DEVICES)
> +		loopin_new = mgbdev->vin[val];
> +	if (loopin_old && loopin_cnt(loopin_old) == 1)
> +		mgb4_mask_reg(&mgbdev->video, loopin_old->config->regs.config,
> +			      0x2, 0x0);
> +	if (loopin_new)
> +		mgb4_mask_reg(&mgbdev->video, loopin_new->config->regs.config,
> +			      0x2, 0x2);
> +
> +	if (val == voutdev->config->id + MGB4_VIN_DEVICES)
> +		mgb4_write_reg(&mgbdev->video, voutdev->config->regs.config,
> +			       config & ~(1 << 1));
> +	else
> +		mgb4_write_reg(&mgbdev->video, voutdev->config->regs.config,
> +			       config | (1U << 1));
> +
> +	mgb4_mask_reg(&mgbdev->video, voutdev->config->regs.config, 0xc,
> +		      val << 2);
> +
> +	ret = count;
> +end:
> +	clear_bit(0, &mgbdev->io_reconfig);
> +
> +	return ret;
> +}

Regards,

	Hans

