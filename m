Return-Path: <linux-kernel+bounces-40025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C985A83D8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C61F24048
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859EC1BF30;
	Fri, 26 Jan 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dEstBjlc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DE1A29C;
	Fri, 26 Jan 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266914; cv=none; b=PHFgcMUeDNFUrwR0f27/SEOI4UVnMWXUoVAhUqpjOLS15B0KJsswY1WHfYI4/YpLB352/k9yp5uRDx4HBUAapDA9r7J5TRNPFtevYTO4MyiWPqXtnf+WRVjsq/EegfZAHj13T/Mge40vzq4K8uAZPsZ9jMFeyib1zCMFCnqNoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266914; c=relaxed/simple;
	bh=pOBMf2guesXNH6vUwvSx6EUngxizNRYUxTMvSY6wvpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdpjXAH4pffCdbwxKGS2BjuYYH9m7QyLsN2zdt6ZwXFaYOlcjGaFvYt0R6+QjyjDuN8beY6ErUzOkFZm9HVO997o3g+SdIKFx8EKGc8FCZa+D/MgHMh/hFo62TZm1rNThBKzmEGmRk/ekYtsGdDH4L+V5z6tVSSZY9e7pOQiiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dEstBjlc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266911;
	bh=pOBMf2guesXNH6vUwvSx6EUngxizNRYUxTMvSY6wvpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEstBjlcD3+4mFr9UIIOSCZBxaQSHrRK0bLFmQc87Bo2bORBINesLDySwXan+1Y1E
	 AVyAjeVjHxoQCcOy10S6fQmOBTABMKYIHmOvHU6XzE/8YkAhei46KypJ+oqRjg42o0
	 mtUyH8IfM5Ztc5KbARJePofWZVRtjxWrWn67GOBKfNpSpr4W/vBQTjw8Khup7nFMoO
	 otE0el+oMHpViQFTqx7zsl3/LlwmBlB8GEZCiPXm+NW1HKGJo7lFCQBFvA6dGsCkvs
	 XRr1En/msHXymHqCZdsJWRai17zXhneKlwT+nRV5uPHJQj2KowTQEdoXK5EgNxgFhp
	 2SSEUXhQYpT9Q==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4DA463782072;
	Fri, 26 Jan 2024 11:01:51 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 9/9] media: verisilicon: Support deleting buffers on capture queue
Date: Fri, 26 Jan 2024 12:01:41 +0100
Message-Id: <20240126110141.135896-10-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
References: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to delete buffers on capture queue because it the one which
own the decoded buffers. After a dynamic resolution change lot of
them could remain allocated but won't be used anymore so deleting
them save memory.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 941fa23c211a..34eab90e8a42 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
 	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
 	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
 
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
-- 
2.40.1


