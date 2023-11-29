Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE177FCB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjK2AO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2AOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:14:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD419A6;
        Tue, 28 Nov 2023 16:14:31 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56B621F8A6;
        Wed, 29 Nov 2023 00:14:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCD8E13637;
        Wed, 29 Nov 2023 00:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id Xx3pHmGCZmUqZwAAD6G6ig
        (envelope-from <neilb@suse.de>); Wed, 29 Nov 2023 00:14:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Oleg Nesterov" <oleg@redhat.com>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <20231128140156.GC22743@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <20231128140156.GC22743@redhat.com>
Date:   Wed, 29 Nov 2023 11:14:22 +1100
Message-id: <170121686264.7109.13475581089284671405@noble.neil.brown.name>
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Queue-Id: 56B621F8A6
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023, Oleg Nesterov wrote:
> On 11/28, NeilBrown wrote:
> >
> > I have evidence from a customer site of 256 nfsd threads adding files to
> > delayed_fput_lists nearly twice as fast they are retired by a single
> > work-queue thread running delayed_fput().  As you might imagine this
> > does not end well (20 million files in the queue at the time a snapshot
> > was taken for analysis).
> 
> On a related note... Neil, Al, et al, can you look at
> 
> 	[PATCH 1/3] fput: don't abuse task_work_add() when possible
> 	https://lore.kernel.org/all/20150908171446.GA14589@redhat.com/
> 

Would it make sense to create a separate task_struct->delayed_fput
llist?
fput() adds the file to this llist and if it was the first item on the
list, it then adds the task_work.  That would probably request adding a
callback_head to struct task_struct as well.

NeilBrown
