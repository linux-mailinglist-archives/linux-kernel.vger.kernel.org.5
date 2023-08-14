Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48B077B5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjHNKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjHNKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:00:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73FEE65;
        Mon, 14 Aug 2023 03:00:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9AB7C1FD63;
        Mon, 14 Aug 2023 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692007210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SKHbbatD+xBAeEgFLQCyf9QhUR4G1GhnXboMbCKKiDg=;
        b=avT5gYoWsU8eHuitTfjgignOFwIVgbU/lTca1r7qjbmC3q1ZGAD0P6yUe8Wb1MaK37T4lM
        nJRe7+UredyuZCFgKZ8ycoAddQiOP54jaR9ow6aTgR7eYd2XQVwr7IkJH4AjSUAV9AHERn
        azVXDiIgCkV5tp2bjItw+OwiPo8OKEI=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A60E12C143;
        Mon, 14 Aug 2023 10:00:09 +0000 (UTC)
Date:   Mon, 14 Aug 2023 12:00:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] serial: 8250: drop lockdep annotation from
 serial8250_clear_IER()
Message-ID: <ZNn7KHY3iMRarqAZ@alley>
References: <20230811064340.13400-1-jirislaby@kernel.org>
 <878rae175n.fsf@jogness.linutronix.de>
 <7d8ae4f8-8900-5a06-5b7b-d4a3aea0673e@kernel.org>
 <87bkfa6nvx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkfa6nvx.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-14 10:21:14, John Ogness wrote:
> Hi Jiri,
> 
> Thanks for the follow-up. You responded faster than I could correct
> myself.
> 
> On 2023-08-14, Jiri Slaby <jirislaby@kernel.org> wrote:
> >>> The port lock is not always held when calling serial8250_clear_IER().
> >>> When an oops is in progress, the lock is tried to be taken and when it
> >>> is not, a warning is issued:
> >> 
> >>> The other option would be to make the lockdep test conditional on
> >>> 'oops_in_progress'
> 
> Actually I find this suggestion more appropriate. It makes it clear that
> we are willing to take such risks and do not want to see the warnings in
> a panic situation. However, I would end up having to revert that change
> as well, so it really does not matter to me at this point. Either way I
> will be reverting this patch.

A "solution" would be to move debug_locks_off() before bust_spinlocks(1)
in panic().

debug_locks_off() is currently called before console_flush_on_panic().
I guess that it is because it ignores the result of console_trylock().
But the particular console drivers ignore a trylock result on
the port_lock already after the earlier bust_spinlocks(1).

My concern is that it would hide any other potential races, for
example, in __crash_kexec() or panic notifiers. So, I think that
it might cause more harm then good. Especially because the race
is quite uncommon. It requires activity on the serial port from
two processes during panic().

I personally vote to keep it as is unless people see this warning
on daily basis. After all, the lockdep splat is correct. The serial
console might not work correctly in panic() when there is the race.

Best Regards,
Petr
