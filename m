Return-Path: <linux-kernel+bounces-20014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1182783E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DFD284CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9654FB7;
	Mon,  8 Jan 2024 19:13:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BB55766;
	Mon,  8 Jan 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2ac304e526so110813366b.0;
        Mon, 08 Jan 2024 11:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741235; x=1705346035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rpvq8Yg/ydgOgzuehJs8deQQoH5fXvdPWPAK1pUUco=;
        b=rZ5Y24n35dNFks/VAZcEG3OkMFPRBjLxgO6kVEQ3HVN9q8Yf+XNB7rsXBioU61AmqP
         KHV+MQjq7+PIZnTJV9VbI7qNf83Ed7XWa7ecmqjHFs95QN2IgbP5za+vad54Ffy1Z+/v
         DDf03sUx460RafPhz4zZ0oUYBVOUD4qdd41JKaqMhvZJd6sTudBaY4JHMR3wjiQIdUAK
         DnDVnbjYY2zlBOiJ0cex7lAOUIg92mbA5zc4z0/PSO8l8aVFu32AFehfLDmbCYRVlyqk
         AC5ij1x1L0wzDPtKikzNfY1EqDZjECewIvpa2D3GLxx66XZKsISAGFc8p3dRIBYWyToV
         dLbA==
X-Gm-Message-State: AOJu0YxCekBsB02+Mabw0s3CwW3iA5h47/AKQ6R6JATJ3DI/BGw2upkO
	9zRhO8Tlgs8nlxetoq0zmJk=
X-Google-Smtp-Source: AGHT+IENSyBaeAxqjIQOyc3AgvX70HtJq+YgB9PS1LlDluPp51gxxJ9ZIFmZJRNInza3g0sHLau8pw==
X-Received: by 2002:a17:906:2791:b0:a2a:38d8:a64 with SMTP id j17-20020a170906279100b00a2a38d80a64mr1286348ejc.65.1704741234619;
        Mon, 08 Jan 2024 11:13:54 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id bw8-20020a170906c1c800b00a269b4692a9sm175029ejb.84.2024.01.08.11.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:13:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: dsahern@kernel.org,
	weiwan@google.com,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net/ipv6: Remove unnecessary pr_debug() logs
Date: Mon,  8 Jan 2024 11:12:53 -0800
Message-Id: <20240108191254.3422696-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ipv6 system, we have some logs basically dumping the name of the
function that is being called. This is not ideal, since ftrace give it
to us "for free". Moreover, checkpatch is not happy when touching that
code:

	WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Remove debug functions that only print the current function name.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ip6_fib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 4fc2cae0d116..fb41bec6b4b5 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -751,8 +751,6 @@ static struct fib6_node *fib6_add_1(struct net *net,
 	int	bit;
 	__be32	dir = 0;
 
-	RT6_TRACE("fib6_add_1\n");
-
 	/* insert node in tree */
 
 	fn = root;
@@ -1905,8 +1903,6 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 	struct net *net = info->nl_net;
 	bool notify_del = false;
 
-	RT6_TRACE("fib6_del_route\n");
-
 	/* If the deleted route is the first in the node and it is not part of
 	 * a multipath route, then we need to replace it with the next route
 	 * in the node, if exists.
-- 
2.39.3


