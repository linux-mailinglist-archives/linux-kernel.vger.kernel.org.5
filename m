Return-Path: <linux-kernel+bounces-64791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043058542E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376E11C20D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06176125A5;
	Wed, 14 Feb 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKdl5r8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFCDDA6;
	Wed, 14 Feb 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892584; cv=none; b=YPJRoX5Emj9aGJa+fKr1S4JpyoCB7jXGOjzYpBLj5GTylax95DOJqzxZ8yTM2KCxaLiAgukeVmP4Cee0I4K2hboV3IrVvtbTBrzdYsZPdadmZ+VEK7+zrM/DSltXKN6nMj0yPxHB+3g+e9O+c0cjyPAbsNr+ptHSerLeZBPPlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892584; c=relaxed/simple;
	bh=S5QTvUq6sE9Cp1C8VwuWZA/YXB1LZbFmxjhmWirs68s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lp8xTJzsVHi3ZTfDORpNjv9rAW2S1XvgLz6ghrv/QIrGJhrkqvqWoCh99Gpr152lOm9CIIJtExkL4zxskZcURgKhZa9pmNwyirrrKqqDtEgBTPuW6escvTofBW7nW0DGcBCKcUBcybyj80iU0kbq1GKfaXOZ9NWxXzmMhF9GgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKdl5r8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDA69C433C7;
	Wed, 14 Feb 2024 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707892583;
	bh=S5QTvUq6sE9Cp1C8VwuWZA/YXB1LZbFmxjhmWirs68s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IKdl5r8o/bdg/0ik9UeFg9GA9nvIUn469qlp45XfESDvS+BcGOTLSombxGzDjzpRh
	 PaJ5wbOo39bimBb6rBJ/Qi1/GCBQPFo0aJRmodl/2dxIm77pDl3f8qLvz/7MfGq0R8
	 N2SOujs16mJC5UVLfPAS05ojrEDsHL/xrW3TrRBovgPORgxP3sbPY7zlOKjntq4oQr
	 DAlbIbxBjyyK6uVZl/TQCD9u+TwOUyaTqwL0XHNDMbmcGfG4AiNRFCBm+oSp5N24fk
	 B9BBRmMe2aZcJQwg/mw7rCt8OQ/xs9vSN+Tk+B4kssMOoC+PTtPIyqthr0h6Rczy8j
	 iBCFypBaD7JHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B06C48BC4;
	Wed, 14 Feb 2024 06:36:23 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Wed, 14 Feb 2024 07:36:13 +0100
Subject: [PATCH v7 1/3] dt-bindings: serial: allow onewire as child node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-w1-uart-v7-1-6e21fa24e066@gmail.com>
References: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
In-Reply-To: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707892581; l=868;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=f5JrNqSq+DhQN/cCXZvlLdSNxNweO7or4GNetVHb2s4=;
 b=MjZYFlxIpcjH+7xYKTHb6sA+5nJV83dewBpgdSNFdhsZJCr1cZrxfi4bKq1nCPPY0k+dr9N++
 PdwW0PHK+iGCN5BGG3Df0NszztBB1Gw+zlGlzt4Jda+k2xGlbM5XtSs
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


