Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6178138CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444082AbjLNRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNRi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:38:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B6710E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:39:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB98BC433C7;
        Thu, 14 Dec 2023 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702575541;
        bh=V/fbxsK7q1OnjNdRchrl8etLwYN7DQR4SahFULXkoe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PN906fd563Q8HLlx91Hl7Dq4NFroiwUoyofjLvvPbk2wF8OvvtszM8A/AK2ycUTu9
         BCGTLKaNEXbHvuKgeDjkYKLjeKmpeUiBOWK96sZbof20gqWp6ViVkE34qDhIr57LYd
         PfDssee2KM5WkvGXQ4xbH5nLcyFE66ZPnBYXx9JW+LPGbdE3WoUAqQNRPKfOXQiWZG
         obXvXu919sT/jBR2ZQdEqZJDo5bK8UTvY1E6dG/ur1BvAt9Tg2/tm1oMTfGfZAAg8I
         WzpZqyvZrb+/Vn+1TFd3opBt6eFsiLJW6N7lQLYtAnKJEVIFjn0gui03KHzZNyWM0b
         aBgPhDFE2qA5g==
Date:   Thu, 14 Dec 2023 09:38:59 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <20231214093859.01f6e2cd@kernel.org>
In-Reply-To: <3d025aeb-7766-4148-b2fd-01ec3653b4a7@kernel.dk>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
        <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
        <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
        <20231213162854.4acfbd9f@kernel.org>
        <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
        <3d025aeb-7766-4148-b2fd-01ec3653b4a7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 09:57:32 -0700 Jens Axboe wrote:
> On 12/14/23 3:50 AM, Christian Brauner wrote:
> >> Let's figure that out before we get another repost.  
> > 
> > I'm just waiting for Jens to review it as he had comments on this
> > before.  
> 
> Well, I do wish the CC list had been setup a bit more deliberately.
> Especially as this is a resend, and I didn't even know about any of this
> before Christian pointed me this way the other day.
> 
> Checking lore, I can't even see all the patches. So while it may be
> annoying, I do think it may be a good idea to resend the series so I can
> take a closer look as well.

So to summarize - for the repost please make sure to CC Jens,
Christian, Al, linux-fsdevel@vger.kernel.org on *all* patches.

No need to add "net" to subject prefix, or CC net on all.

> I do think it's interesting and I'd love to
> have it work in a non-blocking fashion, both solving the issue of splice
> holding the pipe lock while doing IO, and also then being able to
> eliminate the pipe_clear_nowait() hack hopefully.
