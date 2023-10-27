Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05A7D9B36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjJ0OVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346216AbjJ0OVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:21:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833D1AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:21:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9becde9ea7bso688792566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698416466; x=1699021266; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6i8VATS6nFhEbYaXyntF8SokXtip/zVE7KgzAiMv+E=;
        b=O8LpcAaSefsQry5b0QTcPDp2H5xq+tcuw86GTFdXi+EuKJ2k5s/+h16yuGlKOhKTbF
         gPYPFFO2+3onCMmTa+u2iCcXB/KTcjb9cv/ksZXuV29gL290hV8PXGKywFo3dlPG9URh
         RmVAAO/2ihAsS3KkiMxoGF6+fNyiPSbpaQ+Me3GtLUazdLlQdZUkKaQ6+qv+z2BY5uov
         LG7HBSkAt0005LtEHjNs63PiGpxm3GbX2ISRexfqWd9FSa5FrQSt5ymxP3C0ba/BCP4o
         53wXUXxqacRuP/7po5NqD8lb8c2tFSqG6A4sHTbX1fWbSsq3dK5gYaJZYnBU3i9tLLmY
         NETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416466; x=1699021266;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6i8VATS6nFhEbYaXyntF8SokXtip/zVE7KgzAiMv+E=;
        b=gyLDbZS+XQzcDjVJIxG1SXvzYBarzTjR+iZH1ALEZO0X+1kbcDsilSec/UxvU/iIn4
         idi8pAOQVus9PSgUqos0ESuDA8/BWYI3NRmIA2fyNBl2MfywahAvH1ZvtCj9F9BlvZpc
         J/EE6lo0RXuqnpRKEpQNtnt5e5Tq+Ln8ik9ukDdbCSjsREOIIFUETbyIC68yVy6cNE+u
         rkpG01tUwzmNkoicpwYTwBT9f4qQjce1XXDuwf0NPNy+qNzJYJCbHINtftwHT2qTMlWS
         gCKQaOJ/Id7JtVMjv+mPCiSYl5lkdPLC+fG0zjzgqJOSg3NYZjhZP+BSOpO+4WfL2vG8
         qgHg==
X-Gm-Message-State: AOJu0YzBUM++LA0LQiCI8OHUHcq1+nPabBh+UqyoSBdeq0Dj49ghELau
        9+BgLonWCzwl5ZVDMZwzpZnKJgFBJQ==
X-Google-Smtp-Source: AGHT+IGuZr6Sm+v1lFmgkTlgNwytB0Nd5v7JpjLSwq2EYKiyl5urEBnNV9UwEbwlIC9es6lb9CW/oQ==
X-Received: by 2002:a17:907:3f9f:b0:9b2:be5e:3674 with SMTP id hr31-20020a1709073f9f00b009b2be5e3674mr2926543ejc.36.1698416466036;
        Fri, 27 Oct 2023 07:21:06 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id ov6-20020a170906fc0600b00992e14af9c3sm1276747ejb.143.2023.10.27.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:21:05 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:21:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] proc: fix proc-empty-vm test with vsyscall
Message-ID: <76f42cce-b1ab-45ec-b6b2-4c64f0dccb90@p183>
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

* fix embarassing /proc/*/smaps test bug due to a typo in variable name
  it tested only the first line of the output if vsyscall is enabled:

  	ffffffffff600000-ffffffffff601000 r-xp ...

  so test passed but tested only VMA location and permissions.

* add "KSM" entry, unnoticed because (1)

* swap "r-xp" and "--xp" vsyscall test strings,
  also unnoticed because (1)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-empty-vm.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -60,7 +60,7 @@ static const char proc_pid_maps_vsyscall_2[] =
 static const char proc_pid_smaps_vsyscall_0[] = "";
 
 static const char proc_pid_smaps_vsyscall_1[] =
-"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n"
+"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n"
 "Size:                  4 kB\n"
 "KernelPageSize:        4 kB\n"
 "MMUPageSize:           4 kB\n"
@@ -73,6 +73,7 @@ static const char proc_pid_smaps_vsyscall_1[] =
 "Private_Dirty:         0 kB\n"
 "Referenced:            0 kB\n"
 "Anonymous:             0 kB\n"
+"KSM:                   0 kB\n"
 "LazyFree:              0 kB\n"
 "AnonHugePages:         0 kB\n"
 "ShmemPmdMapped:        0 kB\n"
@@ -90,7 +91,7 @@ static const char proc_pid_smaps_vsyscall_1[] =
 ;
 
 static const char proc_pid_smaps_vsyscall_2[] =
-"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n"
+"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n"
 "Size:                  4 kB\n"
 "KernelPageSize:        4 kB\n"
 "MMUPageSize:           4 kB\n"
@@ -103,6 +104,7 @@ static const char proc_pid_smaps_vsyscall_2[] =
 "Private_Dirty:         0 kB\n"
 "Referenced:            0 kB\n"
 "Anonymous:             0 kB\n"
+"KSM:                   0 kB\n"
 "LazyFree:              0 kB\n"
 "AnonHugePages:         0 kB\n"
 "ShmemPmdMapped:        0 kB\n"
@@ -244,10 +246,10 @@ static int test_proc_pid_smaps(pid_t pid)
 		if (g_vsyscall == 0) {
 			assert(rv == 0);
 		} else {
-			size_t len = strlen(g_proc_pid_maps_vsyscall);
+			size_t len = strlen(g_proc_pid_smaps_vsyscall);
 			/* TODO "ProtectionKey:" */
 			assert(rv > len);
-			assert(memcmp(buf, g_proc_pid_maps_vsyscall, len) == 0);
+			assert(memcmp(buf, g_proc_pid_smaps_vsyscall, len) == 0);
 		}
 		return EXIT_SUCCESS;
 	}
