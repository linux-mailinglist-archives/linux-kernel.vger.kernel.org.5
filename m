Return-Path: <linux-kernel+bounces-7439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960981A7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209B3286AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82BB4AF86;
	Wed, 20 Dec 2023 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMsXp5la"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6634AF63
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3ddccfaffso1323145ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703107033; x=1703711833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGegIddggKFG/zutIaei4eHzxrpz6/dja4W8/BctOAU=;
        b=WMsXp5lad1ptNXHEjUl8VA87VrrCWANP2+oOSskHvW08BCjLlInH3WWbGorhzR5IKG
         Q3t95JdFtKdYbMRYuP6lCmOSzzjDOtGuQwzIr0F2QKrF6hsQv/uRi3IUn7p5uYwqrV4x
         u2e1M/EpEU/NXfkzSPDrGyiLFplp2ZLpYLOJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107033; x=1703711833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGegIddggKFG/zutIaei4eHzxrpz6/dja4W8/BctOAU=;
        b=NHZN/j2xGHI8SbJe/k5aOVmelUqpvEv7hjTXXjriSUThpciRRGFBSlrdjuDcwtVIUV
         4aBmjcux0OBrqlhe9TofySHhSSM7uKwBY75MKScWcM5uMMJDf1MDfZaky35sm6GaP0Sh
         hUO1vOcziL/VoekAjJJo9eEGD3Arl2y4s/0o4KA4Jcr4oXEUM8tPaONIHP/lKflrw/Sv
         MpxR5n+mC5V6yZl8ohgNglLYvrmKt6FKAJB+gZNWyUT5D7VWngmuRkGTLgj19IUwFcpP
         diBRLtEty5VI7BNlvbQJbnIr6I3IYBsPBq+epuFtRcFdZ6qGZr2UGbTKPl9R42YKH4tZ
         0Q+w==
X-Gm-Message-State: AOJu0Yy/ax01Ab5qBh6KgRqkg6F7Z3XK0sGkvrvXGn4N0q/Vgk0fK5AV
	SjFmpyKKaN1i/gGW2jsYml9lyw==
X-Google-Smtp-Source: AGHT+IEePv04N2Xkrvd8k65DZuDoY0n0riLwskKakblHowU4xsnnlhRcp1chgs2Vk6H2fJPV3kaKjw==
X-Received: by 2002:a17:902:e847:b0:1d0:acfc:a653 with SMTP id t7-20020a170902e84700b001d0acfca653mr23942838plg.84.1703107033190;
        Wed, 20 Dec 2023 13:17:13 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5a22:d46c:eec1:e5d4])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001d3dfebc05esm175023plr.21.2023.12.20.13.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:17:12 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] watchdog: If panicking and we dumped everything, don't re-enable dumping
Date: Wed, 20 Dec 2023 13:15:37 -0800
Message-ID: <20231220131534.4.Id3a9c7ec2d7d83e4080da6f8662ba2226b40543f@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220211640.2023645-1-dianders@chromium.org>
References: <20231220211640.2023645-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If, as part of handling a hardlockup or softlockup, we've already
dumped all CPUs and we're just about to panic, don't reenable dumping
and give some other CPU a chance to hop in there and add some
confusing logs right as the panic is happening.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 11f9577accca..81a8862295d6 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -192,7 +192,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 
 		if (sysctl_hardlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(cpu);
-			clear_bit_unlock(0, &hard_lockup_nmi_warn);
+			if (!hardlockup_panic)
+				clear_bit_unlock(0, &hard_lockup_nmi_warn);
 		}
 
 		if (hardlockup_panic)
@@ -548,7 +549,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		if (softlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
-			clear_bit_unlock(0, &soft_lockup_nmi_warn);
+			if (!softlockup_panic)
+				clear_bit_unlock(0, &soft_lockup_nmi_warn);
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
-- 
2.43.0.472.g3155946c3a-goog


