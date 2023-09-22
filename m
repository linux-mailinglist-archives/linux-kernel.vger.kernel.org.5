Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA0B7AB88D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjIVRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjIVRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3281980
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690bd59322dso2022674b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405146; x=1696009946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0V3jWlF6ThW9BuslQEoTcg1mHcaUXfGXFyJTs8W3R6E=;
        b=WNsNx3lEa3pYifcOXRTBiyOirDBQYr/iVR8Oz8syKOitmjmQguKVvBDEf8giSm1okU
         CvYIJQnq6juXYJKyCgUdy4fkPjQOzJMUwzQnHEuelSaAw0khzW0Z/A0wqgVzGNC+FGZN
         UzfOcX+C8XRPS77EiW7GLkamq/G3i3EKwnmD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405146; x=1696009946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V3jWlF6ThW9BuslQEoTcg1mHcaUXfGXFyJTs8W3R6E=;
        b=mQ2JZJ3yBG8VDwRk1lXPB0/bQfy0XpJSb9S9joekHFS9nD4y1Ra6M/42+Ul5ekh2Ie
         FkOBhJFSLxfu8TRudUu23dlt9C9Ut2jwNpi/Zo0jiTTSuNW/prygCNE553BD3iMKYI2t
         ogbXxhS+ZAPvQm0m6v/retBY4hk4zT/eWd/C74MEIatccVpzRIp9fMql10pi5uePGpQV
         zvx5TgVGNdSyvOhv/QOsn915r+e2fEnAazq04Fj8jChyvMSbJN+kkV9YQhWxl0j3N/6A
         JkeDArfQUmIbIRVE+B1oYDHMPLbnhsTmhJIPGL0etG2UYltYaoc20KTgfLp/SxNx1rpY
         /yQg==
X-Gm-Message-State: AOJu0YzTUFS3KG4xehke/GWib4tmG5eikXIlMSoRMMt57PqywM0JORSC
        fBCRYktouZ3ykls/VHuH9jjVdA==
X-Google-Smtp-Source: AGHT+IHx4GnSNddp0w77bsyIRrhbxTM/759paXQ8qQVs8QwwnJM4CYqUGvwQocxlGPM8jBTrYu6dZA==
X-Received: by 2002:a05:6a20:918a:b0:149:9b2f:a79d with SMTP id v10-20020a056a20918a00b001499b2fa79dmr290578pzd.6.1695405146334;
        Fri, 22 Sep 2023 10:52:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090ade8600b002680dfd368dsm3539391pjv.51.2023.09.22.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Date:   Fri, 22 Sep 2023 10:52:24 -0700
Message-Id: <20230922175224.work.712-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=keescook@chromium.org;
 h=from:subject:message-id; bh=L7QtPm9sV53utHLzzgBlBEkBDQ4wLhHXIn/rOvcMRB8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRYVSnSoLrnQY5IDtf2GC3u6QkTIyJo8C8QH
 UxbqYg6Z1eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UWAAKCRCJcvTf3G3A
 JiO2D/4/umN2M56qMMDxw25gfk0XXrNasJyvVidbf0iVWd2FgMZqMzVjLLRZKgALKtPtlbDlkh2
 uMauyeoWwoJreiokLRDV03uy+dbxUuXicnyG1bqS0hQX79TIbLta7QucwkDPvl6ApHxx5G7/lM5
 n1+Vo5Onde7/uK/2hXqgKAZObP3bWuBXqt/r7JbPJp709MTsA0KotCN0R3ZCUfDz2t8xfPIxvpR
 S/BBPo6ZplYLWO9EVXoJzCvwZxEGL0JmSI8IMvIYrw6hZRXg1j/dR/pmBplYZnXwLByQXsphPpR
 S1nRV9zZoQGb6SUX4mf/M71DVfcZKchFA9BihrGb4YXnLb47CU6/+m0AXiLZp5Qx5eVC0cZTHgM
 Qps2mjfP+ph6xuFEcF/gF8bWWrNbKVvtftK30Li+TojYHIK2xvrdmuBbOCY6g6EVijg0KCGHx8K
 i9yJ+ibNvqF2ArwEQHi13ri0WBKLiujrfoInUBfMHwjtOxZqjnVpwz1I4W5F22E6+6rWL1CaSZA
 QOK0C9uuoYEZJkZ74kv04YXgsLbr85durHrVptzD6/83FJLlgZAwX38fwmJ54utqv5Vmvv7EPlN
 eFnyapYuZ/+5urqf5Q8HplGM5D3AFfSZ6y+Y8OToC74qQf4wevVdjZsyKPHA2o6OuQXX0GnGdR8
 Eahlr6L R5b0zPWw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct crash_mem.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/crash_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 3426f6eef60b..5126a4fecb44 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -131,7 +131,7 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
 struct crash_mem {
 	unsigned int max_nr_ranges;
 	unsigned int nr_ranges;
-	struct range ranges[];
+	struct range ranges[] __counted_by(max_nr_ranges);
 };
 
 extern int crash_exclude_mem_range(struct crash_mem *mem,
-- 
2.34.1

