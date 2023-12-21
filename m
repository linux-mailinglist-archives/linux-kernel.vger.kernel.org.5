Return-Path: <linux-kernel+bounces-8432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A281B710
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B861F241C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D57745CB;
	Thu, 21 Dec 2023 13:12:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476576F602;
	Thu, 21 Dec 2023 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bb69f38855so492222b6e.1;
        Thu, 21 Dec 2023 05:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703164354; x=1703769154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9sf1n32OXYC12G8mzkhZo6OE4CGgDXLFkI6meoazzQ=;
        b=TQR80AjVvK3TrN8fDmO8pnO/Kihdlahs/6ZRCvH0nehhziO9phOBIGBap0wk1TRz7T
         FAPKpIsHY3BpHAwgB7hFpayeA8DmVdX3DlLpCvjs6YC5d46jiYCGBEqALPP2M9bQzKbT
         Db//A3IJDdZkmZOVJpLbqFL8rs45ZMDOJzvFVyQ/VusHvQGtXRpPysnjsAIyOb0YbM+g
         Z+LpIM2gLE7C4X5RgRHRdQDsoFDD3aJTNfvPgUrAAHQ845PwrwTxa03VX21HyBgzjxEn
         5e1ucv7kDcaVjCFWG+lXonJqfmmyIuY2mYuuSajzeN/F+TbCbQ/BP3xGnm6/WiTpsISA
         kbmQ==
X-Gm-Message-State: AOJu0YzKDqT8kwu/Q8gEHFhXjfX+Y9o7skPzubCo+X8CuYiAlo4Z7RRZ
	E3lM5Cod9w+FOcf4LnPS/dCmWRNhBXagYg==
X-Google-Smtp-Source: AGHT+IFsMAY7qX/6ThEvAPcatTeAg5u2Su4PY3IDFWeoA+u1fj64OLZu9mTwEMF4XKas62EIGR6QYA==
X-Received: by 2002:a05:6358:6a46:b0:173:aea:cd6a with SMTP id c6-20020a0563586a4600b001730aeacd6amr1561024rwh.33.1703164354126;
        Thu, 21 Dec 2023 05:12:34 -0800 (PST)
Received: from hemlock.fiveisland.rocks ([2001:470:1d:225:6d9:f5ff:fe15:325d])
        by smtp.gmail.com with ESMTPSA id fe15-20020a05622a4d4f00b00425b3fd33f2sm805639qtb.90.2023.12.21.05.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:12:32 -0800 (PST)
From: Marc Dionne <marc.dionne@auristor.com>
To: netdev@vger.kernel.org,
	Jordan Rife <jrife@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: Save and restore msg_namelen in sock_sendmsg
Date: Thu, 21 Dec 2023 09:12:30 -0400
Message-ID: <20231221131230.2025000-1-marc.dionne@auristor.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 86a7e0b69bd5 ("net: prevent rewrite of msg_name in
sock_sendmsg()") made sock_sendmsg save the incoming msg_name pointer
and restore it before returning, to insulate the caller against
msg_name being changed by the called code.  If the address length
was also changed however, we may return with an inconsistent structure
where the length doesn't match the address, and attempts to reuse it may
lead to lost packets.

For example, a kernel that doesn't have commit 1c5950fc6fe9 ("udp6: fix
potential access to stale information") will replace a v4 mapped address
with its ipv4 equivalent, and shorten namelen accordingly from 28 to 16.
If the caller attempts to reuse the resulting msg structure, it will have
the original ipv6 (v4 mapped) address but an incorrect v4 length.

Fixes: 86a7e0b69bd5 ("net: prevent rewrite of msg_name in sock_sendmsg()")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
---
 net/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 3379c64217a4..89d79205bf50 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -757,6 +757,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
 	struct sockaddr_storage address;
+	int save_len = msg->msg_namelen;
 	int ret;
 
 	if (msg->msg_name) {
@@ -766,6 +767,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 
 	ret = __sock_sendmsg(sock, msg);
 	msg->msg_name = save_addr;
+	msg->msg_namelen = save_len;
 
 	return ret;
 }
-- 
2.43.0


