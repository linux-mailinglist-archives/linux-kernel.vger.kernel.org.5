Return-Path: <linux-kernel+bounces-68191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CB857706
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9721C21E99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93199175BE;
	Fri, 16 Feb 2024 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=okanakyuz.com header.i=@okanakyuz.com header.b="TRTefXCL"
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277CB1758E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070007; cv=pass; b=cQ5hEg2bCxX3Np/rptZmwb8wfN3kq9i3Xj9s8Il/Di5zwe+fZD6IdPtWbcrpgh3YxQ30D1d8X7+6O+KZjceQfmbnzqLWhOqqjKODIy/4f2L6pucw0p7k1YoybfJfoa54WDajdBQL0fTUKmQY9X95bsSLyPTsTvoUqTtyOxa4k38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070007; c=relaxed/simple;
	bh=PezQPniDwrxOS1sZ6Z9vu2b1Y/jy/gMt+PRn3CnoUHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcnm/eyGRDncXk/UOH9EtdvmpUl5rNURl/T2WUP3Jv4qkYk2LNgS8QI5RcdVwA8LdoErcP0aH46MvQsFASjnF3S7XpeyCWv659rDg93Cl9U94u7AciSw+mVQxVIK+m9Kgl1ORxOYX6261xm4801wW1OzONpcdJbnDhdeQzfJWSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=okanakyuz.com; spf=none smtp.mailfrom=okanakyuz.com; dkim=pass (2048-bit key) header.d=okanakyuz.com header.i=@okanakyuz.com header.b=TRTefXCL; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=okanakyuz.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=okanakyuz.com
X-Sender-Id: hostingeremail|x-authuser|okanakyuz@okanakyuz.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A8844141105
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:53:18 +0000 (UTC)
Received: from nl-srv-smtpout1.hostinger.io (unknown [127.0.0.6])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4A7E8141193
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:53:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708069997; a=rsa-sha256;
	cv=none;
	b=5QConbt3OCwl+6teJu7XNZTygIktU496c+lG90MeeDkypkZxMPeBshxHD2cGZT9EI1sbdJ
	skNOk8k0ZJgOJgPN/tv8Y2SqEDh6sbtaaqDRSIUHgj9wnZmLc+ZDQ3jQZ8awA5ZJUaV4k5
	/NbREib/n0e5EpYcfdazvvgUURl+URxUK5lm9A0Dj6kxvbJw+ShaiT6XFvPsvmY8uZojpt
	zYJhuRWQdzY+a4SvKb5exGtT9Fzq72+Ci8exPR74Vf8mooveJFT5t2FBCwDm1Fag/yH5HU
	zClHnxuK+PTEaJpk0V+grJ577WCoOYKQEL/HrUCiDspV8g9s1pPmWItiDR6weA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708069997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8cmGCBCZUEA+TV3yv1pZQqP0Eu0Q4AFcXv53Tf+4EVA=;
	b=FMR35+bEHjuXDTmBb5koRU7EJootvOOUTZ2CZA4+GoXCU2cYVN9nmd5j0dJ/yiK+01UkVk
	HVS6FjzokGOFXxFgiOQ1gyI6xMSQW/i5mzKG6bAIDwhJchpVcBBp+mXg7edbfZjY2mWKoQ
	1Pk4ELddkuWsaPuMpNCFQUTGqFOrze+yOWpdCPT3N/2PD65x8lrdXpponUj9zffZMzuIya
	xI/csWeYyNA2TLB4AEo+D34L8Hwv+irahqxAqP4J+WnIJlZoPGpcjUtNWQif00S7fEZMMr
	drrdMa+DP7bm/VmvnmaCqAznuMuzRx6+wRdCto6qhr33mLAh+4cZbhBMYJJskg==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-q6zv8;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=okanakyuz@okanakyuz.com
X-Sender-Id: hostingeremail|x-authuser|okanakyuz@okanakyuz.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|okanakyuz@okanakyuz.com
X-MailChannels-Auth-Id: hostingeremail
X-Supply-Skirt: 0d5b788836bc1297_1708069998360_1092149339
X-MC-Loop-Signature: 1708069998360:2392319591
X-MC-Ingress-Time: 1708069998360
Received: from nl-srv-smtpout1.hostinger.io (nl-srv-smtpout1.hostinger.io
 [145.14.150.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.181.84 (trex/6.9.2);
	Fri, 16 Feb 2024 07:53:18 +0000
From: Okan Akyuz <okanakyuz@okanakyuz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=okanakyuz.com;
	s=hostingermail-a; t=1708069995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8cmGCBCZUEA+TV3yv1pZQqP0Eu0Q4AFcXv53Tf+4EVA=;
	b=TRTefXCLsMTfrTsBtc/J/itLJ2XMJM0yAN7TpWEAYP+9h5q4fHEoR0oNFxJUaNbL2PeYHH
	fxzx2+8th6lE6FtTFJfGZTHYwcvZpbC+GfVZWsRtZzphEA/JiByXUKnta4b/vpHi1o7Bcp
	KNJcxb0iVqveglNWjNOGmC0J6J88FxI6jPcADaY4M4KGqAWo4d1i4JhuA4v70gudL+Ih75
	i8XhOw5ChZQu5Kie0RPsapLWf0PTX7EmzSIFXEnFUB9ZfPxpqcE7L7mRMkotw5Its1IVMY
	19jwVNSzDCMw5ome6Y0BKJlS7y6bGTGXiN0nWQE64mt+cgGjhQVw9ndosqOa+Q==
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	okanakyuz@okanakyuz.com
Subject: [PATCH] Update broken Datasheet URL
Date: Fri, 16 Feb 2024 10:52:12 +0300
Message-ID: <20240216075212.69118-1-okanakyuz@okanakyuz.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-Analysis: v=2.4 cv=DIOJ4TNb c=1 sm=1 tr=0 ts=65cf146b a=geHYaF3j5ifCImHjKwHHfg==:117 a=geHYaF3j5ifCImHjKwHHfg==:17 a=-tA9vPf7AAAA:8 a=UXzzSC1OAAAA:8 a=gAnH3GRIAAAA:8 a=GDfwrwm8OuJMyJXZuzcA:9 a=vtdtr2SZiqPAgdHKmkdM:22 a=NXyddzfXndtU_1loVILY:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-CM-Envelope: MS4xfBJ5/lmWxDk8XyjpN88LEIZVKZvTv/g7W8OexkmoDW7V+K8eHde8XNgYKiWZCNI0JgCyugfhGhOOUkUczW5LYsB7fOWVD3aM+0Pwg1qqN05XCEi8NIjK YNcZUVBJ6NX58Fz1761dAM/SAj40PNyzid8tady3ZNxLmuE2grzZGDUxPFIWjl3vN1iZMxNQGWQkgiI2HiCTbhuNZV8PUN1URjLwucqngczsdn4W3zrUShRi nQo0NzIIyEPG9Wu6KCezx83n4dVQSwdEhW+h/weYocfLPqYntaNFceRh+UxxqZo6IqVXMm2HWz5JGZYS8L18UijlT7Lb8YUq0impiRJSLTdbzuBosicmXnx5 f+ecEu/sYaRqgAs8arQX1f4oYBPubsFpakbigwsDmUrWPN8Ak9+BvFtNxz34LUn76YPalOUcTK3HNnxuWq4DlhKR+mbk/A==
X-AuthUser: okanakyuz@okanakyuz.com

The URL for the document in version 19-4039 Rev1 has changed. Updated
the URL reflect the conrect location of the datasheet for the same
version.

Signed-off-by: Okan Akyuz <okanakyuz@okanakyuz.com>
---
 Documentation/hwmon/max6620.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max6620.rst b/Documentation/hwmon/max6620.rst
index 84c1c44d3de4..d70173bf0242 100644
--- a/Documentation/hwmon/max6620.rst
+++ b/Documentation/hwmon/max6620.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6620.pdf
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max6620.pdf
 
 Authors:
     - L\. Grunenberg <contact@lgrunenberg.de>
-- 
2.43.0


