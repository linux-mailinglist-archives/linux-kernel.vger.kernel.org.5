Return-Path: <linux-kernel+bounces-126775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A2893C93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9A51F225A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9984597C;
	Mon,  1 Apr 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fZaW36wF"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30C4653A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984208; cv=none; b=o1fg5HEnMzaIwMqKUt2mvQcyyPt4lv6P1vDkVapT2v6v63g30CLhtU+Qs8z86KBZ4HmamYWrYhxmJqejBX3muMsb4EMow0+RmyxvpXZigpvWkTSwONyp0OBnMf/2NAvunVdaa2fYlkmwdrt1YRiYb7LYxVHxmkpZOwp+x+TWR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984208; c=relaxed/simple;
	bh=Yi05bZlr3S+bK6PgvEQ75C/AE3jftkZgNZvSQjHaCW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iE9zSJ02n1+QSOTbfqaQyE6CeH/21wzRa7q2K6uycjz1sewUphD7nIPiUkyoZkDrfyyNH12ezAIKqcAQx5KnbyM3/PrUARFzI4ZzOhAvgEMgC9WLBHlk8deJEIrRzZUQrf0AwjTv/yRCOlefUxuGafZEhGrWfghN5i/D91wcqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fZaW36wF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22a1e72f683so3148388fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711984203; x=1712589003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQFlUQeyKWFDWLBpqoob08XtJp95F+fDHik08zWnRFQ=;
        b=fZaW36wFLPfy1OFNuM52Ig2pnM08D1EWktKuliUUupi04+0WHKyrEVc5+NDoc7Renj
         TWhI5AtMg5gOWw+9pfJA2smbqqvIMdSZFtwW+V23ocHe9qiMtkuoPksatm8j40bEf2Kc
         qDDirLBLvJtI8yJXPAoTPBiMNpR8WOyw5TWaJ+sVrKm7HOGpxerpLhS7VNIMR+1gkW4Y
         BiL2ay2zS9wnIGdU0DKL2oIuM9rIVcvPB1yq0fJcjWv67ZGT0PPmmdMKzdoWFV6nzCha
         i1SlKsuvxnUH4aPLKnaikxNZ+x8gWBb2y678kMjfAq6kQJF6CIOHNAIjX8bdUQKeG+Mj
         jVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984203; x=1712589003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQFlUQeyKWFDWLBpqoob08XtJp95F+fDHik08zWnRFQ=;
        b=WlQ0Js1oc3jgZJycJ64ZNoDzRfcyChefyQpuvfO1lv17CLHHpfkqti+BaPd/hZn0Q6
         SwuT37iQRt7owzFpolamziVprgCmeQDUzwxdfc2VvMtS/gBqV6SytiXg0cbNo87Y8azI
         vdJqMxhLOFWt3F9TlCLYWF67Lysx6lIr6EGORMJWviwt3zKqJql6ub5w4fx2foX2/Sgp
         gOVPx969Egb/S1PpchGDh1I3lIyy5BLeFnNCfuGLn8xBZVi2ucSU3eVHqeQBr77p19Dc
         w7YyAt1pCcf9DwXPvSy9Nd4LJ7Lqqu5XoxoRufjgn7cyZ/HdP9nO7gOCsCoLgIFALG1R
         vTTw==
X-Forwarded-Encrypted: i=1; AJvYcCXnxsPuj4exTM8kDDQN+6POIIlLXsyLluUQ/atd5TV+krOOAWr7acR5VyY7daGltL1ZUdZkqAar74wNC6rJ4Of3qGuvyF5t6IewNgFh
X-Gm-Message-State: AOJu0YwBCY99IGpdSbs8FEmsEmzBrhXe4mO1ifsNai5sLPwJHVdI3XlG
	OLo7SRd1NfgDPRZT5h11yIQoCE8AfXUwG3qrWUYnkfRUUMWigQC9zgNbLnbuqKU=
X-Google-Smtp-Source: AGHT+IG46vil8V+QX6v3m1ld79YQdQe2MsqNEZ3wOUmMBazrwxw5yn2Y+XRVOOoqP0m2sTdp5+bcMg==
X-Received: by 2002:a05:6871:741a:b0:229:cec1:cbb8 with SMTP id nw26-20020a056871741a00b00229cec1cbb8mr11814398oac.3.1711984202793;
        Mon, 01 Apr 2024 08:10:02 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id d5-20020a9d51c5000000b006e67f654617sm1957534oth.23.2024.04.01.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:10:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX
Date: Mon,  1 Apr 2024 10:09:46 -0500
Message-ID: <20240401-da850-fix-select-da8xx-v1-1-a348ab91448f@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Chips in the DA850 family need to have ARCH_DAVINCI_DA8XX to be selected
in order to enable some peripheral drivers.

This was accidentally removed in a previous commit.

Fixes: dec85a95167a ("ARM: davinci: clean up platform support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 2a8a9fe46586..3fa15f342240 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -27,6 +27,7 @@ config ARCH_DAVINCI_DA830
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
+	select ARCH_DAVINCI_DA8XX
 	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA8XX

---
base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
change-id: 20240401-da850-fix-select-da8xx-989725eec11f

