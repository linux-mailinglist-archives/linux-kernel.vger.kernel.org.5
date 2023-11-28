Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653097FB148
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjK1FeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjK1FeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:34:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6DCC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cd89f2af9dso2039266b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701149654; x=1701754454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yppdPakpPj/hSLJ9uZBVv46+PUQYqbzCgWp1lHeXxis=;
        b=fGfkLpjItIfWDyLNc/yBvAmWdQFixpU3BXrR9zcmm3PnEtVMnK2QucsZtT0AK3dmtd
         vZi0kdojw9PjqxAKUrLHTTNnxU0cQRp5pySKmft4XRoc+WG93GTSSfFy21jLysySEcvp
         qRMJoEzEnoiVWJwVar+SZu5E+bymzHsWOhL/Wv+e0/iv0p0bjKjl9GgN8lrMuJEty2x+
         EYkdql0EMDWOmgHD5r8uv5NCeHN7gylmQObm5euHBpgnAQHSlyQnP47qZmSGcE0ngVPP
         TcnaZYYBO4C6GwccJJaCRb7rGSsKoTU9NkZYiBZDsh9Qw1tBfvW4k6bw7zggA82YxgRd
         R5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149654; x=1701754454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yppdPakpPj/hSLJ9uZBVv46+PUQYqbzCgWp1lHeXxis=;
        b=BlRjHM7AgCE3UJ8NdFx6KbJTZM1tNXS8/rk/HA82BS7CbFtA73oRLLwKwQqJdIKiw+
         DbWNzYxK2T4PE7dQGDdTFId0xjm/jXRkw0+TQ0vWw8RKYvEtGoOQWpt5QKz3UnsrIRzg
         ZewTiH5BdDIyUjXhJ3WP0yjKLpKk3OkLlvCMLkWopdS/hvD+YElx+xe5iL0UuNXsl0cr
         GmoluftYuB7ymJe94Z+8OPck9ky7Eh0B6xB6uFS6IPj6G1LIzB0OWlZhhFijeEhjrDUK
         hRXLagLH4VoR3DHJP9M3mSNXPhG1EOBrBrDN5amvyqUnZwfVPvu9yQJuIHt4lKNYjHFU
         rrEg==
X-Gm-Message-State: AOJu0YxvI3G3LYc0Lldc5a7HrPyXTpXeSWd80kFmuHpWlGBFTHuwA6e9
        zzrNyc+H9MyseQXmzHmjcmb5LLQoX+S/QdtNGZ0+ZTLb
X-Google-Smtp-Source: AGHT+IGGEgtU/0QNfhR0VuWj+6MjlDH0aKxEm/b7PHGugXgt1r/1AySGlMTOGnp8qDgQ2pyVd5sWYg==
X-Received: by 2002:a05:6a20:12d3:b0:18b:d3db:7048 with SMTP id v19-20020a056a2012d300b0018bd3db7048mr18160990pzg.23.1701149654057;
        Mon, 27 Nov 2023 21:34:14 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b001cfb6bef8fesm5372899ple.186.2023.11.27.21.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:34:13 -0800 (PST)
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
Subject: [PATCH 0/2] Fixes for ENOSPC xfs_remove
Date:   Tue, 28 Nov 2023 13:32:00 +0800
Message-Id: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

Hi,

Recently, our use-case ran into 2 bugs in case doing xfs_remove when the
disk space is in-pressure, which may cause xfs shutdown and kernel crash
in the xfs log recovery procedure. Here are 2 patches to fix the problem.

The 1st patch fixes an uninitialized variable issue.

The 2nd patch ensures the blkno in the xfs_buf is updated when doing
xfs_da3_swap_lastblock().

Thanks,
Jiachen

Jiachen Zhang (1):
  xfs: ensure tmp_logflags is initialized in xfs_bmap_del_extent_real

Zhang Tianci (1):
  xfs: update dir3 leaf block metadata after swap

 fs/xfs/libxfs/xfs_bmap.c     |  6 ++++--
 fs/xfs/libxfs/xfs_da_btree.c | 12 +++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.20.1

