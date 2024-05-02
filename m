Return-Path: <linux-kernel+bounces-167061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6E8BA3FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4A1C21ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4FB1CFBE;
	Thu,  2 May 2024 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bo8YN3pV"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC21CAA1
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692621; cv=none; b=WfOjjoJyJOiH8onaCJbpdCJcdgiBjroALzs0chmV0N92n6MxlQusbYbNmGRYjZ79FTRcR8Uavaz+ojfHKINI0bnoPYsn2x4xmaZaHipBomkprWuy4u5WHq/+lVJthyu5+gVJbbb/m5PObSslQZ6jeJqjYoQYoPkBNFKquK3H52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692621; c=relaxed/simple;
	bh=ieLJkhs2QHRkxAuQ7oeBN/5dxz1NuU1GS5D6U1nGO3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfVx6E95x4BQ23CJXDEfkfpFI3dRc2PPcFqQTQP1oXGihZCPldwQBlZs3QzNtkv0AXPKAEwXQ6iuFSk0IPcaHgJd22cZn1mTtBoLTERRXSPnKciCbxh1MIbz04HTM3+Px8QeUDpoOS+JSszmgsvFCMMpLBVkVIE71DAHB4kEULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bo8YN3pV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b519e438so6747069a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714692619; x=1715297419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4aHlRU+lYNz9FFM2hjk7x/6oGNEaOSMbIgLXm8XygnI=;
        b=bo8YN3pVTQgiSIhjithYRVqdmkLKzkDLM1mu3IUFhDQdG/n9qpvNOTgpGbxSaM6IOY
         ZPIwLYXCjexCeficbfEWERV0JNFjIM3p/qQKKli69KP88SbODeXioUJfihKqtg1S1ytI
         9GZ8DLkZ3PzECBpmy2yJgy14wMD2+TA6ruysI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692619; x=1715297419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aHlRU+lYNz9FFM2hjk7x/6oGNEaOSMbIgLXm8XygnI=;
        b=uOIMMB9TcpeAeoUmkcAtYWS8FUDSGDpb+Wby+FROqrkTlYBOM/53unSEK7PTmMAdAt
         uH1kSeQJyXU63hwRokuCoSwJsoDXWPTvFYIgmuqEghzsoh5e3htXvEMV0Izid7M/Pf2G
         PSnvzAvZB0BS7psvxID+7/lkg+G+DJ2WCmBxPqK+U4dKhVd2Ptqm48zKysVC7pKqKFYC
         xDCY57JAW2oC9l7Q8p/PyZLyH+0gi099Um8cmHPBMWN+BJHdP7FocgeBXVwcNsDfR2Ii
         txrvGI+oWkKL6mlBzPOzL25tGR2kzoqxPw/Z8Nd//xjIEVFEa8PeydNRTh7mPgV2sofv
         qE9Q==
X-Gm-Message-State: AOJu0Ywqg/XHHfeejVTXfX3ArCfe24yCqZsDrWuTGXHmSmhfRmW00jfD
	S2G6JlRHX0sKHNfHF372zjI/MYezjHRDvq6qsRjHH5/MwI1YBfB7sWuE5JEP2wDmymmMcJKfV8Y
	=
X-Google-Smtp-Source: AGHT+IHKrfn8+eXI8IWJ2Tfq/Z+DpLDHoUndaSRPdcyF4wNGAdIV5FDxV8ykztx/38ibgvf4U9YTJw==
X-Received: by 2002:a05:6a21:329e:b0:1a9:fe63:90f0 with SMTP id yt30-20020a056a21329e00b001a9fe6390f0mr1553336pzb.53.1714692618977;
        Thu, 02 May 2024 16:30:18 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id j4-20020a056a00130400b006ed2709ada6sm1825666pfu.65.2024.05.02.16.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 16:30:18 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Mark validate_timer_rate() init
Date: Thu,  2 May 2024 16:30:15 -0700
Message-ID: <20240502233017.419365-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __init marking to validate_timer_rate() so that it gets
discarded after init.

  $ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
  add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-8 (-8)
  Function                                     old     new   delta
  arch_timer_register                         1724    1716      -8
  Total: Before=69177808, After=69177800, chg -0.00%

Cc: Jisheng Zhang <jszhang@kernel.org>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 8d4a52056684..9c4a4af25d2c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1045,7 +1045,7 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int validate_timer_rate(void)
+static int __init validate_timer_rate(void)
 {
 	if (!arch_timer_rate)
 		return -EINVAL;

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev


