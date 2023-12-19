Return-Path: <linux-kernel+bounces-5561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43425818C43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8092850F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E21DA44;
	Tue, 19 Dec 2023 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="bE1UADNe";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="V7XnzUo5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417801D54D;
	Tue, 19 Dec 2023 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003463; bh=M9WlBbQS+py4vER3IqEGVhXVemW9VnxieqHLqtwQ3LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bE1UADNeB2uspHMYO3fCWbYA2MtHZ1o6vQMX7OMEAWNWK04X2PNGmfHb215SMxQxF
	 aVTUi56JUtqcQZsLaz+d8QiQ/edH37rBaUsa754r5Jhbmb65DmIn+9GbDx5g7MMGWW
	 cY0sQW3gmOSn0TQLrYCv/GA4sVyxKOY9BIXB2Ns7cDUOQ5egfO3FYDO4B4GLxWvmHW
	 07dvld+veB3/EhCgjVUHZVRrryXhZNJ2ay0uva29oAbkrz0+qyrCUCas0ta8bi3oQZ
	 TYC7siMKU3sI6hfbjqCaCEncklEGdCpulOZOwbFlezPqrX0MetIN8XfXeGL3k65hkp
	 PWM90dkxrTnQQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 91B1D100A03; Tue, 19 Dec 2023 16:31:03 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003448; bh=M9WlBbQS+py4vER3IqEGVhXVemW9VnxieqHLqtwQ3LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7XnzUo5dtNydJL1osYe+LHZrYzldF0f0Pklco8NJlaQDeRO5p+9Em3YRowZIWJui
	 G8uS0cpyjiI//V/DYUBXOPhdlyV45rF6Rt7JYopQNXkEGscmYTXP3jopTyleeL7X10
	 wb5LcWt1O39zsUWteKERN6vnpjFiUzBWp6QupRHyI5BU/35Y/lsrWf870vYJQ4FZt9
	 iHW7xQlVgOCIvUoAOlZ+IGC1hagKPFSfj3RG9B7xVVv1yXBk6bw0+K4S5/xjFQHKwg
	 7qLFhAAIOQgcOMiNj+lb1T1nuN+WNm1okZj8I1O19ae1g2uV8G065uz7g0h8zkcVEp
	 89WzAqwfgFQtQ==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 970D11002A3;
	Tue, 19 Dec 2023 16:30:48 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/6] pwm: Replace ENOTSUPP with EOPNOTSUPP
Date: Tue, 19 Dec 2023 16:30:25 +0000
Message-ID: <7d6c10b52bbb29925fff9d2f16788a65c138921e.1703003288.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703003288.git.sean@mess.org>
References: <cover.1703003288.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/dev-tools/checkpatch.rst ENOTSUPP is
not recommended and EOPNOTSUPP should be used instead.

Signed-off-by: Sean Young <sean@mess.org>
---
 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b64b8a82415c..c9cb87b59ac8 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -407,12 +407,12 @@ static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
 					const struct pwm_state *state)
 {
 	might_sleep();
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pwm_adjust_config(struct pwm_device *pwm)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-- 
2.43.0


