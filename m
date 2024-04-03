Return-Path: <linux-kernel+bounces-129160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACB896634
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A592E1F2428C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E776D1A8;
	Wed,  3 Apr 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="JdueFn8D"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6E5A0F3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128911; cv=none; b=NTJS5LxbJJxfGwWkszGB9r/GWq4PvcoPM/qM8AtvHKBlQMItsi6P50s0xHHyTHPWeg4gsKBh4oa2gURwmApiGQk464bLd/mpAfX8+OttXxDTvmTAROcXjRlD0UPVttaP/IYKvHw0S/sHVle2I2PpPERfEgsGYVj7/YHsq/8IFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128911; c=relaxed/simple;
	bh=Khyeg1/xj46k+x5xR7s8vWgC8Y2GcoM7MOqDayZ6owQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj+Xqmf8pU0FX8BEv6cbL51iE80u4YTw17xhVTykOR1adi/tZrsdP009488geh8OqR/k7+MjwFXWs6Jn50aImdmECG6aXpTw2E46pn1FBIP/k/MvhR8g4vUgLxGTgZAUAOGz+thdXxB+mdOE41LMT2zgV/ho7q5XJLWXwIN2z4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=JdueFn8D; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41550858cabso29545565e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1712128908; x=1712733708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9xm7Qk02wEciH96RlDxlZxQKfuGKusC1XnJuVX2I7s=;
        b=JdueFn8DOrllCF00jh7MZOpnWQ1lhXI07HeDguULMBqeUVFmYd0LdOLUnTcaFzDa9A
         fazroUBnovKNuscyPO4FCLe0JeX3UGKiiFODXPRNspid68bsgjq4/Lbbb6AFzYk6ywQ4
         SBm4k2Gn32Ge60qG9f0JhMyyag9WvGrF5f08YivMgWXoXtMD+vohf+2i6bOhkJyf4bG0
         hL3R6ZJp5c8R3WAkDuasakh8HZJPWC5n6iRvPheE6W2A/pkwAyJj2+wb3Dg22p+fIr9k
         ++8mkLDiq/kTE4jgEWSkkLk3rMbYUuwcbg9BSsKvZGZP6/sy7RT7K+It3kfoOurfgTJ/
         ZWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128908; x=1712733708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9xm7Qk02wEciH96RlDxlZxQKfuGKusC1XnJuVX2I7s=;
        b=bV5sxnJg3cxSNPXv0NgOtQiO/7lb3dwAKJlXAOQkQ3QYYQ5j5mqJsZAg2vviBwAihn
         jrMMYwoLCxXGRM449RLBSsYb4ncYI+7/nWrXZ4XxaIf/SuPzMYTMCOAgQV4EdTu2VSvU
         cA+PmrEsxwkAQsZAdY2zdWRjrvu8TAUuyvPNoEHcgtsUuQnvr5Z1AxGBW0Y3v84rAvNk
         5uITka2ph72xvM+tE7cSV3VoAhrB8mOqEYkvWYmVZSDMNl4F1EwPl3SrHcB2OcHDq2xI
         Ii4gw4rMHK7IuhKisAdFT+K5sapNH0LNqSL5eokW/B001OTpD2eYhUcTrXjzFKEJtm2O
         AiZg==
X-Forwarded-Encrypted: i=1; AJvYcCWm0egmaiLwUtphl1UYtdRqPd7hXQnyFQJSNug21QBQeQ/p27qdPuuApWLG8B8isL91Xjcv6GWFG9OsBwW8e8ngakwHhS08oFWQPpuS
X-Gm-Message-State: AOJu0YxLOJ4HshyP1gDOgfMPjaY5J+25qrFpOdwSufjLS8sMgCo4ldxb
	QVpr3MOK7+YFVd+jEo+a5ECZ4vBO07vR4JiJMZJCk+yj7IsSfkz/pbyRWl6mM6w=
X-Google-Smtp-Source: AGHT+IFwfWGPzmjOkZpQ5g13bjj6w//ru+uAqGOIDa7Sctmy6coY4cw7BXdzp+Ags4F/9A/eZ2BqQQ==
X-Received: by 2002:a05:600c:3c92:b0:416:2181:bcaf with SMTP id bg18-20020a05600c3c9200b004162181bcafmr930669wmb.1.1712128908083;
        Wed, 03 Apr 2024 00:21:48 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id n30-20020a05600c501e00b0041621b3cfa8sm1724904wmr.6.2024.04.03.00.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:21:47 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 4/6] MAINTAINERS: add entry for DCP-based trusted keys
Date: Wed,  3 Apr 2024 09:21:20 +0200
Message-ID: <20240403072131.54935-5-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403072131.54935-1-david@sigma-star.at>
References: <20240403072131.54935-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This covers trusted keys backed by NXP's DCP (Data Co-Processor) chip
found in smaller i.MX SoCs.

Signed-off-by: David Gstir <david@sigma-star.at>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 976a5cea1577..ca7f42ca9338 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12019,6 +12019,15 @@ S:	Maintained
 F:	include/keys/trusted_caam.h
 F:	security/keys/trusted-keys/trusted_caam.c
 
+KEYS-TRUSTED-DCP
+M:	David Gstir <david@sigma-star.at>
+R:	sigma star Kernel Team <upstream+dcp@sigma-star.at>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_dcp.h
+F:	security/keys/trusted-keys/trusted_dcp.c
+
 KEYS-TRUSTED-TEE
 M:	Sumit Garg <sumit.garg@linaro.org>
 L:	linux-integrity@vger.kernel.org
-- 
2.35.3


