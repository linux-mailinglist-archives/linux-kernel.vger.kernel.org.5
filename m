Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54097F895D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjKYInQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjKYInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:43:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC518B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:16 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfa36bfe0cso9286925ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901796; x=1701506596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wItB+PKNO3hEPBQi2nWGljT56dVv5dpK/TMccffm1xE=;
        b=A7+eJJOHV4FYPhX3BvVFbgFr8IQz2aEf+nyW6RrsjFANP7WaeRG5j+/qc7OaqNZDVq
         VrDqPpjSiRL2yMnhJUh0S8SLlM0ARw5vihf4IGq9xmvTvXDWdea4R5xt4qT9XrXG/ULI
         FIqLzD4sObronjXYSMMdB0xzQVK4zKAsKJbpsxVy8zmYuuM5bCYMwqb4r1g+rismbrHW
         IlKcqrtS7kVuiQiWNTGHStVoJRrmNwxoJVcZn2NaxMy/LshngjGzqViabGer0aTxYYLM
         2JTjvtOuPA1O3BgoRkplAQvf6jQZ/06T/6PefkxFhFNZ9HJzZWHy6HR92LwnaBzcOFSi
         OZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901796; x=1701506596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wItB+PKNO3hEPBQi2nWGljT56dVv5dpK/TMccffm1xE=;
        b=tXOc3oKH6XTg+WGogm+TyjkTAk0BS7Z3uLFGF3A0QDU8QEy57sKJzdvZ0KSNFmvFrf
         YCGjbzMlL46g+yFPgZJ5VlEMYZJIgu4fiexgs3TSpVUV35M1PCivkEwccOuvQs/FgAbF
         CQII/8ZRofQOQocmmivpN5tk8XwpO6N0dzM6t/HTsFx49YOMJ0kOlfMMmo79mxeog9As
         VQ8EhgiUeR8XR9I5E/2QGKG7hp81v2OUfBsRUQVlx0o2W6WBWGrKZY8TQt/gfaKBe32T
         xQVg2Fn1lADVsN10sSIWjyMUOougOA3ryfl/uvYqZHectRcV65t4RedLdk9x9u3apeAM
         0+iA==
X-Gm-Message-State: AOJu0YzjFKyE57htzQAaVZFpZ3fJcZhWwW9TTf9T78Hkqpqi2jqsAXH4
        xplN+MXKQ9jIlF+m1EWItJCo1A==
X-Google-Smtp-Source: AGHT+IFxiQz3BsHEBO78xSibjA97oPp4WKGwp+0jnIwsj/tgRFBbBaOp+jEnT/85fbLaPzY/Qm92DQ==
X-Received: by 2002:a17:902:e88f:b0:1cf:6832:46c with SMTP id w15-20020a170902e88f00b001cf6832046cmr6577902plg.6.1700901796260;
        Sat, 25 Nov 2023 00:43:16 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id t8-20020a170902bc4800b001cc131c65besm4432871plz.168.2023.11.25.00.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:15 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Override PKG_CONFIG for static builds
Date:   Sat, 25 Nov 2023 17:42:51 +0900
Message-ID: <20231125084253.85025-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231125084253.85025-1-akihiko.odaki@daynix.com>
References: <20231125084253.85025-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A library may need to depend on additional archive files for static
builds so pkg-config should be instructed to list them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index cb9b95702ac6..9af79c7a9b58 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -77,7 +77,7 @@ In case of linker errors when running selftests, try using static linking:
 
 .. code-block:: console
 
-  $ LDLIBS=-static vmtest.sh
+  $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
 
 .. note:: Some distros may not support static linking.
 
-- 
2.43.0

