Return-Path: <linux-kernel+bounces-98779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC151877F49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D111B21D95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F43C488;
	Mon, 11 Mar 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYpt5aJH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD03B796;
	Mon, 11 Mar 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157617; cv=none; b=fxovt7NRmxdvbMBUZJZ9s1ewJGiAgdtfKzbmTzeOSGlZhsweKVK4cVVa6ZZKraCIa+Md1k1Fd2vYiyB5ECQQxJc/eySlMY6idjolmQhwnJaCEfqSEduOByjND7GyXhryn78BhaSVZcLHmgHyFkD46i/6Lj7SGukaOvuIkhv6AQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157617; c=relaxed/simple;
	bh=90OLEsdfJqu8wgRSuSRNabsqq0MAYE6rL2NiXmGoMtI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r3oy2gNSXpMZiC8rDwtyfTm5808eDRf1Ng+Ak2wOplJFSISzTcjFRJWu6m68SYo6/W8BGZbowBR7ZAJPtSD/zfxeSK8+E5lI5RPgb8/jfcF0i8jCbtlWO3in6H2Sp3OwsUBM8Z7uf5WLBVK4uRocLwzPrNi0BfJzONS7TxCzbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYpt5aJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89A83C43390;
	Mon, 11 Mar 2024 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710157616;
	bh=90OLEsdfJqu8wgRSuSRNabsqq0MAYE6rL2NiXmGoMtI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VYpt5aJHczmPPrIB9JAWhU9Y/Ur747KX42t9XfhPEtXzrzrXWOFeCcsqEysu2RwcT
	 IIb1bHjnYr6JZ1msidcECoTRYSwU5HSkMV2a8Noj4xfR5Y99ko0e5sFbE0hCPZE+ui
	 L19WJ2xCh67uvrIlqp0WUS5zPhRHW/C6N4peZ7nB/GnZKvOyiQv2wTnfHImdXrReMP
	 4Bi3q0Y+TbOBy4n6myqieKfOXW4FI/pm7Ze5j3D0wWnrSSgijZurozcPJoyO/C8ymp
	 cFcMlw7HYCxwy3H09iGhcDah7o/Gz1lg1JqniOxwC8fw8CjUTg7yWlUQDYXDnCFsmM
	 hGbm9MRdgnkyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B0C5475B;
	Mon, 11 Mar 2024 11:46:56 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net 0/2] MT7530 DSA subdriver fix VLAN egress and handling
 of all link-local frames
Date: Mon, 11 Mar 2024 14:46:37 +0300
Message-Id:
 <20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-0-d67e6cc31af2@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB3v7mUC/4WPwQ7CIBBEf6XZs2sKaks9+R/GA1JoN1JogDQa0
 393U717nJndeZk3ZJvIZjhXb0h2oUwxsBC7Csyow2CRetYga3msZa3wfkQXEwZbcCrt6VCjoyd
 6Cg/00WiPi9cBtWts10mle9UDd83J8tnGuQL/wo3NkXKJ6bWxF7FFP4z4jymjLkhhSDbnL9ORL
 zwmDDjHVNgUKFApYYTpmrts3UVzarq9iRPc1nX9AFLj/gX9AAAA
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com, 
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710157606; l=737;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=90OLEsdfJqu8wgRSuSRNabsqq0MAYE6rL2NiXmGoMtI=;
 b=yEjWff1QAaQVlCGNmDywGXbrJAoO1e6BjBXW4cIqriDctnD1IsQi0KcTnd5CM7arX36Tysqkm
 AJv5bSCJiDzDPFoDPQKux05QW1mtLNNtQ5FjXY+5dgkjdGDyHg95tCA
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
Arınç ÜNAL (2):
      net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports
      net: dsa: mt7530: fix handling of all link-local frames

 drivers/net/dsa/mt7530.c | 52 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/net/dsa/mt7530.h | 22 +++++++++++++++++++-
 2 files changed, 65 insertions(+), 9 deletions(-)
---
base-commit: c8a5c731fd1223090af57da33838c671a7fc6a78
change-id: 20240208-b4-for-net-mt7530-fix-link-local-vlan-af6e9928ad8d

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


