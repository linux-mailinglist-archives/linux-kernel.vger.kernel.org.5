Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FAA757937
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGRKXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGRKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:23:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559391A8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:23:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 01C142188A;
        Tue, 18 Jul 2023 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689675816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LvQ7gxvIfRJWJtKzj86mRWgvjuCV3Bsma1148iePS5A=;
        b=bl9kVrlHfh5tMopu71TPE7z5W7qicTb4SI48bClZWw9FWORvA4f0QuQB8ksCdO/DGP0pgF
        xIpjtdXhOuZV0O64rtmcAk9g9G7ZK6dzTc8LxQozei0/8LbRh9Us+qwffbXlvZjrj8Jbrf
        S3TSLg4cuTYYrI4oqgtNBQzP8OxLirU=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C75552C142;
        Tue, 18 Jul 2023 10:23:35 +0000 (UTC)
Date:   Tue, 18 Jul 2023 12:23:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 3/7] printk: Keep non-panic-CPUs out of console
 lock
Message-ID: <ZLZoJy8_meWUl9wv@alley>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
 <20230717194607.145135-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717194607.145135-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-17 21:52:03, John Ogness wrote:
> When in a panic situation, non-panic CPUs should avoid holding the
> console lock so as not to contend with the panic CPU. This is already
> implemented with abandon_console_lock_in_panic(), which is checked
> after each printed line. However, non-panic CPUs should also avoid
> trying to acquire the console lock during a panic.
> 
> Modify console_trylock() to fail and console_lock() to block() when
> called from a non-panic CPU during a panic.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
