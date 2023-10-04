Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C07B7F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbjJDMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJDMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:39:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6825A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:39:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3852821838;
        Wed,  4 Oct 2023 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696423173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLNINpIKof+eEy/1RFZQDSKVWzj5eMFFhG6a4cq09TY=;
        b=EkMWDXF0BLTJnRvfOgbX4KJDouKYco9QVrz2ET01vlWb3XXz2+JkLtxbr8c/Q9Onbf2lBM
        O3zvLnwIJ8PUnq0wuEHpxd38UWLFdrVBGFGA4t+qqUwOZhp2eBBxZ+8d3VndHBrhUy6PlJ
        V+JbqToaN5T3vE+pV0szQFEzlR7jaWM=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C50342C142;
        Wed,  4 Oct 2023 12:39:32 +0000 (UTC)
Date:   Wed, 4 Oct 2023 14:39:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH printk] printk: flush consoles before checking progress
Message-ID: <ZR1dBAOMmMUNgY6Q@alley>
References: <20230929113233.863824-1-john.ogness@linutronix.de>
 <ZRrAFS3cELj1DDN2@alley>
 <87h6n64rcs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6n64rcs.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-04 12:31:07, John Ogness wrote:
> On 2023-10-02, Petr Mladek <pmladek@suse.com> wrote:
> > I was about to push this patch and ran checkpatch.pl. It warned about
> >
> > WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
> > #73: FILE: kernel/printk/printk.c:3782:
> > +               msleep(1);
> >
> > And indeed, Documentation/timers/timers-howto.rst says that msleep()
> > might sleep longer that expected for <20ms delays. I guess that
> > it is somehow related to jiffies, HZ, and load on the system.
> >
> > I think that we need to count jiffies here.
> 
> Agreed. The @timeout_ms parameter should be respected.
> 
> > Something like:
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index db81b68d7f14..6ea500d95fd9 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3772,24 +3773,19 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >  		console_srcu_read_unlock(cookie);
> >  
> >  		if (diff != last_diff && reset_on_progress)
> > -			remaining = timeout_ms;
> > +			timeout_end = jiffies + timeout_jiffies;
> >  
> >  		console_unlock();
> >  
> >  		/* Note: @diff is 0 if there are no usable consoles. */
> > -		if (diff == 0 || remaining == 0)
> > +		if (diff == 0)
> >  			break;
> >  
> > -		if (remaining < 0) {
> > -			/* no timeout limit */
> > -			msleep(100);
> > -		} else if (remaining < 100) {
> > -			msleep(remaining);
> > -			remaining = 0;
> > -		} else {
> > -			msleep(100);
> > -			remaining -= 100;
> > -		}
> > +		/* Negative timeout means an infinite wait. */
> > +		if (timeout_ms >= 0 && time_after_eq(jiffies, timeout_end))
> > +			break;
> > +
> > +		msleep(2000 / HZ);
> 
> Is there really any advantage to this? I would just do msleep(1) and let
> msleep round up. Everything else (tracking via jiffies) looks fine to me.

It was attempt to synchronize it with a scheduler tick. I saw it somewhere ;-)
But you are right. Let's keep it simple and use msleep(1).


> >  		last_diff = diff;
> >  	}
> >
> > And we should do this in a separate patch. It seems that sleeping
> > is a bigger magic than I expected.
> 
> Agreed.

Are you going to prepare them or should I?

Best Regards,
Petr
