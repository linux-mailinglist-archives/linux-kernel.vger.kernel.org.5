Return-Path: <linux-kernel+bounces-112232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF92887734
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19201F241C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2965CBD;
	Sat, 23 Mar 2024 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="otvaLSl/"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CF5382
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711175183; cv=none; b=scu5S7RyCKM6s8FVbu9KTzg4xUVZ0Wln9vz5301jQT0WMW/i71Xo7Sdae6m4Kn1quV/Jo7oChdcceGeTWq54b9nCqtLpZbS/x5o/XWj+jcGYtUFCV1S/J3t8dhOlvz02sh589fzG4gp9mHxXiYNGMbMzTN3Ob0yG+44dDuOhHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711175183; c=relaxed/simple;
	bh=4zNnlz2FX5Z0fSGTzKMLqhTxCPDwK2SwGj0Ql4edVXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8ckKcjUBUhEpSoOLEIoMRciWEOWkLupPwkCTzK5mE+9jxJd373aZ9K6CRDF3gQdk9O4Rmg/6Rts/aSZmiiFZLC+rLcffiiUOOyz+RDdyJL13qz0UYFZyOuRcpLqltodP62o1FKsL4wWwybbsdRFuzhcjed6Q47UjiBWwzjdmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=otvaLSl/; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id B584E1C14F7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:26:12 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1711175172; x=
	1712039173; bh=4zNnlz2FX5Z0fSGTzKMLqhTxCPDwK2SwGj0Ql4edVXg=; b=o
	tvaLSl/V2pZzlQTLKiVsEA3KVKG0jOlQAu3iDTYeqOkpo0Qy9iPD/VFLTLw8n+Bj
	ahw1mvAcmg1p8G9masa1Q63a7SaSnz+CRwG5bg3JDgwu8RnEoaD0Qhsk9iHE/WY8
	/Ie+/wTTcGPrD4aDaI6o6sDwxZfe77kAJklShNQDmI=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zh1y3rhpW_ki for <linux-kernel@vger.kernel.org>;
	Sat, 23 Mar 2024 09:26:12 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id 22CE71C129D;
	Sat, 23 Mar 2024 09:26:10 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Chandan Babu R <chandan.babu@oracle.com>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list),
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH 2/2] xfs_refcount: Preventing integer overflow
Date: Sat, 23 Mar 2024 09:26:03 +0300
Message-Id: <20240323062603.665572-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiplying variables can overflow the "overhead" variable.
To fix this, the variable type has been increased.
Next, a subtraction operation occurs with it,
but before that it is checked.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 fs/xfs/libxfs/xfs_refcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index 511c912d515c..cbf07552eaff 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -1070,7 +1070,7 @@ static bool
 xfs_refcount_still_have_space(
 	struct xfs_btree_cur		*cur)
 {
-	unsigned long			overhead;
+	unsigned long long		overhead;
 
 	/*
 	 * Worst case estimate: full splits of the free space and rmap btrees
-- 
2.30.2


