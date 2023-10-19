Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479B97CF16D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjJSHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjJSHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:38:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3BE112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca79b731f1so8971405ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697701087; x=1698305887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iODpyYFwO1oG91Rx1B6vPWC8Bb1guLsLCVeteiWdg7A=;
        b=b+O9s3zWTLNTNRkmQHEB/XQZXDu3cR9qEr7+srNOHV27W5pMHKo7JwG5VrvwnzoXl1
         HsGHDMOowWNu/ZZ3t+3QhmuhCoC4lip3ri8mNsF5J2KkC3mYOkV0rShHbipyLsZIIJoR
         BddiJ+avi7ILtv7nBNau93226MvcfzGvv0Ea/VQrizPaKDPUZhMvl49Vvoyv/ndKW4sZ
         Yavy7KuyfuJwAF4ZKcL2pY/m/nMv+LME8zWHXZlLoVylEaW+eGLCLYsFOD10wIhZ0xIs
         rUCsa6Q3B+Z6ZFmqLGftgF8ANdnsmZEYfpivBi/737Zegxoe3A67vlmrVqi2q2uNRWdq
         PB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701087; x=1698305887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iODpyYFwO1oG91Rx1B6vPWC8Bb1guLsLCVeteiWdg7A=;
        b=QdhVIefaJ1+ijptYFvo9/ntuii6Q/p/+0QZdLf127t86sQINkOajet7cfMUfhZborO
         fwfssaw2zzqVwX+RFGv72vaglCGYy0hYqX19YV20IoAQ7ss8YDT7sKaz3I92R3ur2djF
         UaSj54L2Bff91rVHgLuOu9DJmLE0w7p34FFKEJSYMeskaK2WNbACRwQgth/y6gEvnCd0
         ihW2mFYQlv27feG9igGH49k72FRcTVb1Fw/P8wkrQOq23blNmH+lH6f6E+UlUjRZDOcy
         pCWlS2HMPbLRkILYVw/DX3TSPVyAWxtSK3bga/HmPn2HNdI6T9nuqRWI0hqYhH/C0dTS
         hm7w==
X-Gm-Message-State: AOJu0Ywl/CjGu9RcqILhYHD/6XsKD5wD5VqTc1IYPa6xqOYcZqEWHEia
        eL47sffCWCEAGyw62uLf/NXixg==
X-Google-Smtp-Source: AGHT+IHZNAoQ3zC9/VR613FTSuua5KOYEG6nqeGd8HRAUu3Xc/1tRXUy4L00rOw0qIrji0VgcHL0qQ==
X-Received: by 2002:a17:903:288f:b0:1b8:9fc4:2733 with SMTP id ku15-20020a170903288f00b001b89fc42733mr1533490plb.3.1697701086997;
        Thu, 19 Oct 2023 00:38:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b001c5d09e9437sm1194306plo.25.2023.10.19.00.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:38:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 0/2] handle memoryless nodes more appropriately
Date:   Thu, 19 Oct 2023 15:36:25 +0800
Message-Id: <cover.1697687357.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changlog in v1 -> v2:
 - modify the commit message in [PATCH 1/2], mention that it can also fix the
   specific crash. (suggested by Ingo Molnar)

Qi Zheng (2):
  mm: page_alloc: skip memoryless nodes entirely
  mm: memory_hotplug: drop memoryless node from fallback lists

 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.30.2

