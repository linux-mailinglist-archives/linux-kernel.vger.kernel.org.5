Return-Path: <linux-kernel+bounces-151190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C98AAAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7999B281B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A66F07B;
	Fri, 19 Apr 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="plMaSgpS"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136BC3E485
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516715; cv=none; b=fuCBBJoU49sLV6UQtSZqIpCjOmof6FZWDU6rMlZeEaiy0Dh6duZXbMyoMlCh7O02BGT29f+U8WOaw4MROh7869U9E7wH+Nyl/ZYEWhprfh1vcAcrV62AG8MOUV7p1Nen0rDOiMDpcJxR6S3/QbD+NgjR6bYnYkc+HputQstOzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516715; c=relaxed/simple;
	bh=mXEa3/fr+2Yd+gOLSZ48gbNrkoHV+D8vEycijLzI+ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPZ+zpuOOyUBjcaQ7s9NQqWWzmErin6iTrb4bHUO9AhK0MEEM2/5PEXS3BrdiP7RBd6M+oM8ddIeV7NDbEbVKu4LdvBANT/p0/pVNYaLb68c2R4NIqWTZymPdOX3UOTvWu1tGW1we9St2K0pj8zdDRdoh5Vd3/yutcK4B0dvWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=plMaSgpS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a5215314a4so1331949a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1713516712; x=1714121512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kSmPAY2XS4ryCfo1DSiuqPgECXM8l4iXsIqd+cYB64=;
        b=plMaSgpSv+JdwfhcHMP0pujgbkpnLujYCDp9eeACcsxE7Wo9XzwpqOGH3g6VfkQ9l0
         opDEZHzg+Hldt2QRLcd03ocZvlwDntv36kGEMJz58eUoiHrfCzc6JJ8LS7bz7VB0dXCz
         xFJrbscAcfOc9bYgoFYRtTwkXRAIZhndlcVYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713516712; x=1714121512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kSmPAY2XS4ryCfo1DSiuqPgECXM8l4iXsIqd+cYB64=;
        b=XCUKyxhf/nsfnnTIDpwRqSQUrC/6zPbxdPc+48nFIui+kas8RgJdct3Ovvfre4AS5R
         uW6JlvEqaY0xSjV67RNPyYPtiiw9shfbchMJ0dh6W/RGPYR0ziGXk9qnevsjBXsCOAs9
         ArXBfQCl0ravbJrbctpHx3cVOgcVofVBeMEThXIxEvFLlTg8wVX+BvpabUT+lQbSu3lE
         dXSU7xvt1jlnlth1BiISavJ9IQVC0ZWYNAOUmYmYIOzXur/LVffRFhD5ZmgJN+mhWgt5
         ZBP4G70h9pcP+juWLsK0Qf1+5E6VQGWBYPwGqbVeVJEancx9AZedAhphyWVZhBbRGbuv
         IVww==
X-Forwarded-Encrypted: i=1; AJvYcCWX5nps3AphSDc6GOYgNM62cJA9iADlPxircd0D+Et6xshqJiAoyszVZ7lk4gAnUojSwSQmSvBwd5DO7lLKX1vUa2s3cFT1GIDOOjzo
X-Gm-Message-State: AOJu0Ywxm9z4AvEkfVpY2kvJ77TLv3p7aDcfDYMBjwWElrF3S85z2fir
	SnFzbH0krXO8FLUj4LGbTA5PcZoXiVuElrN/Rk2Tb6IChFQhdVirNIfKuz4yrDo=
X-Google-Smtp-Source: AGHT+IFAgtnW3qqihnjJM7JXbAazL8JYMdNU6KxlN7/s4bsg6YnWDk0/qCmsc2ADDIFgwxMTpZVPkQ==
X-Received: by 2002:a17:90b:24d:b0:2ac:9ee:a7a0 with SMTP id fz13-20020a17090b024d00b002ac09eea7a0mr1526287pjb.1.1713516712249;
        Fri, 19 Apr 2024 01:51:52 -0700 (PDT)
Received: from nuc.. ([202.83.99.71])
        by smtp.gmail.com with ESMTPSA id hg19-20020a17090b301300b0029c472ec962sm4430566pjb.47.2024.04.19.01.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:51:51 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	Steffen Persvold <sp@numascale.com>,
	James Cleverdon <james.cleverdon.external@eviden.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Prarit Bhargava <prarit@redhat.com>,
	Frank Ramsay <frank.ramsay@hpe.com>,
	Russ Anderson <rja@hpe.com>
Subject: [PATCH v2] x86: Trust initial offset in architectural TSC-adjust MSRs
Date: Fri, 19 Apr 2024 16:51:46 +0800
Message-Id: <20240419085146.175665-1-daniel@quora.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the BIOS configures the architectural TSC-adjust MSRs on secondary
sockets to correct a constant inter-chassis offset, after Linux brings
the cores online, the TSC sync check later resets the core-local MSR to
0, triggering HPET fallback and leading to performance loss.

Fix this by unconditionally using the initial adjust values read from the
MSRs. Trusting the initial offsets in this architectural mechanism is a
better approach than special-casing workarounds for specific platforms.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
Reviewed-by: Steffen Persvold <sp@numascale.com>
Reviewed-by: James Cleverdon <james.cleverdon.external@eviden.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Frank Ramsay <frank.ramsay@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
---
Changes in v2:
- Maintain comment based on feedback
- Rebase against v6.9-rc4

 arch/x86/kernel/tsc_sync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 1123ef3ccf90..4334033658ed 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -193,11 +193,9 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	cur->warned = false;
 
 	/*
-	 * If a non-zero TSC value for socket 0 may be valid then the default
-	 * adjusted value cannot assumed to be zero either.
+	 * The default adjust value cannot be assumed to be zero on any socket.
 	 */
-	if (tsc_async_resets)
-		cur->adjusted = bootval;
+	cur->adjusted = bootval;
 
 	/*
 	 * Check whether this CPU is the first in a package to come up. In
-- 
2.40.1

