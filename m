Return-Path: <linux-kernel+bounces-139783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A08A07A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0981B2741A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2113C8F4;
	Thu, 11 Apr 2024 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PQkVZyLF"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5113C810;
	Thu, 11 Apr 2024 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813114; cv=none; b=hO+KjbLgMJfe90IyMFxPGdOhtmSOg99Ywct07Avo7ovrsMji8sFiH3ClV5ifZgshKfILnHVkQyZBzB+XSHX1AdCfXsB7P4nz5DdPOaCWm6pjLj9VBesAGr5LgOP3wt53hboN0X55VyC0qgUZlgtueEAQTFSS9MouI8heCFVwwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813114; c=relaxed/simple;
	bh=pY/KsiwkSSrnTo1CDrGux687+Q84CUyArAIKkfMLfXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRj1XdJuB73p+NdKkqwA6lXPeWDsg+Ip2c3G/Hx/pvKm770RnMWO7VhBprawm0orXYupKhjhgou/1hiw4kgCnDaexPnXFbgyYs3jv5YSHj/zBPIg2gwY7w1SCtWmOduZ6vho2EkPx8Vr24SuQ1u2Sts4pJYpsW1VDCyi7QJHM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PQkVZyLF; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CwRkdAu5gHV8CG+unzDNLJuqPeE7Wh9EpIy9OgvjDHo=; t=1712813112;
	x=1713245112; b=PQkVZyLFoe6VsBpzhQHUTkp82Um9stH/VNSHqirEBsx+ATl0ea9w/7Um/XA3+
	NJS5fLD8Dbem87+djk4Zg6oHo0RSCFuy2PGJP3dU73A1JJMG1K5+g/SzQ/akMAGnRBHMvyZovqkD1
	KLn1kEgmoTioo0ElKcWW90CIVXCQjnc8LhWzD578DNpfzDNudomIY38wpj1PSMUNFizt3g33Sg27d
	YY957bkQwEveQ3TNyUM9pUNeyHAqQdBGCmtBFj9m8tw99KemtvQ4Fi/BXolFygz3zq2Ur9idFC1Oj
	6mBbmS5rYahlsr5M0tV0L6pc+tuCuMs27/K+sdPHPY19ZKBcww==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rumvr-0000rh-CA; Thu, 11 Apr 2024 07:25:07 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no semi-automatic backport"
Date: Thu, 11 Apr 2024 07:25:04 +0200
Message-ID: <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712812895.git.linux@leemhuis.info>
References: <cover.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712813112;8245af4a;
X-HE-SMSGID: 1rumvr-0000rh-CA

Some developers deliberately steer clear of 'Fixes:' tags to prevent
changes from being backported semi-automatically by the stable team.
That somewhat undermines the reason for the existence of the Fixes: tag,
hence point out there is an alternative to reach the same effect.

Link: https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 7bb16d42a51833..ebd57cb9277f7b 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -117,6 +117,12 @@ comment to pass arbitrary or predefined notes:
    Note, such tagging is unnecessary if the stable team can derive the
    appropriate versions from Fixes: tags.
 
+ * Prevent semi-automatic backporting of changes carrying a 'Fixes:' tag:
+
+   .. code-block:: none
+
+     Cc: <stable@vger.kernel.org> # no semi-automatic backport
+
  * Delay pick up of patches:
 
    .. code-block:: none
-- 
2.44.0


