Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16180F67F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377093AbjLLTVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjLLTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:21:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC239F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:21:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E8C433C9;
        Tue, 12 Dec 2023 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408907;
        bh=mj3SAwKcmqSqhMBqORrj4sHEFg6g5cS+PgxB5jSbueY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KEQHZ1B5w9+KQEUURp8DI6uCXRF4SjDEK2K0PH8YTdG4Q7EUrSRK+V6rfabwGbsQV
         UFPCt5lBYyOGcrgt/KV18WrYpGDH39q6CTQmi2Fg1MJ5mYXJBSjWfsegyeIPjQrjBb
         lUzWYVkaqwQe2KFCL32uqg1nrUVFn16KSIxhXk3+T5Ive6WDYeS2KkznrBGz/XpFnO
         N/ekEg3TGKl5HjMu37kyXAaILa7GZyZGBkp3RToBqCq2K61E7CKMSW4sIGUDXcT7Wc
         5kJpD5I+OCycKUCY6IrSsCzwoOGMLFNxVqQeiobdYQOqq8dbhbPEYiFaJP9qyi3QCx
         8ETOjngt76Vdg==
Date:   Tue, 12 Dec 2023 11:21:45 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 10/13] rtase: Implement ethtool function
Message-ID: <20231212112145.25953351@kernel.org>
In-Reply-To: <20231208094733.1671296-11-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-11-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 17:47:30 +0800 Justin Lai wrote:
> +static const char rtase_gstrings[][ETH_GSTRING_LEN] = {
> +	"tx_packets",
> +	"rx_packets",
> +	"tx_errors",
> +	"rx_errors",
> +	"rx_missed",
> +	"align_errors",
> +	"tx_single_collisions",
> +	"tx_multi_collisions",
> +	"unicast",
> +	"broadcast",
> +	"multicast",
> +	"tx_aborted",
> +	"tx_underrun",

Please take a look at struct rtnl_link_stats, anything that's already
present there should be reported via ndo_get_stats64, not ethtool
