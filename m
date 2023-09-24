Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5137AC6DC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjIXGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIXGu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:50:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A94ACA;
        Sat, 23 Sep 2023 23:50:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f2719ab2so1137341b3a.0;
        Sat, 23 Sep 2023 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695538222; x=1696143022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrHTSpkzd+LXtpKuymSYv3mpDomhlVl0YG5JvuCE3wQ=;
        b=O4hjqhs9/opvQsxqLtmcgws1LtdSUnYuVc7YS293GkiYbAp8qnfoQk5haY0p13X/5O
         d0a9cfswjmVLFyfEtyCEheTjAkoc2VLtVx2Y4f3YK4BBU9mLt92f+NHSwm3xc0BzOZ07
         VT/16d3eYD6xpNkd7oG56RCJCSlCkFWyml8jtFDuWjWhU/WZFCTCNenRrLyAKA2vqh/t
         Ab5BfwRcgTE5wSIdH8vpSho3BZbI6F+EFtVuNFOXTO8RcQcl3P+AdZA+WmLxKsmadqAt
         dRHPPXcECPbdFU1Bp8TWdEDOsAoGsyYaixzbrUufcgjh/etDl5DwgOBy7sfLWXgHbEko
         D/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695538222; x=1696143022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrHTSpkzd+LXtpKuymSYv3mpDomhlVl0YG5JvuCE3wQ=;
        b=dno0nyKWdulrwDQiJGwwdS9sUdaK+CKWkH5CMH9rE9lEpnIcie8s3qn6RTarQTT17i
         50Pz+GQhqSKiNDeSpOMqFf2PGrfVumdgGtYBdlmoODSrqG+CosWY8jJjxxqEfw9T1C++
         IZXgzq9rFF8lyF0+/fKTTurujeW+AaJvMrq0OBIv/V0VTpJzcD08DQTFJWXBdAGbBqah
         am8kKt0jhq23X1TzJuS0pnvTThsfbNRaTKj8a7c3Un8MfGI2SdV0NgIrur4nujo8oPbo
         MieWMGzXYLtFLZlRcHAslx3krbiRI7lukDnqAB+kxFf6ZWQKCWlgAHcyxUOOoUrQqQ7s
         aagQ==
X-Gm-Message-State: AOJu0YxDQysGQbXtw5cTJexduVLmHa36LtbcN2AaL+tRFfyBdjbVFJdW
        RGBVaB7Sk+CTqOIN6ONtpnPXsRVVGbKUa7vz
X-Google-Smtp-Source: AGHT+IE6bw4BXFQteOfUtY0WSyz9whBozxmGfEK37Ua+VFCEmqf5qPcMmdiFpWziLX/C701CnoYo3Q==
X-Received: by 2002:a05:6a00:1d8a:b0:68e:25ff:613e with SMTP id z10-20020a056a001d8a00b0068e25ff613emr4485965pfw.3.1695538221989;
        Sat, 23 Sep 2023 23:50:21 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b0068fc6570874sm5828899pfn.9.2023.09.23.23.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 23:50:21 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] tools/thermal: fix memory leak in realloc failure handling
Date:   Sun, 24 Sep 2023 14:50:13 +0800
Message-Id: <20230924065013.1081471-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous code, there was a memory leak issue where the
previously allocated memory was not freed upon a failed realloc
operation. This patch addresses the problem by releasing the old memory
before setting the pointer to NULL in case of a realloc failure. This
ensures that memory is properly managed and avoids potential memory
leaks.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/thermal/lib/mainloop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/lib/mainloop.c b/tools/thermal/lib/mainloop.c
index 94cbbcbd1c14..6dcc4090d47e 100644
--- a/tools/thermal/lib/mainloop.c
+++ b/tools/thermal/lib/mainloop.c
@@ -62,9 +62,13 @@ int mainloop_add(int fd, mainloop_callback_t cb, void *data)
 	struct mainloop_data *md;
 
 	if (fd >= nrhandler) {
-		mds = realloc(mds, sizeof(*mds) * (fd + 1));
-		if (!mds)
+		struct mainloop_data **mds_tmp =
+			realloc(mds, sizeof(*mds) * (fd + 1));
+		if (!mds_tmp) {
+			free(mds);
 			return -1;
+		}
+		mds = mds_tmp;
 		nrhandler = fd + 1;
 	}
 
-- 
2.25.1

