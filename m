Return-Path: <linux-kernel+bounces-27793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B333082F600
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0FC1C24117
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8623750;
	Tue, 16 Jan 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrcmEIFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9923742;
	Tue, 16 Jan 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434210; cv=none; b=jcdmm0bZI9Jsb+xzHHyxAB1Le6iFYVOgE74qv2FudnXOSO4k1MbIp3OnIjkoWQjVkDPsPTKNL+wMWRNIrQaqAK7dTKAzaBvEOhLvgmIPNQ9Au1jSK9ctptGYdvnarQjdDtkhS6ke5mdJrD74ZOvJg9Orxoin6iKfPNF12xxYXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434210; c=relaxed/simple;
	bh=ACQuwnrHOOPZAyDz3qTaDrzWugOxk+sx/8S41lB1OVI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=HAzKxziwfIdPTbK2Ge25plxUPHZn5L1I1LlLgXuPO4ScbqGHgXqmwrL0ni7iI3w4LWz5PRKSPrbO+JnnxSNTHC+5HU6xqr5RjO3igrNxplhSk1FHcrxPq/Px+IUoZD1mynkE7fXnB6lczwR5TfiVh29NUV1lHab+9ELvs02XfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrcmEIFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A70C43399;
	Tue, 16 Jan 2024 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434210;
	bh=ACQuwnrHOOPZAyDz3qTaDrzWugOxk+sx/8S41lB1OVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrcmEIFpaWKjGjypDVvSWD5bNsQ+9dba1cq/Qby0b/28rNGA00T9jX02FYtgPR++M
	 vnHzcVG1kZyDmUaNNgYYdTxGZNpQuyPJxqHdPuwUN48KzEsc0eIKxrV7zH04S0jrg6
	 j0yENBr/Iag6lLjbS9GTW6LAKL5phxLxdVbzzqy6pkU6YmdXkU8sotO7gSyFIzRNzo
	 Jko0Ih83RHFx3ZoN8jbvOxFklAAFS60+xtNrNK8tYLYYnPg8+lnGwgYTiKTKKGCExy
	 QTb/9UVFZmyno+Lg8WtCRJ8MijxJYXI+CBy5xXJFTMiKaJK2bDI08GUb2Si2gy5rY0
	 2+aFg89El7NtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Herb Wei <weihao.bj@ieisystem.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 023/108] net: usb: ax88179_178a: avoid two consecutive device resets
Date: Tue, 16 Jan 2024 14:38:49 -0500
Message-ID: <20240116194225.250921-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit d2689b6a86b9d23574bd4b654bf770b6034e2c7e ]

The device is always reset two consecutive times (ax88179_reset is called
twice), one from usbnet_probe during the device binding and the other from
usbnet_open.

Remove the non-necessary reset during the device binding and let the reset
operation from open to keep the normal behavior (tested with generic ASIX
Electronics Corp. AX88179 Gigabit Ethernet device).

Reported-by: Herb Wei <weihao.bj@ieisystem.com>
Tested-by: Herb Wei <weihao.bj@ieisystem.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Link: https://lore.kernel.org/r/20231120121239.54504-1-jtornosm@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88179_178a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 5a1bf42ce156..d837c1887416 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1315,8 +1315,6 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	netif_set_tso_max_size(dev->net, 16384);
 
-	ax88179_reset(dev);
-
 	return 0;
 }
 
-- 
2.43.0


