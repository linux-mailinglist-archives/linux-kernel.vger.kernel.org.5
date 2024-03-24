Return-Path: <linux-kernel+bounces-113524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE8888505
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95981F228F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3E71BE7EE;
	Sun, 24 Mar 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZTZN2gr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97613DDDD;
	Sun, 24 Mar 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320326; cv=none; b=eRRLbbieaUUwDA19QkKvkRoVT8e//3EHS+zFD937Ij7T8iv5lHpXLtQXG/BBsbsIdMG9j6kHmJJsYWK0aXa61gcoxRM3+8kwv3K/VWu29EQsVFDujLI2P3BLRpL5aXDwlTOLceaEVArPMYUXG9sO81rIzbUuvfkpm1eFLjuNYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320326; c=relaxed/simple;
	bh=UC4iSRp+k3B2QXRMpvz/N5o6qCS5pztBlHZU2CKkeCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bcbum84flnrsrqJjBOs/upQnbCYhlpo1FlQqQ0PjaZv6sMYVjTsLLweOaItQozq4ceWytKxANeI/m5EJ7/fdEqhUPpQLJfAy5cVtuNEOlMH8s1Q2caSe/YE8VL/rcUI+VgHFp4ofLq5xt3LMiqu3ejx2LEjZzUhV863qapkPiI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZTZN2gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A8BC433F1;
	Sun, 24 Mar 2024 22:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320326;
	bh=UC4iSRp+k3B2QXRMpvz/N5o6qCS5pztBlHZU2CKkeCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZTZN2grvqjTes5c6K320tcTrf5tXP7bRiR+f/7ZjNRB7+f7KzXLKpnYj1RIdcYJE
	 Q3ImAc/Aqlo11ECrXeW6pOh9FHrn66l3BGM29tpHW6VgfluMJ77I6RTtcRsweQdBRc
	 GrtfnauNK00Ii3UHKb5nQFc20phy3H4O5L7RWyvU1lly1dO52oIInwBj9UX9WW8Q//
	 IViG3cZZ7BZr0ixH8u32P76GTOtiv3nkXkesTok7Jt7I2QAozivSigbVJRZZuylc8I
	 4rDYaxe6NvHFvpOE5Kvpouf3T24kSlDQejELc1n7TV9Cemw63Dt5Yg7rDsMm34gFks
	 1zfiZBBK+Ajsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 633/715] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Sun, 24 Mar 2024 18:33:32 -0400
Message-ID: <20240324223455.1342824-634-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 600556809f04eb3bbccd05218215dcd7b285a9a9 ]

Currently the variable irqflags is being set but is not being used,
it appears it should be used in the call to net2272_probe_fin
rather than IRQF_TRIGGER_LOW being used. Kudos to Uwe Kleine-König
for suggesting the fix.

Cleans up clang scan build warning:
drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
set but not used [-Wunused-but-set-variable]

Fixes: ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device controller")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20240307181734.2034407-1-colin.i.king@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/net2272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 12e76bb62c209..19bbc38f3d35d 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2650,7 +2650,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
-- 
2.43.0


