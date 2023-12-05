Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5D804CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjLEIs0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 03:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjLEIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:48:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D511F;
        Tue,  5 Dec 2023 00:48:29 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B63521F68;
        Tue,  5 Dec 2023 08:48:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64156136CF;
        Tue,  5 Dec 2023 08:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id YFqqBdfjbmWZQQAAD6G6ig
        (envelope-from <neilb@suse.de>); Tue, 05 Dec 2023 08:48:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>, "Oleg Nesterov" <oleg@redhat.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
In-reply-to: <ZW7GKku/F2QK9MrC@dread.disaster.area>
References: <20231204014042.6754-1-neilb@suse.de>,
 <20231204014042.6754-2-neilb@suse.de>, <ZW7GKku/F2QK9MrC@dread.disaster.area>
Date:   Tue, 05 Dec 2023 19:48:20 +1100
Message-id: <170176610023.7109.11175368186869568821@noble.neil.brown.name>
X-Spamd-Bar: ++++++++++
X-Spam-Score: 10.29
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 2B63521F68
X-Spamd-Result: default: False [10.29 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[14];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023, Dave Chinner wrote:
> On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> > User-space processes always call task_work_run() as needed when
> > returning from a system call.  Kernel-threads generally do not.
> > Because of this some work that is best run in the task_works context
> > (guaranteed that no locks are held) cannot be queued to task_works from
> > kernel threads and so are queued to a (single) work_time to be managed
> > on a work queue.
> > 
> > This means that any cost for doing the work is not imposed on the kernel
> > thread, and importantly excessive amounts of work cannot apply
> > back-pressure to reduce the amount of new work queued.
> > 
> > I have evidence from a customer site when nfsd (which runs as kernel
> > threads) is being asked to modify many millions of files which causes
> > sufficient memory pressure that some cache (in XFS I think) gets cleaned
> > earlier than would be ideal.  When __dput (from the workqueue) calls
> > __dentry_kill, xfs_fs_destroy_inode() needs to synchronously read back
> > previously cached info from storage.
> 
> We fixed that specific XFS problem in 5.9.
> 
> https://lore.kernel.org/linux-xfs/20200622081605.1818434-1-david@fromorbit.com/

Good to know - thanks.

> 
> Can you reproduce these issues on a current TOT kernel?

I haven't tried.  I don't know if I know enough details of the work load
to attempt it.

> 
> If not, there's no bugs to fix in the upstream kernel. If you can,
> then we've got more XFS issues to work through and fix. 
> 
> Fundamentally, though, we should not be papering over an XFS issue
> by changing how core task_work infrastructure is used. So let's deal
> with the XFS issue first....

I disagree.  This customer experience has demonstrated both a bug in XFS
and bug in the interaction between fput, task_work, and nfsd.

If a bug in a filesystem that only causes a modest performance impact
when used through the syscall API can bring the system to its knees
through memory exhaustion when used by nfsd, then that is a robustness
issue for nfsd.

I want to fix that robustness issue so that unusual behaviour in
filesystems does not cause out-of-proportion bad behaviour in nfsd.

I highlighted this in the cover letter to the first version of my patch:

https://lore.kernel.org/all/170112272125.7109.6245462722883333440@noble.neil.brown.name/

  While this might point to a problem with the filesystem not handling the
  final close efficiently, such problems should only hurt throughput, not
  lead to memory exhaustion.

Thanks,
NeilBrown


> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

