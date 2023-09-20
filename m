Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614447A8AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjITR3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjITR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:29:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3ECCC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:29:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-276b9d5ce1dso1197069a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695230977; x=1695835777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2kSqjbE4R4s9y9PfagLdxTPyk6OQBps7KGlApfLIXc=;
        b=xWFL8w1eAEZjW21bAvLu0Nie13OTsSvGPe5U0ge3uyfcB3WN8LVXh7KFNnwEHs85rH
         8VnTaU9ivhsjea6qpxL90yKYBin6rI0oGADVpH7hoz+GSl0enPWQPOXqs9KQgI3PNIoz
         6/wtaJK0lcgEtVQowL8RnzEuYTGzqoVhEssJHr1xmtZven3pBpplZ1UARkTzo5wzEvYT
         xMILRhi78w4+4xKxeL2YMPbglhkY1z5BguGzB7kaFWP9mIkd7ELVkSOL3O/evLxNrjeZ
         hT8j2CgQw5qXl/1kYtqoUzrV2NqkVG3N+Tx9G+A17NENVQvaj6ifTTz6TIf615sApxYK
         1hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230977; x=1695835777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2kSqjbE4R4s9y9PfagLdxTPyk6OQBps7KGlApfLIXc=;
        b=pYBZ6RKfvxSiRqTVXoCawBTVdL07JzUEZWH9B6d03joeQ2Q9/NffXOeoVU4jBaiC9I
         XsdYc0cK5HaD17dkEcCaejDfHQqghVoBBDI0TCw4eIUBE4JGvyQbOkKXqoG3boIJNd/J
         TvoAcPTd7z1vCew1zFZpUpYZTtiP985Dv4J8d0vkvMfMkeYtvOnPsEGPhU/lEqefnpxt
         lHPo1NralyyiORN3q9OY9VOOQ/537h1eXVPI2gKh1yoMieHNbBywnfFLGrcryhMQhjLy
         XHwtYB8tm5gI5cDp+HrBmcbSXcPEUPR0o2pXchqO3PErmsOCWLv84B9ADGuC9kk6FspI
         Nu2g==
X-Gm-Message-State: AOJu0YwV4XFM4KxkeMn49SoPj+6MFUtajHYXN0qAwnFtFhFC2uBhjBZ1
        2ncbBvNPNmft+59SUTPT7AkLZQ==
X-Google-Smtp-Source: AGHT+IENxeIO9GsbP5Nbf4A5wYx4U8iUO+I6y0wMlt3QBuQ04m3lMwzoskKgzx6T3xCx7qIkJBoaEQ==
X-Received: by 2002:a17:90b:1b03:b0:26b:4ce1:9705 with SMTP id nu3-20020a17090b1b0300b0026b4ce19705mr3390551pjb.38.1695230977427;
        Wed, 20 Sep 2023 10:29:37 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id oj15-20020a17090b4d8f00b0026b3ed37ddcsm1591518pjb.32.2023.09.20.10.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:29:37 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:29:34 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Mirko Lindner <mlindner@marvell.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: include/linux/dma-mapping.h:416:36: warning: array subscript i
 is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'}
Message-ID: <20230920102934.595b755f@hermes.local>
In-Reply-To: <202309200904.CEED70DA33@keescook>
References: <202309191958.UBw1cjXk-lkp@intel.com>
        <202309200904.CEED70DA33@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 09:09:33 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Sep 19, 2023 at 07:27:26PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   2cf0f715623872823a72e451243bbf555d10d032
> > commit: df8fc4e934c12b906d08050d7779f292b9c5c6b5 kbuild: Enable -fstrict-flex-arrays=3
> > date:   4 months ago
> > config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230919/202309191958.UBw1cjXk-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309191958.UBw1cjXk-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    In file included from include/linux/skbuff.h:28,
> >                     from include/net/net_namespace.h:43,
> >                     from include/linux/netdevice.h:38,
> >                     from drivers/net/ethernet/marvell/sky2.c:18:
> >    drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':  
> > >> include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]  
> >      416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
> >          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
> >     1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
> >          |                 ^~~~~~~~~~~~~~
> >    In file included from drivers/net/ethernet/marvell/sky2.c:41:
> >    drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
> >     2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
> >          |                         ^~~~~~~~~  
> 
> The .config has:
> CONFIG_PAGE_SIZE_16KB=y
> which makes PAGE_SHIFT == 14
> 
> #ifdef CONFIG_PAGE_SIZE_16KB
> #define PAGE_SHIFT      14
> 
> ETH_JUMBO_MTU is:
> 
> #define ETH_JUMBO_MTU	9000
> 
> which forces "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0.
> 
> I think the right fix would be:
> 
> dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1]
> 
> Thoughts?
> 
> -Kees
> 

This is old driver, I don't have the HW anymore, it went to Free Geek.
Most of this code was based off of code in other drivers.

The assumption is that the first part of the data will be received in the
skb itself, then pages are used for overflow.

static unsigned sky2_get_rx_data_size(struct sky2_port *sky2)
{
	struct rx_ring_info *re;
	unsigned size;

	/* Space needed for frame data + headers rounded up */
	size = roundup(sky2->netdev->mtu + ETH_HLEN + VLAN_HLEN, 8);

	sky2->rx_nfrags = size >> PAGE_SHIFT;
	BUG_ON(sky2->rx_nfrags > ARRAY_SIZE(re->frag_addr));

Assuming PAGE_SIZE of 16k and MTU of 9000.

	size = roundup(9000 + 14 + 4, 8) => 9024
	sky2->rx_nfrags = 9024 >> 14 = 0

Which means no skb frags will be used.

This is probably suboptimal since it will endup calling alloc_skb()
to get a 9024 skb. Which in turn causes a call to kmalloc() of 9024.

Not really worth fixing if not testable.

