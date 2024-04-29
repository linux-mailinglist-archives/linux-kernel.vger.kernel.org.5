Return-Path: <linux-kernel+bounces-161846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0038B5223
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8204F1C20E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B11758C;
	Mon, 29 Apr 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="I4IliJyU"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056010A25;
	Mon, 29 Apr 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375118; cv=none; b=DoRBWdm1VNwj6WnL9GBeVRoi4XtPVLomfMpfonhvWqxYGL03t1I5EfxynvZs5CMqaU2GRdOH8WzJSh1Q8IG1QbkXxRwvejPGnBe1ZWNKJRQ+507PafrKHB8DGmanNtG9dbESQFxc1+bh3KIPnvxT8nInv7mgeTQHm0LD6QUtqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375118; c=relaxed/simple;
	bh=FUv8C/H7hY9I+fk/65VVZ7+kKtRRAkdhg7RM70eHSKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmtxucKp7Ee7czQHrgsUOtjh3LxO1yD9BlyxpV5gbkzYNsJju1ozx3j8XaYvMc9iBysUQTtNl6vlAHqg1Cx7qXtCHQcspwH6GNiOUMb9+axo2z6mJ1EIh8Br4n5eZ2vzgDdHrmRZSIzNR/SYr7AujfcSUo1ndm8d6cUY23UFi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=I4IliJyU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=zHxiPlbn8iylFbdHdlasv5xRFVd2Xjc1sCdQba/lytQ=; t=1714375116;
	x=1714807116; b=I4IliJyUKWOIwiWYMzQ/hDxuV1KkuQf6ivBolodzHzOHp0VgU+jzxnZsPDdSE
	mvogawIjvc1sR9tARu8/DkaYVoOXCFrio4Dq7CwXjbJrHZTiFRxdD+HTxvso9Ydj1SkKH8Cmw2Yyf
	c3j8eTJnq6bjBw+dbk1UMssmLXbYGTwjX8MCbiP9SmTw5Qwta/50zlOmZftT5XU8KmlM+EmJ88Q90
	azd/Bzv64/mFIOv+fWIjliiqrqbjpTvGk17eEPnYG8YUBSAqO9PJcdnNiJX87hiX/HL5Y/bcm1KGm
	zWGqDZAQXeeWqx+fdaHxMaPHnZCzYqdna1/lCkiLTkQL/Pa3/w==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s1LHT-0004e1-Sv; Mon, 29 Apr 2024 09:18:31 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] docs: stable-kernel-rules: reduce redundancy
Date: Mon, 29 Apr 2024 09:18:26 +0200
Message-ID: <106e21789e2bf02d174e1715b49cd4d30886d51f.1714367921.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1714375116;044ac9ba;
X-HE-SMSGID: 1s1LHT-0004e1-Sv

Explain the general concept once in the intro to keep things somewhat
shorter in the individual points.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 1704f1c686d0a8..0da9c57287c134 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -79,10 +79,9 @@ stable tree without anything else needing to be done by the author or
 subsystem maintainer.
 
 To sent additional instructions to the stable team, use a shell-style inline
-comment:
+comment to pass arbitrary or predefined notes:
 
- * To specify any additional patch prerequisites for cherry picking use the
-   following format in the sign-off area:
+ * Specify any additional patch prerequisites for cherry picking:
 
    .. code-block:: none
 
@@ -114,8 +113,7 @@ comment:
    prerequisite of patch2 if you have already marked patch1 for stable
    inclusion.
 
- * For patches that may have kernel version prerequisites specify them using
-   the following format in the sign-off area:
+ * Point out kernel version prerequisites:
 
    .. code-block:: none
 
@@ -132,14 +130,13 @@ comment:
    Note, such tagging is unnecessary if the stable team can derive the
    appropriate versions from Fixes: tags.
 
- * To delay pick up of patches, use the following format:
+ * Delay pick up of patches:
 
    .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
 
- * For any other requests, just add a note to the stable tag. This for example
-   can be used to point out known problems:
+ * Point out known problems:
 
    .. code-block:: none
 
-- 
2.44.0


