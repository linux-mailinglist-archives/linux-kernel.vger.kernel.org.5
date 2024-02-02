Return-Path: <linux-kernel+bounces-50428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA108478D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6762428C091
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6915B4AF;
	Fri,  2 Feb 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abzwpZxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE71509B7;
	Fri,  2 Feb 2024 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899341; cv=none; b=IPigEL0L5c9+RQcJ0PgpR4Zrqwv3Gwgx1DfdeS2qmPvR0F3cMKtBOp8Vy73YfKIkzbNdYr+Z/ius9O74afpXxV22PB7dVEaJtU4hxY0/YRwk7y1KDkljXnTVkokEPo1U7df8J8qNRt6LSCRwRoWIxiqSE5XjwQQXgtzwWwA8VHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899341; c=relaxed/simple;
	bh=bdapCyazg28pG2gCVYAOthdOKRR8OwhX4GZ5e77VKc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9JqB8aVgN1QksA59BjSh9HkP/M/Al5p4Ceciv6mju7YQ28I7oLo8cRaX5KlfHgd+HWsAn2ExXRd+XBnjP3JJ1il9JKIhRttcnApzEs+5qvkLcqBgFcF6+ggL+xd6DkfBIksWegSJsZ3UZfqT83HquSp0Nw5RnjtUhN5arP5viU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abzwpZxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A91AC433C7;
	Fri,  2 Feb 2024 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899341;
	bh=bdapCyazg28pG2gCVYAOthdOKRR8OwhX4GZ5e77VKc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abzwpZxPSavMPvJt+wXqcH8wwz83igq9S0WJOCqC6qUASKbhVc3jkaD+n1G3Q5ngo
	 t2RhVYsVTE86/2tC7M9bvU+SIrHnz0q+5/UvS9SrTNDDJbng6VDmjE8ISTuhw8fjo2
	 V5nWzGJIuNOovCzhy924nHvSgPRCh4EA1rvLBbiYODLewgGoycBQpNXemI/ubgOeDy
	 ePnLyWy4y+U7syWjc1ijEGYK+c9z8mDYWyLrc957AmZ2nUwpgCwF0RnOuZfy5mflFE
	 6ur127FQvEPxgECHsgJwaUlEwE1QRAuvjz4l3qBE5tocKZdTfZ+XgWN4AjJSUa2xvj
	 8JqwO6AhBiSIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	adaplas@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 3/6] fbdev: savage: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:42:09 -0500
Message-ID: <20240202184215.542162-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184215.542162-1-sashal@kernel.org>
References: <20240202184215.542162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index d5d22d9c0f56..368500c40140 100644
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


