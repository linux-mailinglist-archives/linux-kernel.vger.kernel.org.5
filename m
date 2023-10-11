Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB40C7C5B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJKSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjJKSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:24:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A09E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:24:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so331664a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697048664; x=1697653464; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhigiG7r2vYGCxl5bErW87uWnRuAFN/RI/oKaHTvtWo=;
        b=Z2atiAmxDdFFn0tHYBnyNwVv9ppdGm3cDltOTI2JurVWQGyGUso/sRWCtA9N51Vg2m
         gkleRHdZ/BH7YoPAPMKPguK2NC3iny7ugCUgQAdX6tcH2vt+iUz3b/zY/iZNyK17k7Z1
         cDzeo979dd65pE450Jqw5Mymmf/nlpBL8XI7Phz9rnOFQ+I7cg+sh0KTNma+/ippTooq
         b+HsX1xKTxy58EzFnTUCx6cQWAWFBli928YxEdOzU/eIb4/K17c0tjE13cg10QTkMKPs
         7bfqBLye7iB2w0IfpDYgsPzI5lMgA4io1NYnvKYS5TVHsSLrfahuW8Q2S8kWEf5mmRhQ
         PMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048664; x=1697653464;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhigiG7r2vYGCxl5bErW87uWnRuAFN/RI/oKaHTvtWo=;
        b=rdOckAMvpPovBf7iUEwv+3is8fr2VzDF5PiISAjdcChF0lm3ygk7t8ShwH78tgNZ/+
         botPD9/QuCOkayz+N2ji6KWFzB9FJ28s7x4VYuWvo+dvsWGY6J8CtKkMFV29L46gyTOU
         CFOlP+Zv5QUgZ9MPYk5oAiliw325mCpC58rjVnkZfIZYeEVQ6T8Yrs4TAkhWwphpIqCX
         3ZE3MfkNLr+TN+eaaYoYTSeJcoPFKRJS07EZZIgrcxzc6sPSFUBZk1n8dAXpVtDsh3o4
         oF8eNcc8tHaxUFm2JYZTel+VTnw80t2vTfv+wUYSc7Ym9r3iKlINfC9FfSZAoHFEbl4e
         b2ow==
X-Gm-Message-State: AOJu0YzCBQp9o63JB3i4J3DoUXkiQtw39QU6267+H6M6aOzr3i3EUzzs
        oi6DVCF2ROM6HORd9kkUgA==
X-Google-Smtp-Source: AGHT+IGVo7Egnhd5Nr4kMfzbttLLZADZ+HSnAz3rEKyIoBnRbHifXOOhwajpvvjl6ON2s4M0D+VSDw==
X-Received: by 2002:a05:6402:b89:b0:53d:eca8:8775 with SMTP id cf9-20020a0564020b8900b0053deca88775mr1359175edb.26.1697048663739;
        Wed, 11 Oct 2023 11:24:23 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id j18-20020a508a92000000b0053deb97e8e6sm733724edj.28.2023.10.11.11.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:24:23 -0700 (PDT)
Date:   Wed, 11 Oct 2023 21:24:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs: move and constify sysctl_nr_open_min, sysctl_nr_open_max
Message-ID: <02591c1e-936b-46bf-ad2b-402b33338eee@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysctl_nr_open_min, sysctl_nr_open_max variables are really hard limits
on fs.nr_open sysctl, they aren't interesting to the rest of the code
and are constants (sysctl_nr_open is not constant obviously).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/file.c            |    5 -----
 fs/file_table.c      |   10 ++++++++--
 include/linux/file.h |    2 --
 3 files changed, 8 insertions(+), 9 deletions(-)

--- a/fs/file.c
+++ b/fs/file.c
@@ -25,11 +25,6 @@
 #include "internal.h"
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
-unsigned int sysctl_nr_open_min = BITS_PER_LONG;
-/* our min() is unusable in constant expressions ;-/ */
-#define __const_min(x, y) ((x) < (y) ? (x) : (y))
-unsigned int sysctl_nr_open_max =
-	__const_min(INT_MAX, ~(size_t)0/sizeof(void *)) & -BITS_PER_LONG;
 
 static void __free_fdtable(struct fdtable *fdt)
 {
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -111,6 +111,12 @@ static int proc_nr_files(struct ctl_table *table, int write, void *buffer,
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+static const unsigned int sysctl_nr_open_min = BITS_PER_LONG;
+/* our min() is unusable in constant expressions ;-/ */
+#define __const_min(x, y) ((x) < (y) ? (x) : (y))
+static const unsigned int sysctl_nr_open_max =
+	__const_min(INT_MAX, ~(size_t)0/sizeof(void *)) & -BITS_PER_LONG;
+
 static struct ctl_table fs_stat_sysctls[] = {
 	{
 		.procname	= "file-nr",
@@ -134,8 +140,8 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &sysctl_nr_open_min,
-		.extra2		= &sysctl_nr_open_max,
+		.extra1		= (void *)&sysctl_nr_open_min,
+		.extra2		= (void *)&sysctl_nr_open_max,
 	},
 	{ }
 };
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -113,6 +113,4 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
-extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
-
 #endif /* __LINUX_FILE_H */
