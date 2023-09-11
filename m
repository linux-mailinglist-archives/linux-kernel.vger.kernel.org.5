Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15979A319
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjIKF7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIKF7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:59:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBBE99
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 22:59:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A91C433C7;
        Mon, 11 Sep 2023 05:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694411948;
        bh=B8Vq3s3zLZ5kinugqWHBytFTAsXlj+fKFaC7+H06OCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2fIw7XyJd/cC0NQEyup6+kZ4jMZo3hUbwonUy8Ikpw4PggZTizIc5j72meB9nqx5
         ZUtKavKw/jaUf6UQ8XtXSiCCszk4bMEUoWULxPw2wmWeNGdTVAoozdPtnQ8o+fZJg0
         Ayu+5M35gU3xNj3ufA7cq940H2FgOYIbUBxCh2332JK2RdHJF8eDoc81feiqK1dQtV
         sCFUZqPjDabJPrD6BBrYSJCGD9ft2u8HS261fihL3iDEA8jd4JlTbXdYnNCdvjTvvK
         5gxhgrorofBh/XfAJpjyRUWQV84Dv2H1S4nIzKcNswZQg1oU4UwGBQjCCueSd9q9jp
         gzsDfm9IM2j3Q==
Date:   Mon, 11 Sep 2023 07:59:04 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
Message-ID: <20230911055904.GN775887@kernel.org>
References: <20230908235853.1319596-1-jeremy@jcline.org>
 <20230910152812.GJ775887@kernel.org>
 <ZP5L6/zF6fE+ogbz@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP5L6/zF6fE+ogbz@dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 07:06:19PM -0400, Jeremy Cline wrote:
> On Sun, Sep 10, 2023 at 05:28:12PM +0200, Simon Horman wrote:
> > On Fri, Sep 08, 2023 at 07:58:53PM -0400, Jeremy Cline wrote:
> > > The device list needs its associated lock held when modifying it, or the
> > > list could become corrupted, as syzbot discovered.
> > > 
> > > Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> > > Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> > 
> > Hi Jeremy,
> > 
> > thanks for your patch.
> > 
> > I don't think you need to resubmit for this,
> > I think this patch warrants a fixes tag:
> > 
> > Fixes: d646960f7986 ("NFC: Initial LLCP support")
> > 
> 
> My bad, indeed. The lock in question looks to have been added in
> 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
> nfc_llcp_find_local") which itself includes a couple fix tags, should
> this reference that commit instead as it won't backport without that
> one?

Yes, I think that is likely.
Sorry for not noticing that.

> > Otherwise, this looks good to me.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> 
> Thanks,
> Jeremy
> 
