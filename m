Return-Path: <linux-kernel+bounces-22530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE640829F11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0C21C20F67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A54EB28;
	Wed, 10 Jan 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YC7btwGA"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85A4EB22
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-122-95.bstnma.fios.verizon.net [173.48.122.95])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40AHOLBW018017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704907463; bh=CX8E5r7zBAOO+i+59rWLdXrft8eUGQgZW55exVjTyPU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YC7btwGASm4zHvg6qa7PnBYSuKZQjN4ijhYzz6nmqAgF/d7WLJ6dmQ0r44MS4iTi6
	 iTarWOFLqD5uzUHTwN4oCydcNeze/Z1VEGJ8imp26pAaNpYCJqe40j+7YZi2M+EvmA
	 8LJLV8D7BYbvHOhRIwUUtwwJFffcAYzpQSYYrSq1n2+xFfnHqJ/H8WdRw1M2glDgUQ
	 DQIiPjRP1/j0C6CbtawW5elNZ3ernMYx9snDy0Wn6R9NcfZaV1ZXpB+a0y4yMaLxeR
	 mujLcd3OWoDasRXl+eSC1TkhPcyiDiXQ8FO2Y4jGSoggciEpRT+dafoDTKTWDkM4D3
	 kwPw4b1RQSCRQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 04C3315C0276; Wed, 10 Jan 2024 12:24:21 -0500 (EST)
Date: Wed, 10 Jan 2024 12:24:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Stevens <stevensd@chromium.org>,
        David Hildenbrand <david@redhat.com>, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: lockdep warning triggered by 15b9ce7ecd:
 virtio_balloon: stay awake while adjusting balloon
Message-ID: <20240110172420.GB1006537@mit.edu>
References: <20240108215015.GA599905@mit.edu>
 <20240110030913-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110030913-mutt-send-email-mst@kernel.org>

On Wed, Jan 10, 2024 at 03:11:01AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 08, 2024 at 04:50:15PM -0500, Theodore Ts'o wrote:
> > Hi, while doing final testing before sending a pull request, I merged
> > in linux-next, and commit 5b9ce7ecd7: virtio_balloon: stay awake while
> > adjusting balloon seems to be causing a lockdep warning (see attached)
> > when running gce-xfstests on a Google Compute Engine e2 VM.  I was not
> > able to trigger it using kvm-xfstests, but the following command:
> > "gce-xfstests -C 10 ext4/4k generic/476) was sufficient to triger the
> > problem.   For more information please see [1] and [2].
> > 
> > [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
> > [2] https://thunk.org/gce-xfstests
> > 
> > I found it by looking at the git logs, and this commit aroused my
> > suspicions, and I further testing showed that the lockdep warning was
> > reproducible with this commit, but not when testing with the
> > immediately preceeding commit (15b9ce7ecd^).
> > 
> > Cheers,
> 
> 
> Thanks a lot for the report!
> I pushed a fixed patch out (tree rebased).
> Would be great if you can confirm it's allright now.

I manually fixed up the white-space issues with the patch last night,
and verified that it fixed it for me with an overnight test run.  (My
patch was versus next-20240109, and then I tested with ext4/dev merged
in.  Previously I had noted the problem with next-20240107 with
ext4/dev merged in.)

Thanks,

					- Ted


From 98097bbd4fe2e15db8fa357aa6e29435cb62e450 Mon Sep 17 00:00:00 2001
From: David Stevens <stevensd@chromium.org>
Date: Tue, 9 Jan 2024 14:41:21 +0900
Subject: [PATCH] virtio_balloon: Fix interrupt context deadlock

Use _irq spinlock functions with the adjustment_lock, since
start_update_balloon_size needs to acquire it in an interrupt context.

Fixes: 5b9ce7ecd715 ("virtio_balloon: stay awake while adjusting balloon")
Reported-by: Theodore Ts'o <tytso@mit.edu>
Tested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: David Stevens <stevensd@chromium.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/virtio/virtio_balloon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index aa6a1a649ad6..1f5b3dd31fcf 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -459,12 +459,12 @@ static void start_update_balloon_size(struct virtio_balloon *vb)
 
 static void end_update_balloon_size(struct virtio_balloon *vb)
 {
-	spin_lock(&vb->adjustment_lock);
+	spin_lock_irq(&vb->adjustment_lock);
 	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
 		vb->adjustment_in_progress = false;
 		pm_relax(vb->vdev->dev.parent);
 	}
-	spin_unlock(&vb->adjustment_lock);
+	spin_unlock_irq(&vb->adjustment_lock);
 }
 
 static void virtballoon_changed(struct virtio_device *vdev)
@@ -506,9 +506,9 @@ static void update_balloon_size_func(struct work_struct *work)
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
 
-	spin_lock(&vb->adjustment_lock);
+	spin_lock_irq(&vb->adjustment_lock);
 	vb->adjustment_signal_pending = false;
-	spin_unlock(&vb->adjustment_lock);
+	spin_unlock_irq(&vb->adjustment_lock);
 
 	diff = towards_target(vb);
 
-- 
2.43.0


