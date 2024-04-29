Return-Path: <linux-kernel+bounces-161845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF348B5220
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72368B214E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C048171B0;
	Mon, 29 Apr 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="foPejAjy"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352913AC5;
	Mon, 29 Apr 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375118; cv=none; b=CwFWvwZjMOWmyUptSjDvU9N48vekVeSxoN70YWdGVx6GHA26TboN6HIJZGrXROYQ4umjWOgoUj2espplcIeh+UsoIb1USsmAVfIJLtxuEVJtsMxL11VBXxetBgde+/ZHRwegv4IhCreL4fYM2K31j/ZBTkFJ0Fv9a1ijhVh3NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375118; c=relaxed/simple;
	bh=lTfHUa+6X3dBbbyMHNjxRT794QlSydTwuuVcDpoSGiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDs2tQUPmRq73flQFLKyshs7YL4raUxGPJcAgZQ6SYrQF1rIC6OCmJ14FXnpprbbyCcNMravBH1n2jRGIBLnsNlL2aVa9HKCQZmmcmGjqWbBX/xdgvnxbTnZXo3VQXWPMpKOT2uzHSQPoiN0EmCRDmyGCJvZysbzMUBZnYYTfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=foPejAjy; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=v4MB+irPk//D9YryabZUxAaUkrcUIos/DQ/+395gmH4=; t=1714375117;
	x=1714807117; b=foPejAjyBmSo2ZG3HPi5DU+Xdkgrr+5bW/86BesxCGJVlffyNpz8ywiga2Rlg
	y65Z8ghV4llz3A/CpJjLpUtqUN9R+STkB9EHXHNcwIufNL+nIpoB1KmpG21uZnp5PZOQJqqh0g2RR
	b/PBNMYo2DN+Ic3UNR9g3ovR1oElmQN48PmEcM8a4wyePzpsisGSWcWWo3IF3Vpqqhw/1R0civIVX
	nQiV3FcctnKLMnKFq/9upgjFM0nhHLwMjDUrWCBbEY0Vf6GnsT8t+e216cfdai34OAcEWyailiTcd
	hvN4aOWC5/TPgMTq3sQ2fCidivm+JhsvlFMIoJe1jO9SEdnENw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s1LHV-0004e1-Ah; Mon, 29 Apr 2024 09:18:33 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] docs: stable-kernel-rules: create special tag to flag 'no backporting'
Date: Mon, 29 Apr 2024 09:18:30 +0200
Message-ID: <35989d3b2f3f8cf23828b0c84fde9b17a74be97c.1714367921.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714367921.git.linux@leemhuis.info>
References: <cover.1714367921.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1714375117;b475376d;
X-HE-SMSGID: 1s1LHV-0004e1-Ah

Document a new variant of the stable tag developers can use to make the
stable team's tools ignore a change[1].

That way developers can use 'Fixes:' tags without fearing the changes
might be backported in semi-automatic fashion. Such concerns are the
reason why some developers deliberately omit the 'Fixes:' tag in
changes[2] -- which somewhat undermines the reason for the existence of
that tag and might be unwise in the long term[3].

Link: https://lore.kernel.org/all/b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info/ [1]
Link: https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/ [2]
Link: https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/ [3]
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

---

A patch to make one of the stable-script honor the flag can be found in
https://lore.kernel.org/all/655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info/

For autosel I was unable to locate the code.
---
 Documentation/process/stable-kernel-rules.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index ebf4152659f2d0..9ca8083b41c7f1 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -129,6 +129,12 @@ comment to pass arbitrary or predefined notes:
 
     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3
 
+There furthermore is a variant of the stable tag you can use to make the stable
+team's backporting tools (e.g AUTOSEL or scripts that look for commits
+containing a 'Fixes:' tag) ignore a change::
+
+     Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
+
 .. _option_2:
 
 Option 2
-- 
2.44.0


