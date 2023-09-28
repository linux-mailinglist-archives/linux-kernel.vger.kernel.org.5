Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9717B1C08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjI1MT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjI1MTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:19:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87536193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:19:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 091AA6607258;
        Thu, 28 Sep 2023 13:19:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695903588;
        bh=FlxWm0KO/95SNT5YlRUVZt9iSvcyPyiN3E49R6C5oI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKI1xG+7fRFRRrjVsNsL1PE/UgVNPargbDyDTpeYOhqaQx0gqX9SdykZWHBgp/bmo
         wTu3SYPUp8sOGb/v6J9FuQNa5MGjgOzDvFawZ7TJi2u6YTI94CFx253rMlMWhYQgZg
         aQxYLZn+IoMCt3RW3iHMvJcRa7+sAeTCfRPFHf59Lh9vzB6R5i00GO7HnW0VCcmeEg
         ffuDvXoU6I+oKslkmWXpM7lh16u03wIcGeLMrVcD7IphfBJ1ivCg/Xb8l0c1n4jdFf
         CcGcOnTkY42oPENN84NdDb8vuHlhshqoa+hkCk94Rl+f7XmhS6oXgoseaQYNuh9UfC
         iIHF721Nnt/8w==
Date:   Thu, 28 Sep 2023 14:19:45 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v4 6/8] drm/gpuvm: add drm_gpuvm_flags to
 drm_gpuvm
Message-ID: <20230928141945.36dd44df@collabora.com>
In-Reply-To: <810dc476-8ead-19e6-23fc-0f9cf35ba2b2@redhat.com>
References: <20230920144343.64830-1-dakr@redhat.com>
        <20230920144343.64830-7-dakr@redhat.com>
        <20230922135842.242c865d@collabora.com>
        <810dc476-8ead-19e6-23fc-0f9cf35ba2b2@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 18:52:55 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> On 9/22/23 13:58, Boris Brezillon wrote:
> > On Wed, 20 Sep 2023 16:42:39 +0200
> > Danilo Krummrich <dakr@redhat.com> wrote:
> >   
> >> +/**
> >> + * enum drm_gpuvm_flags - flags for struct drm_gpuvm
> >> + */
> >> +enum drm_gpuvm_flags {
> >> +	/**
> >> +	 * @DRM_GPUVM_USERBITS: user defined bits
> >> +	 */
> >> +	DRM_GPUVM_USERBITS = (1 << 0),  
> > 
> > Nit: I tried declaring driver-specific flags, and I find this
> > counter-intuitive. You basically end up with something like:
> > 
> > enum my_gpuvm_flags {
> > 	MY_FLAG_X = DRM_GPUVM_USERBITS,
> > 	MY_FLAG_Y = DRM_GPUVM_USERBITS << 1,
> > };
> > 
> > instead of the usual
> > 
> > enum my_gpuvm_flags {
> > 	MY_FLAG_X = BIT(0),
> > 	MY_FLAG_Y = BIT(1),
> > };
> > 
> > pattern.  
> 
> Right, same as with dma_fence flags.
> 
> > 
> > Another issue I see coming is if we end up adding more core flags and
> > drivers start falling short of bits for their own flags. This makes me
> > wonder if we shouldn't kill this notion of USER flags and let drivers
> > store their flags in some dedicated field, given they're likely to
> > derive drm_gpuvm and drm_gpuva with their own object anyway.  
> 
> The only reason I have this in the code is that Xe asked for this with
> drm_gpuva_flags. Hence, for consistency reasons I added it for drm_gpuvm_flags
> too.

Yeah, my comment stands for both drm_gpuva_flags and drm_gpuvm_flags
actually.

> 
> Drivers can still have their own flag fields if needed, otherwise I guess it
> doesn't really hurt to keep DRM_GPUVM_USERBITS in case someone wants to use it.

Sure, it doesn't hurt, but given drivers are inheriting from this
object anyway, I thought it'd be simpler/more future proof to let them
have their flags in a separate field. It's not like we care about
saving 4 bytes in such a big object. Might be a bit different for
drm_gpuva given the amount of live mappings one VM might have, but even
there, I suspect the current drm_gpuva size is going to hurt if we have
millions of 4k mappings, so, four more bytes won't make a huge
difference...

Anyway, I don't think that's a blocker, I just thought I'd mention it,
that's all.
