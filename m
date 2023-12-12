Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97580F4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376804AbjLLRe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjLLRe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:34:26 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9081BE3;
        Tue, 12 Dec 2023 09:34:32 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4851481a12.3;
        Tue, 12 Dec 2023 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402471; x=1703007271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7WPnTXwcd9ZzcvpmJ6cfpBxVRJlaEYkuDj4m5TKSZY=;
        b=A8NqHMCkM+oLrxx1u2ACtPDJ1Mlo3p6cF24tlvsX83FHvgbRnSuNaLW0L9TyAlW0ii
         JhzbVrSrxzqs2Pg+HPlm6okgifwT6421Kx0V74FKZWFUINqxO1LVk69R5aXMZyZowZC1
         LvF26omnNoZb/m2hB+BSuuNRdhNxUG7ewgwk7MUEYBGrRmW9AdeYyuo/LLnzVzAGwydK
         emVCIOPIcxP89vqNDMlcD9P/tLXxF6sWSAY18oY1V7sp1zuNKT2JRjnr+qeaX3FLOoQH
         Bpi4GF3u/FNM3QTpvSyFrioqShY3KqzyOdMJyPpc+P605/fvxOa65oSxSEVRqRgR3QBA
         2iiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402471; x=1703007271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7WPnTXwcd9ZzcvpmJ6cfpBxVRJlaEYkuDj4m5TKSZY=;
        b=mxYsWHvBLwP5HLePVIaoMm6xCJ/T2sWVXMeff8w6ECJ9reFnT/MFtB9XjA6JJV+8Yx
         ig4fdKxuuDy6BFNODt31K/Uc7CvR0rlepv32lI8V7i9o/W4hlqi+aGzGyEbxZNNZRG9N
         JMIOyxOb0ec9JoafTHxLggZ7FHaVA048LIuB3Yaf/o/K5j6Qvzlb3QwrgLWCxM0coCWc
         uKUUEwiJq6wOGRJcYj7Ii1heUUfEMgMTcSlyfHgyrXbFc/dCeFEZ/ZPd8yncNUzDY+R3
         b0wO0nNep1EYAz8stOEmW7sC3fbnLnOd3z5taOfOoZmxD5y09AuwqRBqdCFax/6F1tzn
         7vEA==
X-Gm-Message-State: AOJu0YyoURuxhHE259YivMCAEW4qv+4Hb89W6XOXOEqenCGvsPNuJNti
        NT8NsBPMT1iWMhW9+2tWjXlxGD35/w3gUFre
X-Google-Smtp-Source: AGHT+IHUtxJgDQUDQl+GLeIkzxxRnkvxeDT917Z0smPcbhO/8giuU84BrdU+h8qclux8NObObKkCrg==
X-Received: by 2002:a17:90b:11c8:b0:286:6cc0:cabb with SMTP id gv8-20020a17090b11c800b002866cc0cabbmr5231012pjb.50.1702402471068;
        Tue, 12 Dec 2023 09:34:31 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id nc4-20020a17090b37c400b00285545ac9d2sm9213862pjb.47.2023.12.12.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:34:30 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 2/4] rcutorture: add nolibc init support for mips, ppc and rv64
Date:   Tue, 12 Dec 2023 23:04:12 +0530
Message-Id: <20231212173414.11602-2-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212173334.GA11572@neeraj.linux>
References: <20231212173334.GA11572@neeraj.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Use nolibc for all support architectures.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 212c52ca90b5..f3f867129560 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -67,7 +67,10 @@ ___EOF___
 # build using nolibc on supported archs (smaller executable) and fall
 # back to regular glibc on other ones.
 if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
-	   "||__ARM_EABI__||__aarch64__||__s390x__||__loongarch__\nyes\n#endif" \
+	   "||__ARM_EABI__||__aarch64__||(__mips__ && _ABIO32)" \
+	   "||__powerpc__||(__riscv && __riscv_xlen == 64)" \
+	   "||__s390x__||__loongarch__" \
+	   "\nyes\n#endif" \
    | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
    | grep -q '^yes'; then
 	# architecture supported by nolibc
-- 
2.40.1

