Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA27BD93A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346164AbjJILHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbjJILHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:07:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065494
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:07:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso731086466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696849636; x=1697454436; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94GrlV6BpXzh9G3J0ul8d01iN4TaQgOhd/Tfg+JX6og=;
        b=mP6FAKp7VpXGO/fULV1JVkxA+MiPiUfMkfkGCSMWfJU02Po0NOcv8jmtVIo5I/K1UD
         +svSl8CVudsIRn19Gz3lG7KK37cH5w0ESvCCWP2AGcdxE92Qo1s84k1DXscnrHJszPWf
         Ayt27IvJRqtJVcE8NvI5Sa435N89iOhaqSfB3oouyVX6T4gPJ0wR0bqwP0QIrbXbyubt
         hXP62syheD/4xayygaSFhp+aDsN4bYDqikGKAwxhMULEW5qsQNaPL7n5aL9n2HdUBYjX
         nYIGBv5U9TGbuuQsucvuutfi+xihBfpio5aktffnb/WAVUFQRqJDOU1nlIuedH6pPXpS
         7ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696849636; x=1697454436;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94GrlV6BpXzh9G3J0ul8d01iN4TaQgOhd/Tfg+JX6og=;
        b=TIkCgUIxjTvIl8GHuVRAnDUDfE6aerDyx69kAsEcV675TYX+MFVPU6I9BqYwLM1B+J
         JrmMEe01KXnRn9eafoORB5UkCdrTIQmlR/rd1m4pMt6Rz5CtMU+rEJfLiwUvA0hcgfvG
         jUhx/wZbrGxIHUeWkYFMqOIab8G2SINwDibX5c+zVjflSFyKquBE6VECtBIaulg9GN0B
         4m5jfdZthcDccliwB67p90ssMeWZ7dtEUXSP2qOn9vlaKyc5pTjzsbGyL2nX7BRnsEKC
         IyDga6V0nMU0PMDbh5KOEqLU+oJ5/IQhB0tn9a4ib2tPSzVyFNvyx6mEa7A8NMxDsOjK
         zs8w==
X-Gm-Message-State: AOJu0YxsPFRt71/V9mCbP8QWO2oSOa8ZzW8AYzi3nWmvCZHh7Q121DIW
        VAMFv2aFfeTHqdWTTJ6IT0LNcE+j6Q==
X-Google-Smtp-Source: AGHT+IHAu4nCcMbixG78LVCeC4CkKiFDMQ3xEvc+tqxg+jBzuKhd3fvPDY4cethnaS72EsBu2hlLbw==
X-Received: by 2002:a17:906:209:b0:9a9:e5bb:eddc with SMTP id 9-20020a170906020900b009a9e5bbeddcmr14496587ejd.16.1696849636330;
        Mon, 09 Oct 2023 04:07:16 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906364b00b009a1a5a7ebacsm6506570ejb.201.2023.10.09.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:07:15 -0700 (PDT)
Date:   Mon, 9 Oct 2023 14:07:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3] proc: test /proc/${pid}/statm
Message-ID: <0721ca69-7bb4-40aa-8d01-0c5f91e5f363@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>

[more or less rewritten. --adobriyan]

My original comment lied, output can be "0 A A B 0 0 0\n"
(see comment in the code).

I don't quite understand why

	get_mm_counter(mm, MM_FILEPAGES) + get_mm_counter(mm, MM_SHMEMPAGES)

can stay positive but get_mm_counter(mm, MM_ANONPAGES) is always 0 after
everything is unmapped but that's just me.

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-empty-vm.c |   97 +++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -303,6 +303,95 @@ static int test_proc_pid_smaps_rollup(pid_t pid)
 	}
 }
 
+static const char *parse_u64(const char *p, const char *const end, uint64_t *rv)
+{
+	*rv = 0;
+	for (; p != end; p += 1) {
+		if ('0' <= *p && *p <= '9') {
+			assert(!__builtin_mul_overflow(*rv, 10, rv));
+			assert(!__builtin_add_overflow(*rv, *p - '0', rv));
+		} else {
+			break;
+		}
+	}
+	assert(p != end);
+	return p;
+}
+
+/*
+ * There seems to be 2 types of valid output:
+ * "0 A A B 0 0 0\n" for dynamic exeuctables,
+ * "0 0 0 B 0 0 0\n" for static executables.
+ */
+static int test_proc_pid_statm(pid_t pid)
+{
+	char buf[4096];
+	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
+	int fd = open(buf, O_RDONLY);
+	if (fd == -1) {
+		perror("open /proc/${pid}/statm");
+		return EXIT_FAILURE;
+	}
+
+	ssize_t rv = read(fd, buf, sizeof(buf));
+	close(fd);
+
+	assert(rv >= 0);
+	assert(rv <= sizeof(buf));
+	if (0) {
+		write(1, buf, rv);
+	}
+
+	const char *p = buf;
+	const char *const end = p + rv;
+
+	/* size */
+	assert(p != end && *p++ == '0');
+	assert(p != end && *p++ == ' ');
+
+	uint64_t resident;
+	p = parse_u64(p, end, &resident);
+	assert(p != end && *p++ == ' ');
+
+	uint64_t shared;
+	p = parse_u64(p, end, &shared);
+	assert(p != end && *p++ == ' ');
+
+	uint64_t text;
+	p = parse_u64(p, end, &text);
+	assert(p != end && *p++ == ' ');
+
+	assert(p != end && *p++ == '0');
+	assert(p != end && *p++ == ' ');
+
+	/* data */
+	assert(p != end && *p++ == '0');
+	assert(p != end && *p++ == ' ');
+
+	assert(p != end && *p++ == '0');
+	assert(p != end && *p++ == '\n');
+
+	assert(p == end);
+
+	/*
+	 * "text" is "mm->end_code - mm->start_code" at execve(2) time.
+	 * munmap() doesn't change it. It can be anything (just link
+	 * statically). It can't be 0 because executing to this point
+	 * implies at least 1 page of code.
+	 */
+	assert(text > 0);
+
+	/*
+	 * These two are always equal. Always 0 for statically linked
+	 * executables and sometimes 0 for dynamically linked executables.
+	 * There is no way to tell one from another without parsing ELF
+	 * which is too much for this test.
+	 */
+	assert(resident == shared);
+
+	return EXIT_SUCCESS;
+}
+
 int main(void)
 {
 	int rv = EXIT_SUCCESS;
@@ -389,11 +478,9 @@ int main(void)
 		if (rv == EXIT_SUCCESS) {
 			rv = test_proc_pid_smaps_rollup(pid);
 		}
-		/*
-		 * TODO test /proc/${pid}/statm, task_statm()
-		 * ->start_code, ->end_code aren't updated by munmap().
-		 * Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
-		 */
+		if (rv == EXIT_SUCCESS) {
+			rv = test_proc_pid_statm(pid);
+		}
 
 		/* Cut the rope. */
 		int wstatus;
