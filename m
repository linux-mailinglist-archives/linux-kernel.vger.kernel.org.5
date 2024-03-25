Return-Path: <linux-kernel+bounces-117786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A601B88AF90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D232306DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97518C08;
	Mon, 25 Mar 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b="DF3tNrwP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b="DF3tNrwP"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2012E55
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394045; cv=fail; b=MC9dcYPgYm97fWQyx2r1M/WluUCrGiKyvC1hFRMEBtnK2D7Mw1KMLfRuDNc1pWT6Ljg74HYZq43HKjFaJZMXw9WWVFEjYKTqO6uZmT+4h8emeakzp3ZKhnsaEIza6E+iIpmpIGeY2oD9EvJYdXiF9PMLijun+N4MhaaXYYGnqC0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394045; c=relaxed/simple;
	bh=giqYI/ErHFSTwpDE5B9nK0XKnbeq61Ei22pxP73Jke0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A0fx1XhXncmmsgK0AA6E+q87oTp8gIMWVc8hF/Mk60cR8znwpwrkWMFTHIW3rJ3Chv8aWPZ139vgxYCtXw8F2Qu2XStd1R3iJmGvg8nX9D/mYIZMDNO6ceJE5S32UfK32NpospjyANVwffqKIRhQ8LqkvVUunzNg5g1xve5Ff9w=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeiss.com; spf=pass smtp.mailfrom=zeiss.com; dkim=pass (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b=DF3tNrwP; dkim=pass (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b=DF3tNrwP; arc=fail smtp.client-ip=40.107.105.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeiss.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=GpcY0bPChJbbK4dxFoD5dne257BQuJlIsbYFUuThO3dY1I+ckCIW6CdUhWhz4rbQ0jUaaL3fFEM61lWnzoK/hgnbqyjRDEHtE2qvCPhNO4eurMqqdv2FLRFOIcgzCv6d27caZhvCFwERgi+d4jpzqfkj4ortug/zy2f8gtfGhdzqNNMPwSwh5svcF8wg3v6B216m7RJsDkOuVi8fqyVR3TgVMH5+kU0A6KEnKl8frVKR6rYMJAtsAhjTYO5FrSUjIsljI7nyTDnpr4Pzh0O409PaZUBiTjADMekMc4ihP9pLryWoCplKpjpXkImwdXdiS/0Zs710OOndZnw5BlkX2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giqYI/ErHFSTwpDE5B9nK0XKnbeq61Ei22pxP73Jke0=;
 b=S4p72eW/Q/w06vH/PaUmDLseaouZH1BywTEtnsvzxXGxrD06J/58whtW0DmYGW2xm+I6/R2TLol0ShnONzGCcOPEdh8e/gpjqHfQ60TZsl68MSxTaf8rYZS/OwLkTKVh1e0WUZYQGteBZUkB0Lp91N3qF4QYIiX9vaDCigzR3k/Z4PsW9MGRE0tg3PjLyL3VuQG+5oRNz0/WXt6KWQCCLLF7TUsaAsnTzFxdkSkGTkXYE9lYUBj3FMHYkEXD++1GkZOXAyfjwuaXIu0XdbyAGOWbXY/xADWSJxiCu7sOgqFSOzl7eWlbDYhFKoTt++xlUydJe0hsefXn14FuwmJ27w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 18.192.202.217) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=zeiss.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=zeiss.com; dkim=pass (signature was verified) header.d=zeiss.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=zeiss.com]
 dkim=[1,1,header.d=zeiss.com] dmarc=[1,1,header.from=zeiss.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeiss.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giqYI/ErHFSTwpDE5B9nK0XKnbeq61Ei22pxP73Jke0=;
 b=DF3tNrwPvC4qnFox0py7c4hDrKEeIt5WLHNgbrKN2s9JYIFvzMvrCiTs+G2M3xAJHh4Js65d8YFXHOCIOVdIGOHW/ckou9zcS4AfuiwNo2Xm97cPynsQULRRdk1j/5pWjZYLBEV9cC1+dFvAtI0gd/cKzHVA/+fgFNa80JVx8DV4mSXiL16KkelGJUZvWnL+FCH4UZjSD/xYM4xUxKR8FGWSdOJLgQDwA0BpZ46W1+4kakzffAbs5u/9tDDLpyKIGGCbMU8HyuXN7WFmV6rcpSTwuIpFEwCmeTdwaT0oclO+wJfsIiFs1JuRRAcvbaLw03cgN75ngkXAs/OsjEwCbw==
Received: from DU2PR04CA0309.eurprd04.prod.outlook.com (2603:10a6:10:2b5::14)
 by AS8P190MB1271.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 19:13:59 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::48) by DU2PR04CA0309.outlook.office365.com
 (2603:10a6:10:2b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 19:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 18.192.202.217)
 smtp.mailfrom=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.com;dmarc=pass action=none header.from=zeiss.com;
Received-SPF: Fail (protection.outlook.com: domain of zeiss.com does not
 designate 18.192.202.217 as permitted sender)
 receiver=protection.outlook.com; client-ip=18.192.202.217;
 helo=jegw1.zeiss.com;
Received: from jegw1.zeiss.com (18.192.202.217) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 19:13:58 +0000
Received: from ip-10-25-10-14 (localhost [127.0.0.1])
	by jegw1.zeiss.com (Postfix) with UTF8SMTP id 080D61B6F7A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:58 +0100 (CET)
Received: from kag06088vm016.zeiss.com (kag06088vm016 [10.25.10.115])
	by kag06088vm011.zeiss.org (Postfix) with UTF8SMTPS id E96691B6F6F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:57 +0100 (CET)
Received: from ip-10-25-10-115 (localhost [127.0.0.1])
	by kag06088vm016.zeiss.com (Postfix) with UTF8SMTP id E6A6A1B6216
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:57 +0100 (CET)
Received: from kag06088vm013.zeiss.com (kag06088vm013.zeiss.com [10.25.10.9])
	by kag06088vm016.zeiss.com (Postfix) with ESMTPS id D96291B6121
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:57 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
	by kag06088vm013.zeiss.com (Postfix) with ESMTPS id C705FBBABF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1NXfGD8tjtFH2HbSXYgDHigmx9fMBD3A8ZpD89NPExyCVDc5sckTc97hrC+1StGo6EmLf39D7ysMuhHXWe8+ESqlDzVZY9DbJCnbitiS3kbysu5QTviGmmJ9qwYt8iB0ThPKWbzEuhjPwh97KWaCsH+k9dRcZM99e5M1dL9rMRBbmWkgJv565mnXZNVama5Kb46z6npzsLfmhyEV7BqIs+xVy4FHZis3Qomp9zP5GN2QgqzgPi3lS4/H0bV45DTrYmVbGoGFIj27OVfh+FmcEsPlTNl6MJWUQo/107cxk9LRnFq/sajQcwyvOkAyEg6iOpQnOqasiEsjcOeLYaG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giqYI/ErHFSTwpDE5B9nK0XKnbeq61Ei22pxP73Jke0=;
 b=J1C6y5qm7W51y2PyM2r9OKLw6VQT7fD5+IHbMlk8armp+g7Z4Tf5dUVsPJ900bRckkh/Hf/Cuf5t1nVyy1hLcWPdL6MpRQ/ymsHgY7yfOY6/9mizk6+0odsiAe/GP2Wp5OjFhmvI2rZ62tF/V1XWqsJMRLE/NXSS1fPhwz8RpxyUyKk9FA+F3tDvOds+zcHbhrtyrPkeTJZDiQI5Rn/0gCrrla/f48logy9rZq/Ssufwnc99ZGSNS1mIs1g8jGEyeZO7kugZ/d/oGMCyzDNVgv7DE+0ybaH+NBLSF3kXu6HHooYPKSUIyFSreVN0u70UaCD+UMIioClX0KMSsZn2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeiss.com; dmarc=pass action=none header.from=zeiss.com;
 dkim=pass header.d=zeiss.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeiss.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giqYI/ErHFSTwpDE5B9nK0XKnbeq61Ei22pxP73Jke0=;
 b=DF3tNrwPvC4qnFox0py7c4hDrKEeIt5WLHNgbrKN2s9JYIFvzMvrCiTs+G2M3xAJHh4Js65d8YFXHOCIOVdIGOHW/ckou9zcS4AfuiwNo2Xm97cPynsQULRRdk1j/5pWjZYLBEV9cC1+dFvAtI0gd/cKzHVA/+fgFNa80JVx8DV4mSXiL16KkelGJUZvWnL+FCH4UZjSD/xYM4xUxKR8FGWSdOJLgQDwA0BpZ46W1+4kakzffAbs5u/9tDDLpyKIGGCbMU8HyuXN7WFmV6rcpSTwuIpFEwCmeTdwaT0oclO+wJfsIiFs1JuRRAcvbaLw03cgN75ngkXAs/OsjEwCbw==
Received: from AS1P190MB1822.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::7)
 by DB9P190MB1308.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 19:13:56 +0000
Received: from AS1P190MB1822.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb70:f989:726d:2055]) by AS1P190MB1822.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb70:f989:726d:2055%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 19:13:56 +0000
From: "Suesens, Sebastian" <sebastian.suesens@zeiss.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How to fix Linux CMA on x86 with internal graphic card i915/hda_intel
 ioremap error?
Thread-Topic: How to fix Linux CMA on x86 with internal graphic card
 i915/hda_intel ioremap error?
Thread-Index: Adp+5q/aWlQfCb3dSge1UZV0wTTL7A==
Date: Mon, 25 Mar 2024 19:13:56 +0000
Message-ID:
 <AS1P190MB1822ACF28CD2BA09A006D7BEF1362@AS1P190MB1822.EURP190.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	AS1P190MB1822:EE_|DB9P190MB1308:EE_|DB1PEPF000509F4:EE_|AS8P190MB1271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 g92xAK1LaVXJWVggim+9IW6dWxuf2lb8LxIu52mBbqnBpJl1k8bevi1HgFJW8EWNkbG5kWM75Bn+DSCfLoG6uU7OmesvjCQaPmJKgj5ueyZzKRd0E8FTUBI+bk7Hkotkt4Fy3y+Tyd+m8lWJTHdRXwe/7vgooLEk4iNOkS5og1CNybCFFCFHPfIACCGFAJyzXMi9gnXGDpy2in0iabGwU5lvxUlveQYogafiYlJTCbp/OB6oIfZ+Zwom1/MYDdjuID4VSoWUwHhiO2+Fj7O2tuHioF9Et6EFNivB4nEJycxhGhMKXwqHCt0aIbEDEE+DFHZcNb7PvzEcKvg0Ng6iV6PMzwRevfVijTA5fHo6gNi7Dkglm1TneatPR9MfKnvcAK1LdbWiLHiFUFSK0jALNO32blT0XP61OHfBIhew6i7XecM9ZEDfq5aj0Mav+9DteIAGDPhjOndk0jDwuMlsu3lWtCizY8wpObTcC22jOvhXy9Jbm0A/N2BM1cBm5vGgAt4t3C4RnJOvdBUj5MhBVSYqZqnPWgqG8OIhIVODfXbCRhHKxH5ZAfSVVAGw2ds3bE+DNW1RjxhyxD31NPVPQNy/w+TRDd5o7VWbreWOGsYUqS0MfvEs5EIYCI1ROSN/162ZyU0HFjyXA9kseIluNKPiIB2Eb6VYnaqg8dJOU/M=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1P190MB1822.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1308
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[18.192.202.217];domain=jegw1.zeiss.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[18.192.202.217];domain=jegw1.zeiss.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a7d368-e3b9-461b-fefe-08dc4cffb8f3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n2Byf1sivQX2qq9deWsRgFKftIH9BeE6TLbqJzo2kUovbhWUXs0UWUNew9WdgH4tp21Q5VoCrJFk49j8kZCPWEmYhz6iQ+teYS4f5etRdVp8MrNb9e3alofgJCkryEHU5t3vk+uMcjWPn0OJ/X3EYQeRUgar+icM3gF6yv+BPqN/RbigvVOwlhWy1UiWwFK2zTqSORRPgydz77jGrplzIE5/sZKSnxSQfwtDx0c4tbceyN51GpAgwdyiFY2e4S7YaL0nvdngki8ZvbwyK5hf9uFLkpQwzbusL3sM0be5ZY4FncjbQPLAPlcPzvpvGxpvEABq1GOG6Fr2FAvBNloQVJRDBA7nI+pdlrgYZwpI3zhc9hLtfbhzwVaMprB+ZN6NcmGDBKTEdG4M8Q3TPVFqls/8kH2OL8yesSgQpEGTEXXdCN4mYnCzMCBy66l9E3Rrg5JTE9nVgp1N/L3mwjIfCyRujkRLBWUiypwHu6lGGL9l49q/LQRv8WW8APhzNdnKbxAVIEHfUP4ZBnkuIzltYano1Spmf2FtaLw//sNmRZ8+KkiXGH0//+DZZb3utI7qPPswDx2cBV1jFu/cZXnnZBQuRqFCIWyqXckI89pgQ3fLCwhVFh6OFlqTEm+1dP8QDpDhwkDka3xrL8R8BeGAsFHPo2cqjl8JUQjU0fIwBPLN42yNdXGGY7PnlNHO/Dcn6FCA0oD5Zqu3riA1J4Gyl6iRsWmvBj28OgSU+jJ/js6EkrN3oOIv1kmr8pVwmKy5VVMkq7eSsjS5hIjs0hwlIVD8MUMvDwTecJQ27BwgriQUPvVfpOVF6n8JjiRQaTcKAL5RWHW68Gw8sayvyIoqmA==
X-Forefront-Antispam-Report:
	CIP:18.192.202.217;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jegw1.zeiss.com;PTR:ec2-18-192-202-217.eu-central-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: zeiss.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 19:13:58.2199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a7d368-e3b9-461b-fefe-08dc4cffb8f3
X-MS-Exchange-CrossTenant-Id: 28042244-bb51-4cd6-8034-7776fa3703e8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28042244-bb51-4cd6-8034-7776fa3703e8;Ip=[18.192.202.217];Helo=[jegw1.zeiss.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1271

Hello,
I enabled the CMA (CONFIG_CMA=3Dy) for an x86 machine on Linux kernel v5.10=
 and v5.15 When I boot the system the CMA reserved memory, but when the gr=
aphic card driver i915 or hda_intel is loaded the system crashed.=20
I see that ioremap on RAM at 0x0000000000000000 - 0x00000000d0000000 get fa=
il. When I blacklist the i915 and hda_intel module the system boots fine wi=
th cma memory reserved.

I think this has something to do with the shared memory which this driver u=
se.

Does anyone know if a kernel config or something else prevents this crash?

Please answer me in CC.

Regards Sebastian

