Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB197BA3C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbjJEP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjJEP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA964ED1;
        Thu,  5 Oct 2023 06:52:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58683C4AF6C;
        Thu,  5 Oct 2023 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696512998;
        bh=sVHgjs6j2i0PqaWsD1fHp1pWIXfooJQLvDVkOSizDRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9todMOzpojr4eNnVkY1o+43vbZ0Ou5vRXv4rFd2b8w/37BOQaJk97eggchBkCC19
         UN+L5Gt0jHx9w8YgUI8f3q2g5RX1WMn5gjL1VAiiBmtb+Db1CqxrN9OWsixX+8txSq
         gFs4hXcYCkba1IkaJLzxcNWyw2uWtAVsMjzOrD4AaAFBdqvL4FKmXzFadFQ+hZeOZ+
         uugzOSLPuZOosiCIKjjYUwsCefhTmGaNOi2ZpZ9O14Lwyj4YkwxDYm5s20+SNcTguT
         1+RpOLM2U2qshZExjYBnizARZvVb7AYTpDvPhPNVwS/hdZ5lmrf5vGLzy+0RMfxGwi
         II3IoEvqllq8g==
Date:   Thu, 5 Oct 2023 15:36:33 +0200
From:   Simon Horman <horms@kernel.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/1] ethtool: Fix mod state of verbose no_mask bitset
Message-ID: <ZR674ase11YwjvsG@kernel.org>
References: <20231003085653.3104411-1-kory.maincent@bootlin.com>
 <ZR1HYg2ElUjy2aud@kernel.org>
 <20231005100349.113f3bf1@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231005100349.113f3bf1@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:03:49AM +0200, Köry Maincent wrote:
> Hello Simon,
> 
> Thank for your review.
> 
> On Wed, 4 Oct 2023 13:07:14 +0200
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Tue, Oct 03, 2023 at 10:56:52AM +0200, Köry Maincent wrote:
> > > From: Kory Maincent <kory.maincent@bootlin.com>
> >
> > > @@ -448,8 +450,11 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned
> > > int nbits, }
> > >  
> > >  	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
> > > -	if (no_mask)
> > > -		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
> > > +	if (no_mask) {
> > > +		tmp = kcalloc(nbits, sizeof(u32), GFP_KERNEL);
> > > +		memcpy(tmp, bitmap, nbits);  
> > 
> > Hi Köry,
> > 
> > I'm no expert on etnhl bitmaps. But the above doesn't seem correct to me.
> > Given that sizeof(u32) == 4:
> > 
> > * The allocation is for nbits * 4 bytes
> > * The copy is for its for nbits bytes
> > * I believe that bitmap contains space for the value followed by a mask.
> >   So it seems to me the size of bitmap, in words, is
> >   DIV_ROUND_UP(nbits, 32) * 2
> >   And in bytes: DIV_ROUND_UP(nbits, 32) * 16
> >   But perhaps only half is needed if only the value part of tmp is used.
> > 
> > If I'm on the right track here I'd suggest helpers might be in order.
> 
> You are right I should use the same alloc as ethnl_update_bitset with tmp
> instead of bitmap32:
> 
>         u32 small_bitmap32[ETHNL_SMALL_BITMAP_WORDS];                      
>         u32 *bitmap32 = small_bitmap32; 
>         if (nbits > ETHNL_SMALL_BITMAP_BITS) {                             
>                 unsigned int dst_words = DIV_ROUND_UP(nbits, 32);          
>                                                                            
>                 bitmap32 = kmalloc_array(dst_words, sizeof(u32), GFP_KERNEL);
>                 if (!bitmap32)                                             
>                         return -ENOMEM;                                    
>         }   
> 
> But I am still wondering if it needs to be double as you said for the size of
> the value followed by the mask. Not sure about it, as ethnl_update_bitset does
> not do it. 

If you only need the value, then I don' think you need to x2 the allocation.
But I could be wrong.
