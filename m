Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4568049A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbjLEF7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjLEF7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:59:35 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC71C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:59:18 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce52d796d2so1613157b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 21:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701755957; x=1702360757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlsEF8HjcrD0vm5er1oT8WZvKcg7ME4zSDysaDBmuRU=;
        b=gU656waJnSolRaCCjEYbesb4/Y2E4s++J4riEcjTmmxZudo2bkcTL0Ud5on6w1MNSi
         oSB0YdOd6/FhFLMjJRsZlib9HM/Endr5Cp7dHrjaT64OJeERH1WP4QEjbAU7/6F+rumz
         R0+XIIFCMhcNvS+pFljL0alzC/om4ByA9du/ZyJXYJNFwOIphf2Iq1xTyLN6AhcjAL6D
         l6znh1rKq37lazrps0D0AlPZPjgQI79+eXn6ntof4JwDgJ5ettFs8X1vCyX5ZGb0y5jN
         DWUM/wjjGIsBL6KwaWoa/5VxeaWAZTb9J4mdDUUgo+0luS6q3+o/CyVESkK4JpoHway8
         tnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701755957; x=1702360757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlsEF8HjcrD0vm5er1oT8WZvKcg7ME4zSDysaDBmuRU=;
        b=igzcHtnkH7Rf3vqsvy8vmZpHpjQRj5nZ8b8dCcCRCrK6tLriXSGSiqkCFO6AnzKzJQ
         +UGtunixeqpojqsnKyEfZu3MTsqbGLXpZGaL8a2wvvIWzv6VMl+zxHWuQyeIMDvzIxAV
         QszlDgIPHHNzjyYf8OKm7flJlHzWJX0jytTJ//Ld8wbpeeda9HBHlCo6x7Ho0U8BN4cr
         HUv9lU7k8ghPlv7rcB4OTpPrcfmdvxwVy2r48Omb9GBLSlSsSgUDiXnjGXcGP5oCcUTK
         0n9ZlSDuKoWo+AFiL0vkRHMkaa2Jz0jBdlRcNzq++lr10gnBhA424smKYQ40x9SthqX8
         jJHQ==
X-Gm-Message-State: AOJu0YxJwtG+HGawvT0C6Rri0ul7NfkZxaxi1FEuoBfFP5ns6qM3TAQ5
        SE4/TFdy6SfLNXQBRHXCp7XeAw==
X-Google-Smtp-Source: AGHT+IG3WM0C8QSWzlA5REbLFumqEaXOOtiDvfkup/AoaEzkEL6TxjNIX+MytDyp2q2eqC3gJ74+DQ==
X-Received: by 2002:a05:6a20:a1a2:b0:14c:a2e1:65ec with SMTP id r34-20020a056a20a1a200b0014ca2e165ecmr5059457pzk.38.1701755957415;
        Mon, 04 Dec 2023 21:59:17 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id jb7-20020a170903258700b001d05bb77b43sm7111605plb.19.2023.12.04.21.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:59:17 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH v4 0/3] Fixes for ENOSPC xfs_remove
Date:   Tue,  5 Dec 2023 13:58:57 +0800
Message-Id: <20231205055900.62855-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Changes of v4:
- optimize comments.

Thanks,
Jiachen


Jiachen Zhang (1):
  xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Zhang Tianci (2):
  xfs: update dir3 leaf block metadata after swap
  xfs: extract xfs_da_buf_copy() helper function

 fs/xfs/libxfs/xfs_attr_leaf.c | 12 ++----
 fs/xfs/libxfs/xfs_bmap.c      | 73 +++++++++++++++--------------------
 fs/xfs/libxfs/xfs_da_btree.c  | 69 +++++++++++++++------------------
 fs/xfs/libxfs/xfs_da_btree.h  |  2 +
 4 files changed, 68 insertions(+), 88 deletions(-)

-- 
2.20.1

