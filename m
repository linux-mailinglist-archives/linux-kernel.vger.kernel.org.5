Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3B78B410
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjH1PJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjH1PJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD412A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so30691475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235352; x=1693840152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C6695DueeDZA9rTKrXkRn2f/fH50YffF9JA6g5ta/Y=;
        b=WtQfO4zgxksMpW7OaaxuZIAENI54VG0EzFAggndg9mUcIb3M2Xezcabx2+YryWgbAA
         N9iFiJ9bLirdEgKUNaxjDRF5W2tAbI2K3Rno8gaX6aJemzBypmY5oCw4hU97bDhNBdbn
         Rp2FXqPaLlJyPRfxE/Y4ar83+m9lXRdXQxNQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235352; x=1693840152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C6695DueeDZA9rTKrXkRn2f/fH50YffF9JA6g5ta/Y=;
        b=QX9zAZISl4gbmG4nJPU12qaSD7JlZtlmYmWfFQyaHRo6aehM3oW0MauLSygcyDBPi2
         sufUpSrqOcK1d8L9lgwXvz3iPTmxcg6LmQ8ke/sOu51bvs/eZMelMM6HoippAHAjUm0N
         aqCBghPJBd1xnmDbxoY510bLDqfZQ6C+2r/A6cNPckbmtN+C099bwHh4GejAk6kMPAM6
         0pcwHueb3YALaxxdoacjOQTvDhQiTXXKrcy27KThI1eL7v3w7LINZqbpWrwkZColJgyw
         l4zRMASsQs+ePwI7YP4IX91JRSPWzeYJn+bdO89KaZypI/Tn9RsO8DBmJ1nWDiI2SqzI
         YJlA==
X-Gm-Message-State: AOJu0Yyzfo1NU3uG5yf+APp9C8mCHI0fQQZ/uMc2hM4QRv3OuedKGCFS
        61MBjT7ppUvUwXn2yoYl/nOsP5/RHVhQf1Hj8So=
X-Google-Smtp-Source: AGHT+IEXUnMXPaBwdEFmcdrUudhk8uAYHPBV2ErTGdS4NlCyRahLQ06reLojtBElYN3aftIEBravdQ==
X-Received: by 2002:a7b:cb49:0:b0:3fb:a506:5656 with SMTP id v9-20020a7bcb49000000b003fba5065656mr20934266wmj.32.1693235352415;
        Mon, 28 Aug 2023 08:09:12 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:40c6:6cff:63b:c70a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm10730522wrr.17.2023.08.28.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:09:11 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com, Florent Revest <revest@chromium.org>,
        stable@vger.kernel.org
Subject: [PATCH v4 4/6] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Date:   Mon, 28 Aug 2023 17:08:56 +0200
Message-ID: <20230828150858.393570-5-revest@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230828150858.393570-1-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining a prctl flag as an int is a footgun because on a 64 bit machine
and with a variadic implementation of prctl (like in musl and glibc),
when used directly as a prctl argument, it can get casted to long with
garbage upper bits which would result in unexpected behaviors.

This patch changes the constant to an unsigned long to eliminate that
possibilities. This does not break UAPI.

Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
Cc: stable@vger.kernel.org
Signed-off-by: Florent Revest <revest@chromium.org>
Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/uapi/linux/prctl.h       | 2 +-
 tools/include/uapi/linux/prctl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3c36aeade991..9a85c69782bd 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -283,7 +283,7 @@ struct prctl_mm_map {
 
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
-# define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
 
 #define PR_GET_MDWE			66
 
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 3c36aeade991..9a85c69782bd 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -283,7 +283,7 @@ struct prctl_mm_map {
 
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
-# define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
 
 #define PR_GET_MDWE			66
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

