Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C07B33E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjI2NnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjI2NnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:43:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB41AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:43:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0B7491F45E;
        Fri, 29 Sep 2023 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695994988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E79DK7BozeB99z07tZdUghJDpaK72+RIh6GRzFcwuPo=;
        b=EDY6DiJQShnQc+6wCGRGVJN8DGvd3ZTNQZysEh1SwDkNsOSEbIhJGotrAfsM4to27GT41B
        km0L2IOYaJh7VE4XoN2RCb4oecwwmugAJz+M1rVtfOX77f8vJEdxkAtvKNnorB4R+d+/qv
        plGwSG7HHIStZyVB6y5KPVB7ywjoodM=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 605652C142;
        Fri, 29 Sep 2023 13:43:07 +0000 (UTC)
Date:   Fri, 29 Sep 2023 15:43:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH printk] printk: flush consoles before checking progress
Message-ID: <ZRbUaldrGz8u6CNp@alley>
References: <20230929113233.863824-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929113233.863824-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-29 13:38:33, John Ogness wrote:
> Commit 9e70a5e109a4 ("printk: Add per-console suspended state")
> removed console lock usage during resume and replaced it with
> the clearly defined console_list_lock and srcu mechanisms.
> 
> However, the console lock usage had an important side-effect
> of flushing the consoles. After its removal, consoles were no
> longer flushed before checking their progress.
> 
> Add the console_lock/console_unlock dance to the beginning
> of __pr_flush() to actually flush the consoles before checking
> their progress. Also add comments to clarify this additional
> usage of the console lock.
> 
> Finally, in case pr_flush() needs to poll-wait (for example,
> because there has been a handover to another CPU), reduce the
> polling interval from 100ms to 1ms. In the bug report it was
> mentioned that 100ms is unnecessarily long.
> 
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217955
> Fixes: 9e70a5e109a4 ("printk: Add per-console suspended state")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going to wait a bit for eventual feedback and push it to
linux-next the following week.

Best Regards,
Petr
