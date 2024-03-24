Return-Path: <linux-kernel+bounces-115224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1243888DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0928F683
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0461D296BA3;
	Mon, 25 Mar 2024 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+k3imjf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D2296173;
	Sun, 24 Mar 2024 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324314; cv=none; b=B3R2d9Qo5HG7JHWxyS1P4lHcfX8eoJ6xW+CWdIETzh5AMFQYVjn6LI9qzoGtzOCHz6CszgM0gRE5gKTQ5BVDTW7Jnx7KSE+g8Kc2ISfZstP+7vrlf8TsUh3lZrcMps8s9zCCUKeKvtJLjIwDoRmtFUQX7T17yHFbrT4oaME1pnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324314; c=relaxed/simple;
	bh=P/PAhYD5AdDh+C56c3tbDfUP3ouaglcCX/oQHeHaGdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah3Lyxhq2Bh6q+VjyQl1MuWt5fzhJYnTRZAEUPM3d07PUbPCihFO2dPqxWlCCnBXxDof1Qfv0m26XJbRnpTFMA74I5aZXCxila8QrddxUL3Kf5NnV114EaNKTY4onT0skbZLd1ZX0vi5SrVq1JJ9nVhbG2G8oaoKN0eL5HEmDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+k3imjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A933C433F1;
	Sun, 24 Mar 2024 23:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324313;
	bh=P/PAhYD5AdDh+C56c3tbDfUP3ouaglcCX/oQHeHaGdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+k3imjfhqleyqj9LRhlk/Mcb7uJ2yuzwTYL+wMP1mbDXCy0bVWegqEut0KlFYs5D
	 xLQwiKtBW4vTN6EQMurie/rNA6LEFryXR7IEdLg0TpYCgBusoNH4i8WnIJv86vih8Y
	 SZ1OUGgWIAbOZ5/cNdSbFrIYDdkLi49N6FRcBXSgOjYLv2in/tHj4VZjWdt9+84bRo
	 SXn5mQLeNmBm1ROTdmHx4jxFpQ5XcpUmi1oywBPBPk/5BUwAyRtI121vZtykLNAm65
	 wpExJzFZ4/TpZgDKvyJD1iffYNSelafAojsoZyi/dkCAG8o03CoSYZ0OkCkiuBprs9
	 QFBAC2LwREpHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/148] media: dvbdev: Fix memleak in dvb_register_device
Date: Sun, 24 Mar 2024 19:49:08 -0400
Message-ID: <20240324235012.1356413-85-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 167faadfcf9339088910e9e85a1b711fcbbef8e9 ]

When device_create() fails, dvbdev and dvbdevfops should
be freed just like when dvb_register_media_device() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 8c64f4cdf4e6 ("media: edia: dvbdev: fix a use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 5d68ad0ac5d26..8273c969358e6 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -547,6 +547,9 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		dvb_media_device_free(dvbdev);
+		kfree(dvbdevfops);
+		kfree(dvbdev);
 		return PTR_ERR(clsdev);
 	}
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
-- 
2.43.0


