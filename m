Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF402801289
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379210AbjLASVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:21:45 -0500
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F0198;
        Fri,  1 Dec 2023 10:21:50 -0800 (PST)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 2D06B22BA4;
        Fri,  1 Dec 2023 20:21:47 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 12C0722B72;
        Fri,  1 Dec 2023 20:21:47 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 046A63C07CA;
        Fri,  1 Dec 2023 20:21:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1701454902; bh=RVMVZinltrNpOTYtB7d7CKwLIUe7uVQYlxaaOejZVpc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=iDCiIsLybtdtJOP92/miL+0hXJQutbzA78zc2zSRJNndjn1As29KrZtNMkJoPj4jb
         dPmvTLvz3litwT6fNhoyYEQR8qxLY8wSy0brxgaSHjIb/nqvEmXXCz64ppwIjj8Mot
         j8RuHJzKZflvj/dpCC4v2wfJGVEQ9hYTM7UnJEO0=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 3B1ILYTx101893;
        Fri, 1 Dec 2023 20:21:34 +0200
Date:   Fri, 1 Dec 2023 20:21:34 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     Doug Anderson <dianders@chromium.org>
cc:     Eric Dumazet <edumazet@google.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
In-Reply-To: <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
Message-ID: <c4d90b06-a941-b275-38a9-2a891485ca4d@ssi.bg>
References: <20231201083926.1817394-1-judyhsiao@chromium.org> <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com> <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com> <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com>
 <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 1 Dec 2023, Doug Anderson wrote:

> The place we hit this wasn't actually with fuzzers but with normal
> usage in our labs. The only case where it was a really big problem was
> when neigh_forced_gc() was scheduled on a "little" CPU (in a
> big.LITTLE system) and that little CPU happened to be running at the
> lowest CPU frequency. Specifically Judy was testing on sc7180-trogdor
> and the lowest CPU Frequency of the "little" CPUs was 300 MHz. Since
> the littles are less powerful than the bigs, this is roughly the
> equivalent processing power of a big core running at 120 MHz.

	If we are talking about 32-bit systems with high HZ value I now 
see a little problem in neigh_alloc() where we may start neigh_forced_gc() 
later on gc_thresh3, not early on gc_thresh2 as expected. This can happen 
after a long idle period when last_flush becomes invalid and 'now'
is 'time_before' last_flush:

-	time_after(now, tbl->last_flush + 5 * HZ))) {
+	!time_in_range_open(now, tbl->last_flush, tbl->last_flush + 5 * HZ))) {

	With a big gap between gc_thresh2 and gc_thresh3 we
may work on large gc_list if we react on gc_thresh3 instead of
gc_thresh2. But such storms can not happen more than once per jiffie wrap.

> FWIW, we are apparently no longer seeing the bad latency after
> <https://crrev.com/c/4914309>, which does this:
> 
> # Increase kernel neighbor table size.
> echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh1
> echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh2

	We expect to keep the entries not much above 4096 and
we should see small gc_list.

> echo 8192 > /proc/sys/net/ipv4/neigh/default/gc_thresh3

	On invalid last_flush we will free 8192-4096 => 4096 entries
under BH lock.

Regards

--
Julian Anastasov <ja@ssi.bg>

