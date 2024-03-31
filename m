Return-Path: <linux-kernel+bounces-126022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045C89310A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFACE282907
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F472757F2;
	Sun, 31 Mar 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmZ0Zyl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A92566;
	Sun, 31 Mar 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876667; cv=none; b=fyHBNmAe3ac56n/5CqqelHnfget8vQZGeY7yAov0v4B/T1Ju5kAI7TuECct0uNuDcw5lSkcrT0BHBYxyjkt0SRD2HFrPoH2hrYfTWGOHgun3t1hPbZogqKDilPBU9b913QR5jV86rC0Gmp9CaatqhGbC937/Hcj56z3Iqn1YXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876667; c=relaxed/simple;
	bh=VzdFzXRE2VaRW7jFZgwq93tJA5xuLG9fPdxBzjiMqvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YmNANHbA5BUEVFjZCnVs7h60yVzrgbTjLmYXRko0xijwQE0pxKoYCJ5KbhnJGlgccU9qHMaKXw3U9X9hNS578bwOousxHFfDzphyznK4vPjNNoAaZCbiabvheVut1IDtnaE0eVA1fwb9GHziYCyDUbljCAVsQmS1nT4MbgivYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmZ0Zyl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E617C433F1;
	Sun, 31 Mar 2024 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711876667;
	bh=VzdFzXRE2VaRW7jFZgwq93tJA5xuLG9fPdxBzjiMqvM=;
	h=From:To:Cc:Subject:Date:From;
	b=TmZ0Zyl0dHghbpysYElex7UbdbqFMjqVZ9jfc4of38vp92x2Ggicmbza02ifRZyNe
	 1TQOiRfyYJy90FHAWMK6pQxIo4xQBQomixhiDa82oWD7APSNNNfuIVaDHX+yN9Ds2A
	 hqnywqXPFnnoubHSKvEAj+w5VFPm/MR7IPQ5fqL22XyHGWtPMLooJXOETsJq/sD6Ex
	 lTHuYjdGOvWTbWcERl+3lJPyTmBXVvrjy7EQDPW82+o2K8JCIXW3Y95nmH2txcoA5g
	 IfXDZg2EoKH9SLDB70edXR9gwvhGRWUFHaDKCR02wzl6XPPFkHZX9TH3ztnlKcB4Ig
	 ukevB8jk8ZHyw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/3] usb: phy: fsl-usb: drop driver owner assignment
Date: Sun, 31 Mar 2024 11:17:35 +0200
Message-Id: <20240331091737.19836-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
---
 drivers/usb/phy/phy-fsl-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 79617bb0a70e..1ebbf189a535 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -1005,7 +1005,6 @@ struct platform_driver fsl_otg_driver = {
 	.remove_new = fsl_otg_remove,
 	.driver = {
 		.name = driver_name,
-		.owner = THIS_MODULE,
 	},
 };
 
-- 
2.34.1


