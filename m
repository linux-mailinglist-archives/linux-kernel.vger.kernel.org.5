Return-Path: <linux-kernel+bounces-112622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC0887C1A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6983C1C20FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B3168DA;
	Sun, 24 Mar 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx6iJLVJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4315E96
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711272732; cv=none; b=c73wHXoAefrxVzRE3tcRIYIPQ9RfdfPDsH9ewiUmNxuhVvi9UHOK/GVtOJhOs6HekNOcyAIab+q1Tq6ndfYK0AFUAfj/qGcN4rquCRztt3VmiFkekDEJzQHh1caP7kVuw/qE7B11BT5PRGuvMAOk3pDiLIwVnnXbhLej0eiNm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711272732; c=relaxed/simple;
	bh=jOF9iZgUd7g+X27X7gIr9Y8B69O2z7nBsgy0A/k1qYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sH3ii4CRrY+hmBia5RKwPCwGToV1x34ntVz7UFak6VAnton+BO2/9OpWQMfs7hIFqQF7CrVR8jBtp/7+35KKdWIL8VtZDwYr8rlJeKEmvm1ONhqumhpGQih04gBVX2tjk4ZsiuntL9wOt0B5bwbBR3M0RdRJKlnlqS/1SMrlM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx6iJLVJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41488d6752eso588205e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711272729; x=1711877529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxbGaOtsAwJ/zarjDamCe/HbCO2cHZVNxWTbIWGUDKE=;
        b=Nx6iJLVJAAIjysUcZkYVsnvishidpNWzd4wvHTxxeOprt0dY+HBMp30lJiq/Fv+12T
         cFzpL1YzGOgbUpiXnAYUT9RyoT8b332F/2pyVFLCGgO4K42u15WkBKT90+OkTsXZhekZ
         GmBKSJmgYp0My3yduzgQsQ1jL99L5YDqlf0TvmVIkUZ9wZ6oBDIZJLna14ffPUhjdpOE
         EnrtbmO3cFGyVV/3ZjbjTxZT/sBdSVo/9/CJqwxB0eM6gCRwAPBNL2M8jhnlIRfK8VKH
         WlC1rFn2GshM3rYVDE1bM4zDkJ3gJgy0eYk8rhaoPSys/7rR4mPPtYK9kHidin9o+gNe
         a4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711272729; x=1711877529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxbGaOtsAwJ/zarjDamCe/HbCO2cHZVNxWTbIWGUDKE=;
        b=p8EZJQ5ePdCidwFgezo7nkNrjnxU0xmWIzcHqE5Ia+Tqj6g466QCVkTV5CV407G2iB
         WPYKDrf2Fc+XsmHKty+Dmz3mFHQh4dn7r24/ZLQWdd2DBzMa3G8hBbBg7x49VAfs2yjD
         nv5O530592mlsPCcwqLoBkMVid+Dn6Rdl2Li+eiDNQDChvvhgMqwUbpIGI/dCK56bH3q
         cRXovz8zY9dR+GYYG1x/r0a7PaU9GVuLJt2JOBeWA6RrAubnbbeD/XLLqNGwHdBhqOpn
         NZy6xAHNP7f8jlI7+uX2lR4TscYTiOIp9xPKbqjoed2Oo+/Jt5Y7UyBj4QC7fPYN3fxd
         Bmqw==
X-Forwarded-Encrypted: i=1; AJvYcCXY8YbdsMEzpANC/wi1gVmHxwn7221MBBYh95u4HB+1WeP/nzRj9Fry8ksNejFCcBN1BlM7tqrYUSTQCLk5mrLXUHxOkc9VuqrBPkyr
X-Gm-Message-State: AOJu0YyGFekXIRISgvO6vMvDzsJFXQ3w1cmI+7cAqWkP2gUN9oTremBC
	ePFfbHJLsvyJP9irO5ePwsUCgBKZWB3LufVmP597+pLxHy8+QfRt
X-Google-Smtp-Source: AGHT+IEJ00xSkWWq048VudCmTvl9Uw5e9k7Kpq3UgGHjtCokqFMwGQDp0pWSO2uyJEawjqO6f6Dm+g==
X-Received: by 2002:a05:600c:474b:b0:414:8948:5f88 with SMTP id w11-20020a05600c474b00b0041489485f88mr66330wmo.0.1711272729177;
        Sun, 24 Mar 2024 02:32:09 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:42b5:8c78:fc9d:7600])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b0033b87c2725csm6490711wrb.104.2024.03.24.02.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 02:32:07 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: pi433: Fix includes & macros.
Date: Sun, 24 Mar 2024 11:31:58 +0200
Message-Id: <20240324093201.793485-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Untangle include hierarchy. 
2. Update #minors the driver can accept.
3. Make use of general macro instead of magic number.

Shahar Avidar (3):
  staging: pi433: Use headers in appropriate files.
  staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
  staging: pi433: Make use of spi mode macro instead of magic number.

 drivers/staging/pi433/pi433_if.c | 5 +++--
 drivers/staging/pi433/rf69.c     | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)


base-commit: bfa8f18691ed2e978e4dd51190569c434f93e268
-- 
2.34.2


