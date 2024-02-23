Return-Path: <linux-kernel+bounces-78103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BE860EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC9C1F23854
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356C5D470;
	Fri, 23 Feb 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojhuTBgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB5D533;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683023; cv=none; b=YkXKzbJqIZzoc/z90asomDUSal/tY3bLzt1vr3ZDuvEoSy6erUvucPr6l001PFjgkXxjOQkkpk05YorNsoWjfzdCkEq7II3mlyDmDXKZToZlDsySxECVrqw4vZ0Rubik/YfpYJoFmhyruiPOt3WSAZbLUp4kFW31q9cMvPeC/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683023; c=relaxed/simple;
	bh=rj50khMCd7O7B7v0SRHISMJug9v3bULtlYjPZBTU/UE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=APvnKuf1yZtrJ0AyUcldk6pCdBxAudu5MhewLAMA/1Nq8+D8LgsYWVKRyi8c1KP3zz/dZJNX+5aaPJ38S8YOPMLeKpx67PNkuHlMU39Lvj7Yi8lYRlBXpreBVfETgtBrO4oam7/Q/ydwJWHEqB5lEwYyJksv0fJyzHMZpOJsoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojhuTBgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92B5FC433F1;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683022;
	bh=rj50khMCd7O7B7v0SRHISMJug9v3bULtlYjPZBTU/UE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ojhuTBgvO18NmWnMejaOWRVAOSKiMw5nzMV2JTV5yYzPQbPFjtVw8Dkq7ACmlV9p7
	 hpW0VwdCTD03BS8x8faqWVRuKYzO+JTRFkJSC2qvYIbkWAkHvE6cLZWiIqN70XItw0
	 7vqPMB9WE7F0c607K57DIF6DqnkhugSgAY9b2BqVFlsnpnBUtjZFrgw6JhdTTrToro
	 N4WPdo6TXvWfCrK3gRqU0oXVTzxFLPHqKZtuI7VAtQkJFrxfBqJGchRGN3zBujJyk6
	 yfczqrRvLiRiLtncJbEa5UOuvQKWhgHDfQcFEplfVtAw7EIwqQX9HG+lxf0xgXyinC
	 iyAit83w9tIRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E06C54E49;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/2] simple-pm-bus: deassert resets if possible
Date: Fri, 23 Feb 2024 18:10:18 +0800
Message-Id: <20240223-b4-bus-v2-0-da8ba83c1a5f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAApv2GUC/2XMQQ6CMBCF4auQWVtTpi0YV97DsCilyERlTAuNh
 vTuVrYu/5eXb4PoA/kI52qD4BNF4rkEHipwk51vXtBQGlCilohK9Fr0axSDcc3YGoumtlDOr+B
 Heu/QtSs9UVw4fHY31b/1j0i1kAJPUjllnW5adeF1eTDfj46f0OWcv+cvru6eAAAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708683020; l=785;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rj50khMCd7O7B7v0SRHISMJug9v3bULtlYjPZBTU/UE=;
 b=KVFzD4/LxaLBN4mijJPpCUdHSXjWF4tITatM8znI+xJq8WdzSibMB92wnRHDyb/bBv2YGJpUw
 7KKvEfT0H5QAP7il7TzxQolRaKUegsfGybEbzOPsbYC/lKe0Nw0Cc6Y
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
Changes in v2:
- use wrapper
- Link to v1: https://lore.kernel.org/r/20240223-b4-bus-v1-0-2803c3ac4673@outlook.com

---
Yang Xiwen (2):
      dt-bindings: simple-pm-bus: Add optional resets
      drivers: bus: simple-pm-bus: Get and deassert resets exclusively

 Documentation/devicetree/bindings/bus/simple-pm-bus.yaml |  7 +++++--
 drivers/bus/simple-pm-bus.c                              | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240223-b4-bus-d5c6f75a251a

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


