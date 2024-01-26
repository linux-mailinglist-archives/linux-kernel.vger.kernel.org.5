Return-Path: <linux-kernel+bounces-40291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BCB83DDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CB51C214F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B701DA58;
	Fri, 26 Jan 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J19Mf6r2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F81D524;
	Fri, 26 Jan 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283759; cv=none; b=pou7HYa9McEgRoNpZZT6oSavh23xfviWzg6lKg6YhuoZcOnbM4j1XSzke9moiHYZnBiJFeMvUffwB0e4Z1C1AyDnLTFpVeCwS34N4CgSjxLnA1k+CSvpVEE/cY77JShditia9ik0TvqjDQodJIrDtnnT+y1oj2Q/3hf+L1AU2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283759; c=relaxed/simple;
	bh=S5QTvUq6sE9Cp1C8VwuWZA/YXB1LZbFmxjhmWirs68s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OliVNyHJCN6cIeNEqn5HerSg+SIqxaJiWVPpEx9Gnsfv5U+8npcm5tU0FNaP9S3eVYHadn5kQA2qZ32/Iz7klaIjf5H2di+Q3HLZMQYdiH3IG/MRw+pXqGG6vbb8zr3JulgnHHsum1KXWb2MjcounceLmirGdAQhqv4vU/s/jFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J19Mf6r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC24BC43601;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706283758;
	bh=S5QTvUq6sE9Cp1C8VwuWZA/YXB1LZbFmxjhmWirs68s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J19Mf6r2IQC4hX3YmqWbphbz1JZrkQfn57Xpx4cK4semsMcImzz2BBhuMMk4r7lmo
	 tfgQd3Ma+KBsIRmxtAIYkDsgoYPMSCz/KhBvffzL6rcRgWFZNzK44wpBTQz62EIzRP
	 iwZ7LYaLiMse/UmMBTeS4QE43DaG5wCnE+QdaT4SrlMXrBLqyLy8TRnV5h56RIR6Dv
	 ZCtijohpqIllEMpUzUDQhndPqfzUlJSNw9CdTms68RDZLlXArqmxsmnHx/JAwPWaqU
	 1ZRlfhbbQL3XD5x6KSx1Xt2wNFexFDKNtW11QiBCR+erfIO0sGso1Q+BZgFQqCtc0m
	 JCMNjsofZQDJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F1AC48286;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Fri, 26 Jan 2024 16:42:04 +0100
Subject: [PATCH v5 2/3] dt-bindings: serial: allow onewire as child node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-w1-uart-v5-2-1d82bfdc2ae9@gmail.com>
References: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
In-Reply-To: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706283756; l=868;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=f5JrNqSq+DhQN/cCXZvlLdSNxNweO7or4GNetVHb2s4=;
 b=vNQIF5PJ+rhmx/oT4VlO72W5qDeYED+UtbIfZCYVYHsbJ/OKK1VjekSbu2DDNnwPV0ciYCnSJ
 TaAbsGElugEDLIUFkOrdYJevyh4Dp8o0FDIMDi+f3030dZExiD8faMd
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

From: Christoph Winklhofer <cj.winklhofer@gmail.com>

The UART 1-Wire bus utilizes the Serial Device Bus to create the 1-wire
timing patterns.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 65804ca274ae..ffc9198ae214 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -88,7 +88,7 @@ properties:
       TX FIFO threshold configuration (in bytes).
 
 patternProperties:
-  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu)$":
+  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu|onewire)$":
     if:
       type: object
     then:

-- 
2.43.0


