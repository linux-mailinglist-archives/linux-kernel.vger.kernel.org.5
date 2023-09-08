Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364C7988E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbjIHOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjIHOfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:35:48 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB861BEE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KhangHqvifzsEmrU/jafDlCuZhalHpNTZ2BYg95hJmg=; b=ix0N7KiqUqtc7Vy3wXgBLQgdTe
        UqQ+5O4MJGXwxfxWwg7t0y3BBZ3yQXdBoOArASHDG0Z1U35gY4q/JjjpdZaT3aSbjYNBLwG+hvq7u
        +jq5bWLk1q86bGKvJPgWWlSrmC+hErrD/kvKZrilDMgWuYY0y6p4JDlurVzHi/GT+mFijHbnxWZSs
        O4k9ateSk/Z0HEL2qxRep8+/5Kt1B+KUgkUFnxQJdSc0jeKZ669RxiafnR8MCFVTLGgDb9exjTGWi
        6Rj4G0dOHuhW1ru/4E5ZiiOiYTppAGsb2cv2uXReFvt/5ROvZI5VHrpykuiG/ZD/jV/Uy40d38K9/
        t1JQkkPA==;
Received: from [38.44.68.151] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qecDd-001Oqj-VU; Fri, 08 Sep 2023 16:12:21 +0200
Date:   Fri, 8 Sep 2023 13:11:59 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Simon Ser <contact@emersion.fr>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/34] drm/amd/display: fix segment distribution for
 linear LUTs
Message-ID: <20230908141159.6hfne5r7hxi6bycs@mail.igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
 <20230810160314.48225-2-mwen@igalia.com>
 <7e11c23d-2824-4f32-b863-13cc631a6d40@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e11c23d-2824-4f32-b863-13cc631a6d40@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06, Harry Wentland wrote:
> On 2023-08-10 12:02, Melissa Wen wrote:
> > From: Harry Wentland <harry.wentland@amd.com>
> > 
> > The region and segment calculation was incapable of dealing
> > with regions of more than 16 segments. We first fix this.
> > 
> > Now that we can support regions up to 256 elements we can
> > define a better segment distribution for near-linear LUTs
> > for our maximum of 256 HW-supported points.
> > 
> > With these changes an "identity" LUT looks visually
> > indistinguishable from bypass and allows us to use
> > our 3DLUT.
> > 
> 
> Have you had a chance to test whether this patch makes a
> difference? I haven't had the time yet.

Last time I tested there was a banding issue on plane shaper LUT PQ ->
Display Native, but it seems I don't have this use case on tester
anymore, so I wasn't able to double-check if the issue persist. Maybe
Joshua can provide some inputs here.

Something I noticed is that shaper LUTs are the only 1D LUT on DCN30
pipeline that uses cm_helper_translate_curve_to_hw_format(), all others
(dpp-degamma/dpp-blend/mpc-regamma) call cm3_helper_translate_curve_*.

We can drop it from this series until we get the steps to report the
issue properly.

Melissa

> 
> Harry
> 
> > Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > ---
> >  .../amd/display/dc/dcn10/dcn10_cm_common.c    | 93 +++++++++++++++----
> >  1 file changed, 75 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> > index 3538973bd0c6..04b2e04b68f3 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> > @@ -349,20 +349,37 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
> >  		 * segment is from 2^-10 to 2^1
> >  		 * There are less than 256 points, for optimization
> >  		 */
> > -		seg_distr[0] = 3;
> > -		seg_distr[1] = 4;
> > -		seg_distr[2] = 4;
> > -		seg_distr[3] = 4;
> > -		seg_distr[4] = 4;
> > -		seg_distr[5] = 4;
> > -		seg_distr[6] = 4;
> > -		seg_distr[7] = 4;
> > -		seg_distr[8] = 4;
> > -		seg_distr[9] = 4;
> > -		seg_distr[10] = 1;
> > +		if (output_tf->tf == TRANSFER_FUNCTION_LINEAR) {
> > +			seg_distr[0] = 0; /* 2 */
> > +			seg_distr[1] = 1; /* 4 */
> > +			seg_distr[2] = 2; /* 4 */
> > +			seg_distr[3] = 3; /* 8 */
> > +			seg_distr[4] = 4; /* 16 */
> > +			seg_distr[5] = 5; /* 32 */
> > +			seg_distr[6] = 6; /* 64 */
> > +			seg_distr[7] = 7; /* 128 */
> > +
> > +			region_start = -8;
> > +			region_end = 1;
> > +		} else {
> > +			seg_distr[0] = 3; /* 8 */
> > +			seg_distr[1] = 4; /* 16 */
> > +			seg_distr[2] = 4;
> > +			seg_distr[3] = 4;
> > +			seg_distr[4] = 4;
> > +			seg_distr[5] = 4;
> > +			seg_distr[6] = 4;
> > +			seg_distr[7] = 4;
> > +			seg_distr[8] = 4;
> > +			seg_distr[9] = 4;
> > +			seg_distr[10] = 1; /* 2 */
> > +			/* total = 8*16 + 8 + 64 + 2 = */
> > +
> > +			region_start = -10;
> > +			region_end = 1;
> > +		}
> > +
> >  
> > -		region_start = -10;
> > -		region_end = 1;
> >  	}
> >  
> >  	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
> > @@ -375,16 +392,56 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
> >  
> >  	j = 0;
> >  	for (k = 0; k < (region_end - region_start); k++) {
> > -		increment = NUMBER_SW_SEGMENTS / (1 << seg_distr[k]);
> > +		/*
> > +		 * We're using an ugly-ish hack here. Our HW allows for
> > +		 * 256 segments per region but SW_SEGMENTS is 16.
> > +		 * SW_SEGMENTS has some undocumented relationship to
> > +		 * the number of points in the tf_pts struct, which
> > +		 * is 512, unlike what's suggested TRANSFER_FUNC_POINTS.
> > +		 *
> > +		 * In order to work past this dilemma we'll scale our
> > +		 * increment by (1 << 4) and then do the inverse (1 >> 4)
> > +		 * when accessing the elements in tf_pts.
> > +		 *
> > +		 * TODO: find a better way using SW_SEGMENTS and
> > +		 *       TRANSFER_FUNC_POINTS definitions
> > +		 */
> > +		increment = (NUMBER_SW_SEGMENTS << 4) / (1 << seg_distr[k]);
> >  		start_index = (region_start + k + MAX_LOW_POINT) *
> >  				NUMBER_SW_SEGMENTS;
> > -		for (i = start_index; i < start_index + NUMBER_SW_SEGMENTS;
> > +		for (i = (start_index << 4); i < (start_index << 4) + (NUMBER_SW_SEGMENTS << 4);
> >  				i += increment) {
> > +			struct fixed31_32 in_plus_one, in;
> > +			struct fixed31_32 value, red_value, green_value, blue_value;
> > +			uint32_t t = i & 0xf;
> > +
> >  			if (j == hw_points - 1)
> >  				break;
> > -			rgb_resulted[j].red = output_tf->tf_pts.red[i];
> > -			rgb_resulted[j].green = output_tf->tf_pts.green[i];
> > -			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
> > +
> > +			in_plus_one = output_tf->tf_pts.red[(i >> 4) + 1];
> > +			in = output_tf->tf_pts.red[i >> 4];
> > +			value = dc_fixpt_sub(in_plus_one, in);
> > +			value = dc_fixpt_shr(dc_fixpt_mul_int(value, t),  4);
> > +			value = dc_fixpt_add(in, value);
> > +			red_value = value;
> > +
> > +			in_plus_one = output_tf->tf_pts.green[(i >> 4) + 1];
> > +			in = output_tf->tf_pts.green[i >> 4];
> > +			value = dc_fixpt_sub(in_plus_one, in);
> > +			value = dc_fixpt_shr(dc_fixpt_mul_int(value, t),  4);
> > +			value = dc_fixpt_add(in, value);
> > +			green_value = value;
> > +
> > +			in_plus_one = output_tf->tf_pts.blue[(i >> 4) + 1];
> > +			in = output_tf->tf_pts.blue[i >> 4];
> > +			value = dc_fixpt_sub(in_plus_one, in);
> > +			value = dc_fixpt_shr(dc_fixpt_mul_int(value, t),  4);
> > +			value = dc_fixpt_add(in, value);
> > +			blue_value = value;
> > +
> > +			rgb_resulted[j].red = red_value;
> > +			rgb_resulted[j].green = green_value;
> > +			rgb_resulted[j].blue = blue_value;
> >  			j++;
> >  		}
> >  	}
> 
