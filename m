Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219057830AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjHUTLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHUTLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDA131;
        Mon, 21 Aug 2023 12:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D47264308;
        Mon, 21 Aug 2023 19:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE71CC433C8;
        Mon, 21 Aug 2023 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692645106;
        bh=tZTj5WqKG4PuPPE9uJojWHeemIDDpr4Jegy1UrFRlG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/M8HPFXszauhN1P+TNuo35DmDK4vKS3lrIft5d2yqphF27iEpBIao4KyKeH/sU/p
         t/aFdSOtPeky7x6LrLY0p57YEqjK5FUChYpqNodbsA5KoM+5RZqf5iQ+DCWqTSr/2w
         VbIugdlyXn6pc0p08KN5X3caqIn9eJ7mvZdMw194=
Date:   Mon, 21 Aug 2023 21:11:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        stable-commits@vger.kernel.org, toke@redhat.com,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: Patch "xsk: Add cb area to struct xdp_buff_xsk" has been added
 to the 5.15-stable tree
Message-ID: <2023082113-nineteen-outbid-7008@gregkh>
References: <20230817150613.2298988-1-sashal@kernel.org>
 <CAJ+HfNhPE_+JJ_UYVtQj=m86Az05Lvo0Xcgdk=0uZ+6GPQmzLA@mail.gmail.com>
 <ZODePZM4H3ItVFWN@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZODePZM4H3ItVFWN@sashalap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 11:22:37AM -0400, Sasha Levin wrote:
> On Fri, Aug 18, 2023 at 03:52:21PM +0200, Björn Töpel wrote:
> > On Thu, 17 Aug 2023 at 17:06, Sasha Levin <sashal@kernel.org> wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     xsk: Add cb area to struct xdp_buff_xsk
> > > 
> > > to the 5.15-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      xsk-add-cb-area-to-struct-xdp_buff_xsk.patch
> > > and it can be found in the queue-5.15 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Sasha, I'm a bit out of the loop, but AFAIU this fix is aimed at
> > supporting XDP hints with AF_XDP ZC, which does not exist in 5.15.
> > IOW, it shouldn't be applied to 5.15.
> 
> Right, the patch does nothing on it's own - it's there just to address a
> context conflict with a later patch.

I don't see the context conflict here, so I'll drop this patch from the
queue.  Sasha, you might want to check your scripts here...

thanks,

greg k-h
