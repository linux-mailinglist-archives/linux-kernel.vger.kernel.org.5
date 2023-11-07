Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9807E49DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbjKGUde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjKGUdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:33:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8010CC;
        Tue,  7 Nov 2023 12:33:30 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B2F06607488;
        Tue,  7 Nov 2023 20:33:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699389208;
        bh=iQA0AIEzfr2uGyaMcXSLLi8yyODv99xxAGMjHVzMB0M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iR1QAwcmJW7tvSh4r6pIvfzIYgwclOB0GS/Vg8ph2Koxfz0VUdR1v9lZpTBSKCAE3
         J/H2lQp5oc/vltrOczjWmyWL9gdjRLtwGr9pw32y75oFGJ1192Eq7JNDYRqN8qrYnf
         ejhC3Q8IEn6motQLm7MQoAUAPqvndi/2fxF+aNIxM7WMcryPQkPjXQVlGBCtc3iMVR
         ckNXfEwNxJ3OfkNL51uLQ8bazYPLDmYAqxyfbCuh3dHilp4LW55fCwcoT6/3fDuUF7
         sryBH2GJxkIfTtQCosjOl7ZTnjx7ct8J/alU2NkIBnWN14Q9szPV5ZhtvhE4nNc8Yy
         s9tDFV6thRMcw==
Message-ID: <be1d3bfbdd076bf7c5c25bab826dc8bde3d067d7.camel@collabora.com>
Subject: Re: [PATCH] media: v4l2-dev: Check that g/s_selection are valid
 before selecting crop
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil@xs4all.nl>
Date:   Tue, 07 Nov 2023 15:33:17 -0500
In-Reply-To: <20231107200509.485071-1-paul.kocialkowski@bootlin.com>
References: <20231107200509.485071-1-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 07 novembre 2023 =C3=A0 21:05 +0100, Paul Kocialkowski a =C3=A9cri=
t=C2=A0:
> The cropcap and g/s_crop ioctls are automatically marked as valid wheneve=
r the
> g/s_selection ops are filled. The rationale is to auto-enable these legac=
y
> cropcap and g/s_crop ioctls that rely on g/s_selection.
>=20
> However it's possible that the ops are filled but explicitly disabled wit=
h
> calls to v4l2_disable_ioctl. In this situation the legacy ioctls should n=
ot
> be enabled.
>=20
> Add a check on the video device's valid ioctls field before auto-selectin=
g
> them to honor the driver's choice. Note that the meaning of the bitfield
> stored in the video device is the opposite of what the name suggests as
> v4l2_disable_ioctl will set the bits. Their meaning will be reversed at
> the end of the function.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/v4l2-core/v4l2-dev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core=
/v4l2-dev.c
> index f81279492682..d13954bd31fd 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -642,11 +642,13 @@ static void determine_valid_ioctls(struct video_dev=
ice *vdev)
>  		SET_VALID_IOCTL(ops, VIDIOC_TRY_DECODER_CMD, vidioc_try_decoder_cmd);
>  		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FRAMESIZES, vidioc_enum_framesizes);
>  		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FRAMEINTERVALS, vidioc_enum_frameinte=
rvals);
> -		if (ops->vidioc_g_selection) {
> +		if (ops->vidioc_g_selection &&
> +		    !test_bit(_IOC_NR(VIDIOC_G_SELECTION), vdev->valid_ioctls)) {
>  			__set_bit(_IOC_NR(VIDIOC_G_CROP), valid_ioctls);
>  			__set_bit(_IOC_NR(VIDIOC_CROPCAP), valid_ioctls);
>  		}
> -		if (ops->vidioc_s_selection)
> +		if (ops->vidioc_s_selection &&
> +		    !test_bit(_IOC_NR(VIDIOC_S_SELECTION), vdev->valid_ioctls))
>  			__set_bit(_IOC_NR(VIDIOC_S_CROP), valid_ioctls);
>  		SET_VALID_IOCTL(ops, VIDIOC_G_SELECTION, vidioc_g_selection);
>  		SET_VALID_IOCTL(ops, VIDIOC_S_SELECTION, vidioc_s_selection);

