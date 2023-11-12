Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72577E90ED
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjKLNdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjKLNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:33:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F515581;
        Sun, 12 Nov 2023 05:29:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDC6C433B8;
        Sun, 12 Nov 2023 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795747;
        bh=OTTYeUonVU5NDgUjk3lGIEE7ffHgTgPHAMKY9ITw5C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYoYqw2AD6s+2UENCruGJkl7FOAxSArIBo67QGHDjSAPL9EnPQ7GpMF4DpCWl1vss
         weCSEYFslKkijtOTOU83K3g/h/eiciJTjOiRhSWnnIhQVpcV6eBaMWLlHogRsBrl3R
         RJmjwH8QeU68zeNg+nEK8DZKE3KQJyo281ihghcmBZAy6BZZ+m8GBTYKqg6xDPmWu3
         fl1aKft15xp7gP/EEubTdj4tkHamBi4hq8DxSlLSrk8S+t+5GdH21rSVtTxIFeGHWf
         2kT9xz3aKq0YLYRqjoWjZX84gTyo4iUzyKJQFmOe0yIsofAi/mKmtoZNz5X3KFdalp
         b+xLlAtE2yuJw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, swhiteho@redhat.com,
        cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.4 3/6] gfs2: ignore negated quota changes
Date:   Sun, 12 Nov 2023 08:28:57 -0500
Message-ID: <20231112132902.176672-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132902.176672-1-sashal@kernel.org>
References: <20231112132902.176672-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.260
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 4c6a08125f2249531ec01783a5f4317d7342add5 ]

When lots of quota changes are made, there may be cases in which an
inode's quota information is increased and then decreased, such as when
blocks are added to a file, then deleted from it. If the timing is
right, function do_qc can add pending quota changes to a transaction,
then later, another call to do_qc can negate those changes, resulting
in a net gain of 0. The quota_change information is recorded in the qc
buffer (and qd element of the inode as well). The buffer is added to the
transaction by the first call to do_qc, but a subsequent call changes
the value from non-zero back to zero. At that point it's too late to
remove the buffer_head from the transaction. Later, when the quota sync
code is called, the zero-change qd element is discovered and flagged as
an assert warning. If the fs is mounted with errors=panic, the kernel
will panic.

This is usually seen when files are truncated and the quota changes are
negated by punch_hole/truncate which uses gfs2_quota_hold and
gfs2_quota_unhold rather than block allocations that use gfs2_quota_lock
and gfs2_quota_unlock which automatically do quota sync.

This patch solves the problem by adding a check to qd_check_sync such
that net-zero quota changes already added to the transaction are no
longer deemed necessary to be synced, and skipped.

In this case references are taken for the qd and the slot from do_qc
so those need to be put. The normal sequence of events for a normal
non-zero quota change is as follows:

gfs2_quota_change
   do_qc
      qd_hold
      slot_hold

Later, when the changes are to be synced:

gfs2_quota_sync
   qd_fish
      qd_check_sync
         gets qd ref via lockref_get_not_dead
   do_sync
      do_qc(QC_SYNC)
         qd_put
	    lockref_put_or_lock
   qd_unlock
      qd_put
         lockref_put_or_lock

In the net-zero change case, we add a check to qd_check_sync so it puts
the qd and slot references acquired in gfs2_quota_change and skip the
unneeded sync.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/quota.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index cbee745169b8f..ce3d65787e016 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -431,6 +431,17 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	    (sync_gen && (qd->qd_sync_gen >= *sync_gen)))
 		return 0;
 
+	/*
+	 * If qd_change is 0 it means a pending quota change was negated.
+	 * We should not sync it, but we still have a qd reference and slot
+	 * reference taken by gfs2_quota_change -> do_qc that need to be put.
+	 */
+	if (!qd->qd_change && test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
+		slot_put(qd);
+		qd_put(qd);
+		return 0;
+	}
+
 	if (!lockref_get_not_dead(&qd->qd_lockref))
 		return 0;
 
-- 
2.42.0

