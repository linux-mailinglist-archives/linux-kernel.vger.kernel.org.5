Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80C76EBE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjHCOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjHCOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:07:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903EB4224
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:06:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso8731885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071604; x=1691676404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLnjc8jPq2PoD5M5aiFgUeVBrc9aIeJJlwbo6fwSV28=;
        b=PniuI4mhE+9Hr5kVvw8WodCwDYHCknlrSoi4oY/F/4MMl9qgwDvgyPHh76hzQ6TSjH
         Vd0kAhHQsPBcV7x4jj/bvR4YBGspwCSImxmOJnMrRL7xOC6KwcEj9UDlYCeE9sLTaJh5
         a8SJArDhjkzS9FNXvbI3C6V+aHuAWEdph5x0qqqWF352VlalvDF0dWL3rqWtUR1xQ0yu
         7kasjrpqgsxNGpDDdDWhB2qbQGwLM4HYCXkVaBmBqQm4ke9nl12IufmKSnFbwO+bgZWO
         UEWrwVu6BztJAvACi1qE0AXwr+3xmtO4RtI/OJr2LdfmbI53BnQ9b9o8HUYub4rpIsjD
         Ex7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071604; x=1691676404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLnjc8jPq2PoD5M5aiFgUeVBrc9aIeJJlwbo6fwSV28=;
        b=FaiGp+Czur+9+OP5YgyeQFUD7EXloNBy68w/wE5JQkj1PiLkKRbHyrhteSsg5Ov2w8
         I5XU0bIL0XAKo1WuZbK9DriOpouhkHerYaUpdL/xBobRgxcmHHgeLaioWvmA54GpycIj
         cYKwVjJqvkozIjI/l45O03MV2k/Zact9WJq1UkKcpywyH3OIqdCp+27b2P6pxTTSxjQq
         A0h7CbXZWAzkEwmEwBSCH2HgmCw55zPBUD6WWzjteVdGamYRt49P/aODVAiXvoj/qOH8
         8G7m9Z5IS+kT2kN1MhC5+lqRUDliDCESC/WVZYmhOLn0rfbKXbK2B9l0yUeIPkTGkrCL
         KclQ==
X-Gm-Message-State: ABy/qLZtrt4hxKn7D+S5QN8dqPoO9XE3h6+ry3twd7qQsOdB7pKHjwLL
        lymK8tQ7bFscrBqYeAJoKZxX3Q==
X-Google-Smtp-Source: APBJJlGBfvMWrRFHnBIykTOaed0DaYtu47ZrmnPZAuDr9AgMye0iCQDRpN4u3trjXrWFZSDvLs74ig==
X-Received: by 2002:a17:903:22c8:b0:1bb:b91b:2b40 with SMTP id y8-20020a17090322c800b001bbb91b2b40mr22927532plg.60.1691071603910;
        Thu, 03 Aug 2023 07:06:43 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:06:43 -0700 (PDT)
From:   "huangjie.albert" <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 08/10] xdp: add xdp_mem_type MEM_TYPE_XSK_BUFF_POOL_TX
Date:   Thu,  3 Aug 2023 22:04:34 +0800
Message-Id: <20230803140441.53596-9-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this type of xdp mem will be used for zero copy in
later patch

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 include/net/xdp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index d1c5381fc95f..cb1621b5a0c9 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -42,6 +42,7 @@ enum xdp_mem_type {
 	MEM_TYPE_PAGE_ORDER0,     /* Orig XDP full page model */
 	MEM_TYPE_PAGE_POOL,
 	MEM_TYPE_XSK_BUFF_POOL,
+	MEM_TYPE_XSK_BUFF_POOL_TX,
 	MEM_TYPE_MAX,
 };
 
-- 
2.20.1

