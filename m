Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A015778C454
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjH2Mf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbjH2Mfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:35:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06109C9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:35:41 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so66201591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693312539; x=1693917339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp+WNcc+NUltg2NS15dJnRBG/GyHjPSWYbuJd4p6LYo=;
        b=a9SwPyreQZPj1VWKSW57uFiuFsYEeNGXdXg+yyDlhi6cc+coykTCtAg3IL37nnmEOl
         4k/Edq2fSlbP8nx5TN8cNXjGlAaslV4ZUCxrys6RDz3sMEIWsJjSZFnhG2TA76JC0yA2
         iIJ4lGh7vKH2DLpKNSJeAV82mJYvtA4VAk7O+n3ZGVQ8EjnH0+JkHatHlyzBk5QUJz4x
         bSdbnPEVtong5kYimjxMf/9Zb8rMclZRo/v6z8CVeuaJmmgHW3dWESZrkuKwYpyEZRfl
         v18bJyQ5CM6HUla+aAhtpa/dK3A4H+xw2n9XJxI9EA/O4Q4PrDE9vIlume0tv6KhUo1I
         eLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312539; x=1693917339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bp+WNcc+NUltg2NS15dJnRBG/GyHjPSWYbuJd4p6LYo=;
        b=agF1HOxMvmGclV8TgNKSyLxa+M38NDyGMenmUWRoIL5D29CSQknMcvYmsH6dj6SI7k
         nuVLkxfOLnHfBcTqPx9EgPHdhJVp8acUu2E6Hcb2NdPkOdqni6e1bTZBoRJvV/v9UUJc
         wmxaeS98NjgToFcU4tq/R7aAy7jby0rNEJAmRiF/11WKrJhHBwVruTagU9CFiAZRaKQ0
         vwK4tMZhInoPTSmUhP9Shv+iiFDSservKhG65HU+KBqsksKpMcygBrjnogReSEgHZ+S7
         FL8aHmGB5qOO9/rIRaORCacwHkzZQ7B0e1irdw/xSmu5Djq34GgJSRXmfjiGrMoD99rC
         QTDg==
X-Gm-Message-State: AOJu0YwSbL0qWCozxBeYgdnmno9+bD3pS6cuHRVrzCNKitY9sh8X9Qb5
        LfxDr+Y8NqH3mRIGsxX90LZyltlMOJb3coZ3
X-Google-Smtp-Source: AGHT+IEMTnEPqLIZvAyyiuDzdCnaIMwXYK12q2e95y3mbT0a89j1g8y2VRm4Rlx+/aCK4LBmw55VCw==
X-Received: by 2002:a2e:2a45:0:b0:2bd:1cd0:6041 with SMTP id q66-20020a2e2a45000000b002bd1cd06041mr953487ljq.0.1693312538904;
        Tue, 29 Aug 2023 05:35:38 -0700 (PDT)
Received: from dev7.kernelcare.com ([2a01:4f8:201:23::2])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906490a00b009a1fef32ce6sm5981770ejq.177.2023.08.29.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:35:38 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH] checkpatch: stop complaining about tags suggested/tested by syzkaller
Date:   Tue, 29 Aug 2023 14:34:47 +0200
Message-Id: <20230829123446.3455193-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you submit a testing request to syzkaller it may reply with:

 syzbot has tested the proposed patch and the reproducer did not \
 trigger any issue:

 Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com

Checkpatch is ok with Reported-by tags, but complains about
Reported-and-tested-by tags:

 WARNING: Possible unwrapped commit description (prefer a maximum 75 \
 chars per line)
 #48:
 Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com

Adding the new tag to signature_tags removes this warning.

Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9841148cde2..f85dcfb098e0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -615,6 +615,7 @@ our $signature_tags = qr{(?xi:
 	Tested-by:|
 	Reviewed-by:|
 	Reported-by:|
+	Reported-and-tested-by:|
 	Suggested-by:|
 	To:|
 	Cc:
@@ -709,7 +710,7 @@ sub find_standard_signature {
 	my ($sign_off) = @_;
 	my @standard_signature_tags = (
 		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
-		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
+		'Reviewed-by:', 'Reported-by:', 'Reported-and-tested-by:', 'Suggested-by:'
 	);
 	foreach my $signature (@standard_signature_tags) {
 		return $signature if (get_edit_distance($sign_off, $signature) <= 2);
-- 
2.39.3

