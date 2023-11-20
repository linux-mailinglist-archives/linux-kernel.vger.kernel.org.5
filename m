Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFF27F0C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKTHKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjKTHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:10:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C0BB7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cb66f23eddso704931b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700464198; x=1701068998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVM7PlgIWBr9i9hcZud6b5TfuAYyAUUwXwcxlfzYtaU=;
        b=DHzDbOAmjE9LKoiXne1B9nDYCMqErMoPy670HrwoV4cb0ittn3rsldSt3EdnIfEdJf
         ekNumQismDpl9IyGwgzzcCF/hy/lAz9BLTG5/BZUtt5tGYywsVMglyuEfabVUjc5O/qQ
         tONK0Qf3Mx48nkhpN3EA0pAifEVMUFPs8BvR64gg9zbhr8F9Udz3b/UFsT+Cf4u52tee
         ihUrQv/cdWrseV9c/ehT3FepUMj2HtHg9k/UejSIJRiqWhenn6Hj8VFs6PpswkJjMY8f
         6UpgcOKIeevgi0IeUBjBWQ8VzJhum+vYoWEVgDRIOtsiDkkDfcJ8bfFAAo5YmTTVj5ds
         51BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464198; x=1701068998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVM7PlgIWBr9i9hcZud6b5TfuAYyAUUwXwcxlfzYtaU=;
        b=GaUtgG4u6ntg4Zme3hzNzr5fSl+oGwjbV/qdxGEeLFsiILkeJXn7l8J+oHHGpiPy4n
         iTKepjrRVOf8NkRIpc+cPs+SP8TOE2HJgQWfjpPS/pFsALOd1CRRNg/v5+O5LTNJc6WG
         Mf3fis9Grhads11rHqY9XzBhriLxE1Ng7becvN190Nk4EyfOr5lRafWmig2d1aoodyYa
         +4EDAWoyHkq2cGYnw/mXm9ML8ooAS+g3q74aYZZfpiBCdYcDibYYq085ojeU7jYIGZel
         dbQCjbK5uCSCHdAfNZQ7NLTD9rEQNfaTzHmYeEdaQ2uWeVkLXplUxL4Cx1T7YkFCfYVM
         UzJw==
X-Gm-Message-State: AOJu0YxiAqWoEHlIbaD0pcOFzUPx90u8xMptie3nZpX8Cpo80YubEila
        m7HHfneGHMWqybyQcm2Nt/9UtQ==
X-Google-Smtp-Source: AGHT+IE2q1NCMNd+w8RbWd7Y6YzdqD5HzLY3jU16q2z24eHxDGMl4yI/3MCaLdN5iu6cGUkG7j/jOA==
X-Received: by 2002:a05:6a20:430a:b0:187:c2be:77f4 with SMTP id h10-20020a056a20430a00b00187c2be77f4mr4769336pzk.44.1700464197848;
        Sun, 19 Nov 2023 23:09:57 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001ce67fab3a2sm3698143plg.261.2023.11.19.23.09.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 23:09:57 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, dan.carpenter@linaro.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 2/5] maple_tree: Avoid ascending when mas->min is also the parent's minimum
Date:   Mon, 20 Nov 2023 15:09:34 +0800
Message-Id: <20231120070937.35481-3-zhangpeng.00@bytedance.com>
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

When the child node is the first child of its parent node, mas->min does
not need to be updated. This can reduce the number of ascending times
in some cases.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 067b186202d7..cc928b5f753d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1088,14 +1088,16 @@ static int mas_ascend(struct ma_state *mas)
 		return 0;
 	}
 
-	if (!mas->min)
+	min = 0;
+	max = ULONG_MAX;
+	if (!mas->offset) {
+		min = mas->min;
 		set_min = true;
+	}
 
 	if (mas->max == ULONG_MAX)
 		set_max = true;
 
-	min = 0;
-	max = ULONG_MAX;
 	do {
 		p_enode = a_enode;
 		a_type = mas_parent_type(mas, p_enode);
-- 
2.20.1

