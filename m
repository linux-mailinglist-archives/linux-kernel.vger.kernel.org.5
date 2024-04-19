Return-Path: <linux-kernel+bounces-151077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C18AA8C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E159A1C210DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB03D961;
	Fri, 19 Apr 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="CbVDsNfP"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2040.outbound.protection.outlook.com [40.107.113.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50E9473;
	Fri, 19 Apr 2024 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510015; cv=fail; b=WIBgnbzXZI6rGAUIjCrQ/M54zfuvtBtasve/PrUZ2IXT0lpN2Qog4R6inY+pSL5qbRZ6hZNB+pmMRz5elgzlajqhxgHBWmXiPQqqQZPYmfDoUXQrIt6MW+1DpcB1g/eD4F99X/eROeOami28ER0EZsIejYs/D2qY+nMQ2Yhshxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510015; c=relaxed/simple;
	bh=B6n2h8/FmRN26YxZL0Rlc1PUX5rvIS93f3V87DcJvoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QR9v4kNhGeZT+HAZbuYgK2Nwt0VtWRt3oLtA7jcOXD5bupvJd0828Fv5l9t+LkNF13OpaX6UY5H0d9iC44wNGQcWk3I8FJHqZg7vhxy2RYnnzKcmI1yoYam9GRAGUPtICdWejvmbKn7O9M+Fwy0gnUvn0taTp7LMgO3SBNc3YVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=CbVDsNfP; arc=fail smtp.client-ip=40.107.113.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE9H+yJM+BoPxgwv/4e4bA0IiXlQ4kqpn0pACC0krCC2RphPsaWYM3FFmbuyxA8SNyI28w+qla78IY4DxiGQYKDjCLFTN/d568cqU6qJ1+i4ax4LHhiXQxwCYqk/L+imJwsvkTD0RMtEfqFeOF+u7ul/mQT57FStLQ0oHpaordvn7FwmvXv1a/sA4Z/81vtIjJFRMveezcMvEHdSj5obRm6/UsJ9tqoXyee06PPgK3Dly+Nye1lfBAVpuZfohyDAE3mBoOFNyiiAilI9Z8e57wVtxVOJ3dUV87WtEaKqe9P9kYkexfqXnq7JDwx7xHmkpQ5ncH7CnRbsmLnRky2s3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s9wvGmoVt1IQXfVpwtquY3/1bt3RZPJNzVXoh0DTL0=;
 b=cUnqpBMeYrhUHHQQjkCYjFOdfBuzZXuONoYjHCF/6+MeaxUcNNSl5N1FBqiRq9uU8WD464sqKNHOXKbAQwrFyjUToO45d7MoNwGi8my3WHxljFvfIIrt9zXUrBkfsEoDvWCMc5fqvYJd+z9kEsz6+SBRZJ0YNZIfp9KZ6h9DX5an5ZSwA4rMow0ti7RL3aI5HDvSYvE64i1JBiBSgoNF9bKKhP44tHpqj7ye48TwcBiCdHA8yDLFzNdS94czRC9QLDMP06OE9c5BDdDPipNGpfEXM4o4QxMuC4j1GRBRdJnZwBHYKpAOhHyJcHDoHpJDu0uO8brS+Y8qP1ilYjGHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s9wvGmoVt1IQXfVpwtquY3/1bt3RZPJNzVXoh0DTL0=;
 b=CbVDsNfPOJRPXiFGHV8y1w9f7ujUfL48Tvk8DK+gJsGXg4sd5SmvF2jKBRrc5gSPozIuY93lVzalDc079sxFzl7TJHFgpA9CqwW+IW6ld1qDmuNDMpZRx80Aw/DB554IP22MjY99X9ApCn7JjuSCY7EZlxCU2cikYef9l12gk5AW/ZqkW17vdeWxKZcsJLOePkt67MrOiHxfJRnPKqKqPsUisXLqIjV2yqxaw3o78yWT0Bo7+spxESTyF/2HuYlphIPSLcVx+2BFqKkn5gVGSVhOV4exrjK1eCVAoiUBpK+LOwzaoZJjgZHLf1X0mwUVnbrCCU/tjkPZJVSltIbkyQ==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by OSRPR01MB11567.jpnprd01.prod.outlook.com
 (2603:1096:604:22d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 07:00:04 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 07:00:04 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: "mdharm-usb@one-eyed-alien.net" <mdharm-usb@one-eyed-alien.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"usb-storage@lists.one-eyed-alien.net" <usb-storage@lists.one-eyed-alien.net>
Subject: RE: [PATCH v3] usb-storage: Optimize scan delay more precisely
Thread-Topic: [PATCH v3] usb-storage: Optimize scan delay more precisely
Thread-Index: AQHaj9cp7zT/I59KNkaCms5RMPC7hLFrrGQAgAN+dVA=
Date: Fri, 19 Apr 2024 07:00:04 +0000
Message-ID:
 <TYVPR01MB10781F18C77919205761743BA900D2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
References: <20240416082821.10164-1-Norihiko.Hama@alpsalpine.com>
 <4d94b2a8-dd2a-4bae-9a0c-8125747f404a@rowland.harvard.edu>
In-Reply-To: <4d94b2a8-dd2a-4bae-9a0c-8125747f404a@rowland.harvard.edu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10781:EE_|OSRPR01MB11567:EE_
x-ms-office365-filtering-correlation-id: c2aaf53e-36b6-41de-7a55-08dc603e571a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-7?B?UW9rc2lGZnRLRkRRQ3ZDdEN1N2RYRmpRT0VnOU5KRDlHZGIrLTB2YTBkSnBm?=
 =?utf-7?B?UzUxYnRvTTBYOGw0ektDNXVjY0RrVHdSNG9XcjNmVkM5MkpPTnZyZlAvbVNI?=
 =?utf-7?B?aHhraUFqL0d0NVNQUzRvV0tqOHZ4M0ZpYmtIQXRITTdhMzZQaExTNm1uSENX?=
 =?utf-7?B?U1cvSSstMENzM1JuTW5aZUtRNkdZR3prMVNOSkRPZHAvV0grLVZZWlJIWTJp?=
 =?utf-7?B?YkxtZkc5VkZUNmw1VURrRUt4VUR3SDRuSEQ1Y2JjdUM1ak9BTVYrLUhLRGFI?=
 =?utf-7?B?dGtRSWNMWWc4cDZRaVRZUmRxblM0dklkazJSR1VTNlE3WklsOHdFUi8xT0R0?=
 =?utf-7?B?a3NtYnlLSllsVXZ5SE1zbE9weHhnVnAwL3ArLUNtaUkvcENBdFBpaGVjTUhZ?=
 =?utf-7?B?SVJaQy9ZOFpHaGRqL1lRTGxiT3JXNE5udERKZUQ0OXJuREtWT0tNeFM1dHJH?=
 =?utf-7?B?blJ5VmdVRjRjaFBvRmRNZSstTlBrRVpXdjhyYi9WbHNFTnJKQVBvV2RFV1hi?=
 =?utf-7?B?R2puQkMxd3RFdE9EOHJZSGpNQmovZWgzdVpCN0labno0MDQ1TG1RSzJGRlY5?=
 =?utf-7?B?bVR5SFc2UEhoWmpqM3lBL2V1UlVhLzdmbHR2SkRzSnQyNmo1OFFlRk5mWW9X?=
 =?utf-7?B?SkZRVmRkYUpqUnYwTlJhSm52OURIczQ4VUN0YjY2TDgwVlRRRWNDZERsNWNJ?=
 =?utf-7?B?anJJeTZiak0vWkdRMXd0SUlQTkxjRnFMWVVUWVYwUlBCS1dSWWt2c2tBYzFu?=
 =?utf-7?B?dC83UDdRNkpOSjFhSk8vOHJ5N2VtWWRNTDllNTEvVTJVaGNxTW1QOWFKQjNU?=
 =?utf-7?B?c0lFNWJ5dkgzYW5lSDFGNlBwamJNNXFkWFN1SEhnSVdIWmpzSk93YzRudndr?=
 =?utf-7?B?czIzS0txTHI1VFFiVystbEhWZm14MlJQL3EvdHRVVGRwTUdXRWF4SGw5L0Zi?=
 =?utf-7?B?NXBEOUdLcmhIZ04zNndOcnpzOUdQVmc4U0dNTUw4Sm81bThrVG43UEpqKy1C?=
 =?utf-7?B?ZjFDaXd6MFFaeVE2NUlxczJvKy1rUFh4OXRtZE5Kd3R4OXd4REozUWFIQ3Qv?=
 =?utf-7?B?ei9OUlNQSmpKR2hTeXVLemwxYnhNY2hESmdJc25pbno1Yjh1aUoxVkJIdEJQ?=
 =?utf-7?B?Nlo2TmFZRXV4VlJlRzJyMmE2cGtid2VkcTJPUHhIZndIN1ZDQmVRY0J5V1VH?=
 =?utf-7?B?WHBXZEd4RGdta01WZWY0VWpsalkwR3B1WjRoZUxNZTdkNzI3TDZZelFmWml1?=
 =?utf-7?B?OXhLUzZOb1VhQUtVMTBhbmVBWlFQcEkvVFFBZWNQSFBVcFB0R2xIYTVjZjVX?=
 =?utf-7?B?dkN1VDVWbzBNak0rLUk4NVJyVEhRN1MxdWNqMHhpcystaVZ6QS9sd3BqQWNj?=
 =?utf-7?B?YmFxTGpGbnlXZlhYbDdMZGlDcFVhcmYwaGo3b2hYcHVTQUVvKy0rLVo5UmJm?=
 =?utf-7?B?ZHUzQlhhcThxMnZuOWJJNjV6YXFHVjhiZTJHOHZCKy1IcnpUL2J0VW0xanZS?=
 =?utf-7?B?YjBNbDA0SUxBbmFIV29tbDN6eWNjTWE2MUJDeTFzNm14akFSaEpubmxBVVE=?=
 =?utf-7?B?Ky1Fa09ZMEdjSktmOUxuRFlTSGxlKy1kU3lreHBWWXFvYy9GUC9ZRVlvZmZW?=
 =?utf-7?B?MWlFOEozcVlCaWp3blA4MS9ZU3UzcVZ0dExtZ1c5eUpKQ0hJdEhNdXl2alk=?=
 =?utf-7?B?Ky04Nk05Ri9kc2UzUG03bW5NUGR5UUljd2ZUQzNCaTN5Nm5iVUl6bVk5aE1S?=
 =?utf-7?B?UXdYOTNFN3F5NWpsUENWTTM5SjhkNWhNcUc0M3JJVU1HMTc5ejkybzV3ZFVn?=
 =?utf-7?B?WWpIZ2h3VFY5Z1hTYVR2d2VPeHM2elpmZHVPc3grLXE4WHNBK0FEMEFQUS0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?VFNJa0Q5V0tRNTlWaERVc3JQb2puWXJ4cDg0RGNBZFdJMFhCZU5Ha09MeSst?=
 =?utf-7?B?NWJKeDdoYlFFMjAwT1VxZHJyYzBaU3NDVWNTLzIvUEViU0F2cm9NWXd6NTUz?=
 =?utf-7?B?cXVTaXlyaTFTd0dNYXZXSnE4bHZFLzN2d3pkMElOMCstbmtpNTB4bnptZzJG?=
 =?utf-7?B?Q1ZzV2hzR2l6Q0Y1cjU3bHFlTWdMZEkrLUZDZ1BYeVR4dVQ5WTdZRnFXVkU4?=
 =?utf-7?B?SktMQWZVQkVDeTJJeEUrLUVoVU1IcjQzSHp2Vy9NcGUrLUNPY0w1RjRFRkh4?=
 =?utf-7?B?OVFyU2J1V1EzbjJ1QVoweXJPMmp1WVV1UGkzQ1c1Vm5QZDdaTncwT3luNFRs?=
 =?utf-7?B?ZXo5UEw2eWNBbnlKYndvMnI0dWljM0FmaUZRZ1lhQ3U0NkQ5NGhlY0xJZFJB?=
 =?utf-7?B?NDhseUlXS3BpZEZKMUI0VnFmRm5CRldqNGxtTk5hWnhNdFBScU1ud0VZVGZn?=
 =?utf-7?B?ajJYNUJ5aXNWVVNmSGorLVpDYzNQMWhNMEhaQnBDV29OckR1eXhva2ViNE12?=
 =?utf-7?B?NUkyYlpzM3NNekZnRGNaMXFQdTlNNDVFVzdvUFZmdUpZQUlVbko1RDFVWUNt?=
 =?utf-7?B?SFpVUmswNHdwOUhha21udjNmd3JpNWpvWFJZY05LSGdkemJiUkxmQlZVcFlO?=
 =?utf-7?B?ckljNUNDS3BDam5SaVFTc0NuT2lidVlxNmRIY2ZiSVdLNVBYbVVLTFEzSDJu?=
 =?utf-7?B?c0UzVDM2Sk1ZOUplNXdaSHJWa2ZGc0orLWdSTGtlNUhYRHAvYnNKMGlVdTJj?=
 =?utf-7?B?V0gyYnpSTDNRbkhyYVJrd3B1VHhjblo4L2N0QnYxM0l6TG9oMEd2ODYweExF?=
 =?utf-7?B?cDhKcTE3c3hRd1NpbystbllLT3djRjJCQTJ1eEs4VXplMUc4SG43Q3VxeUlD?=
 =?utf-7?B?dnFKQ1BuQ0wrLVhyUkR3QUk5TXI4RXZ4bzZnTEV2SG5QcE90dzBENVpmdDdN?=
 =?utf-7?B?Mm9sRVJYc0VFby90OU5zVUtQei9UYUFUUHd5a0VUZ0lTaXRMeDdhN1BmbjBT?=
 =?utf-7?B?VmZTd2lIT1JZUS9Bc2xLdmhmb2w0T2doTGNLaXlLaVVyVTZiVFVkMy9YKy1n?=
 =?utf-7?B?Z2syUkZXdk1taUI2RUpod1ZvcWt0cWtYaTR4R0VCVEgvZkJMcE5Lemp2TkZt?=
 =?utf-7?B?Uk1LR1pUTE40cXVBUHF2SmNQWDRYdnkzalRLQXVZV0FRb0JvWCstTmF1RFpk?=
 =?utf-7?B?WmV3L1NVakJwS1l4dlJJZVU4dExJUGl2bnhyVTRSNzBocUxyUUlkNHZxTFht?=
 =?utf-7?B?WWpTUzBFY216OVVTZU1zN1pVYVJCaTQ2bzBFRVN2emNjWCstZUNWNXlrdXc2?=
 =?utf-7?B?UDIyOU5DZ1VoR0QxOFNTSlBDZmFBbEg5U3ZOYUwyQmVqd2dlWENtcystbVA5?=
 =?utf-7?B?WTd6ckl5WmVIdmhyWGFZS00wZDIwNUpyYWx6MkJwUGhQeWtIQzFTMm9jZ3pT?=
 =?utf-7?B?dFZaV0UrLThLblJxbEdpL2tNMDN2L2w2RGVta3ptM0xDb0pMTndSMGJrR1Nk?=
 =?utf-7?B?SGpQV1lidzZEUzd2NmhPM1JralVPZkMxNTVtMHZScVlFWCstNVhmdkhGRmVF?=
 =?utf-7?B?Sm13aDRlSnlFeDdId281NjlEc3lIR2wvV2EyejBjbFJDbDduNWsvZjlGVWRm?=
 =?utf-7?B?WjZRZSstT25pWk5raFlwYkwxS0FlSUN0RXJ6WW9Oa3dHMGt2R2ZQU09FanhU?=
 =?utf-7?B?MlVkdDEyKy1BNVVsTjNSSFdYMWlUcWxLbWdZTklFZ1hUQzRuRm10dDZaaFVp?=
 =?utf-7?B?ekNNaVp3dE9QS01jSXF3d1lmRE9keXBvdU01YnErLXAzajRzWm1NQ3pTV0xm?=
 =?utf-7?B?a0pxV016T3hZT25RMUg3eWdYcDJESk1ZcllGMjJwS2dpZlpFUWd5aFhZQUQ3?=
 =?utf-7?B?a1AzWUZXcHVJUTlrZUtocUFFSmxPT3N4bFo0Vm40WUh5akdCRHVVM3dvVWpH?=
 =?utf-7?B?QkFtN1E2Q0ZQMGRpMTAybnpiRHFiTzYxemhwV1RITHVLS1Y4eGtJdUFNUEho?=
 =?utf-7?B?bC9YSjJ3YnppY2EwT3dmRVBiLzYzZVluSDJKKy1OTDFMWWVZRVdvWHpIU3lo?=
 =?utf-7?B?anY0YzFqYUc5V005Ky0vaUFzSW52YmcyNGhYTE1sS044dGNEQlBBU3JjT2ds?=
 =?utf-7?B?OUZtWENUN0tjcVhJd05ud1dPenFYam9iUFRhY3hSVVlteDZ3QWY4VG9YdFVO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2aaf53e-36b6-41de-7a55-08dc603e571a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 07:00:04.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGkxW+TgZ4TVI44T6uBiKxzBZPDpYOpdq2COd24tRpiFDR5Qn0lCxQqGDHrB231b4c3upZvy/q00/3eMxjctDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11567

+AD4APg- On Tue, Apr 16, 2024 at 05:28:21PM +-0900, Norihiko Hama wrote:
+AD4- At this location you're supposed to describe how this version of the =
patch differs from the previous version.

Thank you for your support.
The difference from previous version is parsing parameter by kstrtouint() o=
nly with padding to 3 digit '0' based on your advice.
I'll split parser function and simplify get() function on next version.

+AD4APg- --- a/Documentation/admin-guide/kernel-parameters.txt
+AD4APg- +-+-+- b/Documentation/admin-guide/kernel-parameters.txt
+AD4APg- +AEAAQA- -6190,6 +-6190,16 +AEAAQA-
+AD4APg-  	usb-storage.delay+AF8-use+AD0-
+AD4APg-  			+AFs-UMS+AF0- The delay in seconds before a new device is
+AD4APg-  			scanned for Logical Units (default 1).
+AD4APg- +-			To specify more precise delay, supports 3 decimal point.
+AD4APg- +-			The range of decimal point is in milliseconds,
+AD4APg- +-			hence the minimum value is +ACI-0.001+ACI-.
+AD4-=20
+AD4- The text could be better.  For example:
+AD4-=20
+AD4-			The delay can have up to 3 decimal places, giving a
+AD4-			resolution of one millisecond.

Thank you for your adevice.

+AD4APg- +-			Example:
+AD4APg- +-				delay+AF8-use+AD0-1
+AD4APg- +-					1 second delay
+AD4APg- +-				delay+AF8-use+AD0-0.1
+AD4APg- +-					0.1 second delay
+AD4APg- +-				delay+AF8-use+AD0-2.55
+AD4APg- +-					2.55 second elay
+AD4-=20
+AD4- This should show all 3 decimal places:
+AD4-=20
+AD4-				delay+AF8-use+AD0-2.567
+AD4-					2.567 second delay

I see.

+AD4- As I said before, the parsing code should be in a separate function t=
o make reviewing the code easier.  It also should be written more clearly. =
 Here's my attempt (not tested at all).  You might prefer to remove some of=
 the comments+ADs- I put in a lot of them.
+AD4-=20
+AD4- /+ACoAKg-
+AD4-  +ACo- str+AF8-to+AF8-fixed+AF8-point+AF8-uint - parse an unsigned fi=
xed-point decimal integer
+AD4-  +ACo- +AEA-str: String to parse.
+AD4-  +ACo- +AEA-ndecimals: Number of decimal places in the fixed-point va=
lue.
+AD4-  +ACo- +AEA-val: Where to store the parsed value.
+AD4-  +ACo-
+AD4-  +ACo- Parse an unsigned fixed-point decimal value in +AEA-str, conta=
ining at
+AD4-  +ACo- most ndecimal digits to the right of the decimal point.
+AD4-  +ACo- Stores the parsed value in +AEA-val, scaled by 10+AF4-(+AEA-nd=
ecimal).
+AD4-  +ACo-
+AD4-  +ACo- As with kstrtouint(), the string must be NUL-terminated and ma=
y
+AD4-  +ACo- include a single newline before the terminating NUL.  The firs=
t
+AD4-  +ACo- character may be a plus sign but not a minus sign.  The decima=
l
+AD4-  +ACo- point and fractional digits are optional.
+AD4-  +ACo-
+AD4-  +ACo- Returns 0 on success, a negative error code otherwise.
+AD4-  +ACo-/
+AD4- static int str+AF8-to+AF8-fixed+AF8-point+AF8-uint(const char +ACo-st=
r, int ndecimals,
+AD4-		unsigned int +ACo-val)
+AD4- +AHs-
+AD4-	int n, n1, n2+ADs-
+AD4-	const char +ACo-p+ADs-
+AD4-	char +ACo-q+ADs-
+AD4-	char buf+AFs-16+AF0AOw-
+AD4-
+AD4-	n +AD0- strlen(str)+ADs-
+AD4-	if (n +AD4- 0 +ACYAJg- str+AFs-n - 1+AF0- +AD0APQ- '+AFw-n')+ADs-
+AD4-		--n+ADs-
+AD4-
+AD4-	p +AD0- strchr(str, '.')+ADs-
+AD4-	if (p) +AHs-
+AD4-		n1 +AD0- p+-+- - str+ADs-		/+ACo- Length of integral part +ACo-/
+AD4-		n2 +AD0- n - (n1 +- 1)+ADs-	/+ACo- Length of fractional part +ACo-/
+AD4-		if (n2 +AD4- ndecimals)
+AD4-			return -EINVAL+ADs-
+AD4-	+AH0- else +AHs-
+AD4-		n1 +AD0- n+ADs-			/+ACo- Length of integral part +ACo-/
+AD4-		n2 +AD0- 0+ADs-			/+ACo- No fractional part +ACo-/
+AD4-	+AH0-
+AD4-	if (n1 +- n2 +AD0APQ- 0 +AHwAfA- n1 +- ndecimals +AD4- sizeof(buf) - =
1)
+AD4-		return -EINVAL+ADs-		/+ACo- No digits present or too long +ACo-/
+AD4-
+AD4-	memcpy(buf, str, n1)+ADs-		/+ACo- Integer part +ACo-/
+AD4-	memcpy(buf +- n1, p, n2)+ADs-	/+ACo- Fractional part +ACo-/
+AD4-	for (q +AD0- buf +- n1 +- n2+ADs- n2 +ADw- ndecimals+ADs- +-+-n2)
+AD4-		+ACo-q+-+- +AD0- '0'+ADs-		/+ACo- Remaining fractional digits +ACo-/
+AD4-	+ACo-q +AD0- 0+ADs-
+AD4-
+AD4-	return kstrtouint(buf, 10, val)+ADs-
+AD4- +AH0-

Thank you for your help.
I'll reconsider the code changes and test it.

+AD4APg- +-
+AD4APg- +-static int delay+AF8-use+AF8-get(char +ACo-s, const struct kerne=
l+AF8-param +ACo-kp) +AHs-
+AD4APg- +-	unsigned int delay+AF8-ms +AD0- +ACo-((unsigned int +ACo-)kp-+A=
D4-arg)+ADs-
+AD4APg- +-	unsigned int rem +AD0- do+AF8-div(delay+AF8-ms, MSEC+AF8-PER+AF=
8-SEC)+ADs-
+AD4APg- +-	int len+ADs-
+AD4APg- +-	char buf+AFs-16+AF0AOw-
+AD4APg- +-
+AD4APg- +-	len +AD0- scnprintf(buf, sizeof(buf), +ACIAJQ-d+ACI-, delay+AF8=
-ms)+ADs-
+AD4APg- +-	if (rem) +AHs-
+AD4APg- +-		len +-+AD0- scnprintf(buf +- len, sizeof(buf) - len, +ACI-.+AC=
U-03d+ACI-, rem)+ADs-
+AD4APg- +-		while (buf+AFs-len - 1+AF0- +AD0APQ- '0') +AHs-
+AD4APg- +-			buf+AFs-len - 1+AF0- +AD0- '+AFw-0'+ADs-
+AD4APg- +-			if (--len +ADwAPQ- 1)
+AD4APg- +-				break+ADs-
+AD4APg- +-		+AH0-
+AD4APg- +-	+AH0-
+AD4-=20
+AD4- While this could also go in a separate function, it's short enough to=
 keep here.

OK, I see.


