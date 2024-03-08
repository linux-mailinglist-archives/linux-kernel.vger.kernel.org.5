Return-Path: <linux-kernel+bounces-97669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB65A876D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF3A1F227F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF4636AF8;
	Fri,  8 Mar 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFLV3qf5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC293FBBD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937904; cv=none; b=qgKHJjLiJwkTQIwoXO6dyLjVKAY93MSS+bMP3dHLef2krw6lO5k7ch9YYZ4UM4Yv9Qi+ZAPgqHfh9Quw/Cm0wCsaestWV8Wn2nVM3vLq6Y+Mnkuue9SOPJ8qG8ygj5lZy6w/NgFwB1JmNMWN46L4ogfgZyp1lgMOrdeli20988w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937904; c=relaxed/simple;
	bh=KZRGbBNF0GTtJzvOMXF5VklG5k9DvU5JzIOJGPDdwQI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=AUPjD+gN+G/1D/M9ZeC2UZRXerZo27XOCtI25C46fHPXIFNAlPU73yYP7h9j3mcawv+m1F2DMPU3daJoIaordtlr/6hPJGTylqsgG+zqAH91ObW9X49KuMeEqpQWoesAmP7L9yWyY0Q4bYD5u8qj9XtHKhjWqYGbS9x9yRdFCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFLV3qf5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0151f194so25758317b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709937901; x=1710542701; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IiMp4Q84ZRHG2huJ3D03WkrKLgdFSmD9U9ReR7uCK6U=;
        b=RFLV3qf5sNxacB65Ib0q1PqL8+KAYXKGUgu879ZIcdJ0qVLrQl70VUI0FMxg1c4MdX
         QEZWlqoBgF5rzKlo0bBXekOUJGCFfDI1yF+x0Agp5HXF+gjIkiC4m0LTPziwaC3FFXfQ
         bAq0a8ceovtmA8MQv7yNtdzhTukpnLVLitUK24sub4LMQLhOQSTbg/iGfGbq6GD5RD2n
         l7YrxZc4cWrw1At1W3odrUYEF8jUC0BiLhTmjAdKWSTNYYNUiDgFYWgiy0iv1urSwUAj
         4yW1QEjk35psTJxtTv2ExH5TDSoHIb6HxDkXe/yt5bBdjEjJCds4yzFgCF3zX+fLtajR
         EcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937901; x=1710542701;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiMp4Q84ZRHG2huJ3D03WkrKLgdFSmD9U9ReR7uCK6U=;
        b=joYUlOBKDPVyegB0/XViXWkqvAdt9UUvF9SnyAAG584Bd32+TbbkTn9kzzgx1gbvRp
         u/G9CqQmX0Fji5TQANMABbr6CmFUsFBCsISfkW9+8Ooipjb+FLFWNI/X16uMuFNhecq2
         NoeoqHqrliy3YIDEpk01hhxfdgKMzOIKTHFCsZA64UoGBT6AlVbaIbLcOGTnig/x2yzu
         5INPH8Sy/ZS/rfrZfe99e3+G1SgArNgZfoQZZxmGeDnred+1STP80KTwPXUprKAQKHlI
         XFvmV6ukPnjEVGYPoCq0HPvSxnlFDz/hU69m5FgrIDs2YOD2qJQBuZisWR1GQTxmR5E5
         jP9A==
X-Forwarded-Encrypted: i=1; AJvYcCVrA9/byOJjuXvmwvV6Vop4yeJOtGGvMJma+NwikwVu4BKg0hX5+jhHKNMwVM3ScMaO6PBtsS2tsdQ6bWSnHa4TLeZKYL2QzFYRNKeM
X-Gm-Message-State: AOJu0YxdkW7MQTHEccpw7KV4NNzO1dJsIFm2Y+8SV0c0aCeaN0B0xJrh
	8P+1e6HqESLTZRE08n8d/h55Q09j6twC4kdAhQpN8z4niST2PaZhpT7iBE8Lj1rDncc/JYLb3mP
	+DWXE+vnt8rWIvA==
X-Google-Smtp-Source: AGHT+IG/emX2/VZdtlMuRgEiAhbEydXKKDZZNEwpuRFiPRm8SORpqs38ydYiV9bQtRKmc6lUxN4XqNmkfzHamhE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:b307:13b8:5743:15a9])
 (user=saravanak job=sendgmr) by 2002:a05:6902:102b:b0:dcc:e1a6:aca9 with SMTP
 id x11-20020a056902102b00b00dcce1a6aca9mr96836ybt.9.1709937900881; Fri, 08
 Mar 2024 14:45:00 -0800 (PST)
Date: Fri,  8 Mar 2024 14:44:50 -0800
Message-Id: <20240308224450.2327415-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH] Documentation: power: Fix typo in suspend and interrupts doc
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Typos are bad. Fix them.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/power/suspend-and-interrupts.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/suspend-and-interrupts.rst b/Documentation/power/suspend-and-interrupts.rst
index dfbace2f4600..f588feeecad0 100644
--- a/Documentation/power/suspend-and-interrupts.rst
+++ b/Documentation/power/suspend-and-interrupts.rst
@@ -78,7 +78,7 @@ handling the given IRQ as a system wakeup interrupt line and disable_irq_wake()
 turns that logic off.
 
 Calling enable_irq_wake() causes suspend_device_irqs() to treat the given IRQ
-in a special way.  Namely, the IRQ remains enabled, by on the first interrupt
+in a special way.  Namely, the IRQ remains enabled, but on the first interrupt
 it will be disabled, marked as pending and "suspended" so that it will be
 re-enabled by resume_device_irqs() during the subsequent system resume.  Also
 the PM core is notified about the event which causes the system suspend in
-- 
2.44.0.278.ge034bb2e1d-goog


