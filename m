Return-Path: <linux-kernel+bounces-49530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B1846B82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0111F2A0A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1086DCF8;
	Fri,  2 Feb 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TX3yn5Vv"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A96087A;
	Fri,  2 Feb 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864733; cv=fail; b=X+5vFe+e1EVBInnidvcHfi+AMlMk0YqFXRYzAUb4m4o1FiC0JSceriINB2tQP6fjj4EuZDPMUCz1EWB4I6puHUjbkQvyeFUNjZEE5UeLgTjk2C66PvXaKrAwj7EXifNVbgcgQo1RBz2JFaMRNvqZ/U9S7XSls/AfecNN6hafae8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864733; c=relaxed/simple;
	bh=C1CKN31JBuWVtXQ5MbMVrB8+uxBR3BK/mo53EHDbxJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EQyn1YQQcFiYoml5+LfxsLPDRBWsWVBIRAZ5zOjKFGBr2ACB0r5yz5Gx1tcybaPdnFlrMunRGPq6vHMoCcFWWxBHj+v0D9AnP2J0dCflIWw8ZDdCTf0JS/TpKyUlLEBxgLRPVHfU8wA78+iS6WKEDeTXVMzVZ4W+0lgVa4EpG/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TX3yn5Vv; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoRYKUjDeBsid3uNKkquqWfdCGFzOn2ZKwcfU322Lecqy5PChwge4pm+f2JDwwnY28W3iv8A44xKZEyI26Oz+ZS4ZqHnSEI8nQ9SVs2uhQqHdP2Odn6KVHHSj3o6TOLg/IG14hg84lXbQPXU2i2MMYVF14ra3tmFZhshQLAjPng8+vAkT6JB1IQDNqJGZpINrSfIi6o6UK88dhfWCm9KCkOiRjwVLx7Set2NFXfaKXNC5OG5m9fI7yRGG+iRtFI/NTTsO9BsZEB/vqn3VN+MOqJmAPzfyWEma5WIo8slUckEF55+aPfz9i9OK8ha3RB8bNyjdz1VUo04qpx8m7h80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1CKN31JBuWVtXQ5MbMVrB8+uxBR3BK/mo53EHDbxJI=;
 b=WlljIePd8jYq4EUe7tO+EXpW5Yf4UncsLONnNrZt00a2xRB54wG2Ql1zooaNdaNJUxcQmF8iZ7ESBBmg3Q/s5HyjHZ85JLWXz/LRWfsH68LkmS3V8uQ5QBXOtWmTxcdU4WkCY0fTXDjrAPT9wN058Qf0ZfkzOKAQVLjdQluFRHPRIEltOqRZH//jEzUGeV7Sc/8BmI/7CXCkF1Healan92AGZsHxqG7vK8VW70tX4Gl/KHFDhkTm9RBLBB+Jv7M/H8TC19FaiU2n+MLCl+nX3Bk944hKnddoQSxbaU0TnwUCHA3YcAgZ6v1Xv/veGJ3E82peKfF2LLVoqTTjl1owlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1CKN31JBuWVtXQ5MbMVrB8+uxBR3BK/mo53EHDbxJI=;
 b=TX3yn5VvZdLRy2z03H/cnCMW1P9WUNZZMbhe+Sc2Dc7lMkunRQA54Tho0xZPUrv7tIMM2EMX015QXCTLpokzMfGJ6iGnrUPxyRLMfYhBJRu3bmwxJY5ve5QkUrtJ9DA60zX7PNBPqgrrQsZ+XNBIP4DEE9O2eztjnLMVQnINRms=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Fri, 2 Feb
 2024 09:05:26 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 09:05:26 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Topic: [PATCH 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Index: AQHaVCOnnB2z/GENwECqL2SLvBT5EbD0eUIAgAJKnxA=
Date: Fri, 2 Feb 2024 09:05:26 +0000
Message-ID:
 <CYYPR12MB8655478F8AF121EAD1EEA2949C422@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706690577.git.perry.yuan@amd.com>
 <ab45b5a29507460a63d772a0e4b24b83c9b61aa6.1706690577.git.perry.yuan@amd.com>
 <49825045-bce1-4772-b7c4-2e116e19cbaf@amd.com>
In-Reply-To: <49825045-bce1-4772-b7c4-2e116e19cbaf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=92704c45-14fb-4d2f-bc07-eb3b5273a3b5;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-02T08:59:07Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH0PR12MB5250:EE_
x-ms-office365-filtering-correlation-id: f56e19b8-63d3-40d9-c85b-08dc23ce188c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nI/NrDCsUSM3YmdKGSNlcIN+Rzf1XETR+BULqU066pPrsUKvlkGtMwTTcH3vnuG/GhbJG/RIGgSUwDLoCyJyRe0ONwfc5UK8h2kTZBa+IabwyvheXgEdVK02rQVZET6Oqjhx1SEC/RHNOl5t2l1031t5nlVDpkctSMtnpNnkRInL8nDzpTnyl58P12HPIh6D9gSk5GcoWFnQgxQmscCMbt2QMKzob3d/Qh/sSUzYfDeivPjGcUeA8bEwveHP/dDKW/3N1NPWQxTE7vAgqzQb0WFlqhCrcXAU005J+ILujAw9parm4N5+arC/o09RRiYZ51C1tOtTQZa1934qjqJj9axrU5Wm3O77lGPOYDjilOoobr7ZvHmjlmIA4xYMJUvF7QyerNAZ7Zt2L4j2o1nYu5xyw7FacyMGGdD9t3fkAoMyF4BXePxiJrlJAAoH/Tf4UuphqmqJnzLnthmfen7wDITXVUi67o1UwDSIwj8Nw3J3qqgeazHZ3QnSC5vgnUED3I+QP8s2pQmJKK+rOM+sIfrjBHhnXeA0V2klIQ7vvWOFLg7Y8BriEHbnZ7tyCb0xg+SaRKJPZdt+Y2pxmrrAVyk9UX/bPc9q+2a6fO5slhVNOxYMohgzbPCofgmoKm8vXZyljGdQ35J3N5kLYCkUsw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(9686003)(122000001)(38100700002)(4326008)(8936002)(52536014)(5660300002)(66476007)(8676002)(71200400001)(478600001)(53546011)(2906002)(7696005)(110136005)(316002)(6506007)(66446008)(54906003)(64756008)(6636002)(66946007)(66556008)(76116006)(38070700009)(41300700001)(33656002)(921011)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVY3U2JqdEZhWGJGWVd1K2gybklvaDdGY2FNemFvbEg1d3hwUHBBdUI3REM5?=
 =?utf-8?B?WTNjSUJMMEtkS2lHL1UxTnlWK3JEbVZ2bzhJeE9NOTNDYzJ4bWltRkpsZE9x?=
 =?utf-8?B?ZmNvSXpNelA3aG5zS2xpY3VPbk90K3dQaURUaktZSEZPL0UwWnA4eW9aV3BZ?=
 =?utf-8?B?dnpNckg2TWJKK1liV3VnRUFmR3FyS24ydXpvMHBqaWxUY2ZzRHJwRXMrOWdS?=
 =?utf-8?B?Y0dSVHdyRGFidUU5anpVN2RqY01KRUx2eFYzbGNEaDB3VHlmK2dvdWtjaTgr?=
 =?utf-8?B?OFU1R2pqUzVSZWVYYmJHQ3ZVN3g0aEN2VEFFQ2NaZHpJaHF1enpJTFdITEt3?=
 =?utf-8?B?STAwcE9FNWJLcGNIbFZFdDY5NlVnWDlzdHdIdFc3cnNhOFZSb2IrSDZGMGhy?=
 =?utf-8?B?YTRMM0l2SFZzdFFqMGxpWjI0Rm9nMlY2SDIzaGdVT1VkTFdKSndXbWtTd3R3?=
 =?utf-8?B?ZGtQWWx4QkdlL21DVjRwRkRySGVKWXU0Y3hwNzZRYmdJUUMzRmxsQlNFWm14?=
 =?utf-8?B?WlpWZkRvRzFwUGpPU09ObGRUSlZrOUh1RlVpdCtCZnBkVVZvT0NTRVJlaitQ?=
 =?utf-8?B?algxdjZWaG9tQWFaM09jWWZLQVcvanhWeC80UDFMM3g3ZGhydUZEWUJuOHBy?=
 =?utf-8?B?aTZDVGlRdzlRM25PMURic0FSY3VGSmprSzV5YysrcFFkQnQ1S3l1REhzL1Np?=
 =?utf-8?B?clhLZnd3dzdZaHZzWU9kdEVFY3hUWXB2dmlYenNpT3lrbzI5U2d6ekVUZzlZ?=
 =?utf-8?B?SllRMlBEaTZrQjZrNVRXUFZiWkd4TGxBWFdlM0Z4NGl4UXlHK1FKRGg1SVY0?=
 =?utf-8?B?L24zOFlqMDZnRXVjMDFkSXBmc0ZpeGxjYUR0aUlyOWVRb2lYYk5qMGsvbTVp?=
 =?utf-8?B?U1N6d240aHlMOE55TWFueXNHSUpkeUJQS200VFBrbDBkcjREc1FEN3huQS9w?=
 =?utf-8?B?ZGRTVEcwMjdNaGl1OG8zUEhSUzdKdEVOUFVXYWlzWC9pU2tNM2o5QmsrT3NR?=
 =?utf-8?B?Z2I0S2NFNms3Tzh5NWRmc2xiYkNCb3YzUFhjN1FGK0c4Y24zWVE2TG9Da1lX?=
 =?utf-8?B?MUdQSDAxZ1lNNUQ2R04xUHRoMTFPZU1TQ2ZJMzJwN01RM0FzME9ISGlKNXNx?=
 =?utf-8?B?cVdnRjN2Nnl5Qk1XTUZnWmgzZ0NoRks1WlJoOEhIazZzc2lzVTcrYlA5QitH?=
 =?utf-8?B?bW1MT3l1WDlsOC80Mkh2dyt0Y0NMTGRyT1RYak52TDROWWZFZWxUY3RxMWIv?=
 =?utf-8?B?ZE52SXhmNUVyeGdMdVZJMGtqbndEWlNLNm1PenR4ODY3SjVHbGNlZXJPZmxn?=
 =?utf-8?B?THRRQTlqTVE4Y1IrZTIyeWV2VEFFV3VNN29pZGQ0ejB4S2FOUDlkRkVaUGZt?=
 =?utf-8?B?QWFudEs1MWtiNVZuSTV2dVc0cnR3cDE2OXNrREN6cXJIMU5qNWpuY20va2Fr?=
 =?utf-8?B?L2w0cDA4MnVjclI0dHkrUDhDY3NEZzQ0a2hUZkxPNlJmMVJ6TDhtMytUbUYz?=
 =?utf-8?B?eDBVSDlwUm9JeU9nQndsWk1IUzJPL3RpbWllQU1USmNDNGQxTHk4YnVxQkpZ?=
 =?utf-8?B?Rzl6Mkt1aEp1Z05FTzBOd1M3UE1lMHhTa25xdTliMUg5K2NJTHRIeUV2VkJm?=
 =?utf-8?B?LzE5SW1QYTdCT21zeU5rbkFjVGh5cTZuVE4zSjN5dEhqeE9ncC9HNzRnOWNB?=
 =?utf-8?B?Ynl1VVNPcU0yQnRqdjdsa2F6SWlWQnpPY2VKOVJQcXgyaFU2Q1g2VzZlMnpw?=
 =?utf-8?B?MTRIb1NUUHBuV0g4cVNGNUhPWGplMnlWWkw3ZjhnRlJROXh2ZFhkcGJkVzVi?=
 =?utf-8?B?c1YwK1BoK2VJTTFIbjgvTDFUZjkzbXhqQkRJaXhzRXowb2pnRFlaRkE3bWlh?=
 =?utf-8?B?cDZiRmlwTTYxREIwMDduWHVNMGVrRUhlUnFHZmlnNy9xT01MUzlpdjMvWWxS?=
 =?utf-8?B?Rmd6VnMwdm5zejNzSWRwSVI5SW9mN1NweGVUMTQ2OW56MDVtdVJOZjVKUTFY?=
 =?utf-8?B?dlkwQzFYYjBOS3BWYXhvdDhBK2tDUTEwRHBDaFY4RFlQelFTUnlmWFpudG5N?=
 =?utf-8?B?V2xiYjZJTGY4Q0l4QlB1eDlHUFl3NzNuS0xweDRWa1dwQmJUNzB4Szc0Qmlj?=
 =?utf-8?Q?SWq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56e19b8-63d3-40d9-c85b-08dc23ce188c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 09:05:26.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bc7bdh4aoatGeS0vxX/ixsFMJbv4fGf66fIzi/d1N3IfPiD+LOh76RWsOlr+iJRLtmGWntEf+fHxLBvMDNUdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEsIDIwMjQg
NjowMCBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJh
eSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksDQo+IEdhdXRoYW0gUmFuamFsIDxnYXV0aGFt
LnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0a292QGFt
ZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9q
aWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVu
Z0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDYvNl0gY3B1ZnJlcTphbWQtcHN0
YXRlOiBhZGQgcXVpcmsgZm9yIHRoZSBwc3RhdGUgQ1BQQw0KPiBjYXBhYmlsaXRpZXMgbWlzc2lu
Zw0KPg0KPiBPbiAxLzMxLzIwMjQgMDI6NTAsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gQWRkIHF1
aXJrIHRhYmxlIHRvIGdldCBDUFBDIGNhcGFiaWxpdGllcyBpc3N1ZSBmaXhlZCBieSBwcm92aWRp
bmcNCj4gPiBjb3JyZWN0IHBlcmYgb3IgZnJlcXVlbmN5IHZhbHVlcyB3aGlsZSBkcml2ZXIgbG9h
ZGluZy4NCj4gPg0KPiA+IElmIENQUEMgY2FwYWJpbGl0aWVzIGFyZSBub3QgZGVmaW5lZCBpbiB0
aGUgQUNQSSB0YWJsZXMgb3Igd3JvbmdseQ0KPiA+IGRlZmluZWQgYnkgcGxhdGZvcm0gZmlybXdh
cmUsIGl0IG5lZWRzIHRvIHVzZSBxdWljayB0byBnZXQgdGhvc2UNCj4NCj4gcy9xdWljay9xdWly
ay8NCj4NCj4gPiBpc3N1ZXMgZml4ZWQgd2l0aCBjb3JyZWN0IHdvcmthcm91bmQgdmFsdWVzIHRv
IG1ha2UgcHN0YXRlIGRyaXZlcg0KPg0KPiB0byBhbGxvdyB0aGUgcHN0YXRlIGRyaXZlcg0KPg0K
PiA+IGNhbiBiZSBsb2FkZWQgZXZlbiB0aG91Z2ggdGhlcmUgYXJlIENQUEMgY2FwYWJpbGl0aWVz
IGVycm9ycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5A
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA1
MQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgIGluY2x1ZGUv
bGludXgvYW1kLXBzdGF0ZS5oICAgfCAgNiArKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1
MSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0
YXRlLmMgaW5kZXggZWVhMmUxOTJkNzQ4Li5jYmM0MTVhZjBmMDgNCj4gMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMNCj4gPiBAQCAtNjQsNiArNjQsNyBAQCBzdGF0aWMgc3RydWN0IGNwdWZy
ZXFfZHJpdmVyIGFtZF9wc3RhdGVfZHJpdmVyOw0KPiA+ICAgc3RhdGljIHN0cnVjdCBjcHVmcmVx
X2RyaXZlciBhbWRfcHN0YXRlX2VwcF9kcml2ZXI7DQo+ID4gICBzdGF0aWMgaW50IGNwcGNfc3Rh
dGUgPSBBTURfUFNUQVRFX1VOREVGSU5FRDsNCj4gPiAgIHN0YXRpYyBib29sIGNwcGNfZW5hYmxl
ZDsNCj4gPiArc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSAqcXVpcmtzOw0KPiA+DQo+ID4gICAv
KioNCj4gPiAgICAqIHN0cnVjdCBnbG9iYWxfcGFyYW1zIC0gR2xvYmFsIHBhcmFtZXRlcnMsIG1v
c3RseSB0dW5hYmxlIHZpYSBzeXNmcy4NCj4gPiBAQCAtMTIxLDYgKzEyMiwzMiBAQCBzdGF0aWMg
dW5zaWduZWQgaW50IGVwcF92YWx1ZXNbXSA9IHsNCj4gPg0KPiA+ICAgdHlwZWRlZiBpbnQgKCpj
cHBjX21vZGVfdHJhbnNpdGlvbl9mbikoaW50KTsNCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IHF1
aXJrX2VudHJ5IHF1aXJrX2FtZF83azYyID0gew0KPiA+ICsgICAubm9taW5hbF9mcmVxID0gMjYw
MCwNCj4gPiArICAgLmxvd2VzdF9mcmVxID0gNTUwLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3Rh
dGljIGludCBfX2luaXQgZG1pX21hdGNoZWQoY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgKmRt
aSkgew0KPiA+ICsgICBxdWlya3MgPSBkbWktPmRyaXZlcl9kYXRhOyA+ICsNCj4NCj4gVW5kZXIg
dGhlIHByZXN1bXB0aW9uIHRoYXQgdGhlIHF1aXJrIGxpc3Qgd2lsbCBncm93IGFzIG1vcmUgYnVn
Z3kgb2xkZXINCj4gbWFjaGluZXMgYXJlIGlkZW50aWZpZWQsIG1heWJlIGl0J3Mgd29ydGggaGF2
aW5nIGEgZHluZGJnIG9yIGluZm8gc3RhdGVtZW50DQo+IGhlcmUgdG8gaW5kaWNhdGUgdGhhdCBp
dCdzIHVzaW5nIHF1aXJrZWQgdmFsdWVzIGZvciBkbWktPmlkZW50Lg0KDQpBZGRlZCBhIGRlYnVn
IGxpbmUgaW4gVjIuDQoNCj4NCj4gPiArICAgcmV0dXJuIDE7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBhbWRfcHN0YXRlX3F1aXJrc190YWJs
ZVtdIF9faW5pdGNvbnN0ID0gew0KPiA+ICsgICB7DQo+ID4gKyAgICAgICAgICAgLmNhbGxiYWNr
ID0gZG1pX21hdGNoZWQsDQo+ID4gKyAgICAgICAgICAgLmlkZW50ID0gIkFNRCBFUFlDIDdLNjIi
LA0KPiA+ICsgICAgICAgICAgIC5tYXRjaGVzID0gew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
RE1JX01BVENIKERNSV9QUk9EVUNUX1ZFUlNJT04sICJDMSIpLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgRE1JX01BVENIKERNSV9QUk9EVUNUX1NFUklBTCwNCj4gIkZYMTk5MTEwMDAwMjgiKSwN
Cj4NCj4gVGhpcyBpcyB3YXkgdG9vIHNwZWNpZmljIGlzbid0IGl0PyAgSXQgd291bGQgb25seSBs
b2FkIG9uIHRoYXQgc2luZ2xlIHN5c3RlbSBJDQo+IHdvdWxkIGV4cGVjdC4gIEJ1dCBJIHRoaW5r
IHlvdSB3YW50IHRvIGhhdmUgYW4gZW50cnkgdGhhdCBtYXRjaGVzIHRoZQ0KPiBETUlfUFJPRFVD
VF9OQU1FIG9yIERNSV9GQU1JTFlfTkFNRSBpbnN0ZWFkIG1vc3QgbGlrZWx5Lg0KDQpZZXMsICBu
b21pbmFsbHkgd2UgdXNlIERNSV9QUk9EVUNUX05BTUUgb3IgRE1JX0ZBTUlMWV9OQU1FLA0KQ3Vy
cmVudCBxdWlyayBmb3IgN0s2MiBpcyBzcGVjaWFsIGFkZGVkIGZvciBhIEFNRCBjdXN0b21lciBJ
IGRpZCBub3QgZ2V0IHBlcm1pc3Npb24gdG8gZXhwb3N1cmUgdGhlIHByb2R1Y3QgaW5mb3JtYXRp
b24uDQpJdCBpcyB1c2VkIGJ5IGEgc3BlY2lmaWMgc3lzdGVtIHdoaWNoIGhhcyBicm9rZW4gQklP
UywgdGhlcmUgYXJlIGxvdHMgb2Ygc2VydmVyIG5vZGVzIHRoYXQgY2Fubm90IHVwZ3JhZGUgQklP
Uy4NClNvIHdlIG1hdGNoIHRoZSBzeXN0ZW0gd2l0aCB2ZXJzaW9uIGFuZCBzZXJpYWwgbnVtYmVy
IGZvciB0aGUgc3BlY2lhbCBmaXguDQoNCklmIHVzZXJzIGhhdmUgb3RoZXIgcHJvZHVjdHMgZm9y
IHF1aXJrcyBmaXgsIHdlIHN0aWxsIGNhbiB1c2UgIERNSV9QUk9EVUNUX05BTUUgb3IgRE1JX0ZB
TUlMWV9OQU1FIGluIHRoZSBuZXh0IG1hdGNoZXMuDQoNClBlcnJ5Lg0KDQo+DQo+ID4gKyAgICAg
ICAgICAgfSwNCj4gPiArICAgICAgICAgICAuZHJpdmVyX2RhdGEgPSAmcXVpcmtfYW1kXzdrNjIs
DQo+ID4gKyAgIH0sDQo+ID4gKyAgIHt9DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFC
TEUoZG1pLCBhbWRfcHN0YXRlX3F1aXJrc190YWJsZSk7DQo+ID4gKw0KPiA+ICAgc3RhdGljIGlu
bGluZSBpbnQgZ2V0X21vZGVfaWR4X2Zyb21fc3RyKGNvbnN0IGNoYXIgKnN0ciwgc2l6ZV90IHNp
emUpDQo+ID4gICB7DQo+ID4gICAgIGludCBpOw0KPiA+IEBAIC01ODEsMTMgKzYwOCwxOSBAQCBz
dGF0aWMgdm9pZCBhbWRfcHN0YXRlX2FkanVzdF9wZXJmKHVuc2lnbmVkIGludA0KPiBjcHUsDQo+
ID4gICBzdGF0aWMgaW50IGFtZF9nZXRfbWluX2ZyZXEoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVk
YXRhKQ0KPiA+ICAgew0KPiA+ICAgICBzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgY3BwY19wZXJmOw0K
PiA+ICsgICB1MzIgbG93ZXN0X2ZyZXE7DQo+ID4NCj4gPiAgICAgaW50IHJldCA9IGNwcGNfZ2V0
X3BlcmZfY2FwcyhjcHVkYXRhLT5jcHUsICZjcHBjX3BlcmYpOw0KPiA+ICAgICBpZiAocmV0KQ0K
PiA+ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4NCj4gPiArICAgaWYgKHF1aXJrcyAmJiBx
dWlya3MtPmxvd2VzdF9mcmVxKQ0KPiA+ICsgICAgICAgICAgIGxvd2VzdF9mcmVxID0gcXVpcmtz
LT5sb3dlc3RfZnJlcTsNCj4gPiArICAgZWxzZQ0KPiA+ICsgICAgICAgICAgIGxvd2VzdF9mcmVx
ID0gY3BwY19wZXJmLmxvd2VzdF9mcmVxOw0KPiA+ICsNCj4gPiAgICAgLyogU3dpdGNoIHRvIGto
eiAqLw0KPiA+IC0gICByZXR1cm4gY3BwY19wZXJmLmxvd2VzdF9mcmVxICogMTAwMDsNCj4gPiAr
ICAgcmV0dXJuIGxvd2VzdF9mcmVxICogMTAwMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGlj
IGludCBhbWRfZ2V0X21heF9mcmVxKHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkgQEAgLTYx
OSwxMw0KPiA+ICs2NTIsMTQgQEAgc3RhdGljIGludCBhbWRfZ2V0X21heF9mcmVxKHN0cnVjdCBh
bWRfY3B1ZGF0YSAqY3B1ZGF0YSkNCj4gPg0KPiA+ICAgc3RhdGljIGludCBhbWRfZ2V0X25vbWlu
YWxfZnJlcShzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpDQo+ID4gICB7DQo+ID4gLSAgIHN0
cnVjdCBjcHBjX3BlcmZfY2FwcyBjcHBjX3BlcmY7DQo+ID4gKyAgIHUzMiBub21pbmFsX2ZyZXE7
DQo+ID4NCj4gPiAtICAgaW50IHJldCA9IGNwcGNfZ2V0X3BlcmZfY2FwcyhjcHVkYXRhLT5jcHUs
ICZjcHBjX3BlcmYpOw0KPiA+IC0gICBpZiAocmV0KQ0KPiA+IC0gICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+DQo+IEkgdGhpbmsgdGhpcyBodW5rIHNob3VsZCBiZSBlYXJsaWVyIGluIHlvdXIgc2Vy
aWVzLiAgQ29uY2VwdHVhbGx5IGl0IHNlZW1zIHRvDQo+IG1hdGNoIHdoYXQgcGF0Y2ggMyBkb2Vz
IHRvIG1lLg0KDQpJdCBpcyBhIG1pc3Rha2UgdGhhdCByZW1vdmUgdGhlIGNvZGUgaGVyZS4NCkkg
aGF2ZSBmaXhlZCBpdCBpbiB0aGUgVjIgYW5kIHRlc3RlZCB0aGUgcGF0Y2hlcyB3b3JrIGFzIGV4
cGVjdGVkLg0KDQoNCj4NCj4gPiArICAgaWYgKHF1aXJrcyAmJiBxdWlya3MtPm5vbWluYWxfZnJl
cSkNCj4gPiArICAgICAgICAgICBub21pbmFsX2ZyZXEgPSBxdWlya3MtPm5vbWluYWxfZnJlcTsN
Cj4gPiArICAgZWxzZQ0KPiA+ICsgICAgICAgICAgIG5vbWluYWxfZnJlcSA9IFJFQURfT05DRShj
cHVkYXRhLT5ub21pbmFsX2ZyZXEpOw0KPiA+DQo+ID4gLSAgIHJldHVybiBjcHBjX3BlcmYubm9t
aW5hbF9mcmVxOw0KPiA+ICsgICByZXR1cm4gbm9taW5hbF9mcmVxOw0KPiA+ICAgfQ0KPiA+DQo+
ID4gICBzdGF0aWMgaW50IGFtZF9nZXRfbG93ZXN0X25vbmxpbmVhcl9mcmVxKHN0cnVjdCBhbWRf
Y3B1ZGF0YQ0KPiA+ICpjcHVkYXRhKSBAQCAtMTYyMyw2ICsxNjU3LDExIEBAIHN0YXRpYyBpbnQg
X19pbml0IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+ICAgICBpZiAoY3B1ZnJlcV9nZXRfY3Vy
cmVudF9kcml2ZXIoKSkNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVFWElTVDsNCj4gPg0KPiA+
ICsgICBxdWlya3MgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgLyogY2hlY2sgaWYgdGhpcyBtYWNo
aW5lIG5lZWQgQ1BQQyBxdWlya3MgKi8NCj4gPiArICAgZG1pX2NoZWNrX3N5c3RlbShhbWRfcHN0
YXRlX3F1aXJrc190YWJsZSk7DQo+ID4gKw0KPiA+ICAgICBzd2l0Y2ggKGNwcGNfc3RhdGUpIHsN
Cj4gPiAgICAgY2FzZSBBTURfUFNUQVRFX1VOREVGSU5FRDoNCj4gPiAgICAgICAgICAgICAvKiBE
aXNhYmxlIG9uIHRoZSBmb2xsb3dpbmcgY29uZmlncyBieSBkZWZhdWx0Og0KPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCBiL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0
ZS5oDQo+ID4gaW5kZXggNDQ2Mzk0Zjg0NjA2Li5lYTgwZjk2MTYwN2QgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Ft
ZC1wc3RhdGUuaA0KPiA+IEBAIC0xMTAsNCArMTEwLDEwIEBAIHN0YXRpYyBjb25zdCBjaGFyICog
Y29uc3QNCj4gYW1kX3BzdGF0ZV9tb2RlX3N0cmluZ1tdID0gew0KPiA+ICAgICBbQU1EX1BTVEFU
RV9HVUlERURdICAgICAgPSAiZ3VpZGVkIiwNCj4gPiAgICAgTlVMTCwNCj4gPiAgIH07DQo+ID4g
Kw0KPiA+ICtzdHJ1Y3QgcXVpcmtfZW50cnkgew0KPiA+ICsgICB1MzIgbm9taW5hbF9mcmVxOw0K
PiA+ICsgICB1MzIgbG93ZXN0X2ZyZXE7DQo+ID4gK307DQo+ID4gKw0KPiA+ICAgI2VuZGlmIC8q
IF9MSU5VWF9BTURfUFNUQVRFX0ggKi8NCg0K

