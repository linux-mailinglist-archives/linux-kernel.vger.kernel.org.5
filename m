Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929527840D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjHVMaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjHVMai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:30:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14048196
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:30:36 -0700 (PDT)
Received: from eldfell (unknown [194.136.85.206])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pq)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDF55660719F;
        Tue, 22 Aug 2023 13:30:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692707434;
        bh=oNXg14QTGldQn4AW/OL7kuoHvS8kbgMdZugnQGXt5Ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l2hodroAMJqLpz1kvDROGH0NHn11H2gEMk+iP7QH870b6mui3W7o2AuJC//Pzp0v/
         u86o89Ayk+HV5fq4ozkvzjzKCkZ7hQOLz9YRB3SLR//WjUJabVLAOca0EYMAyGm/18
         V/uq1iPk1STNSgsOWUu3t428TCl2J7duuFmexi0rNWO9IjOQUGMAvlNx8dHqocf7FO
         NHOot6pvi5llznunluUUj4jF0PB6qsU77teV0Z4VxdSpIi4IazdQ7+G02uqN7EJkOB
         BI7H2q2NkhT2AvNV4yCoA5jxPbqkBNaiimfIE7YnV7qTwpNt6+aSpi0fm+4PPfW5jS
         lMbOR5XtK6LCg==
Date:   Tue, 22 Aug 2023 15:30:30 +0300
From:   Pekka Paalanen <pekka.paalanen@collabora.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
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
        Simon Ser <contact@emersion.fr>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/34] drm/amd/display: set stream gamut remap matrix
 to MPC for DCN301
Message-ID: <20230822153030.4d410ff9.pekka.paalanen@collabora.com>
In-Reply-To: <20230810160314.48225-32-mwen@igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
        <20230810160314.48225-32-mwen@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 15:03:11 -0100
Melissa Wen <mwen@igalia.com> wrote:

> dc->caps.color.mpc.gamut_remap says there is a post-blending color block
> for gamut remap matrix for DCN3 HW family and newer versions. However,
> those drivers still follow DCN10 programming that remap stream
> gamut_remap_matrix to DPP (pre-blending).

That's ok only as long as CRTC degamma is pass-through. Blending itself
is a linear operation, so it doesn't matter if a matrix is applied to
the blending result or to all blending inputs. But you cannot move a
matrix operation to the other side of a non-linear operation, and you
cannot move a non-linear operation across blending.


Thanks,
pq

> To enable pre-blending and post-blending gamut_remap matrix supports at
> the same time, set stream gamut_remap to MPC and plane gamut_remap to
> DPP for DCN301 that support both.
> 
> It was tested using IGT KMS color tests for DRM CRTC CTM property and it
> preserves test results.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 37 +++++++++++++++++++
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  3 ++
>  .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +-
>  3 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index 4cd4ae07d73d..4fb4e9ec03f1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -186,6 +186,43 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
>  	return result;
>  }
>  
> +void dcn30_program_gamut_remap(struct pipe_ctx *pipe_ctx)
> +{
> +	int i = 0;
> +	struct dpp_grph_csc_adjustment dpp_adjust;
> +	struct mpc_grph_gamut_adjustment mpc_adjust;
> +	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
> +	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
> +
> +	memset(&dpp_adjust, 0, sizeof(dpp_adjust));
> +	dpp_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
> +
> +	if (pipe_ctx->plane_state &&
> +	    pipe_ctx->plane_state->gamut_remap_matrix.enable_remap == true) {
> +		dpp_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
> +		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
> +			dpp_adjust.temperature_matrix[i] =
> +				pipe_ctx->plane_state->gamut_remap_matrix.matrix[i];
> +	}
> +
> +	pipe_ctx->plane_res.dpp->funcs->dpp_set_gamut_remap(pipe_ctx->plane_res.dpp,
> +							    &dpp_adjust);
> +
> +	memset(&mpc_adjust, 0, sizeof(mpc_adjust));
> +	mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
> +
> +	if (pipe_ctx->top_pipe == NULL) {
> +		if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
> +			mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
> +			for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
> +				mpc_adjust.temperature_matrix[i] =
> +					pipe_ctx->stream->gamut_remap_matrix.matrix[i];
> +		}
> +	}
> +
> +	mpc->funcs->set_gamut_remap(mpc, mpcc_id, &mpc_adjust);
> +}
> +
>  bool dcn30_set_output_transfer_func(struct dc *dc,
>  				struct pipe_ctx *pipe_ctx,
>  				const struct dc_stream_state *stream)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> index a24a8e33a3d2..cb34ca932a5f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> @@ -58,6 +58,9 @@ bool dcn30_set_blend_lut(struct pipe_ctx *pipe_ctx,
>  bool dcn30_set_input_transfer_func(struct dc *dc,
>  				struct pipe_ctx *pipe_ctx,
>  				const struct dc_plane_state *plane_state);
> +
> +void dcn30_program_gamut_remap(struct pipe_ctx *pipe_ctx);
> +
>  bool dcn30_set_output_transfer_func(struct dc *dc,
>  				struct pipe_ctx *pipe_ctx,
>  				const struct dc_stream_state *stream);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> index 257df8660b4c..81fd50ee97c3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> @@ -33,7 +33,7 @@
>  #include "dcn301_init.h"
>  
>  static const struct hw_sequencer_funcs dcn301_funcs = {
> -	.program_gamut_remap = dcn10_program_gamut_remap,
> +	.program_gamut_remap = dcn30_program_gamut_remap,
>  	.init_hw = dcn10_init_hw,
>  	.power_down_on_boot = dcn10_power_down_on_boot,
>  	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,

