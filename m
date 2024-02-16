Return-Path: <linux-kernel+bounces-69448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F187858923
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3588C282750
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05B1487DE;
	Fri, 16 Feb 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="jaGS85hU"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2139.outbound.protection.outlook.com [40.107.13.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420E146904;
	Fri, 16 Feb 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123683; cv=fail; b=PBc1Yig+tdd4yczypqNpnqkS5TYbhlhb05Wz+3pOXQXSCRnVk27B0wiIgIDaI8IM/BPbIRh8GM7ajktiKBhoqNsMw6Dm1ge8eTKCmIahvCKhtG8LMj+s3MkNK2wIhlH0OttVgJAUpmZZaQOGFnIpwKi3VajcVcGQckOQmKuNBCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123683; c=relaxed/simple;
	bh=sQNmmOqiQ+gSaPNcqFZpoXHPHkDDxxndySbu7ZpRVEo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tJBctfyl6X8LZIHXc+e0j655HttnqWdx7c3fvqe+C+Fee0r/fizq/fGhqPgqds3u7Hqrrhx6RQfgXDsou7qA5R+HVp20ZbH4x7192LFIdHCP4mJTBBr2uQRWC67pzjdpwd7FTUqJsvJD1x3nhge5bFDlvVY1iJVpoQIibqcLy3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=jaGS85hU; arc=fail smtp.client-ip=40.107.13.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsNMKYXMeq4u989EDx5QHaCRx1LC8NhiODUUP5xAEVTo0otblf+6UkkXiPj7cdWGA6PlKPzDVnYWiFPO4qfs65yDuFIZnEPSEmkUL2knCIjeVlCPBhfv23WCl5+AHlWEYpkeJz1ftxy7tagwsUm+UbYwRrWaJ3iFYb4gaPuqXZtJqyxOTopgva5Ha/sZnnfK50dW2JZi3/aIF6NH9WIb2nYHeivHSaMtT2J35WkaRc3FrREA8ARrR0m9fPuhTDT65WV0Bj6IXcC5QBtJxqerP3Ki5YuAleuBbRAPSzGJF2KhMjsKd8+aKLzmJPUdGaxWCpSpnRaM28bDih9MY+L5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQNmmOqiQ+gSaPNcqFZpoXHPHkDDxxndySbu7ZpRVEo=;
 b=Lqhv6KbRm16mv4OkVgUEWEexmm8TwLagwDYQeJbmLEXe8t8t/bTu9UnOlzkGO+K7VY53ekXjTIZiWBhrdF2eiFG4y/OQ7+FV0EVaXkRKPOrhz4Aq049vpQkC2hYLptIbLrlhB7D7lwqU6NJH1crJvl/u2cw3zQSlbcNUkJYiY8FYscWU9Ckt3E54Jid72mN5Qv9nOClDh9oN6Lvv//ygqQsCtbE7c4akZMEzu81i0NfD250XGS+AeT5aGcoxbrMBzIIOLh7qTDJFEmD44v20C47qMr10x+eZd6q698mTyAleyz6228ZBJ30Ce1j/dkI4+64Q0o8m36G2SRnO3QC2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQNmmOqiQ+gSaPNcqFZpoXHPHkDDxxndySbu7ZpRVEo=;
 b=jaGS85hUaOu2FmvFVZ9GHlTuZ6Ok7aG3se73l8iCHrFfiPMrUIuvQJqkagZEMSvzWAlLPjTrMak4OBcoeURck3MSr09VHy5xwCZwJx+62x2JB1ApkWkVbz+HYcMdGXdV2bfeUx7zE2ctZJmHYPZvECJSQI61IEa0fnBpFJ7YWLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB1872.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:47:55 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 22:47:55 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	ilpo.jarvinen@linux.intel.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] serial: stm32: do not always set SER_RS485_RX_DURING_TX if RS485 is enabled
Date: Fri, 16 Feb 2024 23:47:07 +0100
Message-ID: <20240216224709.9928-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PAXP193MB1872:EE_
X-MS-Office365-Filtering-Correlation-Id: 693dd5d1-c3ea-41f3-550b-08dc2f41502e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w6ZMlVOi7srl3om4cqW+LtQ5EsdbDzSUanfaWfuxyQyByEVw0zYhgezWTaM36DAe4NkHGmRyJaBGL1/PZVLAzKk2FptA02/fJex3xjIZ65GuEOnE4EbK579OHjFSUIkzuwF0KB9mgYGUYbLRA+Jlei9VIpm+M+EcKjO1XCB3re3QY5BaS6ZAEWWpDJJc4Q96Kk/M4iDBexrsHDd6r5qBZ4c2rt9SljGOnHj4KN6knTBhC1gM6w6CR0w8/wCOpkyYOgSiLtINpkz8RWAZ+BMcbxmwv1oYPZ4+KcrwyHXRwtv+2cRoA4TeODFMnl3CX4gxKIQv6uH+0Cs5n3xiz1q3m2S+8BZ63XnlDOCrC3Oq0Qb1i8PtMUewr9eiVyuIoULDrx9OuyAGnM5MbQxScazUl/EJiYEUL8dUHKLmSyU8d/1ohUytOIlT1MODb6/xwsQ0IHBIEjpNwzZppmtcZuVzi96C4RIzbyk37MhCruoB5J7XGPmhkYIsbV647mTZfBo35K233SCh3zbWaLiB52ZFnRowudhf8JWummI5UolLBbzQQLODKzK/9fs0D/Etlznc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39840400004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(66946007)(8936002)(66556008)(4326008)(66476007)(8676002)(7416002)(5660300002)(1076003)(2616005)(41300700001)(83380400001)(36756003)(316002)(6666004)(478600001)(6506007)(6486002)(52116002)(86362001)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/QdQYcac3Cn9ncDCtyxZhPjVMsOQ0ipavKSRZlzLl53org6iGx9i/rDKOr3P?=
 =?us-ascii?Q?X5AWQhZK8h0gF0jmyvO5I/VQO05iyvSrriKMpRe7r5hM9XBv2H7t1/UuS+qK?=
 =?us-ascii?Q?ubmU0F9F6lAa6/mY2prJW6F8VhoiyjIkVHDgDry0LcbeDmMIz0Zjsi10N0yi?=
 =?us-ascii?Q?cCBFd9QaxfcyAwO+gtC6nCjcUesPWjaz6d/kwMWIM7o21PmW4AWVyrOJMyg4?=
 =?us-ascii?Q?EwKn7PpUUGOMz+YRxrztSu3aTuM5N6WKYdmkkAqEwAVZtkCOJlFsnSMxRAcr?=
 =?us-ascii?Q?KmzQSL51fQQ/lwKIvuI3RWdni5ccVvjuvkjJMZtQDwrjCVWoxzdqPcEVf0NI?=
 =?us-ascii?Q?XkaRtj8skj9SVWekmyJUanIkEHi06uO4ktIGhwzBR7w11woaXELKJ/0O8cr8?=
 =?us-ascii?Q?nIflNiwDb93cBLXgOpWZPZ/O/6GRmXxtBDjVgQe6DW51aqgQjDGqm+Qg4t7S?=
 =?us-ascii?Q?1piBWzkLnQKwlOf1YU81IV++NEB80sRw3cfw6H0tnbr+uleHjKpRMKNIHbt6?=
 =?us-ascii?Q?6OkZDe77815ctn3fcsf0j4LPqpT237yx2fbfB7pQ/Gg7z+0C/+oTONKJd6sE?=
 =?us-ascii?Q?245zH5qKbnWiTGNS8c6R+qdxmjCtJwb/vlwMQMD/phZIFkQrckblxzzu1nFZ?=
 =?us-ascii?Q?YBcn7L4h5b67Ngv2mHAKg3rvZN2Lm3/CHowJdunE2ezJIfWo3qM8IornFgEd?=
 =?us-ascii?Q?p8uSBQmkqBqKS+o/I3pJbwQNYv98QZsv2nnauYB6PP1ze8+PC8/xj0O3Pz1I?=
 =?us-ascii?Q?H/x3g2ng3zMcVOcNZDZTVOTproJ0d/ze3v2jylVHzqMH6uqTgDM5l/dTHuBG?=
 =?us-ascii?Q?SkZgrTY/7qoSF8L/NYFrfHZUVgzwdwHGcJXUVBHSXUXNAGBSaLnyYc633vMh?=
 =?us-ascii?Q?AK3aaAc6rVASLoSHwyztWfAQ2xt8LWE5W80Ma/OYIpnvYQXSm+Ibf9q6T50q?=
 =?us-ascii?Q?pAkiqcPongRrBb0k/VZp7Dp8BnXMvAV9g8FV7g2q0MsVbQNF8E7RSkT7gcRd?=
 =?us-ascii?Q?eUhpvxjDcrb5t7Y9HVyaPLsAMsh4ex4vDKDTB7jbuBqLwX58efgzqzAfr94n?=
 =?us-ascii?Q?gKCiWiS2UY5A9IOvwkeTyW82Ct60Bk7sgw9TEwuRXMvpXBmZV3IZxDuhKsmW?=
 =?us-ascii?Q?xQ2VgAN4Ia7F9j7ro1fTUFmILuTA1CjummCn+RHdfovbtcFt+Sk0hvwdQpdr?=
 =?us-ascii?Q?PytNkSUs/Uv8HkNw5fybFtCG9Heazl5x7MJuomSkZatz6obj4fNQHNRmPPMV?=
 =?us-ascii?Q?BiJdQqIelm68adswagrO+Z2PAfceQctdMIZ+7614zmxfnmEIRbBcnDqMGHKz?=
 =?us-ascii?Q?xfRo4M0fCt9e/vHRdzrfuLFMOVhVYIdXrOCEePkxPicY9M8IAnMRT2vMkZbB?=
 =?us-ascii?Q?HD6M2Gq2Do7Ek2hnL3RDsPRhHIyQ0gJCfSFs56iIuD1Ah+TUvX50HXKN2BIN?=
 =?us-ascii?Q?ru2ikOf6jnPTsJwPUMKhso+iZzAICL8Otyieqculeh/09HqV93fQ9r3eeA3n?=
 =?us-ascii?Q?loy1HPQJ6Wyd8B5yYH3cUemSd9Z+2OVIxaSQOTXPYvkhu/BwXGPMQPEEqq/t?=
 =?us-ascii?Q?FYmwCHVnvuYQz04+CHRGHBgfkDtv1CZyhwpvn4yGI6RxdhclPDNpDNuDWM88?=
 =?us-ascii?Q?BAbiQeVSyso77R3ZFmg6CJkUBxtd7kCSlfKGypdtZdv7bX90TOdv6krWdvj7?=
 =?us-ascii?Q?xymDHA=3D=3D?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693dd5d1-c3ea-41f3-550b-08dc2f41502e
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:47:54.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FP6qpxMKUZlu5+UYK56t8kJRDUoyGB1DwQfVlC8W6ewPuCspG+tHh5PvDmkxvOTSiFkeTmz7L8CBYF9TahzA7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1872

QmVmb3JlIGNvbW1pdCAwN2MzMGVhNTg2MWYgKCJzZXJpYWw6IERvIG5vdCBob2xkIHRoZSBwb3J0
IGxvY2sgd2hlbiBzZXR0aW5nCnJ4LWR1cmluZy10eCBHUElPIikgdGhlIFNFUl9SUzQ4NV9SWF9E
VVJJTkdfVFggZmxhZyB3YXMgb25seSBzZXQgaWYgdGhlCnJ4LWR1cmluZy10eCBtb2RlIHdhcyBu
b3QgY29udHJvbGxlZCBieSBhIEdQSU8uIE5vdyB0aGUgZmxhZyBpcyBzZXQKdW5jb25kaXRpb25h
bGx5IHdoZW4gUlM0ODUgaXMgZW5hYmxlZC4gVGhpcyByZXN1bHRzIGluIGFuIGluY29ycmVjdCBz
ZXR0aW5nCmlmIHRoZSByeC1kdXJpbmctdHggR1BJTyBpcyBub3QgYXNzZXJ0ZWQuCgpGaXggdGhp
cyBieSBzZXR0aW5nIHRoZSBmbGFnIG9ubHkgaWYgdGhlIHJ4LWR1cmluZy10eCBtb2RlIGlzIG5v
dApjb250cm9sbGVkIGJ5IGEgR1BJTyBhbmQgdGh1cyByZXN0b3JlIHRoZSBjb3JyZWN0IGJlaGF2
aW91ci4KCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA2LjYrCkZpeGVzOiAwN2MzMGVh
NTg2MWYgKCJzZXJpYWw6IERvIG5vdCBob2xkIHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4
LWR1cmluZy10eCBHUElPIikKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZp
bGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYyB8
IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIGIvZHJpdmVycy90
dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKaW5kZXggNzk0Yjc3NTEyNzQwLi42OTNlOTMyZDZmZWIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCisrKyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCkBAIC0yNTEsNyArMjUxLDkgQEAgc3RhdGljIGlu
dCBzdG0zMl91c2FydF9jb25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0
IGt0ZXJtaW9zICp0ZXIKIAkJd3JpdGVsX3JlbGF4ZWQoY3IzLCBwb3J0LT5tZW1iYXNlICsgb2Zz
LT5jcjMpOwogCQl3cml0ZWxfcmVsYXhlZChjcjEsIHBvcnQtPm1lbWJhc2UgKyBvZnMtPmNyMSk7
CiAKLQkJcnM0ODVjb25mLT5mbGFncyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOworCQlpZiAo
IXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvKQorCQkJcnM0ODVjb25mLT5mbGFncyB8PSBT
RVJfUlM0ODVfUlhfRFVSSU5HX1RYOworCiAJfSBlbHNlIHsKIAkJc3RtMzJfdXNhcnRfY2xyX2Jp
dHMocG9ydCwgb2ZzLT5jcjMsCiAJCQkJICAgICBVU0FSVF9DUjNfREVNIHwgVVNBUlRfQ1IzX0RF
UCk7CgpiYXNlLWNvbW1pdDogODQxYzM1MTY5MzIzY2Q4MzMyOTQ3OThlNThiOWJmNjNmYTRmYTFk
ZQotLSAKMi40My4wCgo=

