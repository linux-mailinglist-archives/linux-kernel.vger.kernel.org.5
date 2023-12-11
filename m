Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7681A80DF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345259AbjLKXNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345301AbjLKXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:13:37 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA32E5;
        Mon, 11 Dec 2023 15:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4zzGhdcyxnMFmx+b16T6hcC16jA6EgRk42HHeuGbE7U=; b=Wg0i0Y2tv3w3mqeC5IfSmSkK+H
        5IlJ/oG++TmEYu/YYUWQRrJggoMAYapUa6I4m1BVxueC3ya0/vfIPZQif64putXQXoTaX11+v4+FX
        sHjm6uByj6tNOme0d8gyXeTvgRt/cudvRU3RnA/7Q+dsKlcOVF9CqFMjDjHF7PQ4VDDyL237mHmkQ
        NQ70H6CHKGyJQOtHOoquJHo6ac4O4Om0nPEBLtsOLl0KzeOR2YgKJe+kkXPHMMOjbjlgDmoo5yk4O
        lcXtHOzGh+leFF/vgt9ADktX84Tei8a9J6/68AFfXowNFuKg9qzQHLnWLtgl9YwEc9lOLuTqAbmUp
        quO0g56Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCpSs-00B2uk-2i;
        Mon, 11 Dec 2023 23:13:31 +0000
Date:   Mon, 11 Dec 2023 23:13:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <20231211231330.GE1674809@ZenIV>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
 <20231211191117.GD1674809@ZenIV>
 <170233343177.12910.2316815312951521227@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170233343177.12910.2316815312951521227@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 09:23:51AM +1100, NeilBrown wrote:

> Previously you've suggested problems with ->release blocking.
> Now you refer to lazy-umount, which is what the comment above
> __fput_sync() mentions.

Yes?  What I'm saying is that the set of locks involved is
too large for any sane analysis.  And lest you discard ->release(),
that brings ->i_rwsem, and thus anything that might be grabbed
under that.  Someone's ->mmap_lock, for example.

> "pretty much an locks" seems like hyperbole.  I don't see it taking
> nfsd_mutex or nlmsvc_mutex.

I don't know - and I can't tell without serious search.  What I can
tell is that before making fput() delayed we used to find deadlocks
on regular basis; that was a massive source of headache.

> Maybe you mean any filesystem lock?

Don't forget VM.  And drivers.  And there was quite a bit of fun
happening in net/unix, etc.  Sure, in case of nfsd the last two
_probably_ won't occur - not directly, anyway.

But making it a general nuisan^Wfacility is asking for trouble.

> My understanding is that the advent of vmalloc allocated stacks means
> that kernel stack space is not an important consideration.
> 
> It would really help if we could have clear documented explanation of
> what problems can occur.  Maybe an example of contexts where it isn't
> safe to call __fput_sync().
> 
> I can easily see that lazy-unmount is an interesting case which could
> easily catch people unawares.  Punting the tail end of mntput_no_expire
> (i.e.  if count reaches zero) to a workqueue/task_work makes sense and
> would be much less impact than punting every __fput to a workqueue.
> 
> Would that make an fput_now() call safe to use in most contexts, or is
> there something about ->release or dentry_kill() that can still cause
> problems?

dentry_kill() means ->d_release(), ->d_iput() and anything final iput()
could do.  Including e.g. anything that might be done by afs_silly_iput(),
with its "send REMOVE to server, wait for completion".  No, that's not
a deadlock per se, but it can stall you a bit more than you would
probably consider tolerable...  Sure, you could argue that AFS ought to
make that thing asynchronous, but...

Anyway, it won't be "safe to use in most contexts".  ->mmap_lock alone
is enough for that, and that's just the one I remember to have given
us a lot of headache.  And that's without bringing the "nfsd won't
touch those files" cases - make it generally accessible and you get
to audit all locks that might be taken when we close a socket, etc.
