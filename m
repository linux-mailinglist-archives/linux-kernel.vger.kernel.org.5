Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1932C7B8D43
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbjJDTUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbjJDTUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:20:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1DE98
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:20:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4041AC433C7;
        Wed,  4 Oct 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696447217;
        bh=Z6f+ph1QyRpOMr1kPPcopjUoPxOl0nIiVIhrZ8RuMUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F+CFVr0vgd5vx17Trp5BZsr4W0E05tuw8MXQbIFJKMC/eYOwsExwe1aJMSGpItffo
         ymd1V8eFZa1plyKPBblOYSuK7IrDNJn53rHRHxD6voYsauAOCz7SvIiBhpuH60hyCf
         obsTqdBwhTfnMK9oAALcn1zWPuWkEkcQ8fxbkchWuabo4w/Rk2EKBidR0fP0hKzv+c
         lUKAtery5Yp1Yhywv86wkt52UHyfO8ZjIQBnRmJY93TLlgG3gn6bDgYEey+X9R3PYx
         dsVewleJRNNSX2F6+xt0V/i/0dcq37Ji9+oBIEitfFFzRAoVv4bEelNVBROe0lM68o
         OZ5UQs/RK8/8g==
Date:   Wed, 4 Oct 2023 12:20:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew@lunn.ch>
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Message-ID: <20231004122016.76b403f0@kernel.org>
In-Reply-To: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 16:46:23 +0530 Vishvambar Panth S wrote:
> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
> device supports placing the descriptors in memory back to back or
> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
> configurable hardware setting. Currently DSPACE is unnecessarily set to
> match the host's L1 cache line size, resulting in space reserved in
> between descriptors in most platforms and causing a suboptimal behavior
> (single PCIe Mem transaction per descriptor). By changing the setting
> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
> transaction resulting in a massive performance improvement in
> bidirectional tests without any negative effects.
> Tested and verified improvements on x64 PC and several ARM platforms
> (typical data below)

Nobody complained for 5 years, and it's not a regression.
Let's not treat this as a fix, please repost without the Fixes tag for
net-next.
-- 
pw-bot: cr
