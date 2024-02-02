Return-Path: <linux-kernel+bounces-49159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B418466A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675DEB26971
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14521F503;
	Fri,  2 Feb 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="m/4VTl8S"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2042.outbound.protection.outlook.com [40.107.113.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CCF4FA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845925; cv=fail; b=dLhzeZ1L42kekqObbDsqQeo3fKeGRDpPwI7WHwd+yGx8qFyIXZaCK1V2z88m/wLdCh7pOCtYcsgAE1lpCeburECWIoe4ExXRN4n0HRRZ65mKlbBN06RL+RyvOcyEOLq6kbbssQyl03dD6mk0UkYdslFqZFX/GbL/vrqNlfsowG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845925; c=relaxed/simple;
	bh=mh8hlDsU7a5vSSmuUuUMn0lnX6RYT/N3ldMf5+vyTBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dx/mQPxMRS+CRTCHgCjlT7C0C+pUQ/MsTnNq+EciNrZSu2hgKUuqzY9+jCjk7mx7tyMtilTRsZQ9VNjEOSISIrq/rmz3lsPUJ1YjPP7H2CKkHfTXDbqxJwPfYetrc+4O/eEsMP1hWqzjUAeSF5d3WUxTLk3KodtXNyp7a3VxSIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=m/4VTl8S; arc=fail smtp.client-ip=40.107.113.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wep8RHRdXmfH4wddrjp4HgCqHroodrdnlve9axiQK1oZCHhUSLWa4URBxcZuYwn5NkxId+FTZJF/QBLjoo+eEITrVIQe+3MdYQN5VFEMcy4JEVHNCSdrNixQQrH/SE9eAuCkgM13iSzpMvfgGYte7L5zC5X4iwgyEBFE0OUebNF3tR7WT8tIc7cuxZOYt5maq0DYHD2v/ZDmDJO5+Ca8gjK2BcPnwNrtnFstwKY/75xblJkjf1tpR5aY6/ooL7fqOb6uCbj0gOVa9UoTURZd2MhuRkXwCSRDrFPdleKMT1EI3gUmcSXnHcPyWSLcRBsPRtmeRcUPRoFsWhR46AUF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L75p96dcJK8isJ9dYgE6R/ovATfdO96AeaCGaSb4f04=;
 b=NGUvfLcwvk7R9qxtDLs6n5wYe8rNe65kCD6lOwrfSCRCeJJsBRhlxcZCDtP3ev1q5ZHP+6uzbuB5M8aMStFQLkjAfk7m0Cq2Xd14z8Ni6kzkwbQfLN/30ijAEHGdgMjJspP5XSJEYyTaf8y7+2vhsT6bGOhT4fwjfRMvbsiiX/UPIUWrWHMbF+Ks1H6cBruaQgrtDVoWo86srma6f869o7epy2lXPVdTgmTXjD+qz+0uGIYV/wv2DAzTr5k+DJqa69kBwoIE1IHIoG4l1yzU58+RKCBjTimLgI0jPY/l8YtCdGO+j7z4q70zcObfk1mlkW3SnYt3x4kl8fatRy2c/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L75p96dcJK8isJ9dYgE6R/ovATfdO96AeaCGaSb4f04=;
 b=m/4VTl8SLxMaPA2GIoc/xAKDbDRmZ9bvIx7lUP6NQ6XKOuqo8AuOKYYgWFlsQn09DdlUARdw0mue3FTHYFtl54NswTBJ18WbCq9Ace0Mz2Zkuq89aRLNkSl/MENqYVtbzTg4qiS8zE8YPDcWW31qFhbrHqjjZC9WXblWfp+k9gwSDFXnywZ8mfCAQ58aSTFa4MH9D8AIUjodqp82g4c9b/1pW560NEwyv0dvL93iX3s83I0d4E51MvQKghgUUG/QUczgV184B59hdseMl07S9Cqj+S3TKdE5ePhHoC8BVoEgNNSjbm0fbQoqlCDodITfP8qpMe62V9FvFnWPmW1EuQ==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by OS7PR01MB11820.jpnprd01.prod.outlook.com (2603:1096:604:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 03:51:59 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 03:51:58 +0000
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
Subject: [PATCH 2/2] x86/boot: Add a message about ignored early NMIs
Thread-Topic: [PATCH 2/2] x86/boot: Add a message about ignored early NMIs
Thread-Index: AQHaVYsrpr7GWJLGak6aXYXtjEM3tQ==
Date: Fri, 2 Feb 2024 03:51:58 +0000
Message-ID: <20240202035052.17963-2-junichi.nomura@nec.com>
References: <20240202035052.17963-1-junichi.nomura@nec.com>
In-Reply-To: <20240202035052.17963-1-junichi.nomura@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|OS7PR01MB11820:EE_
x-ms-office365-filtering-correlation-id: 6e7ef16f-48bb-4fb9-a587-08dc23a24e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b5hnKD0f/pfqAWD9+PUjLAJ7XJfRhwyUPsknP7WaQC6aPfqUJa0Qv+wTbWXq3M5NENrH/RXlkkcTFe62RWWkEkB+IGvMXcU2ks2DMnUbJQGTfbuzujkluPe4z5zGUbjOkjHYWGEncwbisuieYO2cA1H488VRer1L89Z+qmbH24ZzXtI3K/340Q45yOWfVoQxnuruW83uU0gQPjZ/9Ad5sISVf4Sw7Lltv+cV71rGSCF4U6NUooSJqzXf/B4KfdFaxk4EiNw0NbHTYYGtozRs4wirVNUSMhfDAql909mxgDf+DRyc/LXN4NuIVFAFegRUsPtn9qi0ai4gTZzTYAG4jP1vGol+HS9mM3bjx19Sj9EquM/lI7ijBBQ4IwAs9w33mPtE5SDRqG52162YS+voZ87W8iXpzAkSnQodFTo2+XrQp1rwiXy/K3wgjU4n+QYQ/l70LwtiPDBCkP5h20TG7ecrlcltG6OzH4oGFQ+YQmmq/PHtzmgx/Cx2+6AscLvzAXYvf7+rA0F76KrxBG8HTEU6sfuUwEasqoM4XCsb01saSBmmnedH7bZ6eCPn5dscE7nWRGj7SvZZy5c3WEnWU6rNOA9IXQ8EkaLCttzskRc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38070700009)(4326008)(66476007)(5660300002)(66946007)(316002)(966005)(478600001)(15650500001)(6486002)(76116006)(66446008)(7416002)(110136005)(83380400001)(54906003)(2616005)(8676002)(6506007)(64756008)(71200400001)(8936002)(66556008)(26005)(2906002)(6512007)(1076003)(122000001)(36756003)(38100700002)(41300700001)(82960400001)(85182001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RlR2cHErN2JLaW41RHZOY3R3cGRzZzA4MWZuWndwNlgvS1R1bjdoUjMy?=
 =?iso-2022-jp?B?eW00ajZHY25UMXBMQ2xjRWpFTUVoQjJJcVk1VkxQVUE2QzB4eU1UN0U0?=
 =?iso-2022-jp?B?U3EzU3dzaFhRUGZNaGZGa0JhTXBuTVRCVFhIMXpVMFJRQlZQZHE2djRn?=
 =?iso-2022-jp?B?ZWF1MmJUOXpTVDl1TzVTZzFKdFdtTkJnUis5ZndOb0YwQWRXZk9NMFA5?=
 =?iso-2022-jp?B?Y1lvMDFFcEVKd2hyZVZrdVk4MnJDVE9PNnd2WE1nWnQ5cDhBbnFUTWto?=
 =?iso-2022-jp?B?VHQzdmxhU3dsWk0xcTRUV0gxSmxhUGx4SG52U2ZqdDZJeUNmMGlLN1lO?=
 =?iso-2022-jp?B?d0JoZkpBL3BnOFVSZGRtQ3hrY0dNdUY1UU9KcEZjRERVK3Ryd0FiTnN3?=
 =?iso-2022-jp?B?MWtJUlY0VnhOVWRyWTdlY0VKcVRWclAxNTJYZ1JQR0kvVDIvWFNQaGFr?=
 =?iso-2022-jp?B?YUFHSXN5OUJLbU1QY0kwWk5vZGxqeW5KdkZDdllZS09IdGZhZUFPVmdZ?=
 =?iso-2022-jp?B?anVmS1FLR3EyZFdMWTB1V3pVUVhxRDA1VlBYZjgrUWZadVc2SFZCL1dM?=
 =?iso-2022-jp?B?ZW1hM1RSUFVScG4vV1Mvd3JJL1dnaDg0L2RtQzkycERHKzhiR3NFcHpS?=
 =?iso-2022-jp?B?ZXg3dW1UVGtoWHRhekZJU0lvNE0yWFVzMDdZR3BhSHh5UllBV0ZRcDYr?=
 =?iso-2022-jp?B?YXFpTDNaY2d0d05YSG9mVEZueUxVczhIUnVOUjNIb0RNdHlmYVRrajhR?=
 =?iso-2022-jp?B?TDdCSngyZk1LU01qV2RMdEZRa1lZeEpVN1pIMjQ1WXFSc1psbTlibUhi?=
 =?iso-2022-jp?B?aDU3WVp1aVlnK2VuRVdrSHdlaW5aeFBtb0dFMUtKcnZYSnpKWlRJRUpv?=
 =?iso-2022-jp?B?Mjh1RnZ5dzFQNXVkMG9HVkZPaHY4Q1duL2pEaEs4Y3hOSVpiUWNlajdL?=
 =?iso-2022-jp?B?ZVd3K0ZOSWh3WDJxcURlUGpjOEY5aDA5N0J2SzhIOXNZK0F5MVhiY1dw?=
 =?iso-2022-jp?B?YlJMU2RncTRPdERYUFh4OThjMHNGOHVKeGYzOTZlV1A4SE80OUNIdTk2?=
 =?iso-2022-jp?B?V1ducVlPQVdsUTgzckV2REx6TkNvazdXcmJCRG5sdWNNWldzQkhnVHl0?=
 =?iso-2022-jp?B?WENBT2Nzd3VjTHJjQUg1Z1V1QWd5VU5QSndFVTlpNWpieGU3QU85RFNn?=
 =?iso-2022-jp?B?RnZoaVJyUUxxSStkV3pCOGozRTN2aUhOVG5uOVV5OVRsbTVSUWpPZFJp?=
 =?iso-2022-jp?B?MTJ0TWRtWmxKQW9XaU0vaTBjQkRvQVU1K083NWNWS3BTUkdYZVBac3g2?=
 =?iso-2022-jp?B?aXpONlp6VzZZQW1YejhINnJoZElCZG93RjBKbGJsdWhORURuY2tiT08w?=
 =?iso-2022-jp?B?cmVJNGRqNEZXWEVhT3FvempoNXRzR0o3RlN5VFh1K283cE5Sak82dDJG?=
 =?iso-2022-jp?B?eCtCWjFGRTVSdEtwNmVpd2tGUnhHWFZlc3daSmdRTlhydHVMZlZkS2FI?=
 =?iso-2022-jp?B?SHIwWFRLTzBiSkZCcHoyU3BmNTRkdnEyejlPMHlKTzhJNzhISDdlSUgr?=
 =?iso-2022-jp?B?YSthNktxd0cwcW9rZTJHYjhIRUczZ2dMT0k3RkYvaE9GZENGckhPYk1Y?=
 =?iso-2022-jp?B?S09LaEJLa2RQUklzNTFLM2s0am5WUmh0Yk1RVEEvTGNocU9kRTA2T1Yx?=
 =?iso-2022-jp?B?bUwvQ2ZOUVIya0dJcUo0OGJpY3FzS2xHa2luL05SMnloRU9YSGFGazND?=
 =?iso-2022-jp?B?ZFVydFI5b0NmMFhWWWNUNUN5R3ZwSHVnUWdpUVI3YW1naHNxVEl6Z2Ru?=
 =?iso-2022-jp?B?c1VWNnhGVGJ0WnhGaEdIRjlwaXJOSldOT204cUZkTnlvS3NXVG1lUlE2?=
 =?iso-2022-jp?B?V3Bxak56MjRtTDhhT2pGSDAxRHR4NTdKYWlidEtxSXJhWkdSVm0wMGUz?=
 =?iso-2022-jp?B?RUNKTFRkejJWSDdQdXMwTzlTd21pbnQvS2NFemlsdC8raWR4WFJrM1A2?=
 =?iso-2022-jp?B?YnhleEhvQmJvUXN1ZU8yT0JaMTNTWWtianVteWE0c25YaFp6MGNKZXNy?=
 =?iso-2022-jp?B?Ylg1a2wza3RDdnU4ejlNQ2xCcjdVTHlLM3g3akZiQzJkbG02cHU4WDFX?=
 =?iso-2022-jp?B?MXpzcmxiTkQzY21KanlTQzNjK2lzc3VJbHZnSnNtdWlscnQ5ZTY4azRa?=
 =?iso-2022-jp?B?YVptNjFKM1VMcXprbFBWZTlQalZaUnQ0Ym5IZGV1K2ZZQUpNSVZEYy9G?=
 =?iso-2022-jp?B?dktVdW5lK2MrZy9YN3hKcWQwYjR2VHJNUXkyZjgzR0tmK0k1MlFRZW5B?=
 =?iso-2022-jp?B?QWtraW9NNTg0SU5wTmN3OFV6ZUlYSTZZTlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7ef16f-48bb-4fb9-a587-08dc23a24e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 03:51:58.2669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLBMSTtYGYQheOBPecpCMHr7lvDT2Kpzjx7NTOReskv2pa12CydL9BJEg+wmuT3yxzsozvELndgRErno3acYCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11820

Commit

  78a509fba9c9 ("x86/boot: Ignore NMIs during very early boot")

added an empty handler in early boot stage to avoid boot failure due to
spurious NMIs.

Add a diagnostic message to show when early NMIs have occurred and/or
what happened to them.

  [ bp: Touchups. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/lkml/20231130103339.GCZWhlA196uRklTMNF@fat_cr=
ate.local

--
v2
  * Moved variable declaration and definition to the right place
    based on comments from Kirill.
    No functional changes.
v3
  * Removed comment and updated message in the NMI handler.
  * Use error_putdec() helper.

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compre=
ssed/ident_map_64.c
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -389,5 +389,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned =
long error_code)
=20
 void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
 {
-	/* Empty handler to ignore NMI during early boot */
+	spurious_nmi_count++;
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -52,6 +52,7 @@ struct port_io_ops pio_ops;
=20
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
+int spurious_nmi_count;
=20
 static char *vidmem;
 static int vidport;
@@ -493,6 +494,12 @@ asmlinkage __visible void *extract_kernel(void *rmode,=
 unsigned char *output)
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
=20
+	if (spurious_nmi_count) {
+		error_putstr("Spurious early NMIs ignored: ");
+		error_putdec(spurious_nmi_count);
+		error_putstr("\n");
+	}
+
 	return output + entry_offset;
 }
=20
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/mis=
c.h
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -59,6 +59,7 @@ extern char _head[], _end[];
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+extern int spurious_nmi_count;
 void *malloc(int size);
 void free(void *where);
 void __putstr(const char *s);=

