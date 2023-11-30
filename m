Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D314A7FF7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjK3RL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjK3RLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:11:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60435171C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:11:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9765BC433C7;
        Thu, 30 Nov 2023 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364290;
        bh=z8tPq/OZFdLYzHcBmbFrH1eT9NsxQ9H6d+/+FYkxiZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRhBO/OAOyR0zL9RuMc2BZ8dbWhnPyzxFlUAWFe1TAis9hnTHvVV0Zsa1391RCgAF
         vSH2hGxvMlNxIURDzEw/9XWsM2kth1WkWMZnqdH95j8H9Bkvj41RKzX/5U8OqRWuH2
         D7Cc6KCrAKtjHyVvisPY9DMDKtCCU6k3B7+RqJbKCQ9HNPooA8w+Elasfm4Vim5zE5
         BktKtSyphAWZ279FY0LAZJ+sKtwjgyURUX4rtdgYMU0Th8xs6gmHXgXwLldHIVlEHT
         4Urs1HOcQUL4aI9+67wuhzg26rzX2py5kqFsLtbW0DU2cwNpWc7KH6BDwb8dJt32bp
         nnCwM8Rcj048A==
Date:   Thu, 30 Nov 2023 17:11:26 +0000
From:   Simon Horman <horms@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20231130171126.GH32077@kernel.org>
References: <20231129204806.14539-1-lnimi@hotmail.com>
 <PH7PR03MB7064FC8C284D83E9C34B8C08A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064FC8C284D83E9C34B8C08A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:48:06PM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> The RENESAS FemtoClock3 Wireless is a high-performance jitter attenuator,
> frequency translator, and clock synthesizer. The device is comprised of 3
> digital PLLs (DPLL) to track CLKIN inputs and three independent low phase
> noise fractional output dividers (FOD) that output low phase noise clocks.
> 
> FemtoClock3 supports one Time Synchronization (Time Sync) channel to enable
> an external processor to control the phase and frequency of the Time Sync
> channel and to take phase measurements using the TDC. Intended applications
> are synchronization using the precision time protocol (PTP) and
> synchronization with 0.5 Hz and 1 Hz signals from GNSS.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Hi Min Li,

some minor feedback from my side.

...

> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile

...

> +static inline s64 ns2counters(struct idtfc3 *idtfc3, s64 nsec, u32 *sub_ns)
> +{
> +	s64 sync;
> +	s32 rem;
> +
> +	if (likely(nsec > 0)) {
> +		sync = div_u64_rem(nsec, idtfc3->ns_per_sync, &rem);
> +		*sub_ns = rem;
> +	} else if (nsec < 0) {
> +		sync = -div_u64_rem(-nsec - 1, idtfc3->ns_per_sync, &rem) - 1;
> +		*sub_ns = idtfc3->ns_per_sync - rem - 1;
> +	}
> +
> +	return sync * idtfc3->ns_per_sync;

Perhaps it cannot occur, but if nsec is exactly 0, then
sync is uninitialised here.

Flagged by clang-17 W=1 build, and Smatch.

> +}

...

> +static int _idtfc3_settime(struct idtfc3 *idtfc3, const struct timespec64 *ts)
> +{
> +	s64 offset_ns, now_ns, sync_ns;
> +	u32 counter, sub_ns;
> +	int now;
> +
> +	if (timespec64_valid(ts) == false) {
> +		dev_err(idtfc3->dev, "%s: invalid timespec", __func__);
> +		return -EINVAL;
> +	}
> +
> +	now = idtfc3_read_subcounter(idtfc3);
> +	if (now < 0)
> +		return now;
> +
> +	offset_ns = (idtfc3->sub_sync_count - now) * idtfc3->ns_per_counter;
> +	now_ns = timespec64_to_ns(ts);
> +	sync_ns = ns2counters(idtfc3, offset_ns + now_ns, &sub_ns);

sync_ns is set here but otherwise unused.
Perhaps the assignment can be dropped and sync_ns removed from this
function?

As flagged by gcc-13 W=1 build and Smatch.

> +
> +	counter = sub_ns / idtfc3->ns_per_counter;
> +	return idtfc3_timecounter_update(idtfc3, counter, now_ns);
> +}

...
