Return-Path: <linux-kernel+bounces-89776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD386F592
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7639D1C20AC2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA067A14;
	Sun,  3 Mar 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcZFw25y"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E5C2C4;
	Sun,  3 Mar 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709477048; cv=none; b=DNXI8sung+ldwqe7fO2XwMumh+N5JirFqtFdzBLOqv260bWxt1wBGWXPWuaOQi38WucRx9PvXQxRicuOuWuNNA1Xq/Bskc90H0ofGEgqkxwrcEqZtDfuiETaelKkKXI2f/4UIJolGLXmDbpyhPOvrrJwArfabXxbKomcs8BadiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709477048; c=relaxed/simple;
	bh=GCy5FRsR+9mQBg/lIejbD8S9okazg2WwCQ30b+0Nvxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j8eYFEnT2z9O/Gd5bsNChYvGpeRc1qLmrxe85d5DhouWVT19qp3X1L7W7w5aqF0nMHG5sZzuM7w7MaId+2UUn4yc5VGtaI99eEkjhRAUfHMCPlbGdn7ckwZnoqztVfKYtR7pWpMREco5YinrTjbA3Lcq7d0aWCAwwXg1utxp7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcZFw25y; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce942efda5so3085274a12.2;
        Sun, 03 Mar 2024 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709477046; x=1710081846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z68uSapF4Aw7VW2nII2f/NiewPJCHLb1OhXjHOzlCWs=;
        b=JcZFw25yzn4Ifm5kN0cpeej7QFauXRLeFQlhVPXPRpn4X8fYr9i7xwxF+4VicBvsPN
         CEbyl93qoIFQF9fnobcKHTcU7pfFEv+qhnwJN+5rOJt8W3Tzkcf3Vj9f/e9WTx+V9qP5
         mpFMwutRHbQIymNINlhlkrUtIEKLZvoJ1Rmsd2+kCdkes3mGU6Mfl6hTlhmz6L3GWiyV
         ByxeFJsrbSTll1qrLsCJPpoqk2P4L8raY3ZtbeXYjGIrvnQEXdooJwQjRDBn8Qlzyn8G
         VQeRVzHqWX/nKfmez5GZDfVasfIsKUAZ4Zs7HxB9het1ohb5UkYF0ts+Au6epMatDnjf
         mcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709477046; x=1710081846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z68uSapF4Aw7VW2nII2f/NiewPJCHLb1OhXjHOzlCWs=;
        b=o9ylYsFHnv6pNLB2pYXT3maPml4YaWChpbIGjO+ibs1Rh/vTXFil50xq4NQodCBnD9
         vQej95kHpG7uSY7y5GAnBc/PMEnNOcjPNEb0r3CB1L3hgvMiqvlpWPUNqwgXr7w4A5nv
         b4/HQxx1ZOnurQ38q/VAryYU5BOMnXOQtzKqE30yaZSfJTqvCAEwPkkRwKMGlDNIJwLF
         IQrGLEVXbAGWkt9gKEjsUc1pKuJqw93S/ZntNhGaB7B9KAKtkeScPLtS6GuMIyV2L8XC
         uKvzKNOhJalEa6/nKFP1+YiJTPvIsBwAxdLftFv3205BW4Tigtub/KYOl2GkKNMhASu6
         Svfw==
X-Forwarded-Encrypted: i=1; AJvYcCXGMA45bQDMM4XJmoznbuTiUYWX6C6Gg/dpoQpJPQkteoLM/gtSUu9AZRCWJWVTMirw5nAtEBQqgoGc6oC/s0PthsOc9grYGUGPt0kN
X-Gm-Message-State: AOJu0YzJ3k4tBmFBvHUDnbZ6eABTUC3AXG4LAmk6LjiVlmAw6Oo9tLp0
	HCzrAYvVQKmaVQ/Bf1sRRmdbrNq2GTAx52spqE7xhJzibQ3DzBXD
X-Google-Smtp-Source: AGHT+IFCer0a0si2NwBlChEN/3QXRP2FKqkzqyK10gXJHIvDmH7SVboEZuVP89Dun+DHitTEym6zGQ==
X-Received: by 2002:a05:6a20:729f:b0:1a1:4e01:f30e with SMTP id o31-20020a056a20729f00b001a14e01f30emr2137790pzk.29.1709477045988;
        Sun, 03 Mar 2024 06:44:05 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:98b4:6d91:d5f4:8f27])
        by smtp.gmail.com with ESMTPSA id c2-20020a637242000000b005dc36279d6dsm5924030pgn.73.2024.03.03.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:44:05 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed blocking_link field description to prevent kernel doc warning
Date: Sun,  3 Mar 2024 20:13:59 +0530
Message-Id: <20240303144359.7066-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/net/tipc/socket.c:143: warning: Excess struct member 'blocking_link' description in 'tipc_sock'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 net/tipc/socket.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index bb1118d02f95..7e4135db5816 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -80,7 +80,6 @@ struct sockaddr_pair {
  * @phdr: preformatted message header used when sending messages
  * @cong_links: list of congested links
  * @publications: list of publications for port
- * @blocking_link: address of the congested link we are currently sleeping on
  * @pub_count: total # of publications port has made during its lifetime
  * @conn_timeout: the time we can wait for an unresponded setup request
  * @probe_unacked: probe has not received ack yet
-- 
2.34.1


