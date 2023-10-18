Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84847CDFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbjJROc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjJROcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:32:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEB79ED3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:20:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12636219FC;
        Wed, 18 Oct 2023 14:20:41 +0000 (UTC)
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A6C742C21E;
        Wed, 18 Oct 2023 14:20:40 +0000 (UTC)
Date:   Wed, 18 Oct 2023 16:20:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
Message-ID: <ZS_puLYK4TZR12Cx@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley>
 <87mswh6iwq.fsf@jogness.linutronix.de>
 <ZS_Vg4vvT29LxWSD@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS_Vg4vvT29LxWSD@alley>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCPT_COUNT_FIVE(0.00)[5];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-0.00)[26.37%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 12636219FC
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-18 14:54:29, Petr Mladek wrote:
> On Tue 2023-10-17 23:31:25, John Ogness wrote:
> > On 2023-10-17, Petr Mladek <pmladek@suse.com> wrote:
> > > BTW: The support for data-less records were added by the commit
> > >      ("printk: ringbuffer: support dataless records"). It was
> > >      needed to handle empty lines: printk("\n"). It is strange
> > >      that we skip them instead of printing the empty line.
> > 
> > We do not skip them. That was the whole point of adding support for
> > data-less records. ;-)
> > 
> > get_data() returns "" and @data_size=0

Ah, I see it now. The code really handles printk("\n") correctly.

There are two types of dataless records:

      + #define NO_LPOS 0x3. It is used for storing zero size data.

      + #define FAILED_LPOS 0x1. It is used when the code failed
	  to allocate enough space on the ring buffer or when
	  they were overwritten.

BLK_DATALESS() returns true for both of them.

Sigh, we should really distinguish in the comments when functions
handle the two situations different way. Especially we should not
use the ambiguous "dataless record" word.

I think about "empty line record" and "records with missing data".
And I would rename NO_LPOS to EMPTY_LINE_LPOS to make the meaning
more obvious.

Also it would make sense to use 0x2 for EMPTY_LINE_LPOS and

#define FAILED_LPOS		0x1
#define EMPTY_LINE_LPOS		0x2
#define DATALESS_LPOS_MASK	(FAILED_LPOS | EMPTY_LINE_LPOS)

#define LPOS_DATALESS(lpos)	((lpos) & DATALESS_LPOS_MASK)

> > copy_data() returns true (but does not copy any data)
> > 
> > prb_read() returns true (we are assuming it is finalized)
> > 
> > _prb_read_valid() returns true
> 
> This is not true if I read the code correctly.
> 
> > prb_read_valid() return true
> > 
> > record_print_text() creates a string with prefix and adds "\n"
> > 
> > printk_get_next_message() returns something to print

If we used the right terms in the comments then they might stay short
and still be clear.

Best Regards,
Petr
