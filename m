Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE987BB159
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJFGGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJFGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:06:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19690;
        Thu,  5 Oct 2023 23:06:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qodyp-0006fE-FF; Fri, 06 Oct 2023 08:06:31 +0200
Date:   Fri, 6 Oct 2023 08:06:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Henrik =?iso-8859-15?Q?Lindstr=F6m?= <lindstrom515@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: macvtap performs IP defragmentation, causing MTU problems for
 virtual machines
Message-ID: <20231006060631.GC11420@breakpoint.cc>
References: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
 <2197902.NgBsaNRSFp@pc>
 <20231004080037.GC15013@breakpoint.cc>
 <3259970.44csPzL39Z@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3259970.44csPzL39Z@pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Lindström <lindstrom515@gmail.com> wrote:
> On onsdag 4 oktober 2023 10:00:37 CEST Florian Westphal wrote:
> > Can you submit this formally, with proper changelog and Signed-off-by?
> > See scripts/checkpatch.pl in the kernel tree.
> Sure, i can give it a shot. How do i properly credit you if i submit your
> patch with some small changes of my own?

You can use:

"Suggested-by:" tag here.

> > You could also mention in changelog that this is ipv4 only because
> > ipv6 already considers the interface index during reassembly.
> Interesting. I've been trying to understand the code and it seems like
> ipv6 does defragmentation per-interface, while ipv4 does it "per-vrf"
> (correct me if i'm wrong). Is there any reason for this difference? 

Only for linklocal and multicasts.  Added in
264640fc2c5f4f913db5c73fa3eb1ead2c45e9d7 . Even mentions macvlan in the
changelog.

> The idea being that bcast/mcast packets are always defragmented
> per-interface, and unicast packets always "per-vrf".

LGTM, but please CC dsahern@kernel.org once you submit the patch.
