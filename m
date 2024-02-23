Return-Path: <linux-kernel+bounces-77742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E08609A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B17A1F26537
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1FA1171E;
	Fri, 23 Feb 2024 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWTmeLFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24562CA5;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660190; cv=none; b=oxfJ+JWkwJ1+CBA3F2LwiFUY9lF4k06aD2v6k71WIpXX3eC2G6K+0xsazai5Zqx95i7v6rvLW3/Kp0sR8f25SlneU12yyFhc8FwyDOMutOYhjN9GNvL3MDX2PU/dzkiHwzTPML7zCyZ0yYGzgtm8+5y2hqy0XrZ2DGr4qRJBSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660190; c=relaxed/simple;
	bh=FABj5PqTYhnM786LMrFtQ0eBls3CUT1p0QbNHPCEQCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IadMFZFvRZjABMqKA/ZjSU44eFoHSWxpASg8ivufdFjus0ZckTRTRCupAuobQrDO95tVWyukZfAjJWfdgXXPOY7DIqfXraeFh1/KfWmevsWL9P/QRgnFw50V31XVlk7t+Zlzz0VBb1ao3oxIjdjNVrb9KZynihbeALgL1fES9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWTmeLFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E36EC433C7;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708660190;
	bh=FABj5PqTYhnM786LMrFtQ0eBls3CUT1p0QbNHPCEQCs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pWTmeLFuio0Ad5mcU+z4JGB4eT3C3VXIbezT4tSRCwKbeC7UUBV2XBJVMggGBirwU
	 YOoYcgQsk3wluZGgxgkPApCfx3Gox4oilEmE2gKj0PBYYJV4ItAQy6ataCGXfOo8ck
	 pFRp40DmNTTlQzkmOvyolJJBBS6B1xBYu/eiKrZxVASV83RKD/x8fYgixAmAY8k82G
	 +rkNLGiNq/fvTW7km70I7puU3hu2Wu3uav0UVRtpENoA9ULvOOaImxjrPwmgWg8mJr
	 BUtlfDAUggFxRV8wztTArEZXZaWsV5ibb/2WvHBCo+n5NecyjhssF9jqIo5pDmD4AK
	 YYZpgBGPLWAag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CCAC48BC4;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/2] simple-pm-bus: deassert resets if possible
Date: Fri, 23 Feb 2024 11:49:45 +0800
Message-Id: <20240223-b4-bus-v1-0-2803c3ac4673@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkV2GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNj3SQT3aTSYt0U02SzNHPTRCNTw0QloOKCotS0zAqwQdGxtbUAock
 28lgAAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708660187; l=658;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=FABj5PqTYhnM786LMrFtQ0eBls3CUT1p0QbNHPCEQCs=;
 b=lAjMgm0upwe5GNEV4wO9MDqjNe+0Gto1rn6DLXSaTmlZoFGjD2+RXTGbL9uwWw6+3sir5+WNP
 tQQ29dl5Rw1AQ8/E5UGsm02f5c26NWy06kxgA0nYOhW9ArEmiBAfR67
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

simple power-managed buses can also have resets. Get and deassert them
if possible.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      dt-bindings: simple-pm-bus: Add optional resets
      drivers: bus: simple-pm-bus: Get and deassert resets exclusively

 Documentation/devicetree/bindings/bus/simple-pm-bus.yaml |  7 +++++--
 drivers/bus/simple-pm-bus.c                              | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240223-b4-bus-d5c6f75a251a

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


