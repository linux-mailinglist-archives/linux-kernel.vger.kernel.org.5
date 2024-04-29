Return-Path: <linux-kernel+bounces-162430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D148B5B13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E89728114A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181077B3E5;
	Mon, 29 Apr 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu3anpyg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CD9468;
	Mon, 29 Apr 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400254; cv=none; b=Ez0CiQD5O3uUXKoPzH0wPgzJTaxr5tRAV+wRs10qHIxGlAjq3UX9MNjU1fgEdxGTrdxkRumh8N0TMxkpDZ77dhWGBcVGtUvSOa0yVw39VxSIKEnZzbpgPL5LLJhesO0Myb0sx+3IwgNItfoHCeOTGYHEM03xoFmBU8o9bxL79zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400254; c=relaxed/simple;
	bh=nbkcu9WSxSxs8Z+1fSlDgrLBT1svm3YEGiy60ntZPH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvsjghqAALcOToht3ONAUKR+BtW99sPQz+Mp9ss132c+5Gmya2bw6pJ4EMPw+i+KJdCAh7b8SClnptUV27qJUX6w9i8ak5BPvHCpwp4pM61mdUr/WeSEfkx7Z4wcnyfn2cJZ+Ibc7ASCxvOYXAJc78DnYjrr0VyX9doY2oCW1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu3anpyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D620EC113CD;
	Mon, 29 Apr 2024 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714400253;
	bh=nbkcu9WSxSxs8Z+1fSlDgrLBT1svm3YEGiy60ntZPH0=;
	h=From:To:Cc:Subject:Date:From;
	b=Vu3anpygTqCpnZJAmEI4qV8DhN+cW+Rk9uJ2LPD/dw1DT4Cpv0RYXj1PhzMSdQlVt
	 PBB7JR25fVzUZw3bZcUJpzRMWU0bfBkUyyendT4NBZb7Bj9gTrdBbJsfZbEctspISs
	 Q5ZKByuXX/DtUqAxIPRQhp6VD3Qvrk9u8texwXwzezJy77o4jkjX0OzWJh5rv2AmBo
	 3557txnCpBInPIJSLGLMzF+r0VmCnHUTXOuBws8S3N9S2ugku0El1iLH1b7FeaHit5
	 njCEVpiObAKVMAwidcOTLapx4oxGu/4G6JLleAScSQbPAXoVZ8WxKmBJkZYD7IXDQ1
	 y0C7UnVvlPBTw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1s1Row-0000000C11A-1gJH;
	Mon, 29 Apr 2024 15:17:30 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Hans Verkuil" <hverkuil@xs4all.nl>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Michael Bunk <micha@freedict.org>,
	Wei Chen <harperchen1110@gmail.com>,
	Yu Zhe <yuzhe@nfschina.com>,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH] media: dw2102: fix a potential buffer overflow
Date: Mon, 29 Apr 2024 15:17:23 +0100
Message-ID: <989d1befaf0ba99277ad7b1f6ef2d454afa6db51.1714400241.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed by smatch:
	 drivers/media/usb/dvb-usb/dw2102.c:802 su3000_i2c_transfer() error: __builtin_memcpy() '&state->data[4]' too small (64 vs 67)

That seemss to be due to a wrong copy-and-paste.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/usb/dvb-usb/dw2102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 03b411ad64bb..79e2ccf974c9 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -789,7 +789,7 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 
 			if (msg[j].flags & I2C_M_RD) {
 				/* single read */
-				if (1 + msg[j].len > sizeof(state->data)) {
+				if (4 + msg[j].len > sizeof(state->data)) {
 					warn("i2c rd: len=%d is too big!\n", msg[j].len);
 					num = -EOPNOTSUPP;
 					break;
-- 
2.44.0


