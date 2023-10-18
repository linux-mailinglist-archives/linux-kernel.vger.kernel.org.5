Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEC7CE1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjJRPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjJRPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:51:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E2D121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:51:05 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697644262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o6GadWL9FpMiVRJIsdolf94ub9c2wj+B0srEPRRHi/8=;
        b=LGaXj0BB6V/RCSUd2bikdxO1ThAn5INzm6drb7NirEggUR9/WzkF5qAoAo/4hn/ELwSGOQ
        l8KcdpjIS4OOmL8hxbN5Hf8KTI9xNAXnBsBv1PML0IiCGCzOQslGRMqAq+drLfhABKJn4M
        CSMznIaODqO8nMXeRY00UVhu3q3UBenYB19rSrq+1J8XTCSQa1e4FqFFbvALunoYqeZXJh
        zbr4yvg6euB+BARJNxPj1licM7kjyhcTJG7lDN58awkAAZ0RCTKXFiaMMQ2obIMwaVVfNi
        9xllQIyZhSYrIRNsRYv+9zhefXfu2w3HPVD/DSUw4d/ueZbRwxrFEvf3YWvmAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697644262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o6GadWL9FpMiVRJIsdolf94ub9c2wj+B0srEPRRHi/8=;
        b=hRgTolrgzoZRwPTSQi9Ycwg/Kgx6hn4v48bDX2jrhY2VixFgSwBNWJx9mhuyrS5Cs8MJsS
        TOZNjCbA+xqMolDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
In-Reply-To: <ZS_5Xd7zPWvSHuqq@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley> <87mswh6iwq.fsf@jogness.linutronix.de>
 <ZS_Vg4vvT29LxWSD@alley> <874jio6o2y.fsf@jogness.linutronix.de>
 <ZS_5Xd7zPWvSHuqq@alley>
Date:   Wed, 18 Oct 2023 17:56:52 +0206
Message-ID: <87zg0g53qb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-18, Petr Mladek <pmladek@suse.com> wrote:
> So it is the _last_ finalized id from the timing POV. If there are
> more CPUs storing and finalizing the messages in parallel then
> it might change forth and back. There might be earlier non-finalized
> records and newer finalized ones.
>
> It means that prb_next_seq() really is the best effort and
> the description is not valid:

Well, the description was valid until prb_next_seq() was optimized and
converted to best-effort with:

commit f244b4dc53e5 ("printk: ringbuffer: Improve prb_next_seq() performance")

> It would be great to document these subtle details especially when
> we are going to depend on them.

Going through the various call sites of prb_next_seq(), I would argue
that the above optimization introduced some bugs. I will investigate if
prb_next_seq() can be fixed to match its description because the current
users already depend on that.

WRT to this series, I have put together an alternative implementation
that does not use prb_next_seq().

John
