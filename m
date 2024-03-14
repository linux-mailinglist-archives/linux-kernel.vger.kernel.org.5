Return-Path: <linux-kernel+bounces-103059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9C87BA82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1621F232E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CEB6D1B2;
	Thu, 14 Mar 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCnH0QpQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B76CDB9;
	Thu, 14 Mar 2024 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408841; cv=none; b=md+QdXTBqdocj2Q7FAgGj3uXvFf4X+JznTDli+HfNCKf30K5PoN91QtTF3dDN87wkQM4jVZNe9PSST69fdl0ldIonbrHfvKJ34JxMN773P3baF4+t8SbPiMlrxBVO3rL+E+cmb8hj3SXQHvZl0HV5C8ma2rx9B2Xq+4vjoC+tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408841; c=relaxed/simple;
	bh=9mhCWCDlcnDok55dMpIkq5VniwCLfhOjl6RgA4AYQZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CtRT5bd/BExhydiACMSAaLRw9dsNUFMWXEs1eID2lOJ2TEXakIrOU/ZDyHQDptlcKLuK8bArHjPBpQELwKFm+NnuaxqWyLj66uweru3xciFV8sO5ScAGk0nI/uwOB440o2mKGER3wTw23Nsp4OL0S0/bb+B8lZcKdn288afjqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCnH0QpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32FAFC433C7;
	Thu, 14 Mar 2024 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710408841;
	bh=9mhCWCDlcnDok55dMpIkq5VniwCLfhOjl6RgA4AYQZE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MCnH0QpQUiqNk5MbW8LitdIJrZknAqk+6T+0xKk3iQd30FtUa7Q51pkVtrI/VmUaX
	 ++swNz2GB7+O8NrEr6z5FsJi5dYZGvmMluOKrmHHYjvmTy1OprE28Z6HM4XlVQJs45
	 i1ymp0+e7GI2gwr2W+6LPHX0eEUS8OS4xV6aQswAxZGrwtPwdqztzP5UZiv1bEyevw
	 i/Ozkz2+H0m4MQ5v3da/D61DP5a6cgPQAzKLtLZgwLLJSLXDtpayIRahwiNha9rlG7
	 lfdQgW1yKkisWcw2EzmoPZteMhtTCRDfGHj3ARZCLqyfMV+Q6v3Ck5q+Y05eXJaHSV
	 zxnHYe7gyv6jA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A9C5475B;
	Thu, 14 Mar 2024 09:34:01 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net v2 0/2] MT7530 DSA subdriver fix VLAN egress and
 handling of all link-local frames
Date: Thu, 14 Mar 2024 12:33:40 +0300
Message-Id:
 <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHTE8mUC/42PsW7DMAxEfyXQXBainNpyp/5HkUGRKZuoIgWSY
 DQI/O9h3Q7d2pF35D3eXVUqTFW9Hu6q0MqVc5LBPB2UX1yaCXiSWRltjtpoC+cjhFwgUYNLG14
 6DYE/IXL6gJi9i7BGl8CFnsbRWDfZSUnWtZCs7Zx3JbfqJOLCteVy29kr7tYPBv/GtMU14DQXq
 vWbGTg2KZNmuObSRERAsBY9+rE/myG8OXH9+Ozz5eunndUh/rOSxGmY+oF67zt0wfyOO23b9gB
 GDEZlTAEAAA==
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com, 
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710408826; l=912;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=9mhCWCDlcnDok55dMpIkq5VniwCLfhOjl6RgA4AYQZE=;
 b=y/QfBdILr3tdHqFe6w7wGfGuQGVjFvZrcg4u0T/fFa3h1BUIgOjuuuXeBdd6fANNjkg6S27HI
 32sFVY83Ud/CBN2QrzvqGPZcCgmRDlDRtwQ6BrugfSb40Y5/66jD/rX
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hi.

This patch series fixes the VLAN tag egress procedure for link-local
frames, and fixes handling of all link-local frames.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v2:
- Add Fixes: tag to both patches.
- Link to v1: https://lore.kernel.org/r/20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-0-d67e6cc31af2@arinc9.com

---
Arınç ÜNAL (2):
      net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports
      net: dsa: mt7530: fix handling of all link-local frames

 drivers/net/dsa/mt7530.c | 52 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/net/dsa/mt7530.h | 22 +++++++++++++++++++-
 2 files changed, 65 insertions(+), 9 deletions(-)
---
base-commit: d7d75124965aee23e5e4421d78376545cf070b0a
change-id: 20240208-b4-for-net-mt7530-fix-link-local-vlan-af6e9928ad8d

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


