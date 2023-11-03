Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862187DFD6B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjKCAHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKCAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:07:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A194182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:07:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C87C433C9;
        Fri,  3 Nov 2023 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698970050;
        bh=5a8zs5Wr97PqvTIeegitAQv79m9E32DrziZ/OhWxb6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzXFfYz/gbLo32NGREz8LG3QPUuTcAxdJuuySWpfPOBaLqOE6KMkJP4xN1dCqK1Cd
         ODC41L7Wg7XBvKP4Y+PRBEPQoMO7nw/Qk14p+ukSZIPZhx3w9iMhDvAx+O9WhTqvfY
         kaJgyh13A8AVaN6mog4MvqIymVKv9RfScPAqaM1relycZlxN24cAG5Bq7cy4PQ5zou
         aTW5ibbmsrIlUK6q3Imc5tPe5yTk+fiGuInTckvYB1pmdpTxaKnulaovTCiPbog3NT
         VIrZwz948ohOKXJDqFgReRXl/fsCzw5FNg3qWg+bOwb6zudb8YlthwBLcmp0tkKCh5
         rvLQpA3ij7ltA==
Date:   Fri, 3 Nov 2023 01:07:23 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     chentao <chentao@kylinos.cn>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@gmail.com, daniel@ffwll.ch, andi.shyti@linux.intel.com,
        robdclark@chromium.org, jonathan.cavitt@intel.com,
        andrzej.hajda@intel.com, chris.p.wilson@intel.com,
        alan.previn.teres.alexis@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com
Subject: Re: [PATCH] drm/i915: Fix potential spectre vulnerability
Message-ID: <20231103000723.e3lylefy46lf5zcm@zenone.zhora.eu>
References: <20231102101642.52988-1-chentao@kylinos.cn>
 <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 02, 2023 at 11:32:43AM +0000, Tvrtko Ursulin wrote:
> On 02/11/2023 10:16, chentao wrote:
> > Fix smatch warning:
> > drivers/gpu/drm/i915/gem/i915_gem_context.c:847 set_proto_ctx_sseu()
> > warn: potential spectre issue 'pc->user_engines' [r] (local cap)
> > 
> > Signed-off-by: chentao <chentao@kylinos.cn>
> 
> I don't know if this is actually exploitable given the time deltas between the index is read from userspace and acted upon here, which is at least two ioctls apart. But I suppose no harm in fixing and for safety so we need to add:
> 
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Cc: <stable@vger.kernel.org> # v5.15+

Is this a real fix? I don't mind adding it, though.

> > ---
> >   drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> > index 9a9ff84c90d7..b2fdfc7ca4de 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> > @@ -843,7 +843,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
> >   		if (idx >= pc->num_user_engines)
> >   			return -EINVAL;
> > -
> 
> Just please refrain from random whitespace modifications like this blank line removal. If you resend without that you can add my r-b.
> 
> Regards,
> 
> Tvrtko
> 
> > +		idx = array_index_nospec(idx, pc->num_user_engines);

idx has been assigned earlier, can we make it one single
assignment at the declaration?

Andi
