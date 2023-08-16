Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF47477D8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbjHPCzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbjHPCyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:54:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B5212F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:54:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6424c61c80eso19665886d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692154484; x=1692759284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B//PxqTOcLRZSFYVWOXGViYC9OULMJhe+RhXHERECls=;
        b=VvEnBrfJTbDnS7YO6wf4U3/Wb0P5UNqUPHrcpqNithi5S0BrD4zhGQP9vNu7gX4U69
         O4PnAXhdHHEEMNemMlmWN8cR6k7G2oaNkIgMN6edW/LPayyq255oQb/D3Zoc/FOPZDhL
         chxBz1yU4VNEqdDK/hP+j4mCLwWPYllhrEPFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154484; x=1692759284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B//PxqTOcLRZSFYVWOXGViYC9OULMJhe+RhXHERECls=;
        b=lo6ZZyt+ettWA1PhpiyQQMiYXKLqXyxkjV/xfM6IzXcyw9ZXo8TnxX+41DMhBiZese
         tdH/TRxnfS25Uzsi6/PhnCIKmGMGZLxLjXw/j/LJ3xktXKtvPRB2anmc0AqU2sxsXeU/
         NO0YSQWB6umK2i6scQpLc7U10+IkM35NObwaimQsWXv+SkZ7hASV8v1gj2N2RAlhoAJX
         6xO8BsrDmd+aVVD5qYIe4bSt8Ffj1ZnlD5Nz1ffi66yAuFvq5b6+N9ti1Mc7TyQ48jk+
         ofd6uBzKnQVUBsOO7yOFCK9ap/C2alPTUADFKecVPbUX+dekf/r7y9qta9pCS2lNVQRY
         JOqQ==
X-Gm-Message-State: AOJu0YzMPNaFgU+tPtw5iuFlAY4ozqUHiKQbBtLGvjU/L+5+w3LkqTY9
        /HLDtjmkh7qWCcVLj+fwCxT7Mw==
X-Google-Smtp-Source: AGHT+IH2b3FS6jHzul6TdkbYn8e/Gv5OnxHjyZ+bzWZToXD1BUhFlrn/X8Ho5v7x8qdmANdvX12Jow==
X-Received: by 2002:a05:6214:caf:b0:635:ce65:38a2 with SMTP id s15-20020a0562140caf00b00635ce6538a2mr6525581qvs.6.1692154484594;
        Tue, 15 Aug 2023 19:54:44 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id i13-20020a37c20d000000b007655a4c5423sm4143104qkm.130.2023.08.15.19.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:54:44 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:54:41 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Yan Zhai <yan@cloudflare.com>, Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v5 bpf 1/4] lwt: fix return values of BPF ops
Message-ID: <28cb906436e87eada712f55e63ae5c420bea0ecb.1692153515.git.yan@cloudflare.com>
References: <cover.1692153515.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692153515.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF encap ops can return different types of positive values, such like
NET_RX_DROP, NET_XMIT_CN, NETDEV_TX_BUSY, and so on, from function
skb_do_redirect and bpf_lwt_xmit_reroute. At the xmit hook, such return
values would be treated implicitly as LWTUNNEL_XMIT_CONTINUE in
ip(6)_finish_output2. When this happens, skbs that have been freed would
continue to the neighbor subsystem, causing use-after-free bug and
kernel crashes.

To fix the incorrect behavior, skb_do_redirect return values can be
simply discarded, the same as tc-egress behavior. On the other hand,
bpf_lwt_xmit_reroute returns useful errors to local senders, e.g. PMTU
information. Thus convert its return values to avoid the conflict with
LWTUNNEL_XMIT_CONTINUE.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Suggested-by: Stanislav Fomichev <sdf@google.com>
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
* v5: discards skb_do_redirect return instead; convert
      bpf_lwt_xmit_reroute return;
* v4: minor commit message changes
* v3: converts skb_do_redirect statuses from both ingress and egress
* v2: code style amend
---
 net/core/lwt_bpf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 8b6b5e72b217..4a0797f0a154 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -60,9 +60,8 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 			ret = BPF_OK;
 		} else {
 			skb_reset_mac_header(skb);
-			ret = skb_do_redirect(skb);
-			if (ret == 0)
-				ret = BPF_REDIRECT;
+			skb_do_redirect(skb);
+			ret = BPF_REDIRECT;
 		}
 		break;
 
@@ -255,7 +254,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 
 	err = dst_output(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 	if (unlikely(err))
-		return err;
+		return net_xmit_errno(err);
 
 	/* ip[6]_finish_output2 understand LWTUNNEL_XMIT_DONE */
 	return LWTUNNEL_XMIT_DONE;
-- 
2.30.2

