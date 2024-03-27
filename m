Return-Path: <linux-kernel+bounces-121936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF7188EFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873DF2A3F97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DB5153514;
	Wed, 27 Mar 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="apkzLDLG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5D152E04
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569725; cv=none; b=cd/93qCZO28lRTmYiE8FrC7f/6hczPpiITOemFmrEffBjd0x2RcBPgcvIU2yR51vtEieU0u04zeY6+ldjY1MNPU1pAEDvOlFf5cDhVHhvL1qkPo3vjaK1YMq9ZVrQd6XjwL8qtGnL2OrWxrw0yrqHVKPyUIwLiey7YIaNzITW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569725; c=relaxed/simple;
	bh=JFTn7HBH7Lnt1aUxkwHzbnUdwmlaZ5Y72ysNp/iIKHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlwzHY7GA9qnLIIHFwXHVSI4aJqMsdpjAg/OgB1wewJZHIgHRZj3yik25NrVllxppYvynkX2izCSgl/9csR19fuaocMe7APB1nPGAD89EesoWb4q6Ud4lqtagJtm7I4k9JoCSQTLZ1o+954ZsN2VOg3HPrnDLag4zsvMoOsIWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=apkzLDLG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0b889901bso2370145ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569723; x=1712174523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3VQJildZHY1Bgj6r2iljFMqpw+vWq4Si7He8vtNBY4=;
        b=apkzLDLGri6I/KIu6YyYeNeivENKcZhXqyTQ5B52eDguME+M/+R1oHSdZrROI0i04B
         0VJt7pn7h55cg0dZGji+nMVzki38fTRq1MdnNL96YNgWjk+GJzShG6PT4CGarKHo9P/V
         1PhKr4QeI9W9EMTfb5deKTeuwTBZTb6ygW/ll7+pFVucrfka/OCwbxnEBA0cgfRl1041
         VrXn0q/fjgO2ErN5NrYS9IQRmq5n6G/+vIayUDWfKkC48Q3Fsca3hjEZz8b/AEOsaZnX
         wTBLb0k09KZpmjgReW+NThiYtYWINmAX8PGpx6GMPecfy6EtkBRkXZ5Qc3KpQjb9TDWe
         3xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569723; x=1712174523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3VQJildZHY1Bgj6r2iljFMqpw+vWq4Si7He8vtNBY4=;
        b=ZqOOOUjk0wsxvqC6fd1kiWJD39U8XBwpIYqgZiRHOgnLRzEnTEiLMlnNy0tF3AkMwI
         fst2Ty1XoDYOGFBJRpI0gLy6i39HIsmsOHIB2u8VHfQD67CGVaH4Q/SYdQjNt+lXuMkD
         LSMuVUcO8+ApKnr3anj/06rsmHvqPdnJAeWy/ID0sEq0aKYA8Tw1S66KWM+A86tkDlLG
         7ku2dDZRXWjtbf9D9fk0nMRwLDanPKKrqKAsY19X7IElfCSFAP/ZHmCN5eWjTTZlN7AJ
         WowuZt0zjMPBl9+r3OngZGuv7RFqHrTOUddl56s05i+sXvv0R+eQXtmAriVBwntZwONP
         qfcw==
X-Gm-Message-State: AOJu0Yyt7fcMAgvIAEv5Ihk3nx/pm6xQr7Aj/dChpHcMhmXp0xMDcoHl
	PQO5YTe1si/2FjeO/RNfnCbfUWXdFxG0IjSuv/+2cLZgzyXFnYZqLxgM4VNSkNQ=
X-Google-Smtp-Source: AGHT+IHYrCNFuZi7JM5PzLehk0tocOhYuLDObxCk9XIqMJvg9sySawc5MBuX1NvDT7qWP/3i+9Szlw==
X-Received: by 2002:a17:902:cece:b0:1dd:c7ea:81f3 with SMTP id d14-20020a170902cece00b001ddc7ea81f3mr964085plg.1.1711569722972;
        Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 03/14] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Mar 2024 13:00:34 -0700
Message-ID: <20240327200157.1097089-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/arm/lib/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 650404be6768..0ca5aae1bcc3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -40,8 +40,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
+  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
-- 
2.43.1


