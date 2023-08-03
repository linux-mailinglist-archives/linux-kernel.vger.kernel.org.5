Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D676DD0C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHCBNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCBNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756351734
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B07B61B9D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB84C433C7;
        Thu,  3 Aug 2023 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691025223;
        bh=jJx5NlEJLKyCLwr9/8OEo0e98eJF2aZClaXFa4XHZvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GWVryhR3cegQIPZhi4pK8Wuh6eHGmQcVEeM4jHapXb9w7SxMPpJEu6Y20Ck183RUt
         oxSG7VZi4zjgVgkLIxsybbtuZW1vGO5CQeDswiSGF3TBSg+VosYb6v6xncy471vtYO
         pYxy4g0Bq8D7RNaBazOAxaiCxCaLNqXgE07blEzLW+jWqC5sIS/M/G96XAzJF4tVPP
         d6ahZZfn635h7/qo3DoTQzFAcbfyr+/LGPkLRX0NwFQreRKW0OkviGcvydGxWTi0fT
         dD9TQbAFfLdE8l1tgMsTAK9LDfMz5673bs7cvexCTG15Cug5AaIUa8Y84GdXujEKtv
         AkJDIprE3G8VQ==
Date:   Wed, 2 Aug 2023 18:13:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
Message-ID: <20230802181341.14cb2e4b@kernel.org>
In-Reply-To: <18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
References: <20230802105227.3691713-1-rkannoth@marvell.com>
        <18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 18:11:35 +0200 Alexander Lobakin wrote:
> > -	ring->rx_max_pending = Q_COUNT(Q_SIZE_MAX);
> > +	ring->rx_max_pending = 16384; /* Page pool support on RX */  
> 
> This is very hardcodish. Why not limit the Page Pool size when creating
> instead? It's perfectly fine to have a queue with 64k descriptors and a
> Page Pool with only ("only" :D) 16k elements.
> Page Pool size affects only the size of the embedded ptr_ring, which is
> used for indirect (locking) recycling. I would even recommend to not go
> past 2k for PP sizes, it makes no sense and only consumes memory.

Should we make the page pool cap the size at 32k then, instead of
having drivers do the gymnastics? I don't see what else the driver
can do, other than cap :S
-- 
pw-bot: cr
