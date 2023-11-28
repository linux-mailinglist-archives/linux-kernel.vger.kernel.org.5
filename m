Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97567FB14E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjK1Few (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbjK1Feq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:34:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21731E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce28faa92dso38862925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701149668; x=1701754468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxO33hgX7qudIID8yDsz8ucZ3gJV05i7WjPRt4ATm1c=;
        b=bhZA9CJchPrKFiQfbQF+NRJRfXVXkcAFEkGxZ7UABAQ1cfDqDCZbSPOzurpSk+scPc
         hQUC17nOc6sFrkYIFnANlXLljAnqoMLyZ8IsuHhUjz8zPTQaHuKgL6TfsGa948nxoA/s
         IWgg84LIqYD3zvi9L+9R5nogMayy0c1PwNm2Sbqv1gUDpYi56dUnzwXklqp6iws57fxa
         pmaFrp/fyFhjuKW5nt1F+GGhGqFA6rAx4hnIcczt1/k9XmUmHlJ3OAFTeQ09QlVailTJ
         Gp3nZo7d9vmhhUOMLTPHlXkBzagXVGTmutvEPFDycrfxhdBZY2LFOwVklLP0LFDDrY3m
         pelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149668; x=1701754468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxO33hgX7qudIID8yDsz8ucZ3gJV05i7WjPRt4ATm1c=;
        b=UwiULU3yeYzIezEvFVdoAavjK6hBqR7OlJp13jZuNCYYsiafXA0jC6yEvw/vOkvm+b
         hy4PLxNkJPLL/kAYdFGmXgmmmAEj0or9ddYjLJdCPQ3cJK75FHn1vxRlABOjS9kr2oIE
         Wb5IrCay2PpbzAxFrBDxg31K65+7aQV/UTDONaJUHftLPiUISbGw3uHtCr9w843qsVd2
         MDhh1+1nbDKsQkn7mKOuCc0gPFiO8FrPYdDoTzluzkeLPFM/Uk9TOQQDWNUFpYtwOnFT
         udroEdlvJE/hz4yJq7m1+gTLqvpzm7ZfJWwUg162kwDawNrM+daBG3K4+UMseXruci86
         xIzg==
X-Gm-Message-State: AOJu0YyN/eiSBvm+NiQvFAU67Ujiv9yO0JnbitQI8lIfzVmZtMlZ6cll
        Vvpoyn/ALieCfwq5YyIPkAD7Xw==
X-Google-Smtp-Source: AGHT+IHAVwWhMA6v/POGZuJcshMw8zoXDI6R4vDpTtywy8ylzTugWHk11eEuOZ5m7x8RpjN2rWm3dQ==
X-Received: by 2002:a17:902:b401:b0:1cf:9790:f243 with SMTP id x1-20020a170902b40100b001cf9790f243mr12596195plr.61.1701149668646;
        Mon, 27 Nov 2023 21:34:28 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b001cfb6bef8fesm5372899ple.186.2023.11.27.21.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:34:28 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH 1/2] xfs: ensure tmp_logflags is initialized in xfs_bmap_del_extent_real
Date:   Tue, 28 Nov 2023 13:32:01 +0800
Message-Id: <20231128053202.29007-2-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of returning -ENOSPC, ensure tmp_logflags is initialized by 0.
Otherwise the caller __xfs_bunmapi will set uninitialized illegal
tmp_logflags value into xfs log, which might cause unpredictable error
in the log recovery procedure.

Fixes: 1b24b633aafe ("xfs: move some more code into xfs_bmap_del_extent_real")
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index be62acffad6c..7cb395a38507 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5048,8 +5048,10 @@ xfs_bmap_del_extent_real(
 	if (tp->t_blk_res == 0 &&
 	    ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
 	    ifp->if_nextents >= XFS_IFORK_MAXEXT(ip, whichfork) &&
-	    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
-		return -ENOSPC;
+	    del->br_startoff > got.br_startoff && del_endoff < got_endoff) {
+		error = -ENOSPC;
+		goto done;
+	}
 
 	flags = XFS_ILOG_CORE;
 	if (whichfork == XFS_DATA_FORK && XFS_IS_REALTIME_INODE(ip)) {
-- 
2.20.1

