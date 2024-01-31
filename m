Return-Path: <linux-kernel+bounces-46904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB6844618
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1DA1F27884
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8612DDB3;
	Wed, 31 Jan 2024 17:26:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EA12DD92;
	Wed, 31 Jan 2024 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721966; cv=none; b=QzZGYEdJqavkEkYGG0Bq2su81RinyaUr2vDCX+FUZBXmAjre02HlyyVpTX3IJ8s67b+lp1vrQwJI+vQ5/187VWnwB+IGpiU7G+TkHe+gadptBdAt4abh7RxnYjoFrDWBF63b3ChIR9mO7/mbM3X0TsWLl+ME++PsOIAEfQGhoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721966; c=relaxed/simple;
	bh=Tv/OIdhU0ncVmP7nGCQx/bdXuPecUNW1V8ksBVTdZoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyyxenD+Sk5MuPmIATCrVeU8zGQdOQZiFyCFRpDhYex0bm1cxWMZL+wZWB22PJ9SIhyhiSRDteXAivesHaTxMU2IKMoDe3Ot+c88SvzxtVSVBhXH0UjfbeuXdiBaIyZqHycl5nXgdirPmdtcbW5mJCdHHAe+EBjpPmktd7eesM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A4C433F1;
	Wed, 31 Jan 2024 17:26:04 +0000 (UTC)
Date: Wed, 31 Jan 2024 12:26:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240131122618.7c533387@gandalf.local.home>
In-Reply-To: <20240131105847.3e9afcb8@gandalf.local.home>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
	<20240129174950.5a17a86c@gandalf.local.home>
	<CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
	<20240130132319.022817e8@gandalf.local.home>
	<CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
	<20240130143734.31b9b3f1@gandalf.local.home>
	<CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
	<20240131105847.3e9afcb8@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:58:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> BTW, I ran my full test suite on your patches with the below updates and it
> all passed. Note, I did not run the "bisectable" portion of my test. That
> is, the part that runs tests on each patch in the series. Because I know
> that fails. I just ran the tests on the last applied patch.
> 
> I can break up and clean up the patches so that they are bisectable, and if
> that passes the bisectable portion of my tests, I can still send them to
> you for 6.8. I think this does fix a lot of hidden bugs, and would like all
> this to go back to 6.6 when the eventfs was first introduced.

So I swapped the order of patch 5 and patch 6, and it appears that patch 6
works without 5 (with some massaging).

Here's the new patch 6 without patch 5, and now patch 5 just finishes the
rest of the changes.

I'll post this series, pull it in through my normal work flow, and rerun
the full test suite with the bisecting check as well.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0289ec787367..0213a3375d53 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -378,13 +378,12 @@ static void free_ei(struct eventfs_inode *ei)
 }
 
 /**
- * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
- * @ti: the tracefs_inode of the dentry
+ * eventfs_d_release - dentry is going away
  * @dentry: dentry which has the reference to remove.
  *
  * Remove the association between a dentry from an eventfs_inode.
  */
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
+void eventfs_d_release(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 	int i;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index f403d32bd7cd..cf90ea86baf8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -377,21 +377,30 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
-static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+/*
+ * It would be cleaner if eventfs had its own dentry ops.
+ *
+ * Note that d_revalidate is called potentially under RCU,
+ * so it can't take the eventfs mutex etc. It's fine - if
+ * we open a file just as it's marked dead, things will
+ * still work just fine, and just see the old stale case.
+ */
+static void tracefs_d_release(struct dentry *dentry)
 {
-	struct tracefs_inode *ti;
+	if (dentry->d_fsdata)
+		eventfs_d_release(dentry);
+}
 
-	if (!dentry || !inode)
-		return;
+static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct eventfs_inode *ei = dentry->d_fsdata;
 
-	ti = get_tracefs(inode);
-	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ei_status_free(ti, dentry);
-	iput(inode);
+	return !(ei && ei->is_freed);
 }
 
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_dentry_iput,
+	.d_revalidate = tracefs_d_revalidate,
+	.d_release = tracefs_d_release,
 };
 
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 9e64ca4829c7..687faba9807b 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -77,6 +77,7 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
+
+void eventfs_d_release(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */

