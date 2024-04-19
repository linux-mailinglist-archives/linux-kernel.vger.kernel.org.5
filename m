Return-Path: <linux-kernel+bounces-151572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEDC8AB091
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F50284E31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BF12E1ED;
	Fri, 19 Apr 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="DDO8Rh3U"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3C12D745;
	Fri, 19 Apr 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536253; cv=none; b=VBzGuKZ7yMRP79yt5/MA7trTeI6eF2VkgRG4hi4LsGWEJU0Fz+8+znIdcfrLGt00eoiXgXRuSnkMe2mUT3XD174Wmfpj7YiDoQDL/PTkLxctcFcWhIkKqgTIy8qc/XA90lNZ72vprZHXqtZGzzmhpWm2A+Q/SH2z1bmgIkbLi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536253; c=relaxed/simple;
	bh=vTbu8+uaAy9bIlLRAIIsaySyMLKaBd92pRdl6Gb8tBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3g5qXuWyVi/71M8NsmIleLisHZlXmf09q1w05wziyDKAevZSpMDDJD+eC3qAv/KgWVzXd3IIDflHhDf/P80L5UORiYaXheqij5G6nx6FtEw7XY5wNcjc6GB+xgAONHsmO2tWfgbAVgmTdcvAcZ2vnlvSahZjJYSmSST/znwKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=DDO8Rh3U; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713536243; x=1714141043; i=parker@finest.io;
	bh=mMKORGqoebFxU+tv5m8Uye3wb8KIjSNC+fOYILy9MRs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DDO8Rh3UWZjPUHImOKNZXT4lVFtCcdI4PEDtWFQx9Rj7Q12X73QZUUrhvZoYGqgI
	 RbtR7jLx62RdN14FSDWuTwVmSlPgOkU4d5TiYPcpq8Dv3J+yeQWh7IRy4yi8l7LFW
	 qvWT6NcUiff0PESU547DW8ut0mDmYgC+5v62Ihe+rR2iMLNcXilSM9JGkDM2IrAOo
	 ywfsW+7A9xL7j7xNPxVz1V3xRv1owaYdRBFQRvbw+cu1bw/kKN9ULQH9sP96gLdaB
	 6xK1UNFF6XmYlbJLmHoMBAEQz9BpgTvsTE/7oS6uwMMoWBHrkO5TJVviRtfShFr3+
	 pCLXLNqUaJdOVwIZjA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lr0UP-1sbGfQ08d1-00egVb; Fri, 19 Apr
 2024 16:17:23 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 0/4] serial: exar: fix kbuild warnings and code style
Date: Fri, 19 Apr 2024 10:17:00 -0400
Message-ID: <cover.1713533298.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pI/AEIEjLuATnt6yZm7in2tJg0aZALvjwgtfzsBtL8HMkPlIzjt
 yXdw8+9jqhwsZ7Jcub1xoe1a31Rkc7prrtJyWSaao7MugbUc8a8YcBbDO77fSuaC+N0rTXP
 wmLjBbylXMgFninlmuvFY1ECa70y442bjg1GKGbBweOD6+cl1qKPYgYFOTkZ1luKR4BcAWG
 DphKeBrDzYWrOlvO79f/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Drs03ndMec=;0KMHNMJLDPMine7dJjdqCUEXfb/
 TiOX8WZktknVlhT5Qu0U2qH1MHHySIq4h7aCcltCv93SwN7AZtwxZS6wR0ae9QQYtGV437iX4
 zbHAS0sfJKrihg4nA/pytGrHhpLNI1ZlxX64xghcN+pYTA0wN7H/QqYGDNegH0rr/0c9PAK6B
 BkCGF4XzZT3ltfoQ3rQZl/9tjqRT4ghN41dqCmYY0AtY0Rum4KVJsU2rvzfXFDl5kXktateqW
 9OZmFa6MWc/XtfLOUu5i6zwznZLn9GNfXOLePVJFjlF1sOIIn2APhgJGCWTYfp5BOpI/EVYwE
 JUMkqETv/ViYeq+RnmYjyhTK7MuJXCcm/Hv712EYH4Fl6wX/y2UvzN09x7kUUOQ5a3ZYqjYUd
 bXkq2Djk26n+pRlG4R37iIHXIQ/f2Zg23JSXKxIpLkHzmgwK+kelUN6jiYpyisrStJsJhjZh3
 bJkt3gbIfkLt2GmOUeAHpaEzWVYAT3Pxg0MPyNz4YqbicUI20giA+/vOw+BCu+j7l0cF0ctGv
 PWQJqoNl09YOEUBmemQ4w2/E7+V13k/Uni8T54ioM9rYWkY6ybn1Cq1SuG59roUQMYkKv+JS5
 sont0mgz/O5XMa1Wbs6T5IbsSFnvf9gi9DDmgKY04/Wk32KUKL1xSfqwFSfpHX3FrB751ovnb
 o4jMEN6mT8z53Z1UcePJ+0CSBXciFTH5vqx79kyR6cF9hulGkTgyp85JklldG7GPjF/olHo3F
 X38H/A9Ve4unHJb5TLe6xNQrcuTiq947EUQj9xN+zGfcbbuG0F23AU=

From: Parker Newman <pnewman@connecttech.com>

This is a series of small patches fixing kbuilds error and code style
issues based on feedback during review of main patches.

Original patches thread:
Link: https://lore.kernel.org/linux-serial/cover.1713382717.git.pnewman@co=
nnecttech.com/

Parker Newman (4):
  serial: exar: add missing kernel doc function parameters
  serial: exar: use return dev_err_probe instead of returning error code
  serial: exar: return bool from exar_ee_read_bit()
  serial: exar: remove ternaries from
    cti_get_port_type_xr17c15x_xr17v25x()

 drivers/tty/serial/8250/8250_exar.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)


base-commit: c6795fbffc4547b40933ec368200bd4926a41b44
=2D-
2.43.2


