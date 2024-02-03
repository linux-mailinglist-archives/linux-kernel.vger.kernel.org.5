Return-Path: <linux-kernel+bounces-50965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC403848462
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4A31C227FF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F354F20C;
	Sat,  3 Feb 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ruPngsdF"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4484018637;
	Sat,  3 Feb 2024 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946745; cv=none; b=GuXUBDUadgK7hxHYoFe/RIWZvcVYYBXQMwdAO03snXpc93oMmTGGeieLNKYQwMiIn8Nh4hnqwI0rUtdVoNhKlD0bIiPVnK/Y1sAn2Q6hdw8I4/WAC4PAhjqC+ofPYIqPuZaBip0qi2R/AvKGz5h7IG7tBto4AMZzf7gV6Oc5+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946745; c=relaxed/simple;
	bh=F6ITBLQvJo2ID4GvkMI70FgRvtOxvEz87EYOHEv1yuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6XXdUUcKVLoAQfO4/K03Ugbuhu/4dBCZ02u/AbCRr/Dn5Hs7MILdy4G5HzYVnK/zWcaRkRb2Eb98AJgu3oMmS/+rsmpaQU8KdtBw9RirveA5oAldO0aiOAi123B66Z2qqfeHBV0FTAf42b7vThMdPaMa0vI/dt1/7cpFPN5iNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ruPngsdF; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id WAnwrvC6Ki8tRWAnwrIHzh; Sat, 03 Feb 2024 08:51:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706946674;
	bh=OCUMJ2d4ncLXSH5gQLn7aWRhS08Qda8fr6S/AVc12+o=;
	h=From:To:Cc:Subject:Date;
	b=ruPngsdFv92lgXoOcl+hbe1MSS1gg2pZWHHh4E022SYll+kGz+kDeGvHu8ZgaliGW
	 OwncwnjK9aWpAyBkpPltlnTwOfylTCUzC7p10RyXMOYjRt37z6Sok/kIfY4JqWArGi
	 z8Q/mBojZI+GLjXbVvYzmcUR5DquA6/YjBcP/zcl6nDfIvZfzliJxn0s/PVMcWdcdH
	 8Y4Rv0j8LU11pS6gAlr5IspqztuYDlup7oafaQrhqDoel5BPrjSylKkYeQSwyy8DZb
	 5zZU4TkBuYiqXsHl6wSgpsy7rdEBMB4u/As9z70ClA2qnlCxPSBTEFZILFLPzR8nLX
	 tmUPSpv7FMHVQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Feb 2024 08:51:14 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: krzysztof.kozlowski@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/2] nfc: hci: Save a few bytes of memory when registering a 'nfc_llc' engine
Date: Sat,  3 Feb 2024 08:51:02 +0100
Message-ID: <cover.1706946099.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llc_register() calls pass a string literal as the 'name' parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

v2: Add a new helper function, nfc_llc_del_engine(), to reduce code
    duplication. This is needed to address Jakub Kicinski's comment
    about nfc_llc_exit() that was not updated in v1.

v1: https://lore.kernel.org/all/6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr/

Christophe JAILLET (2):
  nfc: hci: Introduce nfc_llc_del_engine() to reduce code duplication
  nfc: hci: Save a few bytes of memory when registering a 'nfc_llc'
    engine

 net/nfc/hci/llc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.43.0


