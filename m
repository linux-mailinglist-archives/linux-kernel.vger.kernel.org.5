Return-Path: <linux-kernel+bounces-123243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438589050E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5C1C2F9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B626137C2D;
	Thu, 28 Mar 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7MxqkSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3BB132492;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642927; cv=none; b=pLLN6BwNRlFxUY+PSKKe8DMSecAhWV9UFXadyHzIuDo8xj2AJpa+ls3h77dJfp8qmOHLphZ8gvWaZRQjr7dicnIO8yPK/DpDc2zmob5UQ8XDMH9d3Y99XuAv4jw88kDMxHt9HSnJGf0n0SC7ozEa9B411luj/nTTo+Q0oS0FTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642927; c=relaxed/simple;
	bh=Bnj4G9XpK1owNLhcShj4KfI60tdpeJg4h2+Xkc762g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBpwFHRlG1KtWfMV4n96IWOmM7ASfWlUC/7mTZra+LvP1S16NTniSDgtdlONyJy3PbVOovbOPn5lBFneBUqkciOC5qVe/tgCPYZBfqXc96pmwPQe0JmZ3WzzQjg+UHI2hKhZ+VjyVdILj1Mxk9zmFluD7Ndzz1YrkkzUnaCHAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7MxqkSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB9EC41612;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642927;
	bh=Bnj4G9XpK1owNLhcShj4KfI60tdpeJg4h2+Xkc762g8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n7MxqkSO//mrVKCmYDqxppoYKtZlKQ3LNPbWW+t3Xn/GpU3VMYBdCOy3JxSkddJq3
	 yL4lDqzi5umlCONYI1Mnk538nzWUVeAmxr4UZpjCe7tcHvCrMZfco1MQ/khgpSHQAY
	 26ZAXSFD+3H8nNTvlf7GS2BlXVgp+tyKnfKQMKZbQft1S05DrqLD4cLFFKgUdfyi5S
	 bSHaZsefqY2sbW8GDjPLDC0kdhzfXWwDC2Re2Mk4H2xYazUlw7wG2Jt77WmQbP8aMi
	 pf0W1XBWISs2cFr8drYHd4a5LBXnlikR5hPxyqPoDpqlxCXSzrYa/WLpWMu+3NAweB
	 wHjBjp56VMFTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF7CD1284;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 17:22:05 +0100
Subject: [PATCH v4 5/6] iio: backend: make use dev_errp_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-ltc2983-misc-improv-v4-5-0cc428c07cd5@analog.com>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
In-Reply-To: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jyoti Bhayana <jbhayana@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711642925; l=964;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UI9LYwYsbzsvYImq/LHr54gyhLBEwgpl2jvt1KqrE14=;
 b=l04hnyfmitT+Wc9CJrsYi+vxjlfokLbKdPEhFV9RWHo3uTK/Oc+B5oE8Zqin/iltsRFq3jV4X
 Z/YjBSEYriIDM+VyTSF3MM88ds1JoMh0zkeVGDvS+BqmmGPR5T9C6YM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Using dev_errp_probe() to simplify the code.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 2fea2bbbe47f..e0b08283d667 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -296,11 +296,9 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 	}
 
 	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
-	if (IS_ERR(fwnode)) {
-		dev_err_probe(dev, PTR_ERR(fwnode),
-			      "Cannot get Firmware reference\n");
-		return ERR_CAST(fwnode);
-	}
+	if (IS_ERR(fwnode))
+		return dev_errp_probe(dev, PTR_ERR(fwnode),
+				      "Cannot get Firmware reference\n");
 
 	guard(mutex)(&iio_back_lock);
 	list_for_each_entry(back, &iio_back_list, entry) {

-- 
2.44.0



