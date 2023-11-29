Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB97FE0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjK2UGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjK2UGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:06:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80FD69;
        Wed, 29 Nov 2023 12:06:52 -0800 (PST)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F8556F0;
        Wed, 29 Nov 2023 21:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701288375;
        bh=pr+DI5rX3G04hdirVZl6BkJQ1CLmT65yZtHt6DXjLiQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VL05jxidfay1sFOSzYKbcy2FZEW1U8kscMsQ8whITFDm3SfVNs5cKFR7evcrNSPhR
         ID63lSLDWx5GiIxP4UAeBXndZgTHzGth7c2fg1EKtEd+zDlMwV1zJWVD542Bw+TAXk
         I1wr5C5rutATEIoNtXji7z4ziw6/lhFH/+D1DkT4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231129092956.250129-4-paul.elder@ideasonboard.com>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com> <20231129092956.250129-4-paul.elder@ideasonboard.com>
Subject: Re: [PATCH 3/3] media: rkisp1: debug: Count completed frame interrupts
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Date:   Wed, 29 Nov 2023 20:06:48 +0000
Message-ID: <170128840893.3048548.12921821466589985052@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Elder (2023-11-29 09:29:56)
> Add a counter to debugfs to count the number of frame-end interrupts.
>=20

And I alway like having counters for debug ... so I like this.


Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 1 +
>  drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c  | 2 ++
>  drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c    | 2 ++
>  3 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/dri=
vers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 1e7cea1bea5e..be69173958a4 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -417,6 +417,7 @@ struct rkisp1_debug {
>         unsigned long stats_error;
>         unsigned long stop_timeout[2];
>         unsigned long frame_drop[2];
> +       unsigned long complete_frames;
>  };
> =20
>  /*
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/driv=
ers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> index f66b9754472e..1b1edfd3ab6c 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> @@ -232,6 +232,8 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
>                              &debug->frame_drop[RKISP1_MAINPATH]);
>         debugfs_create_ulong("sp_frame_drop", 0444, debug->debugfs_dir,
>                              &debug->frame_drop[RKISP1_SELFPATH]);
> +       debugfs_create_ulong("complete_frames", 0444, debug->debugfs_dir,
> +                            &debug->complete_frames);
>         debugfs_create_file("input_status", 0444, debug->debugfs_dir, rki=
sp1,
>                             &rkisp1_debug_input_status_fops);
> =20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/driver=
s/media/platform/rockchip/rkisp1/rkisp1-isp.c
> index 64a956b9f2d0..06cdb4edf19c 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> @@ -991,6 +991,8 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
>         if (status & RKISP1_CIF_ISP_FRAME) {
>                 u32 isp_ris;
> =20
> +               rkisp1->debug.complete_frames++;
> +
>                 /* New frame from the sensor received */
>                 isp_ris =3D rkisp1_read(rkisp1, RKISP1_CIF_ISP_RIS);
>                 if (isp_ris & RKISP1_STATS_MEAS_MASK)
> --=20
> 2.39.2
>
