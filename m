Return-Path: <linux-kernel+bounces-19945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FBB827736
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987E81F2099A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7955E77;
	Mon,  8 Jan 2024 18:16:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A155E67;
	Mon,  8 Jan 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so2371030a12.0;
        Mon, 08 Jan 2024 10:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737815; x=1705342615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSw5SvHccqbRf/pikKUBURIR6qjS3hHMkgDAPoX96gU=;
        b=O1cuVcgItPH61ekcB21nUxRncsd/yMaYh2XFP5olg89e7s5AtNCk3C/jMRnHlODpbf
         oaFxxkObMElE+YqP4LJuM7bpbzKtdwAM+09MTq7oO1BMPeXmZg9WwQZPaAvvBBnwVuFS
         DXlphCU4gEvpgqBuXEsshzFUctQBckjrEqp97ywtGQuEOQCwav3Jivp/XvFpetrZySeH
         RsbiDfmJNzmhSaUg1KPmsEsbzHM6Dmao97pVVGkBVaYAtmARrl+QlsVXSY1b2+06uqXl
         GfBIaNKyEvkYk7bfzurOQz2+Xk2xRdlAKdR8/uI/azfmlN3vKd6gVui6Snn+HpmnNDev
         u3iw==
X-Gm-Message-State: AOJu0YxMlN71QMettrBtiFkX5x4+ivTo5y7TlmqocDiExmb8ToOJ/GEr
	nH1zT8KCpTA1gofJa6w8ZVxbl2ZXhjddiQ==
X-Google-Smtp-Source: AGHT+IEEpZQ6KeDtU3VLi7tFsU3QPmGoePMhPKyXBJI6ebmOscraR5Z4z8dHPLT2c0snawLI8qCT6A==
X-Received: by 2002:aa7:ccc7:0:b0:556:7cc8:e735 with SMTP id y7-20020aa7ccc7000000b005567cc8e735mr2304162edt.60.1704737815050;
        Mon, 08 Jan 2024 10:16:55 -0800 (PST)
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d98b000000b00557556858ffsm90318eds.60.2024.01.08.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 06/10] net: fill in MODULE_DESCRIPTION()s for ieee802154
Date: Mon,  8 Jan 2024 10:16:06 -0800
Message-Id: <20240108181610.2697017-7-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to ieee802154 modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ieee802154/6lowpan/core.c | 1 +
 net/ieee802154/socket.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 2c087b7f17c5..b88f6a96d961 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -280,5 +280,6 @@ static void __exit lowpan_cleanup_module(void)
 
 module_init(lowpan_init_module);
 module_exit(lowpan_cleanup_module);
+MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network IEEE802154.4 core");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("lowpan");
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 00302e8b9615..db8df6e26159 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1137,4 +1137,5 @@ module_init(af_ieee802154_init);
 module_exit(af_ieee802154_remove);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IEEE802154.4 socket interface");
 MODULE_ALIAS_NETPROTO(PF_IEEE802154);
-- 
2.39.3


