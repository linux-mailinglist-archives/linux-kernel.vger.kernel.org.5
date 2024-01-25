Return-Path: <linux-kernel+bounces-38875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930D83C7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ECF2952B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23C129A65;
	Thu, 25 Jan 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1doCUrm"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4807129A63
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199266; cv=none; b=l/47rPX8o1LquHVU1M/wlZrhCGAV+iwfFQ1vFe9kKc9uGn4wQtUHAW6nVcahKqKMdhvk807eC6EQnefrdhoL9XXvc92iW8UFEr1NH1BIfGoaZSUsu3eZ3co/Bss34Ck8XsW/Qooc+0mVnMp4FKRzeHYPiIzcSV4OFEkF2duEeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199266; c=relaxed/simple;
	bh=D7HjdH5n2jQqoPTWaPly/Vf+jsmHYxO4Mpe85iv0rXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhdpuCHhr/6dp8Qv/AKPmPR4P7/qLuAZZFEx38b+AGsEg8z1zsfL39n4p4jwLSBmBXkpsOL7Lver5QNTJaJ9g6bCCHB/gUVPwm3ZcXsrqRw2vmYIAyW7ZnxL4K4p5gKlVB7r5RZvVCZ9EbSLAGfLAd5819u0qKc10OY9tBl41RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1doCUrm; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2144c37f3d3so1810718fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706199260; x=1706804060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lX5JA/vOezXM4ynRPh1Zrd3wkIQrBVz24OxUuw3lB3w=;
        b=T1doCUrmBqhHiqqpBPaGJk20GuvbBpHKq5BIHU8ZVSAWIeLPVOdiHjFg0MbjXXyrN2
         ooG0QcwLg2JwnaPZq9BH57BVkcIy04clIlQ9J6jA+hPgtPTLRsm89V2skmhPXVbiLGRM
         rDtrOLHBCstgcT/zHm3KTtpMPZDGDpPCXB55HCZHlv/Thc76lmHA29tRYF0vcQUz0AbA
         7y9slF2QQZ3+HC5ifdXSgK445RGYM7xa5v3j0C23XqpbZmxHmcWqnt1QqObIOfjRNBCZ
         4aZyq0e2NpGwHwiX3slZXbvKhMtWUvCtDyVUxJ0gAkprBblDSoJ2C8NRqDbE+fn4ojPn
         cXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199260; x=1706804060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX5JA/vOezXM4ynRPh1Zrd3wkIQrBVz24OxUuw3lB3w=;
        b=uKdP9PxMVv4x51cPGiUgwflM0wU/6lw39rAOobAhuZPZvPw/iw44F2PDqjg28YUq7e
         d/p/P7Wqw+y58jolVAdYdjLUdI2zsJnt7YMXf3Sx1OqM7mjuBnoNjNpx6OgfXcxorgLC
         70gvV11byIoi3CJjsdnA127LlDY/LageeJpID7RFnoEuhFC1O6HlWMPw2MEJziswQE9T
         0LMwQF9Ti9MhUVjNW/obGWZMXRw44lovviFB7muuFQNfa15qpgp30iI/0Tc+Um4NJcHX
         dPxICDdzZYDzpUBKj90s68gKXWoZt1KHyK2Vfm4JIZWmHlS80SgHZyVlFzvPaE3TjrlI
         0cgA==
X-Gm-Message-State: AOJu0Yx6bMfgFFQmWQvkoYmRppzjK3Lr7dVyNHmReJBSPInJHe+XvSnc
	aQnoc3aazDtxTyKggAxzOlJKfUHsrG/8s46CVA2zw+46DBX272zx9u9oJCVJu98w2Ae77GuKOhf
	5Ltz9T4EJi3n8xX7ecBZUFsCUCXI=
X-Google-Smtp-Source: AGHT+IEl32TC7vknoL2jvitmiRvpPr0wus0XTiiHWjRRQDN7tJbMr8YPKAqJdJYS6tWF7jo1WmISFQ72yM3YQTVpvrw=
X-Received: by 2002:a05:6870:64ac:b0:214:c900:6993 with SMTP id
 cz44-20020a05687064ac00b00214c9006993mr895138oab.6.1706199259618; Thu, 25 Jan
 2024 08:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-etnaviv-npu-v2-0-ba23c9a32be1@pengutronix.de> <20240125-etnaviv-npu-v2-1-ba23c9a32be1@pengutronix.de>
In-Reply-To: <20240125-etnaviv-npu-v2-1-ba23c9a32be1@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 25 Jan 2024 17:14:08 +0100
Message-ID: <CAH9NwWdXVCfzUy88n49g0ZqaC9KVLuw7Des9JpT5t1sif7qy5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/etnaviv: Update hardware headers from rnndb
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Update the state HI header from the rnndb commit
> 8d7ee714cfe2 ("Merge pull request #24 from pH5/unknown-3950").
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

You missed my R-b from the v1 series for this patch - please include
it the next time!

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/cmdstream.xml.h |  52 ++++++++++++++--
>  drivers/gpu/drm/etnaviv/common.xml.h    |  12 ++--
>  drivers/gpu/drm/etnaviv/state.xml.h     | 101 +++++++++++++++++++++++++++-----
>  drivers/gpu/drm/etnaviv/state_blt.xml.h |  20 +++----
>  drivers/gpu/drm/etnaviv/state_hi.xml.h  |  28 +++++----
>  5 files changed, 170 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/cmdstream.xml.h b/drivers/gpu/drm/etnaviv/cmdstream.xml.h
> index 65f1ba1099bd..a96597a27ae2 100644
> --- a/drivers/gpu/drm/etnaviv/cmdstream.xml.h
> +++ b/drivers/gpu/drm/etnaviv/cmdstream.xml.h
> @@ -8,11 +8,11 @@ This file was generated by the rules-ng-ng headergen tool in this git repository
>  git clone git://0x04.net/rules-ng-ng
>
>  The rules-ng-ng source files this header was generated from are:
> -- cmdstream.xml (  14094 bytes, from 2016-11-11 06:55:14)
> -- copyright.xml (   1597 bytes, from 2016-10-29 07:29:22)
> -- common.xml    (  23344 bytes, from 2016-11-10 15:14:07)
> +- cmdstream.xml (  16933 bytes, from 2023-12-11 15:50:17)
> +- copyright.xml (   1597 bytes, from 2016-11-10 13:58:32)
> +- common.xml    (  35664 bytes, from 2023-12-06 10:55:32)
>
> -Copyright (C) 2012-2016 by the following authors:
> +Copyright (C) 2012-2023 by the following authors:
>  - Wladimir J. van der Laan <laanwj@gmail.com>
>  - Christian Gmeiner <christian.gmeiner@gmail.com>
>  - Lucas Stach <l.stach@pengutronix.de>
> @@ -52,6 +52,9 @@ DEALINGS IN THE SOFTWARE.
>  #define FE_OPCODE_RETURN                                       0x0000000b
>  #define FE_OPCODE_DRAW_INSTANCED                               0x0000000c
>  #define FE_OPCODE_CHIP_SELECT                                  0x0000000d
> +#define FE_OPCODE_WAIT_FENCE                                   0x0000000f
> +#define FE_OPCODE_DRAW_INDIRECT                                        0x00000010
> +#define FE_OPCODE_SNAP_PAGES                                   0x00000013
>  #define PRIMITIVE_TYPE_POINTS                                  0x00000001
>  #define PRIMITIVE_TYPE_LINES                                   0x00000002
>  #define PRIMITIVE_TYPE_LINE_STRIP                              0x00000003
> @@ -192,6 +195,9 @@ DEALINGS IN THE SOFTWARE.
>  #define VIV_FE_STALL_TOKEN_TO__MASK                            0x00001f00
>  #define VIV_FE_STALL_TOKEN_TO__SHIFT                           8
>  #define VIV_FE_STALL_TOKEN_TO(x)                               (((x) << VIV_FE_STALL_TOKEN_TO__SHIFT) & VIV_FE_STALL_TOKEN_TO__MASK)
> +#define VIV_FE_STALL_TOKEN_UNK28__MASK                         0x30000000
> +#define VIV_FE_STALL_TOKEN_UNK28__SHIFT                                28
> +#define VIV_FE_STALL_TOKEN_UNK28(x)                            (((x) << VIV_FE_STALL_TOKEN_UNK28__SHIFT) & VIV_FE_STALL_TOKEN_UNK28__MASK)
>
>  #define VIV_FE_CALL                                            0x00000000
>
> @@ -266,5 +272,43 @@ DEALINGS IN THE SOFTWARE.
>  #define VIV_FE_DRAW_INSTANCED_START_INDEX__SHIFT               0
>  #define VIV_FE_DRAW_INSTANCED_START_INDEX(x)                   (((x) << VIV_FE_DRAW_INSTANCED_START_INDEX__SHIFT) & VIV_FE_DRAW_INSTANCED_START_INDEX__MASK)
>
> +#define VIV_FE_WAIT_FENCE                                      0x00000000
> +
> +#define VIV_FE_WAIT_FENCE_HEADER                               0x00000000
> +#define VIV_FE_WAIT_FENCE_HEADER_OP__MASK                      0xf8000000
> +#define VIV_FE_WAIT_FENCE_HEADER_OP__SHIFT                     27
> +#define VIV_FE_WAIT_FENCE_HEADER_OP_WAIT_FENCE                 0x78000000
> +#define VIV_FE_WAIT_FENCE_HEADER_UNK16__MASK                   0x00030000
> +#define VIV_FE_WAIT_FENCE_HEADER_UNK16__SHIFT                  16
> +#define VIV_FE_WAIT_FENCE_HEADER_UNK16(x)                      (((x) << VIV_FE_WAIT_FENCE_HEADER_UNK16__SHIFT) & VIV_FE_WAIT_FENCE_HEADER_UNK16__MASK)
> +#define VIV_FE_WAIT_FENCE_HEADER_WAITCOUNT__MASK               0x0000ffff
> +#define VIV_FE_WAIT_FENCE_HEADER_WAITCOUNT__SHIFT              0
> +#define VIV_FE_WAIT_FENCE_HEADER_WAITCOUNT(x)                  (((x) << VIV_FE_WAIT_FENCE_HEADER_WAITCOUNT__SHIFT) & VIV_FE_WAIT_FENCE_HEADER_WAITCOUNT__MASK)
> +
> +#define VIV_FE_WAIT_FENCE_ADDRESS                              0x00000004
> +
> +#define VIV_FE_DRAW_INDIRECT                                   0x00000000
> +
> +#define VIV_FE_DRAW_INDIRECT_HEADER                            0x00000000
> +#define VIV_FE_DRAW_INDIRECT_HEADER_OP__MASK                   0xf8000000
> +#define VIV_FE_DRAW_INDIRECT_HEADER_OP__SHIFT                  27
> +#define VIV_FE_DRAW_INDIRECT_HEADER_OP_DRAW_INDIRECT           0x80000000
> +#define VIV_FE_DRAW_INDIRECT_HEADER_INDEXED                    0x00000100
> +#define VIV_FE_DRAW_INDIRECT_HEADER_TYPE__MASK                 0x0000000f
> +#define VIV_FE_DRAW_INDIRECT_HEADER_TYPE__SHIFT                        0
> +#define VIV_FE_DRAW_INDIRECT_HEADER_TYPE(x)                    (((x) << VIV_FE_DRAW_INDIRECT_HEADER_TYPE__SHIFT) & VIV_FE_DRAW_INDIRECT_HEADER_TYPE__MASK)
> +
> +#define VIV_FE_DRAW_INDIRECT_ADDRESS                           0x00000004
> +
> +#define VIV_FE_SNAP_PAGES                                      0x00000000
> +
> +#define VIV_FE_SNAP_PAGES_HEADER                               0x00000000
> +#define VIV_FE_SNAP_PAGES_HEADER_OP__MASK                      0xf8000000
> +#define VIV_FE_SNAP_PAGES_HEADER_OP__SHIFT                     27
> +#define VIV_FE_SNAP_PAGES_HEADER_OP_SNAP_PAGES                 0x98000000
> +#define VIV_FE_SNAP_PAGES_HEADER_UNK0__MASK                    0x0000001f
> +#define VIV_FE_SNAP_PAGES_HEADER_UNK0__SHIFT                   0
> +#define VIV_FE_SNAP_PAGES_HEADER_UNK0(x)                       (((x) << VIV_FE_SNAP_PAGES_HEADER_UNK0__SHIFT) & VIV_FE_SNAP_PAGES_HEADER_UNK0__MASK)
> +
>
>  #endif /* CMDSTREAM_XML */
> diff --git a/drivers/gpu/drm/etnaviv/common.xml.h b/drivers/gpu/drm/etnaviv/common.xml.h
> index 001faea80fef..07c0bf47d89f 100644
> --- a/drivers/gpu/drm/etnaviv/common.xml.h
> +++ b/drivers/gpu/drm/etnaviv/common.xml.h
> @@ -8,12 +8,12 @@ This file was generated by the rules-ng-ng headergen tool in this git repository
>  git clone git://0x04.net/rules-ng-ng
>
>  The rules-ng-ng source files this header was generated from are:
> -- texdesc_3d.xml (   3183 bytes, from 2017-12-18 16:51:59)
> -- copyright.xml  (   1597 bytes, from 2016-12-08 16:37:56)
> -- common.xml     (  35468 bytes, from 2018-01-22 13:48:54)
> -- common_3d.xml  (  14615 bytes, from 2017-12-18 16:51:59)
> +- texdesc_3d.xml (   3183 bytes, from 2022-11-18 09:38:25)
> +- copyright.xml  (   1597 bytes, from 2016-11-10 13:58:32)
> +- common.xml     (  35664 bytes, from 2023-12-06 10:55:32)
> +- common_3d.xml  (  15069 bytes, from 2023-11-22 10:05:24)
>
> -Copyright (C) 2012-2018 by the following authors:
> +Copyright (C) 2012-2023 by the following authors:
>  - Wladimir J. van der Laan <laanwj@gmail.com>
>  - Christian Gmeiner <christian.gmeiner@gmail.com>
>  - Lucas Stach <l.stach@pengutronix.de>
> @@ -65,6 +65,7 @@ DEALINGS IN THE SOFTWARE.
>  #define chipModel_GC520                                                0x00000520
>  #define chipModel_GC530                                                0x00000530
>  #define chipModel_GC600                                                0x00000600
> +#define chipModel_GC620                                                0x00000620
>  #define chipModel_GC700                                                0x00000700
>  #define chipModel_GC800                                                0x00000800
>  #define chipModel_GC860                                                0x00000860
> @@ -481,5 +482,6 @@ DEALINGS IN THE SOFTWARE.
>  #define chipMinorFeatures11_NN_INTERLEVE8                      0x00000008
>  #define chipMinorFeatures11_TP_REORDER                         0x00000010
>  #define chipMinorFeatures11_PE_DEPTH_ONLY_OQFIX                        0x00000020
> +#define chipMinorFeatures12_G2D_DEC400EX                       0x00000020
>
>  #endif /* COMMON_XML */
> diff --git a/drivers/gpu/drm/etnaviv/state.xml.h b/drivers/gpu/drm/etnaviv/state.xml.h
> index 421cb7cc0053..573e39489a27 100644
> --- a/drivers/gpu/drm/etnaviv/state.xml.h
> +++ b/drivers/gpu/drm/etnaviv/state.xml.h
> @@ -8,17 +8,17 @@ This file was generated by the rules-ng-ng headergen tool in this git repository
>  git clone git://0x04.net/rules-ng-ng
>
>  The rules-ng-ng source files this header was generated from are:
> -- state.xml     (  26087 bytes, from 2017-12-18 16:51:59)
> -- common.xml    (  35468 bytes, from 2018-01-22 13:48:54)
> -- common_3d.xml (  14615 bytes, from 2017-12-18 16:51:59)
> -- state_hi.xml  (  30232 bytes, from 2018-02-15 15:48:01)
> -- copyright.xml (   1597 bytes, from 2016-12-08 16:37:56)
> -- state_2d.xml  (  51552 bytes, from 2016-12-08 16:37:56)
> -- state_3d.xml  (  79992 bytes, from 2017-12-18 16:51:59)
> -- state_blt.xml (  13405 bytes, from 2017-12-18 16:51:59)
> -- state_vg.xml  (   5975 bytes, from 2016-12-08 16:37:56)
> +- state.xml     (  29355 bytes, from 2024-01-19 10:18:54)
> +- common.xml    (  35664 bytes, from 2023-12-06 10:55:32)
> +- common_3d.xml (  15069 bytes, from 2023-11-22 10:05:24)
> +- state_hi.xml  (  35854 bytes, from 2023-12-11 15:50:17)
> +- copyright.xml (   1597 bytes, from 2016-11-10 13:58:32)
> +- state_2d.xml  (  52271 bytes, from 2023-06-02 12:35:03)
> +- state_3d.xml  (  89522 bytes, from 2024-01-19 10:18:54)
> +- state_blt.xml (  14592 bytes, from 2023-11-22 10:05:09)
> +- state_vg.xml  (   5975 bytes, from 2016-11-10 13:58:32)
>
> -Copyright (C) 2012-2017 by the following authors:
> +Copyright (C) 2012-2024 by the following authors:
>  - Wladimir J. van der Laan <laanwj@gmail.com>
>  - Christian Gmeiner <christian.gmeiner@gmail.com>
>  - Lucas Stach <l.stach@pengutronix.de>
> @@ -55,6 +55,8 @@ DEALINGS IN THE SOFTWARE.
>  #define FE_DATA_TYPE_UNSIGNED_SHORT                            0x00000003
>  #define FE_DATA_TYPE_INT                                       0x00000004
>  #define FE_DATA_TYPE_UNSIGNED_INT                              0x00000005
> +#define FE_DATA_TYPE_INT_2_10_10_10_REV                                0x00000006
> +#define FE_DATA_TYPE_UNSIGNED_INT_2_10_10_10_REV               0x00000007
>  #define FE_DATA_TYPE_FLOAT                                     0x00000008
>  #define FE_DATA_TYPE_HALF_FLOAT                                        0x00000009
>  #define FE_DATA_TYPE_FIXED                                     0x0000000b
> @@ -89,6 +91,7 @@ DEALINGS IN THE SOFTWARE.
>  #define VIVS_FE_VERTEX_ELEMENT_CONFIG_NORMALIZE__MASK          0x0000c000
>  #define VIVS_FE_VERTEX_ELEMENT_CONFIG_NORMALIZE__SHIFT         14
>  #define VIVS_FE_VERTEX_ELEMENT_CONFIG_NORMALIZE_OFF            0x00000000
> +#define VIVS_FE_VERTEX_ELEMENT_CONFIG_NORMALIZE_SIGN_EXTEND    0x00004000
>  #define VIVS_FE_VERTEX_ELEMENT_CONFIG_NORMALIZE_ON             0x00008000
>  #define VIVS_FE_VERTEX_ELEMENT_CONFIG_START__MASK              0x00ff0000
>  #define VIVS_FE_VERTEX_ELEMENT_CONFIG_START__SHIFT             16
> @@ -209,7 +212,15 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_FE_GENERIC_ATTRIB_SCALE(i0)                      (0x00000780 + 0x4*(i0))
>
> -#define VIVS_FE_HALTI5_UNK007C4                                        0x000007c4
> +#define VIVS_FE_HALTI5_ID_CONFIG                               0x000007c4
> +#define VIVS_FE_HALTI5_ID_CONFIG_VERTEX_ID_ENABLE              0x00000001
> +#define VIVS_FE_HALTI5_ID_CONFIG_INSTANCE_ID_ENABLE            0x00000002
> +#define VIVS_FE_HALTI5_ID_CONFIG_VERTEX_ID_REG__MASK           0x0000ff00
> +#define VIVS_FE_HALTI5_ID_CONFIG_VERTEX_ID_REG__SHIFT          8
> +#define VIVS_FE_HALTI5_ID_CONFIG_VERTEX_ID_REG(x)              (((x) << VIVS_FE_HALTI5_ID_CONFIG_VERTEX_ID_REG__SHIFT) & VIVS_FE_HALTI5_ID_CONFIG_VERTEX_ID_REG__MASK)
> +#define VIVS_FE_HALTI5_ID_CONFIG_INSTANCE_ID_REG__MASK         0x00ff0000
> +#define VIVS_FE_HALTI5_ID_CONFIG_INSTANCE_ID_REG__SHIFT                16
> +#define VIVS_FE_HALTI5_ID_CONFIG_INSTANCE_ID_REG(x)            (((x) << VIVS_FE_HALTI5_ID_CONFIG_INSTANCE_ID_REG__SHIFT) & VIVS_FE_HALTI5_ID_CONFIG_INSTANCE_ID_REG__MASK)
>
>  #define VIVS_FE_HALTI5_UNK007D0(i0)                           (0x000007d0 + 0x4*(i0))
>  #define VIVS_FE_HALTI5_UNK007D0__ESIZE                         0x00000004
> @@ -232,6 +243,8 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_FE_ROBUSTNESS_UNK007F8                            0x000007f8
>
> +#define VIVS_FE_MULTI_CLUSTER_UNK007FC                         0x000007fc
> +
>  #define VIVS_GL                                                        0x00000000
>
>  #define VIVS_GL_PIPE_SELECT                                    0x00003800
> @@ -273,6 +286,7 @@ DEALINGS IN THE SOFTWARE.
>  #define VIVS_GL_FLUSH_CACHE_UNK11                              0x00000800
>  #define VIVS_GL_FLUSH_CACHE_DESCRIPTOR_UNK12                   0x00001000
>  #define VIVS_GL_FLUSH_CACHE_DESCRIPTOR_UNK13                   0x00002000
> +#define VIVS_GL_FLUSH_CACHE_UNK14                              0x00004000
>
>  #define VIVS_GL_FLUSH_MMU                                      0x00003810
>  #define VIVS_GL_FLUSH_MMU_FLUSH_FEMMU                          0x00000001
> @@ -282,6 +296,8 @@ DEALINGS IN THE SOFTWARE.
>  #define VIVS_GL_FLUSH_MMU_FLUSH_UNK4                           0x00000010
>
>  #define VIVS_GL_VERTEX_ELEMENT_CONFIG                          0x00003814
> +#define VIVS_GL_VERTEX_ELEMENT_CONFIG_UNK0                     0x00000001
> +#define VIVS_GL_VERTEX_ELEMENT_CONFIG_REUSE                    0x00000010
>
>  #define VIVS_GL_MULTI_SAMPLE_CONFIG                            0x00003818
>  #define VIVS_GL_MULTI_SAMPLE_CONFIG_MSAA_SAMPLES__MASK         0x00000003
> @@ -368,7 +384,7 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_GL_OCCLUSION_QUERY_CONTROL                                0x00003830
>
> -#define VIVS_GL_UNK03834                                       0x00003834
> +#define VIVS_GL_VARYING_NUM_COMPONENTS2                                0x00003834
>
>  #define VIVS_GL_UNK03838                                       0x00003838
>
> @@ -387,7 +403,16 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_GL_FENCE_OUT_DATA_LOW                             0x0000386c
>
> -#define VIVS_GL_HALTI5_UNK03884                                        0x00003884
> +#define VIVS_GL_USC_CONTROL                                    0x00003884
> +#define VIVS_GL_USC_CONTROL_L1_CACHE_RATIO__MASK               0x00000007
> +#define VIVS_GL_USC_CONTROL_L1_CACHE_RATIO__SHIFT              0
> +#define VIVS_GL_USC_CONTROL_L1_CACHE_RATIO(x)                  (((x) << VIVS_GL_USC_CONTROL_L1_CACHE_RATIO__SHIFT) & VIVS_GL_USC_CONTROL_L1_CACHE_RATIO__MASK)
> +#define VIVS_GL_USC_CONTROL_ATTRIB_CACHE_RATIO__MASK           0x00000f00
> +#define VIVS_GL_USC_CONTROL_ATTRIB_CACHE_RATIO__SHIFT          8
> +#define VIVS_GL_USC_CONTROL_ATTRIB_CACHE_RATIO(x)              (((x) << VIVS_GL_USC_CONTROL_ATTRIB_CACHE_RATIO__SHIFT) & VIVS_GL_USC_CONTROL_ATTRIB_CACHE_RATIO__MASK)
> +#define VIVS_GL_USC_CONTROL_UNK16__MASK                                0x001f0000
> +#define VIVS_GL_USC_CONTROL_UNK16__SHIFT                       16
> +#define VIVS_GL_USC_CONTROL_UNK16(x)                           (((x) << VIVS_GL_USC_CONTROL_UNK16__SHIFT) & VIVS_GL_USC_CONTROL_UNK16__MASK)
>
>  #define VIVS_GL_HALTI5_SH_SPECIALS                             0x00003888
>  #define VIVS_GL_HALTI5_SH_SPECIALS_VS_PSIZE_OUT__MASK          0x0000007f
> @@ -421,7 +446,48 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_GL_SECURITY_UNK3904                               0x00003904
>
> +#define VIVS_GL_MULTI_CLUSTER_UNK3908                          0x00003908
> +#define VIVS_GL_MULTI_CLUSTER_UNK3908_UNK0__MASK               0x00000007
> +#define VIVS_GL_MULTI_CLUSTER_UNK3908_UNK0__SHIFT              0
> +#define VIVS_GL_MULTI_CLUSTER_UNK3908_UNK0(x)                  (((x) << VIVS_GL_MULTI_CLUSTER_UNK3908_UNK0__SHIFT) & VIVS_GL_MULTI_CLUSTER_UNK3908_UNK0__MASK)
> +
> +#define VIVS_GL_MULTI_CLUSTER_UNK3910(i0)                     (0x00003910 + 0x4*(i0))
> +#define VIVS_GL_MULTI_CLUSTER_UNK3910__ESIZE                   0x00000004
> +#define VIVS_GL_MULTI_CLUSTER_UNK3910__LEN                     0x00000004
> +#define VIVS_GL_MULTI_CLUSTER_UNK3910_CLUSTER_ALIVE_MASK__MASK 0x000000ff
> +#define VIVS_GL_MULTI_CLUSTER_UNK3910_CLUSTER_ALIVE_MASK__SHIFT        0
> +#define VIVS_GL_MULTI_CLUSTER_UNK3910_CLUSTER_ALIVE_MASK(x)    (((x) << VIVS_GL_MULTI_CLUSTER_UNK3910_CLUSTER_ALIVE_MASK__SHIFT) & VIVS_GL_MULTI_CLUSTER_UNK3910_CLUSTER_ALIVE_MASK__MASK)
> +
> +#define VIVS_GL_NN_CONFIG                                      0x00003930
> +#define VIVS_GL_NN_CONFIG_UNK0__MASK                           0x00000003
> +#define VIVS_GL_NN_CONFIG_UNK0__SHIFT                          0
> +#define VIVS_GL_NN_CONFIG_UNK0(x)                              (((x) << VIVS_GL_NN_CONFIG_UNK0__SHIFT) & VIVS_GL_NN_CONFIG_UNK0__MASK)
> +#define VIVS_GL_NN_CONFIG_DISABLE_ZDPN                         0x00000004
> +#define VIVS_GL_NN_CONFIG_DISABLE_SWTILING                     0x00000008
> +#define VIVS_GL_NN_CONFIG_SMALL_BATCH                          0x00000010
> +#define VIVS_GL_NN_CONFIG_DDR_BURST_SIZE__MASK                 0x00000060
> +#define VIVS_GL_NN_CONFIG_DDR_BURST_SIZE__SHIFT                        5
> +#define VIVS_GL_NN_CONFIG_DDR_BURST_SIZE(x)                    (((x) << VIVS_GL_NN_CONFIG_DDR_BURST_SIZE__SHIFT) & VIVS_GL_NN_CONFIG_DDR_BURST_SIZE__MASK)
> +#define VIVS_GL_NN_CONFIG_UNK7                                 0x00000080
> +#define VIVS_GL_NN_CONFIG_NN_CORE_COUNT__MASK                  0x00000f00
> +#define VIVS_GL_NN_CONFIG_NN_CORE_COUNT__SHIFT                 8
> +#define VIVS_GL_NN_CONFIG_NN_CORE_COUNT(x)                     (((x) << VIVS_GL_NN_CONFIG_NN_CORE_COUNT__SHIFT) & VIVS_GL_NN_CONFIG_NN_CORE_COUNT__MASK)
> +#define VIVS_GL_NN_CONFIG_UNK12                                        0x00001000
> +
> +#define VIVS_GL_SRAM_REMAP_ADDRESS                             0x00003938
> +
> +#define VIVS_GL_OCB_REMAP_START                                        0x0000393c
> +
> +#define VIVS_GL_OCB_REMAP_END                                  0x00003940
> +
> +#define VIVS_GL_TP_CONFIG                                      0x0000394c
> +
> +#define VIVS_GL_UNK03950                                       0x00003950
> +
>  #define VIVS_GL_UNK03A00                                       0x00003a00
> +#define VIVS_GL_UNK03A00_UNK0__MASK                            0x00000007
> +#define VIVS_GL_UNK03A00_UNK0__SHIFT                           0
> +#define VIVS_GL_UNK03A00_UNK0(x)                               (((x) << VIVS_GL_UNK03A00_UNK0__SHIFT) & VIVS_GL_UNK03A00_UNK0__MASK)
>
>  #define VIVS_GL_UNK03A04                                       0x00003a04
>
> @@ -451,7 +517,7 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_NFE_VERTEX_STREAMS_CONTROL(i0)                   (0x00014640 + 0x4*(i0))
>
> -#define VIVS_NFE_VERTEX_STREAMS_UNK14680(i0)                  (0x00014680 + 0x4*(i0))
> +#define VIVS_NFE_VERTEX_STREAMS_VERTEX_DIVISOR(i0)            (0x00014680 + 0x4*(i0))
>
>  #define VIVS_NFE_VERTEX_STREAMS_ROBUSTNESS_UNK146C0(i0)               (0x000146c0 + 0x4*(i0))
>
> @@ -498,5 +564,12 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_DUMMY_DUMMY                                       0x0003fffc
>
> +#define VIVS_WD                                                        0x00000000
> +
> +#define VIVS_WD_UNK18404                                       0x00018404
> +#define VIVS_WD_UNK18404_UNK0__MASK                            0x00000003
> +#define VIVS_WD_UNK18404_UNK0__SHIFT                           0
> +#define VIVS_WD_UNK18404_UNK0(x)                               (((x) << VIVS_WD_UNK18404_UNK0__SHIFT) & VIVS_WD_UNK18404_UNK0__MASK)
> +
>
>  #endif /* STATE_XML */
> diff --git a/drivers/gpu/drm/etnaviv/state_blt.xml.h b/drivers/gpu/drm/etnaviv/state_blt.xml.h
> index 0e8bcf9dcc93..380d3533d645 100644
> --- a/drivers/gpu/drm/etnaviv/state_blt.xml.h
> +++ b/drivers/gpu/drm/etnaviv/state_blt.xml.h
> @@ -8,17 +8,17 @@ This file was generated by the rules-ng-ng headergen tool in this git repository
>  git clone git://0x04.net/rules-ng-ng
>
>  The rules-ng-ng source files this header was generated from are:
> -- state.xml     (  26087 bytes, from 2017-12-18 16:51:59)
> -- common.xml    (  35468 bytes, from 2018-01-22 13:48:54)
> -- common_3d.xml (  14615 bytes, from 2017-12-18 16:51:59)
> -- state_hi.xml  (  30232 bytes, from 2018-02-15 15:48:01)
> -- copyright.xml (   1597 bytes, from 2016-12-08 16:37:56)
> -- state_2d.xml  (  51552 bytes, from 2016-12-08 16:37:56)
> -- state_3d.xml  (  79992 bytes, from 2017-12-18 16:51:59)
> -- state_blt.xml (  13405 bytes, from 2017-12-18 16:51:59)
> -- state_vg.xml  (   5975 bytes, from 2016-12-08 16:37:56)
> +- state.xml     (  29355 bytes, from 2024-01-19 10:18:54)
> +- common.xml    (  35664 bytes, from 2023-12-06 10:55:32)
> +- common_3d.xml (  15069 bytes, from 2023-11-22 10:05:24)
> +- state_hi.xml  (  35854 bytes, from 2023-12-11 15:50:17)
> +- copyright.xml (   1597 bytes, from 2016-11-10 13:58:32)
> +- state_2d.xml  (  52271 bytes, from 2023-06-02 12:35:03)
> +- state_3d.xml  (  89522 bytes, from 2024-01-19 10:18:54)
> +- state_blt.xml (  14592 bytes, from 2023-11-22 10:05:09)
> +- state_vg.xml  (   5975 bytes, from 2016-11-10 13:58:32)
>
> -Copyright (C) 2012-2017 by the following authors:
> +Copyright (C) 2012-2023 by the following authors:
>  - Wladimir J. van der Laan <laanwj@gmail.com>
>  - Christian Gmeiner <christian.gmeiner@gmail.com>
>  - Lucas Stach <l.stach@pengutronix.de>
> diff --git a/drivers/gpu/drm/etnaviv/state_hi.xml.h b/drivers/gpu/drm/etnaviv/state_hi.xml.h
> index 94d5f33b1fd6..829bc528e618 100644
> --- a/drivers/gpu/drm/etnaviv/state_hi.xml.h
> +++ b/drivers/gpu/drm/etnaviv/state_hi.xml.h
> @@ -8,17 +8,17 @@ This file was generated by the rules-ng-ng headergen tool in this git repository
>  git clone git://0x04.net/rules-ng-ng
>
>  The rules-ng-ng source files this header was generated from are:
> -- state.xml     (  27198 bytes, from 2022-04-22 10:35:24)
> -- common.xml    (  35468 bytes, from 2020-10-28 12:56:03)
> -- common_3d.xml (  15058 bytes, from 2020-10-28 12:56:03)
> -- state_hi.xml  (  34804 bytes, from 2022-12-02 09:06:28)
> -- copyright.xml (   1597 bytes, from 2020-10-28 12:56:03)
> -- state_2d.xml  (  51552 bytes, from 2020-10-28 12:56:03)
> -- state_3d.xml  (  84445 bytes, from 2022-11-15 15:59:38)
> -- state_blt.xml (  14424 bytes, from 2022-11-07 11:18:41)
> -- state_vg.xml  (   5975 bytes, from 2020-10-28 12:56:03)
> +- state.xml     (  29355 bytes, from 2024-01-19 10:18:54)
> +- common.xml    (  35664 bytes, from 2023-12-06 10:55:32)
> +- common_3d.xml (  15069 bytes, from 2023-11-22 10:05:24)
> +- state_hi.xml  (  35854 bytes, from 2023-12-11 15:50:17)
> +- copyright.xml (   1597 bytes, from 2016-11-10 13:58:32)
> +- state_2d.xml  (  52271 bytes, from 2023-06-02 12:35:03)
> +- state_3d.xml  (  89522 bytes, from 2024-01-19 10:18:54)
> +- state_blt.xml (  14592 bytes, from 2023-11-22 10:05:09)
> +- state_vg.xml  (   5975 bytes, from 2016-11-10 13:58:32)
>
> -Copyright (C) 2012-2022 by the following authors:
> +Copyright (C) 2012-2023 by the following authors:
>  - Wladimir J. van der Laan <laanwj@gmail.com>
>  - Christian Gmeiner <christian.gmeiner@gmail.com>
>  - Lucas Stach <l.stach@pengutronix.de>
> @@ -275,8 +275,10 @@ DEALINGS IN THE SOFTWARE.
>  #define VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SE 0x00000020
>  #define VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA 0x00000040
>  #define VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX 0x00000080
> +#define VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SH_EU      0x00000400
>  #define VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_EZ      0x00010000
>  #define VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_HZ      0x00020000
> +#define VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_NN 0x00400000
>
>  #define VIVS_PM_MODULE_STATUS                                  0x00000108
>  #define VIVS_PM_MODULE_STATUS_MODULE_CLOCK_GATED_FE            0x00000001
> @@ -620,5 +622,11 @@ DEALINGS IN THE SOFTWARE.
>
>  #define VIVS_MC_MC_AXI_SAMPLE_COUNT                            0x00000574
>
> +#define VIVS_DEC400EX                                          0x00000000
> +
> +#define VIVS_DEC400EX_UNK00800                                 0x00000800
> +
> +#define VIVS_DEC400EX_UNK00808                                 0x00000808
> +
>
>  #endif /* STATE_HI_XML */
>
> --
> 2.39.2
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

