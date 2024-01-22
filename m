Return-Path: <linux-kernel+bounces-33565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E48836B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215321C251A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81315351B;
	Mon, 22 Jan 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruGB0nFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D315350D;
	Mon, 22 Jan 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936741; cv=none; b=j1XBqLgd1MgrLrFn9xHg2DHo+jqA7zu/OTrDxJrb3frSCi+GnI/kwr/I/pc7f7D8/gw5b6Bo6LHDekRjKea8y3bYl0IbpKlufRt8jL5n6/ao+A2yX1RefB2bXjWeq7Rcs60x8nmPlYaloLKfcngT3FEhFPYgIf1n3LjRTtnNNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936741; c=relaxed/simple;
	bh=fBsdNgg9HntIGTa0Zx247NHn3maz/+IjkfhwqJBT1Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxPp9o55T727366dqg+tb1mjSPfOWMinZFGbnmMLpLs1unp77kPzPW9IGeNyJYiIohOowlkO4SSDOZ1yI9innICEPNYxDpW7lBVhqoD03gK2PwNdp6t+MK9GrcAJ3J9h+818yHp19TlP6SOUr5DNAweEP3lfHegi6nJwTQnUBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruGB0nFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F170C43390;
	Mon, 22 Jan 2024 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936740;
	bh=fBsdNgg9HntIGTa0Zx247NHn3maz/+IjkfhwqJBT1Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ruGB0nFFMFvdp+iMHbs6hYIGvqEILdXyPIm6LHOuG00FJi9YkPfenk5AMoX6dOzVg
	 VMu2+FzwTfJ40XAU0JQ2oGM9FfUFexgS1Cai/WobYJlkTDZUF/3YchD3J2+whuA+at
	 oBUoS2DJ5UxB0tVNqz/RJ/OtIhdyxfUinJ6bkNcUfyps7Z/bCClnxxZ4LmUThrCgju
	 m9zpaeZcirrSdOazD2u3lHeOg+aypzvTnxkNj/RSMjTlRuioPGT96EKAhp1VFQndFe
	 9mI57rRDKdr+NLCmr1S59wrclDZk44tFvKR8D6JjbpVkzB8DSqZL8yS9qtaSTg0vZi
	 qpnxh2aocM4Mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/23] media: ddbridge: fix an error code problem in ddb_probe
Date: Mon, 22 Jan 2024 10:17:56 -0500
Message-ID: <20240122151823.997644-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 09b4195021be69af1e1936cca995712a6d0f2562 ]

Error code is assigned to 'stat', return 'stat' rather than '-1'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index f4748cfd904b..7aa6c966ba0d 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -247,7 +247,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
-- 
2.43.0


