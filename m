Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA17E90E5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjKLNcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjKLNbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:31:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F4561AA;
        Sun, 12 Nov 2023 05:29:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC42C433CA;
        Sun, 12 Nov 2023 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795768;
        bh=yVo8ubIcxefRIGAaASQcaSuRC+IULS1M2mBBNEePGy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdoeTMiccy4L7RnHVZ7XaSj0foKGnu3tLb+3mPAogiVwd19boy93IktRI8K33Tp+V
         GhaAJcb7ALsrelEiv59ssPrK5Rxy7S8Etr0cQEoT726L0PS0mPFmPWkNZ63VkE+iz2
         sGipDkil3jseDvHb7MJ2LuUgLQEIeyGTQnXRx2JEjqTQpl53WoSSUHR7I/rzXgXEAy
         NAqwzqp47YiHIFz1hT2FtLADVm/cN05dlbtxv+4FJRagq2yeG7qAAX4FOI90Frzzhg
         OonxiuSNLzSm72IObOc7cca2C26fXpBeRuoybI9G0ML+Lm1Vqu0vgcPhpK62xq0Gu/
         Q4XJHd2dGzyDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, swhiteho@redhat.com,
        cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.14 3/4] gfs2: ignore negated quota changes
Date:   Sun, 12 Nov 2023 08:29:21 -0500
Message-ID: <20231112132923.176955-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132923.176955-1-sashal@kernel.org>
References: <20231112132923.176955-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.329
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index a833e2e071675..9cef9f1ab63fa 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -434,6 +434,17 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
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

