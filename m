Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF87CF556
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbjJSK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbjJSK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:29:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F182119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:29:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C6CBD21AC1;
        Thu, 19 Oct 2023 10:29:49 +0000 (UTC)
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 652832C4F5;
        Thu, 19 Oct 2023 10:29:49 +0000 (UTC)
Date:   Thu, 19 Oct 2023 12:29:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
Message-ID: <ZTEFHdWhB-UZynVI@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley>
 <87mswh6iwq.fsf@jogness.linutronix.de>
 <ZS_Vg4vvT29LxWSD@alley>
 <874jio6o2y.fsf@jogness.linutronix.de>
 <ZS_5Xd7zPWvSHuqq@alley>
 <87zg0g53qb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg0g53qb.fsf@jogness.linutronix.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C6CBD21AC1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-18 17:56:52, John Ogness wrote:
> On 2023-10-18, Petr Mladek <pmladek@suse.com> wrote:
> > So it is the _last_ finalized id from the timing POV. If there are
> > more CPUs storing and finalizing the messages in parallel then
> > it might change forth and back. There might be earlier non-finalized
> > records and newer finalized ones.
> >
> > It means that prb_next_seq() really is the best effort and
> > the description is not valid:
> 
> Well, the description was valid until prb_next_seq() was optimized and
> converted to best-effort with:
> 
> commit f244b4dc53e5 ("printk: ringbuffer: Improve prb_next_seq() performance")
> 
> > It would be great to document these subtle details especially when
> > we are going to depend on them.
> 
> Going through the various call sites of prb_next_seq(), I would argue
> that the above optimization introduced some bugs. I will investigate if
> prb_next_seq() can be fixed to match its description because the current
> users already depend on that.

I thought about caching the last seq returned by
prb_next_seq() instead of caching the last finalized record.

Also I thought about the highest sequence number accessed
by _prb_read_valid(). But it can be done lockless way only
on 64-bit systems. Well, it might be good enough. I doubt that
there are big 32-bit systems.

> WRT to this series, I have put together an alternative implementation
> that does not use prb_next_seq().

Great.

Best Regards,
Petr
