Return-Path: <linux-kernel+bounces-136969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1689DA70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422AA1C20ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE29131E59;
	Tue,  9 Apr 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q50M8sfa"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2113.outbound.protection.outlook.com [40.107.92.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69212FB12;
	Tue,  9 Apr 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669652; cv=fail; b=idC375pX2IFJa7Q3orEQOrOpmrQSqxS2g121F8Yp105lvfSy7K+6+pmrGAOU1MNB6Nd7b/qQPLtw3VRn4ws6JAPyjjzhvkDTcYlkpHx/YCHCmVH9bvPqhV6lDYHgVJjEc1tIfNBFKPRUW+J7gAhYjb6Pf6eynHbCIz+w+hjDRRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669652; c=relaxed/simple;
	bh=5Fqt0iLNFwJA0PIOIM7qxHCX0Vrv8kmbiB6TbO9ikzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ya+ymC3TCITPAxtH2Yj8nd/QFYcfK0FmnDrsez0oSfxpeLiITGmGhjvSKMdZVPO/QiT+yt15lmaSREvjsAYHvi01xgiH4/FBX92x8ouTh8b8MDyKldqcRu1tjhlQRjf3IHM4wkwVJ+QGMHLHvKFfNgqXxDPRVZ41Wji75bjUkOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q50M8sfa; arc=fail smtp.client-ip=40.107.92.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV1S0g2K7R3zSdI7zU5mqx82Gs4Opo+zddeh9sb0rht9CivOFQM1UEqh19+x6o9ZFPpi5VT95VBILTaiCJSAs6uRbOFYF4M3uWfg4KdmJoQag4+lgj2vrv15wqnZCO+eLrSwFl9SSgcc1x4tsgr42bnMiGx7ZX6rI6r/SkpWsxdbFCETkTRU8jgz9ihQT0MzqnuUmO31v3sly727ID7u3TJ9OdHX805qHTK8fiph9ukvJ6y2K7jMRTPFcRxIJ4tkPZeX+h53SDSSdHNMII0xLMq2v5TAmVcPPhXEEMzxYy2IK+WG8K1do74wEaL60iwrkhZz/Q+8JuHjelXo+qPFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fqt0iLNFwJA0PIOIM7qxHCX0Vrv8kmbiB6TbO9ikzw=;
 b=AWaoiV2Ih5gMC2sN2XTxL9202ZV0fKSEk7g2dLH9UELpXITLQh4xRRQKyczLddGbE3R+nzHT9L5ntllNl5dAxX27VSqWFZ4lM+OMu+DZIS+DS75UXmEtYaj4bVLH7KAPPRpLP6fqZMsVWR9DdLNRhWaWc9iq8jpbX8NrMCjPxsxOi3LUYjt4jS6g1vyo80HokxyooNhmmJD4SQjfH85vpkJj3vpdFlpJ91Gc76OfDK1jWBX3lQ15aF3HpCmBc0DU0K/pQ+l0zViQ3ePUTzaroQafK9XSKYNSR1vzGlXRTQwLZ1y+5Rx0zcSuQ4clyASx/cfaZfajPhUnEcImhtKPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fqt0iLNFwJA0PIOIM7qxHCX0Vrv8kmbiB6TbO9ikzw=;
 b=Q50M8sfaGNKHPV8/5ZA9ynYyYwX05lyzcbq2GVorrtE6l5Ompap2wgkEHha6B9uL9sMu6BmnrBrzP04pWc2gHmVQizy3Ee7fnZ7A9biUjPWf+SZ4Ac1nlyBACBr0LNk3eMFsptVg1icw/htI0Vk6cmca1OnAEo1IG8QZdworae7CI676ZtcVxbODNVh/px1hNio8r6WBd/vCZPfSKDD3jpzZ61GmcfRTUIfOB+E5m0xg1jJ2+1kFeH2d3DaBm+HJmce1kZDmcyb5erQQXgpz69atu0aSDfAUNXQ6v0HyAFGOS7FleJC1VwbyMIiFeQxV8ZJSk1qTAZ4sOCFSTQnUHw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:34:07 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 13:34:07 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Russell King <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHaibP8CTLNLV9gi0evdveMyJyMArFediSAgAFophA=
Date: Tue, 9 Apr 2024 13:34:07 +0000
Message-ID:
 <DM6PR12MB451681D2A292399C9DDE9EDFD8072@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240408125340.2084269-1-danieller@nvidia.com>
 <20240408125340.2084269-8-danieller@nvidia.com>
 <ZhQFV7I3EwW7FV+H@shell.armlinux.org.uk>
In-Reply-To: <ZhQFV7I3EwW7FV+H@shell.armlinux.org.uk>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA0PR12MB8930:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rkqefNPRvhXZs4dg/0gwY6cNTDRLxroXmG4CBi/nIT7c18W2v6C5J8yduCzaljEVYkKkLyW0TsKrPrLy+Xq9k0ZA+WTCe7j7aF7LnPSl9XwkLcNDc6YyypkOi5tu+yF9zNL0XnQDlwKEe4etO/aJSdn99SNjHraGfR5qXnA+bLl9C/hGsyhpF51bJssPyS+Aft7GI5M/ntwXI8glvkFBX1E1sY3R4msaGqWsiQfo+A2pKOLUzSRgEGDiMhLLZedBO4OdPV6YrOroMMFTkkTzx15xgzZd1LGLlLIm7v6NfEPyzSKA5Gh34a5C3OTrSngeIuxXEln3YRmq7YDbKeIn7GXgZq32BWg3LWI8D2humsmDPQ2xV4SSckkx/bETFQyP3Y2D+SqXgfDhJO0OTfKuxQXaZOgwCCfaONewbAMwMAHhp80I0Xh1W9HLrrcxfWv8nAxjtGwYCbFS6ifg1qmcl2vAFDIDDW+NVeE2+4wi0J+Mi4nhMQSkluVqRceDdGIEwoOpm5LXw892If4RqHXpntVZ6FND9NgsF+S/GT6TzwE/1HQlijlbneZCsRtkrvYlMMxl/27bB2Xar5WgewkpVsHT3WaIPifeRyK2XPF9mEopRqYC+pl8oSuD+/WyrwjJJSZx4oh2+6ecqzNVYMiCDEtybZZhgZfrmU+8KB5eVVM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnZSYnlxeFNJYjJzWTlqT1V0dklmUXZRdlBvd3pIWTF6bjllRndSN3hSd0lL?=
 =?utf-8?B?VXc0RWhCWXROSFZOOU9oUjlFODRWTU9TY3JUR0xFT0t6elIyOTdkNnFnSnMz?=
 =?utf-8?B?cDQrT1U1Y0xLZWJJcUV0bjZ2ajdta1pJemdERU93NTBXbzI3UVh5Nm80c21o?=
 =?utf-8?B?WllSSjM1S0lyTlhzZEZsNThLK1R1SDQ4SDhYWFNrUWlNSlpHamRtMzFad3Zu?=
 =?utf-8?B?K0xGOFdFS0xuL1c0ZFE5bGlNanl0ZEMzTklYMUg2YURnUHBtdjA3eThUOWIr?=
 =?utf-8?B?VDJvRkRyMktLQ1JrdC96OHIvbDRFWHc5ZjdwSjRVdWFvN1N3VGVsbXNzWnpX?=
 =?utf-8?B?bUJNVXN2TXhGb3I4YVc3eHpHL1pKQ0VKaGpVREFocVlpL1pEVDlrbW9Zb2dI?=
 =?utf-8?B?RmxNYXRkazBsdWV3UE9rZDR5STM5VVRaOWZHeHJHeWZIU1lRcHk1Mm9UZzdZ?=
 =?utf-8?B?VWpsclZ3MENMWEVaaWZyQVZPWHhqQTQ2WjFCbXNmUWx3OEROUCtMNDZTNXIz?=
 =?utf-8?B?UUFPMUhneWcranBMR3BXVHZjNEZSVWlqd2dkZUM0M2lMSGtDRWttV3ZaN2xO?=
 =?utf-8?B?cFh6aTN2L2xkRnF2MnViYmdkelh6K1FNdGZpaktkT0ZhSVhGU0FZUnZEZFkx?=
 =?utf-8?B?bUZnSktqTFRJK0lmRW5tcUhRbTcwSXd4c0J6MEIvb011cEgyQWZjaFZvcExs?=
 =?utf-8?B?YkV0cmZld1pNMDEyWFRaSUZ5djVTUnVGMndaTGNaSXVKK1Z3dFZzbEhsc01B?=
 =?utf-8?B?eWdETzJLZEdqWWlydVpINkNJVlVZeFc0a3pXTzRnbmZuQXl2bGNoV1k1M3E5?=
 =?utf-8?B?ZnN6VENtWnp5Kyt6ay9SWXhmM1pKWXVtOElOeEdqN3hjQ0hPa3V0QjlxSndI?=
 =?utf-8?B?Nndlb09YV045ZTY0Q2R2bkoyS3A3UGJYK3FncWhLTEFxd01vNENrL0ZmMDBE?=
 =?utf-8?B?cFNvd09INmFLb2JLcHUya1FrK1M3aXVxOUVIZExycy9HcjR6WWc2Z0NBZXc5?=
 =?utf-8?B?MEFZNU84SVJqekdpMUdTRkxiZjNXTzZiQWhTcnNmL0RXYUJURGlweEdLTmhm?=
 =?utf-8?B?dGQ5Q0lHeHpvdWRleU5NK1FUSXBCK1hxZEt1OTFSZGZxYjVsMm53em01Yldr?=
 =?utf-8?B?THBGOXJWYlkzT2pRQ2tBczVmdE1SYlBRRVhrd2VIM09tVElOY2ZyVUhBZFl2?=
 =?utf-8?B?UDFsRk1yMjVMVEtYTzJjWE1FUUExYnFML1dFbU9Rd2NsckV0c01hQVBFYm9N?=
 =?utf-8?B?TzU0N3JlckRnK3JnV0UyZ0ZEODNoSC8rZlNsY3B0eHRMMi9UbEJVcFJMcEVu?=
 =?utf-8?B?aEFsODFJUVB4VTZKUVc0dFN4SkMrRmJiaHE4WEE1ZFRCcEFIREsyaVByZzJX?=
 =?utf-8?B?SlYrNk9TNlR1M3BhY01pZFNKem1zaTAxMFV6L1VDYWF6a2ltOVJMZHBRUDBs?=
 =?utf-8?B?TDBIM0M3VFRNbU52LzVrQWs5ZUFqcVlBcnlsaHNkVVRxdlFqVE1BVDB2cmRw?=
 =?utf-8?B?aUU0elN3ZXRLd2ltRzhWVVRTZ1prVVJ2bzBWTE8wUGYxNkpZWHNMd241eWd4?=
 =?utf-8?B?SlUyN3k4RDNIOEl1MDNGMVNjbmJUbHVHejdIamd1YmxEUDQ3Qjl0WmxQZ1FP?=
 =?utf-8?B?UVlXS3Q2WTI3S1BLakJ1VGQ1Nld1bmUzaWZHcXBxUG9YN3RuWTFNZ3pldEJ4?=
 =?utf-8?B?ZGMyVHNkOFJJVitIbndLL2hZYTVTTUZ6bmt0L2pFWlRUOGVyeW5WWGoyWndQ?=
 =?utf-8?B?VFNaL0tLUlNCb1MxM0hqYlFnSzR3eFVWZHVjaENMOGhtc3h5VUlDRjFLTDQv?=
 =?utf-8?B?c2NvZ2tKTmlSNEg1ckJxSllvWTBZRWxIbFo5aDJ1OGdKWHNobHpYUzZCNzUw?=
 =?utf-8?B?Mi9HMWdqVFM3cXlmc0NYWEF4Ykk3bjh0SEdtNmlyem1XbG9ab2hvVzVUVit4?=
 =?utf-8?B?dnpVb1l5MU9DZFFWOWQ1Q0xxYjVJTVpNT1JyUmI2RDh1a2NIbXJpckJ3Tm5x?=
 =?utf-8?B?L3JLb01qbnB0a1NSNkVXRGhTdDJXWldsSW9lUzF3MnNLK1EySC9QdXZTb3hQ?=
 =?utf-8?B?czZsUVk5T2ZUVUVwTnpjQ1FMV0dxMElyaEpSOHRrWVdXMk5CWHBzYzFJNjVn?=
 =?utf-8?Q?uo+dLnYMWLECdl7Mw4cqK/RVb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f5ccc7-4c66-4674-6f55-08dc5899bb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 13:34:07.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O68eHyg+AQOBM6oOCIRRfXW0QZXoYgxYJ5y7HuUCz7Ruw44JJCjd5fc+eUetvgY4kzBgKlS9vc/GB5Ns5gZBXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPGxpbnV4
QGFybWxpbnV4Lm9yZy51az4NCj4gU2VudDogTW9uZGF5LCA4IEFwcmlsIDIwMjQgMTc6NTUNCj4g
VG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29t
Ow0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBjb3JiZXRAbHduLm5ldDsg
c2RmQGdvb2dsZS5jb207DQo+IGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb207IG1heGltZS5jaGV2
YWxsaWVyQGJvb3RsaW4uY29tOw0KPiB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsgcHJ6ZW15c2xh
dy5raXRzemVsQGludGVsLmNvbTsNCj4gYWhtZWQuemFraUBpbnRlbC5jb207IHJpY2hhcmRjb2No
cmFuQGdtYWlsLmNvbTsgc2hheWFnckBhbWF6b24uY29tOw0KPiBwYXVsLmdyZWVud2FsdEBpbnRl
bC5jb207IGppcmlAcmVzbnVsbGkudXM7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtbHhzdyA8bWx4c3dAbnZpZGlhLmNvbT47IFBl
dHIgTWFjaGF0YQ0KPiA8cGV0cm1AbnZpZGlhLmNvbT47IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52
aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgMDcvMTBdIGV0aHRvb2w6
IGNtaXNfY2RiOiBBZGQgYSBsYXllciBmb3INCj4gc3VwcG9ydGluZyBDREIgY29tbWFuZHMNCj4g
DQo+IE9uIE1vbiwgQXByIDA4LCAyMDI0IGF0IDAzOjUzOjM3UE0gKzAzMDAsIERhbmllbGxlIFJh
dHNvbiB3cm90ZToNCj4gPiArLyoqDQo+ID4gKyAqIHN0cnVjdCBldGh0b29sX2NtaXNfY2RiX3Jl
cXVlc3QgLSBDREIgY29tbWFuZHMgcmVxdWVzdCBmaWVsZHMgYXMNCj4gZGVjcmliZWQgaW4NCj4g
PiArICoJCQkJdGhlIENNSVMgc3RhbmRhcmQNCj4gPiArICogQGlkOiBDb21tYW5kIElELg0KPiA+
ICsgKiBAZXBsX2xlbjogRVBMIG1lbW9yeSBsZW5ndGguDQo+ID4gKyAqIEBscGxfbGVuOiBMUEwg
bWVtb3J5IGxlbmd0aC4NCj4gPiArICogQGNoa19jb2RlOiBDaGVjayBjb2RlIGZvciB0aGUgcHJl
dmlvdXMgZmllbGQgYW5kIHRoZSBwYXlsb2FkLg0KPiA+ICsgKiBAcmVzdjE6IEFkZGVkIHRvIG1h
dGNoIHRoZSBDTUlTIHN0YW5kYXJkIHJlcXVlc3QgY29udGludWl0eS4NCj4gPiArICogQHJlc3Yy
OiBBZGRlZCB0byBtYXRjaCB0aGUgQ01JUyBzdGFuZGFyZCByZXF1ZXN0IGNvbnRpbnVpdHkuDQo+
ID4gKyAqIEBwYXlsb2FkOiBQYXlsb2FkIGZvciB0aGUgQ0RCIGNvbW1hbmRzLg0KPiA+ICsgKi8N
Cj4gPiArc3RydWN0IGV0aHRvb2xfY21pc19jZGJfcmVxdWVzdCB7DQo+ID4gKwlfX2JlMTYgaWQ7
DQo+ID4gKwlzdHJ1Y3RfZ3JvdXAoYm9keSwNCj4gPiArCQl1MTYgZXBsX2xlbjsNCj4gDQo+IHUx
NiB3aXRoIGEgc3RydWN0IHRoYXQgYWxzbyB1c2VzIF9fYmUxNiBsb29rcyBzdXNwaWNpb3VzLg0K
PiANCj4gPiArCQl1OCBscGxfbGVuOw0KPiA+ICsJCXU4IGNoa19jb2RlOw0KPiA+ICsJCXU4IHJl
c3YxOw0KPiA+ICsJCXU4IHJlc3YyOw0KPiA+ICsJCXU4IHBheWxvYWRbRVRIVE9PTF9DTUlTX0NE
Ql9MUExfTUFYX1BMX0xFTkdUSF07DQo+ID4gKwkpOw0KPiANCj4gRG9lcyBpdCBtYXR0ZXIgaWYg
dGhlIGNvbXBpbGVyIGluc2VydHMgc29tZSBwYWRkaW5nIGJlZm9yZSB0aGlzIHN0cnVjdCBncm91
cD8NCg0KWWVzIGl0IHNob3VsZCBtYXR0ZXIgc2luY2UgSSBjb3B5IHRoaXMgc3RydWN0IGludG8g
YSBwYXlsb2FkIGFuZCBpdCBzaG91bGQgYmUgdHJhbnNmZXJyZWQgbGlrZSB0aGF0IHRvIG1hdGNo
IHRoZSBDTUlTIHNwZWNpZmljYXRpb24sIGJ1dCBpZiBJIHVzZSBfX2JlMTYgZm9yIGJvdGggaWQg
YW5kIGVwbF9sZW4gaXQgbWlnaHQgcmVzb2x2ZSB0aGUgaXNzdWUgaXNu4oCZdCBpdD8NCg0KPiAN
Cj4gPiArLyoqDQo+ID4gKyAqIHN0cnVjdCBldGh0b29sX2NtaXNfY2RiX3JwbF9oZHIgLSBDREIg
Y29tbWFuZHMgcmVwbHkgaGVhZGVyDQo+ID4gK2FyZ3VtZW50cw0KPiA+ICsgKiBAcnBsX2xlbjog
UmVwbHkgbGVuZ3RoLg0KPiA+ICsgKiBAcnBsX2Noa19jb2RlOiBSZXBseSBjaGVjayBjb2RlLg0K
PiA+ICsgKi8NCj4gPiArc3RydWN0IGV0aHRvb2xfY21pc19jZGJfcnBsX2hkciB7DQo+ID4gKwl1
OCBycGxfbGVuOw0KPiA+ICsJdTggcnBsX2Noa19jb2RlOw0KPiANCj4gRG9lcyBpdCBtYXR0ZXIg
aWYgdGhlIGNvbXBpbGVyIGFkZHMgc29tZSBwYWRkaW5nIGhlcmU/DQoNCktpbmQgb2YgdGhlIHNh
bWUgaWRlYSwgaXQgaXMgbWF0dGVyIGlmIHRoZSBjb21waWxlciBhZGRzIHBhZGRpbmcgc2luY2Ug
dGhlIHJlcGx5IGlzIHJlYWQgYW5kIGV4dHJhY3RlZCBpbnRvIHRoaXMgc3RydWN0IGxpa2UgaXQg
aXMgd3JpdHRlbiBpbiB0aGUgQ01JUyBzcGVjaWZpY2F0aW9uLg0KPiANCj4gLS0NCj4gUk1LJ3Mg
UGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNo
ZXMvDQo+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVj
dGl2aXR5IGF0IGxhc3QhDQo=

