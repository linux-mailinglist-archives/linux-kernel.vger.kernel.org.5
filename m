Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2C7CD107
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJQXtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJQXtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:49:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5B98
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:49:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9EC433C8;
        Tue, 17 Oct 2023 23:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697586556;
        bh=MexSOo1RTu4wqGyRDUVunJf4jvcyJayGmORQAzJv3BI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TmosqRnw6eYeeXCKHLlI4Ha9QwUDZ0FCf/QHS5J6lcI3sc5Qt7K1S8XD+tg5oYavu
         gFfkFP7t71Sh88xpMOHcpb3Uq5JXj9z32qjyQbrvOWqD9druQj25COP9M6ZkNXDPWn
         WVN3HYot/sNCESgGIzNowAg286q6+rt9zWRsVde5jkgytaogrlkv7hZUuzjrdwJvWo
         y5tnaWZjkx9p4piM7Vsd2337+EaWGvlFO9RXh6RK8EjIYi4j3BrGwUcVENL7pmr4Ib
         CGs2cokr8yjW/G7KuHnSWsg54rwvE+vteaojzMqlpVGbkMYPdszV+qgtV7I94zQCBL
         yyUPTor2FuwLA==
Date:   Tue, 17 Oct 2023 16:49:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     takeru hayasaka <hayatake396@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231017164915.23757eed@kernel.org>
In-Reply-To: <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
References: <20231012060115.107183-1-hayatake396@gmail.com>
        <20231016152343.1fc7c7be@kernel.org>
        <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
        <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
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

On Tue, 17 Oct 2023 23:37:57 +0900 takeru hayasaka wrote:
> > Are there really deployments where the *very limited* GTP-C control  
> I also think that it should not be limited to GTP-C. However, as I
> wrote in the email earlier, all the flows written are different in
> packet structure, including GTP-C. In the semantics of ethtool, I
> thought it was correct to pass a fixed packet structure and the
> controllable parameters for it. At least, the Intel ice driver that I
> modified is already like that.

I may be wrong (this API predates my involvement in Linux by a decade)
but I think that the current ethtool API is not all that precise in
terms of exact packet headers.

For example the TCPv6 flow includes IPv6 and TCP headers, but the
packet may or may not have any number of encapsulation headers in place.
VLAN, VXLAN, GENEVE etc. If the NIC can parse them - it will extract
the inner-most IPv6 and TCP src/dst and hash on that.

In a way TCP or IP headers may also differ by e.g. including options.
But as long as the fields we care about (source / dst) are in place,
we treat all variants of the header the same.

The question really is how much we should extend this sort of thinking
to GTP and say - we treat all GTP flows with extractable TEID the same;
and how much the user can actually benefit from controlling particular
sub-category of GTP flows. Or knowing that NIC supports a particular
sub-category.

Let's forget about capabilities of Intel NICs for now - can you as a
user think of practical use cases where we'd want to turn on hashing
based on TEID for, e.g. gtpu6 and not gtpc6?
