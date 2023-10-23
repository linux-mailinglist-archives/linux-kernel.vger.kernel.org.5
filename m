Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7017D42EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjJWWxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJWWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:53:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5AF10E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 15:53:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158DAC433C7;
        Mon, 23 Oct 2023 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698101595;
        bh=2p2vYId+/XkAtr85GFeTQzGPwyHJushD8tZW2QZ/NCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/ZQMPtfTk56Ys0Dbu0IxS8q5MWeRF0Do42hnKDF2NObWX8rz3+qy4jA02r7dZ6Xs
         w0v2g3rnNrL66Ak7jZAiSeLaUp0tpW3phpaF4ILKGez5gaX+Rd0c53i7omLjVFrwbb
         PQGOQBtPpN7x6afTja9y8fQSUJ8kDRVZWJ8F+ralL99LM7rGZQLOGXP4UHg3i70IBg
         75MbecLbZZdzpSYihBW7LYvjciHOYOvIH7gzoOpX9i/O5SzrJgi9NyhEgjO8JRbXJ5
         PxpIAaA7cK/xzk1ANn6/sA39le33Uw+I3I31PO1uqLfZi77U4zeR3FUObDwgwbxOHM
         RYeS2uXPXeL8g==
Date:   Mon, 23 Oct 2023 15:53:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
Message-ID: <20231023155314.50b13861@kernel.org>
In-Reply-To: <20231020163415.2445440-1-syoshida@redhat.com>
References: <20231020163415.2445440-1-syoshida@redhat.com>
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

On Sat, 21 Oct 2023 01:34:15 +0900 Shigeru Yoshida wrote:
> Link names must be null-terminated strings. If a link name which is not
> null-terminated is passed through netlink, strstr() and similar functions
> can cause buffer overrun. This causes the above issue.

If strings need to be null-terminated you should switch the policy here
https://elixir.bootlin.com/linux/v6.6-rc6/source/net/tipc/netlink.c#L91
from NLA_STRING to NLA_NUL_STRING, no?
-- 
pw-bot: cr
