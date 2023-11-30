Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730957FE81F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjK3EGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjK3EFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:05:54 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832110C6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:05:35 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c6001ec920so460053a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701317135; x=1701921935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HifOguLosmCp1hqOD7nW4Pzhg3FPPc3H1eWRpxejRrY=;
        b=ACwPBuMIkvHS0zI/LN+NB+3jM4e1sTKu4c2au+Vi5mF75iopDUbsItmrOA90zcllOG
         5pV5rA9aEwGZSL9VqrupURkA9ixJK6o5z1dHaVzZgI2DoxYSnu3HJqa03pQSl5jAfzrV
         BiHCKg4+dD3vP1p2e/zaqIuUOJWGO+fMKQTA3K0eSB1E+E80/PbvooMmHuduAhd8PiMV
         15lP2N77qsDXosPYD3WDTJQIUk8Fuxu1SpbtKIDmFiT5KHTFdJ6VYDiQstHTdSm372Bn
         P3E+OrQ/CLcjnUPNcvr4tIpvPSL5zhDXgVyLCe+LevjeLVbueRnZ07TAmIDLe245uAuF
         Ky0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701317135; x=1701921935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HifOguLosmCp1hqOD7nW4Pzhg3FPPc3H1eWRpxejRrY=;
        b=RwgvZF2Ad0iDJUM2+D/vD0Q+7h6FrQ/OB+8n2QhPRJmFEq/jW6RGzLCtjghHYgGSYN
         DNlKziC8oXy1i8OpyiHk7zXhgWy2COAKjY8g2ww0HsbUxFwisCUAE7tU0432yFR7q9TI
         tH514TMOyfcOZKpc6ODDiklYCo4+dtjJLmR/nhAsBuN0N6u5xz7KWHzymWmHhBKZpAE+
         WMOQYTx4aDjVnezlT46asH8o7Qfw7k0Hj36ez+rXNdv3i61grsa2NJop+Gz9FpUPgXQj
         2W/gpAIkbDyMNnlHDYpGP07xaPMYQms2mcfTQBj71XK0aJPZa+I5uf8RAZYR4Dh+BpxA
         XB4w==
X-Gm-Message-State: AOJu0YzCTKGd5PF4u43OosnXmmrN5yTiOBtAKBWj8AKXnnUSR4bEKVNJ
        2tCDV92vhoQSdxAB0MP7yrkLeQ==
X-Google-Smtp-Source: AGHT+IH9PSQT+1rspy2juwmb1zQ+1+xmcZ4tuw74DHRM5bQB/lfp8qpMQb3zzbKumW4BYP3Z9DzDug==
X-Received: by 2002:a05:6a20:548e:b0:18c:8d0f:a794 with SMTP id i14-20020a056a20548e00b0018c8d0fa794mr14103759pzk.19.1701317134959;
        Wed, 29 Nov 2023 20:05:34 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001d01c970119sm174181plh.275.2023.11.29.20.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:05:34 -0800 (PST)
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
Subject: [PATCH v3 1/3] xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real
Date:   Thu, 30 Nov 2023 12:05:14 +0800
Message-Id: <20231130040516.35677-2-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231130040516.35677-1-zhangjiachen.jaycee@bytedance.com>
References: <20231130040516.35677-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

