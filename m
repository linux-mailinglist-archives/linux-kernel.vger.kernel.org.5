Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6AF7B1E57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjI1N1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjI1N1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:27:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC7180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:27:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F3BC433C8;
        Thu, 28 Sep 2023 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907670;
        bh=l2AzfVnQusW7bzHrFKQB4PAqb+m//Ig8AMRGcQRghPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezyR/FxmKsts3EHdMLgVbT0yHbZFg4bvvJ9WhGuWXLkquTvF9fZkDoItY6n6O9x3g
         7HEN4870TbLrza3/zkzdGiJDY3SVLxl1D9oEshZa1hUps3DfKsW3AB7RqjoWiAzkej
         FC9UYKPVn0E+bp4WmMMyRknhpPC/I56PUc0U1batkkUxy26zxxWwOBhC4I2mBYH9d3
         0VwsNDhPh7H9oprBjq9iwwJLmzj5iJBohSvw9WUy3RlF35GwS+9wFSqBo2GkpKnEos
         Gzkix9bLvTMdqOYqWToBDA1udMUTOVe1nmnoCutQBiIJtcmGZ5bpAQYn0GcW7eowec
         R8h/P3w6Y+6QQ==
Date:   Thu, 28 Sep 2023 15:27:37 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qed/red_ll2: Fix undefined behavior bug in struct
 qed_ll2_info
Message-ID: <20230928132737.GL24230@kernel.org>
References: <ZQ+Nz8DfPg56pIzr@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ+Nz8DfPg56pIzr@work>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 07:15:59PM -0600, Gustavo A. R. Silva wrote:
> The flexible structure (a structure that contains a flexible-array member
> at the end) `qed_ll2_tx_packet` is nested within the second layer of
> `struct qed_ll2_info`:
> 
> struct qed_ll2_tx_packet {
> 	...
>         /* Flexible Array of bds_set determined by max_bds_per_packet */
>         struct {
>                 struct core_tx_bd *txq_bd;
>                 dma_addr_t tx_frag;
>                 u16 frag_len;
>         } bds_set[];
> };
> 
> struct qed_ll2_tx_queue {
> 	...
> 	struct qed_ll2_tx_packet cur_completing_packet;
> };
> 
> struct qed_ll2_info {
> 	...
> 	struct qed_ll2_tx_queue tx_queue;
>         struct qed_ll2_cbs cbs;
> };
> 
> The problem is that member `cbs` in `struct qed_ll2_info` is placed just
> after an object of type `struct qed_ll2_tx_queue`, which is in itself
> an implicit flexible structure, which by definition ends in a flexible
> array member, in this case `bds_set`. This causes an undefined behavior
> bug at run-time when dynamic memory is allocated for `bds_set`, which
> could lead to a serious issue if `cbs` in `struct qed_ll2_info` is
> overwritten by the contents of `bds_set`. Notice that the type of `cbs`
> is a structure full of function pointers (and a cookie :) ):
> 
> include/linux/qed/qed_ll2_if.h:
> 107 typedef
> 108 void (*qed_ll2_complete_rx_packet_cb)(void *cxt,
> 109                                       struct qed_ll2_comp_rx_data *data);
> 110
> 111 typedef
> 112 void (*qed_ll2_release_rx_packet_cb)(void *cxt,
> 113                                      u8 connection_handle,
> 114                                      void *cookie,
> 115                                      dma_addr_t rx_buf_addr,
> 116                                      bool b_last_packet);
> 117
> 118 typedef
> 119 void (*qed_ll2_complete_tx_packet_cb)(void *cxt,
> 120                                       u8 connection_handle,
> 121                                       void *cookie,
> 122                                       dma_addr_t first_frag_addr,
> 123                                       bool b_last_fragment,
> 124                                       bool b_last_packet);
> 125
> 126 typedef
> 127 void (*qed_ll2_release_tx_packet_cb)(void *cxt,
> 128                                      u8 connection_handle,
> 129                                      void *cookie,
> 130                                      dma_addr_t first_frag_addr,
> 131                                      bool b_last_fragment, bool b_last_packet);
> 132
> 133 typedef
> 134 void (*qed_ll2_slowpath_cb)(void *cxt, u8 connection_handle,
> 135                             u32 opaque_data_0, u32 opaque_data_1);
> 136
> 137 struct qed_ll2_cbs {
> 138         qed_ll2_complete_rx_packet_cb rx_comp_cb;
> 139         qed_ll2_release_rx_packet_cb rx_release_cb;
> 140         qed_ll2_complete_tx_packet_cb tx_comp_cb;
> 141         qed_ll2_release_tx_packet_cb tx_release_cb;
> 142         qed_ll2_slowpath_cb slowpath_cb;
> 143         void *cookie;
> 144 };
> 
> Fix this by moving the declaration of `cbs` to the  middle of its
> containing structure `qed_ll2_info`, preventing it from being
> overwritten by the contents of `bds_set` at run-time.
> 
> This bug was introduced in 2017, when `bds_set` was converted to a
> one-element array, and started to be used as a Variable Length Object
> (VLO) at run-time.
> 
> Fixes: f5823fe6897c ("qed: Add ll2 option to limit the number of bds per packet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

