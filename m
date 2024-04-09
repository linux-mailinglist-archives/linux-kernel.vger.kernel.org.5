Return-Path: <linux-kernel+bounces-136109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02C89D018
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3251C23B69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B78B4EB46;
	Tue,  9 Apr 2024 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="CuXZvcDB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2105.outbound.protection.outlook.com [40.107.223.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB54F608;
	Tue,  9 Apr 2024 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627841; cv=fail; b=PVg9n4r4iZMHYp466kXhNO+/P0bcULz0DlmlvrzpAUJJpMUBfNS835p822CPxJ0CAWmlusS5ro5tPG0AwFuYm/edV0Fa5NWLuJGfLPoHqTCOo0OdsCFCkvCsRmT+gr/CEUiI+Ako7EjlPSr2riQ9CXAFHDLuXGrjM71jpE9s9G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627841; c=relaxed/simple;
	bh=rUxfKhfJZ0/orBHbQu7acOWmWqqT7UIqJSeb4VB5dlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sp7ze3Hu1fJbQ47Vb95C/H8Wj5nKzrLT+RQpZRYvNG0J3HKD/FbYqlN93TyBHK7Nz7We9gpjG7ywmmWe/xaH/UE4MH9y5MLPZqExIeBmyUKsfuOCFk1kfz5kxFTWkLYECKoWqWvmQwFYSl31T5CtjukbeFRGKW1NdlfxgLmz9T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=CuXZvcDB; arc=fail smtp.client-ip=40.107.223.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPj9o2w7viYXOvQYGV/a/n4Ycb58jiIhWd0ue/jIfhjBdfBB8qIP8+UgToUTqU95qTvlugc9nMIXHBu9qun/Tebl63zRrkh5mZLr68FDaOlJK+ATqC0J75VYaEbGoRhnFG2N2kSQ32Fqx6lXNKm4jbR4kLEJXtPLWn18KHh1h7PbXmN0wLL4YxmpVyPo2+QFWwGQr2TV/8589Rbmps+vYlm5NlID5NHYZFrBocGQlP6khIVTMEjH56mGdhdnAQ1WaaK1kyTe1helu5JuAhoT9jHvA8ff5dWG9qM46uXSfVfM9OVJ9NKLThlOloVHL3JZO5/pphIjxN3bL6ouCMjmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUxfKhfJZ0/orBHbQu7acOWmWqqT7UIqJSeb4VB5dlg=;
 b=Mw1MNwKLIbDlpNelTK36yhN8pxTOc3j/QW5/VPNrvDpcqqACCBjLDbQjAHarJnt0M3b6TIZJDdkTG7leWGWGuPn5dqHbv6DQMUOJRGcs+s5NhDAsyV/huRuctkwW0IsBEuDShJtAD/sD+hfx6vcHHNSlYF9BtnHH7sD7lcAfrSYbksttXZPk0THaAzn6ZoOzA+LTs8VB0BtJXnIpNsNsoE434RjLqYYlJjapKla8EEwH0QdvyrpLFyX42iZR15rwy+LdBV9HU3yq1dEfgFPHrjaXGFfzhzMo3Xk20sJY2Aa7Nc2putWFPNADDHZRm2A7OrWpsdev8ScdrcYk9rZVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUxfKhfJZ0/orBHbQu7acOWmWqqT7UIqJSeb4VB5dlg=;
 b=CuXZvcDBPuRWdOBbOqgRUmR//WRAiMkkO2zpuDB7dVumd89HLZq2Alx76L2vbqGKQGuSlznNJd0++OPLng6GChU02rXJt16WuDv2yEC1G1O45p81U0FjmTWHY2m6yMOIBIM7uscyda65ZjqqGtJt/O9FxzMSJsUtNZOCdc8qDo4=
Received: from DM4PR13MB5882.namprd13.prod.outlook.com (2603:10b6:8:4d::13) by
 SA3PR13MB6232.namprd13.prod.outlook.com (2603:10b6:806:300::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:56:57 +0000
Received: from DM4PR13MB5882.namprd13.prod.outlook.com
 ([fe80::5e89:b434:88dd:50a]) by DM4PR13MB5882.namprd13.prod.outlook.com
 ([fe80::5e89:b434:88dd:50a%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:56:57 +0000
From: Baowen Zheng <baowen.zheng@corigine.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Louis Peens
	<louis.peens@corigine.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yanguo Li
	<yanguo.li@nephogine.com>, oss-drivers <oss-drivers@corigine.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>
Subject: RE: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
Thread-Topic: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
Thread-Index: AQHaibYrsvBECEUwwku93UrztVy9A7FfLK/w
Date: Tue, 9 Apr 2024 01:56:57 +0000
Message-ID:
 <DM4PR13MB588247E7A37F98213BD0B9C4E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
References: <20240408130927.78594-1-ast@fiberby.net>
 <20240408130927.78594-2-ast@fiberby.net>
In-Reply-To: <20240408130927.78594-2-ast@fiberby.net>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR13MB5882:EE_|SA3PR13MB6232:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dOwSghxxmnWkWgngmlBq2tltb0pIqvpDWvJwzkLOZTLuutE1EQJmaD3Dmras6geDC00Yn6MjT0Xx7W6tjVzx8C9IKDcPbFmzMcajBO6ugQTIQlc6GIEi8bQpBwntniKXDz6t5beLJKUAA7w/xVhdzQeTF6MqHKiz6OBNPqy4nd5ycXyKzlj+DZ5m38B7XXRzpQ9YxQHYLZOTt4tQQNEL8j4cELvq/gMMXYayUGUOjquCAnfunrH/npbTKuIvwiSJvNbLUWuV1wyWAvFWWOJHGJR7x4htd5IBxbAs9ltmf+YnQeSJ25NTRd2dzVDkJQi1yi/Xen1r45PpCrka/25Lb9C5MKJKEgIE3G7KRvtE6vPWv9KXMP+7V2qsyhg66gKyy1Xc3wspPrH+t/0UisE3WcenpEs5e/y86U0r+qjkrgdKj9EBrJYLcCyYBfK7S+SEg4+2EZ+jxJx6KzHNMf7EYWA35hQLWNwqu7ZfWqHvLUPdamePZd3AP9qrpSsoKvca4Fld8Re9SgwZDWoheyeaC7iMZLzc1x96aLJoGtRF8qdI8QrlLN0t2UEb2ixOFVNLeNUazjs5RST15Wdc8M8nnAYYRRHZRsPD9MsfSFERABRwmK+4EVCdspiVletedeaTWK9vssk/WaTeo4q1YvsJ9UhzFsFno2vZ3RsbKF3nIUk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR13MB5882.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1hyNkJnM0V2cWU2elNvbTkrdlh0ZUFpUU8rbktsYTdxdFU1aURTTHRZN1NW?=
 =?utf-8?B?QkU4TzVGazRoMGRqbTIwdU94VjVrckpvTGVuZlVMNUJhcmNKKzEvSjRDbGw4?=
 =?utf-8?B?L2VWSmVudmZBNTFuQlBNYjUyMFlXamtPeGVORVUyL2s2Qnl6WklYQ0lmWEVx?=
 =?utf-8?B?RWhmUjhhVXV4b2hRTlltd3lVR3pGR1p3WkNtTG12WW9neS9pcnd4Z1Frczhn?=
 =?utf-8?B?SjNHdnNFMlAwYmhabUNMWUNGdm05NGtmQlI1aTRrWkw3S3dEYkhGOXNHOTFD?=
 =?utf-8?B?SmV3RkE1RzFXMFRlY0w2QzhmLzlrRUF4RTRianN0OGZRWlZFUThDTk1JVjlE?=
 =?utf-8?B?cFlrQzVRRW1PVWZiS2RuaXNhVFprSlJ3ZUQ5eFBoYU5ucDRRSWk5Z1M0NXls?=
 =?utf-8?B?L3ZKUEwvMk8zNnlIcnl2Q3E1M2E1Vm0veFc5cWh1a2l5Ui9kYk1xaTBKOUFC?=
 =?utf-8?B?NFR5MXYrZjZnTWdoYjdZTFUzRXI5OHdnMnBZN0NVb2E2MTBYUUNBMTNjTnZq?=
 =?utf-8?B?eStFT0FsYWZQYmhpd1RsK1ROV1l6ZzI2SFdjMi96cFgrMjYvNTdldnlrSHVX?=
 =?utf-8?B?bjY0bnl5L05SMDJkNDlQdGRlaERoUzVUaXlCUjJ0d29uVXRWdTJ1TUJINWJL?=
 =?utf-8?B?SlV3aXEvMzJBcVgxbm1qY1RtRHRmMVdkV241MXJRQXByd0R6bXNjRjFLMGdW?=
 =?utf-8?B?dHlnN2Q2NG0wUkFtNW5lRGJoV2UvT2VnNDB0NS9mcDRxS1I5NWtkcFQzMHZw?=
 =?utf-8?B?ZzlZT0gyNVo2OEFkSFh5ZlpQejlwdnBIVXJHVzNpcTdDb2ZvYkptQ1BWRUQz?=
 =?utf-8?B?QlpUYnFlOTFxRHRhMzhkRnl1MlJlYVpaaTJuUkZLd2gyTTF6NWQ5WitLK2FM?=
 =?utf-8?B?TjFEK1Rwak43L1FGTkV5TmZJeXdBZUFqdHRVNEExNkRPYUk1NEpYcVAyQkt1?=
 =?utf-8?B?YTdhMGNKd0hzNnhoYzFOVWpIV0hSTTFMOUFEcGpMdjV0NzZEUldVTGVpU2VT?=
 =?utf-8?B?dzhXM09PckFiZnpYRENQanhwWVkwK05lYWlFU2pmeitWS3dQZTJvbUllbHcw?=
 =?utf-8?B?Tjd0UmQwWE0rZXpldEdVNzdkZ3pTRElNVlVLRWkya0U1UnZmRk5veWVYYUFk?=
 =?utf-8?B?WWQvWmVHakQ0RXhsU1JYaXdud24xb2t4MlJpVFBuQkJFOG44em5LOWJIOUFC?=
 =?utf-8?B?Q1lzaUFQUStNZVBxc3JHWlQ0eXY0RnM3YjR1OUdKZUEvYTZxSkZpQm5SWUV0?=
 =?utf-8?B?OHZld1B5KzluVm1tZ1cxUEVOOXRqQmViMWMwaDVTbjlxaVZOTVNrcnIzaFNL?=
 =?utf-8?B?Ujg4VzFjc1o1OXozMFJPejA5YTJTd01RS1VjNEZYK1NqY2JLZTVYYmVqdXA0?=
 =?utf-8?B?c3dXRlJmRk5xdXNqMXdjV0hzNTk2ZnJyamlvZDNQdzhYTlNqNENFbGxPNVNT?=
 =?utf-8?B?TU5QNlVSMVNaNyswSlZScllOakZyM2x5eWNkb25SdDJlcjZLQWNRM1l6RlV0?=
 =?utf-8?B?cG0vTGZUMUZzSjBUa05NV2MwWHVYVkZBNCtIVkNubCszSUlxSHVGY3ZINHpZ?=
 =?utf-8?B?YzdFWldmOHRTU1d5OEYwRk54aE1uOE5ET0FXMis1NjZZek9nRzV6NUZacFRt?=
 =?utf-8?B?QnpUZko0OFg2TTFmbExHS3pJYlFvempRdzBRazN3SFRFQ283ZTFENDBaZkli?=
 =?utf-8?B?YlRNYmg5MDFPMkZ2eXRyRUNmS1plakxYZndkcitYZG1LWnQySWRaRzFRQTJD?=
 =?utf-8?B?cFloc21KUFM4OEo1Q1RYeUh0NFhSbUVadWszaU4yMlQwaU5PNytHS2lzZEdH?=
 =?utf-8?B?ekF4RU5hNkFyb0pmMm9QaFc4b2pPUnZMeEx4MXhvUDBCZUlRR3NNdGhDdlQ4?=
 =?utf-8?B?aUtlOXdwZ1ZGbXd5WWErSk5BUUEweGdVSi9CWkpZUTliSDBiUkFMRXVuS1ZJ?=
 =?utf-8?B?dWNEYnRvS0U2d2NFM3RVOUN3VnFPNmNxc21HcTBLaEZqMHRCSi9yYjM2RUEw?=
 =?utf-8?B?NGhmSjBRZ01pR2l3ZUgwaUZJQisyZ090UFVrN0NIMW9GcXRWMnZtQVoxQTRV?=
 =?utf-8?B?aUl6ODhsSHFYYVBib0Q0UG5YMEIzSGVRRmh0UVBJVWxCOHArNDBFVDQrNnRH?=
 =?utf-8?Q?xLt9KvUei1K9jgq3vUSvKS5K+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR13MB5882.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa47d8-f6c9-47de-13d7-08dc583856ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 01:56:57.5314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGyVdsY2FqoTtaXx8WmFgJCdScgjmjOK4LP6t//MakoKVjiZnpNLRW+UsDHx5/54alEpfivyRuRah4KIWfqAep5cX6My9kZF4dKek+X76G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6232

T24gQXByaWwgOCwgMjAyNCA5OjA5IFBNLCAgQXNiasO4cm4gd3JvdGU6DQoNCj5UaGlzIGhlbHBl
ciBjYW4gYmUgdXNlZCBieSBkcml2ZXJzIHRvIGNoZWNrIGZvciB0aGUgcHJlc2VuY2Ugb2YgdW5z
dXBwb3J0ZWQNCj5jb250cm9sIGZsYWdzLg0KPg0KPkl0IG1pcnJvcnMgdGhlIGV4aXN0aW5nIGNo
ZWNrIGRvbmUgaW4gc2ZjOg0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc2ZjL3RjLmMgKzI3Ng0K
Pg0KPlRoaXMgaXMgYWltZWQgYXQgZHJpdmVycywgd2hpY2ggaW1wbGVtZW50cyBzb21lIGNvbnRy
b2wgZmxhZ3MuDQo+DQo+VGhpcyBzaG91bGQgYWxzbyBiZSB1c2VkIGJ5IGRyaXZlcnMgdGhhdCBp
bXBsZW1lbnQgYWxsIGN1cnJlbnQgZmxhZ3MsIHNvIHRoYXQNCj5mdXR1cmUgZmxhZ3Mgd2lsbCBi
ZSB1bnN1cHBvcnRlZCBieSBkZWZhdWx0Lg0KPg0KPk9ubHkgY29tcGlsZS10ZXN0ZWQuDQo+DQo+
U2lnbmVkLW9mZi1ieTogQXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+
DQo+LS0tDQo+IGluY2x1ZGUvbmV0L2Zsb3dfb2ZmbG9hZC5oIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1n
aXQgYS9pbmNsdWRlL25ldC9mbG93X29mZmxvYWQuaCBiL2luY2x1ZGUvbmV0L2Zsb3dfb2ZmbG9h
ZC5oIGluZGV4DQo+MzE0MDg3YTVlMTgxOC4uYzEzMTdiMTRkYTA4YyAxMDA2NDQNCj4tLS0gYS9p
bmNsdWRlL25ldC9mbG93X29mZmxvYWQuaA0KPisrKyBiL2luY2x1ZGUvbmV0L2Zsb3dfb2ZmbG9h
ZC5oDQo+QEAgLTQ0OSw2ICs0NDksMjggQEAgc3RhdGljIGlubGluZSBib29sIGZsb3dfcnVsZV9t
YXRjaF9rZXkoY29uc3Qgc3RydWN0DQo+Zmxvd19ydWxlICpydWxlLA0KPiAgICAgICAgcmV0dXJu
IGRpc3NlY3Rvcl91c2VzX2tleShydWxlLT5tYXRjaC5kaXNzZWN0b3IsIGtleSk7ICB9DQo+DQo+
Ky8qKg0KPisgKiBmbG93X3J1bGVfbm9fdW5zdXBwX2NvbnRyb2xfZmxhZ3MoKSAtIGNoZWNrIGZv
ciB1bnN1cHBvcnRlZCBjb250cm9sDQo+K2ZsYWdzDQo+KyAqIEBzdXBwX2ZsYWdzOiBmbGFncyBz
dXBwb3J0ZWQgYnkgZHJpdmVyDQo+KyAqIEBmbGFnczogZmxhZ3MgcHJlc2VudCBpbiBydWxlDQo+
KyAqIEBleHRhY2s6IFRoZSBuZXRsaW5rIGV4dGVuZGVkIEFDSyBmb3IgcmVwb3J0aW5nIGVycm9y
cy4NCj4rICoNCj4rICogUmV0dXJucyB0cnVlIGlmIG9ubHkgc3VwcG9ydGVkIGNvbnRyb2wgZmxh
Z3MgYXJlIHNldCwgZmFsc2Ugb3RoZXJ3aXNlLg0KPisgKi8NCj4rc3RhdGljIGlubGluZSBib29s
IGZsb3dfcnVsZV9ub191bnN1cHBfY29udHJvbF9mbGFncyhjb25zdCB1MzIgc3VwcF9mbGFncywN
Cj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IHUzMiBmbGFncywNCj4rIA0KSGkgQXNiasO4cm4sIHRoYW5rcyBmb3IgeW91ciB3b3JrLCBp
dCBtYWtlcyBzZW5zZSBmb3IgZHJpdmVyIGNoZWNrLiBXaWxsIGl0IGJldHRlciB0byBuYW1lIGZs
YWdzIGFzICJjdHJsX2ZsYWdzIiB0byBtYWtlIGl0IG1vcmUgY2xlYXIgc2luY2UgaXQgaW5kaWNh
dGVzIHRoZSBjdHJsX2ZsYWdzIGluIHJ1bGUgYW5kIHlvdSBuYW1lIGl0IGFzIGNvbnRyb2wuZmxh
Z3MgaW4gdGhlIGZvbGxvd2luZyBwcmludCBtZXNzYWdlLg0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0DQo+K25ldGxpbmtfZXh0X2FjayAq
ZXh0YWNrKSB7DQo+KyAgICAgICBpZiAobGlrZWx5KChmbGFncyAmIH5zdXBwX2ZsYWdzKSA9PSAw
KSkNCj4rICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+Kw0KPisgICAgICAgTkxfU0VUX0VS
Ul9NU0dfRk1UX01PRChleHRhY2ssDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJV
bnN1cHBvcnRlZCBtYXRjaCBvbiBjb250cm9sLmZsYWdzICUjeCIsDQo+KyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGZsYWdzKTsNCj4rDQo+KyAgICAgICByZXR1cm4gZmFsc2U7DQo+K30N
Cj4rDQo+IHN0cnVjdCBmbG93X3N0YXRzIHsNCj4gICAgICAgIHU2NCAgICAgcGt0czsNCj4gICAg
ICAgIHU2NCAgICAgYnl0ZXM7DQo+LS0NClRoaXMgc2hvdWxkIG5vdCBiZSBpbmNsdWRlZCBpbiB0
aGlzIHBhdGNoLg0KPjIuNDMuMA0KDQo=

