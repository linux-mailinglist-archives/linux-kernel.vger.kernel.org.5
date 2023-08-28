Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E379478B40F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjH1PJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjH1PJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A09E5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so2746057f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235350; x=1693840150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6Jw13ojRxer1CiudmSrh9Dog+8TQjAfOMQPH0B+zsU=;
        b=Lk2KfNqdfkyZPx8vi/h/HB59i1bm7w+8tv8ZcJZqLR9PmqVKGsJ7mj84sSlppy2pKN
         1Kudx1wqbxnO03PxF1S2GCnJgmlMgd5W8AwbKxspHAQbIzqb0S5gM+Uk5xxJVtI3vi6c
         OzY/Fal78xF4WUGyBlsEpwHcZBptFYGjvo5+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235350; x=1693840150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6Jw13ojRxer1CiudmSrh9Dog+8TQjAfOMQPH0B+zsU=;
        b=A8m94fgPixoYvbXm/A1jzyEa58SLVaL5HPYkQ9s/ZeoC7zJ4pPEHO72AHbzqR29n2E
         2tCPZgZRqekTYEWBk7WyFEK37bdnHXRiIkZYygdWZ12R/ZF8QyZ+MqezOQ0uxnyfQDys
         IO9/uTMSdvNWGZ7FjSkiSOCw3bQxkHafUDJn/jt3doYhz4Eppty+y6a0rFANdCx+CRKZ
         WsZQ5m8hmS+WT/gsjCOCskN/nYXWlcUhnzOMEYNzLur82+1pviIyt0zhMCxrvo4EVyKc
         I1bIvLvnMo5Mfnsb6GwijE4eOAtyqQJ5kT1ZGZLrUteORIOba46Nr1aWTup66dM7339W
         pC2Q==
X-Gm-Message-State: AOJu0YzEGxmTDYT4wNqrPZkmEAHqhWmkQXxAH6zHsfsOwryqFAtgfnjA
        rJ1e1XPah0fBGvB344LNkvq0feaTAw/OEgewo68=
X-Google-Smtp-Source: AGHT+IGXAqJyw97V+o4oaIks1Kj/kAns5+tLjlPhppgRBXwPa0+zcI2oLEhzNJD6x+xUpCRPgxj60Q==
X-Received: by 2002:a5d:5389:0:b0:319:6997:9432 with SMTP id d9-20020a5d5389000000b0031969979432mr19677532wrv.1.1693235350535;
        Mon, 28 Aug 2023 08:09:10 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:40c6:6cff:63b:c70a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm10730522wrr.17.2023.08.28.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:09:09 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com, Florent Revest <revest@chromium.org>
Subject: [PATCH v4 3/6] kselftest: vm: Check errnos in mdwe_test
Date:   Mon, 28 Aug 2023 17:08:55 +0200
Message-ID: <20230828150858.393570-4-revest@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230828150858.393570-1-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invalid prctls return a negative code and set errno. It's good practice
to check that errno is set as expected.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/mm/mdwe_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 91aa9c3099e7..1b84cf8e1bbe 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -23,14 +23,22 @@
 TEST(prctl_flags)
 {
 	EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
+	EXPECT_EQ(errno, EINVAL);
 	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
+	EXPECT_EQ(errno, EINVAL);
 	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 7L, 0L), 0);
+	EXPECT_EQ(errno, EINVAL);
 	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 0L, 7L), 0);
+	EXPECT_EQ(errno, EINVAL);
 
 	EXPECT_LT(prctl(PR_GET_MDWE, 7L, 0L, 0L, 0L), 0);
+	EXPECT_EQ(errno, EINVAL);
 	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 7L, 0L, 0L), 0);
+	EXPECT_EQ(errno, EINVAL);
 	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 7L, 0L), 0);
+	EXPECT_EQ(errno, EINVAL);
 	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 0L, 7L), 0);
+	EXPECT_EQ(errno, EINVAL);
 }
 
 FIXTURE(mdwe)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

