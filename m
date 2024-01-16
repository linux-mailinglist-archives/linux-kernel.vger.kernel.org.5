Return-Path: <linux-kernel+bounces-26650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDA882E48C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8053F1C21EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C391C6AF;
	Tue, 16 Jan 2024 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0tvoRgC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8281C698;
	Tue, 16 Jan 2024 00:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A1EC433F1;
	Tue, 16 Jan 2024 00:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364018;
	bh=3tP+eiue/2btVPp5XJCUOABDjMxdGiMg9cEfvBj/4pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0tvoRgC3HZ2/S+4etak5NB+Jl2LrFzoF0dHb+2ICtzIBFeMjNyP7VGTIdDE89+JF
	 C9HR6RQUOaZCkZv/TaPTyabc8oQfKGjt1YsB7gWSOOyTFj6hs4qAtH8Q2I6whBj7+V
	 JqnhkzobCU86GURIM96+LGErv66GqaHEpHcFo0cx7CcSIOw+WdbH2qB42TsE7tEWyf
	 QJM6avLPVriDEJ2TTHH7Jov1xVBfJNpP4rsAiwDCAnUbIuv+fZmoN3mOIoTAWBu1Fo
	 hVQG0B6JeBPo836wmMZzF9XPyXxE5pbtHVjEyrqolf7TbJhgYzWDYZYOKF8Hji3QT/
	 vsAntpl4XBQcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	vireshk@kernel.org,
	nm@ti.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 17/18] OPP: The level field is always of unsigned int type
Date: Mon, 15 Jan 2024 19:12:59 -0500
Message-ID: <20240116001308.212917-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit ba367479c7ad0b870461024cd5ae7a1ea6e1e3db ]

By mistake, dev_pm_opp_find_level_floor() used the level parameter as
unsigned long instead of unsigned int. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/opp/core.c     | 9 +++++++--
 include/linux/pm_opp.h | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 84f345c69ea5..630639432eea 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -832,9 +832,14 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
  * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
-					       unsigned long *level)
+					       unsigned int *level)
 {
-	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
+	unsigned long temp = *level;
+	struct dev_pm_opp *opp;
+
+	opp = _find_key_floor(dev, &temp, 0, true, _read_level, NULL);
+	*level = temp;
+	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ccd97bcef269..18a102174c4f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -157,7 +157,7 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level);
 
 struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
-					       unsigned long *level);
+					       unsigned int *level);
 
 struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					   unsigned int *bw, int index);
@@ -324,7 +324,7 @@ static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
-							     unsigned long *level)
+							     unsigned int *level)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.43.0


