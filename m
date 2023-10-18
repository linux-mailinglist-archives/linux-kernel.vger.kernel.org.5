Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8847CDD25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjJRNZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJRNZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:25:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D1095
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:24:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FF9C433CB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697635498;
        bh=y7R3Xc7b/dDNyN2IeFpAjUBAw7DegSFH5XvMPARiVk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HqRRQnvPK9Llpsr83E0oTzhy/MdvDrNQkXWi1wfdt0swbneeg0G4qXpRNX0H2YOU8
         2s/GzaMVN5v/JizxnGYjamOybkFMBWCSqMvH1s0EJKOBdkW0BIVnuibasbKNkxp2r1
         Iwxr32Ep7jAMWk7Ii3r6oIFRubLOCdh50Mf2Bosg/+LM93+ZMNIQipIqrP4OpQuQVB
         YQyqyXkE6wzhg/dconNrBQ1Mq6EzoUgRspIbWiMlvHn+DTtkk3XDou8f58qRH3rApf
         FyJxSaDGH60zhVh5e+mCRFTEy1EmvbeeNGHgX7nXeq0waUYlQmVvdYKcmnHdCOhX0X
         mdU01qZUKbTJw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9338e4695so92284751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:24:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYnAQtFiia4UTlHUQdyMlny3rbyPJwan6pvscEphtAZsgMTuGf
        LLyCBQQ5s3wDQbdtnEgO+siDPK3UG777aUmwhA==
X-Google-Smtp-Source: AGHT+IE2erweQk78p2WZGcYNeJzi7UyNstiTigaugME3+3bf0yEm/om0FbaNsQp91jAtR+tU1eTO2SwDaQRNiTjDk+0=
X-Received: by 2002:a2e:9457:0:b0:2b9:4b2e:5420 with SMTP id
 o23-20020a2e9457000000b002b94b2e5420mr3825894ljh.52.1697635496365; Wed, 18
 Oct 2023 06:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230523104234.7849-1-angelogioacchino.delregno@collabora.com>
 <20230915101124.283232-1-mwalle@kernel.org> <54a04d22-7ec1-473b-ab57-f6339b2cc782@collabora.com>
In-Reply-To: <54a04d22-7ec1-473b-ab57-f6339b2cc782@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 18 Oct 2023 21:24:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_85g9bvVDUqK3ePd+7cWvqmVU4zRb=f4QxU_=A9eZaEpw@mail.gmail.com>
Message-ID: <CAAOTY_85g9bvVDUqK3ePd+7cWvqmVU4zRb=f4QxU_=A9eZaEpw@mail.gmail.com>
Subject: Re: [PATCH] drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Walle <mwalle@kernel.org>, airlied@gmail.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jitao.shi@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, shaoming.chen@mediatek.com,
        yt.shen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2023=E5=B9=B410=E6=9C=8818=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:=
21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 15/09/23 12:11, Michael Walle ha scritto:
> >> Due to the initial confusion about MIPI_DSI_MODE_EOT_PACKET, properly
> >> renamed to MIPI_DSI_MODE_NO_EOT_PACKET, reflecting its actual meaning,
> >> both the DSI_TXRX_CON register setting for bit (HSTX_)DIS_EOT and the
> >> later calculation for horizontal sync-active (HSA), back (HBP) and
> >> front (HFP) porches got incorrect due to the logic being inverted.
> >>
> >> This means that a number of settings were wrong because....:
> >>   - DSI_TXRX_CON register setting: bit (HSTX_)DIS_EOT should be
> >>     set in order to disable the End of Transmission packet;
> >>   - Horizontal Sync and Back/Front porches: The delta used to
> >>     calculate all of HSA, HBP and HFP should account for the
> >>     additional EOT packet.
> >>
> >> Before this change...
> >>   - Bit (HSTX_)DIS_EOT was being set when EOT packet was enabled;
> >>   - For HSA/HBP/HFP delta... all three were wrong, as words were
> >>     added when EOT disabled, instead of when EOT packet enabled!
> >>
> >> Invert the logic around flag MIPI_DSI_MODE_NO_EOT_PACKET in the
> >> MediaTek DSI driver to fix the aforementioned issues.
> >>
> >> Fixes: 8b2b99fd7931 ("drm/mediatek: dsi: Fine tune the line time cause=
d by EOTp")
> >> Fixes: 2d52bfba09d1 ("drm/mediatek: add non-continuous clock mode and =
EOT packet control")
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >
>
> Hello CK,
>
> can you please pick this fix?

Applied with the changing

Fixes: 2d52bfba09d1 ("drm/mediatek: add non-continuous clock mode and
EOT packet control")

to

Fixes: c87d1c4b5b9a ("drm/mediatek: dsi: Use symbolized register definition=
")

Regards,
Chun-Kuang.

>
> Thanks,
> Angelo
>
