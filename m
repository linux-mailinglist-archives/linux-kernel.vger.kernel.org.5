Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF087908CD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjIBRG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:06:58 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA4E5B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 10:06:55 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RdLsm14XCz5l;
        Sat,  2 Sep 2023 19:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693674412; bh=k2B3ojuBo5bq1G8Wcln0tjJf8sAXZP+Jp0k3LQVmjsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0zam5A7QVFQVJua91IzXnufTBI1ZSY6QE4NtLbMIGYwfifB7spawe6QCJ1zkLv1a
         olIwPSX2Er4KzpMv6/0pqEJpKMlkZidsg28P3+34dQhGsPhN1k36OmTdNu4cgemItM
         TOQIVNfihmU0dyFSK9y8nk883Hf+tMVtr5iRdtcW3pyObE9/alB8sn2qTU2zewO3a9
         bZDcWtUYfKpV8VnKpJnZm9IZRQGRxe0uK2Au/1FmrlzLfRpeSvLkQMWD3sR9UF46tg
         o3aG5QwyLmr4AWp/f3+bbTgQMShhffcCK6ezs2vKbH4VBsBiHry5wm/joVnqKqc7SQ
         u9IZLjk+gAQEQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 2 Sep 2023 19:06:49 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/mutex: remove redundant argument from
 __mutex_lock_common()
Message-ID: <ZPNrqZokdzpuyAqR@qmqm.qmqm.pl>
References: <76a1d64e683ee9a9f507114dfbc2d5121da8c3f3.1693433504.git.mirq-linux@rere.qmqm.pl>
 <cdb0df68-ed29-18d2-22af-12253a4ec659@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdb0df68-ed29-18d2-22af-12253a4ec659@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 07:54:13PM -0400, Waiman Long wrote:
> On 8/30/23 18:12, Micha³ Miros³aw wrote:
> > use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
> > use_ww_ctx was true but ww_ctx == NULL leads to the same
> > __mutex_add_waiter() call via __ww_mutex_add_waiter().
> I think ww_mutex_lock() can be called with a NULL ctx. Your patch will
> effectively change those ww_mutex_lock() to be equivalent to mutex_lock().
> So it is a behavioral change.

Isn't ww_mutex_lock() with ctx = NULL expected to behave like mutex_lock()?

> > Since now __ww_mutex_add_waiter() is called only with ww_mutex != NULL,
> > remove the branch there.
[...]
> > @@ -627,12 +624,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> >   	debug_mutex_lock_common(lock, &waiter);
> >   	waiter.task = current;
> > -	if (use_ww_ctx)
> > -		waiter.ww_ctx = ww_ctx;
> > +	waiter.ww_ctx = ww_ctx;
> This one is fine.
> >   	lock_contended(&lock->dep_map, ip);
> > -	if (!use_ww_ctx) {
> > +	if (!ww_ctx) {
> That change will break ww_mutex.

I see that there is the rt_mutex version that stubs out
__ww_mutex_add_waiter(), but its ww_mutex_lock() doesn't use
__mutex_lock_common() at all. With the RT version out of the picture, we
can see that __ww_mutex_add_waiter(), when passed ww_ctx == NULL, just
forwards the work to __ww_waiter_add() with the same arguments
and returns 0 -- making the path exactly as the !use_ww_ctx branch.

Note: There is a lot of templating-via-preprocessor code here and I
might have missed something. I'll appreciate hints here as maybe it
could be made simpler or better understood.

Best Regards
Micha³ Miros³aw
