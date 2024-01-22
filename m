Return-Path: <linux-kernel+bounces-33832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93137837001
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E985B28844
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369858100;
	Mon, 22 Jan 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRdhz3q5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923534A990;
	Mon, 22 Jan 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944931; cv=none; b=cow5+mXNc46WsKs8TEb9w7XBohBo27VWzinFwEZw1dwPIOervya8sMWwiZISMe6GOMDYptAK5kPxsNGlSd5s991qmJEAV5SLgv8gH0Rsu8P31OeI4+aupWX35SG/ob/z+Hlr7/n8FeZfx8Qy1aXny9+19rvjjzxb4NIZCxv3mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944931; c=relaxed/simple;
	bh=h/7MA+uqwVPx3lfrDrsWshvS6sJaQjSKgJKwuuLOb4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FS1fWU9tAhSyQGZXIjOMifwEw1h7EhSE+ePQ8yGM9rHfgAPwJU021iobmZ9n+FW93q3skoIzV27Lb/iDUfJPXFdOvcuSOzV6xtT7h2mOpSmnPp4PC/dCNH07UK5b/otDyc9BN6Jyr0QfEOe5+YLZ+2gSOQt6ke0m4mwPNoaLQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRdhz3q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863BAC43394;
	Mon, 22 Jan 2024 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705944930;
	bh=h/7MA+uqwVPx3lfrDrsWshvS6sJaQjSKgJKwuuLOb4c=;
	h=From:To:Cc:Subject:Date:From;
	b=sRdhz3q50c2LFzSjqgwuho5ugqACLibobv3W1S6w6tBmB8+2ejZg1QBnlhJO163ev
	 kMsTOgb6J7LCBJGMYpRdoHMrVJfdUnwsf1iJltEMe1Gg/qADOJ8N63KTinYOO9XvYd
	 X2Qt4hqZyEYxoBmBY7MiwrJQkFAwZ45NHBox7/OmjbSXsGq8tyqxNU0SxT609l0wWN
	 wEmcjzTvTiL07RKYnH1MbTyL7MBHZdKFMVHfFF/aOZ66nBKMf8wtGMn5aixFcxDbje
	 +o1RE4KGl49C22uL4YZp5f9Q4WyW+qe6HVbmskMEjv+SpWClURCixy/lJPI6IJImCt
	 ZNnjc/JZP6MAg==
From: Rob Herring <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: marvell,prestera: Fix example PCI bus addressing
Date: Mon, 22 Jan 2024 11:35:14 -0600
Message-ID: <20240122173514.935742-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example for PCI devices has some addressing errors. 'reg' is written
as if the parent bus is PCI, but the default bus for examples is 1
address and size cell. 'ranges' is defining config space with a
size of 0. Generally, config space should not be defined in
'ranges', only PCI memory and I/O spaces. Fix these issues by updating
the values with made-up, but valid values.

This was uncovered with recent dtschema changes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/marvell,prestera.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.yaml b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
index 5ea8b73663a5..16ff892f7bbd 100644
--- a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
@@ -78,8 +78,8 @@ examples:
     pcie@0 {
         #address-cells = <3>;
         #size-cells = <2>;
-        ranges = <0x0 0x0 0x0 0x0 0x0 0x0>;
-        reg = <0x0 0x0 0x0 0x0 0x0 0x0>;
+        ranges = <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
+        reg = <0x0 0x1000>;
         device_type = "pci";
 
         switch@0,0 {
-- 
2.43.0


