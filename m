Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F777FE81A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjK3EF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjK3EF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:05:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DD9CA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:05:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfc34b6890so4987165ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701317128; x=1701921928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+yjpAu/Jsru6QG03RfnszV7SN1caXKKF6cUUXYNdao=;
        b=FwBdeI6nAdH131mq7iPHPrbhy0nqwsVBWssTIqkz02vCctta9ho4kK3F1lZrtuglDY
         bNYvPIERMIjhgGxYt17P/FOVh2SgQqyBkV2usgrRqOy6JKsbMvXHwYQbQXpww/YVkxtr
         KhA9ZKTZlv36DNpsvrpypkCZo3mkhDF1P1K/PsvgBbqnEGzdv2Hz+PSXAzEtFiWD4Ryh
         V+TfkYKcBtLLjol59YeqXe9KR2SWAxzAjLW84ltgRN4usyHfs5qZ3KuaYd/fGyf+G5qV
         QS/e8G1dVG5av526A6Jt9Pd2ALU20qTfYlztOIxrKzxdHQA0x3Pa4C29hmJkdSm5VdKM
         cLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701317128; x=1701921928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+yjpAu/Jsru6QG03RfnszV7SN1caXKKF6cUUXYNdao=;
        b=JPmb9+gyTEQgcZ2AN9CvdCf4J6JdhIXFely7SVOVOmfN2Cdm3Gt36VtA47treWEJKk
         x7SL/1wEL9aPXBjEvg3/iaPpS3Tuf4B+FlJ6cTWDniLxpA9xEv9uqPYs3C/fuDHjdfSZ
         Crh8excFEHnV48UZf+pSJh4aSX8GCNF6MKAACJF0nMjDxryR+i6NqKqWB++qmRbKCYma
         m84yM4lCMHwrYObO/YUhmbZoafzLOfoyKs580mK/fufIeLh6EBDhyVT+EOzR8ERHK1eN
         0RLbG6/vgSDVuEnkmiOZerKdFab8RHCJFUVzaA/L62p1w7o/M9hX0EZxw4GKC/bEjDlf
         F1Pw==
X-Gm-Message-State: AOJu0YzvoNuQ3mbwxMe9tWmz6eqGJ7MRuP8pyYc0TLOsc3rSkDNxpmh8
        2aBB/6OKPOZ9Cjx707/t34O96A==
X-Google-Smtp-Source: AGHT+IF2TPny1kU3pUpbWpuyFpMHloE4EU/UOBulaT2ThGwlIOchgef/BblJ7yPK0aci9EcXP1Nrvg==
X-Received: by 2002:a17:903:249:b0:1cf:b4bb:9bdc with SMTP id j9-20020a170903024900b001cfb4bb9bdcmr23350613plh.9.1701317128695;
        Wed, 29 Nov 2023 20:05:28 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001d01c970119sm174181plh.275.2023.11.29.20.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:05:28 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH v3 0/3] Fixes for ENOSPC xfs_remove
Date:   Thu, 30 Nov 2023 12:05:13 +0800
Message-Id: <20231130040516.35677-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
problem, and a patch adding a helper to optimize the code structure.

The 1st patch fixes an uninitialized variable issue.

The 2nd patch ensures the blkno in the xfs_buf is updated when doing
xfs_da3_swap_lastblock().

The 3rd patch adds a xfs_buf copy helper to optimize the code structure.

Changes of v2:
- directly set the *logflagsp value to make the code more robust in the
  1st commit,
- check xfs's crc-feature rather than magic in the 2nd commit, and
- fixed code style and rebased onto the master branch.

Changes of v3:
- fix code style, and
- add a new patch which does xfs_buf memcpy in a helper.

Thanks,
Jiachen


Jiachen Zhang (1):
  xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Zhang Tianci (2):
  xfs: update dir3 leaf block metadata after swap
  xfs: extract xfs_da_buf_copy() helper function

 fs/xfs/libxfs/xfs_attr_leaf.c | 12 ++----
 fs/xfs/libxfs/xfs_bmap.c      | 73 +++++++++++++++--------------------
 fs/xfs/libxfs/xfs_da_btree.c  | 70 +++++++++++++++------------------
 fs/xfs/libxfs/xfs_da_btree.h  |  2 +
 4 files changed, 69 insertions(+), 88 deletions(-)

-- 
2.20.1

