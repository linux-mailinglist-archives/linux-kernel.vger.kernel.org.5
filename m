Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C37CA9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjJPNgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjJPNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:35:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A245136;
        Mon, 16 Oct 2023 06:35:44 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56E4766071EF;
        Mon, 16 Oct 2023 14:35:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697463342;
        bh=TznfC4TF12W8ScIql5iv7WR3cxstbuq3pTRFxtuJ+jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrxoHnYktcz29ytK0yQxtJuylDb1WXgY2mbz2qhy/TUqunmGrD6m4jl9VgBPYnX4t
         ZYa9He71mfD2osZUfoN1o1dVHRGA+1g2us4NoWitlWsYB5O5k30oHPE5qhfJQpEz/1
         Ig79kvBC1oXtddtrkoPMwqleom/HGGyM85O3eTgdmy/LtDl+vVRKZdbGtykktKOvC8
         Gt0ZreKiCzJ5E02DVDOFavAM9KircMhEcOGP5MQDbp09bAysFP/C2KCxlmTB0lSU7W
         VaztqmNIS8pD3nBHoMowTmHEo1op3bal1x5/TLK9y8oGq1dl22YnLiBfAWBv6raNDo
         P7BxVe1l5OzEw==
Date:   Mon, 16 Oct 2023 15:35:39 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v13 5/8] media: chips-media: wave5: Add the v4l2 layer
Message-ID: <20231016133539.m3i5crlsknoidim3@basti-XPS-13-9310>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
 <20230929-wave5_v13_media_master-v13-5-5ac60ccbf2ce@collabora.com>
 <c5e826a2-5bc6-4c49-9a6d-655d26a3b97f@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <c5e826a2-5bc6-4c49-9a6d-655d26a3b97f@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hans,

On 16.10.2023 13:57, Hans Verkuil wrote:
>Hi Sebastian,
>
>On 12/10/2023 13:01, Sebastian Fricke wrote:
>> Add the decoder and encoder implementing the v4l2
>> API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
>>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
>> ---
>>  drivers/media/platform/chips-media/Kconfig         |    1 +
>>  drivers/media/platform/chips-media/Makefile        |    1 +
>>  drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
>>  drivers/media/platform/chips-media/wave5/Makefile  |   10 +
>>  .../platform/chips-media/wave5/wave5-helper.c      |  213 +++
>>  .../platform/chips-media/wave5/wave5-helper.h      |   31 +
>>  .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1953 ++++++++++++++++++++
>>  .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1794 ++++++++++++++++++
>>  .../media/platform/chips-media/wave5/wave5-vpu.c   |  291 +++
>>  .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
>>  .../platform/chips-media/wave5/wave5-vpuapi.h      |    2 -
>>  11 files changed, 4389 insertions(+), 2 deletions(-)
>>
>
><snip>
>
>> +static int wave5_vpu_dec_create_bufs(struct file *file, void *priv,
>> +				     struct v4l2_create_buffers *create)
>> +{
>> +	struct vpu_instance *inst = wave5_to_vpu_inst(priv);
>> +	struct v4l2_format *f = &create->format;
>> +
>> +	/* Firmware does not support CREATE_BUFS for CAPTURE queues. */
>> +	if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>> +		dev_dbg(inst->dev->dev,
>> +			"%s: VIDIOC_CREATE_BUFS not supported on CAPTURE queues.\n",
>> +			__func__);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return v4l2_m2m_ioctl_create_bufs(file, priv, create);
>> +}
>
>Regarding the EOPNOTSUPP discussion: I discussed this some more with
>Nicolas on irc, and we wonder if it isn't better to just drop create_bufs
>support for the wave5 decoder altogether. Is there any point in supporting
>it for OUTPUT but not CAPTURE?
>
><snip>
>
>> +static const struct v4l2_ioctl_ops wave5_vpu_dec_ioctl_ops = {
>> +	.vidioc_querycap = wave5_vpu_dec_querycap,
>> +	.vidioc_enum_framesizes = wave5_vpu_dec_enum_framesizes,
>> +
>> +	.vidioc_enum_fmt_vid_cap	= wave5_vpu_dec_enum_fmt_cap,
>> +	.vidioc_s_fmt_vid_cap_mplane = wave5_vpu_dec_s_fmt_cap,
>> +	.vidioc_g_fmt_vid_cap_mplane = wave5_vpu_dec_g_fmt_cap,
>> +	.vidioc_try_fmt_vid_cap_mplane = wave5_vpu_dec_try_fmt_cap,
>> +
>> +	.vidioc_enum_fmt_vid_out	= wave5_vpu_dec_enum_fmt_out,
>> +	.vidioc_s_fmt_vid_out_mplane = wave5_vpu_dec_s_fmt_out,
>> +	.vidioc_g_fmt_vid_out_mplane = wave5_vpu_g_fmt_out,
>> +	.vidioc_try_fmt_vid_out_mplane = wave5_vpu_dec_try_fmt_out,
>> +
>> +	.vidioc_g_selection = wave5_vpu_dec_g_selection,
>> +	.vidioc_s_selection = wave5_vpu_dec_s_selection,
>> +
>> +	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
>> +	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
>> +	.vidioc_create_bufs = wave5_vpu_dec_create_bufs,
>
>So this would just be dropped.
>
>> +	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>> +	.vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
>> +	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>> +	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>> +	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
>> +	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
>> +
>> +	.vidioc_try_decoder_cmd = v4l2_m2m_ioctl_try_decoder_cmd,
>> +	.vidioc_decoder_cmd = wave5_vpu_dec_decoder_cmd,
>> +
>> +	.vidioc_subscribe_event = wave5_vpu_subscribe_event,
>> +	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
>> +};
>
>This also means there is no need to document the new EOPNOTSUPP error
>code in VIDIOC_CREATE_BUFS, or to modify v4l2-compliance.
>
>You *do* need to add a comment somewhere explaining why you don't
>support this ioctl. I think it would be best to do that right after
>'.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,'.

So, besides this issue would you judge the v4l2 layer of the driver to
be ready? Do you want a reviewed by tag for it or would you take it like
this as well?

>
>Regards,
>
>	Hans

Sincerly,
Sebastian
>_______________________________________________
>Kernel mailing list -- kernel@mailman.collabora.com
>To unsubscribe send an email to kernel-leave@mailman.collabora.com
