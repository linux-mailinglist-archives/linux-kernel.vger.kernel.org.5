Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8E8097EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572939AbjLHAxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444228AbjLHAxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:53:24 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495A128
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:53:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d42c43d8daso10065457b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996804; x=1702601604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUh6+R8PyJI5UjQ2PsAiU6Bt8ES298Z5QR8+6xQcmYE=;
        b=2TIiaxC0IIxvIXQ99aZ23/ECXzt89xzHAz8vDzuidfu7txru05e/Q95jZRIPfbTIRU
         hKjqdzpA4u+6RZOKq1RxaEedOUSHBV4IFACdVO/GOECX4sBca8VsOFp719jGF7hwka+5
         D1DFwVkJFRieD79PWHpIq/q1ywYDWoPRKhhzPLqlWMyTj5IaUR12wdT3MC+XwbcUg/us
         8SviaMHAuKerm8BZEksmxb1prLWrynhmjxZlYSMM2d7P6g1tiWrSIMPgbKHAb8TSC5xA
         4IwY5GVqli0f0OOEvtMFo5C3NXialwES/oiAPvLfxFdl3IkWXpgA60r4JaCVij2Lzv2C
         Wuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996804; x=1702601604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUh6+R8PyJI5UjQ2PsAiU6Bt8ES298Z5QR8+6xQcmYE=;
        b=VjUM29HcFIBRVIqq7820kWuAMj3Ac1ON8AoKysZZg/2VS8e3fQMptpt721lWQVnfSe
         Z9FcKvOtnKMUCfGk5k8+HIaAqu4HflgHr5HSNu5L/G88Qi7CoTvp8HKtdT+nGb/6bqnT
         5URqLLsr8CUyXaIttMJ1+rX7dxT+QEUjkD9GTc6yerbheACfES9vyot3ihl6mwjySs0q
         sBuO+SoJDPdXu87zvNI+hnqC283oqdMe8pu0WQySDTOL9SmLq6dCTGum92LCvfd7MuuV
         vXnzAAlnEGJv5ryxDp9oXk2VHE5uai9g4K5Pnpm3rIKitzvt+ZD7NsxapzTRI79fZ/Cf
         kt3w==
X-Gm-Message-State: AOJu0YwlMRnxK5TkcVSEoTk9/Ym4Sf5eDekW3RwJJVzZNCwucRqYGPHm
        aAU0/MgqDqHEAWboRjYUzfAeGUza/ErYy1/W9w==
X-Google-Smtp-Source: AGHT+IHVuzVckyE/E0TPu0QHBrVQTT3kDuCWzit0Enzhqk5IFqRCJ3FkAoDBVqkfvr2rYGREMqR0vzwsTFGcsut5qw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a25:9d10:0:b0:ca3:3341:6315 with SMTP
 id i16-20020a259d10000000b00ca333416315mr2159ybp.0.1701996804012; Thu, 07 Dec
 2023 16:53:24 -0800 (PST)
Date:   Thu,  7 Dec 2023 16:52:45 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-15-almasrymina@google.com>
Subject: [net-next v1 14/16] net: add SO_DEVMEM_DONTNEED setsockopt to release
 RX frags
From:   Mina Almasry <almasrymina@google.com>
To:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Mina Almasry <almasrymina@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interface for the user to notify the kernel that it is done
reading the devmem dmabuf frags returned as cmsg. The kernel will
drop the reference on the frags to make them available for re-use.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v1:
- devmemtoken -> dmabuf_token (David).
- Use napi_pp_put_page() for refcounting (Yunsheng).

---
 include/uapi/asm-generic/socket.h |  1 +
 include/uapi/linux/uio.h          |  4 ++++
 net/core/sock.c                   | 38 +++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 25a2f5255f52..1acb77780f10 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,7 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_DONTNEED	97
 #define SO_DEVMEM_LINEAR	98
 #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
 #define SO_DEVMEM_DMABUF	99
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index ad92e37699da..65f33178a601 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -30,6 +30,10 @@ struct dmabuf_cmsg {
 	__u32  dmabuf_id;	/* dmabuf id this frag belongs to. */
 };
 
+struct dmabuf_token {
+	__u32 token_start;
+	__u32 token_count;
+};
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa..521bdc4ff260 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1051,6 +1051,41 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	return 0;
 }
 
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct dmabuf_token tokens[128];
+	unsigned int num_tokens, i, j;
+	int ret;
+
+	if (sk->sk_type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP)
+		return -EBADF;
+
+	if (optlen % sizeof(struct dmabuf_token) || optlen > sizeof(tokens))
+		return -EINVAL;
+
+	num_tokens = optlen / sizeof(struct dmabuf_token);
+	if (copy_from_sockptr(tokens, optval, optlen))
+		return -EFAULT;
+
+	ret = 0;
+	for (i = 0; i < num_tokens; i++) {
+		for (j = 0; j < tokens[i].token_count; j++) {
+			struct page *page = xa_erase(&sk->sk_user_pages,
+						     tokens[i].token_start + j);
+
+			if (page) {
+				if (WARN_ON_ONCE(!napi_pp_put_page(page,
+								   false)))
+					page_pool_page_put_many(page, 1);
+				ret++;
+			}
+		}
+	}
+
+	return ret;
+}
+
 void sockopt_lock_sock(struct sock *sk)
 {
 	/* When current->bpf_ctx is set, the setsockopt is called from
@@ -1538,6 +1573,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
+	case SO_DEVMEM_DONTNEED:
+		ret = sock_devmem_dontneed(sk, optval, optlen);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 		break;
-- 
2.43.0.472.g3155946c3a-goog

