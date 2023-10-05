Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9197BA58F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbjJEQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbjJEQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ADF7AA2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:21:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso559863b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696490505; x=1697095305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bhehRkAcisDo+pGOQLMRxqAGq1y9OCFtpvbtY4rto2E=;
        b=J0JYLqSpzkCZ6BdEnoa/liu+LPdyncdMwXtORUAHCTgtF9y1ukvFH2a/3hIsR5kk99
         CulV63SjxX33xXR4k7f7jafPelz0m+6fgzaE689tUCBGn8LmH43LTyurDvZz9wD/zZwL
         e7BJeDBc9A7Kunv3JWnHKBDb9vzPrsqUkKp0yVCe3cv+z786ahRbxZFgw+bhcZMDK004
         xxwMlNbkDENZtrNfadB3TS+i58CmHjGx3sXHPwC8X8CNGFY7E75LFf+0J26uampkCEDv
         l2g9YZ3e/uZPLHD6dx7IueyZPg+AlDy+sNbCqPmuVb3b3UoXU4Ex+FVK0SyDwvmVvycJ
         7FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490505; x=1697095305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhehRkAcisDo+pGOQLMRxqAGq1y9OCFtpvbtY4rto2E=;
        b=tc4S2b1cqo2yuHO/dP9442xuZXWnVnBVZVcQzluD29IV1Qxsc8x1QItvIGkHTeuVsI
         +RSRnSxOFkCbRCqGXZZk4P1Ub7XTo6MVoyD9xY8iq58aLRullTemS/EtKZVSSBINf+7m
         lRY59N9rRe0ks+3bycC8esDQDRcKyQe9uxT0yNWJ4n+ysj0jLIyws6dw70l1WYydPR2U
         NmPfwt8IE2oKNHdUWvBeHHnX2VZuf3ueALGUChNLlXK/AcQ5vnFlIdJusSWfoaI60hPE
         yLZoBdVJ1k/QBd4rsgrFGJ2hUf5HF+RnrEZsvG5d66ZiHtzNFrt5QNMr01HbF5cQ1DhM
         HJog==
X-Gm-Message-State: AOJu0YwZeIotaHQCGho0nHvcbr1e+BURcFHTIHVCjhVrWC644r7VEMng
        tKH8nIAo7mwxUCw9Xd8PCPHzVw==
X-Google-Smtp-Source: AGHT+IFhMnVxhJdAb97D0VwgSzeh+kZhImxe5gU+SeW/JS015eMWW9pRON/b9es2e93+oeGFnvtWUQ==
X-Received: by 2002:a05:6a00:1d8e:b0:690:41a1:9b64 with SMTP id z14-20020a056a001d8e00b0069041a19b64mr3737258pfw.1.1696490504720;
        Thu, 05 Oct 2023 00:21:44 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id j10-20020aa783ca000000b0068ff267f092sm663033pfn.216.2023.10.05.00.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 00:21:44 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] bpf: Fix the comment for bpf_restore_data_end()
Date:   Thu,  5 Oct 2023 16:21:36 +0900
Message-ID: <20231005072137.29870-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment used to say:
> Restore data saved by bpf_compute_data_pointers().

But bpf_compute_data_pointers() does not save the data;
bpf_compute_and_save_data_end() does.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 761af6b3cf2b..bf7ad887943c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -694,7 +694,7 @@ static inline void bpf_compute_and_save_data_end(
 	cb->data_end  = skb->data + skb_headlen(skb);
 }
 
-/* Restore data saved by bpf_compute_data_pointers(). */
+/* Restore data saved by bpf_compute_and_save_data_end(). */
 static inline void bpf_restore_data_end(
 	struct sk_buff *skb, void *saved_data_end)
 {
-- 
2.42.0

