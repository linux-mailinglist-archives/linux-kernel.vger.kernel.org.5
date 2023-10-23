Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4FE7D405D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjJWTjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWTjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:39:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088AC0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:39:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a81a80097fso50808727b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698089984; x=1698694784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9EIZiW1HwjzgzPQnsdOlRK+mgWuyYzh91PBmK2SZvQ=;
        b=pZLrZw0YfuDygzr91zxC7gJYE5umiWM/sbZ6RQSoXdcm0v/A/oninyLNitxrTWpnNZ
         hWqqH2CFK2iaunA47NRngSe5yJ/mAiJpq7Zs7enmDKe3QN1xJIU4+oLQDdPsY+j/ulXi
         Q5SJuGfNjNG8XJmmG3lj0iFlN+w0kUT2Nweq2oBcpRUccS4kc13c2eKDATqTJs6wCMGg
         LMmedRNCfNa1gsdPmIIcKd3opb+pSU+y8uyUSjHmMiC8LBZX1UfDlLVGmBGJOzdsb+VA
         h6osO4rORHD5Tw8W3biqAIB3MvPFGEXP6U17OWakeWiuWhesz2aXd8ZcvT7YR/fE18Wf
         dKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089984; x=1698694784;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9EIZiW1HwjzgzPQnsdOlRK+mgWuyYzh91PBmK2SZvQ=;
        b=sh53MfrUxNQShjR6+fyd8UVsz7EFe5ivs8+ndgkVx37qwK5co+DvwrHg9OhTdXe/L5
         BFbdnPR4PGBdZTV603s7BV+C+Kg94sJzYYlVmWeHyuuznaDQtzhlfzrrX/o6cG/o4/aQ
         bUY2jr9SFegDdWnJGKRnpYyZ6yLECR0WNEgF9zRMgDoshoEQnul1KADFeyPmJec4Xb30
         BALwzRy7k9sHkqhLuLlcI7eXA6GosbBAZrG/pLnpJpNOGDnxt1+NiZjd5+MNg76lg/Ak
         I1Fpg2MmrkvpIp+Q0ALi4slwLH9YwT6ULo8My3XflI2IGQQ4v08RrMvZ6ei7vK3nrXLJ
         n/ew==
X-Gm-Message-State: AOJu0YyX2ub6PhK+O6tE9PU2bvClNQTWqePhqpFvHaYVLTQSI9GIoEW0
        t28xq9YHDJb5sqvH3GdDIEdDqqIqJcWQ4rQhSg==
X-Google-Smtp-Source: AGHT+IGK4A3kzKHMuI1vfQcGREADhmi6Xw83SP8yDuQv0J3EKfsflMNbU94U/eagV1Cxkz8W4vwLPtTNxoEOQ4RlHg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:524f:0:b0:59b:f3a2:cd79 with SMTP
 id g76-20020a81524f000000b0059bf3a2cd79mr209796ywb.8.1698089984390; Mon, 23
 Oct 2023 12:39:44 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:39:39 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPrLNmUC/x2NwQ6CQAwFf4X0bJOyJKL+ijEEl6f04ILthkAI/
 +7GwxzmMrOTwxROt2onw6KuUypSnyqKY5/eYB2KU5DQ1AX2bCnOGw+mC8zZm6twQuYv8tjFydB 9ek0cWZ4CyOXcBkQqvdnw0vX/uj+O4wfaSOZzewAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698089983; l=2072;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=M5RJKmWPvcJapRTNGdtENHYtsTUHGQvR0yt/b2ASDXM=; b=ZhkAnJlpERSNbPEUqrn6noB5gdUU1Q+eak5GCE3RG37c9uzSozI+Cq7MPmxpD2XXjuYIF4rjZ
 ZcOVJ3phr4bD4D9lgbRI2UQc3Ts2rIWms6GJlebnY2kx5Na3GN7KOpl
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
Subject: [PATCH] s390/qeth: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect new_entry->dbf_name to be NUL-terminated based on its use with
strcmp():
|       if (strcmp(entry->dbf_name, name) == 0) {

Moreover, NUL-padding is not required as new_entry is kzalloc'd just
before this assignment:
|       new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);

... rendering any future NUL-byte assignments (like the ones strncpy()
does) redundant.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cd783290bde5..6af2511e070c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6226,7 +6226,7 @@ static int qeth_add_dbf_entry(struct qeth_card *card, char *name)
 	new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);
 	if (!new_entry)
 		goto err_dbg;
-	strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
+	strscpy(new_entry->dbf_name, name, sizeof(new_entry->dbf_name));
 	new_entry->dbf_info = card->debug;
 	mutex_lock(&qeth_dbf_list_mutex);
 	list_add(&new_entry->dbf_list, &qeth_dbf_list);

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-s390-net-qeth_core_main-c-0b0ee08672ec

Best regards,
--
Justin Stitt <justinstitt@google.com>

