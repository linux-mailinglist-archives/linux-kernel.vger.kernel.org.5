Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4B7EFF44
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjKRLeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKRLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:34:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA6E1A1;
        Sat, 18 Nov 2023 03:34:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507be298d2aso3706164e87.1;
        Sat, 18 Nov 2023 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700307249; x=1700912049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/sqZtYPf1d7uCFhAGajJY8T+mb9aQWAUkemimPSnCc=;
        b=i/Yf9yN4XeWCzaxHY0kOWarvL+Ym2E4SK+I/2i3png7kJd8m22dQNn16L/yPuZVhUt
         ewCeGnfcfjCD9HwUJmuWtQ3ba20tRNBGqwo66MpcfkBG82HGfRcbmbgbyIHF4neTBTVD
         4iXBHFkhkqNGU+QldTFnGyvZBU3q1XLMPEZGuia4/fNDX1WvJu6Wy8cCS22WcLsZyfFa
         X2z/6Y7A5z78w/atybRW6Fd2+8NfbeuO3m9C6XA/lDx9JdqlJVmO5jVoHgxtUv1qs8Py
         l4vUj15Uwjonwj4IRS8c9Apqw2kymwtHLqhO7Cprzj/6PfZLLDj8YK+p9xhJ0fqo6aqn
         TebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700307249; x=1700912049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/sqZtYPf1d7uCFhAGajJY8T+mb9aQWAUkemimPSnCc=;
        b=lOiP1PElQZtTp4N+6ntOVIoACv208i+BgXziQM9PvAaW8rLbb4+rl+ohG4Zt7gdzvA
         QLxYqDsImcQ03b1tn4W0s4DPr8jR7E6vNM85rdq3qGKVidCGeCtkuqD24VUuu0u5n3Wy
         eqOI7YKv8faN9U/vH4XjmwLmqz/TN+TeJpNdU8fo0L7nw4WdAqBbbN7p28JwJfELYbp7
         LhOc4YcEv7dltSBkj/nVRu+rXIZszqGDNyV1vhGSSsiG38tbRSPeXLX+RWHyBTk/Awo2
         wZtlpiRTyVdAKhIF70Lsptw73NezjXj9iNXmutswwWiEroGuG9mGv0rby7Luh0Yo2dl4
         u/vA==
X-Gm-Message-State: AOJu0YxgEADMeJw9S9IaB4gB7HbUTiAeKjm4/9JYptQtD/3CKI3eUNDa
        LPh6jwxp3v40LOh3LHlO9oA=
X-Google-Smtp-Source: AGHT+IEm5TDII5VXXDPzzv1iAekAn9g6WwCAuut52LH2oQh2SfXrPp8HC4foHDanR7i7GoBnRR3iyg==
X-Received: by 2002:a19:5514:0:b0:509:4424:2e0e with SMTP id n20-20020a195514000000b0050944242e0emr1586680lfe.0.1700307249434;
        Sat, 18 Nov 2023 03:34:09 -0800 (PST)
Received: from localhost.localdomain (87-206-74-243.dynamic.chello.pl. [87.206.74.243])
        by smtp.gmail.com with ESMTPSA id w27-20020a05651204db00b0050799f689ddsm557170lfq.200.2023.11.18.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 03:34:09 -0800 (PST)
From:   Kamil Duljas <kamil.duljas@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamil Duljas <kamil.duljas@gmail.com>
Subject: [PATCH] genetlink: Prevent memory leak when krealloc fail
Date:   Sat, 18 Nov 2023 12:33:57 +0100
Message-ID: <20231118113357.1999-1-kamil.duljas@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

genl_allocate_reserve_groups() allocs new memory in while loop
but if krealloc fail, the memory allocated by kzalloc is not freed.
It seems allocated memory is unnecessary when the function
returns -ENOMEM

Signed-off-by: Kamil Duljas <kamil.duljas@gmail.com>
---
 net/netlink/genetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 92ef5ed2e7b0..82273d6eaea3 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -437,8 +437,10 @@ static int genl_allocate_reserve_groups(int n_groups, int *first_id)
 			} else {
 				new_groups = krealloc(mc_groups, nlen,
 						      GFP_KERNEL);
-				if (!new_groups)
+				if (!new_groups) {
+					kfree(mc_groups);
 					return -ENOMEM;
+				}
 				mc_groups = new_groups;
 				for (i = 0; i < BITS_TO_LONGS(n_groups); i++)
 					mc_groups[mc_groups_longs + i] = 0;
-- 
2.42.0.windows.2

