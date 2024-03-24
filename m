Return-Path: <linux-kernel+bounces-115441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5308896DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE741C30706
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E3213454;
	Mon, 25 Mar 2024 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS/j0kj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B59128366;
	Sun, 24 Mar 2024 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320795; cv=none; b=PQ/PBv1NsOXuKd9LCRk4K6V2RblnK23Wy3F/tXTQIdV5UdCTzVQ3djNkmkGffghzLjBB8Lunw5Hm9JJ8y9ayqzpCXyYdP5sJ1J2o6NqE1NZzbSoj5tmjGa7cQkciKSWhO1Zn4hM7/KGhUltSWwXjtlARJ2zPh5qRGmHn+ke5zr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320795; c=relaxed/simple;
	bh=36c3PdCk3dmv9ATi1Ur1ycwjHJ3q6K33jYl8d79ERfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovALxmQ+/LqulpkA6bB99X5lk5hW1Tl4Yh0qVaZNXUUOSu8VTqI0jskr8Q/OoKfQXpgumRPbPAgUMECCx5a4YEZEd8Ic8Tn+CqGvjsDg1dI9+BjS2LSIPEPrrmVzDSaFybNZsdAj+fxFNJQ/+1lgZH81NXH1/m+3Q4YqorwuOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS/j0kj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA411C433F1;
	Sun, 24 Mar 2024 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320794;
	bh=36c3PdCk3dmv9ATi1Ur1ycwjHJ3q6K33jYl8d79ERfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NS/j0kj2RJPFtFVkdvyTNLEcGnSCWcfKucaIbLmYFvJULI4ePsAE9MpOWmn+AvKQ5
	 9n7SaxTBJmSDxFWOsoMa4NhZKH5jC+L6bt6CmwOrLTlcItJHuINi+Mx94+dH16VPmO
	 wMhj/0x5zUZZSwn/nRi4BDxbOW7vRXyx/Yk/fU0tGVtj8Z7MaBofRO4IiUgoyzR+9X
	 UAaGY2oAJDqondIBt45/Wrp6i9ahwa1gv80cMOav58uNC71wjpfcQwZyS/EtpCY3Hi
	 QAm/t4y0tFQXmkuS+HCvjJ8h+0vFz6+Lk3MGuzcUw5/FgQWsrN1KWnO5gWTcQXMd+E
	 GEzAn2vN+zxgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 358/713] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 18:41:24 -0400
Message-ID: <20240324224720.1345309-359-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 07161b2416f740a2cb87faa5566873f401440a61 ]

Add check for usbnet_get_endpoints() and return the error if it fails
in order to transfer the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 19a38d8e0aa3 ("USB2NET : SR9800 : One chip USB2.0 USB2NET SR9800 Device Driver Support")
Link: https://lore.kernel.org/r/20240305075927.261284-1-nichen@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/sr9800.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 143bd4ab160df..57947a5590cca 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -737,7 +737,9 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	data->eeprom_len = SR9800_EEPROM_LEN;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* LED Setting Rule :
 	 * AABB:CCDD
-- 
2.43.0


