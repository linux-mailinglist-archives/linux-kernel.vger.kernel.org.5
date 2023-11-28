Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B737FB62A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjK1Joq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 04:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjK1Joo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:44:44 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DF0DA;
        Tue, 28 Nov 2023 01:44:48 -0800 (PST)
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r7udu-0002kA-Qd; Tue, 28 Nov 2023 10:44:34 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>, Andy Yan <andy.yan@rock-chips.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v2 10/12] drm/rockchip: vop2: Add support for rk3588
Date:   Tue, 28 Nov 2023 10:44:33 +0100
Message-ID: <4339687.HovnAMPojK@diego>
In-Reply-To: <f179e9ae-b2cd-4f6c-badc-4d76d8a3ba0d@rock-chips.com>
References: <20231122125316.3454268-1-andyshrk@163.com> <4788319.uZKlY2gecq@diego>
 <f179e9ae-b2cd-4f6c-badc-4d76d8a3ba0d@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am Dienstag, 28. November 2023, 10:32:55 CET schrieb Andy Yan:
> On 11/27/23 23:29, Heiko Stübner wrote:
> > Am Mittwoch, 22. November 2023, 13:55:44 CET schrieb Andy Yan:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >>
> >> VOP2 on rk3588:
> >>
> >> Four video ports:
> >> VP0 Max 4096x2160
> >> VP1 Max 4096x2160
> >> VP2 Max 4096x2160
> >> VP3 Max 2048x1080
> >>
> >> 4 4K Cluster windows with AFBC/line RGB and AFBC-only YUV support
> >> 4 4K Esmart windows with line RGB/YUV support
> >>
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >>
> >> ---
> >>
> >> Changes in v2:
> >> - add rk3588_ prefix for functions which are rk3588 only
> >> - make some calculation as fixed value and keep calculation formula as
> >>    comment
> >> - check return value for some cru calculation functions.
> >> - check return value for syscon_regmap_lookup_by_phandle
> >> - add NV20/NV30 for esmart plane
> >>
> >>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 381 ++++++++++++++++++-
> >>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  66 ++++
> >>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 221 +++++++++++
> >>   3 files changed, 660 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >> index 4bcc405bcf11..9eecbe1f71f9 100644
> >> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >> @@ -271,9 +282,12 @@ static bool vop2_cluster_window(const struct vop2_win *win)
> >>   static void vop2_cfg_done(struct vop2_video_port *vp)
> >>   {
> >>   	struct vop2 *vop2 = vp->vop2;
> >> +	u32 val;
> >> +
> >> +	val = BIT(vp->id) | (BIT(vp->id) << 16) |
> >> +		RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN;
> >>   
> >> -	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE,
> >> -			BIT(vp->id) | RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN);
> >> +	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE, val);
> > I don't fully understand that code:
> > (1) the write mask is also present on the rk3568, so should this change
> >      be a separate patch with a fixes tag?
> 
> The write mask of VP config done on rk356x is missing, that means
> you can write the corresponding mask bit, but it has no effect.
>
> I once considered making it a separate patch,  I can split it as a separate patch if
> you like.

I think I'd like it to be a separate patch please.


> > (2) RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN does not contain the part for
> >      the write-mask
> >
> > 	#define RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN     BIT(15)
> >
> >      why is this working then?
> 
> 
> Actually this bit has no write-mask bit. 🙂

when doing that separate patch mentioned above, could you also add a
comment to the code stating that RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN
doesn't have a write mask bit please?

Because the TRM is not clear and ideally I'd not forget this fact for
the future :-) .


> >>   }
> >>   
> >>   static void vop2_win_disable(struct vop2_win *win)
> > [...]
> >
> >> @@ -1298,7 +1346,11 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
> >>   			vop2_win_write(win, VOP2_WIN_AFBC_ENABLE, 1);
> >>   		vop2_win_write(win, VOP2_WIN_AFBC_FORMAT, afbc_format);
> >>   		vop2_win_write(win, VOP2_WIN_AFBC_UV_SWAP, uv_swap);
> >> -		vop2_win_write(win, VOP2_WIN_AFBC_AUTO_GATING_EN, 0);
> >> +		if (vop2->data->soc_id == 3566 || vop2->data->soc_id == 3568)
> >> +			vop2_win_write(win, VOP2_WIN_AFBC_AUTO_GATING_EN, 0);
> >> +		else
> >> +			vop2_win_write(win, VOP2_WIN_AFBC_AUTO_GATING_EN, 1);
> >> +
> > I think this at least warrants a comment, what is happening here. Also,
> > can you already see how future vop2-users are behaving - aka are all new
> > socs in the "else" part of the conditional, or would a switch-case better
> > represent future socs?
> 
> 
> On rk356x, this bit is auto gating enable, but this function is not work well so
> we need to disable this function.
> On rk3588, and the following new soc(rk3528/rk3576), this bit is gating disable,
> we should write 1 to disable gating when enable a cluster window.
> 
> 
> Maybe i add some comments in next version ?

Yep that comment would be helpful. And with your explanation the code
itself can stay as it is :-)

Thanks
Heiko


> >>   		vop2_win_write(win, VOP2_WIN_AFBC_BLOCK_SPLIT_EN, 0);
> >>   		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en);
> >>   		vop2_win_write(win, VOP2_WIN_AFBC_HDR_PTR, yrgb_mst);
> >
> >> @@ -1627,9 +1937,17 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
> >>   	drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
> >>   		struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
> >>   
> >> -		rk3568_set_intf_mux(vp, rkencoder->crtc_endpoint_id, polflags);
> >> +		/*
> >> +		 * for drive a high resolution(4KP120, 8K), vop on rk3588/rk3576 need
> >> +		 * process multi(1/2/4/8) pixels per cycle, so the dclk feed by the
> >> +		 * system cru may be the 1/2 or 1/4 of mode->clock.
> >> +		 */
> >> +		clock = vop2_set_intf_mux(vp, rkencoder->crtc_endpoint_id, polflags);
> >>   	}
> >>   
> >> +	if (!clock)
> >> +		return;
> >> +
> > hmm, shouldn't the check for the validity of a mode happen before
> > atomic_enable is run? So this shouldn't error out in the middle of the
> > function?
> >
> >
> >>   	if (vcstate->output_mode == ROCKCHIP_OUT_MODE_AAAA &&
> >>   	    !(vp_data->feature & VOP_FEATURE_OUTPUT_10BIT))
> >>   		out_mode = ROCKCHIP_OUT_MODE_P888;
> >
> > Thanks
> > Heiko
> >
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 




