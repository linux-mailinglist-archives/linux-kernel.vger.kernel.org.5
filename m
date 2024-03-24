Return-Path: <linux-kernel+bounces-116330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708E889E51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8C1F3765C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A829BB10;
	Mon, 25 Mar 2024 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOKw251n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9600296179;
	Sun, 24 Mar 2024 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324315; cv=none; b=au3RKugZPvUwCwYWXHi7MG8pCUkjD2KfOhXPjAS4ZlUs3SIOTC9mc2TiCXNqTBOITdPZQmZ0ZxOBqSfTtk06VGc/ZEXSk9k1Dwq/tnzGPUYkUoNrxLJgr9xZ70Oqpz4kXqf7tXtaU4qpTBEGhSZgoRlNLmenYBFjJSTh9b2SJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324315; c=relaxed/simple;
	bh=VZsBu+Ttvi19cA8CEXfjnmf7ujuFCHpyubcJGasIOGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk4j9xg8tdftPXWqCXcW6miwbLVRSabpQs3Cbl594jXWt4S+5zRNFrkUWmvqVhPC9tp2PHOwcB1acirqlf4uYDCy527CgBQn+XxuHf4dFkWSpoqfYrYcloV05q2hngTD+RX7mhmnLoR2R9dChQN9M+FSPwjP5OAo3cJ2arR8Nak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOKw251n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC0C433C7;
	Sun, 24 Mar 2024 23:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324313;
	bh=VZsBu+Ttvi19cA8CEXfjnmf7ujuFCHpyubcJGasIOGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOKw251nRLFNpD6o1huTBcELobLN1/O5zsvyF2zjHbslyYGSGwKXvYjLqw6x39f+w
	 SMzOAr1+QLjVayGpsN20yDcP7Jp9BT9UkNmm94eR2lr7yWDHHfDOFyIjoiZq02Vpl3
	 FckXOdLSoZNwwygPwZRDI7X+Tq0Wa1g9deJRZy8g4Tu4iHEDSy5C/bOBRD18J7CIey
	 K4jcVqayrkob4S5nS4Uqtmw716KbjavKa9NuT3cGujOxY5dP7lud4L1/oZaRmN5kS4
	 YIGEF9ytIQ9PXzzo1MZVjK5G3Z5rh2PZMmdaHSGgeMjk6c1HSzFC+Ci7XCGRuhBgdP
	 3eXtqJ6raS1QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/148] media: dvbdev: fix error logic at dvb_register_device()
Date: Sun, 24 Mar 2024 19:49:09 -0400
Message-ID: <20240324235012.1356413-86-sashal@kernel.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 1fec2ecc252301110e4149e6183fa70460d29674 ]

As reported by smatch:

	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:510 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:530 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:545 dvb_register_device() warn: '&dvbdev->list_head' not removed from list

The error logic inside dvb_register_device() doesn't remove
devices from the dvb_adapter_list in case of errors.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 8c64f4cdf4e6 ("media: edia: dvbdev: fix a use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 8273c969358e6..cf0c428f5776b 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -513,6 +513,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			break;
 
 	if (minor == MAX_DVB_MINORS) {
+		list_del (&dvbdev->list_head);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
 		up_write(&minor_rwsem);
@@ -533,6 +534,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		      __func__);
 
 		dvb_media_device_free(dvbdev);
+		list_del (&dvbdev->list_head);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
@@ -548,6 +550,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
 		dvb_media_device_free(dvbdev);
+		list_del (&dvbdev->list_head);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
 		return PTR_ERR(clsdev);
-- 
2.43.0


