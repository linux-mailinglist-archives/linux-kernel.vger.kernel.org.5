Return-Path: <linux-kernel+bounces-156331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F178B0153
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832E7285269
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54A15687F;
	Wed, 24 Apr 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b="HDJwnIUq"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808D156878
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937820; cv=none; b=RhsIwcxPfIj/k+/QJsVg8UG3oA2kRwgJLcdBE8UWB+6S28VlOZibgMcMNCbhPVAOZGDeL7P085d3CYU1F4RbKmBcvd1ZbJuMOtPL69mSGEjJzUMmbe4Lmsxh3C6a6cYuE8ZfqF26rgXA4GiNMN0L/uEa2olOJk+emUE+GfOJkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937820; c=relaxed/simple;
	bh=nvIPui2ny2LbHagQUrcXOUnm1wNFXZyyF3UpKRbeMkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C16b0yUMXdpTuLpzmNpmUL8ZaU8LCHsQ1xij3c+clMAsUS3//yOLid3u2bAWGqKlTg8obGOx9PRV8lzl05ogg86UaPvYi0KZ95+wOO4wqdOOkdgww7ytw7apa/BpeqgXZh8dZqCZ5erFJ+1innIlnY1WdwxXgC98r9+OKgsxuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b=HDJwnIUq; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202404240550118f296fac051aeb8f0e
        for <linux-kernel@vger.kernel.org>;
        Wed, 24 Apr 2024 07:50:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2vHGINbeeSfwsgWaZmnck2tclo2bm4vX2z5Axlbkzok=;
 b=HDJwnIUqO1418xKMoN5ekvJn0kW8nJx9BMhr2NG/hAeSmjMlQfUjO1Vu6RBskW29ENxssN
 ysFD/QROGZ1OyhxDQ7Vvefzk44D7h0eNlHuu9TooZPIMSePqISL5U0hQ0WpVRKsvsDKfPYpc
 ZBYq5eZ41B85m3AsesZ02cxghGoUY=;
From: "D. Starke" <daniel.starke@siemens.com>
To: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	j51569436@gmail.com,
	Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/2] tty: n_gsm: fix possible out-of-bounds in gsm0_receive()
Date: Wed, 24 Apr 2024 07:48:41 +0200
Message-Id: <20240424054842.7741-1-daniel.starke@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer

From: Daniel Starke <daniel.starke@siemens.com>

Assuming the following:
- side A configures the n_gsm in basic option mode
- side B sends the header of a basic option mode frame with data length 1
- side A switches to advanced option mode
- side B sends 2 data bytes which exceeds gsm->len
  Reason: gsm->len is not used in advanced option mode.
- side A switches to basic option mode
- side B keeps sending until gsm0_receive() writes past gsm->buf
  Reason: Neither gsm->state nor gsm->len have been reset after
  reconfiguration.

Fix this by changing gsm->count to gsm->len comparison from equal to less
than. Also add upper limit checks against the constant MAX_MRU in
gsm0_receive() and gsm1_receive() to harden against memory corruption of
gsm->len and gsm->mru.

All other checks remain as we still need to limit the data according to the
user configuration and actual payload size.

Reported-by: j51569436@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218708
Tested-by: j51569436@gmail.com
Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f5b0d91d32a7..7c697dab6f84 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2913,7 +2913,10 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 		break;
 	case GSM_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
-		if (gsm->count == gsm->len) {
+		if (gsm->count >= MAX_MRU) {
+			gsm->bad_size++;
+			gsm->state = GSM_SEARCH;
+		} else if (gsm->count >= gsm->len) {
 			/* Calculate final FCS for UI frames over all data */
 			if ((gsm->control & ~PF) != UIH) {
 				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
@@ -3026,7 +3029,7 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 		gsm->state = GSM_DATA;
 		break;
 	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
+		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
 			gsm->state = GSM_OVERRUN;
 			gsm->bad_size++;
 		} else
-- 
2.34.1


