Return-Path: <linux-kernel+bounces-113208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA0E888252
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B009428D213
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6417E3B5;
	Sun, 24 Mar 2024 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feaTqofB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D865C8FE;
	Sun, 24 Mar 2024 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320010; cv=none; b=OQN1RFRN9j2IgLNUHiHMSetXrMdS0BnU+QaTRb060HSHmH1MNJ6SPFTRdlOQ9L72zIZ5jCd+EaPo077BRRZJheDsx6Xe7hJhigkCdqwCt4pqUB0tR5ZBEW9iYO2U40up/cT/zLeYmvLtqbr2PyhnNFxpwEeiY0sbY3/SSsRrgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320010; c=relaxed/simple;
	bh=36c3PdCk3dmv9ATi1Ur1ycwjHJ3q6K33jYl8d79ERfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alYNFwntKb16zWvF4QltrjuR4Df1sdL7I0uYj0xzUs+vlbFwHrdzILK/Vie2qO/DtJ9uJk6wJDHx9IP2JeJ9oHeNfZ/ISVMfLb7eVBN8kquCNEdPBWo5qfDWpo+eiP0QqYfkCZS/tqPWzMBkc3e7ALGF4WIGIym6d8z+1FYTLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feaTqofB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2773AC433F1;
	Sun, 24 Mar 2024 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320009;
	bh=36c3PdCk3dmv9ATi1Ur1ycwjHJ3q6K33jYl8d79ERfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feaTqofBFW+tTsRuBBb777SJH5+qCGCW6jfiAl257mXzabB7FeIckj50jBI2KQEZE
	 gPw+UUhCj5/kEIUaXU64A6sdFWwUPmqf1Cwv7VH0Z7idsktZp0wSo4lgdZ2PSs1j3o
	 wiPCKsBpMNhZ3lwhEuvArt4qd7EJYs05GKVPWUFCMdGOOzbJewPkcc7KBa+KidNWmN
	 MihF4nH20FEpGgHmEXeVay7ZzO0dBToYOQAYv5IDKmaSvz7oBrEq5QjgGWFYc6Wcfx
	 6LrmiPkF3RYps9CejMBCUUaJkw/i/sjVs3YAkLLKhXCKjvDYIkh9/o+1/eSQ5tMVkr
	 XGJUW80RCmWdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 317/715] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 18:28:16 -0400
Message-ID: <20240324223455.1342824-318-sashal@kernel.org>
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


