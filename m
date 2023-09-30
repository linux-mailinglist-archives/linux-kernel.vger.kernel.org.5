Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1377B3ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjI3H1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjI3H1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:27:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E74C5;
        Sat, 30 Sep 2023 00:27:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so2456239a12.0;
        Sat, 30 Sep 2023 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696058847; x=1696663647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzQbe3xqikAXp9OvaPgwc5fcgw/0yjo9zmm5YHRYu8k=;
        b=YJyffz8aIDJbks+jmSLd/aVrGK+049feH/RZp2dgNi/YlZZRUoxzNIVNH1AjW3uEwH
         d0zB59pGvQbHNKwCbtus58R6HP1ognyc+5+KDa177HftUWsLq7/9pnnDL35MpO1oh1iQ
         DF6YnmyAc1x16d53RGVQQSfdPGMIg+pPuvH+cm38sZT1NT/44MvWb9pRKp48H1Zed1tP
         120544DokQx3aOpdJ7TS/CtJLQm6hn0/toeUcmiLVcr5Fn0SmPZ5DvlWIx7hUE5szLB1
         0czqmSlihPWl33pV2yVx0d8xBVic9PQGs4KHCuc2gMGYwhguqtkS1T01kyN/S9Sy1lGG
         zWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696058847; x=1696663647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzQbe3xqikAXp9OvaPgwc5fcgw/0yjo9zmm5YHRYu8k=;
        b=OQZgVblbphoHi0cSctlx0FAGL6MP5yArv1eau72GWcl0hM0kcgiM8fzstbkWwVaMGg
         CulE776fKdwRmDuJIkuGbQtz9jqlZOQ7fSzWvys/Nn+lhdY9hBndqxJKzukddp3ykBZd
         3WODvqmvrsk2YEW5tKc5Nu5pjR2NJjYEgtmmPfKOwenQbXYjXW9HTnDaZC0FscctAZ56
         4l4rIjxeVHTlkavmVA6qbaPlbDiNwINilYR1EHgL98qNPK174INUxgXXoctkJ1nDlonp
         hCK3lbA4+ZIyfUku3QrzkvAlWusuFzwnEqXmvH0+MdU9UA4IS5Sm+nnsOAINMrb27OwA
         T4xQ==
X-Gm-Message-State: AOJu0YwFqsIRVqWCuqOj4fc5Gdx4T3Y12u/mifPsuDDU2UbxAuX8Vieq
        aIFjSZwXGc6CKemeFinfWug=
X-Google-Smtp-Source: AGHT+IFqLpF0bbPNUywr+lAB8eUGEusBLfO5jBZnb1OO8Mj3Ij6/EM4uF4pbX6hLiqySsom0Lwojnw==
X-Received: by 2002:a17:902:f54b:b0:1c3:a4f2:7cc1 with SMTP id h11-20020a170902f54b00b001c3a4f27cc1mr6793684plf.5.1696058847485;
        Sat, 30 Sep 2023 00:27:27 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001acae9734c0sm800627plw.266.2023.09.30.00.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 00:27:26 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     yangyicong@hisilicon.com, jonathan.cameron@huawei.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] perf hisi-ptt: Fix memory leak in lseek failure handling
Date:   Sat, 30 Sep 2023 15:27:19 +0800
Message-Id: <20230930072719.1267784-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous code, there was a memory leak issue where the previously
allocated memory was not freed upon a failed lseek operation. This patch
addresses the problem by releasing the old memory before returning -errno
in case of a lseek failure. This ensures that memory is properly managed
and avoids potential memory leaks.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/perf/util/hisi-ptt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 45b614bb73bf..43bd1ca62d58 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -108,8 +108,10 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
 		data_offset = 0;
 	} else {
 		data_offset = lseek(fd, 0, SEEK_CUR);
-		if (data_offset == -1)
+		if (data_offset == -1) {
+			free(data);
 			return -errno;
+		}
 	}
 
 	err = readn(fd, data, size);
-- 
2.25.1

