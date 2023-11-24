Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06087F6C26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjKXGJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjKXGIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:08:45 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5803C16;
        Thu, 23 Nov 2023 22:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mP6tVCRmngSxX4zTF9VuSA3p674+lSRAQ1st0EqnsFM=; b=uB4iQY+2ZH8iT871ljEez2FYS3
        4afnkh/cdZOtfAuGbtt/2IAYazjF95yH+JMC2bL5Df4fZ6HoJP8d3qJTO35/t43Oo1oYtynDvgBw1
        quPS0Z30iLcx7uKjdlf4hJ38mS6nZG/KVoQsFGRIRdx6B9ar6SpbfQ8T1/Kph2h58G5JKSGqkiUrC
        QpfVNU4e3Q1jU2rr28Rg9HEs1EObg8yUSYL1eXzge7Kr4jBb6mYCnqsIw8m6CZsglPvXDdZsVNfIF
        yZorUHpDVs8jdQbllfxpHBUqy2I7ZfzJEp6cFEjhr2noMyLrspQEAUcPUCgPFApHTkus6r+MNJW8x
        qNKVy05A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PK5-002PyS-2o;
        Fri, 24 Nov 2023 06:05:54 +0000
Date:   Fri, 24 Nov 2023 06:05:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHES] assorted dcache stuff
Message-ID: <20231124060553.GA575483@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted dcache cleanups.  There's a couple of commits that live in
never-rebased branches shared with selinux and overlayfs trees resp.

	Lives in #work.dcache-misc, #no-rebase-overlayfs, #merged-selinux
and #work.dcache (all pulled by the last one, as is #work.dcache2) in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
Individual patches in followups.  Review and testing would be very welcome;
it survives the local beating, but the more the better...

Diffstat (sans #work.dcache2):

 fs/dcache.c                  | 157 +++++++++++++++----------------------------
 fs/file_table.c              |   5 --
 fs/internal.h                |   5 ++
 fs/libfs.c                   |  17 ++---
 fs/nsfs.c                    |   7 +-
 fs/overlayfs/export.c        |  23 +------
 include/linux/dcache.h       | 142 +++++++++++++++++---------------------
 security/selinux/selinuxfs.c | 144 ++++++++++++++++++---------------------
 8 files changed, 194 insertions(+), 306 deletions(-)

Shortlog (again, excluding #work.dcache2):

Al Viro (21):
      selinux: saner handling of policy reloads
      struct dentry: get rid of randomize_layout idiocy
      get rid of __dget()
      DCACHE_... ->d_flags bits: switch to BIT()
      DCACHE_COOKIE: RIP
      kill d_{is,set}_fallthru()
      dentry.h: trim externs
      [software coproarchaeology] dentry.h: kill a mysterious comment
      kill d_backing_dentry()
      Merge branch 'no-rebase-overlayfs' into work.dcache-misc
      kill d_instantate_anon(), fold __d_instantiate_anon() into remaining caller
      d_alloc_pseudo(): move setting ->d_op there from the (sole) caller
      nsfs: use d_make_root()
      Merge branch 'merged-selinux' into work.dcache-misc
      simple_fill_super(): don't bother with d_genocide() on failure
      d_genocide(): move the extern into fs/internal.h
      get rid of DCACHE_GENOCIDE
      d_alloc_parallel(): in-lookup hash insertion doesn't need an RCU variant
      __d_unalias() doesn't use inode argument
      Merge branch 'work.dcache2' into work.dcache
      kill DCACHE_MAY_FREE

Amir Goldstein (1):
      ovl: stop using d_alloc_anon()/d_instantiate_anon()

Vegard Nossum (1):
      dcache: remove unnecessary NULL check in dget_dlock()

[merged-selinux]
1/#) selinux: saner handling of policy reloads
	Fix abuses of lock_rename() and d_genocide() in there.

[no-rebase-overlayfs]
2/#) ovl: stop using d_alloc_anon()/d_instantiate_anon()
	Switch overlayfs to d_obtain_alias(); overlayfs used keep a data
structure (struct ovl_entry) hanging off a dentry, which prevented the
use of d_obtain_alias() there.
	We couldn't call d_obtain_alias() and attach struct ovl_entry to
resulting dentry - new dentry would be exposed as an inode alias while
still not in a usable state.
	These days ovl_entry got moved to their inodes and the rest
of the things done in ovl_obtain_alias() turned out to be not needed.
The bottom line: ovl_obtain_alias() can use straight d_obtain_alias()
and doesn't need an access to the guts of that primitive.

[work.dcache-misc]
[the first two used to be in #work.dcache2]
3/#) struct dentry: get rid of randomize_layout idiocy
        This is beyond ridiculous.  There is a reason why that thing
is cacheline-aligned...

4/#) get rid of __dget()
	fold into the sole remaining caller

5/#) DCACHE_... ->d_flags bits: switch to BIT()
	For bits 20..22 (inode type cached in ->d_flags) turn the
definitions into expressions like (5 << 20); everything else turns into
straight use of BIT()

6/#) DCACHE_COOKIE: RIP
	the last user gone in 2021...

7/#) kill d_{is,set}_fallthru()
	Introduced in 2015 and never had any in-tree users...

8/#) dentry.h: trim externs
	d_instantiate_unique() had been gone for 7 years; __d_lookup...()
and shrink_dcache_for_umount() are fs/internal.h fodder.

9/#) [software coproarchaeology] dentry.h: kill a mysterious comment
	there's a strange comment in front of d_lookup() declaration:
/* appendix may either be NULL or be used for transname suffixes */
	Looks like nobody had been curious enough to track its history;
it predates git, it predates bitkeeper and if you look through the
pre-BK trees, you finally arrive at this in 2.1.44-for-davem:
  /* appendix may either be NULL or be used for transname suffixes */
 -extern struct dentry * d_lookup(struct inode * dir, struct qstr * name,
 -                               struct qstr * appendix);
 +extern struct dentry * d_lookup(struct dentry * dir, struct qstr * name);
In other words, it refers to the third argument d_lookup() used to have
back then.  It had been introduced in 2.1.43-pre, on June 12 1997,
along with d_lookup(), only to be removed by July 4 1997, presumably
when the Cthulhu-awful thing it used to be used for (look for
CONFIG_TRANS_NAMES in 2.1.43-pre, and keep a heavy-duty barfbag
ready) had been, er, noticed and recognized for what it had been.
Despite the appendectomy, the comment remained.  Some things really
need to be put out of their misery...

10/#) kill d_backing_dentry()
	no users left

11/#) kill d_instantate_anon(), fold __d_instantiate_anon() into remaining caller
	now that the only user of d_instantiate_anon() is gone...

12/#) d_alloc_pseudo(): move setting ->d_op there from the (sole) caller
	more obviously safe there...

13/#) nsfs: use d_make_root()
	Normally d_make_root() is used to create the root dentry of superblock;
here we use it for a different purpose, but... idiomatic or not, we need the
same operation.

14/#) simple_fill_super(): don't bother with d_genocide() on failure
	Failing ->fill_super() will be followed by ->kill_sb(), which should
include kill_litter_super() if the call of simple_fill_super() had been asked
to create anything besides the root dentry.  So there's no need to empty the
partially populated tree - it will be trimmed by inevitable kill_litter_super().

15/#) d_genocide(): move the extern into fs/internal.h
	... now that the only user is in fs/super.c

16/#) get rid of DCACHE_GENOCIDE
	... now that we never call d_genocide() other than from kill_litter_super()

17/#) d_alloc_parallel(): in-lookup hash insertion doesn't need an RCU variant
	We only search in the damn thing under hlist_bl_lock(); RCU variant
of insertion was, IIRC, pretty much cargo-culted - mea culpa...

18/#) __d_unalias() doesn't use inode argument
	... and hasn't since 2015.

At that point #work.dcache-misc merges with #work.dcache2 into #work.dcache,
with two followups:

19/#) kill DCACHE_MAY_FREE
	Redundant with new ordering in __dentry_kill()

20/#) dcache: remove unnecessary NULL check in dget_dlock()
	dget_dlock() requires dentry->d_lock to be held when called,
yet contains a NULL check for dentry.  After taking out the NULL check,
dget_dlock() becomes almost identical to __dget_dlock(); the only
difference is that dget_dlock() returns the dentry that was passed
in. These are static inline helpers, so we can rely on the compiler to
discard unused return values. We can therefore also remove __dget_dlock()
and replace calls to it by dget_dlock().
