Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865775793F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGRK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGRK2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:28:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57361B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:28:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 734C321880;
        Tue, 18 Jul 2023 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689676124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=50UkDd30LUCKJrV0PxCEUFi1cZLFwTdFg/ishYaBuTs=;
        b=UBKIFE/N5zIQI0Z9Yipqv5tYmSzOr3YJ8CsELBI90i3PU9lqLxeKZwE0gd2LKfhbYN+lD9
        CMUD2JHM2ezW8rPLsza3pAfwL3hG0m7eub+e6YRtZfeX5yCW57rR6q+WUY/P/2QddxLWXt
        BpbWb3j5vFFobh+A50/rlSrp2NVUQcI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4EB822C142;
        Tue, 18 Jul 2023 10:28:44 +0000 (UTC)
Date:   Tue, 18 Jul 2023 12:28:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 4/7] printk: Do not take console lock for
 console_flush_on_panic()
Message-ID: <ZLZpW1PKsL8QlsxI@alley>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
 <20230717194607.145135-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717194607.145135-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-17 21:52:04, John Ogness wrote:
> Currently console_flush_on_panic() will attempt to acquire the
> console lock when flushing the buffer on panic. If it fails to
> acquire the lock, it continues anyway because this is the last
> chance to get any pending records printed.
> 
> The reason why the console lock was attempted at all was to
> prevent any other CPUs from acquiring the console lock for
> printing while the panic CPU was printing. But as of the
> previous commit, non-panic CPUs will no longer attempt to
> acquire the console lock in a panic situation. Therefore it is
> no longer strictly necessary for a panic CPU to acquire the
> console lock.
> 
> Avoiding taking the console lock when flushing in panic has
> the additional benefit of avoiding possible deadlocks due to
> semaphore usage in NMI context (semaphores are not NMI-safe)
> and avoiding possible deadlocks if another CPU accesses the
> semaphore and is stopped while holding one of the semaphore's
> internal spinlocks.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
