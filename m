Return-Path: <linux-kernel+bounces-11477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF881E6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD231C21D94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4934E1B2;
	Tue, 26 Dec 2023 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwUj8bQb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129F4CE1F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-467010c1c72so632281137.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703587617; x=1704192417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XQX9ADRpW0fV0acmqNA3+e/T+xSUGBzzTRQ8O4YnQM=;
        b=EwUj8bQbrStPQyB7hhU5SrNtLQ230FbHJOQtwb61XgFmCam4o7mV6Ji5ANC1V8kRDY
         8g/vcJ1GuQjpQzb/gOGBuA15PfURelntir0C+iQiHPhmhk5tZ5mvkiuIZZDoVrPrRc4E
         J1oCHYf9+jkq1EGx6KOfGfM2rJg+s24AtB8v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703587617; x=1704192417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XQX9ADRpW0fV0acmqNA3+e/T+xSUGBzzTRQ8O4YnQM=;
        b=JJ99rl7h2oGefGvAiDUSMSLWjnLMA51xeumttoyoMDSOySYLpcPg5VhI+VpsGKaGES
         B2ro33mrT4NzHepcyQ2EDT58Zn7llVzdkju7pBczSB3HkekQZ9THy1gcqb3CRBApUcKj
         ORWNL3XjQvnYTf42tPMicGSuMT1VRriUheT5E2nn9E0BsS1bL+l5oeC3VHylEqumx76t
         lBw7plASucN4SDXDE9smt7RjQqe7mK97HFSjjB2ss+ZlFQJn0uAxpSQwRStOGW1EpMwq
         QCOcD5d/fAutb96PmaqWlCB7IoP7GYx8duIFG4dkA0/N5TzcIiMbOY0JXRZBamPVaQ7H
         rPRg==
X-Gm-Message-State: AOJu0YyZZL5CkuYLPhJapQ0PhXe+KSqPkLqQjv4UsZYFWJsFVihj/f+y
	5KEAZxwCHHyUURV3xasWbBchChALr0FzZqt0HhtACf3gfA==
X-Google-Smtp-Source: AGHT+IFqvDzK2Rsh6XXsNUSbmM5q+7j2vxheyzqHQXo84NGKJDl625+iGoYL4LRQ36wjW6u8uAzZ7Q==
X-Received: by 2002:a67:ff8b:0:b0:467:1cf4:7575 with SMTP id v11-20020a67ff8b000000b004671cf47575mr109095vsq.6.1703587616838;
        Tue, 26 Dec 2023 02:46:56 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ek11-20020a0561302c8b00b007cbbc93aba1sm367004uab.5.2023.12.26.02.46.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 02:46:56 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7cc14b91230so3068291241.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:46:55 -0800 (PST)
X-Received: by 2002:a05:6102:5593:b0:464:77f1:f34a with SMTP id
 dc19-20020a056102559300b0046477f1f34amr3642595vsb.24.1703587614863; Tue, 26
 Dec 2023 02:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220135722.192080-1-angelogioacchino.delregno@collabora.com> <20231220135722.192080-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220135722.192080-2-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 26 Dec 2023 18:46:18 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng+kkJS-g3FHe4SC-r1a6hegj3=Any07TCdvTU_apvZNg@mail.gmail.com>
Message-ID: <CAC=S1ng+kkJS-g3FHe4SC-r1a6hegj3=Any07TCdvTU_apvZNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/mediatek: dsi: Use GENMASK() for register mask definitions
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Wed, Dec 20, 2023 at 9:57=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Change magic numerical masks with usage of the GENMASK() macro
> to improve readability.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 46 ++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index a2fdfc8ddb15..23d2c5be8dbb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -58,18 +58,18 @@
>
>  #define DSI_TXRX_CTRL          0x18
>  #define VC_NUM                         BIT(1)
> -#define LANE_NUM                       (0xf << 2)
> +#define LANE_NUM                       GENMASK(5, 2)
>  #define DIS_EOT                                BIT(6)
>  #define NULL_EN                                BIT(7)
>  #define TE_FREERUN                     BIT(8)
>  #define EXT_TE_EN                      BIT(9)
>  #define EXT_TE_EDGE                    BIT(10)
> -#define MAX_RTN_SIZE                   (0xf << 12)
> +#define MAX_RTN_SIZE                   GENMASK(15, 12)
>  #define HSTX_CKLP_EN                   BIT(16)
>
>  #define DSI_PSCTRL             0x1c
> -#define DSI_PS_WC                      0x3fff
> -#define DSI_PS_SEL                     (3 << 16)
> +#define DSI_PS_WC                      GENMASK(14, 0)
> +#define DSI_PS_SEL                     GENMASK(19, 16)

GENMASK(17, 16)
>
>  #define PACKED_PS_16BIT_RGB565         (0 << 16)
>  #define LOOSELY_PS_18BIT_RGB666                (1 << 16)
>  #define PACKED_PS_18BIT_RGB666         (2 << 16)
> @@ -109,26 +109,27 @@
>  #define LD0_WAKEUP_EN                  BIT(2)
>
>  #define DSI_PHY_TIMECON0       0x110
> -#define LPX                            (0xff << 0)
> -#define HS_PREP                                (0xff << 8)
> -#define HS_ZERO                                (0xff << 16)
> -#define HS_TRAIL                       (0xff << 24)
> +#define LPX                            GENMASK(7, 0)
> +#define HS_PREP                                GENMASK(15, 8)
> +#define HS_ZERO                                GENMASK(23, 16)
> +#define HS_TRAIL                       GENMASK(31, 24)
>
>  #define DSI_PHY_TIMECON1       0x114
> -#define TA_GO                          (0xff << 0)
> -#define TA_SURE                                (0xff << 8)
> -#define TA_GET                         (0xff << 16)
> -#define DA_HS_EXIT                     (0xff << 24)
> +#define TA_GO                          GENMASK(7, 0)
> +#define TA_SURE                                GENMASK(15, 8)
> +#define TA_GET                         GENMASK(23, 16)
> +#define DA_HS_EXIT                     GENMASK(31, 24)
>
>  #define DSI_PHY_TIMECON2       0x118
> -#define CONT_DET                       (0xff << 0)
> -#define CLK_ZERO                       (0xff << 16)
> -#define CLK_TRAIL                      (0xff << 24)
> +#define CONT_DET                       GENMASK(7, 0)
> +#define DA_HS_SYNC                     GENMASK(15, 8)

This is new, so please introduce it in a separate patch if intended.

The rest looks good to me.

Regards,
Fei


>
> +#define CLK_ZERO                       GENMASK(23, 16)
> +#define CLK_TRAIL                      GENMASK(31, 24)
>
>  #define DSI_PHY_TIMECON3       0x11c
> -#define CLK_HS_PREP                    (0xff << 0)
> -#define CLK_HS_POST                    (0xff << 8)
> -#define CLK_HS_EXIT                    (0xff << 16)
> +#define CLK_HS_PREP                    GENMASK(7, 0)
> +#define CLK_HS_POST                    GENMASK(15, 8)
> +#define CLK_HS_EXIT                    GENMASK(23, 16)
>
>  #define DSI_VM_CMD_CON         0x130
>  #define VM_CMD_EN                      BIT(0)
> @@ -138,13 +139,14 @@
>  #define FORCE_COMMIT                   BIT(0)
>  #define BYPASS_SHADOW                  BIT(1)
>
> -#define CONFIG                         (0xff << 0)
> +/* CMDQ related bits */
> +#define CONFIG                         GENMASK(7, 0)
>  #define SHORT_PACKET                   0
>  #define LONG_PACKET                    2
>  #define BTA                            BIT(2)
> -#define DATA_ID                                (0xff << 8)
> -#define DATA_0                         (0xff << 16)
> -#define DATA_1                         (0xff << 24)
> +#define DATA_ID                                GENMASK(15, 8)
> +#define DATA_0                         GENMASK(23, 16)
> +#define DATA_1                         GENMASK(31, 24)
>
>  #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
>
> --
> 2.43.0
>
>

