Return-Path: <linux-kernel+bounces-115552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B98896EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863E11F35D32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05024C336;
	Mon, 25 Mar 2024 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmuno7Pc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8201EFE59;
	Sun, 24 Mar 2024 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321054; cv=none; b=fAO4POHJ0hz55fRemfzpSVD0Qc8JuwsmZMwAmdmozCW6Ts0aGmdSLM+ovTMiM2pY+2syA1nmyFuqW494OnE1hgvcwRZi3HonjyqHMe3+G60pj6ju0/CBAzmRq0Gh3REL3TzZQAJ5m48VBUQjPFuLaSGYCZGVwomOZgk4UTyy2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321054; c=relaxed/simple;
	bh=U7g9Y0xZPvSe/JiBFaypvdFGXsPf97kTS1mDNLbllxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnNtl8RkFa7PYhkwAfKIg5CM7LtxusPabzvozH1F+CTBRuwfij2IoLBiOHBeM0oX1EPzjfTjRV70D4p6euDxcbvb0LzqGBRPuvAiSETojw5/LE5kdAPdV81q+SAv3syXovWJw0zUicNNMU6gLX+DuE5vcj0IMAw7u55zHaFl9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmuno7Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA6FC433C7;
	Sun, 24 Mar 2024 22:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321054;
	bh=U7g9Y0xZPvSe/JiBFaypvdFGXsPf97kTS1mDNLbllxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rmuno7PcLPHRE/vVvSq9XCu59O5o/IbUSKEOBdqhpmgAx39BEKBW34QRbS+Urmxe0
	 95AvhbdXljJLLdSckAxhcfbRHhH91oRk0z5FQNrPGKqtcnzI5uVnGp/PDOsoFBd/OX
	 LCM2O6k3+ECEwwebXzxWgWMquFCHokNM41aPTHr+CXTm2PPimQ6mzUAFXIJloghwgS
	 yyluBO1QfYp6F+PqTxhXkPUbk3dc3i/27jxgdl++yVdn71stUZQ2wU+X3gsSx4SwA4
	 73nqvF7d7nSdgy3lRaLRS8hHIchQ8l+cwRUzeu3x1VipwhhcDNnsIEAa5UFqTo9qjI
	 tpXuCENVM3VXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 618/713] mei: gsc_proxy: match component when GSC is on different bus
Date: Sun, 24 Mar 2024 18:45:44 -0400
Message-ID: <20240324224720.1345309-619-sashal@kernel.org>
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

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit a0776c214d47ea4f7aaef138095beaa41cff03ef upstream.

On Arrow Lake S systems, MEI is no longer strictly connected to bus 0,
while graphics remain exclusively on bus 0. Adapt the component
matching logic to accommodate this change:

Original behavior: Required both MEI and graphics to be on the same
bus 0.

New behavior: Only enforces graphics to be on bus 0 (integrated),
allowing MEI to reside on any bus.
This ensures compatibility with Arrow Lake S and maintains functionality
for the legacy systems.

Fixes: 1dd924f6885b ("mei: gsc_proxy: add gsc proxy driver")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240220200020.231192-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
index be52b113aea93..89364bdbb1290 100644
--- a/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
+++ b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
@@ -96,7 +96,8 @@ static const struct component_master_ops mei_component_master_ops = {
  *
  *    The function checks if the device is pci device and
  *    Intel VGA adapter, the subcomponent is SW Proxy
- *    and the parent of MEI PCI and the parent of VGA are the same PCH device.
+ *    and the VGA is on the bus 0 reserved for built-in devices
+ *    to reject discrete GFX.
  *
  * @dev: master device
  * @subcomponent: subcomponent to match (I915_COMPONENT_SWPROXY)
@@ -123,7 +124,8 @@ static int mei_gsc_proxy_component_match(struct device *dev, int subcomponent,
 	if (subcomponent != I915_COMPONENT_GSC_PROXY)
 		return 0;
 
-	return component_compare_dev(dev->parent, ((struct device *)data)->parent);
+	/* Only built-in GFX */
+	return (pdev->bus->number == 0);
 }
 
 static int mei_gsc_proxy_probe(struct mei_cl_device *cldev,
@@ -146,7 +148,7 @@ static int mei_gsc_proxy_probe(struct mei_cl_device *cldev,
 	}
 
 	component_match_add_typed(&cldev->dev, &master_match,
-				  mei_gsc_proxy_component_match, cldev->dev.parent);
+				  mei_gsc_proxy_component_match, NULL);
 	if (IS_ERR_OR_NULL(master_match)) {
 		ret = -ENOMEM;
 		goto err_exit;
-- 
2.43.0


