Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575D7803235
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjLDMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjLDMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:11:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A8E5;
        Mon,  4 Dec 2023 04:11:22 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D8B91F8A6;
        Mon,  4 Dec 2023 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701691880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxTUWdHIx6xxX7iZlpUHoKFG80kLdXjhaKtXPLn8ws4=;
        b=uFq8rxm+pamkzbrSlBWbhNk6X9kePTtzzfNTDEjQ5TM90jz76mmWEIPyl6e0F4Y+ijFpc0
        Yb1WUrtWT1EcVnujTM5UmYRM6fjJOZItU+CToU/OGPQ3NztLs0XKpSAiWYryK0rDHRHe6G
        wZ8lxFB0mlnWA+0lk/74j8HDuKM0p2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701691880;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxTUWdHIx6xxX7iZlpUHoKFG80kLdXjhaKtXPLn8ws4=;
        b=B8ysIvT1UHTOEG1B88VZ4Di3VCaA2VlxLOCSxWQcQ09vJ9txnYpN5CoXv0mAfmQk27BflX
        G3d54fWVSpZ46xAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C42E139E2;
        Mon,  4 Dec 2023 12:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id MGpgIujBbWXyXwAAn2gu4w
        (envelope-from <jack@suse.cz>); Mon, 04 Dec 2023 12:11:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F868A07DB; Mon,  4 Dec 2023 13:11:20 +0100 (CET)
Date:   Mon, 4 Dec 2023 13:11:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <20231204121120.mpxntey47rluhcfi@quack3>
References: <20231202091432.8349-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202091432.8349-1-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[13];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,mit.edu,dilger.ca,suse.cz,infradead.org,linux-foundation.org,gmail.com,huawei.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat 02-12-23 17:14:30, Baokun Li wrote:
> Recently, while running some pressure tests on MYSQL, noticed that
> occasionally a "corrupted data in log event" error would be reported.
> After analyzing the error, I found that extending DIO write and buffered
> read were competing, resulting in some zero-filled page end being read.
> Since ext4 buffered read doesn't hold an inode lock, and there is no
> field in the page to indicate the valid data size, it seems to me that
> it is impossible to solve this problem perfectly without changing these
> two things.

Yes, combining buffered reads with direct IO writes is a recipe for
problems and pretty much in the "don't do it" territory. So honestly I'd
consider this a MYSQL bug. Were you able to identify why does MYSQL use
buffered read in this case? It is just something specific to the test
you're doing?

> In this series, the first patch reads the inode size twice, and takes the
> smaller of the two values as the copyout limit to avoid copying data that
> was not actually read (0-padding) into the user buffer and causing data
> corruption. This greatly reduces the probability of problems under 4k
> page. However, the problem is still easily triggered under 64k page.
> 
> The second patch waits for the existing dio write to complete and
> invalidate the stale page cache before performing a new buffered read
> in ext4, avoiding data corruption by copying the stale page cache to
> the user buffer. This makes it much less likely that the problem will
> be triggered in a 64k page.
> 
> Do we have a plan to add a lock to the ext4 buffered read or a field in
> the page that indicates the size of the valid data in the page? Or does
> anyone have a better idea?

No, there are no plans to address this AFAIK. Because such locking will
slow down all the well behaved applications to fix a corner case for
application doing unsupported things. Sure we must not crash the kernel,
corrupt the filesystem or leak sensitive (e.g. uninitialized) data if app
combines buffered and direct IO but returning zeros instead of valid data
is in my opinion fully within the range of acceptable behavior for such
case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
