Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF6A7627FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGZBIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGZBI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:08:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C0A268B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:08:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76c4890a220so191370885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690333700; x=1690938500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0NtF3U2QeP9UCLELIDDLvHXTMrNEAe+2WmgLDwewEc=;
        b=Zwegie/aBtxLm5/hxoycUPRg/LkQ/+bpJIJPBs1adCSZnU6/M4XYi77KAHIkaUYFf5
         5oiYrj8pSZiGiUIiSLGeDdPFyg85hpidIdlmu7QljlEKcwguPf2CD4c2jD2M9HiJpHkh
         c0rIWHce8o8oUAI6BuBWP529MRjgnrlaI7qpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333700; x=1690938500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0NtF3U2QeP9UCLELIDDLvHXTMrNEAe+2WmgLDwewEc=;
        b=GJ+fVWbV8jHyFW5qC78m0aSO6/pw+UvA0vh683219JK21svyLyWYyBlJqz4lqwfzcc
         wfvMjTODJNX7JFDwDlWacDwcYThWsEZuxtM4pcFpGbUtfsto6T4I6j/j9gM4QhTy+y8y
         rxhMWgVyJbZXJygPYwTvnXQxhWngINjGkQAbg3Z7SMxtoRYA/snvG4exjvOwk0vB4oaQ
         Dv3l9pPfkzSbC12R+4ux5O/DTqtpjHwyAWHZwf/LvikBzH4Oc4xXkNaZQ/i0NzwfXNkE
         wKmoX8nYQ/JsphLOfd02uZBJIEkFusCuXVP+0s9QaBUo44ic5dQQi3M6NJmJT10XyBvV
         Rkng==
X-Gm-Message-State: ABy/qLZDvrG7Z3CTYYbxc3qE1wOP1noOTXNSb2wxmIMtVFTVgAVIy8cY
        wMnxudA8OHOvICEou4m1cq3c1Q==
X-Google-Smtp-Source: APBJJlHootmHuQIc4Y64hnKm0eyRKTB4o0UGbqOkUA0SaKNL39yvmtLcwTImM1JUwqGGiCQBoMf6wA==
X-Received: by 2002:a05:620a:e1e:b0:768:2472:d4ac with SMTP id y30-20020a05620a0e1e00b007682472d4acmr643965qkm.4.1690333700214;
        Tue, 25 Jul 2023 18:08:20 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id t4-20020a05620a004400b00767c8308329sm812377qkt.25.2023.07.25.18.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 18:08:19 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:08:17 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Message-ID: <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
References: <cover.1690332693.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690332693.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_do_redirect returns various of values: error code (negative),
0 (success), and some positive status code, e.g. NET_XMIT_CN,
NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel
infrastructure") didn't check the return code correctly, so positive
values are propagated back along call chain:

  ip_finish_output2
    -> bpf_xmit
      -> run_lwt_bpf
        -> skb_do_redirect

Inside ip_finish_output2, redirected skb will continue to neighbor
subsystem as if LWTUNNEL_XMIT_CONTINUE is returned, despite that this
skb could have been freed. The bug can trigger use-after-free warning
and crashes kernel afterwards:

https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

Convert positive statuses from skb_do_redirect eliminates this issue.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Suggested-by: Stanislav Fomichev <sdf@google.com>
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/linux/netdevice.h | 2 ++
 net/core/filter.c         | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..520d808eec15 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -87,6 +87,8 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
 #define NET_RX_SUCCESS		0	/* keep 'em coming, baby */
 #define NET_RX_DROP		1	/* packet dropped */
 
+#define net_rx_errno(e)		((e) == NET_RX_DROP ? -ENOBUFS : (e))
+
 #define MAX_NEST_DEV 8
 
 /*
diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..564104543737 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2095,7 +2095,9 @@ static const struct bpf_func_proto bpf_csum_level_proto = {
 
 static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buff *skb)
 {
-	return dev_forward_skb_nomtu(dev, skb);
+	int ret = dev_forward_skb_nomtu(dev, skb);
+
+	return net_rx_errno(ret);
 }
 
 static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
@@ -2108,7 +2110,7 @@ static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
 		ret = netif_rx(skb);
 	}
 
-	return ret;
+	return net_rx_errno(ret);
 }
 
 static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
@@ -2129,6 +2131,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	ret = dev_queue_xmit(skb);
 	dev_xmit_recursion_dec();
 
+	if (unlikely(ret > 0))
+		ret = net_xmit_errno(ret);
+
 	return ret;
 }
 
-- 
2.30.2

