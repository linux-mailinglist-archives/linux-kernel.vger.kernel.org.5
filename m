Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893177A4535
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbjIRIzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbjIRIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:55:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4EDD1;
        Mon, 18 Sep 2023 01:54:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695027296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SaupYWhDkXFaEEUUd3eBV7dIU5O04Mi5eNGHFaaIGY=;
        b=xHYrdQl9Fyoq2TE360zSXtB4EpAvVmpUsqJQpJCnBTY1s7EdBTSxJ0kILkRn3qXRxXgtp0
        nfxfbDMQ0ZG4N7C+KkJrrwtXxEWWHEny4xgOcwRFjBAAttlvZkXW3jGJBTwdpzVorw4OrS
        luXaqlQEd42Bsv/YmV0AB2ouM4q+mcctSLE86o8iO4baw2eKCUkhYo6sLZyQbhg2xuqobe
        +NKagOTTe5hfBorbaO4q+/uEx3sgaJuNf6rdXaubMoL8KyKN7TdaI5H+9YKEa6wLUKaq68
        wEg7wefJe9mJ8IR3fEk8PV3hN6mT1KemifGFaN1TJklEMLeKGac0hGSHc6gh7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695027296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SaupYWhDkXFaEEUUd3eBV7dIU5O04Mi5eNGHFaaIGY=;
        b=3ZW1E3MWTMz7DFU1FAMoJ/GG7soyRLlrVp1Vn4DtvHHcTlA7fK4xv+J7kmUdsWGqizQAF8
        C2XhGyt13zv7ZyAA==
To:     Petr Mladek <pmladek@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Enlin Mu <enlinmu@gmail.com>, Enlin Mu <enlin.mu@outlook.com>,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        enlin.mu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
In-Reply-To: <ZQSHJ_786kZNjEDX@alley>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de>
 <CAAfh-jPc+UWMcLPFbYy6rYUh4OU36frkVYVbkhNPNX4L6RG5sA@mail.gmail.com>
 <2023091547-mug-unlikable-571f@gregkh> <ZQSHJ_786kZNjEDX@alley>
Date:   Mon, 18 Sep 2023 11:00:48 +0206
Message-ID: <87ttrrlv3b.fsf@jogness.linutronix.de>
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

On 2023-09-15, Petr Mladek <pmladek@suse.com> wrote:
> The biggest problem is that it would change the format of the
> ringbuffer so that it would require updating external tools,
> working with crashdump, especially crash but there are also
> alternative python extensions for gdb.

I already have experience updating these external tools. It is
manageable. But I would prefer we had bigger changes to make. Let us not
forget your RFC [0] where you wanted to add similar metadata and
more. We should put all these changes into a single release.

John Ogness

[0] https://lore.kernel.org/lkml/20200923135617.27149-1-pmladek@suse.com
