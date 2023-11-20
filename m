Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8AD7F0C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjKTHKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:09:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0CA4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso29128205ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700464195; x=1701068995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUE9ZvwZFQu7umd/mVKa2M3eheT6QrVVeWcfJsSgwak=;
        b=Nb4FDyNwjN+mOaQPz6vPBmzYYcVrzNF5lLIOTo6NJLZKKaYQ5q9G4XxtppDPLL07Gu
         55YA5qrTr1EpcPIQ5TK8SckyR9o0lYdLfVRPrUhc4zHW5a167XSptvC2YGllJZinWSuU
         nKoOt3fqhCXgiwow2e7Ylq15hCDyYoTaC2FDpRBEm0vA9u9CxCBiGJ9/AEtTA72TyUjN
         ZikhEjKhKVhxCjkjkgGAg2tA1RmzQaJEDrKfJnaTHB7YYPps2CuOBQergscCtcw+JkNE
         cwtiQ9ExMewLMDFrNMZqlubgo5z/KDQq0H+fFdj1CdY/aMYNW/X0s1NKw+zN01tvnV/2
         LAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464195; x=1701068995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUE9ZvwZFQu7umd/mVKa2M3eheT6QrVVeWcfJsSgwak=;
        b=YjcNVgSV04kAqK6VRKmWpCBcrFfLcKmghBaEmpwhHeu1HAPqpFl6wyqvVL+a0e7lTp
         zHc61karxmVchcZiZa72rTSI8bh40vAITP21c6Sv6IJSLowsh1IE2LegHWYwwdlYF1oq
         oSBedeojA6iThL94DqmEaOh8S7gvRNyodE6U0QOEtDpONzNXAfBeUlAwNQCz7VpeK113
         1orLNL2p4AaoWK15htp+tjFWvY87j31MWVX2nFND87mqQSEWKhT5uvv7qbZTRpG/WVn4
         7Cz7aKijeFMegv2oYwWh0XzqB3IPMfVtcZgFcR+7J//QJw4T9U0BkwV6IJyiqCoUdZFs
         gHdQ==
X-Gm-Message-State: AOJu0Yx5VXZ+KSifVWp0BtAb8bZ0NE/MF6EDj1vBQ4hBRiYeDVVmTCvT
        +DXohLnFOZgSvJ1tWuRBgR+Q1Q==
X-Google-Smtp-Source: AGHT+IHoQx5VP90DjW6z7hmikj/ILZ20irNIme8mby57GLohgMrwLjCqPd9SOayxbZcQ2cOPovcmJg==
X-Received: by 2002:a17:902:d904:b0:1ce:5c04:fb60 with SMTP id c4-20020a170902d90400b001ce5c04fb60mr4374550plz.8.1700464194899;
        Sun, 19 Nov 2023 23:09:54 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001ce67fab3a2sm3698143plg.261.2023.11.19.23.09.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 23:09:54 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, dan.carpenter@linaro.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 1/5] maple_tree: Move the check forward to avoid static check warning
Date:   Mon, 20 Nov 2023 15:09:33 +0800
Message-Id: <20231120070937.35481-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
References: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the check for gap before its reference to avoid Smatch static check
warnings. This is not a bug, it's just a validation program. Even with this
change, Smatch may still generate warnings because MT_BUG_ON() doesn't
necessarily stop the program. It may require fixing Smatch itself to avoid
these warnings.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: http://lists.infradead.org/pipermail/maple-tree/2023-November/003046.html
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index aaba453b0d30..067b186202d7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7249,6 +7249,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 
 counted:
 	if (mt == maple_arange_64) {
+		MT_BUG_ON(mas->tree, !gaps);
 		offset = ma_meta_gap(node, mt);
 		if (offset > i) {
 			pr_err("gap offset %p[%u] is invalid\n", node, offset);
@@ -7261,7 +7262,6 @@ static void mas_validate_gaps(struct ma_state *mas)
 			MT_BUG_ON(mas->tree, 1);
 		}
 
-		MT_BUG_ON(mas->tree, !gaps);
 		for (i++ ; i < mt_slot_count(mte); i++) {
 			if (gaps[i] != 0) {
 				pr_err("gap %p[%u] beyond node limit != 0\n",
-- 
2.20.1

