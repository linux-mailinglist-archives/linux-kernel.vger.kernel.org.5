Return-Path: <linux-kernel+bounces-89211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313386EC16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27E6B23912
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F625EE84;
	Fri,  1 Mar 2024 22:59:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598C5EE68;
	Fri,  1 Mar 2024 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333940; cv=none; b=M3ijNDkJSFd7r5KSEIwyrktayLU9sRuVdKN9mIyM7GSVkpwV6FwN4oLk4LQDekI2BZvKpotM59+JXCCTkrVK1oaiNcEpguL6f/1k5ihInsXCnHUARphQo9FjNjeSwUf6uEMnlQBz03uRVl4em9jVaqmEODzoF3sdrXY+TRrtdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333940; c=relaxed/simple;
	bh=sUNQXNzk7A9AAczsx1WMa7txCzYIhocc+2J70qriY6Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KCY6Hi2IzOcrUQlC0R28wUY23cofhRxVUgQaz0QU3MMnuyH8BB3y94bn33aePQ54k4QEybI/3JWEm1GEtalks/NovioXNIZRds6xDO25MT2iUD7IzrNnjDi+zHb4jBZYv9G4rgrMLgo9OLGofg7dI8Jl5F2PjuU/gapOpxapxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF31C43390;
	Fri,  1 Mar 2024 22:58:59 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C5E5210633B9; Fri,  1 Mar 2024 23:58:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/2] power: supply: core: class cleanups
Date: Fri, 01 Mar 2024 23:58:25 +0100
Message-Id: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFd4mUC/x2MywqAIBAAfyX2nKA9qV+JDotutRAmLkUh/XvSZ
 WAOMwmEIpPAWCSIdLHw4bOYsgC7oV9JscsOla4aXWujgjzK7iiSSejPoDrqemNcO7SIkLsQaeH
 7f07z+37yQ9fPYwAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=983;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=sUNQXNzk7A9AAczsx1WMa7txCzYIhocc+2J70qriY6Y=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBl4l2mMtNMnw/BcD4dXzRYXDs4StwkHxeBcH7Zr
 Lg7LDjEnfmJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZeJdpgAKCRDY7tfzyDv6
 mtV7D/9eG8lLNklmAPl615dGtgGA3CbvHXyMuIyLhoZKoU1iatSzpxYOmKLkcI8aTbOwFXb6oC8
 MpbHbq/ZGEqUVx+PJLZH9FIo7zYjsmCH5mOzVRG+mTFMBjAyUrrRmTdmWx+ikq035RgC4ETf3A+
 8uql3k9CKhmXHW04Q9CwRBSBN0vqjRHFERZI0/iCgpkAMMqgSqQvDHplRMMh55vCo+3edb/GVH8
 UKT9FWHeJ0vWzs1B2q6VKw57CE8/WMGiBTSlKQllJHsJuwxZWspT95gKmY8j/p9Wbq2YJbLP2w1
 l8IuubGoDoL1EhRv5A426AU3vzhd98OD2qT7W2bw3JrwfHlnwGT19HF1/sSjO3T5goXMivIBeaB
 unneyS/LIQv4KK2Z741C5MYur1wPu3viujAzN/MKcEsnQzjdc9k+cz9h87Tfct2Q9DIvye74pUp
 3u1U5V3K0OPLrCL74bGkgCQLPZewFup7EHCFWfqEg1F6QjnydCZVvUrCMpvVaO3znwyWbO+fgl6
 +yh3HI8XnSyq78VwdjobPRXKMeR8va7o1KsolRnhjj7lXO41xeOU4ykAqqye8zZWXEerVaPOrPJ
 usXM+uPIluX0eZke4keaGtebKD2UWIThbjroz4gYNaFCl9FvXiyvZ6rvlp/0nZkKWWq5JZY7SlM
 NljyWLjtYrFZeqg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

I noticed some further possible cleanups when reviewing
and applying Ricardo's patch to make power_supply_class
constant.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (2):
      power: supply: core: add power_supply_for_each_device()
      power: supply: core: simplify power_supply_class_init

 drivers/power/supply/ab8500_btemp.c      |  3 +--
 drivers/power/supply/ab8500_chargalg.c   |  3 +--
 drivers/power/supply/ab8500_charger.c    |  3 +--
 drivers/power/supply/ab8500_fg.c         |  3 +--
 drivers/power/supply/apm_power.c         |  3 +--
 drivers/power/supply/power_supply_core.c | 43 +++++++++++++-------------------
 include/linux/power_supply.h             |  3 +--
 7 files changed, 23 insertions(+), 38 deletions(-)
---
base-commit: 71c2cc5cbf686c2397f43cbcb51a31589bdcee7b
change-id: 20240301-psy-class-cleanup-6e6711d595aa

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


