Return-Path: <linux-kernel+bounces-13667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E131820AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C911C20DE7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFC320F2;
	Sun, 31 Dec 2023 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DGCaUnSB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8924422;
	Sun, 31 Dec 2023 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704015497; x=1704620297; i=markus.elfring@web.de;
	bh=fX8AFaR7x87HsTh6nIC//eueVMeAPcdOmrlfPLHQHUk=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=DGCaUnSBuKr1f/ptwqcfa98KzB413qTy5ZtchiNllEkyNg+Th1qJ2MpgXNkbg7+D
	 YD5DBi+LRQwodlm/1GeofcagKa64JRKOxCaHwJ+gKD+FvBKGpCXqQ581+/a68e1ly
	 RXDAh2Gm5/UC5GcikoQ5I/BlSujKmTTXyMHvYSPzDi/J+9xmH5qBtBGO7D7CY+ZQ7
	 qg9yrjicY34WYLHFQrpp37hXOxfPs5TY+VIMGE4gU0puFRswSQFseofUkGCNnr2Sn
	 IMmeUvxpHKKq1h9i7EldaVOSfy2AoMUKe/1/ecs3Cb+/ojXEhjRa018Pr2RfNegdq
	 BCkikoh8sfsJCD5+ZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdfCH-1qkXWK2Gx7-00ZGR5; Sun, 31
 Dec 2023 10:38:17 +0100
Message-ID: <ef8b36bf-d9d7-46a4-9648-7cc8aaa8a980@web.de>
Date: Sun, 31 Dec 2023 10:38:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Andrew Morton <akpm@linux-foundation.org>, Li kunyu <kunyu@nfschina.com>,
 Michal Hocko <mhocko@suse.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Zhang Zhengming <zhang.zhengming@h3c.com>, Zhou Kete <zhou.kete@h3c.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] kernel: relay: Improve exception handling in
 relay_create_buf()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8cAMbnrx5PUzmWpIuZ3ENWfAXomfwk4vH6XkW65pVmmKbuBjJms
 KcHBoClLhCth389xP6fAuwM0yo+vzgXzDnU1xBseJKQXYlBjN/VGEMWwe6geP5/fYb40JER
 aZppaaFdtlZSTdUo6Xga5ACBmoRAC/UNXFkfoyrwN/Iuw0vPNPUDvv5/TNUp3WMBw0I/W0Q
 5iKa8rdaZguM52SFxwrIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TE4FyJwHFpY=;R4C80PLXC7bNJoaCP+76mtDrUir
 fEpQqTxyHJMHQ2IxBrS4diRWjF/UT49k7QmyZsscFMyyurPN576Jy6jI5yuw+VOJb8/UcoC4R
 6TnARN8eRw7Lx7/P7JgfSV0/BCsKkvZhJ6Ug173NXzcWEuZYe4W5e7hk9+JKaoeA1wdxIpjwJ
 Rk3iwA0m3QGxGjAL7g7BWZDnWQNkKhUuB5UBtotAfsgZsyGZJpmmse48saakQ5S2fRua9FHD4
 jX8OC3lAJOjFGtxuOHtzZK0TJZjN2cjeOYcxRhWFE2ZQk4gBLOt3ab2l3yFvfGaCooVI6Dnt5
 irkZSoZjlQXCRIG1E3uLNfaEe2uh1YcbVsJikE7s4rR/2K/NmjRZgn9gSm/1bfFB4nbsg7fLj
 swiXAGmG+rhqe56HeIHES//KUia2EBgkEGe1kiUJN2Fi7GWNCu2mDay9lG4K99oNUhQQpAHj4
 4PzuSgYKRG5lrS2O4u6xH1LXf0J5fUlgPgjmSlBlgDYkaRBAB5kwJjm6ALYUG3HisJtdGBot8
 sUUq5iuC9/zxo9b5QDvJJBXUOAFsUSdiByNDiLZ/Uhsz7D8pRSdkir6aPXg6+v2SzYmJJEmCk
 +AKtb/506clg487Bl404M6Ok4gni/NRnRcFjciuwNfI4CGNBUS/3EvtNDnt88xIvHSPTC1tk+
 aIYLouH2uynh3KdAavByEu1sLoGHTCzXcWpIk/AWx15StY9wM1qEOdCRcRfPGDoNc3jjsOdX7
 ITlNc6O2smWyIu3X7MMJYPZWSB4mEASyVeRoFh9q+Dhf7yS+hCJAxrCL+hESDUz0bdaS9MUjP
 uZSF8xCVgBd/+UYOftuqAYdybiLZPVIJ+/qeLVBFYNUbTiBiJSIt4WqT2sF0w4HmrGMMUKP8d
 JB3eiaxvzF45dn8BiwxraZRSETN3qopjIB2gvlYf7CaVlSB/nPoF8cC6C1PwP1Zv3v6eNRmXq
 6s1h+QOihtOGG0yzIvNPlzt2tJ0=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 10:26:25 +0100

The kfree() function was called in one case by
the relay_create_buf() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/relay.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index a8e90e98bf2c..b8c06305213d 100644
=2D-- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -161,14 +161,15 @@ static struct rchan_buf *relay_create_buf(struct rch=
an *chan)

 	buf->start =3D relay_alloc_buf(buf, &chan->alloc_size);
 	if (!buf->start)
-		goto free_buf;
+		goto free_padding;

 	buf->chan =3D chan;
 	kref_get(&buf->chan->kref);
 	return buf;

-free_buf:
+free_padding:
 	kfree(buf->padding);
+free_buf:
 	kfree(buf);
 	return NULL;
 }
=2D-
2.43.0


