Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA8758C26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGSDcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGSDba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:31:30 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531021992
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:30:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7680e39103bso372379685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689737451; x=1692329451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5ViIa9kIWhKpjXcZBtYO65UsTVYeK9sG8XIg7UKsWY=;
        b=OOFAVLqjATrStPvjkz6NnW62pm2cGNMLe4dpM6cNDeB5rP5Y5izGVnDiI3Uhjykxg+
         TTCC+ei8wan7SyFu5F4yF2GdKBEDzEoSQUphmNFPuNgTmBHea1PmRR2qP//KG9JFVMF1
         0Br/DjzwQRdgd9lFNRolxIY1vwdZ9kfaueXA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689737451; x=1692329451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5ViIa9kIWhKpjXcZBtYO65UsTVYeK9sG8XIg7UKsWY=;
        b=es6CwgWQBzeXBoLka8ZTq1HzpbP9EJMZvEcpewjDiDZ/qFCN70sWySLhI4iHq53KOz
         2zJhJ4iJF9Sefgc5dYdusaEM4A67CzzEJGQoEcsMLwgNKTe5GwwnyIomsHtQwIKUPy6z
         vL3Vqy/iu5NrmE/F8heFgmf8X6d7oYcw90AnALFJPDYobsB6jDZymV86R965Eiqm328P
         g6xnO7WU9HZb0icSYJafyFyHjeOVsATWoMkLEuqjgse/4e4WGPdFywaefXNdV3oVN4cZ
         8QZnIsGwj9/nik32uRkV31XFq3p+qprnhDTeImjssSBwXMwaZMV+m98uhnQjIANW2Djp
         qMow==
X-Gm-Message-State: ABy/qLZHRd0tv+UouOSp9wKBX+1FzLNmtSoKLteN+na1CzxyCRtm9Yww
        0wUYLeI2909YX+m6IVPDovalig==
X-Google-Smtp-Source: APBJJlEDtuDMnxxA73PfvNz3FCIl2UrlOG+E4Uu71tzJs2uiJ2IVYZ5Pm2FW7nVh9jL+ddXoNlHHPQ==
X-Received: by 2002:a05:620a:8287:b0:768:14ee:2467 with SMTP id ox7-20020a05620a828700b0076814ee2467mr1485529qkn.66.1689737451232;
        Tue, 18 Jul 2023 20:30:51 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id u1-20020ae9c001000000b00767d203ed84sm1028074qkk.24.2023.07.18.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:30:50 -0700 (PDT)
Date:   Tue, 18 Jul 2023 20:30:48 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@cloudflare.com,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jordan Griege <jgriege@cloudflare.com>
Subject: [PATCH v2 net] bpf: do not return NET_XMIT_xxx values on bpf_redirect
Message-ID: <ZLdY6JkWRccunvu0@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_do_redirect handles returns error code from both rx and tx path. The
tx path codes are special, e.g. NET_XMIT_CN: they are non-negative, and
can conflict with LWTUNNEL_XMIT_xxx values. Directly returning such code
can cause unexpected behavior. We found at least one bug that will panic
the kernel through KASAN report when we are redirecting packets to a
down or carrier-down device at lwt xmit hook:

https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
down device, and it propagates from dev_queue_xmit all way to the lwt
logic. The result is skb that has been freed by the qdisc continues to
neighbor subsystem and triggers the bug.

This change converts the tx code to proper errors that lwt can consume.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2: coding style fix; sent to netdev instead of bpf for bug fixing.

---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..8738c7a4701d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	ret = dev_queue_xmit(skb);
 	dev_xmit_recursion_dec();
 
+	if (unlikely(ret > 0))
+		ret = net_xmit_errno(ret);
+
 	return ret;
 }
 
-- 
2.30.2

