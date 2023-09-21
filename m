Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0267AA566
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjIUXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjIUXAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:00:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396898A203
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:40:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so22335401fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695318027; x=1695922827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exindjDRedXgd3Z4uqnR6aLnmaUK9oSQ00jryr/8dkk=;
        b=c2fwadW/bxkT2mvxY06pYDFleUPJ6t9rsbDH/sy+z7l+nnQC7aJZB4qTFpHtVV0hTh
         10KEl5kps2ChhyFkt+IfPA7+jgu8AIVqfMERwclqAwWZUX16ZKoWbAvuHx/ryzQQKlG3
         u3fHkaI3RzRHQMuzKa7s+y4BLtwdUeOAcNU1ZNZM7iVROQkp8yAqQKRjKhlEBOzW0kxs
         aoYhwEGTg1SoTv1SXozK7ioYt0CiKuGi2x9Ebrz/jMHbDZm3siNU5CWxki1XiPKjyb7p
         388ZZRx1GTibwL/j6ABRDrQxlTX5dloByrlQoMVY5fGilZoPMoRop+AAl0Aeh/IwgUfk
         WhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318027; x=1695922827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exindjDRedXgd3Z4uqnR6aLnmaUK9oSQ00jryr/8dkk=;
        b=edCefjok8/MEZx3xSJ6MVfzI/Y1nifqxWlXT4lQyVVk5B7TwdzZo8mXrLmt1EGfnyR
         Gc9caQQK5XSK9eHDjet7uMHn30snsCzht8bObQwcjwlCXupVaAEXlAvYEwGFFEZNAKZa
         ShvdxJgHxBlQ+EwfzNMmADdrl0GkymhM3EdTN1X3zmMlgknrOCJGPsI9PUKRWIuUDhIv
         Je09nZl+wd/CAkmqcz1o8WgDL9bc8C9Vm3rIP8Xu67sLWKkevaiUhJVyHY/hwXtNNr6v
         wd01i+eWJXw+JlJYJQDonXRqHtE7Msj03AupUNixX2kdTEBz3oDRSM6kuEQtkpSNQeWN
         IwjA==
X-Gm-Message-State: AOJu0YyES0pxTHsGx0I6xl50ItVs1p7Mzi4u3Qafb+mW6gNpxakWdvGs
        aUNM6PiuyUZhuhbCaGxFTDkjU763u+TGmAhS0VQ=
X-Google-Smtp-Source: AGHT+IGgD2cpMGXUp64ky7Z5KuE2s5kxlCzRjSWpVK8NceErhc6QZfb9I2OKWDGSASGhoo1owTOA2w==
X-Received: by 2002:a05:600c:2109:b0:401:bedd:7d42 with SMTP id u9-20020a05600c210900b00401bedd7d42mr4517741wml.13.1695283081746;
        Thu, 21 Sep 2023 00:58:01 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fef19bb55csm1151252wml.34.2023.09.21.00.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:58:01 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, howells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/4] fs/pipe: move check to pipe_has_watch_queue()
Date:   Thu, 21 Sep 2023 09:57:53 +0200
Message-Id: <20230921075755.1378787-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921075755.1378787-1-max.kellermann@ionos.com>
References: <20230921075755.1378787-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This declutters the code by reducing the number of #ifdefs and makes
the watch_queue checks simpler.  This has no runtime effect; the
machine code is identical.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/pipe.c                 | 12 +++---------
 include/linux/pipe_fs_i.h | 13 +++++++++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6c1a9b1db907..6ecaccb48738 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -437,12 +437,10 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue) {
+	if (pipe_has_watch_queue(pipe)) {
 		ret = -EXDEV;
 		goto out;
 	}
-#endif
 
 	/*
 	 * If it wasn't empty we try to merge new data into
@@ -1325,10 +1323,8 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned int arg)
 	unsigned int nr_slots, size;
 	long ret = 0;
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue)
+	if (pipe_has_watch_queue(pipe))
 		return -EBUSY;
-#endif
 
 	size = round_pipe_size(arg);
 	nr_slots = size >> PAGE_SHIFT;
@@ -1380,10 +1376,8 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 
 	if (file->f_op != &pipefifo_fops || !pipe)
 		return NULL;
-#ifdef CONFIG_WATCH_QUEUE
-	if (for_splice && pipe->watch_queue)
+	if (for_splice && pipe_has_watch_queue(pipe))
 		return NULL;
-#endif
 	return pipe;
 }
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 598a411d7da2..699507c52b72 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -124,6 +124,19 @@ struct pipe_buf_operations {
 	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
+/**
+ * pipe_has_watch_queue - Check whether the pipe is a watch_queue,
+ * i.e. it was created with O_NOTIFICATION_PIPE
+ */
+static inline bool pipe_has_watch_queue(const struct pipe_inode_info *pipe)
+{
+#ifdef CONFIG_WATCH_QUEUE
+	return pipe->watch_queue != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * pipe_empty - Return true if the pipe is empty
  * @head: The pipe ring head pointer
-- 
2.39.2

