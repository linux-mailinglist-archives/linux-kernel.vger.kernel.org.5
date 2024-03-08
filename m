Return-Path: <linux-kernel+bounces-97485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F5876AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68091282ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A63FE1;
	Fri,  8 Mar 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="NbGBiWOD"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B999249FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924068; cv=none; b=qr6622oTEu9y/gjkph8cbmvGE3ZOS4qhuQsDwb4cyvpjNwC3/QGZ4wR6KA4Gce6fSUj0ROuyy9GggLQG7BjPK/aQHAoAq4TXXCwSoLOtcWVzLu/eW7Hg8iUJyi2OM7W3/c46g7ZdT8QbA/sQH0W2sKgNUowgfsAoV7s99Am3fgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924068; c=relaxed/simple;
	bh=boTAUudgAa/bcCgISeFb5WFztoS0+nbfFlfZhHHnvVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jsR14TgD63RmKmhv2YX6rqRP2wzmLeC2Ol51olLcj9HcSoGbFgkzaJd/z9VY5ebt/wuLxsWRf5/TZhX8hQxDdeRnwbBGq/tZ/uSMZOd3u5Ju9Ndue8/AF5Xl7D8gfsUAS7V9dZqpC/gt5h/cKvEAhoLEkCEGo9Dh3dHO5NVVN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=NbGBiWOD; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gL6cdh/XNsrNqIVeHU3hrV0kdShNxmskNNYI9x0juTQ=; b=NbGBiWODtWI4lIB+Yk4GF0+nIC
	PcvCUQ722kHHBy8FzkSRe63+CwaG9FtXxOizwO1QHhM4WRUArQ+NiBKequagSLNmj+UFwhNE0cDAU
	Wpm96DyNuMrUiCzTK38vp0JiEknTvaRM43H/gXHt5yyRlqduOxgS49bGPa5e2AbTEf6QFXmipIVFP
	wpsm3j/sdsk+cbQf8j/EW7Sg4utuglQuotRMukG+7OVxB1GHcl/LSEzHfCzdEHzNowsnObljMiFEJ
	jOLGL0cNWMyl9J8yXAwnFZs20I8RRPajqYkeWLgs08caa82EbcMXApB8zxvvnBgh+G6CcCayApaQx
	52hm4a/A==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1rifML-00CPLJ-F7; Fri, 08 Mar 2024 18:54:21 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1rifML-000000085rt-0Gcl;
	Fri, 08 Mar 2024 18:54:21 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org
Cc: hsweeten@visionengravers.com,
	abbotti@mev.co.uk,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] comedi: don't build module device_ids if built in
Date: Fri,  8 Mar 2024 18:54:19 +0000
Message-Id: <20240308185419.1929060-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

If not building as a module, then the device_ids[] array is not used
by the  MODULE_DEVICE_TABLE(pnp, device_ids) so remove the warning
about it not being used by enclosing it in #ifdef MODULE

Fixes:

drivers/comedi/drivers/ni_atmio.c:209:35: warning: ‘device_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/comedi/drivers/ni_atmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
index 8876a1d24c56..f0dbe4c2341a 100644
--- a/drivers/comedi/drivers/ni_atmio.c
+++ b/drivers/comedi/drivers/ni_atmio.c
@@ -206,6 +206,7 @@ static const int ni_irqpin[] = {
 
 #include "ni_mio_common.c"
 
+#ifndef MODULE
 static const struct pnp_device_id device_ids[] = {
 	{.id = "NIC1900", .driver_data = 0},
 	{.id = "NIC2400", .driver_data = 0},
@@ -216,6 +217,7 @@ static const struct pnp_device_id device_ids[] = {
 };
 
 MODULE_DEVICE_TABLE(pnp, device_ids);
+#endif
 
 static int ni_isapnp_find_board(struct pnp_dev **dev)
 {
-- 
2.37.2.352.g3c44437643


