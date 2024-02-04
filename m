Return-Path: <linux-kernel+bounces-51659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87243848E00
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9C4283BD7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06DC224EA;
	Sun,  4 Feb 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIaceN9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F0224CF;
	Sun,  4 Feb 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707052366; cv=none; b=grW3OP+93LqH3VxzCOWC8+ah85EyXXHHWOmb3x+7Hf7wEp96mpcEJqahwghyRngEYwPvWBu6BaE88NB6Yz4VGxRqstvdDB4bChUWnx/hBxxeLLdzqAr84e3AmhDkQiWltLBnjF/VqCKPxCzPCJbSYba9nAaaw0h9Bp6sBSdXE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707052366; c=relaxed/simple;
	bh=nH3NzbqLBwHOgGrDWdI4FNLuMls7cfEBPoA/IJE2soY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTt+mEtlFrSCqVJyZHb6RHcMZN8MMg06gWoVvVX34N5gekTPIIpexrgADxe3+/3jBPB5crIFEbesm4tLqhY7nNtv5+A8TJc4Z/6oz7bICT+MBYK5CiRvNkVDqyngCKHaLUuubh+wEy0f5nqK5HUxzFn9mVu+Zlf5n9iLQun/u68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIaceN9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A993CC433C7;
	Sun,  4 Feb 2024 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707052365;
	bh=nH3NzbqLBwHOgGrDWdI4FNLuMls7cfEBPoA/IJE2soY=;
	h=From:To:Cc:Subject:Date:From;
	b=VIaceN9sj2XJBTxfjnVqZxm5olOLj0i7ar4eoSRTRAIuViaqWfQOLqrLWvfMQg8s1
	 OEGpICA3DP8Ba/xWdNlk9E3/XCFmeRXTKz7i0FfGO05apbv7/sEl9LpGL0j5XtvV2T
	 VUCQPHsrn59POjCDRhvbL29sRQa4O3Wnn0e6Vl7MpKqtJ+5cS5q+YGw/FMbnwqX+vk
	 YWQEuvl2dz0rvIlmcv7kAohq2ekpg8Sgwddk+d6hJEYyBGFGEkZ72nLndtq/77LaDB
	 42cnySgcEcPEnHoHar85Rq0AV8tMD2dLMoWcwm0er+8TFdigEss1EmULJNxvfZ8OEd
	 8d1Kjb4zxUpew==
From: Masahiro Yamada <masahiroy@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	linux-kernel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: [PATCH] net: tipc: remove redundant 'bool' from CONFIG_TIPC_{MEDIA_UDP,CRYPTO}
Date: Sun,  4 Feb 2024 22:12:26 +0900
Message-Id: <20240204131226.57865-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'bool' is already specified for these options.

The second 'bool' under the help message is redundant.

While I am here, I moved 'default y' above, as it is common to place
the help text last.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 net/tipc/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/tipc/Kconfig b/net/tipc/Kconfig
index be1c4003d67d..bb0d71eb02a6 100644
--- a/net/tipc/Kconfig
+++ b/net/tipc/Kconfig
@@ -32,16 +32,17 @@ config TIPC_MEDIA_UDP
 	bool "IP/UDP media type support"
 	depends on TIPC
 	select NET_UDP_TUNNEL
+	default y
 	help
 	  Saying Y here will enable support for running TIPC over IP/UDP
-	bool
-	default y
+
 config TIPC_CRYPTO
 	bool "TIPC encryption support"
 	depends on TIPC
 	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_GCM
+	default y
 	help
 	  Saying Y here will enable support for TIPC encryption.
 	  All TIPC messages will be encrypted/decrypted by using the currently most
@@ -49,8 +50,6 @@ config TIPC_CRYPTO
 	  entering the TIPC stack.
 	  Key setting from user-space is performed via netlink by a user program
 	  (e.g. the iproute2 'tipc' tool).
-	bool
-	default y
 
 config TIPC_DIAG
 	tristate "TIPC: socket monitoring interface"
-- 
2.40.1


