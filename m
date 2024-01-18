Return-Path: <linux-kernel+bounces-29919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00B83152A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0ED1F23720
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9A1BDFD;
	Thu, 18 Jan 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eoaQ1rq7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B21B96A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568089; cv=none; b=a8IzauGjfRtWMytms1vSQFr4tIJ6rV+t9VO9GcQUz6WVO7vZSt9AFjKLyHVUlAZUF32pCxkSoAi0s5IdXExkqoQxxzneYV0sL1Rr0cqC2rq4pRKCEf/8RQtdOmLrQNX6AhF0oBoCqz7cnfHcUMWksPzGzP0uf00+0qJbeapo2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568089; c=relaxed/simple;
	bh=MCxZ8z07WUK2BsrAfJ6Bu00FMqAk5lxvFXxpvD9oRSk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=B5jL1FOteiKWtp2Ok5bMh//s6nJjkU55Hh2JfDT6bXQ0JjZYOhTlYnkv/ewp+4Aw4TchIRyB44aTRSOILpXoHERw8iTHWEyuU/6czloYM0qvwwbOWUr8uPuT1935UI2+CkUrx46lKq5ylC25977i+kemH9i+iINB8EFTNkVQQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eoaQ1rq7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d5f10052easo12768615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705568088; x=1706172888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oz9mVOu+ad9eAvvgLiXYxdC8+oSkbRkyUjyWQjx33yM=;
        b=eoaQ1rq78eTtzh0wFOS9Tz2aySgv13PGt+7LqbFZ58CqGGbyLnBm/JLNfMTa+fnqaj
         UkoqWg0ZR5VQdEGutJsZNYQMt2hKnQgbYSo//p5u0QIhXYnGv4hHZIxnH5r5Vw8BFaFM
         b4FV9RVa5L7OM8934MXFkCgDfeN9Wakj4eduM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705568088; x=1706172888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oz9mVOu+ad9eAvvgLiXYxdC8+oSkbRkyUjyWQjx33yM=;
        b=i23VjTFolcMAr7lUnQ91cUHws8KA5A5nhDYdiAYnVAwIR3HMsO2CQBLYEIXJNdI82r
         CSAKPEOZFjMdvA37AgcIfVE89ck7RmyG8ZX9DkQj2jvn5x3jY21yN2WqpMMsJTXhNNsS
         w94EvD6bpIJUhK2qbqu5Mvn1ozgcbkrYDS5+19WSHeL4OX5mXlYucdyTuRaEji+HStn7
         O5y+24zuHt8yf0U2jw1HVyoyGM3sY3fSDEINlDtFWtLpkY0gwgaz0gWy0eLY3MhBKmSq
         MugR6RX/Bx7YtoxA24dibUfnBE6W6pjwT1dcVgZRvzWlpEzNVpcYDdCaHnZ5fNy8ZMHk
         RRkA==
X-Gm-Message-State: AOJu0YyUwxCI1nYu9uw4cQObWPDQSS7Y4CkvY1xTIn8F2SzL1DDrxexV
	cFho9OC3e/NnZRdbzQh/7X8Nk+0fdNxwtPobPjGeT44bbBEi34PC6g7icEydX2a+bp2oVbMws1f
	VzQ==
X-Google-Smtp-Source: AGHT+IHLBlmDFJj4oPMADbmRUKL9nH9CY9T4nkMaGF60d4eQZV9wC6gpHKuBd5hsyMwfFMYc1IoExw==
X-Received: by 2002:a17:902:8606:b0:1d5:845:da16 with SMTP id f6-20020a170902860600b001d50845da16mr467559plo.126.1705568087823;
        Thu, 18 Jan 2024 00:54:47 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:6a83:9579:c455:9664])
        by smtp.gmail.com with UTF8SMTPSA id kf13-20020a17090305cd00b001d0ca40158dsm912379plb.280.2024.01.18.00.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 00:54:47 -0800 (PST)
From: Ting Shen <phoenixshen@chromium.org>
X-Google-Original-From: Ting Shen <phoenixshen@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: fshao@chromium.org,
	Ting Shen <phoenixshen@google.com>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	chrome-platform@lists.linux.dev,
	=?UTF-8?q?joewu=20=28=E5=90=B3=E4=BB=B2=E6=8C=AF=29?= <joewu@msi.com>,
	linux-input@vger.kernel.org
Subject: [PATCH] Input: cros_ec_keyb: add support for base attached event
Date: Thu, 18 Jan 2024 16:52:43 +0800
Message-ID: <20240118085310.1139545-1-phoenixshen@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This CL maps ChromeOS EC's BASE_ATTACHED event to SW_DOCK,
to allow userspace detect that a keyboard is attached to the
detachable device.

Signed-off-by: Ting Shen <phoenixshen@google.com>
---

 drivers/input/keyboard/cros_ec_keyb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 30678a34cf647..d2e0d89d4ffdf 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -128,6 +128,11 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
 		.code		= SW_TABLET_MODE,
 		.bit		= EC_MKBP_TABLET_MODE,
 	},
+	{
+		.ev_type	= EV_SW,
+		.code		= SW_DOCK,
+		.bit		= EC_MKBP_BASE_ATTACHED,
+	},
 };
 
 /*
-- 
2.43.0.381.gb435a96ce8-goog


