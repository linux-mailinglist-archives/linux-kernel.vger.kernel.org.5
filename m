Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3277BF658
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjJJIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjJJIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:44:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA24A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:44:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BBEB4215D5;
        Tue, 10 Oct 2023 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696927495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UiIzTG42vlM3ir1B9Nj5ARgpKfCz7wsB+YLI2XJpGM=;
        b=qbAZTlNzDmvjQLvR458eRwE+OseaJjC1froSejIsk0SHd5fzRgPEyTXSKgj2cjpB5kWp4z
        6VBA18rfK5aT6itrC1aWJetBwhtW1/8MfxI+LGNMiTH/5SGbwWUYWX6aFcBLme5dkKSB+2
        Ge62cQbFdTW9a9KMgAvML+Yz+OGhJrY=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 28A9A2C386;
        Tue, 10 Oct 2023 08:44:55 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:44:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] printk: Reduce unnecessary wait times by
 pr_flush()
Message-ID: <ZSUPBiTXY486H1FV@alley>
References: <20231006082151.6969-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006082151.6969-1-pmladek@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-10-06 10:21:49, Petr Mladek wrote:
> This is an updated version of the patch
> https://lore.kernel.org/r/20230929113233.863824-1-john.ogness@linutronix.de
> 
> Changes since v1:
> 
>   + Split reduction of the pooling time into separate patch.
>   + Use jiffies to count the real sleeping time.
> 
> Note that my original POC counted jiffies spent in the entire cycle.
> It would count also the time spent by console_lock() and by flushing
> the legacy consoles in console_unlock().
> 
> The current version counts only the time spent by msleep(1) aka
> the pooling interval.
> 
> 
> John Ogness (1):
>   printk: flush consoles before checking progress
> 
> Petr Mladek (1):
>   printk: Reduce pr_flush() pooling time

JFYI, the patchset has been committed into printk/linux.git,
branch rework/misc-cleanups.

I am going to push it in the next merge window for 6.7.
IMHO, the issue is not critical and we are already at 6.6-rc5.

Best Regards,
Petr
