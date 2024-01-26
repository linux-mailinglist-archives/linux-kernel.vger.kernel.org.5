Return-Path: <linux-kernel+bounces-40265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E883DD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566111F21A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A05D1D539;
	Fri, 26 Jan 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP/gAuUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B21D52C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282656; cv=none; b=d/AGS2fbrM1W7MT/Q0p8UvL3/9lAIeyMui0NoeMB9FcxGke1QFkgT6SP7tgo6PFVDtIcsDf9r3LjJDdy1Rq6swIT+bKE14PKHKdnBRDHz5avbViyRlwmwDb186Cf39rVEm9momP2Vr1metCt0ocFsNhKWrFRTmBFdrk5uEO/4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282656; c=relaxed/simple;
	bh=lhfvdd0CQ97+F2PLgTG9KuevanbLcfk73SxBk1IuAQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ifv+sPFbfB5tcq3w9k0UmaIO4Df64YfDBPM0Ew66Izo2s6mZ0nGjqKXaG+oExi1jihY51ThfAl6ANiW2KBbhpqNdS+DAWvoK742jm0I/axS1niSk9fV8EwaeD+el30rK2Iqi1VGKVpgO9KXOqkLhbRqlkqucLa70NLEme0B7Q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP/gAuUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3396C433F1;
	Fri, 26 Jan 2024 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706282656;
	bh=lhfvdd0CQ97+F2PLgTG9KuevanbLcfk73SxBk1IuAQc=;
	h=From:To:Cc:Subject:Date:From;
	b=TP/gAuUaUu7icEys+fJSftia5Z2bBywBvzDtxCrryqHpAd9V259yshOGhMVtg4BDR
	 aY9Ru6nX6qbLRwxHyHLWTh4rECc7wgBRSPLBaG9f8HbHMlmvlzOmGuxdSxJURsFp0d
	 WSIBDAYsampsbf3sdJmmRG7uetx/NuQCIQUjYAYV8hNZYpzjeyM3rzUFVSZz3L+2MC
	 TNPN4NjrWbZPXaKAxMrmoYmZdrHrqcByle4gAEtUY+RliW9Rq1rEbesLkjwyVYMOJe
	 1YCnSnX8lrhbCzVkgzzIjgFl3/CRNKJrPziHRCeHpqxWTdzXV4JvsrFLzZPQnybX8L
	 ai8dLo7R1QALA==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Brazdil <dbrazdil@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: open-dice: Fix spurious lockdep warning
Date: Fri, 26 Jan 2024 15:24:10 +0000
Message-Id: <20240126152410.10148-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probing the open-dice driver with PROVE_LOCKING=y, lockdep
complains that the mutex in 'drvdata->lock' has a non-static key:

 | INFO: trying to register non-static key.
 | The code is fine but needs lockdep annotation, or maybe
 | you didn't initialize this object before use?
 | turning off the locking correctness validator.

Fix the problem by initialising the mutex memory with mutex_init()
instead of __MUTEX_INITIALIZER().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Brazdil <dbrazdil@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/misc/open-dice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index 8aea2d070a40..d279a4f195e2 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -140,7 +140,6 @@ static int __init open_dice_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	*drvdata = (struct open_dice_drvdata){
-		.lock = __MUTEX_INITIALIZER(drvdata->lock),
 		.rmem = rmem,
 		.misc = (struct miscdevice){
 			.parent	= dev,
@@ -150,6 +149,7 @@ static int __init open_dice_probe(struct platform_device *pdev)
 			.mode	= 0600,
 		},
 	};
+	mutex_init(&drvdata->lock);
 
 	/* Index overflow check not needed, misc_register() will fail. */
 	snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%u", dev_idx++);
-- 
2.43.0.429.g432eaa2c6b-goog


