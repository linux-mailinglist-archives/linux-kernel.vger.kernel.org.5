Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A74D7FCE55
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjK2FfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjK2FfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:35:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424CC19AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:25 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cbe716b511so4827950b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236124; x=1701840924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwvK48qFUm0jCa9wEfVcXn45D/cRCqvvkYtg9bxD7CQ=;
        b=bp0oQe9UlkFRjkIx9QI9KDBxM8CKm9e0RQ9yt/Qix0KYIn2DttzSxYxNOgLL863MlG
         D4PqGO+ZxG7y1RleoHR4MnAU7BekyB5nBiDuyJkB0VEkN/7/LipqTKOvIRc/eqS6CFBk
         xEzaDXTCNR202R6Tlpf89IoqcWmyr8QOSZBS9J03v8e1ZMIbThMkW5umWhK71C4lfmei
         /3aM57zK5Bwf2YVzwreRmojucpMpNGT9Er1uJivsj+i/9cpMvtayjRdqWMCUqsABkwsp
         RCzgL4qcIeS0S2cU5LETLRwrvHDo2QV4+L4Er8M9uCICFNNf5I+jeBfWMRMa3oL+W5cM
         Bh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236124; x=1701840924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwvK48qFUm0jCa9wEfVcXn45D/cRCqvvkYtg9bxD7CQ=;
        b=ciRyhVqFjpLv1fHI5k0Je+Nx56ORIKB36WicoAlEXQTxbNBhVKXl7jH7yTDGSWTZJt
         OSNiQUCaqn1mpvfjfiHv8ND9MUd+bGP6QAX1KKnVNEDGzGpUYcsBGkwJ9YI7zedTf8QI
         I0p7v4LdySw3i74MiUfrkLT97VjmqomZcflJuL8+29t68OOOLpAOWdPir4hFdqCdvQiA
         IVIhkt+Q7ARmtpfSnGopUxiV3EsvfptkvqgClFAa8gDaHHAD69qf6H/+7IYjoz2g8LnM
         6YoDTpR0OkkTW0NnFcDq6e0Ks+5DWrKqn9LiiJ30fP4hNKk6P1i9en5/lpnQB2a3l5pr
         ANwQ==
X-Gm-Message-State: AOJu0Yw810l3UZ61MAmwI6NehTnp1hljIurz8pZIyB+0P7EplA0GXV1Z
        tQC2DxEBob4kc1ukN8aAy6JxyHlZtOCf3Q==
X-Google-Smtp-Source: AGHT+IGqw9zpcmv9S8ayL/b0Kmr/cPkw5pqGB8FtB1beqRSMUAvhJmfMDLi0YT1zEZ6KrwMRF/bgpw==
X-Received: by 2002:a05:6a20:8e1e:b0:18c:6c2:55e0 with SMTP id y30-20020a056a208e1e00b0018c06c255e0mr16921486pzj.22.1701236124324;
        Tue, 28 Nov 2023 21:35:24 -0800 (PST)
Received: from ubuntu.. ([43.132.98.44])
        by smtp.googlemail.com with ESMTPSA id gj6-20020a17090b108600b00285a2d14184sm660717pjb.0.2023.11.28.21.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 21:35:23 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: [PATCH v3 2/3] seccomp: Introduce new flag SECCOMP_FILTER_FLAG_FILTER_FD
Date:   Wed, 29 Nov 2023 05:34:39 +0000
Message-Id: <20231129053440.41522-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129053440.41522-1-hengqi.chen@gmail.com>
References: <20231129053440.41522-1-hengqi.chen@gmail.com>
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

Add a new flag SECCOMP_FILTER_FLAG_FILTER_FD for SECCOMP_SET_MODE_FILTER.
This indicates user supply a seccomp filter fd, not a sock_fprog.
It allows us to attach the seccomp filter that is previously loaded via
SECCOMP_LOAD_FILTER.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/linux/seccomp.h      |  3 ++-
 include/uapi/linux/seccomp.h |  2 ++
 kernel/seccomp.c             | 44 +++++++++++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 175079552f68..3257042c35fc 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -9,7 +9,8 @@
 					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
 					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
 					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH | \
-					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
+					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV | \
+					 SECCOMP_FILTER_FLAG_FILTER_FD)
 
 /* sizeof() the first published struct seccomp_notif_addfd */
 #define SECCOMP_NOTIFY_ADDFD_SIZE_VER0 24
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index ee2c83697810..41e0ca56ef1c 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -26,6 +26,8 @@
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+/* Indicates that the filter is a fd obtained from SECCOMP_LOAD_FILTER */
+#define SECCOMP_FILTER_FLAG_FILTER_FD		(1UL << 6)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ef956c3d15c7..a43a6a6b6b77 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -883,8 +883,11 @@ static long seccomp_attach_filter(unsigned int flags,
 
 	/* Validate resulting filter length. */
 	total_insns = filter->prog->len;
-	for (walker = current->seccomp.filter; walker; walker = walker->prev)
+	for (walker = current->seccomp.filter; walker; walker = walker->prev) {
 		total_insns += walker->prog->len + 4;  /* 4 instr penalty */
+		if (walker == filter)
+			return -EEXIST;
+	}
 	if (total_insns > MAX_INSNS_PER_PATH)
 		return -ENOMEM;
 
@@ -1897,6 +1900,38 @@ static const struct file_operations seccomp_filter_fops = {
 	.release = seccomp_filter_put,
 };
 
+/**
+ * seccomp_prepare_filter_from_fd - prepares filter from a user-supplied fd
+ * @ufd: pointer to fd that refers to a seccomp filter.
+ *
+ * Returns filter on success or an ERR_PTR on failure.
+ */
+static struct seccomp_filter *
+seccomp_prepare_filter_from_fd(const char __user *ufd)
+{
+	struct seccomp_filter *sfilter;
+	struct fd f;
+	int fd;
+
+	if (copy_from_user(&fd, ufd, sizeof(fd)))
+		return ERR_PTR(-EFAULT);
+
+	f = fdget(fd);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+
+	if (f.file->f_op != &seccomp_filter_fops) {
+		fdput(f);
+		return ERR_PTR(-EINVAL);
+	}
+
+	sfilter = f.file->private_data;
+	__get_seccomp_filter(sfilter);
+
+	fdput(f);
+	return sfilter;
+}
+
 /**
  * seccomp_set_mode_filter: internal function for setting seccomp filter
  * @flags:  flags to change filter behavior
@@ -1944,7 +1979,10 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		return -EINVAL;
 
 	/* Prepare the new filter before holding any locks. */
-	prepared = seccomp_prepare_user_filter(filter);
+	if (flags & SECCOMP_FILTER_FLAG_FILTER_FD)
+		prepared = seccomp_prepare_filter_from_fd(filter);
+	else
+		prepared = seccomp_prepare_user_filter(filter);
 	if (IS_ERR(prepared))
 		return PTR_ERR(prepared);
 
@@ -2005,7 +2043,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		}
 	}
 out_free:
-	seccomp_filter_free(prepared);
+	__put_seccomp_filter(prepared);
 	return ret;
 }
 
-- 
2.34.1

