Return-Path: <linux-kernel+bounces-116329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF48895F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED45B29A2E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1CD29BAE0;
	Mon, 25 Mar 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMqX1Vz+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE313280B;
	Sun, 24 Mar 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324310; cv=none; b=hi/D5U+gEKwg1Qspr24idqLuBXE2sUNsX+T84Jix01sahGYqAUWBORzM9a+O1IduJxyiEc6McXT+1oK+qsqH883Md9OIODy/W26u7xB7PeT8ngvDntHToJyMcS/5Yuvb0++2VuHslzmlZZ0g+3Kax0v86nkxtCwXsqw7qaRqG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324310; c=relaxed/simple;
	bh=E3ev4s0/MWK6GrCYFP2vej+WNCRhvaN5iAa8vNsJbHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6khlqh9iWJbzLZS1/I3XLqpeqiQzE208WCo4dA5UjwMf/QSDZnCUhcmO1RVpdKBUe5EeAF/xKduFZPAvzzybVhahRkkm0eD8LiXbxJCvhj8QFJ5UzVAhL/2sKnk5DVKszTVnol8b52sIaMP/sNOCAd5Kx4BKLpppf3NjeEBaIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMqX1Vz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C39EC43399;
	Sun, 24 Mar 2024 23:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324310;
	bh=E3ev4s0/MWK6GrCYFP2vej+WNCRhvaN5iAa8vNsJbHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMqX1Vz+xQtUaYwh4PadyzErvDFF60iTgL18lEd28FWyR+04ABCeb6Qv/pu8QW2N2
	 6QIWisSyyrJBgVfDkvPlOkeY6cxO+nkRggbS8Tu+sGfVWnWdXLh8m8jC8HMpAhbQUf
	 IMqsqwwNpxoho8KHo1xGD6/JRnvM/ltnxcRnHCiUK6JeoN4jNinDgT+QzrMWhKBwOd
	 UY8mDNykoAjmRn0FaiQRE0zu74kFM0EmIfnPOuvjYgVEsWJPKLs0FPGbb2fqezadKY
	 SrOxn8cCj/ECcA2HLuOi8CF+DFSZy/3j29lFjDjgyTZ91g2/hE9XU5WnyfpQEr/jk6
	 2g5dbMBw0uIoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/148] media: dvbdev: remove double-unlock
Date: Sun, 24 Mar 2024 19:49:06 -0400
Message-ID: <20240324235012.1356413-83-sashal@kernel.org>
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

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

[ Upstream commit 122d0e8dd050cc5dc3fb9e9b5f2dee3c5276ce35 ]

As warned by smatch:
	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:529 dvb_register_device() error: double unlock 'sem:&minor_rwsem'

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Stable-dep-of: 8c64f4cdf4e6 ("media: edia: dvbdev: fix a use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index b8335ede66264..1f80c4fa31c9b 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -536,7 +536,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
-		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
-- 
2.43.0


