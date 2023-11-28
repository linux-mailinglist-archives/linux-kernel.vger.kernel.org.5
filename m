Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81167FC697
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346573AbjK1U6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346323AbjK1U56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:57:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED319AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b40423df8so25444185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205083; x=1701809883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=elzW+7nHN98jC6ZJZMIqiLsFfmXCX42bi2ai1Y4bS/09yKYcU6wF9dk4lhpsrX5KgI
         V0Y9omLOT+CvFthG444zGkNllvn5FqXuw0tZh79L1inaTsGIaaShV4UvMViWoR4DIKCZ
         CwvbeML3MKMLybJeF34nxXOvaezU+VGRXxoXeuVlPx4LLeU4oQ81TfPfjoJtRWukXBjd
         Iwr11MpHFokR5J4xK77NOJxPoseJyL/VwyQ8sZVgRCOw6uJAAh0pLoUwVwSDiGoQNL8O
         uFLPljZsFoyAvKbG8++Vo5wQDFopMfeAEAqwMJzdvLjHCnQ9NNsvNmTJDHS3y9MrDEFV
         byaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205083; x=1701809883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=gQ30R1WfUuIgwYv62zFqNhv1bXZoJ5Jh1GwdnMc/3tqqQeD99fkcKlN7bke6dElgAl
         /IZKAUtHEsXq/oGfipq6SEpX0Ah44bfTQ3vaZ6NcKejjZrlB5P3SZmhjMVSOmw3FQbUt
         dKheBi4mHRvDaKq49GiJc5nMHZhhSJ/5DKZ23ZkOQF/nzPyLqtL1U8OdM1CHBqTcpR/N
         QQ6lTpY0YUpmTEhjHnOsbqI3XM40tSoefrPh9tvm4aFA4qWLp8ogpO7pLXQPkHtvrS23
         9Zxl68/Dxg+C0Hxst6FSkd3MVKGA7bRNoDAFWWZIDZrJhUfCnSieIVmnL/niqjBR5QG4
         Bweg==
X-Gm-Message-State: AOJu0YzLyUhUxPqoPICnlpZoMZ9yUkIrzGP2FH0WsBif10hNtgfeGyU9
        HlM3JEUXeAOrJT9gg61KKop85Q==
X-Google-Smtp-Source: AGHT+IFrXyrxI2DheRUy2qRVidUrN3TX/h847BSafti/fP2chMfRtHxz+JkNhBcBQeK9NEeeMi1vGQ==
X-Received: by 2002:a05:600c:1d89:b0:407:4944:76d1 with SMTP id p9-20020a05600c1d8900b00407494476d1mr10794865wms.17.1701205083659;
        Tue, 28 Nov 2023 12:58:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:03 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v3 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date:   Tue, 28 Nov 2023 20:57:47 +0000
Message-ID: <20231128205749.312759-6-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128205749.312759-1-dima@arista.com>
References: <20231128205749.312759-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the connection was established, don't allow adding TCP-AO keys that
don't match the peer. Currently, there are checks for ip-address
matching, but L3 index check is missing. Add it to restrict userspace
shooting itself somewhere.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bf41be6d4721..2d000e275ce7 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.43.0

