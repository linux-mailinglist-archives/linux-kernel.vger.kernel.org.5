Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3337F0457
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 05:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKSEof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 23:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjKSEoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 23:44:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD12A8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 20:44:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB09C433C8;
        Sun, 19 Nov 2023 04:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700369066;
        bh=lX9jmudgE0rvRgwTmcrOlAruOBlzOUgPsTThK5jENvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q44IyrjByKDRhh0GONd6gcTiDIdmWlizpHahTFqY+F/Gk/yYNw6mwxAYr9y/rZD+6
         uufdkAlIHr2MxO4DiCvHSGjfu7umHss+RKlEy87mxhL4PxPbflujA+QH7o1lKyw2kO
         N9jVSvRS3AmvqySCqXTZ+tQoV9Zpz3CgjMvlCYKpg8xPdStFmXW5QdWn67WjUi1Mzu
         WWArUiIMUsn32uwcaSan8DpCWWewRlVu9o6i7yB22yxNFcPdimHoGquq9hZ1JKt4gM
         uajDFSuJ4QooJUS33BaCRp1sNCcAIj5WxnUq/MlNzns2nXB6sGueJQdPBc42fGhGRT
         kTvHQhs3nzOkg==
Date:   Sat, 18 Nov 2023 20:44:24 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ti: am65-cpsw-nuss: Fix NULL pointer
 dereference at module removal
Message-ID: <20231118204424.21d209a6@kernel.org>
In-Reply-To: <20231116110930.36244-3-rogerq@kernel.org>
References: <20231116110930.36244-1-rogerq@kernel.org>
        <20231116110930.36244-3-rogerq@kernel.org>
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

On Thu, 16 Nov 2023 13:09:30 +0200 Roger Quadros wrote:
> The NULL pointer derefernce error seems to come from the
> list_for_each_entry_safe() helper in free_netdev(). It looks like
> the napi pointers are stale contents but I coudn't figure out why.

Some interplay with am65_cpsw_nuss_free_tx_chns()?
It does:

	memset(tx_chn, 0, sizeof(*tx_chn));

which will wipe the NAPI instance, including its struct list_head.

AFAICT the patch as posted misses free_netdev() on some error paths.
-- 
pw-bot: cr
