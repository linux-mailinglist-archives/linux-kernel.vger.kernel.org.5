Return-Path: <linux-kernel+bounces-113221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEC88826C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375891F2197F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E0181470;
	Sun, 24 Mar 2024 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4gVxb9E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E74180B9A;
	Sun, 24 Mar 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320022; cv=none; b=umDYVg4Nn3qotlIUM1uzVSs0Of4KdLGXwDxWyGI8AUzi8NL4md732ArM930x2nApxivjrc6FI/QtMl2T8cyj6UGcvQM8v/DjTzDlaq4yOB/UbcQGpT23rEKnFwOT4b8/fsNZOM+49SLX5Qs29LyxoKIdpUp+9k4XRciEbGG6POg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320022; c=relaxed/simple;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+7abthOQwiN9pfh2v9hd5u5bvQSajTEcu99GS0Cpovu2Ugc4HRlZ7Mg3X+YFjBIWpT8v5arGEdg61ctI8QHMiifjhtTySvUt5AUbyvydcJuMqm5UT6cdusblvsS8S1TCtvnUJb7YcfSdK+fyoGASWIBCclIhfSDBcLKbkOtBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4gVxb9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69BCC433A6;
	Sun, 24 Mar 2024 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320022;
	bh=vP825Ku2Y5fpQtvsySFA7Z6w4KP+omheovnqVtB+F0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4gVxb9EJQBbnIzVWnlknzNh62vVXNlHs1NTzHbUC/wtIcY9Si2ozdf7XrB9s7qYL
	 sGfTg9Ajr13stJvqiVlnfgde0toZgYbkcE55zoAtGKICyJz2Wu4Z4edESScPRbRfI1
	 i0Wa7e3xubN25KykRJDGSlll4W2q/dJmfHY9oM6j6hZefTD5jXqHcMOVdvj+2CKkHr
	 rqetDkZ2HLaGhrmFsNStbaHr0MSm2GaN1aHntcyaOOaTEmi8nYFh17rdz3bSbQlxF+
	 h1myY6Z/LyIy2pjAiQsWy146vJCtcvKR/oDC42CE0oV7juLdcmQXMMxW7+I9iFtXvo
	 3d7k6TpBvaaxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 330/715] net: hns3: fix wrong judgment condition issue
Date: Sun, 24 Mar 2024 18:28:29 -0400
Message-ID: <20240324223455.1342824-331-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit 07a1d6dc90baedcf5d713e2b003b9e387130ee30 ]

In hns3_dcbnl_ieee_delapp, should check ieee_delapp not ieee_setapp.
This path fix the wrong judgment.

Fixes: 0ba22bcb222d ("net: hns3: add support config dscp map to tc")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
index 3b6dbf158b98d..f72dc0cee30e5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
@@ -76,7 +76,7 @@ static int hns3_dcbnl_ieee_delapp(struct net_device *ndev, struct dcb_app *app)
 	if (hns3_nic_resetting(ndev))
 		return -EBUSY;
 
-	if (h->kinfo.dcb_ops->ieee_setapp)
+	if (h->kinfo.dcb_ops->ieee_delapp)
 		return h->kinfo.dcb_ops->ieee_delapp(h, app);
 
 	return -EOPNOTSUPP;
-- 
2.43.0


