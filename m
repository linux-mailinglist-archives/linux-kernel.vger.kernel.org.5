Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AEF7D7E12
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjJZIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZIHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:07:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0DAB8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:07:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7AAB421B3F;
        Thu, 26 Oct 2023 08:07:08 +0000 (UTC)
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BE9052C7AE;
        Thu, 26 Oct 2023 08:07:07 +0000 (UTC)
Date:   Thu, 26 Oct 2023 10:07:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>,
        Chunlei Wang <chunlei.wang@mediatek.com>
Subject: Re: [RFC PATCH printk v1] printk: ringbuffer: Do not skip
 non-finalized with prb_next_seq()
Message-ID: <ZToeK130KtWvcTx3@alley>
References: <20231019132545.1190490-1-john.ogness@linutronix.de>
 <ZTkxOJbDLPy12n41@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTkxOJbDLPy12n41@alley>
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
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 7AAB421B3F
X-Spam: Yes
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-25 17:16:09, Petr Mladek wrote:
> On Thu 2023-10-19 15:31:45, John Ogness wrote:
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > +static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
> > +			    struct printk_record *r, unsigned int *line_count);
> > +
> > +/*
> > + * Check if there are records directly following @last_finalized_seq that are
> > + * finalized. If so, update @last_finalized_seq to the latest of these
> > + * records. It is not allowed to skip over records that are not yet finalized.
> 
> I would add some details about what expect from this value. Something
> like:
> 
>  * @last_finalized_seq value guarantees that all records up to this
>  * sequence number are finalized and might be read. The only exception
>  * are too old records which have already been overwritten.
>  *
>  * Also it is guaranteed that the value can only grow.
>  *
>  * But it is just a best effort. There is _no_ synchronization between
>  * writers finalizing records and @last_finalized_seq updates. The result
>  * might be a lower value because updaters might not see finalized
>  * records from other CPUs.
>  *
>  * There is _no_ easy way to serialize these two operations. It would
>  * require to remember two values which might be called handled in:
>  *
>  *   @last_finalized_id in desc_make_final()
>  *   @last_readable_seq in desc_update_last_readable_seq()
>  *
>  * and these two values would need to be updated atomically together
>  * so that only the last updater of the @id part would be allowed
>  * to update the @seq part. Also it would require a barrier so
>  * that each writer would see the finalized state from other
>  * writers whom updated the @id part earlier.
>  *
>  * Summary:
>  *
>  * This value might be used by readers only to check the last
>  * readable seq number at the given time. They must count with
>  * the fact that new records might appear at any time.
>  *
>  * Beware that this value is not increased with every finalized
>  * record. It stays the same when there are not-yet-finalized
>  * records with lower sequence number.
>  *
>  * In particular, it does not guarantee that readers woken
>  * via wake_up_klogd would be able to flush all messages
>  * up to the one just stored by vprintk_store(). For example,
>  * it does not guarantee that console_unlock() would flush
>  * all pending messages.
>  */

The last paragraph sounds scary. But it is a pretty old problem.
I was curious why nobody noticed it.

IMHO, we are mostly safe in practice because:

   1. Every printk() either tries to flush the consoles or
      queues irq_work to do a deferred flush.

   2. Every printk() calls wake_up_klogd() to wake user space
      log daemons.

   3. console_unlock() checks prb_next_seq() after releasing
      the semaphore. It goes back and flushes any message
      finalized in parallel or the parallel writer is able
      to take the console semaphore.

By other words, even when one flush is not able to flush
everything there always should be scheduled someone
who would flush the rest in a near future.

The only problem might be a missing barrier when some CPU
sees a finalized record and others do not see it. But it is
probably very hard to hit in practice.

Anyway, I haven't been aware about this prb_next_seq() limitation
until last week. We should keep it in mind or improve it.
But it seems that it is not that critical in the end.

Best Regards,
Petr
