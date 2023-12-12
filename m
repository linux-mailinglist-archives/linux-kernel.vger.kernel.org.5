Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192A380E6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346002AbjLLJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:02:18 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015DB7;
        Tue, 12 Dec 2023 01:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ddjLKHL1vzr3plG/hsog1qkUo/z9opT+f/zOvpha0b0=; b=ckhvibhNx3rj+A/PLp2vc5DNbK
        jiF8zjrZWeynfAyPZwDRBCY5r55GrKD0boJe8FBidYzsRKk2tsE0XhKNflEQbYkyBveCiwYqS+Nyb
        uz+qCCLfpLv8yM0k/mv2tllDQruerU2hyIgPYOaxfeeP1xv0CzCgDdtsfqf+cMcMos4p6x01oXGLB
        VvcJOb2RoTHS/IBuxUekM53z3xoglWSavV4ydsJWVo9ksLIDV7a+/TbSMiPj4JnKstK+R7BEvFKGT
        qBBIW2doUubPuskZLyyW/nSVQw4hX0oTtzwuTqh5czyVzVPhya1BBbxJHdQ42FY/bTk1AUZq9fRTC
        7QqrBmzQ==;
Received: from [102.213.205.115] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1rCyea-00CsVa-NY; Tue, 12 Dec 2023 10:02:12 +0100
Date:   Tue, 12 Dec 2023 08:01:59 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20231212090159.hshy6elwhgkkhuzb@mail.igalia.com>
References: <20231212110415.6f849fb4@canb.auug.org.au>
 <20231212140134.13ffafa8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212140134.13ffafa8@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 12 Dec 2023 11:04:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the amdgpu tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> > 
> > drivers/gpu/drm/drm_atomic_uapi.c:366:1: warning: 'drm_atomic_replace_property_blob_from_id' defined but not used [-Wunused-function]
> >   366 | drm_atomic_replace_property_blob_from_id(struct drm_device *dev,
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Introduced by commit
> > 
> >   1d2b049e4582 ("drm/drm_property: make replace_property_blob_from_id a DRM helper")
> 
> This became a build failure in the i386 defconfig build, so I applied
> the following patch for today.

Yes, I also noticed it yesterday when building amd-staging-drm-next.

Something went wrong when they applied this patch:
https://lore.kernel.org/amd-gfx/20231116195812.906115-3-mwen@igalia.com/
and your patch below is exactly the part of this patch ^ that is
missing.

In addition, only the first four patches of the series were applied.

Thanks,

Melissa

> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 12 Dec 2023 13:53:55 +1100
> Subject: [PATCH] drm: remove unused function drm_atomic_replace_property_blob_from_id()
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 42 -------------------------------
>  1 file changed, 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 70ddbb93e466..29d4940188d4 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -362,48 +362,6 @@ static s32 __user *get_out_fence_for_connector(struct drm_atomic_state *state,
>  	return fence_ptr;
>  }
>  
> -static int
> -drm_atomic_replace_property_blob_from_id(struct drm_device *dev,
> -					 struct drm_property_blob **blob,
> -					 uint64_t blob_id,
> -					 ssize_t expected_size,
> -					 ssize_t expected_elem_size,
> -					 bool *replaced)
> -{
> -	struct drm_property_blob *new_blob = NULL;
> -
> -	if (blob_id != 0) {
> -		new_blob = drm_property_lookup_blob(dev, blob_id);
> -		if (new_blob == NULL) {
> -			drm_dbg_atomic(dev,
> -				       "cannot find blob ID %llu\n", blob_id);
> -			return -EINVAL;
> -		}
> -
> -		if (expected_size > 0 &&
> -		    new_blob->length != expected_size) {
> -			drm_dbg_atomic(dev,
> -				       "[BLOB:%d] length %zu different from expected %zu\n",
> -				       new_blob->base.id, new_blob->length, expected_size);
> -			drm_property_blob_put(new_blob);
> -			return -EINVAL;
> -		}
> -		if (expected_elem_size > 0 &&
> -		    new_blob->length % expected_elem_size != 0) {
> -			drm_dbg_atomic(dev,
> -				       "[BLOB:%d] length %zu not divisible by element size %zu\n",
> -				       new_blob->base.id, new_blob->length, expected_elem_size);
> -			drm_property_blob_put(new_blob);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	*replaced |= drm_property_replace_blob(blob, new_blob);
> -	drm_property_blob_put(new_blob);
> -
> -	return 0;
> -}
> -
>  static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  		struct drm_crtc_state *state, struct drm_property *property,
>  		uint64_t val)
> -- 
> 2.40.1
> 
> -- 
> Cheers,
> Stephen Rothwell


