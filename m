Return-Path: <linux-kernel+bounces-130305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D7897698
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CC1292D68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E5155314;
	Wed,  3 Apr 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCWitntS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B795158D93;
	Wed,  3 Apr 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164696; cv=none; b=iXzowNbEywYy46Ji3emyyZZ9opLre8li0+2NzN1MXsltyUeYWogoT9LqpYuO64YNiqPQM9lwRPIm88fYzhP7ZDk3glgwl8BDCw5ZCKJe9rdJbzfbui+04IMo5iCTe5MGcormrIQb3JziEWEbdwtKsD3BlSiBdTyiP1+yaBEw/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164696; c=relaxed/simple;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDQFP/+RE448+8O7c9sq7axUsB96QSADh2+D5guwhpKAIzCMKxRUhEEyIUUsUIUegc+ttLov3A3cJ2a68KFMF1/c+eW3r/AqMdQeBpAdy88zcD58wH5Ph3c29viCwk6eb/EEV6fSF1shOSA7q+s8I5Y+SSUXrN0A2G+Txz+tDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCWitntS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E764C433F1;
	Wed,  3 Apr 2024 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164696;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:From;
	b=rCWitntS/Kmz738F/mtyUAY21cHEMGBwnAdp5x7Ub7Li+c4PcL7jMvmPm0cDcvwT7
	 AjTbQQqPdkBr3SDGMpMs9/wz61F5Zwg//OaKYdYu89EaoYcHF3AIX8Azvwp/0CNO4R
	 u94IRdb2suKXOSQyvcerO2qPNUFaplOYboua9dWeWyqqWdNZMCm0L5qFKjVjF/8zh+
	 qeOlj4QWwq5LXXt8ECfI4rpK6p3SfJMQRk9puwNVVeJTJTjfMNQ6taLHc0tgSI17gr
	 ITHpiCstm2XeYh7diN0i3OmJ8Y4ix3ZV6iguGyFbD6kpmMl5bOwbjyDBrsqALFzbpK
	 7Ex6Trc9F1mAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/20] tools: iio: replace seekdir() in iio_generic_buffer
Date: Wed,  3 Apr 2024 13:17:42 -0400
Message-ID: <20240403171815.342668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
Content-Transfer-Encoding: 8bit

From: Petre Rodan <petre.rodan@subdimension.ro>

[ Upstream commit 4e6500bfa053dc133021f9c144261b77b0ba7dc8 ]

Replace seekdir() with rewinddir() in order to fix a localized glibc bug.

One of the glibc patches that stable Gentoo is using causes an improper
directory stream positioning bug on 32bit arm. That in turn ends up as a
floating point exception in iio_generic_buffer.

The attached patch provides a fix by using an equivalent function which
should not cause trouble for other distros and is easier to reason about
in general as it obviously always goes back to to the start.

https://sourceware.org/bugzilla/show_bug.cgi?id=31212

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Link: https://lore.kernel.org/r/20240108103224.3986-1-petre.rodan@subdimension.ro
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 6a00a6eecaef0..c5c5082cb24e5 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 		goto error_close_dir;
 	}
 
-	seekdir(dp, 0);
+	rewinddir(dp);
 	while (ent = readdir(dp), ent) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
-- 
2.43.0


