Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85604772AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHGQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjHGQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED66172A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B29A061F2C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6163BC433C8;
        Mon,  7 Aug 2023 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691426036;
        bh=XgeQ5mSaWe8K6QwECsHe/esmDKTuPpjwcCuG5PrF2aA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OPyqeyqVIr68DswAS0TYjevUUCuhQAVJkjGbBek8e8l3hfB/D5EzUOh8HEVLMIePb
         q4cW7JFqaBcW95B/0Ofe1flROB+y6rS6dHLVLLV5yk+mkvNS8SvfomkcA8UiadUa4d
         AOAs8d0hgbT2d+grxxXzKUrmFOQSGY1fAFbJRSq+D2oylMt02Xo8KPOxO+Bssx6qQt
         Fan02QqfsVtBDeeE4zcVPxWDXu4QXGQ+6ljyH/4YZ7LGM3ppSgfBbMjkiAsn2L+jgS
         I7oEf0N6+mXHaw3nqsoZ+cHTbWmxA5LyqWadY89vkd1Jq6uAJvdYFfvmHnkgtgobM2
         7hSjYbv68xASQ==
Date:   Mon, 7 Aug 2023 09:33:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230807093354.184bc18b@kernel.org>
In-Reply-To: <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
        <20230802104706.5ce541e9@kernel.org>
        <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
        <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
        <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
        <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
        <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
        <ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
        <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
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

On Mon, 7 Aug 2023 10:30:34 +0000 Wei Fang wrote:
> ./xdp_rxq_info --dev eth0 --action XDP_TX
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       259,102     0
> XDP-RX CPU      total   259,102

> Result 2: dma_sync_len method
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       258,254     0
> XDP-RX CPU      total   258,254

Just to be clear are these number with xdp_return_frame() replaced
with page_pool_put_page(pool, page, 0, true); ?
