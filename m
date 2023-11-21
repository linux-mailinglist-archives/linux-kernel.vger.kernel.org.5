Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CBD7F3991
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjKUW5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:56:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D52719E;
        Tue, 21 Nov 2023 14:56:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc938f9612so40361575ad.1;
        Tue, 21 Nov 2023 14:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607414; x=1701212214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo5dqey6I8QbyZ6Fam9wAbARY07XFw/XeE4bQ28EgY0=;
        b=JEu6w1afdz8Hu27VUzP9Khj5RCJ7GpOn5dgugyME5UtqgJd2CWujQuZ+EBBOuckNKF
         QvgxGntVtrFXpj6dJYcGudmkYF7SJtSqrGw14OZDUaA+9Etc5ULDYPgb8IEOcM51TbZy
         XPJeL6dwoJ544kri/7bWwEvT3aGTz4rgGh4/BRKH+3cHkReS/uLoiGWtY8ko6PRrQDTg
         gqqKDQd8dvJF+vSKQ9aL31kQ0VcZAVnYOE7Od0bbi7u7eZ+u8LaM5QYecIWcToNcfDeX
         /MmOj9MYiLbkT9jUGoEfA/DTAqhL3LYuL4GvPZ0c6dFLsqz2nA/SJyb51h4+p/um4jSa
         23zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607414; x=1701212214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wo5dqey6I8QbyZ6Fam9wAbARY07XFw/XeE4bQ28EgY0=;
        b=SrDFeAc14cxHFbXaGUWCGLXAMpztgZuzzyJdt9jQtxGHdE1d8Lizobg5GoEmomvHO2
         gPxXsR5jYNI/ciVB/ojyem6x+WKeSIdZSKNrHqaHD9JJkFsuCTkgUR+e9sdGU2j1JkeD
         HZXSGgkrGVu1RLphm+CPBhLHWAkQnxLKLtKAB0uf48c9v0ViCm4UFKHetqIDnRENLMqL
         6y9qJVkQ3ipHjxkglK0Lu6Oc+DCeWeYETZCo8aKi9NDK6KHvkz99Wj+bimbmt9mOzuIc
         7OuBDCQt1xiJWZHaH0ZIfgjwyWCyugRBvrQDSHVaNda3B7dsNTeBeI7TsQmIVSa3qt6Y
         zzAQ==
X-Gm-Message-State: AOJu0Yx5n0ujhgIBcOtY/lKFIZbQ4n9GyIyi0rvvLV19gZ9GKzj6i6wG
        +oWEE2WdOD4e+MOOMlTCZstkm7X/now=
X-Google-Smtp-Source: AGHT+IGIxq+l3yx4uYvZ5XmfPTWhnQX0FwJnRjQlkZ5Na4RwXZf6doms4MSbaTaFoR61OXOoFguLJQ==
X-Received: by 2002:a17:903:11ce:b0:1cf:66a3:16c with SMTP id q14-20020a17090311ce00b001cf66a3016cmr649997plh.21.1700607413955;
        Tue, 21 Nov 2023 14:56:53 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:56:53 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Subject: [PATCH 02/14] tools headers UAPI: Update tools's copy of fscrypt.h header
Date:   Tue, 21 Nov 2023 14:56:37 -0800
Message-ID: <20231121225650.390246-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121225650.390246-1-namhyung@kernel.org>
References: <20231121225650.390246-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fscrypt@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/fscrypt.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index fd1fb0d5389d..7a8f4c290187 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -71,7 +71,8 @@ struct fscrypt_policy_v2 {
 	__u8 contents_encryption_mode;
 	__u8 filenames_encryption_mode;
 	__u8 flags;
-	__u8 __reserved[4];
+	__u8 log2_data_unit_size;
+	__u8 __reserved[3];
 	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
 };
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

