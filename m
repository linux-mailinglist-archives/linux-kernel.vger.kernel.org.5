Return-Path: <linux-kernel+bounces-3213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55396816946
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D936DB2104A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE969111B9;
	Mon, 18 Dec 2023 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="XD9yKPIX";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ps7D0E6K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C528125A5;
	Mon, 18 Dec 2023 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890434; bh=M9WlBbQS+py4vER3IqEGVhXVemW9VnxieqHLqtwQ3LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XD9yKPIXqiiGz+JMhJtxPdySF+OoOU2IBt2PN5pf2fRf4IVuHalPF95qrJaWDW8M2
	 UYc2YjJus9OAzfSbyTKBYlF/rieSc+yqZQEeCfjkl6dk18Fb4US2Owv9QN7xcTjFVM
	 XcpyPJ8j7Gqqzuug6p0//NLOQO2ZbUfsAcQhSqOiWsGXf/GGJyKa3LLqXanz+PKlM7
	 lmRodLFXcQqwG8+xEIgVv6wCm4XVzboo+Ko+weFxmYHP85G5cPYc8wOyVwBgfoppcS
	 NgOV+0mhHJok76UPHUpav2R2RLmjGjnLmczUWwNNMejmR3YesOUevTNwyl6RvcsFs3
	 brsVrvI1O/j4g==
Received: by gofer.mess.org (Postfix, from userid 501)
	id E0ACD100A06; Mon, 18 Dec 2023 09:07:14 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890420; bh=M9WlBbQS+py4vER3IqEGVhXVemW9VnxieqHLqtwQ3LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ps7D0E6KbDPw/1N6ea7ATvd4BzRKSOD2B83ULZcceR0d35PhXuGTCPPzNbjYziZDN
	 Hn0fBfjt4uOpDH5qeTYiDy2y7Tmn/XVFtu+S9VyxZLYvxUpKxldNMPVbYviHfZMffM
	 Enp08OhvEHAeccqI/GMV9PSCPNbgUG8OKjCKFfnUYSINtHn150GNgV4+tz0u6xmnQN
	 JpMprVKDiHtkH7CDT5EzepDY8x8hvKMPYHXrEwt//vre+/z/eyJfkMV/0tBM57JEpX
	 uiYFjfEf6wo0pdMled1bD+yNEF1RtchQCW/YXJzDLfk2kfaI0bcfMJjvOxLO1xBg52
	 A0NJLjwPAfbIg==
Received: from localhost.localdomain (bigcore-79.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 125961009FC;
	Mon, 18 Dec 2023 09:07:00 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/6] pwm: Replace ENOTSUPP with EOPNOTSUPP
Date: Mon, 18 Dec 2023 09:06:43 +0000
Message-ID: <7d6c10b52bbb29925fff9d2f16788a65c138921e.1702890244.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702890244.git.sean@mess.org>
References: <cover.1702890244.git.sean@mess.org>
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


