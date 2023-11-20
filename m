Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1142B7F0C90
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjKTHKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjKTHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:10:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B8ED8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:10:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ce5e65ba37so17696755ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700464205; x=1701069005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJAegsGMEAsqPHcwildrmHLCgFp9mNVCImkTSvfwCSs=;
        b=RZuvEUTwzMJaXyQftBdE3+xXTm0zN6PT0wf9hzJwVo/OhkE0EGafVPBX/+TBSiDIud
         jBvNgzE2mSjt1WKQOJ6QgtKfVaLscjLD+leKspUrmwNAOFe0twS7IoPoCo8z2M2zzvwh
         d0Mg2XjhIORdFse/Nl5UkqaQc1bt9BsOSfW1gSD0gFBfHpmkUkLQkxN8EDnhB0LQaCCo
         gwB0h8sWwHAp0bmCehzeC1LQWphh2LomZtoCKHd9+TLXjOxLyYjrh2pcOAmWn6dEPhbX
         lqmc6AYl8psUIotbi5D9l/ZZKg/S1InPmLOAQWJTYh4iUjzBlic972ecRT+JRIKCxVR0
         6tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464205; x=1701069005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJAegsGMEAsqPHcwildrmHLCgFp9mNVCImkTSvfwCSs=;
        b=L4GoeUwUppWvmxUkHdLio7QNSRrji/I3rhKAWEmbPLwvOmfW4KuuKycbvjxAEFi308
         8hEAqXptGfFMmLy5P4nObk9J8I3rpsZF3nS9a71053yny/mKBlo5DBFPHJciExLMDsPt
         MrjyN6VQlj03X1KO6dQJf+Ap+Gdm5qyhzczGnbJvmsHv+mAvVE+DxfFwq5r2xWJTSeiz
         ZFyuwcwo1GGKvqeC5ZK08bDejWJqYzmpQ0eW+8uOSZa/v/bKBKaFROrVxIB60TrB15V4
         N+Sb8IzKNXH7ApFCzRXww4ujk2iTB1Qp53JreqGMoyA9jc2MdFHtH5rnhgtEDi5O7bDS
         Tn8g==
X-Gm-Message-State: AOJu0YyhiiMVdfzPlejudOgPinCDzlAJewoLhtIcbOHaA1KVBUBbaldr
        D84e1t/pS2EKq/IVlS9JY+sJ1w==
X-Google-Smtp-Source: AGHT+IHMWj5eJhGQVYHhWGVAjEcPR1r+lH672kbdri/DDnFDTKkMrBGTSEq1F8Cut7W5CdHqO1+75A==
X-Received: by 2002:a17:902:d2c4:b0:1ce:6630:1585 with SMTP id n4-20020a170902d2c400b001ce66301585mr7924553plc.23.1700464205725;
        Sun, 19 Nov 2023 23:10:05 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001ce67fab3a2sm3698143plg.261.2023.11.19.23.10.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 23:10:05 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, dan.carpenter@linaro.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 4/5] maple_tree: Delete one of the two identical checks
Date:   Mon, 20 Nov 2023 15:09:36 +0800
Message-Id: <20231120070937.35481-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
References: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
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

There are two identical checks, delete one of them.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3d894f849e57..bf64d080b376 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4117,9 +4117,6 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	if (mt_in_rcu(mas->tree))
 		return false;
 
-	if (mas->offset != mas->end)
-		return false;
-
 	end = mas->end;
 	if (mas->offset != end)
 		return false;
-- 
2.20.1

