Return-Path: <linux-kernel+bounces-32167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9788A835796
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7821C21393
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F697374DD;
	Sun, 21 Jan 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ayj49dUh"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC93838D;
	Sun, 21 Jan 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866421; cv=none; b=f6ZGMn1vUKDVDuDlRhBqD7vykQvgiFUfktjhxl/a+yqnIoEY0FtvNvZ3x4WF14gL8NfTgJzmqDh07umLPBTvNhEJ4QAV30fa82+Jgmt6kK+Wl0mGt80D8HvHh1fnfOIK1nRmjnI/+EyxNR1qTyzqRRmY7sBl5/19mncmdswuEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866421; c=relaxed/simple;
	bh=7m5wVgw/dtUbBF7VrDV/H9Q4wFpKMFawGAO1A4xOMUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QxFov/sklPm80YRugI3y7MKAQZfc4SY6V6KaiBOZc8pj5Q5ziYOm8Ob3o596pSUbO2D4DDoJAvE6gx+K3Fu49DLD5pEBtyn9wAZmBHo6Gie97Yd00ns4t0oS0pMweYaTPf0g1NR8iEqBXrxAvzaomleF1TlUB7+2648EsJ270hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ayj49dUh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705866411; x=1706471211; i=w_armin@gmx.de;
	bh=7m5wVgw/dtUbBF7VrDV/H9Q4wFpKMFawGAO1A4xOMUs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Ayj49dUhrSyjPkq+7fit6vI/TXZxPTTVJ9UNGriM1XvzfeF/PIzZBg9Urc9z8HlH
	 HRGcXuJ4OM+VgfHi6Nt0aEgJG4oM4yAN0sftPYJCg/kcONDrlDZsJqB4VIxOOLikE
	 aNmwGERfB6U7JBX8/DglMEgYKADe44GRkafMl8C41xdhOMKxRm46/vedsLP/0kaRg
	 c53RwN+6o1Ef6mVxgiJ/9giMqbapddAhxL3qaL5aHlJebDPK2VEs+f/s+WfVAlI6S
	 QZiU4YYCM3xrfk7zpvbTB5aTIbg82llmwoxchL2RCxw6P8r6D9N8pnUvKBEZjYC8V
	 URteSJw9fbiULwK62A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MatRT-1qqfOj3xZz-00cOWP; Sun, 21 Jan 2024 20:46:51 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: Use ACPI device name in netlink event
Date: Sun, 21 Jan 2024 20:46:47 +0100
Message-Id: <20240121194647.10540-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dk+deG1oo8iWNmccCAYDHp5t7TXcwUcxZMSkKxwHeqMcPbNx1OR
 0xkCZAlqtRp5euljR4u54XOQRDtl619y//qebWzs3ltX5fKMdZWS1f7sAAP6pBfrUvXnyz3
 CseD8xFPT/p81PNls+ULLgEfy9kYPIKcm4cPiwse5F1GePC3jH4cfcCK9kxNWhuoEeiTl7g
 E+ccS1/r7goV+IGyC58ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J0C3laZ1Rho=;m/Rw5EQFxH/jKvO5pHD3NJP4bWM
 fQUjrNiukoPU3D4c/rNS3vi6mfrtv1BbZlicpzsev0nE1VHenHk3S8KfgcS8twRgeBNLQY2/n
 HTTOHI2W+ICIoTE8Z+juN5p0KdpWdSgjCU9cTir4mCA5KsLJyQgLWCu8GE5yYHa9UJh3pKkvR
 XuDnemtaIFOhmHj5u6WM53dC6Jqxyym14RFk0db/QeXz3u82F0H1NqzwQptdVb9Hj+bP2sJa/
 1UqSG4JWN4S9K4uiBvXvK5sc0/aThD7rg9P7mYFzVfPJQJuqmc2xubI+u56bb0ddzvj3KXgwX
 uIZf+uysjIPp3OZDK9R8dVOHRYNjRozZ+D+DcdcT2JAgAji6ByRMn/MuqZqkpVXrQu4ozaCQ3
 gy29HV4MXxsjW08940E1yKPUY72wubZ9TisTq1uKuKqN8nnRlDQppDzkGng+r5nf8h+EefrMw
 yomB2l+8noA0IH6P6HiGlzujAeIJbtdiNrLumjgaZt8olpnfRcNCmOGqox/FywvGNNxGf/4wN
 MwIVe7y/EFAReWFJ5QR3XbsAQ7l9ZNZKnBjoM402ljPmHqWu5p9Qi3zi6KEk0vP9A4El4mArB
 cC6iZPnA/6N5/wQXgQxbk/b7QGZ6M0DiRYqZRDdReqnfay0ybGSuNj/XfKXYdyv0YkOd1sCGl
 JXLe3RkRWNnOnDlfzcV1w5QlHhWK7mIJUPT3VQbMDigb+0XI8GIFUhckyEeWOD+ESh7fYHon2
 TK41vnFO0p4GtQBdwdDyeuh2K6tg6MNAv8yLmwr2kM9uB6se4PugIp8ZOw+DrHNRdsBvLn+fP
 z+WEQnWtHpIukfsivux+xn0vPVGpVLnQiTLwCYCBXGDfRobj7QObv8Zqqws9oToa2LEwrd96q
 z2HxK9z0t+l41whBDDnsVqBs5Uef1HuEgnE0o475TWfRt+/pZmgvTCvZtXLa4atfwmLmTIsyU
 cdQmVQ==

The device name inside the ACPI netlink event is limited to
15 characters, so the WMI device name will get truncated.

This can be observed with kacpimon when receiving an event
from WMI device "9DBB5994-A997-11DA-B012-B622A1EF5492":

	netlink:  9DBB5994-A997- 000000d0 00000000

Fix this by using the shorter device name from the ACPI
bus device instead. This still allows users to uniquely
identify the WMI device by using the notify id (0xd0).

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index a7cfcbf92432..4bacbe71cdb6 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1202,7 +1202,7 @@ static int wmi_notify_device(struct device *dev, voi=
d *data)
 	}

 	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
-					dev_name(&wblock->dev.dev), *event, 0);
+					dev_name(&wblock->acpi_device->dev), *event, 0);

 	return -EBUSY;
 }
=2D-
2.39.2


