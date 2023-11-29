Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497E37FD037
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjK2H7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2H7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:59:24 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA2A1A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:59:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ce28faa92dso49890145ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701244769; x=1701849569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YauZ5nFY7F7io1hORv7LvgfYKOqlkddb830K39XSJwk=;
        b=Ar6QsFEgzh0w8kdputYDcWo2TnCJKb7Dcq9ZxbDvtO7xZC0g9ibnr7aW9PtIytmc3q
         oO4AIiYSlm8vjQCwj3sl1S4zvy9BXV3gdvauRBb4LxQXgPhD9AlXcvvBUV9M6b/GvFiy
         SIXPbxJ7sto4+cADBwFhy1EyP5Ssr6yU4e3aUhDzNr4g5gnEvOHL01CGKvB50awODAMn
         9Io/qgmTSbVQfaG3RV8dn/quYReo7gbXvcr9ReRC24EiqgGL4BjPaXx2Wzhy8hqXsXKn
         KpJdLUbDLoJ+ay9JlbniY32tZtIeZEJGPVOZd/NQACCRJBn7h54/ZF3esan2yC2DHm48
         fKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701244769; x=1701849569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YauZ5nFY7F7io1hORv7LvgfYKOqlkddb830K39XSJwk=;
        b=HhDe4EoawFypKz0q/c3WkrPoABnOmfvc634y9MgNACbsPtBoLpILMRnEWJerAY6Hgk
         z3R87eOdMtM1LBEwkTbpPOn21+u8v5RL8Tw/kHMQ/caABZGTPEls7+A+mZZGNxF6l8F4
         z8pHOU6LoJgdfml7YrgvmzNqXp4P4zBw4F17/tsg2llA+WybP0xhzFJpMTVjLK9V4pwT
         GkY1U9bAQAnaUb/9mTH7lwaYcMJ9ZxBiF94f8nLA52jBqeXyfHdTsrE1GSyuq7i2mN3f
         qTKquNESTwicrpgBqySfu6nzTQi1KujlevzBTlg75dEfOlhePfgIDkVQwDojNTm8US0G
         Gy3g==
X-Gm-Message-State: AOJu0YyZ4UXMyGIX3cCWGA9KVLNtygyK90QcpgVylxBdY72Snxun3ybZ
        AjuTV+6yP5hZ7Um8bicnvyGMzw==
X-Google-Smtp-Source: AGHT+IFaKO62tpVgLz7ZQW3WdVZvjkLFQ3+fYbURvJNMI1MHyODzmDZE9pRm6Tgt1d216kFDzkBR9g==
X-Received: by 2002:a17:902:e744:b0:1cf:bd98:633b with SMTP id p4-20020a170902e74400b001cfbd98633bmr13147413plf.64.1701244769204;
        Tue, 28 Nov 2023 23:59:29 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902989100b001cfd0ddc5d3sm4979419plp.277.2023.11.28.23.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 23:59:28 -0800 (PST)
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
Subject: [PATCH v2 0/2] Fixes for ENOSPC xfs_remove
Date:   Wed, 29 Nov 2023 15:58:30 +0800
Message-Id: <20231129075832.73600-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently, our use-case ran into 2 bugs in case doing xfs_remove when the
disk space is in-pressure, which may cause xfs shutdown and kernel crash
in the xfs log recovery procedure. Here are 2 patches to fix the
problem.

The 1st patch fixes an uninitialized variable issue.

The 2nd patch ensures the blkno in the xfs_buf is updated when doing
xfs_da3_swap_lastblock().

Compared with the V1 patchset, this V2 patchset
- directly set the *logflagsp value to make the code more robust in the
  1st commit,
- check xfs's crc-feature rather than magic in the 2nd commit, and
- fixed code style and rebased onto the master branch.


Thanks,
Jiachen

Jiachen Zhang (1):
  xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Zhang Tianci (1):
  xfs: update dir3 leaf block metadata after swap

 fs/xfs/libxfs/xfs_bmap.c     | 26 ++++++++++++++------------
 fs/xfs/libxfs/xfs_da_btree.c | 11 ++++++++++-
 2 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.20.1

