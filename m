Return-Path: <linux-kernel+bounces-50346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C37D8477CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFABC1C26BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908C14E2E8;
	Fri,  2 Feb 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW8Afam5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DCD152DE3;
	Fri,  2 Feb 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899172; cv=none; b=nsrBfA36HqWK1Uut83DfJoD7SGoaAtd7jOALebchjPm1jUGODNzxgHMVVpIlH7UzEGypeNf74ajfMbZ8SOZJijA3lQ7vvHH+Xmm3RF6tzW5Jsn8OAri4rWqSSSqNsEoqSj0hGDt9Rtutq+FtFHIXZV1NIuUlGX4IpLXtT8zcK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899172; c=relaxed/simple;
	bh=+I78WAJjV2mXXrvpFXbawPuTz8P4TcngqBjgiVV9yU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKHy6VI2lv8RCGIsRAbNjBdPtBSqQa+Be2VAlx6GcU+K5A6drYn7yEfMbKz6sHUX9stVYSRlmeJGQiFhbfpdFClfK3CIb3tFP0g9Vc3PcLbGrnhWfU5Y1eTQnxw3D3vnuaurNb5575QBalFpTSNlBCDtcgHkMmk4lRjfNpmoHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW8Afam5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2C6C433A6;
	Fri,  2 Feb 2024 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899172;
	bh=+I78WAJjV2mXXrvpFXbawPuTz8P4TcngqBjgiVV9yU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OW8Afam5jtsHT1tsBudJ8TyHMuiXcHckjhau6Tz43/JAq5BC1UMTJxrjT+h/6VJS8
	 /6ZEZDeORCIPjagzSwbeL8bkktghFC7HqouOELil+f4UVQo4LWAh/zZlUYqLKeOX1l
	 w6Sdr/nEHD1gy3R6PG/4yi2/7z1MMLSFTIC5K9WqytWeTiAW+bku7yGLuqe0qZVVhM
	 sIbeX1aSPKMJzCx5XlfiiqQMGrkgMUFKr4uqVPZ2JD0p0cCjRTdaKT57yKyy4NDCjD
	 VRrjlSbSWAfMIS32kDZnGfELxeFpodVfWQAecfKtI2WM61i8asaE9gg4DPllEigHTB
	 0V0jqVP8OH5DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	adaplas@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 03/23] fbdev: savage: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:38:59 -0500
Message-ID: <20240202183926.540467-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Fullway Wang <fullwaywang@outlook.com>

[ Upstream commit 04e5eac8f3ab2ff52fa191c187a46d4fdbc1e288 ]

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of pixclock,
it may cause divide-by-zero error.

Although pixclock is checked in savagefb_decode_var(), but it is not
checked properly in savagefb_probe(). Fix this by checking whether
pixclock is zero in the function savagefb_check_var() before
info->var.pixclock is used as the divisor.

This is similar to CVE-2022-3061 in i740fb which was fixed by
commit 15cf0b8.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index dddd6afcb972..ebc9aeffdde7 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -869,6 +869,9 @@ static int savagefb_check_var(struct fb_var_screeninfo   *var,
 
 	DBG("savagefb_check_var");
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
-- 
2.43.0


