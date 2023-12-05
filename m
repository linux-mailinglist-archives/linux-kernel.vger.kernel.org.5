Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144A180499B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbjLEF7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEF7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:59:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E31E116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:59:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d06d42a58aso27238105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 21:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701755967; x=1702360767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+odzlx0iKgbFxvPhRnZ5hpchFT389azLhhLZpDzZwc=;
        b=SbLcaCDseqofjPkjQX7Y5q8bEUKijUthvO4DuGLHxVhq08tlfQft+lgv3dzS1H6zSL
         aoNGsiHigig1VOs4fZwALn+kC/7vr+YSdRv+9OkBW2EfopmZM1ocHXDWwwLtf6LRnBv1
         YGzd3JVsOY+6ChOD8lREiKsVupYwrX+lDSwSKusRJAVmyNhcItSge1+Iz8u8zsXby0JE
         LHKzWIlQNVBOZFqkzpi/IFFx44HShIyu0HmKjW+J7+If7yPHIfUYDuWRe0Ws5vv1P2HE
         tdKzDdj1Nn45eO3zdMLErNyrauyJEYhwOAI0HLZzVvLBAlNH92tHj75DjWXmGvzb49Sp
         fvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701755967; x=1702360767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+odzlx0iKgbFxvPhRnZ5hpchFT389azLhhLZpDzZwc=;
        b=B0K0Yr9dNiUxrL5r974v28c3RvAGXSma8TYORDpvokPwlszoldgWn+BXc0K6MDCy2Z
         pUEPzt3J/I1aX59WllnltLWQqdtCHKr2GClpWHeCeU/cMv0fv4pZBjEC8VRr4T76qM2z
         vI2Y0Tug+vutn703wQLEnp2tLzSwWno+Jb32btYzqBL/wY3DgtYQiGSGm4FMXdTkF0Uk
         baj+wbR/6YqSRcdOhFP5euEVkgxU3n0i6d4BshXVF1q6v0OS6PPvlNgzcJUqZoTnByL7
         ik3iF+G6tbz1KHy422M7pphREjDxnGfrBpTvDcj17za0ebh9j4gmgbBYIYiHestS2HMh
         CyCw==
X-Gm-Message-State: AOJu0YwIx65/n+GbFiBDWz3IerZjzjFIR1NPCNrt0avU+SNkKtmyUnu5
        4BAjwTEgJRidAt6RtEwEe0Bkxw==
X-Google-Smtp-Source: AGHT+IFagYO4UhW71rhqjy9PmXmr6aCMHCOjLSAzvW/JPUAbVwygw3F445s5LtnqLu2X3lfXlKOm3w==
X-Received: by 2002:a17:902:d586:b0:1d0:3358:4e26 with SMTP id k6-20020a170902d58600b001d033584e26mr6983846plh.1.1701755966931;
        Mon, 04 Dec 2023 21:59:26 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id jb7-20020a170903258700b001d05bb77b43sm7111605plb.19.2023.12.04.21.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:59:26 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 1/3] xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real
Date:   Tue,  5 Dec 2023 13:58:58 +0800
Message-Id: <20231205055900.62855-2-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231205055900.62855-1-zhangjiachen.jaycee@bytedance.com>
References: <20231205055900.62855-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of returning -ENOSPC, ensure logflagsp is initialized by 0.
Otherwise the caller __xfs_bunmapi will set uninitialized illegal
tmp_logflags value into xfs log, which might cause unpredictable error
in the log recovery procedure.

Also, remove the flags variable and set the *logflagsp directly, so that
the code should be more robust in the long run.

Fixes: 1b24b633aafe ("xfs: move some more code into xfs_bmap_del_extent_real")
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 73 +++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index be62acffad6c..eacd7f43c952 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5010,7 +5010,6 @@ xfs_bmap_del_extent_real(
 	xfs_fileoff_t		del_endoff;	/* first offset past del */
 	int			do_fx;	/* free extent at end of routine */
 	int			error;	/* error return value */
-	int			flags = 0;/* inode logging flags */
 	struct xfs_bmbt_irec	got;	/* current extent entry */
 	xfs_fileoff_t		got_endoff;	/* first offset past got */
 	int			i;	/* temp state */
@@ -5023,6 +5022,8 @@ xfs_bmap_del_extent_real(
 	uint32_t		state = xfs_bmap_fork_to_state(whichfork);
 	struct xfs_bmbt_irec	old;
 
+	*logflagsp = 0;
+
 	mp = ip->i_mount;
 	XFS_STATS_INC(mp, xs_del_exlist);
 
@@ -5035,7 +5036,6 @@ xfs_bmap_del_extent_real(
 	ASSERT(got_endoff >= del_endoff);
 	ASSERT(!isnullstartblock(got.br_startblock));
 	qfield = 0;
-	error = 0;
 
 	/*
 	 * If it's the case where the directory code is running with no block
@@ -5051,13 +5051,13 @@ xfs_bmap_del_extent_real(
 	    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
 		return -ENOSPC;
 
-	flags = XFS_ILOG_CORE;
+	*logflagsp = XFS_ILOG_CORE;
 	if (whichfork == XFS_DATA_FORK && XFS_IS_REALTIME_INODE(ip)) {
 		if (!(bflags & XFS_BMAPI_REMAP)) {
 			error = xfs_rtfree_blocks(tp, del->br_startblock,
 					del->br_blockcount);
 			if (error)
-				goto done;
+				return error;
 		}
 
 		do_fx = 0;
@@ -5072,11 +5072,9 @@ xfs_bmap_del_extent_real(
 	if (cur) {
 		error = xfs_bmbt_lookup_eq(cur, &got, &i);
 		if (error)
-			goto done;
-		if (XFS_IS_CORRUPT(mp, i != 1)) {
-			error = -EFSCORRUPTED;
-			goto done;
-		}
+			return error;
+		if (XFS_IS_CORRUPT(mp, i != 1))
+			return -EFSCORRUPTED;
 	}
 
 	if (got.br_startoff == del->br_startoff)
@@ -5093,17 +5091,15 @@ xfs_bmap_del_extent_real(
 		xfs_iext_prev(ifp, icur);
 		ifp->if_nextents--;
 
-		flags |= XFS_ILOG_CORE;
+		*logflagsp |= XFS_ILOG_CORE;
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		if ((error = xfs_btree_delete(cur, &i)))
-			goto done;
-		if (XFS_IS_CORRUPT(mp, i != 1)) {
-			error = -EFSCORRUPTED;
-			goto done;
-		}
+			return error;
+		if (XFS_IS_CORRUPT(mp, i != 1))
+			return -EFSCORRUPTED;
 		break;
 	case BMAP_LEFT_FILLING:
 		/*
@@ -5114,12 +5110,12 @@ xfs_bmap_del_extent_real(
 		got.br_blockcount -= del->br_blockcount;
 		xfs_iext_update_extent(ip, state, icur, &got);
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		error = xfs_bmbt_update(cur, &got);
 		if (error)
-			goto done;
+			return error;
 		break;
 	case BMAP_RIGHT_FILLING:
 		/*
@@ -5128,12 +5124,12 @@ xfs_bmap_del_extent_real(
 		got.br_blockcount -= del->br_blockcount;
 		xfs_iext_update_extent(ip, state, icur, &got);
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		error = xfs_bmbt_update(cur, &got);
 		if (error)
-			goto done;
+			return error;
 		break;
 	case 0:
 		/*
@@ -5150,18 +5146,18 @@ xfs_bmap_del_extent_real(
 		new.br_state = got.br_state;
 		new.br_startblock = del_endblock;
 
-		flags |= XFS_ILOG_CORE;
+		*logflagsp |= XFS_ILOG_CORE;
 		if (cur) {
 			error = xfs_bmbt_update(cur, &got);
 			if (error)
-				goto done;
+				return error;
 			error = xfs_btree_increment(cur, 0, &i);
 			if (error)
-				goto done;
+				return error;
 			cur->bc_rec.b = new;
 			error = xfs_btree_insert(cur, &i);
 			if (error && error != -ENOSPC)
-				goto done;
+				return error;
 			/*
 			 * If get no-space back from btree insert, it tried a
 			 * split, and we have a zero block reservation.  Fix up
@@ -5174,33 +5170,28 @@ xfs_bmap_del_extent_real(
 				 */
 				error = xfs_bmbt_lookup_eq(cur, &got, &i);
 				if (error)
-					goto done;
-				if (XFS_IS_CORRUPT(mp, i != 1)) {
-					error = -EFSCORRUPTED;
-					goto done;
-				}
+					return error;
+				if (XFS_IS_CORRUPT(mp, i != 1))
+					return -EFSCORRUPTED;
 				/*
 				 * Update the btree record back
 				 * to the original value.
 				 */
 				error = xfs_bmbt_update(cur, &old);
 				if (error)
-					goto done;
+					return error;
 				/*
 				 * Reset the extent record back
 				 * to the original value.
 				 */
 				xfs_iext_update_extent(ip, state, icur, &old);
-				flags = 0;
-				error = -ENOSPC;
-				goto done;
-			}
-			if (XFS_IS_CORRUPT(mp, i != 1)) {
-				error = -EFSCORRUPTED;
-				goto done;
+				*logflagsp = 0;
+				return -ENOSPC;
 			}
+			if (XFS_IS_CORRUPT(mp, i != 1))
+				return -EFSCORRUPTED;
 		} else
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 
 		ifp->if_nextents++;
 		xfs_iext_next(ifp, icur);
@@ -5224,7 +5215,7 @@ xfs_bmap_del_extent_real(
 					((bflags & XFS_BMAPI_NODISCARD) ||
 					del->br_state == XFS_EXT_UNWRITTEN));
 			if (error)
-				goto done;
+				return error;
 		}
 	}
 
@@ -5239,9 +5230,7 @@ xfs_bmap_del_extent_real(
 	if (qfield && !(bflags & XFS_BMAPI_REMAP))
 		xfs_trans_mod_dquot_byino(tp, ip, qfield, (long)-nblks);
 
-done:
-	*logflagsp = flags;
-	return error;
+	return 0;
 }
 
 /*
-- 
2.20.1

