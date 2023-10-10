Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1338C7BF013
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379324AbjJJBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379287AbjJJBJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:09:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9049E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:09:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3DC433C8;
        Tue, 10 Oct 2023 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696900179;
        bh=rpZwfgLhvy5NqjoH11+XB5hus1b0cemlPwEivuy1gFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bjnXfl4qyuPsS3baHqQuOCAT9FK00axcKnBdFMKqr5qve0gkvhIWLMx8mu/1iw7BN
         qfday0BuLRKe5KHd3HgjQ+sWFY4KKatOiBh6GVZkeAzcdHUEKU8Z1UudPoSJs8He1+
         hQ9avKm296g5+eZr2rFN/3O9RVsguAzz/q6COyj7kuREWtBmwr8BqJWsIp0X0PByrW
         uQthIrcDvxGkDY+Y0FSxn0j3nL6T8rDSjjrDXRwC/gHOQ1aH3DR6fe8r78IfW4AtpQ
         LytbcKENjMPJ5sz/ZKsoKamVp1gWxob3/ETRSCItZNG7L3AeNXWFIP4X15RKQd5NJ3
         Rtsy8TBg4kXmQ==
Date:   Mon, 9 Oct 2023 18:09:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231009180937.2afdc4c1@kernel.org>
In-Reply-To: <20231007155957.aPo0ImuG@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
        <20231004154609.6007f1a0@kernel.org>
        <20231007155957.aPo0ImuG@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 17:59:57 +0200 Sebastian Andrzej Siewior wrote:
> Apologies if I misunderstood. You said to make it optional which I did
> with the static key in the second patch of this series. The first patch
> is indeed not what we talked about I just to show what it would look
> like now that there is no "delay" for backlog-NAPI on the local CPU.
> 
> If the optional part is okay then I can repost only that patch against
> current net-next.

Do we have reason to believe nobody uses RPS?
