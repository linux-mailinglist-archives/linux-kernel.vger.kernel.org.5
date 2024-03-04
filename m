Return-Path: <linux-kernel+bounces-90902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDD487068D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91C51F2648E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258FB4D134;
	Mon,  4 Mar 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ojILu51K"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33624482EB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568418; cv=none; b=SgHv+sBM1hLg2Ce0WkUhSOyjq1Nm2Geg/2RHpx48JctYbT5Anm4jMWoLuoVBLIEsZLDzXn0rGnikZ2pjHaU097WGBYVLjT1B3eK/Rov4jsNIlGlXqoEzWBbL9oLoaQ7ubeYgnC2VIyDWktuvKvlk6iqCFCghQ7X1uDH3gH8iyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568418; c=relaxed/simple;
	bh=5hT5wjsUvej4t0PzrwkFZZddS5utw/QYaLNNX9eOC0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXQouBLPb+gY1cPBuCXjrhHC5XA+MckuvVfTwNyKg0AxA3OZgyvJbJHinSeB742UyQvJ9JDtj8t3Pe5xfxCwFp9/w6fB63nFWKbI1gHODZtEC+sJ4KWtaoeAe2VpGnQvPUvG5CnZLUZGXkMVSDfCoUecYjLvLNCmLPpPzDL1cnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ojILu51K; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2210865d962so911718fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709568414; x=1710173214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47S4ZgnBYo9jKRg+1Qx0IpWuTU4W29awdHsHBhIR8G8=;
        b=ojILu51KDxcLa8wt1MuvwAZ2zY0s/ZInPDn+TrUK5FsoZzwbXRJdUlVEgu9z4czUXm
         /XNS6Eyqxw2xa11MkN2Fn8w1mJdPgPqTH2NWyrNGddt8UjFpB8si9zCM9xVY52D3VMYY
         rWTA7E5TXy89VWoBTs5KmQkkkkKwMZYYEmR2K37Xy4o/t7JEMtqCkqtCFahzYYfBnkQp
         3zK6rfVRLI0yzWsZ1KLlGTQ9F3RLoXYAdvQm/r/FEosbIFN4NUPfnzwsWjz4+7LGxYpM
         0s0DKqrfF21G1/xVQ89lbHPuIG9JqV7oUtTAorFMyEAF5LtEXzrnDqr62iT2RORfUlm+
         Hj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568414; x=1710173214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47S4ZgnBYo9jKRg+1Qx0IpWuTU4W29awdHsHBhIR8G8=;
        b=uA/uE1KqiGroRDWsKlZev4oHzWG8CgOdR7V82CGirehHT0QiinoDfkaSZpi41nkKXk
         P05psFZhOkrdSloYgHO0TP4v+FN7ao8Z/IF5FGYGQ+a75QwIm5xXU7nPeyEOChq+yqQA
         L6ubwQAIA8u1maDbKdrRVIfArvURTFNUAv5Twc6D/tii7Nzvt9vX6BdbSv7H7J+n7En2
         0UfRY+4S8GNa5Axiw7DHhNfI1NuNzuL+UdpehQVePV0Ip0wVypSEZMrOJ1X3HXxFzgok
         0dI79VwYqW6lZJspfFXAiubJ6tehn8VMaJHmDkP3Xf73ZAXCPNKcHccMPya33Uex+q0W
         XK/w==
X-Forwarded-Encrypted: i=1; AJvYcCUG2MmtlZ1tKa55ax4zIpsu6RQc6j4FzSx96DNlJRwnlS+toWO3gc7HrUrIQg3s+E3uWMRA2xGiF3DZmXAzfxiQHA1IZ5qOy7eTZYGc
X-Gm-Message-State: AOJu0Yw6T47+t4Sxt92b2LvduGL+pJocj3KeFp7jY/0IV9f4dIEVJXcb
	vv1ZONTEsgMHH4Bi6DNcV8HTCYeynp9ikKjbrDaNZun27ShHR0guUA1S2zbahyo=
X-Google-Smtp-Source: AGHT+IHnUujhgYRoulUU9Ki4jG7rgvaQB6rYriALE46IC4meCxLSw11sUvrfGLvhQczpaNuwleJnxw==
X-Received: by 2002:a05:6870:37cd:b0:220:9862:a2dc with SMTP id p13-20020a05687037cd00b002209862a2dcmr10440444oai.57.1709568414246;
        Mon, 04 Mar 2024 08:06:54 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id lu6-20020a056871314600b00221287ebd03sm83392oac.4.2024.03.04.08.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:06:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/3] spi: axi-spi-engine: remove p from struct spi_engine_message_state
Date: Mon,  4 Mar 2024 10:04:23 -0600
Message-ID: <20240304-mainline-axi-spi-engine-small-cleanups-v2-1-5b14ed729a31@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The program pointer p in struct spi_engine_message_state in the AXI SPI
Engine controller driver was assigned but never read so it can be
removed.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 6177c1a8d56e..d89f75170c9e 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -82,8 +82,6 @@ struct spi_engine_program {
  * struct spi_engine_message_state - SPI engine per-message state
  */
 struct spi_engine_message_state {
-	/** @p: Instructions for executing this message. */
-	struct spi_engine_program *p;
 	/** @cmd_length: Number of elements in cmd_buf array. */
 	unsigned cmd_length;
 	/** @cmd_buf: Array of commands not yet written to CMD FIFO. */
@@ -543,7 +541,6 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 
 	/* reinitialize message state for this transfer */
 	memset(st, 0, sizeof(*st));
-	st->p = p;
 	st->cmd_buf = p->instructions;
 	st->cmd_length = p->length;
 	msg->state = st;

-- 
2.43.2


