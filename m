Return-Path: <linux-kernel+bounces-30097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB383192E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14426283364
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C924218;
	Thu, 18 Jan 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="CN++Aq9c"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC724B37;
	Thu, 18 Jan 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581240; cv=none; b=PrYhxwYctGedV58Qo4apnd+bjcn6wP/GRXP/+jXt4PWPYsui2rf1eKjiiaxEZarJsPS7+Z4qc7Ua8ywtAojwyb3pMnvQD2cIlPfHJFKWtG7Z5PTC5LDt20qXW9UXZ+IoUU1A7qM8skJ5xRzWBu47MSA4o1fKr/EEK/AAg3G0xLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581240; c=relaxed/simple;
	bh=enSOVsCGs4bxes4ItZtt6sN9rqkkFbugofi4iUTiV7o=;
	h=From:DKIM-Signature:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding; b=qfHlHCdi34I5PX9BpW5/464PctFbHKiNMrrS8W4r2npywMbdjwv7gau6BcXHV4EY5yae0papws1qtnuLyDfJljylWHWC1DDOsBa0NrTGyQyqebxzt3fp85LbmnELFgCnAubz1kIV9JYhgFRtNA4H2ENv9UX5UB2rOSKGQJozOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=CN++Aq9c; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1705581228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8vg4TreMwHyQzz57ZlQq9JFOtxfPPCMiJHGivl59KOc=;
	b=CN++Aq9cMKtmUorUWfJ1inQs3tM4qS9v46kSiGAkbVu9rR6Y9phUJL3hfEAHNX47CwRXZP
	FFr47QPeqZbmxFUtFavCQX+wIBnXIT7JsT6f8DTw27qdQX47H7O185rH0H7AOdz/8r9d5l
	v7XZEKwIkKBBlzjSe7/rTxGyPqDoGQw=
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	"# v5 . 15+" <stable@vger.kernel.org>
Subject: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression overflow
Date: Thu, 18 Jan 2024 15:33:48 +0300
Message-Id: <20240118123348.45690-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of an arithmetic expression period_ns * 1000 is subject
to overflow due to a failure to cast operands to a larger data
type before performing arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock_src() and helpers")
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/ni_tio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
index da6826d77e60..acc914903c70 100644
--- a/drivers/comedi/drivers/ni_tio.c
+++ b/drivers/comedi/drivers/ni_tio.c
@@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
 				GI_PRESCALE_X2(counter_dev->variant) |
 				GI_PRESCALE_X8(counter_dev->variant), bits);
 	}
-	counter->clock_period_ps = period_ns * 1000;
+	counter->clock_period_ps = period_ns * 1000UL;
 	ni_tio_set_sync_mode(counter);
 	return 0;
 }
-- 
2.25.1


