Return-Path: <linux-kernel+bounces-37304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DA83AE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA171C2208F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B617CF35;
	Wed, 24 Jan 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gUMhv5EM"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EC7CF08
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112673; cv=none; b=FVyHGCM6LJBIsxdcm8ysnfRt37IMKcpx2hJc0IO0SawdiplxDioVOsHLnqoYtxOMqammYejzeLOtL9L8IfqNtzvuD4psjTtU/srncV434ziM7uiYRQFp8qcbY1Q8LrrEG+FjYWXW4j5JMFJMe7jSQ4VZ3jz6rLVjXXWJdyH4zKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112673; c=relaxed/simple;
	bh=UX/O06bb1bYHqBE2zORSZJORTNiEHtAspjOJqex86MU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ejukvIXysv+VIjgHWGiYarKE0HxlnbUhRQ/AwJZ+QA8CfnU2qc9xstLYLq1ztr09zn0O5WTnTwNzvc9W+3tjB7mQooBgS4P+DdCPrquD1cKrWC6KRHociy1mvz8jYHhn0Etfkd8CnZKoGzswu3s0/dKDNS1JbgpTBwdiuWeVs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gUMhv5EM; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240124161100epoutp014d7804021947aa39dc5d15d6226b6faa~tVGz0syCm2165921659epoutp01o
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:11:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240124161100epoutp014d7804021947aa39dc5d15d6226b6faa~tVGz0syCm2165921659epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706112660;
	bh=CdBTzjj9QRIrDtLF0bR4Lb4tmSM1Gbb3D4QyktOKNi0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gUMhv5EMEjkZRnMCeDuNXSAj3zXu2BvxCaBOLesLVuIaPZ7A0oLRGRvsFQCTwgRlD
	 mOvSZh+olg7VSrD5YxF8df6tCwIHB2JkdSEFRi4oPwncg6U2HgKD50xWoZIklgUCcu
	 oChgdNV9m+Lla0K1kXEw+H8NEhl/iBDTjEIk+JYU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240124161100epcas5p4b9b6c9dcb7022e9e96eea94e54b82ac7~tVGzbgdQ91524215242epcas5p4Y;
	Wed, 24 Jan 2024 16:11:00 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TKppp58kQz4x9Pt; Wed, 24 Jan
	2024 16:10:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.0A.19369.29631B56; Thu, 25 Jan 2024 01:10:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240124161058epcas5p40b641fe9049630c2a9ce69cab17c40b9~tVGxYAGmA1520015200epcas5p4L;
	Wed, 24 Jan 2024 16:10:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240124161058epsmtrp2bd0ef5a3177afb500d64363ae0fb280c~tVGxUWEY31670316703epsmtrp2f;
	Wed, 24 Jan 2024 16:10:58 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-56-65b136928acd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.E7.08817.19631B56; Thu, 25 Jan 2024 01:10:57 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240124161056epsmtip16852c3426d3ea9edac9ec66013c001ab~tVGvz8BbF1251112511epsmtip1d;
	Wed, 24 Jan 2024 16:10:56 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v3 0/6] 
Date: Wed, 24 Jan 2024 21:40:22 +0530
Message-Id: <20240124161029.3756075-1-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTXXeS2cZUg6V71S2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xsT9a1gLXgpW3L36hLWBcQpfFyMnh4SAicTiR3eZuxi5OIQE9jBKnOm9
	wQySEBL4xChx+Z0xROIbo8StJTuZYDpuTdjIBpHYyyix8eNrJgink0nizI0TYFVsAloSfUe+
	g9kiAhES7xZsYgSxmQWuM0o8eBgIYgsLGEtMfXaCFcRmEVCV+LzkKDuIzStgK3FixUdWiG3y
	EvsPnmWGiAtKnJz5hAVijrxE89bZYHdLCNxjl/j2aDVQMweQ4yKxcjknRK+wxKvjW9ghbCmJ
	z+/2skHUdzNKLL19jB3CmcEo0bLzKjNElb3Ez9cT2EAGMQtoSqzfpQ+xjE+i9/cTJoj5vBId
	bUIQ1SoST7t2s8LM/35iIzSEPCRW3f4Bdo6QQKxE61KeCYxys5B8MAvJB7MQdi1gZF7FKJVa
	UJybnppsWmCom5daDo/M5PzcTYzgpKgVsINx9Ya/eocYmTgYDzFKcDArifCamG5MFeJNSays
	Si3Kjy8qzUktPsRoCgzXicxSosn5wLScVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2
	ampBahFMHxMHp1QD07yHdjwepn+e/fH91XZv7u3rG2alW7tu324k+3Z9d8i6ukm3zQLCNsid
	qj5xMKW2rOj5g6RprCrHfJ5zcH67aPjseaLr0rxHWR5/nRd1fxfxnv7iwuqjWkldroovrY22
	7P4jqN48weT4sz+2p0Nviwbu4xfY0bFezjt9f9XdfxnHS40vnD5sO//lBGX2qiZTce3J5Xvv
	/JROa2c6ysoknhuau32aTgS/Yfu7jc8Eji9dN0M0zK9RpMaX/Z8Zo76G9KNZVlmfrYOeGRy5
	fybrUA7vzlqF37sVVXi19vGHcxm1bf39QWilQNi2nNJpeR59jcY3Vm0IO1C8stGlPCbBf96i
	h/Nkb1zesv+71Ouor0osxRmJhlrMRcWJAJxEHugTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnO5Es42pBsduW1pcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGxP1rWAteClbcvfqEtYFxCl8XIyeHhICJxK0J
	G9m6GLk4hAR2M0psP3eAESIhJbHq+j0oW1hi5b/n7BBF7UwSEw6cB0uwCWhJ9B35zgRiiwhE
	SEz7t5YRpIhZ4D6jxNb9V9lAEsICxhJTn51gBbFZBFQlPi85yg5i8wrYSpxY8ZEVYoO8xP6D
	Z5kh4oISJ2c+YQGxmYHizVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLS
	vHS95PzcTYzg0NXS2sG4Z9UHvUOMTByMhxglOJiVRHhNTDemCvGmJFZWpRblxxeV5qQWH2KU
	5mBREuf99ro3RUggPbEkNTs1tSC1CCbLxMEp1cA0edKHOTYrf0/o3vVkF8898/eyx6wqpy96
	89TsQsnm3Yv8Nyh9/JrT+uduh2y69L/bDnePFc1+UOJ8x0m187e/n1XPury34qJrNu5nrtBX
	suialBa2e/v6/d7rw388uGmn9Ynz5lwd5e9CsQv6FWqD1jU8WvAjoUrT5M4hxmROrkcvJjeZ
	x53+WOl1se/apspTqzb2xnyc7V/Ls+z77l1M9WGsCi5Gf+8sMdDsYAk7P50t+/WaxcK15nyp
	L3cLiaSnzwlt32B1/fLVkCVsgnHLV88Ti+P3lxBjrLLSObbhaXSMZeuu/VPqvz3Qa3gte1cs
	0r2y++296C2vv90Q+P5gIs+SWcvO1T3pC5x3ZH6jmhJLcUaioRZzUXEiAEkarGbMAgAA
X-CMS-MailID: 20240124161058epcas5p40b641fe9049630c2a9ce69cab17c40b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161058epcas5p40b641fe9049630c2a9ce69cab17c40b9
References: <CGME20240124161058epcas5p40b641fe9049630c2a9ce69cab17c40b9@epcas5p4.samsung.com>

Dear Kernel Team Members,

I hope this email finds you well.  
As per the review comments given by Mr. Joe Perches in our last converstaion over mail.
We have incorporated the feedback on our driver. Please check this set of series and help us to improve the samsung driver.

As of today, Opensource kernel Samsung driver only supports USB HID devices and do not have support for Bluetooth HID devices. 
Samsung would like to improve the samsung driver and extend it's support for bluetooth devices as well.

Summary of changes in Samsung driver:
 1. Add support for below bluetooth devices

	Samsung wireless Keyboard
	Samsung wireless GamePad
	Samsung Wireless Action Mouse
	Samsung Wireless Book Cover
	Samsung Wireless Universal Keyboard
	Samsung Wireless HOGP Keyboard
 2. Add support for Special key processing on each of the above devices.
 
 Patch Series Overview:
--------------------------------------

[Patch 1/6]

HID Samsung : Broaden device compatibility in samsung driver.

hid_is_usb() check being moved.

[Patch 2/6]

HID: Samsung : Fix the checkpatch complain.

Warning found by checkpatch.pl script.

[Patch 3/6]

HID: Samsung : Add Samsung wireless keyboard support.

[Patch 4/6]

HID: Samsung : Add Samsung wireless gamepad support.

[Patch 5/6]

HID: Samsung : Add Samsung wireless action mouse support.

[Patch 6/6]

HID: Samsung : Add Samsung wireless bookcover and universal keyboard support.



All these changes have been verified and tested thoroughly in android devices.
Please accept our changes.


Thanks for your time and consideration.

Best regards
Sandeep C S

Sandeep C S (6):
  HID Samsung : Broaden device compatibility in samsung driver.
  HID: Samsung : Fix the checkpatch complain. Rewritten code using
    memcmp where applicable.
  HID: Samsung : Add Samsung wireless keyboard support.
  HID: Samsung : Add Samsung wireless gamepad support.
  HID: Samsung : Add Samsung wireless action mouse support.
  HID: Samsung : Add Samsung wireless bookcover and universal keyboard
    support.

 drivers/hid/hid-ids.h     |   7 +
 drivers/hid/hid-samsung.c | 459 +++++++++++++++++++++++++++++++++++---
 2 files changed, 430 insertions(+), 36 deletions(-)

-- 
2.34.1


