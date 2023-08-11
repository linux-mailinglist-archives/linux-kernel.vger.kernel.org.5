Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43086778E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHKL6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjHKL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:58:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D4812C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C15670FA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DD9C433C7;
        Fri, 11 Aug 2023 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691755086;
        bh=wfvu3TMRQPeIB4HmfbwwbhKQnTjDQldHSGkl2C9S4iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyYGu5/uMiK9TbeMZWJXnCV0oyAzsE/5JBPkWDkQxRT1DPbMJKbg6ybKFOhqlQBDn
         2J/GJqc/efbNVLfEHCl+H5JMaS9pWI/EWw6wNjsqSLbRycjiuxPvy/UhRs1UxYt/54
         QWJBo35BVFe3gB4cAqk2uFW83L3i8Is5s9gc0mcV11fY0atqQDnG37c6A9NMeecrNt
         bhfGMxbB71i3YSrVfZVpakn6FU57rVxT+vznHJIHkITxk/VZOK5/8VOb1T+e6VK/WV
         64uPt3PViRq8P7IHgOHEKLkqryLiXUOQVk0/xE484D5Q0S+p6d1wFwVhI5dq0jp2z9
         pQfJqRNA/xlcA==
Date:   Fri, 11 Aug 2023 13:58:00 +0200
From:   Simon Horman <horms@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, larysa.zaremba@intel.com,
        aleksander.lobakin@intel.com, jbrouer@redhat.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Message-ID: <ZNYiSEG5/0cJIZ3f@vergenet.net>
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-2-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810064514.104470-2-wei.fang@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:45:13PM +0800, Wei Fang wrote:
> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.
> 
> I tested the performance of XDP_TX in XDP_DRV mode and XDP_SKB
> mode respectively on i.MX8MP-EVK platform, and as suggested by
> Jesper, I also tested the performance of XDP_REDIRECT on the
> same platform. And the test steps and results are as follows.
> 
> XDP_TX test:
> Step 1: One board is used as generator and connects to switch,and
> the FEC port of DUT also connects to the switch. Both boards with
> flow control off. Then the generator runs the
> pktgen_sample03_burst_single_flow.sh script to generate and send
> burst traffic to DUT. Note that the size of packet was set to 64
> bytes and the procotol of packet was UDP in my test scenario. In
> addtion, the SMAC of the packet need to be different from the MAC

nit: addtion -> addition

     checkpatch.pl --codespell is your friend here.

...
