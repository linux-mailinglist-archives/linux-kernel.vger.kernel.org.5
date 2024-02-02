Return-Path: <linux-kernel+bounces-49158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EAB8466A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F30AB26381
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7197E568;
	Fri,  2 Feb 2024 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="NdBqHVK7"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2046.outbound.protection.outlook.com [40.107.113.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC68DF5E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845908; cv=fail; b=D6/vE8IW9HmzBS6uIEuj1YQLdE6/jLhjEg3Y6Pug0BwqbYSqC7KceicZU0HdbrCmA2XQz6kT2JWC5PMBdu6goTFyLKGyP29awXcb2Nc94FQBGtHSZC+xGxFFS0RtByygiZKnrg2wnoy6QPVPWvrTriVuJ8hTcH45Ep+swFTrBJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845908; c=relaxed/simple;
	bh=rNZcMsa9yRvdOqjIjKL/KeyxlwFu/PIj3bzlY0fYAi0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tKvG4XOxdRx1TsD6kFcY69ph7fSQ7P3HsxCV4N0MIeLNECamIKBLJeYXgaIURLckGAU631+K9LY94w/NEYkltO8+9fyRbRyJAtimSvDkMbj8IlLtKy7mTF+Qz29UIXEJH29dF/uhYJWho/rWy124U4oABaE3iPo50w6HXx33VCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=NdBqHVK7; arc=fail smtp.client-ip=40.107.113.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HozRGI3KIhx6p3tC4fq8HNGqKQII7fHuFZ7B3opjci5RLsT++QlqoBc6H6BCxIhvXpr4LQwgljQGp9GsASf0bnfHT/JXRilI/YpXsMHBAbNvqQQquB0WHHQUS5sgOAkFc5cd6nksEMiLgXWSS7qFkXEM0rbJxy3lYRPzWQ5C8orMef5zN+Otu0ozF6G6H/Ti8R+ip9wj96or4cUqq4yxAjjPTB7tC+07tebGWFJKM77dT6OU3UjtcD+zGH0kDlAntva6sG/1BtghfMIPgP8ZBiD2MLzLIWiSX99nhnnqUdpQhIBNYXo2qL0JiL/SfjCHlVO+f34Mp/asxuSU+MgHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LCNOaXIkA/4uTRpN0/FbM3LP4tZxsvhPRsUPLCGi10=;
 b=VpDPyr+2lVEVY7hRY6b0864ygScin9ECExvbCOHD8S8XhvplCx+hlzzTM+a1m9VJao2AqxIV0q1YrSarOoqNhaumBPZ5i5tOUeQSAqfoP6abEsFlEvdumTg7CZ81ovBTpuNK5he5Mz40bXrKBbMV5GLe4mNGJoRQD5Z6eNgkdjctfOf6crbq8GGuekeE75cQoH2LDGdZ90OA2YbO8XisWm5Yv9eyURzuhmh12Kvjd4Z8SmGqTOgOieACedtMxZzpkdFjv32hFaWhkSf/BoXPqStiXiSIMdRsqg/EC2aBI4bYokNTMdW8X3UesFse77QA52bEPBR+qwIIRoMAzWvTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LCNOaXIkA/4uTRpN0/FbM3LP4tZxsvhPRsUPLCGi10=;
 b=NdBqHVK7lKORCDOPf9K88BBxAmca61TsmSn9ZwEMoqi/fMidZNavB+cScj5tinVKF9M+Zgo3HlmjxVHDUdYy7/Exv6E687i1pfRtlZUaB1yCqGW/ag2Kce+MTvnIsVIHoiG4xaKrjujM6KZssB2TQFtDPjb18K4I1oBvNGup/oPssFCbcFzv4uxWPFIfzx76xvKSgwfWl8a+9c1cWGRJvplHQKoxmt/RZLpJB7xqv0AU9FFtD3G+d6XKFmEEyX5ZTaTks3q/u6xOgdSXEqv4eTSh9WYV2eKu/xHN4EcDutZ0fiym1xvfmnWlIhfnyaaRhA/HWCkRUurIKKOUJCa3Ig==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by OS7PR01MB11820.jpnprd01.prod.outlook.com (2603:1096:604:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 03:51:43 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 03:51:43 +0000
From: =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
	<junichi.nomura@nec.com>
To: "x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"david@redhat.com" <david@redhat.com>, "debarbos@redhat.com"
	<debarbos@redhat.com>, "dzickus@redhat.com" <dzickus@redhat.com>,
	"jlelli@redhat.com" <jlelli@redhat.com>,
	=?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
	<junichi.nomura@nec.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "lgoncalv@redhat.com"
	<lgoncalv@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nikunj@amd.com" <nikunj@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
Subject: [PATCH 1/2] x86/boot: Add error_putdec() helper
Thread-Topic: [PATCH 1/2] x86/boot: Add error_putdec() helper
Thread-Index: AQHaVYsi/1oB6HDI3k25PP/X1Nkmaw==
Date: Fri, 2 Feb 2024 03:51:43 +0000
Message-ID: <20240202035052.17963-1-junichi.nomura@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|OS7PR01MB11820:EE_
x-ms-office365-filtering-correlation-id: 68e7c3c3-ba9b-479e-3459-08dc23a24561
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dRhIv+Ae21gWJtePCtXfWs9DfzbCy32M5hYnAO84hMfBgrNF3g4jycWPWSSb9Fk4a2Z8P3kbnjM7coYkB3UAvzWf1CJEMRVX9w+PzewzDJcSYX7DDfRkBZHyB91UxozhTRrAf8sEQl66rs1PadC1KqLN3gmbpRsZLIRza7OEay6Hhm9Zo1Wk5NaTVD+mHmZT07I3U4AACl/QVZsZ6ngj0tb1b4O8EWjuC9dtyn805gtJz7z3zejcH66YWJRRTdsc22CsZLn1EKwITUCEM9wRCUJ2U9DXgqUVG0R3P3CUpaVBmUuraOxc+PCHTCid3ntm/xSLcOiSp6Q/0cmtruQ0fdDD+lsEUGPzk9bv90boMGkD/V48Uyde8UcF9aBOTxKskZ9IjOip4uYcOSLm/FOzPRQa2ybq5n/ViCRNXo8Mzhyw7waRBfnay30TxrpFu7uuYI3/ZRuatKhStVsxEToWDUkBbAQ3uzvJ9emWlPFGaSOyceytlEhSeYGq4IFZ+XC1FhrcJw+YZvtrrKgTdnZvXV/UruNgw76uAjZIX2M8QlWFV4LGPezGQi72iBoj9AKfafCsip3IDLx4NpXGPRO2oDd3vcfL5Vlmq2r/m+AfvIs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38070700009)(4326008)(66476007)(5660300002)(66946007)(316002)(966005)(478600001)(6486002)(76116006)(66446008)(7416002)(110136005)(54906003)(2616005)(8676002)(6506007)(64756008)(71200400001)(8936002)(66556008)(26005)(2906002)(6512007)(1076003)(122000001)(36756003)(38100700002)(41300700001)(82960400001)(85182001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NCtxOHZhUEJwMGI5YUNtLzQ4MHZ0Y3hOM2RtMVVQRjRzQU0vVWVUd2NK?=
 =?iso-2022-jp?B?aitudHNZcEFoN3h3M2JKS1BtMG5qTVl5Z1duVVVnTHc0UEcvWTdBd2lw?=
 =?iso-2022-jp?B?aHVKSW1uVS9IUkhyNy80SS9iMUtCRi9xTkd2U3U0eG9PbmNxZTVMKzZM?=
 =?iso-2022-jp?B?ZEhYNnllRzZGbDA2V1lOTHlFUmVvZ0hLekFBM056SGd0Sk9ndzh0RlNn?=
 =?iso-2022-jp?B?NWtTTnhaVDV0NFg5OTRqVnNPa0xyTXg2NzF2QWtsRU5zUkd5bEhTZy9D?=
 =?iso-2022-jp?B?aHo2QUZwOXYrUGFVM1hncXVEYjJPelhVTFRiQzhieklNR0VaMlN4TU5D?=
 =?iso-2022-jp?B?L2xpeVlZaW4xT3NvU01JbmYzdHExWDlXd2tQREJhVXJWbExWT0orVU9X?=
 =?iso-2022-jp?B?VGtCaGJzQURQS2U3c3BlTitjREFDdE50R3JSTXkxMStwdy9qR0V3ZjhO?=
 =?iso-2022-jp?B?Zml2dklkSlBTdEhpR1cxN1FzWXJXcDUrNjRQOFc0R3dsWGRxZ2lIR1FD?=
 =?iso-2022-jp?B?ZHh1U1ZiZEQrUFdzVUN3aGJrQnlPOCsvZmYyYXVIVCt2am1TbWM5c09y?=
 =?iso-2022-jp?B?QzU3bFN5MVJ0Z3BOTklscklOWU9hUlZQSFVFaERqY3dHS3d2MnVYUGFM?=
 =?iso-2022-jp?B?d0dySGxTUTJQdXcyRSs5N2hZT1RBcHlqQVZIWUR2S1FFZTJhZVVHZVBG?=
 =?iso-2022-jp?B?dnNGTUlUWE5ZS01HRHJOazFWckkydFhqbjN5UlBiK3hTWE9XUTZQWDN5?=
 =?iso-2022-jp?B?VVdOYmthU0xkYk9KRkVwNEVoRUkxVTY4ZGFVWmlQbVBUQVZmZjZ4byt2?=
 =?iso-2022-jp?B?TEZQUWlqRUIxYmJ4MEF6UDk1bGV0Z2N0UG1iRW9BelMxdWFsSVE4cGhQ?=
 =?iso-2022-jp?B?MU4rUVg0NUltSTVUUVV0cXVLVVRZK0dITlJwV1RYc1NKWlR3aDVRSXBs?=
 =?iso-2022-jp?B?Si9WV2ozaGdYZkhoL2N5Tmk0SDlUd21XcEdESEN0U0hNZzBSbmtmVDQ0?=
 =?iso-2022-jp?B?TTVBZ1R1cDk2dWlyK1ozYWQ5cDlwRHJ0QlgrSWJEMmRxbkp2YUkzTUVO?=
 =?iso-2022-jp?B?NmtSdmxqbnlDMFRjYnVXZ0tpUWxCN0gwWDdRVDg1TTZSWWRBNThYUkps?=
 =?iso-2022-jp?B?RU1XL3NvRFFNOVIwRHFSQVRNREU5K3NOMjdmcnl2MlVhNXZuK2xabE9Q?=
 =?iso-2022-jp?B?eUsrNklOU2hJdndiQURER21ObXBZMHY3aHpTR1grRjJ5QjBacy8xSFpV?=
 =?iso-2022-jp?B?SmVsbmxNY3lMd09vSnVYdis0TzJJRHYydEM0WHBRNUZUUjVpdzJsOTNR?=
 =?iso-2022-jp?B?SXdadm1PckVraE1RWTJ5OTJhUm9jTVZ3c0QzZEIwR21ETzhhZFIrL3U4?=
 =?iso-2022-jp?B?cmphZVlxUXNXR3hmME54SThOTTZEVTVwOFJiSys5RE9ram9yaG5QM3dm?=
 =?iso-2022-jp?B?WG9UdVJ6eVNJZmF2NnR1bmJGUkFmcTFJSVRKUzFsTjlJRDBhamF5azhJ?=
 =?iso-2022-jp?B?aE9UcnBQWlk4bkIvK2lVUVFEZDlGZDVUK3JVVHpwYlBCZmY2d0R4a1JG?=
 =?iso-2022-jp?B?c0VWbW95RmNTdDVSTlgzdDFtdVFnREx3RHIxaEZhZ3U2QStWeDNoVHp4?=
 =?iso-2022-jp?B?MnVQQWxtUVFBQzJLS3VWVTBrZ2dUcmJnOWVQYWNzWDB1WDZUZVZGaHpp?=
 =?iso-2022-jp?B?MzBQaGE2dUlBaGIvNWhodkp6L2V0cEZ3aURqVFJHS3FuOXp2dTR2c0Uz?=
 =?iso-2022-jp?B?TlZxR2JQV2VKSHB4NTB4dHVVRVRuTFR6MG5IRWlFNktSc3YxOEM5c0g5?=
 =?iso-2022-jp?B?bGxaWFBCZEdrT2J4MERVakZ0ejRCV1BkS2Nmb2JhTzNLaUVTTGJaSXdy?=
 =?iso-2022-jp?B?TmdNY0xTd0dNZnZvNGYwaDJzMERvaHdiN1Jha041Q0FWUk8zS3BSQXFT?=
 =?iso-2022-jp?B?WlVOc015emZ6RnBoRnZFTUZFeEFKTHVwZWlmbjhDbUNYZnRUSTIvNGo3?=
 =?iso-2022-jp?B?TVJDRHcwYUtic09XeDRQbWFiUURlOVFLRXozRXRnSmNkL1hWanBtMkE2?=
 =?iso-2022-jp?B?bUJ1QnU1c3EzcVI2KzA0TXdQTFJiTlVxaGxXUFVyMEtqeTQvVkh1amtP?=
 =?iso-2022-jp?B?cU95bWt5S2NtYWVvaUJCbDVpV0JhMWIwUUREQUlaNm1pamt4ZXc0RkFr?=
 =?iso-2022-jp?B?V3VpdUNBallOdWlIS01PbUxhelFOYUZFVHhvdTlDODJUQm9FSWlKdnRW?=
 =?iso-2022-jp?B?Wm96M0VjbEZMMzhldmsycFhndnBuK1M0N2dTbGtBZmMvc1JQQmkxSUUz?=
 =?iso-2022-jp?B?T2RuRTdCYkduY2NWb1dvNWVWNlVLYkZhd3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e7c3c3-ba9b-479e-3459-08dc23a24561
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 03:51:43.5114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUU6wAc7HyJcYUuQVP0va92EZ0xIZX+67rabb8yIWCSS5H0GObFbW2+HoO+q+AYoYgk4pDJwyBr9T2fhc+3+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11820

From: "H. Peter Anvin" <hpa@zytor.com>

Add a helper to print decimal numbers to early console.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Link: https://lore.kernel.org/lkml/20240123112624.GBZa-iYP1l9SSYtr-V@fat_cr=
ate.local/

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -164,21 +164,34 @@ void __putstr(const char *s)
 	outb(0xff & (pos >> 1), vidport+1);
 }
=20
-void __puthex(unsigned long value)
+static noinline void __putnum(unsigned long value, unsigned int base,
+			      int mindig)
 {
-	char alpha[2] =3D "0";
-	int bits;
+	char buf[8*sizeof(value)+1];
+	char *p;
=20
-	for (bits =3D sizeof(value) * 8 - 4; bits >=3D 0; bits -=3D 4) {
-		unsigned long digit =3D (value >> bits) & 0xf;
+	p =3D buf + sizeof(buf);
+	*--p =3D '\0';
=20
-		if (digit < 0xA)
-			alpha[0] =3D '0' + digit;
-		else
-			alpha[0] =3D 'a' + (digit - 0xA);
+	while (mindig-- > 0 || value) {
+		unsigned char digit =3D value % base;
+		digit +=3D (digit >=3D 10) ? ('a'-10) : '0';
+		*--p =3D digit;
=20
-		__putstr(alpha);
+		value /=3D base;
 	}
+
+	__putstr(p);
+}
+
+void __puthex(unsigned long value)
+{
+	__putnum(value, 16, sizeof(value)*2);
+}
+
+void __putdec(unsigned long value)
+{
+	__putnum(value, 10, 1);
 }
=20
 #ifdef CONFIG_X86_NEED_RELOCS
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/mis=
c.h
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -63,8 +63,10 @@ void *malloc(int size);
 void free(void *where);
 void __putstr(const char *s);
 void __puthex(unsigned long value);
+void __putdec(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
 #define error_puthex(__x)  __puthex(__x)
+#define error_putdec(__x)  __putdec(__x)
=20
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 =

