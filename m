Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30BB7C5390
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbjJKMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjJKMUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:20:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CE270E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:11:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2DC01210E1;
        Wed, 11 Oct 2023 12:10:41 +0000 (UTC)
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D78002C6A1;
        Wed, 11 Oct 2023 12:10:40 +0000 (UTC)
Date:   Wed, 11 Oct 2023 14:10:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] printk: Reduce unnecessary wait times by
 pr_flush()
Message-ID: <ZSaQv46h_aMcLHk1@alley>
References: <20231006082151.6969-1-pmladek@suse.com>
 <ZSUPBiTXY486H1FV@alley>
 <87cyxmso5d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyxmso5d.fsf@jogness.linutronix.de>
X-Spamd-Bar: ++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [16.94 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCPT_COUNT_FIVE(0.00)[6];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         BLOCKLISTDE_FAIL(0.00)[149.44.160.134:query timed out];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         R_DKIM_NA(0.20)[];
         RCVD_COUNT_TWO(0.00)[2];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-1.56)[92.18%]
X-Spam-Score: 16.94
X-Rspamd-Queue-Id: 2DC01210E1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-10-10 13:44:38, John Ogness wrote:
> On 2023-10-10, Petr Mladek <pmladek@suse.com> wrote:
> >> This is an updated version of the patch
> >> https://lore.kernel.org/r/20230929113233.863824-1-john.ogness@linutronix.de
> >> 
> >> Changes since v1:
> >> 
> >>   + Split reduction of the pooling time into separate patch.
> >>   + Use jiffies to count the real sleeping time.
> >> 
> >> Note that my original POC counted jiffies spent in the entire cycle.
> >> It would count also the time spent by console_lock() and by flushing
> >> the legacy consoles in console_unlock().
> >> 
> >> The current version counts only the time spent by msleep(1) aka
> >> the pooling interval.
> >> 
> >> 
> >> John Ogness (1):
> >>   printk: flush consoles before checking progress
> >> 
> >> Petr Mladek (1):
> >>   printk: Reduce pr_flush() pooling time
> >
> > JFYI, the patchset has been committed into printk/linux.git,
> > branch rework/misc-cleanups.
> >
> > I am going to push it in the next merge window for 6.7.
> > IMHO, the issue is not critical and we are already at 6.6-rc5.
> 
> It is a real regression. I think it is important that it goes into
> 6.6. At least the first patch is simple enough and fixes the regression.

Fair enough. I have crated pull request with the 1st patch for
6.6-rc6, see ZSaPGo13Fz9TLUc6@alley.

Note that I rebased the branch rework/misc-cleanups in
printk/linux.git to be able to crate a merge with the 1st patch only.
I am not sure if it could have been done without the rebase.

Best Regards,
Petr
