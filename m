Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA37D526F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbjJXNrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjJXNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:47:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F55128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86766bba9fso2561099276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155219; x=1698760019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=re9qyJoQbXM1lB3hu8WMyX+cG50piCMxG0UfNqXuCfM=;
        b=PFMlCZyOq8+KpB/XmnTZ0DpDxuSjhLqcwFl+VBHN9Ed5054PT7eVKG3WYjEca4c/zW
         QWBiaAZxzb/uK2c5gtOlF3x5y6HTqqa1Kv4b6P/bhkg7rWfWTjZxP09RGlo1sM+6Q77m
         ed/Lr+tkAnz1LzGsD27+9aEpGE7Uc1BGe/dlcAxXSbdenGElv/uziAiZPbllJFARvhGA
         jE/6kTKtS+KZY9kaGehb5wj4ImlVjrYmQ4DACnv6JIF/5POUS3JJ9t8r8qwwt/R4JX0B
         ZWNiwCIaW/LEQ+snxPyRr43dTADnL/urTryizeGebnwDf0s1e3TdjOFbF9ZUurdklRVP
         bzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155219; x=1698760019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=re9qyJoQbXM1lB3hu8WMyX+cG50piCMxG0UfNqXuCfM=;
        b=jXoo+/kG8Y83TuL0QUaWhEwdOQ0srDvHVi4t0CLXLeGaVg7Cib0C2IECgHQ9lWj7ky
         aqFALXkA8Y7MOSOTcpAnxG/o+oeDg9tYacRK8UVu+4A4jHSAgchD3DYPeYlG70D3uxnS
         dRS1zYbpCIFlGpeoTFysAk/jU2Ievi1CBZEKrd8sZuBgKbQuNhZxmvUPSTRhVoctlcCD
         i6IdYTwbiMjjxmvtMUYl2i4pj8FbU1hMfc7swmLyKUsissnZ0ZUsWYHZGQj16M3Ti9hd
         5HCL0wzJTYEUSA3De67OerZgSCML9nHn+z5mi0iVxBqcoG6JGPVunIiR6jey3N+e9JNn
         EN+Q==
X-Gm-Message-State: AOJu0YwXd7Cp6GPFaMUrjgp0jEgjoMYWpLO+0SzBqvAZcS1iD2a3oaLb
        viKKXMzdDUELNfCchVqMpPBAcfTnTZY=
X-Google-Smtp-Source: AGHT+IGJ25fW4BnP1NJYhrzH0X+zrhr1/eHne8PBOna8hmvrezOwpbGVvOl7JHFMC4rGhoY/sRPJncXHlfA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c946:c18c with SMTP id
 v3-20020a056902108300b00d9ac946c18cmr311395ybu.6.1698155219188; Tue, 24 Oct
 2023 06:46:59 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:05 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-9-surenb@google.com>
Subject: [PATCH v2 08/39] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, vvvvvv@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com, surenb@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/gfp_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 3fbe624763d9..1c6573d69347 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -52,6 +52,9 @@ enum {
 #endif
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
 #endif
 	___GFP_LAST_BIT
 };
@@ -93,6 +96,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -133,12 +141,15 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
-- 
2.42.0.758.gaed0368e0e-goog

