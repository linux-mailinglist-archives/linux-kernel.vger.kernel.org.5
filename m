Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9447B7438
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjJCWnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJCWnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:43:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B409B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:43:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261DFC433C7;
        Tue,  3 Oct 2023 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696373007;
        bh=P9+3h53DxqmjxSGM6n93lGmt0Puqp/z5dcxCLS1WDnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BV9UcaP+hpFCnN6I9ENoevhcCLjhYTmYkkTHvkZ7qT3q1yIOZ98ANL+SXHfo7mzRb
         7zgNftxObRPKY49gRz7tKnuh4BIQm/4VubbU7y7z+0n1Fv41KiY7MdBRGrs5ad8Bl+
         TQhg6JuSB9C37B/Zf4wnluiEOAm7u3R0H1Z0L9lE/rpnHkxB0jAcVl62S2NArkiZCr
         5ygtHz4EYQty6Jqd9nQrYGM0bVAWzQOKo0IrvwnqcoCXsdCQFWxwChtCEnKQA31z7E
         vX0gevM+gdjc2x33GbNGLauYLuvVAnWa9zoi5zkt63mT+2C3XBwkhDnkC3yGjAxxex
         t1BN62AP7U3IA==
Date:   Tue, 3 Oct 2023 15:43:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Alan Brady <alan.brady@intel.com>,
        "Sridhar Samudrala" <sridhar.samudrala@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Phani Burra <phani.r.burra@intel.com>,
        Joshua Hay <joshua.a.hay@intel.com>,
        Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
        Madhu Chittim <madhu.chittim@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH] idpf: fix building without IPv4
Message-ID: <20231003154326.213e9c81@kernel.org>
In-Reply-To: <1430f3d3-4e84-b0ec-acd9-8a51db178f73@intel.com>
References: <20230925155858.651425-1-arnd@kernel.org>
        <1430f3d3-4e84-b0ec-acd9-8a51db178f73@intel.com>
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

On Mon, 25 Sep 2023 10:05:03 -0700 Tony Nguyen wrote:
> Also, a pending patch for this [1], however, this does look a bit more 
> efficient. Adding Olek as he's author on the other patch.
> 
> netdev maintainers,
> 
> If this is the version that does get picked up, did you want to take it 
> directly to close out the compile issues?

Sorry for the delays. Should we not add a !INET static inline wrapper
for tcp_gro_complete()? Seems a bit backwards to me to make drivers
suffer and think about such a preposterous config :S

$ git grep tcp_gro_complete -- drivers/
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:        tcp_gro_complete(skb);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:              tcp_gro_complete(skb);
drivers/net/ethernet/intel/idpf/idpf_txrx.c:    tcp_gro_complete(skb);
drivers/net/ethernet/qlogic/qede/qede_fp.c:     tcp_gro_complete(skb);

We have 4 drivers which need ifdefs already and the number will only
grow with GRO-HW spreading.
