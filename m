Return-Path: <linux-kernel+bounces-123830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B16890E96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759E81F24324
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D424137C29;
	Thu, 28 Mar 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="KatDiuXK"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11020003.outbound.protection.outlook.com [52.101.229.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9238FA1;
	Thu, 28 Mar 2024 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669125; cv=fail; b=UHcV847Bsrpvae8p3PBFyvz5tZ5WafPID7c1yNYlG3vTRbl2vLegQwf7X54lp+MiWYmsGguHXckTmX3ltLM2+OrYB62uCDwWpDjaymMbsXL1kCbMobHh7rc7HFTeNTXE/u3KiNuI9MAyqmDWncE7/PKxD9lQ6JevF+RJwElvTpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669125; c=relaxed/simple;
	bh=ecosBrlN7dNeoPPibmTdZn884affcUgWCF2aFgxPPW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ICV3fn3fh5EXBbzWtc1BzyQEfS1qrRLWwth0u3dw9kerL/8UWRKNgDB5KCivoYjbek2mmkD4vUtokavJ68qYAsofe00JDWw/j5TaOWA9G97NjOYaD+yiHcojGmV+8WS3GfNfiizK7aaAkTAg8odPETVXgtvWsW5i3xYflkbDRkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=KatDiuXK; arc=fail smtp.client-ip=52.101.229.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDPaOXmKlKpLA3HsWOeIvk49dAjEf7IMSRlkMTaIBORtdN8UepQQ6XvNuaISfakDa3dGqrDs5+8V3CcKETf1qg6rIeWuD1qWUYUX5A9UjTRFwVEQlqxCQ65NZC4bzmU42MKiI+5YzY0s/p+jCK3XXEO30goNIOrZNAiFGxi4HyY7Mqe8m7QCgjuQGNA5sMQ+XYnv0PFzZK2z/8eA6XH+M3Kju0GPNBkLFBk7fDPIx5Ccd3CjvFn36az9y8HhhtCYT2q97sReDeD5JN8mtIe9Gqpsk3xFztEpIK9fNEbV8c1YCy6xEikkNjoXk89khOBATa9gau7YBiPURMANbsgPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ94iaN0ow7vQ+UztB1LuKe70e+0ZrDMkvhS+11krq4=;
 b=D9leNROErwWre/mXXcZPiDXCjF8UOSaj08n2KDpUMEmz78qUEyH26MjzgDRkqKoy/nd4Fd0LulnhvIMBOGEcpA1kziUxOERS6WUyRxaCvc+9g046KFYyEypTkA0zGC/rQM6B05OYp7YmkjSf8NDeYeGn9WU/tKXJluGvXdWH3gpeDxYvg1eUdHM77yuZYXgHsO6QTxk/XkdzMFbyPEQZ1MA9i1hiCdneJAu498/y1x0qUJy0CK0888lTdr4ArUvmsLpuRl+ixBdeR1oGvPCkeDfu1+ceG7SFRPpeOdk6YvIgEQPf4WwHWEjOhd+R5Qpvryq1yeutoflQ6SZ1tv7xUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ94iaN0ow7vQ+UztB1LuKe70e+0ZrDMkvhS+11krq4=;
 b=KatDiuXK+RL0pINfFyotkyVbQts2/hSmJnh3Nu7KVcL/R8J7u9pORHCiEKi5tzPXnVxmnAyXdpRFYZFzPkFO18AvqiYffLlAOT4HKnjzcg/lVaaBGi0+IfePIoXYKkveHB1jui1dJ0asT1rRicl4GS5H+ssmQ+R9afwfy1eibu3lK8XXbTLkQYTlswOSkKEiM3TUfFaLm7iP5pUf4YiC5jJnf2vGzuuewo0hKYx5Qhz/WsQBJUPYIpTpGcNi3k4RAnVjw0yteIFB6e6Z/8sPEejYRtYdh2GXsFBk1n4ni34tpLIntE9M6bQEuWlv3k64SmpSZOZ3tCWRgU9N1+zSGw==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by OS0PR01MB5761.jpnprd01.prod.outlook.com
 (2603:1096:604:b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Thu, 28 Mar
 2024 23:38:37 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 23:38:37 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Alan Stern <stern@rowland.harvard.edu>, Matthew Dharm
	<mdharm-usb@one-eyed-alien.net>
CC: Greg KH <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "usb-storage@lists.one-eyed-alien.net"
	<usb-storage@lists.one-eyed-alien.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Topic: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Index: AQHagSuLspWlvFs4ZkGDPqS33FWwALFNzt0g
Date: Thu, 28 Mar 2024 23:38:37 +0000
Message-ID:
 <TYVPR01MB107818669DF1EB88BA7D9D2A7903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <a446cdf4-3a9b-43d8-b22b-78c20cce2b4f@rowland.harvard.edu>
 <TYVPR01MB10781AA8B37E147E318597B46903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <0c99daaf-c727-467f-b8c1-ba8846d8a9ab@rowland.harvard.edu>
 <CAA6KcBBcpug-rOytgnbb=c4O54m-Pfy=divqp12qOMrgmQrz7w@mail.gmail.com>
 <2483fb37-8939-4723-ae8d-7a7a7dba3322@rowland.harvard.edu>
In-Reply-To: <2483fb37-8939-4723-ae8d-7a7a7dba3322@rowland.harvard.edu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10781:EE_|OS0PR01MB5761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /Oxog5YQ7dwy+Q0YFJ9S1GKIK52fVM2U1ZsJF9pVBaF9O4QS3AlbTDW8XuPxCzBcipGsniNuoW2Rar89n31yWjwjwEQorCENoubqU2JwglSE6mtgCiLfgEHSZy3mOxYGXekyV77SDHdkoOVXb1AnEC2BD5Z0XR4npKwaGbBXNt6453N/9rlvKpP2TG9AnC7/U7m4atKmM5vBlQe+obMfUFjfp7VH/YV3vbbIdwvjYxMGYFJ+WS9xpVPNWr7oMAJOciQC7bLlUsb794cPbqcKk8DG6XWsuT9j2L7IPeHIo4ja0jnlcrUbpOOU+209PRWvN/PaddVJWov1apxOhO/+Du0hp3ikGl2jjsv1JEKOAkyqXs+eR/oc+kZ6BkbbvWlFKDI8/1wpYlkHeHUF8qYoG5CUc7P3xrYidACiTWWHFnLykmwjxR2EmLWfxRdvHRyMuUcewCvRRhViPz5mSv2T+qslPDMhaBgsLJAFMeGHnZVgbFLG2ahWeu8J5QacBwUPkSSxifb6KCD+5EWFXZcfra6tGN4h54WDyIFYpU5DDumQtcXhp7WCGSNQ8Kx2XE3EK9lXabfZ1vC8dzbxS8G3Nc+MDnofqIj+lgN7N7R6ar3ifECN1OODrFMj4vDE2nrSIjKB9mO7Bk9vvqP4tRE9AR3L5PmQYjUlFHQzCA+eKtE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?bVIwa2tvd01zcG04OTZoNVBHSFcxZmRHQlFtYUhORGliYUM4NkJMS25waWNK?=
 =?utf-7?B?ZTNIdW1OQWxZYXZIMUVDZHR0ZElhNG9iQUhvM1ZtOVlzVzV2bjl6NTJvQ3pE?=
 =?utf-7?B?VmFINXAxRzlvZ0daWS9heGpCOG1SaUtoODJNWEtzdDFlanl1SDhmcU5JbDQz?=
 =?utf-7?B?OFBrWDI1UXpkL3h3UUhSRkV3VVVqWG83enozbWZRMjhLQXU3bmZ5d090VEh0?=
 =?utf-7?B?TzNRYmtPYTBMaGZlY1Q2MFpZWmFGU2pMZ2lQbnE5UnBSUENiT3JIQzRtTVVX?=
 =?utf-7?B?a2tKdDd1azQ3bDBQWU5obkR4ZC9sckpZbFdIejNGblZzUTQwem9LMTZaNVAz?=
 =?utf-7?B?UklzMDJzMUVWNHN0MGN3bzRJeFNvUWFURHg5SGhwUlIrLWYzNUpwTTUvZTVM?=
 =?utf-7?B?WkRoVGtXU1VkOHo1dGd1Z2YxbGNFWVprbzVjNDBTaHlOTjljdTVxVE52M3Vt?=
 =?utf-7?B?NWFyYnJIbUhYSVhKd056ajNoRjZhY2M4S29nMk1BUCstTkZQZW5kcUxWMHJP?=
 =?utf-7?B?dzFIMnl0UWxaUEI4YzhCTDRsR2VQbTJlM2ZRVlJGZFNWRm9CZXpNUkk1RHM1?=
 =?utf-7?B?d3NJYXZwNkRaUm03azV0QXRXMUxNcDVUeGpSWDg0Y1ZmU0YrLS85RmJ4V1Ex?=
 =?utf-7?B?WFB2VDVlalI1S3p3U2dhZ1FGSEJPdnN4Vlh5S1ZjaU1BM3B3aWFreEVXMkJa?=
 =?utf-7?B?SDIzM3pkcld4M0NMVnkzTEtwM0thbFkxZjQyMmh5cm40ZVB3N1RvdmU1bmRQ?=
 =?utf-7?B?Z09QN2d5MkRKbXdPWExBR2VLaThFSi9DMTJnbGxSMW9JSjZpY2FyeEtkbjNz?=
 =?utf-7?B?WnhqblE1ZmdPdVBUYy9EdzA1TjRCZlQvTDFtMUhhQ29KRE1IMC9md2FxaTdS?=
 =?utf-7?B?Ky1haGhtY00zL3hXQ05kMFEvMXZGc2FiVFdjM1FxSThSdjFiNExlYzYzM1RJ?=
 =?utf-7?B?MzVqWktMNDZoVVRnSUdKYWlZU0xLY1cyWExoMGhVRVhtRWZ3bk5TMGRGTUdh?=
 =?utf-7?B?QmR5ZFBRYUZrNGROTnZNVFJsWUR5UUZjVUdYKy1INHNDZ3hWVUJ1OXg2R0pR?=
 =?utf-7?B?cXFoKy1CT1E0S3UrLUtBNE94aDgrLXZET04zVzdtN2M3cFJJOFpMcnkyNllW?=
 =?utf-7?B?bDByTUQxNlBnZ2ZFVUJpZU9hYWFPeDhLNTc2V243RzZkWWNrVzl4T2FtRHRt?=
 =?utf-7?B?R2F0MnllUUtvaG9xcnhmb2hwdElTRmdQeXZNNUIySUs0bnFWSHdDeWx5L0Ey?=
 =?utf-7?B?YystR01aY09YL0RoTU1xUCsteGNPSWdURHJhUS9mbDEzSENFOHhhbDNmR2NY?=
 =?utf-7?B?YTZWaHFPcTNwTTArLUJDWXNlVHJTZUhMS2traW93ZHI2dWd3dVBjdlk3Ymdz?=
 =?utf-7?B?b01YUjM4V3oweG1zNm4wTmRHTVlVM1NuMjZoWTRtMHR4NlZVT0dBSWZmcm9i?=
 =?utf-7?B?clNkKy1MMnIvT3A3b1VBWTdHRVBDQjM0amsvNDJFcDd0M0NMZnp2UnN5ZFFk?=
 =?utf-7?B?Sm9HV3lWWWIwcDk5ODZLb25YTm5COERrUWFYanJxc2hiY0o4dWtiTDE4aTZN?=
 =?utf-7?B?d2ttYkwySzcvNWZCUGZTcmljZ0JkMDJtSW0wQTluU2NFUHVmSmJaNVc2Ukg2?=
 =?utf-7?B?RlJvOEJWVmZ5WUpOVi9lOFVGTmo3YVJ1ZHV4WnUrLXRKVVRab3lOMll6TlJz?=
 =?utf-7?B?ZnR4RDdXbW5iNnhJMkw1RFNNenZLOUpESTE1U3FHMnIrLVpSem9QRHdvTkJ1?=
 =?utf-7?B?ZlZiT1RsU1kxaDU0M1gvRkRscE9Jc3RnWmNoc0hta0s2NlYzMGpiUmw1czZq?=
 =?utf-7?B?YndLbld6WW05UUFZRUhHRjJKVFpINXdVRThKWXcrLWIrLU84VXN6aVdYbzY3?=
 =?utf-7?B?SFp3VkJuSktUVUkrLTR4enFFNUxuTEcxKy1aUGpZWWN2NlIrLXI1b3BDNDNp?=
 =?utf-7?B?akdRQ2FFYS96NVJ6MXBaMHVIcUxLTGtZNlVYTXMvWkhrVXF2Ky00UWY4Zkk4?=
 =?utf-7?B?dW42R1dESWFkTG0rLURJMGI2ZzN1NjhEbzBva1BNajJNWGJiNkx1NDZLNS9y?=
 =?utf-7?B?ZlV1cW5hRk10ZHBQRlFIODU5UHBFM044NDg4VlQvSlRubkNRNHhLL25yRnRr?=
 =?utf-7?B?WDFkNEFBMnk4WURnbk9FT3ZpT1ZzamJjcmh3S3B6RWk2RFVFWjI5YThKeWp6?=
 =?utf-7?B?cA==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c3fa4e-a693-4679-cb2a-08dc4f803122
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 23:38:37.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tF5w5cGrUl3/973/hizyfxPEdkUs1KO7ytUxFhVjzu+JzwiZlwj/RJX/HJrfSx2edEBNbr5phbdzKUHcah7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5761

+AD4- +AD4- +AD4- Here's an approach that Greg might accept.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Since we already have a delay+AF8-use module parameter, w=
e could add a=20
+AD4- +AD4- +AD4- delay+AF8-use+AF8-ms parameter.  The two module parameter=
s would display the=20
+AD4- +AD4- +AD4- same value, but delay+AF8-use+AF8-ms would be in millisec=
onds instead of in=20
+AD4- +AD4- +AD4- seconds.  (This is similar to what we did for the autosus=
pend and=20
+AD4- +AD4- +AD4- autosuspend+AF8-delay+AF8-ms sysfs attributes.)
+AD4- +AD4-=20
+AD4- +AD4- What about just changing the parser on the currently delay+AF8-=
use=20
+AD4- +AD4- parameter to accept an optional suffix?  If it's just digits, i=
t is in=20
+AD4- +AD4- seconds.  If it ends in +ACI-ms+ACI-, then interpret it as mill=
iseconds.  This=20
+AD4- +AD4- would be backwards compatible with existing uses, give you the=
=20
+AD4- +AD4- flexibility you want, avoid adding another modules parameter, a=
nd=20
+AD4- +AD4- potentially be expandable in the future (if, for some reason, s=
omeone=20
+AD4- +AD4- wanted microseconds or kiloseconds).
+AD4-
+AD4- A little unconventional, I think (at least, I don't know offhand of a=
ny other module parameters or sysfs attributes that work this way), but it =
would work.
+AD4-
+AD4- Noriko, would you like to write a patch to do this?

Thank you for your advice.
I understand and will try to do that.

Best regards,
Norihiko Hama

