Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BBF7B6E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbjJCQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjJCQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:13:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6348A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:13:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-69361132a60so133131b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696349620; x=1696954420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDJF4HDvdbvC8HGpA321wCqM7eAE7ZDYuka+f9gbHrE=;
        b=Cgj+uUZlKOGXlcvbQboOBHPRFwX6YFuijFdS3wWNimLgNAKc2MLMOqkTxVyv1oBvAX
         SxPRlxBAk3ytcT6TnfWij3fea0W0fPsZKERDA5ZusJ00ejQ+sqfO8ZbqgDXWxp6UTZxy
         Vvys5uEhkHtSIwZyBynaHof4nzjMyqmKqcxttYCG01az4cQHGsLWt5qLG7KcV1/ayyrp
         HijkeFsxN2lS6g/QRA3yYcLlYjBgKrGb6MRnaIi90TxK7LYNPyWcGMgp8SR2w9LTnqTZ
         +gpCIJaH2buEOLX3CZgxXtPUSMObjupJfjeGHSRrnzgiahNZGjG6z5OOuCTmW9E0h9wX
         N9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696349620; x=1696954420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDJF4HDvdbvC8HGpA321wCqM7eAE7ZDYuka+f9gbHrE=;
        b=Hu44y742nVzmpnsbBDjnTLRFc8ee2/3PqHMRH2JrVH1iShuQ9JTc8V9Ci5eoi3MFbq
         8PzlVk+w4aXs0b+rfJzDREO6yQGxfbwjXNqcVllRbXTbsTwXbaAZyyToJwkoRifh68DY
         A4WNR4BvV5O4E10r/Gbl0sRNaPf4lFNHyinTy3Hvp/lTBNjS7XUH3tzfOWIA7f8Xbttq
         tL+7JXboWRu/EBmSmO2lTXPZ8UjRr/6L4AtLi7ETffUFpqDnER5cSKAfk3LNcn1eVGbB
         VO+s5zTZ+/9YO9VfHcerdh7ZuwD+A5996dLdZMBUInGrrNfP92YKol6E6/BGrwYtmq6C
         FQBA==
X-Gm-Message-State: AOJu0YwVgsOS2rKNVhA7vuBf3N3DEylxtWbEsHZTMRBOsmOV9Qw70sCo
        1lt4NaiaGXeqTDggkN654ECLleJ+wy116w==
X-Google-Smtp-Source: AGHT+IEJgy33K1p1hRRj4EQyl5p2mFyZjvGPJ87E1fmfKGOBuPiMPo9tCAw/afY1/NB3OJ8XP92IHw==
X-Received: by 2002:a05:6a00:1d22:b0:693:38c5:4d6d with SMTP id a34-20020a056a001d2200b0069338c54d6dmr30438pfx.2.1696349620270;
        Tue, 03 Oct 2023 09:13:40 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id j7-20020a62b607000000b0068bbd43a6e2sm1600697pff.10.2023.10.03.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:13:39 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] objtool: Fix memory leak in check.c
Date:   Wed,  4 Oct 2023 00:13:35 +0800
Message-Id: <20231003161335.1403094-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In the 'disas_funcs' function of check.c, the 'cmd' string used to store
a command is not being freed after it's used, leading to a memory leak.
This patch adds the necessary 'free(cmd)' statement to release the
allocated memory.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e308d1ba664e..b010b883c1ee 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4589,6 +4589,7 @@ static int disas_funcs(const char *funcs)
 	/* real snprintf() */
 	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
 	ret = system(cmd);
+	free(cmd);
 	if (ret) {
 		WARN("disassembly failed: %d", ret);
 		return -1;
-- 
2.25.1

