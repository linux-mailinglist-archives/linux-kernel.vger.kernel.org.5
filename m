Return-Path: <linux-kernel+bounces-116350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B48895FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9361F1C2FA34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9399D184F1E;
	Mon, 25 Mar 2024 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXloHjDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113822F4FD;
	Sun, 24 Mar 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324375; cv=none; b=GKA1LZtD/6LHQ2OVnanfbd1oxiuUjVW8wNxJnRdrD5YSQjptTvFKNttyM/2n3MArKhEkTq18La6j8o1LfXqnnfjcdX1Q8+Etatbtd6ZnF+cxhpsIYJaoJmhyQdIFwH526mQiiBuoVEDsNrTFYIsuo5Rw0MproTxVgpHZe/3+OHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324375; c=relaxed/simple;
	bh=enmPEvNCBlIwV8Fl86Ev3ooXw4ze2iMs+fMseQtNmSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMy3ULkgjyIXJ/LRZGkceQsU78n5jHFFo08V6YxmFiQ5H/+QSGuU+nLMzdGr6zZjh7Ar3s5Ytk9lV6/w97Qx6CvGZlu2+0hM/ypl0FitJ51A62YqLFFGKOs3Dd910l1UKjgpfaFqLDZbJ3mytQV0bQytZehQCZSeXsroDMVkqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXloHjDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC244C43390;
	Sun, 24 Mar 2024 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324375;
	bh=enmPEvNCBlIwV8Fl86Ev3ooXw4ze2iMs+fMseQtNmSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXloHjDeXIHhLvqQjLmoFvYVjbYX6WIN5GAGZNyGdJH/lMG7Ct2i/up+AfueZhEvm
	 dARxtr9/zY25Qnzn2y97Hm19IAA8Chf+Mxx7UVTEKDX8mk+H2HEAYp3SmH/fw973bw
	 VDqFLd8WSU41lrrFOmoyueo5KNTkWuTKkaGyOK1E0kz8v6BdukrLhl2AYMYd4MLci3
	 JdiZuj71M/gNV+IiEPaMMXXCQwrh96JNdZkj0uNgE/z9TIRkpxIR2xIPhltmX8FSYk
	 v9kbVj/EXJpBd3aw/740Bm5NZvrOLf/SdZ9/4/7Aoy5IlLqJsR3To+3XSEeu6NrUnR
	 0Gs6dLWeHAtbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 141/148] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Sun, 24 Mar 2024 19:50:05 -0400
Message-ID: <20240324235012.1356413-142-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 077fa9304618d..2004442d791cf 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2638,7 +2638,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
-- 
2.43.0


