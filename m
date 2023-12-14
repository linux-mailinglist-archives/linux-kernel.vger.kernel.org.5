Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B933812ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443998AbjLNLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444075AbjLNLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:40:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0350CD63;
        Thu, 14 Dec 2023 03:39:51 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 450628CD;
        Thu, 14 Dec 2023 12:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702553942;
        bh=ogHP7ERRqviyncSIJETCyLsvDqsw9yYJg9b459qDC04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFGZadcnghgkbdRSqXyXrTr/FQ+F3mwnvSwxoKadm1KoorapugcujdUkCoJnmgSSf
         6UMZYvn4Ctkka5ydMgiAM4Z8OHivCmuyJoqX/TCOyUIG8o+N6phS28+GR6r1UnLpBW
         LqtPQa1cw3gdgzWF+BnhfTJcN/mg2Z8VxIGLi/Xo=
Date:   Thu, 14 Dec 2023 13:39:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marvin Lin <milkfafa@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Ming Qian <ming.qian@nxp.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 1/9] media: v4l2-ctrls: Add user controls for StarFive
 JH7110 ISP
Message-ID: <20231214113955.GK12450@pendragon.ideasonboard.com>
References: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
 <20231214065027.28564-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214065027.28564-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changhuang,

Thank you for the patch.

On Wed, Dec 13, 2023 at 10:50:19PM -0800, Changhuang Liang wrote:
> Add a control base for StarFive JH7110 ISP driver controls, and reserve
> 32 controls，also add some controls for StarFive JH7110 ISP.

ISP parameters should be passed through parameters buffers, not V4L2
control. See for instance the V4L2_META_FMT_RK_ISP1_PARAMS format in the
mainline kernel, it describes how to store ISP parameters in a buffer.
The rkisp1 driver is an example of how this can be implemented.

Please note that the ISP parameters need to be documented precisely,
regardless of how they're passed by userspace to the kernel. Even with
V4L2 controls, documentation would be needed. Please see below for
additional comments.

> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  MAINTAINERS                        |   1 +
>  include/uapi/linux/jh7110-isp.h    | 342 +++++++++++++++++++++++++++++
>  include/uapi/linux/v4l2-controls.h |   6 +
>  3 files changed, 349 insertions(+)
>  create mode 100644 include/uapi/linux/jh7110-isp.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af94a3a9be80..e4b6408585d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20664,6 +20664,7 @@ S:	Maintained
>  F:	Documentation/admin-guide/media/starfive_camss.rst
>  F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>  F:	drivers/staging/media/starfive/camss
> +F:	include/uapi/linux/jh7110-isp.h
>  
>  STARFIVE CRYPTO DRIVER
>  M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
> diff --git a/include/uapi/linux/jh7110-isp.h b/include/uapi/linux/jh7110-isp.h
> new file mode 100644
> index 000000000000..df0bb6ab1895
> --- /dev/null
> +++ b/include/uapi/linux/jh7110-isp.h
> @@ -0,0 +1,342 @@
> +/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * jh7110-isp.h
> + *
> + * JH7110 ISP driver - user space header file.
> + *
> + * Copyright © 2023 Starfive Technology Co., Ltd.
> + *
> + * Author: Su Zejian (zejian.su@starfivetech.com)
> + *
> + */
> +
> +#ifndef __JH7110_ISP_H_
> +#define __JH7110_ISP_H_
> +
> +#include <linux/v4l2-controls.h>
> +
> +#define V4L2_CID_USER_JH7110_ISP_WB_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0001)
> +#define V4L2_CID_USER_JH7110_ISP_CAR_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0002)
> +#define V4L2_CID_USER_JH7110_ISP_CCM_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0003)
> +#define V4L2_CID_USER_JH7110_ISP_CFA_SETTING		\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0004)
> +#define V4L2_CID_USER_JH7110_ISP_CTC_SETTING		\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0005)
> +#define V4L2_CID_USER_JH7110_ISP_DBC_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0006)
> +#define V4L2_CID_USER_JH7110_ISP_DNYUV_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0007)
> +#define V4L2_CID_USER_JH7110_ISP_GMARGB_SETTING		\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0008)
> +#define V4L2_CID_USER_JH7110_ISP_LCCF_SETTING \
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0009)
> +#define V4L2_CID_USER_JH7110_ISP_OBC_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x000a)
> +#define V4L2_CID_USER_JH7110_ISP_OECF_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x000b)
> +#define V4L2_CID_USER_JH7110_ISP_R2Y_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x000c)
> +#define V4L2_CID_USER_JH7110_ISP_SAT_SETTING		\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x000d)
> +#define V4L2_CID_USER_JH7110_ISP_SHRP_SETTING		\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x000e)
> +#define V4L2_CID_USER_JH7110_ISP_YCRV_SETTING	\
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x000f)
> +#define V4L2_CID_USER_JH7110_ISP_STAT_SETTING \
> +				(V4L2_CID_USER_JH7110_ISP_BASE + 0x0010)
> +
> +struct jh7110_isp_wb_gain {
> +	__u16 gain_r;
> +	__u16 gain_g;
> +	__u16 gain_b;

This seems easy to understand, but still needs documentation. What is
the minimum and maximum value, what is the unit (e.g. is the gain in
U8.8 format ?), ...

> +};
> +
> +struct jh7110_isp_wb_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_wb_gain gains;
> +};
> +
> +struct jh7110_isp_car_setting {
> +	__u32 enabled;
> +};
> +
> +struct jh7110_isp_ccm_smlow {
> +	__s32 ccm[3][3];
> +	__s32 offsets[3];

Same here, I understand what those fields are, but I can't tell the
unit, and also can't tell in which order the values are stored in CCM.

> +};
> +
> +struct jh7110_isp_ccm_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_ccm_smlow ccm_smlow;
> +};
> +
> +struct jh7110_isp_cfa_params {
> +	__s32 hv_width;
> +	__s32 cross_cov;

Here on the other hand, I have no idea what those parameters are. Same
for lots of parameters below.

A block diagram is also needed, to indicate in which order the different
processing steps are performed.

> +};
> +
> +struct jh7110_isp_cfa_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_cfa_params settings;
> +};
> +
> +struct jh7110_isp_ctc_params {
> +	__u8 saf_mode;
> +	__u8 daf_mode;
> +	__s32 max_gt;
> +	__s32 min_gt;
> +};
> +
> +struct jh7110_isp_ctc_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_ctc_params settings;
> +};
> +
> +struct jh7110_isp_dbc_params {
> +	__s32 bad_gt;
> +	__s32 bad_xt;
> +};
> +
> +struct jh7110_isp_dbc_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_dbc_params settings;
> +};
> +
> +struct jh7110_isp_dnyuv_params {
> +	__u8 y_sweight[10];
> +	__u16 y_curve[7];
> +	__u8 uv_sweight[10];
> +	__u16 uv_curve[7];
> +};
> +
> +struct jh7110_isp_dnyuv_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_dnyuv_params settings;
> +};
> +
> +struct jh7110_isp_gmargb_point {
> +	__u16 g_val;
> +	__u16 sg_val;
> +};
> +
> +struct jh7110_isp_gmargb_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_gmargb_point curve[15];
> +};
> +
> +struct jh7110_isp_lccf_circle {
> +	__s16 center_x;
> +	__s16 center_y;
> +	__u8 radius;
> +};
> +
> +struct jh7110_isp_lccf_curve_param {
> +	__s16 f1;
> +	__s16 f2;
> +};
> +
> +struct jh7110_isp_lccf_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_lccf_circle circle;
> +	struct jh7110_isp_lccf_curve_param r_param;
> +	struct jh7110_isp_lccf_curve_param gr_param;
> +	struct jh7110_isp_lccf_curve_param gb_param;
> +	struct jh7110_isp_lccf_curve_param b_param;
> +};
> +
> +struct jh7110_isp_blacklevel_win_size {
> +	__u32 width;
> +	__u32 height;
> +};
> +
> +struct jh7110_isp_blacklevel_gain {
> +	__u8 tl_gain;
> +	__u8 tr_gain;
> +	__u8 bl_gain;
> +	__u8 br_gain;
> +};
> +
> +struct jh7110_isp_blacklevel_offset {
> +	__u8 tl_offset;
> +	__u8 tr_offset;
> +	__u8 bl_offset;
> +	__u8 br_offset;
> +};
> +
> +struct jh7110_isp_blacklevel_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_blacklevel_win_size win_size;
> +	struct jh7110_isp_blacklevel_gain gain[4];
> +	struct jh7110_isp_blacklevel_offset offset[4];
> +};
> +
> +struct jh7110_isp_oecf_point {
> +	__u16 x;
> +	__u16 y;
> +	__s16 slope;
> +};
> +
> +struct jh7110_isp_oecf_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_oecf_point r_curve[16];
> +	struct jh7110_isp_oecf_point gr_curve[16];
> +	struct jh7110_isp_oecf_point gb_curve[16];
> +	struct jh7110_isp_oecf_point b_curve[16];
> +};
> +
> +struct jh7110_isp_r2y_matrix {
> +	__s16 m[9];
> +};
> +
> +struct jh7110_isp_r2y_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_r2y_matrix matrix;
> +};
> +
> +struct jh7110_isp_sat_curve {
> +	__s16 yi_min;
> +	__s16 yo_ir;
> +	__s16 yo_min;
> +	__s16 yo_max;
> +};
> +
> +struct jh7110_isp_sat_hue_info {
> +	__s16 cos;
> +	__s16 sin;
> +};
> +
> +struct jh7110_isp_sat_info {
> +	__s16 gain_cmab;
> +	__s16 gain_cmmd;
> +	__s16 threshold_cmb;
> +	__s16 threshold_cmd;
> +	__s16 offset_u;
> +	__s16 offset_v;
> +	__s16 cmsf;
> +};
> +
> +struct jh7110_isp_sat_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_sat_curve curve;
> +	struct jh7110_isp_sat_hue_info hue_info;
> +	struct jh7110_isp_sat_info sat_info;
> +};
> +
> +struct jh7110_isp_sharp_weight {
> +	__u8 weight[15];
> +	__u32 recip_wei_sum;
> +};
> +
> +struct jh7110_isp_sharp_strength {
> +	__s16 diff[4];
> +	__s16 f[3];
> +	__s32 s[3];
> +};
> +
> +struct jh7110_isp_sharp_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_sharp_weight weight;
> +	struct jh7110_isp_sharp_strength strength;
> +	__s8 pdirf;
> +	__s8 ndirf;
> +};
> +
> +struct jh7110_isp_ycrv_curve {
> +	__s16 y[64];
> +};
> +
> +struct jh7110_isp_ycrv_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_ycrv_curve curve;
> +};
> +
> +struct jh7110_isp_sc_config {
> +	__u16 h_start;
> +	__u16 v_start;
> +	__u8 sw_width;
> +	__u8 sw_height;
> +	__u8 hperiod;
> +	__u8 hkeep;
> +	__u8 vperiod;
> +	__u8 vkeep;
> +};
> +
> +struct jh7110_isp_sc_af_config {
> +	__u8 es_hor_mode;
> +	__u8 es_sum_mode;
> +	__u8 hor_en;
> +	__u8 ver_en;
> +	__u8 es_ver_thr;
> +	__u16 es_hor_thr;
> +};
> +
> +struct jh7110_isp_sc_awb_ps {
> +	__u8 awb_ps_rl;
> +	__u8 awb_ps_ru;
> +	__u8 awb_ps_gl;
> +	__u8 awb_ps_gu;
> +	__u8 awb_ps_bl;
> +	__u8 awb_ps_bu;
> +	__u8 awb_ps_yl;
> +	__u8 awb_ps_yu;
> +	__u16 awb_ps_grl;
> +	__u16 awb_ps_gru;
> +	__u16 awb_ps_gbl;
> +	__u16 awb_ps_gbu;
> +	__u16 awb_ps_grbl;
> +	__u16 awb_ps_grbu;
> +};
> +
> +struct jh7110_isp_sc_awb_ws {
> +	__u8 awb_ws_rl;
> +	__u8 awb_ws_ru;
> +	__u8 awb_ws_grl;
> +	__u8 awb_ws_gru;
> +	__u8 awb_ws_gbl;
> +	__u8 awb_ws_gbu;
> +	__u8 awb_ws_bl;
> +	__u8 awb_ws_bu;
> +};
> +
> +struct jh7110_isp_sc_awb_point {
> +	__u16 intensity;
> +	__u8 weight;
> +};
> +
> +struct jh7110_isp_sc_awb_config {
> +	struct jh7110_isp_sc_awb_ps ws_ps_config;
> +	__u8 awb_ps_grb_ba;
> +	__u8 sel;
> +	struct jh7110_isp_sc_awb_ws ws_config;
> +	__u8 awb_cw[169];
> +	struct jh7110_isp_sc_awb_point pts[17];
> +};
> +
> +struct jh7110_isp_sc_setting {
> +	__u32 enabled;
> +	struct jh7110_isp_sc_config crop_config;
> +	struct jh7110_isp_sc_af_config af_config;
> +	struct jh7110_isp_sc_awb_config awb_config;
> +};
> +
> +#define JH7110_ISP_SC_FALG_INVALID		0x0
> +#define JH7110_ISP_SC_FALG_VALID		0xffff
> +
> +#pragma pack(1)
> +
> +struct jh7110_isp_sc_buffer {
> +	__u32 y_histogram[64];
> +	__u32 reserv0[33];
> +	__u32 bright_sc[4096];
> +	__u32 reserv1[96];
> +	__u32 ae_hist_y[128];
> +	__u32 reserv2[511];
> +	__u16 flag;
> +};
> +
> +#pragma pack()
> +
> +#endif
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 99c3f5e99da7..8078aa2cc3d4 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -215,6 +215,12 @@ enum v4l2_colorfx {
>   */
>  #define V4L2_CID_USER_THP7312_BASE		(V4L2_CID_USER_BASE + 0x11c0)
>  
> +/*
> + * The base for the JH7110 ISP driver controls.
> + * We reserve 32 controls for this driver.
> + */
> +#define V4L2_CID_USER_JH7110_ISP_BASE		(V4L2_CID_USER_BASE + 0x11e0)
> +
>  /* MPEG-class control IDs */
>  /* The MPEG controls are applicable to all codec controls
>   * and the 'MPEG' part of the define is historical */

-- 
Regards,

Laurent Pinchart
