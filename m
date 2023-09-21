Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BD7A9DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjIUTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjIUToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:44:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1510D76C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:31:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053c6f0da0so1640145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695324664; x=1695929464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXl3XjtNY+qQUGAfKFbAOhIfMu203xufyzo0Jfa0XyY=;
        b=iRPclcbEziiuXphFxRjzycEIzgzVvfixovnnY4z5rMoA8nZQhVSi2TzjFvZhuYnott
         F1ZFDsMMxSO4O99WzxyJDTcpo4zhddeK3Q0OVoDfH/ypn6AdIdHlwqmlkxqkLp5B5q5w
         QolScV9TwCk/GfZ8CelkWOwX7wqK5Hd60a2nzZnX9XrFQfi089RIYsnxhgoUiubdtu1M
         fYrd7hOnuxK14aKZyIBbRtuw1/1Ck3zFJRyJElwQ9rqKV6Kt8iWTdnfDCjW9BIx7q2ds
         Fvwenutawy+gAoF8SGE8c1XYI3Wt2jp6gs/TxVghZX4jDiHEHmDJJHFoQ1xqpUakJpqV
         Q3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324664; x=1695929464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXl3XjtNY+qQUGAfKFbAOhIfMu203xufyzo0Jfa0XyY=;
        b=EIomeeeB/V89W4OcanAsjfM9p/vo8KY8X/uxW1l6z+fg5Z6QZssFj/uG5h0HGklT0T
         ErRZbMDaHRZl/WP7FSLPF710ZaPHBt2aKs454kkUxCYUWiM9orlaNooNKbV9CF+gdvvs
         1xf8zs5WGdzPZktVo63EumdLGtbJvy4quInL1n2WtVWrgjCRC3+dmE+HZFjU1Hsi7qvZ
         TNiGOiX6jP4ohe3fwFL13C0KkpumwIopf2AQrXDlQssCZlVmVfXJvs3AJTYyUnEWDhIJ
         kKeC93b5rHCPx7sg3McEvk2H0dvnlXNuIjTtR2KNLfth/JorlVN2+6LmQyr/IfP3Bjhj
         2J9g==
X-Gm-Message-State: AOJu0Yy0Utwjs//cQhKMjUEySipkhjZ5/2x0BwDCQkw82qw6Absw4fvz
        9+rKgIVA9XsOwsCicZL+qlxAQkfRJa7vRBCPFPI=
X-Google-Smtp-Source: AGHT+IF1pBtqoHJupqJB89JDTv8U2tPiwASllgBiXga49KhWXGoCCYdQLyGMzig5D0GLqGXQxvk2QQ==
X-Received: by 2002:ac2:44ce:0:b0:503:f:1343 with SMTP id d14-20020ac244ce000000b00503000f1343mr3999054lfm.19.1695283079562;
        Thu, 21 Sep 2023 00:57:59 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fef19bb55csm1151252wml.34.2023.09.21.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:57:59 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, howells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/4] pipe: reduce padding in struct pipe_inode_info
Date:   Thu, 21 Sep 2023 09:57:52 +0200
Message-Id: <20230921075755.1378787-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has no effect on 64 bit because there are 10 32-bit integers
surrounding the two bools, but on 32 bit architectures, this reduces
the struct size by 4 bytes by merging the two bools into one word.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/pipe_fs_i.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 608a9eb86bff..598a411d7da2 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -62,9 +62,6 @@ struct pipe_inode_info {
 	unsigned int tail;
 	unsigned int max_usage;
 	unsigned int ring_size;
-#ifdef CONFIG_WATCH_QUEUE
-	bool note_loss;
-#endif
 	unsigned int nr_accounted;
 	unsigned int readers;
 	unsigned int writers;
@@ -72,6 +69,9 @@ struct pipe_inode_info {
 	unsigned int r_counter;
 	unsigned int w_counter;
 	bool poll_usage;
+#ifdef CONFIG_WATCH_QUEUE
+	bool note_loss;
+#endif
 	struct page *tmp_page;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
-- 
2.39.2

