Return-Path: <linux-kernel+bounces-76442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B585F76A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847F31F2654A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EBD4596E;
	Thu, 22 Feb 2024 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="drE5OqPr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7644438F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602460; cv=none; b=VfYVj6VSH5N52nNmgIe8lgIIvj6rRUQaA6C8/EdB64siOXbbwpgK21OGy0tfcv08A1Sxyi+cfxo6PPezzfmaGpScpZGWe5HHmrEq6fpYh1LeicNUCU5kzj6k75XfSdyVdPRT7sfJVBNFOYpBxdcuOqIzR+S4E27cYJLb1YjxGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602460; c=relaxed/simple;
	bh=rspXMyvbrxXQDEVONtmPeewTIUO8cuBQ1GzWdFUhTYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BK5dbFImWWXqcaKqGjr0VuPlgPX3DHtVPsQbZdC9v3Kt6fiJkP8j16Ou4HOiED3sDIumdvnnoeSfWBIU6FoFMUz7WJCiE7Ga38Opn+Q7erHU0yg0z3XyQo/wU0614dtPCFAgqU1X6awOECJgw7eY8rMfvE2tDXebcs7a4Ix4wRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=drE5OqPr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d26da3e15so500498f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602455; x=1709207255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32KygsBBniElsYDhZFu86kyH97BjM6glF2hhxL+tJxE=;
        b=drE5OqProb0RSQKkl88i2nkfUqw+P0BhggKxRKkVVffz4jafPoIFrOK25M4dF+98lp
         fLRHHvs5GUTjnROAifGo2x4U0xzg9jcBcXd2p8rnez/tuMvlvjtm0wXUXdMb/D3St90P
         P5SPNP6/1iDbW8Tib7qUqUgsNpMto7ad+JOVg9BlUmxiGMTE4hmOcfBhnR78RTHOXMTm
         JbABUln6O8K2zIpfqcCtVAOpoKTfz5fJAZjtZbZRGOZjHp9Pv8x2aiQYOuD4UtDi0otc
         EVtM96+rlTXyIy8rWlGuBUyh1lwT8vZEKDsQeTomgQT/ahXFSFIJdaKA5S+5CcyyPXyp
         Y+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602455; x=1709207255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32KygsBBniElsYDhZFu86kyH97BjM6glF2hhxL+tJxE=;
        b=kKy6awNxiYdcdP4lm9UrCWbo8g0qUMvLsE3p5urbiXY5OW7kqH05WNhZmxjfayPck1
         uaxWn2QvBErI6AHioUMNkOLOaeMijy6T6Y1sVbudmHO8WglHffSQlkkppjfbGyOxMHyd
         6oNId/uNkoPhkidFpxdRDb8ezQX5waGo6HtkAQ23ahOKRN39ToqzLrsPL3lppjhHSmeg
         eH+N/bFE9gR/pwyx5CBD7+Ct5mDnZkUZEwN+Fzmq3OurWD0P5/UpzAFwzH0iyIcJNDFN
         1Q5KWGvq8qQSNkrYsIgHL5q3DX0xroZI5mxRJbbGLjldpe8vMr6hHlDogZRQuZE+GXrf
         xXkg==
X-Forwarded-Encrypted: i=1; AJvYcCUvvUJs18/lmbjvSQIOTQGHloV+iabdIdvaqp6tEJwECeZfx3m00ezgP9d6BiprBdxw8KqTdvYNzd9oxQiXPsVn2E0zNDJJtt8z4IRI
X-Gm-Message-State: AOJu0Yx64QzFpqkH69lnp0jvksIHiks/tj3wh5+u5FPEp38DU3wPiVKh
	PF2YGKbCGvKvcaJa9wqf1xD8vfArL1TY8HOaaDjoO+FLlg7frG0zDKtIuKHqyG0=
X-Google-Smtp-Source: AGHT+IE7b25rzA+Oajdyr+NHJQMrfisY7DzPHsgIrpCkxWVcnzdJRL/5ax+1Jho3J7XJwdtp4ecdLQ==
X-Received: by 2002:a05:6000:906:b0:33d:754c:8daf with SMTP id cw6-20020a056000090600b0033d754c8dafmr1937949wrb.10.1708602455647;
        Thu, 22 Feb 2024 03:47:35 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id w2-20020adfec42000000b0033d13530134sm19914269wrn.106.2024.02.22.03.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:47:35 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: adobriyan@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] linux-next/cpu: remove stray semicolon
Date: Thu, 22 Feb 2024 12:47:27 +0100
Message-Id: <20240222114727.1144588-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This syntax error was introduced by commit da92df490eea ("cpu: Mark
cpu_possible_mask as __ro_after_init").

Fixes: da92df490eea ("cpu: Mark cpu_possible_mask as __ro_after_init")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 7b36b3a4e336..cc4a8068747c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3106,7 +3106,7 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
 EXPORT_SYMBOL(cpu_all_bits);
 
 #ifdef CONFIG_INIT_ALL_POSSIBLE
-struct cpumask __cpu_possible_mask __ro_after_init;
+struct cpumask __cpu_possible_mask __ro_after_init
 	= {CPU_BITS_ALL};
 #else
 struct cpumask __cpu_possible_mask __ro_after_init;
-- 
2.39.2


