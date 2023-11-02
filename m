Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CE7DFBC4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbjKBU62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:58:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D2188;
        Thu,  2 Nov 2023 13:58:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so1484347b3a.2;
        Thu, 02 Nov 2023 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698958704; x=1699563504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cstE9fD5qQ5qJwAb5/3UxpI/SzYe5lMdLih9ETiot+c=;
        b=E4uHGVLWM2fmSbQqF+dD2UASVLPQX4dSVfvZW9fiAfM/jIhZfpo5tgsB3L9WNuYg6C
         n6erKhhtPxgej/O8R/may9uJEf/y2CwBeTQceKe1IIS7+pVh5U5a6gK50u2q26Q7NX5j
         hXuwKVLugitY4BjhpKG9Q3VpBR/KETPg4ekcpTTlW3LXaFE1BG8ypsnMRIcGluKC719W
         3SkeWXi7TCNOgbaPME73e2Y3rdJXIDtvRQHZ24ErKghtsSThoEeQ46j9NvbX6mvk50WR
         SlB7lw9EQASIhzOYvE9kLDor9FTNx1k1O1lnuXVoAkOe6c1n0b/ETFa05n4qrz66NOq3
         Js2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958704; x=1699563504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cstE9fD5qQ5qJwAb5/3UxpI/SzYe5lMdLih9ETiot+c=;
        b=G6HJYmtTwjjn/D3vB6ohextPWPkdtOunve4XcSmMRMMoNotMcx4BPwRz+9OXl+fJeu
         k6A7sG9xId61+Vn/KZ4enLgYYLvpmsn5/qMJVgSaYobfpSE5bIWQtgCAFBb/4yEw/rT5
         803aHba3B6BXwjlLpso+9GXBuyscb1R+AQ31/7WUSht6wNoJDkJ9ngj9H7/PCu1GmFxw
         Jhn0Kw+QbPaZwwi55hAc3dIqGszlknsaWGKDs0DpDopuE3I5l8QBMS3G6X15lCKf62K9
         ITfQVO5j1RxRhXoy+tED1/BKR9Wu39W8Deh0TCgfa9EVtmKj7awWBrgQArGEbIwFnwnt
         jJUg==
X-Gm-Message-State: AOJu0YzHHrvrdqu/j2amXJq6Ri8vgaiS5uYC8h8zkQ2s9m16txSCcr3f
        X0e+j95qqrqVKNl0U7G0tyE=
X-Google-Smtp-Source: AGHT+IE5TDHlqNeeOPjCDWZAqwvzOwnnAmnp9YInwHy/Yw2ExKoEYACc0WesIrtsXdTpf0XOUN+ONA==
X-Received: by 2002:a05:6a20:914a:b0:13f:9cee:ff42 with SMTP id x10-20020a056a20914a00b0013f9ceeff42mr24768259pzc.41.1698958703758;
        Thu, 02 Nov 2023 13:58:23 -0700 (PDT)
Received: from localhost (fwdproxy-prn-120.fbsv.net. [2a03:2880:ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id j15-20020aa78d0f000000b006be0b0fc83asm160551pfe.125.2023.11.02.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:58:23 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Subject: [RFC PATCH v2] zswap: memcontrol: mplement zswap writeback disabling (fix)
Date:   Thu,  2 Nov 2023 13:58:22 -0700
Message-Id: <20231102205822.1135655-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102200202.920461-1-nphamcs@gmail.com>
References: <20231102200202.920461-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a leftover function from an previous iteration of the patch.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e3a3a06727dc..7ff55f557bd8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1621,12 +1621,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
-
-static inline bool mem_cgroup_swap_disk_enabled(struct mem_cgroup *memcg)
-{
-	return false;
-}
-
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
-- 
2.34.1
