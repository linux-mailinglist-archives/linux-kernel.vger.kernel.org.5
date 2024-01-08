Return-Path: <linux-kernel+bounces-19941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53D9827725
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B881F23A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4F5576C;
	Mon,  8 Jan 2024 18:16:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76254FAB;
	Mon,  8 Jan 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28ab7ae504so204140166b.3;
        Mon, 08 Jan 2024 10:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737799; x=1705342599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1OQkRuN6jb/zL9MYD1CSwYj1/9CReesJ8A53XGFjNI=;
        b=I6IJTzzSvUmRGtSU/QBMDSN8gAh9I4h/A4bTYpXUKiK/wk3QZuf4gehvUgf7QFnhdi
         qQCKaJSZ+9TXBBr2VlAVIxgSgQ17Edv3DvgkIH9YtUzK3r1KLWSH7zLirwrfzfGR5vGn
         OtupcImHv//XRK8+4XPrvbXrg+cdksXipUXnp53l6uqKoWxuqjCfxwVGGQevDpVhXvRt
         ovH18IWay/PmR8NZUVr9p3KwWygkS8WQSveC3vRS3OW6nzDp7pBi5b6Yrimr4IT/AJ/I
         NJ0jiBXf3ELJ9uYNjj7voWBN5SDIE+DBcPAl1anM8Fx9BjL7kjf2jPW7ZRPXOICcMwHL
         Kwsg==
X-Gm-Message-State: AOJu0Yw1ialkvMxqJg7fejGm8ygtHr5ngOa9mo15BUEhFy7/62oD7snq
	Gkvjn0jLtd4NGxmXBvmAy78BnT8VdqRUpA==
X-Google-Smtp-Source: AGHT+IHB1L0xCsBetZbgjF6QwFM0RZvnUnDuCkRzeGugiG+cCaELv6pU77OkHlh6/xTubM+YscR8Yw==
X-Received: by 2002:a17:906:eecb:b0:a27:d1c5:906 with SMTP id wu11-20020a170906eecb00b00a27d1c50906mr2049728ejb.60.1704737799026;
        Mon, 08 Jan 2024 10:16:39 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090617d200b00a26e490e3f2sm127138eje.181.2024.01.08.10.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:38 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 02/10] net: fill in MODULE_DESCRIPTION()s for SLIP
Date: Mon,  8 Jan 2024 10:16:02 -0800
Message-Id: <20240108181610.2697017-3-leitao@debian.org>
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
Add descriptions to the Serial Line (SLIP) protocol modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/slip/slhc.c | 1 +
 drivers/net/slip/slip.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index ba93bab948e0..18df7ca66198 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -752,4 +752,5 @@ EXPORT_SYMBOL(slhc_compress);
 EXPORT_SYMBOL(slhc_uncompress);
 EXPORT_SYMBOL(slhc_toss);
 
+MODULE_DESCRIPTION("Compression helpers for SLIP (serial line)");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index e4280e37fec9..0aba3569ccc0 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -1437,5 +1437,6 @@ static void sl_keepalive(struct timer_list *t)
 }
 
 #endif
+MODULE_DESCRIPTION("SLIP (serial line) protocol module");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_LDISC(N_SLIP);
-- 
2.39.3


