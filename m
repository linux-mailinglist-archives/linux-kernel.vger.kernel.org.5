Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5E7D0E17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377125AbjJTLFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377122AbjJTLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:05:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D27E8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:05:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so187871b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697799912; x=1698404712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9IZMHeTac8Kz4oLd5mHCdBq6mCMIqXMrNggWXrCufEg=;
        b=W70J1ARRDPYsSpVtfHhZ4A64/ZIhxkXMvMzxF0V3FZL+Kyql/nhe3Jshnoda9EPmHy
         wWMmt5/RVcrZ4Uy3+Ex7V9VI+uhgDJ03lEUMIZhGa+5MSrxTSrO2VLMVrZec5sUN2OM3
         VHOxc9+0SmKDrxGHQxUC5brDT4ALCfLVLcImiH683WvNSlwXnN5XY/6LjPCANikvXqXZ
         qVHMncvfJRsrHyjWHMIQZh69Cd7GMWY86CkNU1qmvwZn9+e0EwI8TBOtqxCLlssd0LOx
         uyTQi1WjDenfw+aycdK0grxX6PqAILUSzYN0I2ra+U4gRE7hMnHMwFbOHEMQmsT4ITBd
         ejOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799912; x=1698404712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IZMHeTac8Kz4oLd5mHCdBq6mCMIqXMrNggWXrCufEg=;
        b=f2+OXb6p/iCw23q4Zx1mrGzJnZzHaI65CqfuRlcIrZ81m3e5ZSGiJ8T2eUt8sloiEz
         ur7ZmAP+eDpYMpz0Se7JQUajuHYyvNh901k6QeEXZxK12WkJVZyO376SPpe4nYzRUe9x
         8D2FVBktCyv/irXtwQfNFSExTPQB43bRqMDncU4frIYJr0ow6U8Nh7g3lZOoXUm55mP9
         HvZCKOLbR0J9L2LGBiq9Gv8rWuQQBC6hkTsXyFiJEAimsg/uOLMKZ6nY2CzqngUGHIhx
         xVkRI3KZSt8Z1oq6bvXiwsFRclm/JKNSquCMhuVj6x/bUnXbwNEqpkUJQuaBqpvlPEoc
         x8fA==
X-Gm-Message-State: AOJu0YzmpS5LOE/62zvO+WGoux41IjFW/eGy5G+cVV2YVDn5HAxvKwO+
        aLgMxR4jg+DT1AgPh5Z+DixrVA==
X-Google-Smtp-Source: AGHT+IHv6H7nLejfTli7KNGHlJj4xUINzK1ZIqbutLEOGaZi/c0sQlHvctN3ARenTJLsJhd0f+DHSg==
X-Received: by 2002:a05:6a00:1c86:b0:6bc:ff89:a2fc with SMTP id y6-20020a056a001c8600b006bcff89a2fcmr1399965pfw.2.1697799912055;
        Fri, 20 Oct 2023 04:05:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b006be4bb0d2dcsm1323865pfr.149.2023.10.20.04.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:05:11 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 0/2] handle memoryless nodes more appropriately
Date:   Fri, 20 Oct 2023 19:04:44 +0800
Message-Id: <cover.1697799303.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Currently, in the process of initialization or offline memory, memoryless
nodes will still be built into the fallback list of itself or other nodes.

This is not what we expected, so this patch series removes memoryless
nodes from the fallback list entirely.

This series is based on the next-20231018.

Comments and suggestions are welcome.

Thanks,
Qi

Changlog in v3 -> v4:
 - fix typo in the commit messages and comment (pointed by Ingo Molnar)
 - collect Acked-bys

Changlog in v2 -> v3:
 - add a comment in [PATCH v2 2/2] (suggested by David Hildenbrand)
 - collect Acked-bys

Changlog in v1 -> v2:
 - modify the commit message in [PATCH 1/2], mention that it can also fix the
   specific crash. (suggested by Ingo Molnar)
 - rebase onto the next-20231018

Qi Zheng (2):
  mm: page_alloc: skip memoryless nodes entirely
  mm: memory_hotplug: drop memoryless node from fallback lists

 mm/memory_hotplug.c | 6 +++++-
 mm/page_alloc.c     | 7 +++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.30.2

