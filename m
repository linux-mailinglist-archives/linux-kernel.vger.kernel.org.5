Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44477DD52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbjHPJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243418AbjHPJbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:31:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E8526A5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:31:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 948A42190B;
        Wed, 16 Aug 2023 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692178294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSpvao0+AYUlFxQUQTlQ0ZllhVu7LrSH3/zVj8PuOtw=;
        b=D8mT1slEzFoOishvpI1xLZR2wwz5KBM8YXatMbO7AJPZrGtgJGmqKr+OFfSnOLANo+uttu
        sqEr6zLVNaWLtt27HxoZTa4+4sqsrDQMhmHNhpFnfNLqBkPnqRhQiuyRg7gfZsK4ERyuR5
        GiTsIN+1xdATZackCISehgqYvEntNnI=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B8CB2C143;
        Wed, 16 Aug 2023 09:31:34 +0000 (UTC)
Date:   Wed, 16 Aug 2023 11:31:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Enlin Mu <enlinmu@gmail.com>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        yunlong.xing23@gmail.com
Subject: Re: [PATCH] printk: export symbols for debug modules
Message-ID: <ZNyXdDlruiQAQeMl@alley>
References: <20230815020711.2604939-1-yunlong.xing@unisoc.com>
 <ZNuDxFGoXPCwECyt@alley>
 <CAAfh-jM0B2Cn579B0CkCrW44pJGGvjs112K+oMuViib+jDKafg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfh-jM0B2Cn579B0CkCrW44pJGGvjs112K+oMuViib+jDKafg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-08-16 09:24:29, Enlin Mu wrote:
> Petr Mladek <pmladek@suse.com> 于2023年8月15日周二 21:55写道：
> >
> > On Tue 2023-08-15 10:07:11, Yunlong Xing wrote:
> > > From: Enlin Mu <enlin.mu@unisoc.com>
> > >
> > > the module is out-of-tree, it saves kernel logs when panic
> > >
> > > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> >
> > I am fine with it. After all, this API seems to here for
> > similar purposes.
> Thanks.
> >
> > Acked-by: Petr Mladek <pmladek@suse.com>
> >
> > Of course, it would be better to maintain the module in upstream.
> > Is there any chance to get it upstream? It seems that it
> > is GPL-compatible so...
> Yes, currently under development. Once the code debugging is stable,
> it will be pushed to the community.

Great.

One more thing which came to my mind.

The log buffer contains the plain text and "id" of the related
metadata. Namely, there is always an "unsigned long" before
each message, see struct prb_data_block.

You might consider using the kmsg_dump API. It has been added
for this purpose. It allows to read and store the messages
one by one. And the messages are formatted the same way
as on console or by dmesg.

The registered dumpers are automatically called in panic().
See kmsg_dump(KMSG_DUMP_PANIC) in panic().

There are few users of this API. Look for kmsg_dump_register()
to get some inspiration.

Best Regards,
Petr
