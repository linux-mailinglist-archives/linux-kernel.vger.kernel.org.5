Return-Path: <linux-kernel+bounces-63362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E8852E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2487F282DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64433838B;
	Tue, 13 Feb 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HZKEmmCg"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01olkn2085.outbound.protection.outlook.com [40.92.112.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B0374FC;
	Tue, 13 Feb 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.112.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820746; cv=fail; b=jHuogw1OU5ax7lsdeW+iAd4gqWyNHVcFay2/rZGbcZ7fC4txwiVOH+G8VJX8dsogN6ze3of3OJJxrk0Z7trgwFIkcXKe/Q/V1MG0l2Zk9RpkiT85a7+Kn0lEAUd6LLSuIW0eS/fY1U4AswHqS4B6y59/bcVKxiEHr0esXi3kusY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820746; c=relaxed/simple;
	bh=HEx74xVct1K22BU5pZVsWC9q+zcD60XCunleYocDPPU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l6EPtsP46BDI/0ZmavDR7qmfds5nMkRgixiXGTZ1ILDRI/LEhRY/FW4PmbE5x7ceZ8F/qV5Avth4cDyTOIcCkkByxDEgFHrepZjWxYPjn2dfyjCKfIk/Tkt0r+IKw2Z81BLVg/yH8ZdyQ7uksj/wV6rI9+/lVSu9mbsn21w8uVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HZKEmmCg; arc=fail smtp.client-ip=40.92.112.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqKuUXbu5NRxZARB5iBNSJVZvtLBHRLwzfR0hegs6vBtcY0IDUpgdQjlLSiJKCpOUkqBDIZH+owUImzkvBYt4DL2jf0Iu+OlRZjz95a8QiA+6xUOkljQUg0trLITuQCReOZKyEYP00wj9uOXHVSwNQZFIckV+ZMS7biOwHKQ3hXYttw4YcyE6tiqdnljKwANmtViVOr+a3gTEcUBSd9ts6go9QN8k69zg5s+i2mrzzs0gGYfDknl9syuG+6mwbzbYfojR56RDl61Ze12lt70u4vH2glMXE5TzaQPa0nek/2plReWlpx1sBuDbLmfGFCIxKvnceYj/Z53aie6+GcGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ee7ZkrqbDzwdJ//4yxSOmy37wLqqQbz5f4eoNDDkl0=;
 b=iHTMebxoG3oyKAH8lZ/F0I3McsU3C/raaw9mZCzpxaIvbS638GX2rF/o2s6uJhsHfXJn1sNwz0KjfVMJJd9RzufxhzzTN6HTBRtrRdCIY8mCPcqHAMg3V1LSNLEuF+Rjtb531HIY6HezXsPgHARqWRgdXATRhhX/sP9TlbRB+kR3PkQpWYA6Qjwkj1qGJQQ0CNmosTmLfzQLZmpnpQkkdEVKtgijvnPtdJvrvJk/1XcpXmN586JE8xSVFt4WmDu0PwWtDqfLGOH46bCWTLMm2/QRv+NAAKIaUAsqksJdXNfs3TY/gUT60a6pYYyhhsPIaA+SvFvTw0jZBoFOnsDbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ee7ZkrqbDzwdJ//4yxSOmy37wLqqQbz5f4eoNDDkl0=;
 b=HZKEmmCg00ikCqPCdIv3UvOpJZcN11DnAkVbYmtRNk7r7UOTpaFQctdKG7KI8g11mjKvroJ7g1gMLg4YSKmEWeT4gT2XJaxemRKCv/IDc5Uxkh1xR+PEzvsQyfwSOMu7WF2U6GK/yiNp1R/jhCtlIauxR9ypmFlAZ1dFudiArYnMBITStz5F98Lyo1dtVVLa/ZOud5/93S+emAKBT1YtlMUJKIa7OjwJB7GIZRIGxdwN9ZcWmx6GLGZ1lOarXRCArg8O8qhHb+6BEI0WpbRteSTMZ5+kmqLqgkEobP/6bT85Yoh8iR5ZAvIVNQLNtKYCddwWjJYPhu9mBBeEVaBkhA==
Received: from CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:160::13)
 by LO6P123MB7301.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:33c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 10:39:02 +0000
Received: from CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8b25:d0be:5a33:99e9]) by CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8b25:d0be:5a33:99e9%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:39:02 +0000
From: Manuel Fombuena <fombuena@outlook.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Raul Rangel <rrangel@chromium.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>
Subject: [PATCH] Input: synaptics - enable InterTouch for TOS0213
Date: Tue, 13 Feb 2024 10:27:11 +0000
Message-ID:
 <CWLP123MB5473E0C4823DAD90E9F3F8F1C54F2@CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [3tA+OPqdlPD030W8jJwBPvSlq5e/1WdLF1S5Ebr6Q49clpxoR9nkC5GyvpooFJdw]
X-ClientProxiedBy: LO4P123CA0571.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::10) To CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:160::13)
X-Microsoft-Original-Message-ID:
 <20240213102710.399833-2-fombuena@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB5473:EE_|LO6P123MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d7295d-906a-4150-b9c6-08dc2c7ffe76
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Sd8gmeCF0Pw/+dSUfqeU5KGTdMpzV7AtDAey2EoOKPtHYS6fhrr5wHSYnxPM8JU0110F1y3VJvPu1U+xo6DME3TGYEo145Sz4ObzqJCvfDOXoHmbrpTG/7i83SviUAsDUUXgRCVAJ7Acm26AGBUVh6OyYrxvGGtAaaBWJZRYQzneVlSi/h9BUYilk8BBtRkvSXqK+CiY+5wUbSfHMHpAfX6clUqK/mZTevSP5e+JyPoazSawHJdjzeoSNjK24O8/3zq/KGTKzrDMD880U9hbQwqBwTh3mv1hAVuciIlzg7ewyYZN6cEaP8b0L/KQDFvLjLKSuRbDr89T/FMF5umjy1XDPBYVWadZsa5AyUFqeGJRJhksg4nfFVdUG8pFtHmaiuZcv+rVCBIE8Jw1ARMcxNpex2Pnj6UvDQTkLd/u7aX4fthmiZYwtttIQSEMCtVZ59unDD21V2VBUa7HdM+wH0yxtBFWbljxxRhfPz10LsCwcZD7LTXR89sgIO9ZEqXlCkHfPJUJK6sTDeGF+KnjKyNFdGWtO3CDJzugWN0ybpRn/0771VZyqsVDwV92+k/Bu8jooWrTZEoS6MFmRz02dciA1oJNvIsDdvv+k3otFy5YKCJGsj2n/WZHIqOPHhn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9RJuaelhUYUCs5GZewdKwWziU+TSChd00bb+AtKAnwtK/4UY9/mSx/Ua3B7?=
 =?us-ascii?Q?sBDe9oLmCJDGO20camC2uBtYTJ51jSi+SOmKK3SJQplTeqX2fwXEE560lovo?=
 =?us-ascii?Q?Zbs3IOtiCp35iHJT6tt6LbyWhMlJhpWpbCMPjP/5ecWq+BjpO1YrMxFX6EL/?=
 =?us-ascii?Q?B96d4jxkG5yvXzC7eDRClTsasg9PrEOY+nxAJJ2ms0qrnBhmZ6bPZHNU017k?=
 =?us-ascii?Q?zJaGGyCshBbV+1kPvelNYM6QNFAKOpW4Ixx1qsgSitUoeJvR5SJZk1FmoX8u?=
 =?us-ascii?Q?3DkXUOHJr/qPAScrVKIjHQle0c6TjHiIoUCvQCO6noe3wTMYJp6ackua+SdM?=
 =?us-ascii?Q?StuD9L7IVwIdSsU6990yzMRQdypWdLx249Q19tSJ9F+CCgk78dTZll2463Pu?=
 =?us-ascii?Q?7TyMdcLq0pygGPBA6Sgo4LmdrzRxOZNk3TyhVjCGX0VGHjaCX6Ncusqpw0je?=
 =?us-ascii?Q?tjmwRei6nulQQjN+bxUe/ZN6ZusOxLXUAIUSH9UOHCg0oEHuRe45623piRtr?=
 =?us-ascii?Q?x5TO9/7DxcuGe5ZmeLuIEXDKoupsRVxvp7fM1Uf5BdKFpmlpam0YoXN+hiqr?=
 =?us-ascii?Q?ut664yh2y9VddRnSrwrzjrsnYwidtp/X+bPFGehIgM/8WJquRIKAnloaesQV?=
 =?us-ascii?Q?NH6RCCDJ4U5CTptZ3PpJjwq/C3jdNxEAterV5S5TgLIOJoYaz3G4+UTiV228?=
 =?us-ascii?Q?3cZb2PkzZQYZ33N+SPrR7GMfHUpFxd57p0J0Z6GkmIy+h3CUzoPq/oSmjA8b?=
 =?us-ascii?Q?u/htS4ePWa8YJCIxmXNvvzxPNLjAy69E59qg6efC6iemEME0ngUekvPsuHwe?=
 =?us-ascii?Q?7JywZZrGlipWWZzQlL72cqcn61ogJHtbQDdNi2rQ0QScYHMHPHpyfjQsImhO?=
 =?us-ascii?Q?dkhj/kldpMr1CoBAEZtLGp5D+ipCUA/VPaisBlT9wjKMMH2dIeHIz4ey46BD?=
 =?us-ascii?Q?EDCGqWm+qS8skXVhV7GfSg5hNqLh+/Q8fbJxbjUqZdwyO9JhyJx9dc1WF95z?=
 =?us-ascii?Q?OtxyXw9ItH+iOw4Jii2B6YtUjIxqfQx0cmg3nUppN3kV3PKggF1NIqnhX07a?=
 =?us-ascii?Q?u6Gov0aPV7TZwvvlFWh4mPHGNDhk1oqpGC47F+A6hJ6ihtiXg9RBNf0p/LME?=
 =?us-ascii?Q?mzFIFXIk8Hez7j8bjQzyPdYsQJ+xL+KUBf9RZyEyAo+sVD/+n+mWJlnEoTYZ?=
 =?us-ascii?Q?gySF4GP0LxUeWdBQQEBl0saDXDrotaE3h1KiQKiI0OoYBqkEwimbFfZWaX30?=
 =?us-ascii?Q?T9bEo2ttx6XMbFuwRAYULacror+aqac3/5GcUOXLCtXZrVNZQMIPPyy1NuED?=
 =?us-ascii?Q?+6Y=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d7295d-906a-4150-b9c6-08dc2c7ffe76
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:39:02.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7301

[    5.989588] psmouse serio1: synaptics: Your touchpad (PNP: TOS0213 PNP0f03) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    6.039923] psmouse serio1: synaptics: Touchpad model: 1, fw: 9.32, id: 0x1e2a1, caps: 0xf00223/0x840300/0x12e800/0x52d884, board id: 3322, fw id: 2658004

The board is labelled TM3322.

Present on the Toshiba / Dynabook Portege X30-D and possibly others.

Confirmed working well with psmouse.synaptics_intertouch=1 and local build.

Signed-off-by: Manuel Fombuena <fombuena@outlook.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ada299ec5bba..a6601e007082 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -192,6 +192,7 @@ static const char * const smbus_pnp_ids[] = {
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
 	"SYN3257", /* HP Envy 13-ad105ng */
+	"TOS0213", /* Dynabook Portege X30-D */
 	NULL
 };
 
-- 
2.43.0


