Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5637B71F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbjJCTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJCTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:43:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6332F93
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:43:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdf4752c3cso9618235ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696362210; x=1696967010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbdHdhO4/8XQFhe6TXvhjzuMCQeWe1W0DXY8haIPqBM=;
        b=WxJ3AYXtIMg1vLvKxq21v3gu5ISmxMMRNS2lOFCiqM3k5uIHxya0gM2VoBt1TltyyV
         fAXm6af5nMm+63TU0XPuN3zwObIgjQ26daRciMWMzqiS+jYhMznRLY+AQasrO0FH3zgt
         3nOUIqeaK5sufackU/6NI9BmI3IbOzNNUn5YFN40kiqNMjYU9eZRxWPohqC22yapoELs
         uet2BWPFfc0mxSv2YXtSf2G9xYaGUgNU5py1TNGQYj3aKq0D6Iu40RvBQ46D5nMY8Ffz
         7mzYnHTFge5k6bR7hKrOyKwrfgWrSXTX6RRolUsS/XibWrjvoBd6oGiRdIdC58hqZ6Ao
         R5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362210; x=1696967010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbdHdhO4/8XQFhe6TXvhjzuMCQeWe1W0DXY8haIPqBM=;
        b=w+MUgtWX9qOqX14+iR8yWx4+OkB/AsfV5WJ1dUobtIN0NSWAZSKay6Pm8bbOy/1qt2
         0kX6TvY54/k1eNwnLulvm5zXpVrgikOOUf4CjOjK2i+WebazxxqbLawKJU66KNYOPPzT
         0PxTl0mzxWXGrJBgM1xPmQkAFvz80P3AeAbM3Sg5O5nRvtHxnLoc18eHh1/zcCjtLXBg
         aLwQApJoqFwKwQZs8jtauBOBFHOJMdO50EKTmQGjwZHH3E80TvLLSh8h/0136FlK1MFd
         QvFp7/DKFuj0EXs2Ij6BI+40fGoYWADWDlxwb1Opr9Q+M1tEBH4MWPW9d2hBHK/+xU+c
         7STg==
X-Gm-Message-State: AOJu0YzIPxkb7wo5h8MxBR++O5DJiyasTfvqGoD8zbf6SmTeFRRlCwmA
        dJ1wTdVrhrKQoUEexGu/kUo=
X-Google-Smtp-Source: AGHT+IE8Zzd5tPTms4qpIkKaLgA/vVn5aDnp/RRxtPIznkHxLLVZPVZ1k3dVVvKti/qDIrBu38AJSg==
X-Received: by 2002:a17:902:d4cd:b0:1c4:3294:74ca with SMTP id o13-20020a170902d4cd00b001c4329474camr590332plg.17.1696362209640;
        Tue, 03 Oct 2023 12:43:29 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001bc2831e1a9sm1989965pls.90.2023.10.03.12.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:43:29 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     swarupkotikalapudi@gmail.com
Subject: [PATCH v2] selftests:proc Add /proc/$(pid)/statm output validation
Date:   Wed,  4 Oct 2023 01:13:19 +0530
Message-Id: <20231003194319.602646-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZRsDWFxy3rcILfxg@swarup-virtual-machine>
References: <ZRsDWFxy3rcILfxg@swarup-virtual-machine>
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

Add /proc/${pid}/statm validation

/proc/$(pid)/statm output is expected to be:
 "0 0 0 * 0 0 0\n"
Here * can be any value

Read output of /proc/$(pid)/statm
and check except for 4th position,
all other positions have value zero.

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
Changes in V2:
- 4th field if zero it will assert
- field other than 4th field is checked for zero value
- clean up of function test_proc_pid_statm()

Changes in V1:
- added new function test_proc_pid_statm()

 tools/testing/selftests/proc/proc-empty-vm.c | 57 ++++++++++++++++++--
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b16c13688b88..1b5b48445e0f 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -302,6 +302,56 @@ static int test_proc_pid_smaps_rollup(pid_t pid)
 	}
 }
 
+static int test_proc_pid_statm(pid_t pid)
+{
+	char buf[4096];
+	char *tok;
+	char *string;
+	int non_zero_value_indx = 4;
+	int i = 1;
+
+	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
+
+	/*
+	 *  Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
+	 */
+	int fd = open(buf, O_RDONLY);
+
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			/*
+			 * /proc/${pid}/statm is under CONFIG_PROC_PAGE_MONITOR,
+			 * it doesn't necessarily exist.
+			 */
+			return EXIT_SUCCESS;
+		}
+		perror("open /proc/${pid}/statm");
+		return EXIT_FAILURE;
+	} else {
+		ssize_t rv = read(fd, buf, sizeof(buf));
+
+		close(fd);
+		assert(rv);
+		string = buf;
+
+		while ((tok = strsep(&string, " ")) != NULL) {
+			if (i == non_zero_value_indx) {
+				if (!strncmp(tok, "0", 1))
+					goto err_statm;
+			} else {
+				if (strncmp(tok, "0", 1))
+					goto err_statm;
+			}
+			i++;
+		}
+	}
+
+	return EXIT_SUCCESS;
+
+err_statm:
+	assert(0);
+}
+
 int main(void)
 {
 	int rv = EXIT_SUCCESS;
@@ -388,11 +438,8 @@ int main(void)
 		if (rv == EXIT_SUCCESS) {
 			rv = test_proc_pid_smaps_rollup(pid);
 		}
-		/*
-		 * TODO test /proc/${pid}/statm, task_statm()
-		 * ->start_code, ->end_code aren't updated by munmap().
-		 * Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
-		 */
+		if (rv == EXIT_SUCCESS)
+			rv = test_proc_pid_statm(pid);
 
 		/* Cut the rope. */
 		int wstatus;
-- 
2.34.1

