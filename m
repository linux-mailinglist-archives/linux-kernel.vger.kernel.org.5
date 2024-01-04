Return-Path: <linux-kernel+bounces-16798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79538243FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A601C220BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4792375A;
	Thu,  4 Jan 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cn/XPIp2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F223745;
	Thu,  4 Jan 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0543B1BF204;
	Thu,  4 Jan 2024 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704379284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZXpk62HaSyYdfa/hmfto+HT7WneHwbXkDqb2eRkEPoA=;
	b=cn/XPIp2Yaaea23I+TyzRR3R6zJW4HSxNWU9xcApY8Zgii2v7xNmb0GdQr+pQXlzR34xXX
	QnbYBc3XsI2XVWastIy+32ChXUnu0X4slBi/01ZJDELOvqd5rtQdMmiP48Nx2sHqumJgI4
	k6aUX53ib0j/XutsEw7NRbW/iuBmdfjD1EJI130JRZWZxVdsW0CLsDIilWxFj03YI5/7ns
	60vyz2m++LB/+zbiaAoZCO6tNp0v9L/hBa9Dz2wdL5zckpTp7fF7N/K+QFx+KUfXzc5XwT
	pkeoEXWzxXXpCRDvKLPsg60E9b3SvKw9wXnND91HqXw1FodPelhi7ZxinlW24g==
From: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] wifi: wilc1000: fix RCU warning in connect path
Date: Thu,  4 Jan 2024 15:39:23 +0100
Message-ID: <20240104143925.194295-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this small series aims to fix a RCU warning due to RCU pointer dereference
outside of a RCU critical read section.

Fix is in the second commit, the first one is a mere declarations
reordering before touching declared variables in wilc_parse_join_bss_param

Alexis Lothoré (2):
  wifi: wilc1000: fix declarations ordering
  wifi: wilc1000: fix RCU usage in connect path

 drivers/net/wireless/microchip/wilc1000/hif.c | 39 ++++++++++++-------
 1 file changed, 25 insertions(+), 14 deletions(-)

-- 
2.42.1


