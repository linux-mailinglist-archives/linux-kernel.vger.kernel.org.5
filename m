Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FCA7A2F5C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbjIPKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjIPKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:54:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52DCF9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:53:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso10195735e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694861638; x=1695466438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOY/sqAjV4zUSxnEWz+4l2rDatIUvlvXWdj0HM6CCVY=;
        b=PKfu4iffbjVERDVY2Vcn8VcyF8CsCSvkuBBgSddX7Ont/NjfboopDakF9Eq8WJJPxf
         fF9MtQVi4eJbFVwhIaPRF9SCTR/+iGs3/bHyovlQ3jAMkj3yajlBAdKWM9D6+u1ciM8K
         fzSzjWcdrVsGShblgTBhg/Qze3hNDtAXIFy41rGskj5ZGBH1xbbIVCPnu4ikxX5FKyJP
         5SUPj0wcr6E93OC2Ze3a043R9zlohCyHybp83XblAmFpBuL84tz7QBrFElbfCcFr4xj6
         sklNQz+UUodGb66YB6FP44Pd+9hysG3jEv3+dV0l3qkkldYR4tFwkjmW1u/ZeisyNj5a
         bQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861638; x=1695466438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOY/sqAjV4zUSxnEWz+4l2rDatIUvlvXWdj0HM6CCVY=;
        b=WEpVvhoFuJUWjFl5NPH+S9xgJOFXDQokhTFtG1jP9cVwmh1GP7mRf9ymQMKx85gGCu
         2+kGGJwkLTdPVyiqQcfveggTZf6KQZawWNao4agVXxwLlQU6MJl0ZSSUcFE4Cmy3sthu
         pJBxeNHyW0gmwc/cY7ybthC8f6mx3fSvl0hpmPs07uozWrXHG8KZwVDzyMx6oL1cAEhh
         iX6/hDNatTL0mxzy/wvh+/KQxOB+28rQyjFPN3md07OJ+xNmN+4gwMGjwwh//cr2kzTf
         /jiwHKaxHA5bMUZpeNfkEEFtq6k8rdFNWa46hhy17GIDt1fexc8umW8auHSLmpcg9/Ar
         r0EQ==
X-Gm-Message-State: AOJu0YxYjKhSL9BkgU7NkG7HIltDlq6iZWm7TDAykyiHHLy+HO+l66eW
        5DxnRfRy1EKYPe2GMVl3fu+UlQ==
X-Google-Smtp-Source: AGHT+IHdx6+03wALwlLa6aUnQuHEThxyzxSQi4wfPfRJ+Tc+CdiQk+bMgxnb4LTTDDWLjxZJL/mjZw==
X-Received: by 2002:a05:600c:1d1d:b0:404:fc51:4e9f with SMTP id l29-20020a05600c1d1d00b00404fc514e9fmr848227wms.38.1694861637487;
        Sat, 16 Sep 2023 03:53:57 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm9900743wmk.35.2023.09.16.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 03:53:57 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 16 Sep 2023 12:52:47 +0200
Subject: [PATCH net 3/5] mptcp: process pending subflow error on close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-3-05d1a8b851a8@tessares.net>
References: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
In-Reply-To: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=rdxdMoVy0CrsijRyr+7AHTMv9lxPX17lbBfXAdrgKyY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlBYlA/V7jp2UdAR1ummQors/RC6sQbjMGfs6Ah
 9bxgcKzDFiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZQWJQAAKCRD2t4JPQmmg
 c+c/D/9DecyoVShlh2Qpntbg0GirJyOPYGcTM8Y85bP1kAbH49a4djc1lUD6FDQdyF8QINSHTA0
 sWQtPzk0yOBhkSbL3rLgikx9q+1MjeHi9V0ElbBxracI4l6yXOZ8Aq/O0wX6bJi69904DEHaC93
 mFzPS3wtpskCrFb/I8NCI9s4fKJV5gWNGt2KTnaadwb715HWfDw+5Yh92UIBGCQH8eQ0ppIX0+o
 9HZ0VWGCIKKuw5emi2U0vfuAo5ktvZYKU0s2I89cWiLKVeuN/N0mcPJX6pgFUXyHTBSqgWPz248
 arQoGazScqsAoLB85T6hSKpqbdGCsnluQO7hfFQutjrLJjecueJF/a9Gm2lleffo8flxW+V42Ok
 0+dM9xqz3ITO/Gv4sn8OjWJrDFTW/FixA11fS055ToJQrCN+DOH568jea5b/7tkLDkVWMcjCIF/
 TFns2aAM9vnhz8fra7WBmhOgCMdzqBJrzPftx05oBZV6W0zfHUWl/nSQKTrTkvS1CfKt9/wdbqm
 r2/lJn0RR2Y5D82x1CJCT2WomPziMIenQy2kifaVdUBKKceu0Om4ASAOQ8RcRJYcia3zwH4d2bh
 moYYKYQDNONipi606AkhMYUaF+XPNak+s/orNRz7229Uum19JAFLU3XL5dOyQkwEGtzeUyNn1fY
 9nRzpJUse4ogShQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

On incoming TCP reset, subflow closing could happen before error
propagation. That in turn could cause the socket error being ignored,
and a missing socket state transition, as reported by Daire-Byrne.

Address the issues explicitly checking for subflow socket error at
close time. To avoid code duplication, factor-out of __mptcp_error_report()
a new helper implementing the relevant bits.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/429
Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 915860027b1a..1c96b8da71df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -770,40 +770,44 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
+{
+	int err = sock_error(ssk);
+	int ssk_state;
+
+	if (!err)
+		return false;
+
+	/* only propagate errors on fallen-back sockets or
+	 * on MPC connect
+	 */
+	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
+		return false;
+
+	/* We need to propagate only transition to CLOSE state.
+	 * Orphaned socket will see such state change via
+	 * subflow_sched_work_if_closed() and that path will properly
+	 * destroy the msk as needed.
+	 */
+	ssk_state = inet_sk_state_load(ssk);
+	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+		inet_sk_state_store(sk, ssk_state);
+	WRITE_ONCE(sk->sk_err, -err);
+
+	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+	smp_wmb();
+	sk_error_report(sk);
+	return true;
+}
+
 void __mptcp_error_report(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
-
-		if (!err)
-			continue;
-
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
-
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		WRITE_ONCE(sk->sk_err, -err);
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
+	mptcp_for_each_subflow(msk, subflow)
+		if (__mptcp_subflow_error_report(sk, mptcp_subflow_tcp_sock(subflow)))
+			break;
 }
 
 /* In most cases we will be able to lock the mptcp socket.  If its already
@@ -2428,6 +2432,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	}
 
 out_release:
+	__mptcp_subflow_error_report(sk, ssk);
 	release_sock(ssk);
 
 	sock_put(ssk);

-- 
2.40.1

