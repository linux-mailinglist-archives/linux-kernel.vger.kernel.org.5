Return-Path: <linux-kernel+bounces-130352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FC897796
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDA1B2E9E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE216D9A9;
	Wed,  3 Apr 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBiYdCbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945E155A2F;
	Wed,  3 Apr 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164811; cv=none; b=stPsiaGJGQRf6QRNmGX8+AraaIiXPAmEp5elNzfH+unR//g6cAaPVTxSelvpKFfk9cNoNUq8qab4RQWYtCZ1XQ0ORXhbl73opHiFsNnNty/iC8ckv6OO0f0TVnqAoJDz3Rl6VFXgXx5aPPAbzlNzgy44kiIfDN9v61yYCAuOXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164811; c=relaxed/simple;
	bh=Q1bGa0DUfIsDSpZYcC/n2dxJH9DP2BQn9nJ5RASB7Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S51+MFKOM0EnxnSN4KI0ugFNUnBSyycyD6ya2vSIIRzLeuV3E60myMhlRLu0DCqwfjwm99xv/CGgvjyEWikG5o+3TZrd4izRjEaCLVhWRL42XzX/nAOS/ZeNV2G2vYvQSQ1KlA+ydxP7uJ3rwmPxf+qpyRPm4KtRM5qubphWUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBiYdCbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F398FC43394;
	Wed,  3 Apr 2024 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164811;
	bh=Q1bGa0DUfIsDSpZYcC/n2dxJH9DP2BQn9nJ5RASB7Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBiYdCbIDLSgSu4WhWvolmCJimuUHW6i3g6ntda1quQsUs8IF5zEBEUCIsQW0yXhE
	 wXMvBzErd7VufFzWRkXXXQEtw7WAq4YbQPPsBWhxGpEZYDc6ZxBr+WyQBgKfIbyd2u
	 ead5lWpeyH70KfiQUJD3wRx50DnQ3uTkyqeDaJcggzrhiACZPXpP0xo0AFq+kjt7JQ
	 ygI8P9zuYfsxCLIUtFJT/24P1mvqCQb/9wFDzrnaWVrKQxMHb3e7A3iBIpbU/PMdQz
	 Fg3r3uvPnY86YPKQPzez9m3mNJOZ/CaAZk97IuFfiwmDA81at+FyQKpXCHw1d0n0zF
	 cpGu2+mRXrxqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rdbabiera@google.com,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/8] usb: typec: tcpci: add generic tcpci fallback compatible
Date: Wed,  3 Apr 2024 13:19:57 -0400
Message-ID: <20240403172006.353022-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172006.353022-1-sashal@kernel.org>
References: <20240403172006.353022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 8774ea7a553e2aec323170d49365b59af0a2b7e0 ]

The driver already support the tcpci binding for the i2c_device_id so
add the support for the of_device_id too.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240222210903.208901-3-m.felsch@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index e34e46df80243..33c67adf7c67a 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -732,6 +732,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
-- 
2.43.0


