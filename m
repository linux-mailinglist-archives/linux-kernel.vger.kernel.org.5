Return-Path: <linux-kernel+bounces-72736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D4F85B823
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122091C209DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F479612E3;
	Tue, 20 Feb 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfinJAwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958767A10;
	Tue, 20 Feb 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422389; cv=none; b=bBYySvv+Al06eVbz9sh0YUKd5BXHRlQKCxdh7FPGlI/33+3w2E1+Sf0ZMTDPmXlQe+MRgRcJYn/F893lYoT5Xlk4uvTbgqb3csIVfdouGEBT843VRUtTgWbDK5K5O6qp/gHfxDC0tTxg7qiJlH7fFsHWdnePI34+grNJ/gEXoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422389; c=relaxed/simple;
	bh=hQJr9GrEiqeK0zA5MJS6och8i4CKTFFL0XZvbPyX92U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsIXuQnXz71MFhhSkYUsbsnlqySgobiOt14jGM4Yh1fThEQDPg54m8BCjCs6d0hDJ+uxWbudQkMcdcLLhjjuAROJV9FNc+rQKFkM1cRVSIEblvCTUptlRyZdsBddhNm9dV98VawAv+u8C8g6PeTcJOkV9WjlroypkfQ0P+H3Iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfinJAwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05688C43394;
	Tue, 20 Feb 2024 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422389;
	bh=hQJr9GrEiqeK0zA5MJS6och8i4CKTFFL0XZvbPyX92U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BfinJAwf3tpTVaMm1yfESWPirj1ytr6Eq6BYpdlIdhHJO89mSfYPLoiaVMT4Bx5il
	 7Ug4Iba+/xuYU9MmGGEuYtTTYx2qJITQT/x4Ee0psdOqLbF5uZOmsZK7Tp2Iz2vuOj
	 8v0/S1TCTARHUaZlU0lG27kOR01GpLcrm3cosTxFa7POObtRX8R1JQpuTI0m81guom
	 UJOZQ7obs86W8XegJcWwpriiFP1FBXNfEmwAWJ5RMnX0Z3ERDmB5SNcVX7K/MFwSrI
	 vvwWoinYz2b+AMkbf9lstoWbL6eOQKuemjKnYQ9OXoJA9FIKXkwT8B0D/bhnzp+1hJ
	 QkaC4P7fI6+bg==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1rcMhm-000000031Qs-2bfx;
	Tue, 20 Feb 2024 10:46:26 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Zhipeng Lu <alexious@zju.edu.cn>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH 1/2] media: dvbdev: export adapter's name and bus ID to DVB uevent variables
Date: Tue, 20 Feb 2024 10:46:01 +0100
Message-ID: <22e1d85d8896681a3f3f9abdc323e634b49fa1fd.1708422122.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708422122.git.mchehab@kernel.org>
References: <cover.1708422122.git.mchehab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new variables for uevent, helping udev to be able to setup
a persistent name for the device.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 733d0bc4b4cc..01227c695cbd 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -1064,6 +1064,8 @@ static int dvb_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct dvb_device *dvbdev = dev_get_drvdata(dev);
 
+	add_uevent_var(env, "DVB_ADAPTER_NAME=%s", dvbdev->adapter->name);
+	add_uevent_var(env, "DVB_ADAPTER_PDEV=%s", dev_name(dev->parent));
 	add_uevent_var(env, "DVB_ADAPTER_NUM=%d", dvbdev->adapter->num);
 	add_uevent_var(env, "DVB_DEVICE_TYPE=%s", dnames[dvbdev->type]);
 	add_uevent_var(env, "DVB_DEVICE_NUM=%d", dvbdev->id);
-- 
2.43.0


