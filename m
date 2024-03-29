Return-Path: <linux-kernel+bounces-124769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BCD891C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A731C26969
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED71181BAC;
	Fri, 29 Mar 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1V0rISx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB78148315;
	Fri, 29 Mar 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716110; cv=none; b=lC1QHXkCJ0e8MVkunIHpGe/2W9okG31DCdwbzI692PsLC6nlAQyLgFeentt5pxiqdTiKEch/1d901DXxDZ6aHo1nsQ5vCaJ6JLx0jQGG9e23Fk+w+bGxUC6UrGxyAvFSLaCn39pVFBUhFjorVfPX1lTJBWz8rsBzk7wQZ5cweFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716110; c=relaxed/simple;
	bh=V4bDS2RxaQJRAuNI95FSliMiLBgmhfekXfxx+cqz+VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIrvHF5DNjEX8+2Tr6kNSwk621qJYtAkJEXAKV92JFQtNdChQPQTYKcXA8rJuX90ndaFpRmnmgapWBk12Z066pVmuzo+HbUGBa+Fua75mp48oHyOJzFXIAesFWYQwuNa60yKrkqiFdci+MkYMrbxoJMZ+ViMKjmKDmL8W9s7mWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1V0rISx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2F3C43399;
	Fri, 29 Mar 2024 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716109;
	bh=V4bDS2RxaQJRAuNI95FSliMiLBgmhfekXfxx+cqz+VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1V0rISxirWDhfcAd6BCOML27N9PbSTKvXNP9i4lNMWLr9PhHakRl3gE/p49VupTx
	 mxD8oW2ANTPGKzbuQJ7nCR1ZpXSXUZ7vPCJqekNY/KsdFtcxpNCGtuIcZwqMSFxdl9
	 IbqktdD2smFPdho070btiE7VJSp83wLVOaGQ8fj9a+EAGcj2Y/2h5TRcAeAa5s3J9g
	 mnY35eK/pqN8Jf8iIQxPJjqZ6LFM3/dLpr3wcaxkpjP9Rfb83tTf2pt7nmUluKWK35
	 Fruk6DRH90u+e3gLifL+io5+GS1+l6A7GjhOvQarwstv0UdKcXx2JXfpSm5X9GbZmZ
	 CDKQhzA1tE3fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Koby Elbaz <kelbaz@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ttayar@habana.ai,
	obitton@habana.ai,
	fkassabri@habana.ai,
	dhirschfeld@habana.ai,
	osharabi@habana.ai,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 59/98] accel/habanalabs: increase HL_MAX_STR to 64 bytes to avoid warnings
Date: Fri, 29 Mar 2024 08:37:30 -0400
Message-ID: <20240329123919.3087149-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Koby Elbaz <kelbaz@habana.ai>

[ Upstream commit 8c075401f2dbda43600c61f780a165abde77877a ]

Fix a warning of a buffer overflow:
‘snprintf’ output between 38 and 47 bytes into a destination of size 32

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 2a900c9941fee..41c7aac2ffcf9 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2547,7 +2547,7 @@ struct hl_state_dump_specs {
  * DEVICES
  */
 
-#define HL_STR_MAX	32
+#define HL_STR_MAX	64
 
 #define HL_DEV_STS_MAX (HL_DEVICE_STATUS_LAST + 1)
 
-- 
2.43.0


