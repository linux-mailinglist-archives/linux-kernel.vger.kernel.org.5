Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8D77939E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjHKP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjHKP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F9230DA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso1921832f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769529; x=1692374329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e3CJJrqZ7ewmH2P5w0S/0zIFsn4QxREbiOM6aZrWvM=;
        b=lX+Ys8CLIATfx0LJtFzeLQ0ERTTrxPkesrFPMmBBNHN86jFrD5P1lfm+ZuIU+kAt7e
         BKBApd8RB4H0cU1jcFTrQziVbtFXdP1duoGwh18rf/io955LcWi7us/52WSQe7pFxdrN
         EJwVzpvtfkWkZnUNNLZTu/xoWO5mMB33a6uemnlGsaUvGomWxdXoxtP0zmFEhhokvjCV
         j/sqlOHXHII4646BvzRoTJ5hcYJbNMEgjwc+ULaarg5W/hYVGjbZHwIv/en9my3r/+zp
         yt5LVvVLIh5SJ7x/IeBaD3TVW7tdwEaGCfOtSkZAIktPoya9afYeSPdirqU9498B2Sl3
         IoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769529; x=1692374329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e3CJJrqZ7ewmH2P5w0S/0zIFsn4QxREbiOM6aZrWvM=;
        b=ANlfU06FY5PqYcwE+g9dtwMsVkjOomqtz9aVkKOaT2mp49CaPAyNbzKcmUN/yEJlSs
         A/n6FitHADjbeR86ww005YkEpiNq48wpoLAmsLDNoG45cMY34K/ec/m8G11XSGhb2Z/b
         ljCL/++t5i/O92Zg/orrmW4uuetb0QyP46rK8FstPjxzC7T6FM8Y+B7vaO4ztG87fcFn
         ZkPGFCy6mwZ3InXZLaOFVDs7WaUFTTNuTGrFzUkwIUJlpXAK0HlllP4YQkm0q8lPUJLX
         rt6b3eckAMJ2jfWtwztdS9nj4CNaEYBP5EemOuvwqlrg9M3xeJnBpI9BzLyhO17oABkf
         Q0xA==
X-Gm-Message-State: AOJu0YwcE7zaeuIhNWyT2HVv9u0KFcelNvwqgf7iRpHuFPNkPoeOinNm
        ME6RwOeNK0nPuZyHADXxW/om4Q==
X-Google-Smtp-Source: AGHT+IEMRuVR4UsvMsf8IVtrN3B7SqSXCFwDWFlUx5pvxeBUjQjokyhxcx8/ORvwhtNlUaLQ2ZSj+w==
X-Received: by 2002:a5d:438a:0:b0:30f:c5b1:23ef with SMTP id i10-20020a5d438a000000b0030fc5b123efmr1642236wrq.41.1691769528840;
        Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:21 +0200
Subject: [PATCH net-next 08/14] mptcp: avoid additional indirection in
 mptcp_poll()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-8-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=J9VNeffJDPfkoJa+eIaJ2TO+2VxqSncVcduqI3h44xQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvfhQYxdq5nUH4ZAoej7J8+p2L5Lmk3Y0Jp
 4uaCRiefWOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c8j2D/4z5s9NgjC9q7QH5Jp/JvDdZkfDO89mpDeftND2ALbI0xuUPpP/N2wmHEm9wtubG3ZWDPP
 1YHwLOswxY4RhycdjJc8NMo3j/IqTpCtz/hTNXmOdReLcv1BiuIERObu7456c46NuhYZbG2fepu
 j1sOGlUnf6LxHPb4MLyWv5PtU90T+gL+MQFyQr4j+uumiM719nFQm+yB7j7ULl08oD/x1ZjRdy1
 BD8Sci4RpOCJJYZ5JK3/Ms6H1NOPsULBbPGoaVJks9OsFpEMwky9aPPlpDsQOQAfKVlkLp1mMZz
 UH4zdwDsJIhMC1USzsgCLBM7TZIu3lckmH6QikfyD1nJ/6R7G4jE2u3zJC6uqLWx8EJo74mfqUu
 hakjOElfGBTXTXCBLIDoBFJTDBEFspHXFtzxztgMGB7mDZIUJ2RcUwn4K8r1t7zBK2GhLfxQrNL
 mUHr3pJ/m/h4UuJvc9cyK4DHp6gN7PF/bRO+Kg0ZCTEp2zdoi8UEi24lqRRVZfJhVd2QR+1ueuK
 JZhzQl2UjPNt+UW6kN0DcNIgcIaBi+1T4l1O1zyx8jGXfyHkfC1GQ0DZe8C42hOD9d5//IZqhV+
 T9uAVSAVqZXlJ1unylAdRkJ1lgXkkuRnOri0iROXZx/wK//VK6iWZodcb2jhuj2NaYq/xZr2oAq
 Q0T1caiGXyTPi4g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

We are going to remove the first subflow socket soon, so avoid
the additional indirection at poll() time. Instead access
directly the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8b75fbc4f24..e89d1bf44f77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3844,12 +3844,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
-		struct socket *ssock = READ_ONCE(msk->subflow);
+		struct sock *ssk = READ_ONCE(msk->first);
 
-		if (WARN_ON_ONCE(!ssock || !ssock->sk))
+		if (WARN_ON_ONCE(!ssk))
 			return 0;
 
-		return inet_csk_listen_poll(ssock->sk);
+		return inet_csk_listen_poll(ssk);
 	}
 
 	shutdown = READ_ONCE(sk->sk_shutdown);

-- 
2.40.1

