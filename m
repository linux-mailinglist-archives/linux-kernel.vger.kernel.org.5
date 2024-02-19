Return-Path: <linux-kernel+bounces-71496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C085A633
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF51F27645
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CAD3771C;
	Mon, 19 Feb 2024 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEilS1h7"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD57E376F6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353625; cv=none; b=jqpNBgVhO8MstLUubL78I1H0GIP96spAPAqKljTe3AT4iJj96bU5goOoZbjpPMhn+xI2UPIbweBs2EPiT2gUY+u4SGIcn4cCfgo6mKjG8Fqqpap5Im7OqRNHSWmG96nNS6fYgJTOS00uFOK0I8gM+JBgWxFDuxdhoiIxvw2i3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353625; c=relaxed/simple;
	bh=GEr9Ds53Uzu0/Xgm3gZzLhsmzW6sTZh+frHwkQG4oGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwx79sV2xwcrgpS7oHMFgMauDKwxTAbBVuhTgP071V+qdlp5Mp/M0V7L16H51ifI04Wg+ntPNhqddEAstnzjq7ZQe45FuQSe6I+et/BIIDiN/0vI2kDoEbKUgk5IsL8BZGvAtS50X+O6dloUPQhTEOn1I1TjVhNv4bUHYhiwqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEilS1h7; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bc32b0fdadso209908139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708353623; x=1708958423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsalqqX3MywWAyCbAuK4sPt5e/xrhQLoccZ7uYuQLjU=;
        b=vEilS1h7cIsVlzTAV7p211rvJrFaBByfRmE+6/ifGEmv0lSJnpTUFJfnSUTgv24htu
         Ma2iU9d2E5aVSFBKfej+Zangext9le2jzGqiinNquQve+76gIoKjqqAKUkxX7B8f8FRr
         tvZPc+Zos1IG2cIb37ZKgxcrROvQ3YhjgDHEE7zqw9QvgXUNO1Dk2CQEhAaHGxkC2hWu
         5SOQHVufkCUtguur/xWOw6S1BM78O9hZMCEoHweG5IEmEm41nmxp+hkSEzrUccgfb7Vk
         OtpEfFYAd8KfFQT8fhOkkJQqaPTozTjZf7PIIDT0xY2M5Izu5fb0QMahnSkCfegX9NEx
         1WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708353623; x=1708958423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsalqqX3MywWAyCbAuK4sPt5e/xrhQLoccZ7uYuQLjU=;
        b=ODWU2WWJIbxZPiPaTo2mUf0vO2gINExIk2rhv947iMGH6St0U0zs22pv4WZeXbnAX2
         J835/icY8wJSxJ7b0jUrZE057FYK6+aLA/5qv1ehIytYwzL2f5aAbkjafoi6Wd3ucSDx
         87POpRDaMK5A1h9UWkzL+sg/PlEU4+vl7e0gSaDp3oPDJ2eofQdOulhCkkPBtlpQ6+h6
         /12yp/3Fegybcm/bdz6ZnuIdZC4wT65swouBlM+S6Tj7f+2AKCZmb3jy9eFzJh/TfHJq
         QK2Gxljo62TCPMaaYx+d1WgF/fkSe5KOTT5yFZ1UhBpogFTD5h9kKQOmmPWPEKn7RIeV
         vSew==
X-Forwarded-Encrypted: i=1; AJvYcCUyugDiZmeXeMHdgOwzrB3DVORhXlWA3MDjaP9wujVeDfRmznP+aSz5jomqMfnJKRXyydsjeAziSsn9FZ1knX+OBZ8d/9qNbhDl7s8Q
X-Gm-Message-State: AOJu0YyURXKmKAodOUkRnykqzFwEKLP14CMSRHmlmPgUHKGTpUsnzfud
	hwt9/a5nMiS7c1mNteMu+sRYMf4grkDe5gIMhhKLLoGWP+Jri8NufeC3zZxwepo/5j88fkTMmNU
	N
X-Google-Smtp-Source: AGHT+IFWksxVy59pv8+2FIrIx+FqJEQMGlwFQrmwxp5iSTu8lWhtKF5A2wmRQrtorqaAGUA4FGNA4A==
X-Received: by 2002:a6b:1547:0:b0:7c4:3218:c767 with SMTP id 68-20020a6b1547000000b007c43218c767mr15178437iov.11.1708353622778;
        Mon, 19 Feb 2024 06:40:22 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id u8-20020a02b1c8000000b004741c8f34easm979144jah.56.2024.02.19.06.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 06:40:22 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ipa: don't overrun IPA suspend interrupt registers
Date: Mon, 19 Feb 2024 08:40:15 -0600
Message-Id: <20240219144015.355462-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In newer hardware, IPA supports more than 32 endpoints.  Some
registers--such as IPA interrupt registers--represent endpoints
as bits in a 4-byte register, and such registers are repeated as
needed to represent endpoints beyond the first 32.

In ipa_interrupt_suspend_clear_all(), we clear all pending IPA
suspend interrupts by reading all status register(s) and writing
corresponding registers to clear interrupt conditions.

Unfortunately the number of registers to read/write is calculated
incorrectly, and as a result we access *many* more registers than
intended.  This bug occurs only when the IPA hardware signals a
SUSPEND interrupt, which happens when a packet is received for an
endpoint (or its underlying GSI channel) that is suspended.  This
situation is difficult to reproduce, but possible.

Fix this by correctly computing the number of interrupt registers to
read and write.  This is the only place in the code where registers
that map endpoints or channels this way perform this calculation.

Fixes: f298ba785e2d ("net: ipa: add a parameter to suspend registers")
Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: Added "net" tag to the subject and rebased.

 drivers/net/ipa/ipa_interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 4bc05948f772d..a78c692f2d3c5 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -212,7 +212,7 @@ void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
 	u32 unit_count;
 	u32 unit;
 
-	unit_count = roundup(ipa->endpoint_count, 32);
+	unit_count = DIV_ROUND_UP(ipa->endpoint_count, 32);
 	for (unit = 0; unit < unit_count; unit++) {
 		const struct reg *reg;
 		u32 val;
-- 
2.40.1


