Return-Path: <linux-kernel+bounces-150399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CED8A9E86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1C81F22C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D016EBFE;
	Thu, 18 Apr 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TooE1OnV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15516D313
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454520; cv=none; b=QKtz+kVRQXrGzfDvlE7l9wwYKQTlCE6mVlB9wTacdiitwGtBZvfVRDZC1RHRfywXKkGeAgKjkANArn8z/tKrMjFlZ6UXtaNhZGLzjfQUr1oFHhiWzPK0aChY3FjYNokj2XmR7Mmn4eideBEr3R2PZ7dXhkF90z6CI1vsGrDFP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454520; c=relaxed/simple;
	bh=aWFOpvJFMYnINTLSgA8EmWFpPZD1N9z9ko3OaW3FO0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gXUxgnKf9Hs1gU478wi1uGdHpyP1O+K51EXd1tWIUcfCllIsUOYNG3KL5B8KpveQ5JRvs00AqMBR4OL9prNXak5VKT1sdsg/KCfNQ62XqwojXgqt2cs9CBKvKvsWRQ8q0dATxYmTAHKLVDcD9HSM57BcDvzw49gdKNX5UrUzA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TooE1OnV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so7480505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713454516; x=1714059316; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRUfSYH5XLsc9HqAAEm8GMYbsUOd/W0lEWfoHF9LhJo=;
        b=TooE1OnVDnouup+J7+nlEIKMvnyxCsqLZ0WvM3l7EBcVUq9KBWlCG1r6bYGVLp9i/K
         y5s6YahoWR6aIJH0jZDiOziiNe9pczdKC6YzU1lwMrNjphD0paqhyro0/A0tfTw8Gg66
         nD1GChPzBxQWijhVNo/2gepuQn6KJYdD3fhPW79M6vcyDDgcORjNbHeGBV2NtqqsHKUd
         5R4DSKVgvFQECCUjWmpjYz6lf0m3iAa0jrVm6y9G51tREx05zGOSjczZ3m5AN5oV43Vh
         MRCkgbnV09YMu6aqYHPmgbdfcg2fXaKGaGxWGxD2bDUzxXY3TY7ikcjCsV82Qtjd5Q9O
         IqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713454516; x=1714059316;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRUfSYH5XLsc9HqAAEm8GMYbsUOd/W0lEWfoHF9LhJo=;
        b=fTBstmaqFq4gHYzaOUAf74N7qXwkuWWd1bHmFyfWulGXi7G/1NjQ6yDsSKbQCE+xT9
         qg2Q7JTF99izJm59BB44Xu+FxKG59OQV0J8fNyCZxLf/dxD23DSjAvxlaoAzWd5MIQeo
         cUGasBN4Ot5XyDMKPqE+CyCZPT2bbfXoTisK7YXvLTjta/pN5YM5OATPl7MEMNw+U8h0
         UdlWI8VESGbkCt9ApbVXRbaDvTfa1k5qWpysosqOXMDQUFvmzszZv5FVJglu8EFuIpFx
         jKGIwD3lOVASNUgxLrb3WEy2BvHHomZwn1JNC5HKdfd7019Sgq5Din9M4dt9iizc1A8r
         pZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8tmLRQYlnkVP38jn5XICmOQiiKonjDdou8wx8OtyLNYgv6TuXn8WlFmczUR87u/LpF3Z8FSKEp5qpKz02t2libAfU1rLQ/S2nHomI
X-Gm-Message-State: AOJu0Yxs0QekhSW//z7EHmzJP2NRbi3nJ1iUZSXehaDMj/171Zi3SWr2
	t62dlRdJwKyWexohNg7NHvqM3skVL6ffEVrjhQbwXQ85lWDlJeyK7/qu+WDBMzs=
X-Google-Smtp-Source: AGHT+IEGhnJQ6Fok7VN1WH4AM0EqRnEGxnsBMAJ3GGvHLpxJH1+mZFZSOdaDrvcXA4chbbmDPSNp7A==
X-Received: by 2002:a05:600c:358a:b0:416:c23a:2c4b with SMTP id p10-20020a05600c358a00b00416c23a2c4bmr2376814wmq.17.1713454516006;
        Thu, 18 Apr 2024 08:35:16 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b00418ee62b507sm1834142wmq.35.2024.04.18.08.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:35:15 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Thu, 18 Apr 2024 17:34:55 +0200
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: Fix xdp_rxq error
 for disabled port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-am65-cpsw-am62a-crash-v1-1-81d710cbc11b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJ49IWYC/z2NQQrCMBBFr1Jm7UASWg1eRUSmcWpm0bFkSi2U3
 t3Uhbv/eDz+BsZF2ODabFB4EZO3VvCnBlImfTHKszIEF1rX+og0njtMk32OFQhTIcsYOF6IXYh
 +6KC2PRljX0hTPmrlGZXX+TGS6OGnwoOsv9/b38J9379oK15kkQAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713454514; l=4253;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=aWFOpvJFMYnINTLSgA8EmWFpPZD1N9z9ko3OaW3FO0s=;
 b=ceuTtDABfUSLzYf2CRSwGuud4p4cuWrQU3NDG+3/9Fh1WFboCi8npyDanVy16X4bm3115UDeH
 E8VSTzhqKOICfY/OmtzC2B3WNElH4ayYkjRoTEAoipcdHHl87Oty3fh
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

When an ethX port is disabled in the device tree, an error is returned
by xdp_rxq_info_reg() function while transitioning the CPSW device to
the up state. The message 'Missing net_device from driver' is output.

This patch fixes the issue by registering xdp_rxq info only if ethX
port is enabled (i.e. ndev pointer is not NULL).

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Link: https://lore.kernel.org/all/260d258f-87a1-4aac-8883-aab4746b32d8@ti.com/
Reported-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Closes: https://gist.github.com/Siddharth-Vadapalli-at-TI/5ed0e436606001c247a7da664f75edee
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
When an ethX port is disabled in the device tree, an error is returned
by xdp_rxq_info_reg() function while transitioning the CPSW device to
the up state. The following message is output:

[    1.966094] Missing net_device from driver
[    1.966154] WARNING: CPU: 2 PID: 1 at net/core/xdp.c:173 __xdp_rxq_info_reg+0xcc/0xd8
[    1.978064] Modules linked in:
[    1.981113] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-next-20240417 #1
[    1.988494] Hardware name: Texas Instruments AM62A7 SK (DT)
[    1.993944] mmc1: new high speed SDHC card at address aaaa
[    1.994051] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.000135] mmcblk1: mmc1:aaaa SL32G 29.7 GiB
[    2.006459] pc : __xdp_rxq_info_reg+0xcc/0xd8
[    2.006468] lr : __xdp_rxq_info_reg+0xcc/0xd8
[    2.006476] sp : ffff800082babad0
[    2.006479] x29: ffff800082babad0
[    2.015506]  mmcblk1: p1 p2 p3
[    2.019500]  x28: 0000000000000440 x27: 0000000000000001
[    2.019510] x26: ffff000800c10880 x25: ffff000801f29480 x24: 0000000000000000
[    2.019520] x23: ffff000801f30000 x22: ffff000800c10080 x21: ffff000801f28080
[    2.048687] x20: ffff000801e69800 x19: 0000000000000000 x18: 0000000000000028
[    2.055813] x17: 00000000cd537234 x16: 0000000046cc0f2d x15: fffffffffffe51d8
[    2.062938] x14: ffff8000826020f0 x13: 0000000000000396 x12: 0000000000000132
[    2.070064] x11: fffffffffffe51d8 x10: fffffffffffe51b0 x9 : 00000000fffff132
[    2.077189] x8 : ffff8000826020f0 x7 : ffff80008265a0f0 x6 : 0000000000000e58
[    2.084314] x5 : 40000000fffff132 x4 : 000000000000aff5 x3 : 0000000000000000
[    2.091439] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000800110000
[    2.098565] Call trace:
[    2.101001]  __xdp_rxq_info_reg+0xcc/0xd8
[    2.105004]  am65_cpsw_nuss_ndo_slave_open+0x358/0x8c4
[    2.110137]  __dev_open+0xec/0x1d8
[    2.113533]  __dev_change_flags+0x190/0x208
[    2.117710]  dev_change_flags+0x24/0x6c
[    2.121539]  ip_auto_config+0x248/0x10b4
[    2.125456]  do_one_initcall+0x6c/0x1b0
[    2.129285]  kernel_init_freeable+0x1cc/0x294
[    2.133634]  kernel_init+0x20/0x1dc
[    2.137119]  ret_from_fork+0x10/0x20
[    2.140688] ---[ end trace 0000000000000000 ]---
[    2.145443] am65-cpsw-nuss 8000000.ethernet: Failed to create XDP rx queues

This patch fixes the issue by registering xdp_rxq info only if ethX
port is enabled (i.e. ndev pointer is not NULL).
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index bfba883d4fc4..022942281767 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -391,6 +391,9 @@ static void am65_cpsw_destroy_xdp_rxqs(struct am65_cpsw_common *common)
 	int i;
 
 	for (i = 0; i < common->port_num; i++) {
+		if (!common->ports[i].ndev)
+			continue;
+
 		rxq = &common->ports[i].xdp_rxq;
 
 		if (xdp_rxq_info_is_reg(rxq))
@@ -426,6 +429,9 @@ static int am65_cpsw_create_xdp_rxqs(struct am65_cpsw_common *common)
 	rx_chn->page_pool = pool;
 
 	for (i = 0; i < common->port_num; i++) {
+		if (!common->ports[i].ndev)
+			continue;
+
 		rxq = &common->ports[i].xdp_rxq;
 
 		ret = xdp_rxq_info_reg(rxq, common->ports[i].ndev, i, 0);

---
base-commit: aa37f8916d20cf58437d507fc9599492a342b3cd
change-id: 20240418-am65-cpsw-am62a-crash-2e87ae0281f5

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


