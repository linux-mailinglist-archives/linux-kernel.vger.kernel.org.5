Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1877470C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjHHTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjHHTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8DD4BEC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21FAB62534
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9815BC433C7;
        Tue,  8 Aug 2023 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691499106;
        bh=czHewSu/ClbRoBJAOohHZjA2+Uw0usYmOLRzJpX+Gbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqCClGIeqYURWbJwbJ6UGvvGF1nj31U1Zj6RfvULDPR4ISd6EiPAw3ibb6fbOjIp0
         ze8z+VMY1X7Fd4SmiuGnxRwjqg71xm54CA1Dd/yyMTPKVk39X0Wt2PVpbYANWGYIA/
         3R6JliH2Msy0JfbNp6fhnLKQpqpTiOU2I4rrt4yVxaH5pZR8/brkRNkEGNGocoVYku
         Lwu/iNj1/fnR/tiSo6xo5mVwceepYwH4C+aUcQ1T4qH1fnkZRpU+plXFDTWlkM7j3y
         rju9ki2Z3awM2RHPAAUGhWz/XmWsmRlvti2jLd8AG5qxYwqSC9STIQh12W6dMYGVge
         VbulLnCCgWYig==
Date:   Tue, 8 Aug 2023 14:51:41 +0200
From:   Simon Horman <horms@kernel.org>
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Jacob.e.keller@intel.com, przemyslawx.patynowski@intel.com,
        kamil.maziarz@intel.com, dawidx.wesierski@intel.com,
        mateusz.palczewski@intel.com, slawomirx.laba@intel.com,
        norbertx.zulinski@intel.com, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] Revert "ice: Fix ice VF reset during iavf
 initialization"
Message-ID: <ZNI6XSBM2ULz0CZM@vergenet.net>
References: <20230807094831.696626-1-poros@redhat.com>
 <20230807094831.696626-2-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807094831.696626-2-poros@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:48:30AM +0200, Petr Oros wrote:
> This reverts commit 7255355a0636b4eff08d5e8139c77d98f151c4fc.
> 
> After this commit we are not able to attach VF to VM:
> virsh attach-interface v0 hostdev --managed 0000:41:01.0 --mac 52:52:52:52:52:52
> error: Failed to attach interface
> error: Cannot set interface MAC to 52:52:52:52:52:52 for ifname enp65s0f0np0 vf 0: Resource temporarily unavailable
> 
> ice_check_vf_ready_for_cfg() already contain waiting for reset.
> New condition in ice_check_vf_ready_for_reset() causing only problems.
> 
> Fixes: 7255355a0636 ("ice: Fix ice VF reset during iavf initialization")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

