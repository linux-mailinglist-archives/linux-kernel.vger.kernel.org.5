Return-Path: <linux-kernel+bounces-71837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D8285AB4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC351F23A14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78F4F5E5;
	Mon, 19 Feb 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mQBY47XP"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A784F1EA;
	Mon, 19 Feb 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368174; cv=fail; b=FigDnZDZGrtgzN+hUrrEMqbBuHONaK5mymCueFO/uFnN/fH5xnccRa/iWlDNAOqjdpAGyYUPSyafLT3P0UFgN2d/oAv43kg3qCIe9izPtknaBV381A77G/eu6PibA9ZLxvvDDLVj+ysWJWCDVYawTJErxzVpVUTkOQsHT8vRq8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368174; c=relaxed/simple;
	bh=3QElO1zrZDPHq1X24auvsot7zs2OPGUhtX5RNSfxi58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHNh+Vk3hWyoeeblPFUrt9prL2J8GmCskJ26mBZrfqK0fgy3UPTVh99dgW8UghSBfGBeYh6YPlMUj0HXwtBycC5Dmie3YatUU+Hbk6EkpteOTILiL+5ODfUSFzAfxgGVVz5GaK2a3ALyUyxErvRMeN8ZuxSB1kqAfXg3jRwSSjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mQBY47XP; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa7g7S1WwAhdYqVcNhOmuzlmrYPKh5p7C+uPtswDezwctU05pmTyGIdS9SMvOIc0nW0zwc9/fB+6orVB2T3SC5lwth8JBqi6xpaScsnQ207utcLc6QRLU6Uz9RH5PAQkHwb1is6M1ccNBBPQjxaQsFd9pQv7fuF1cPNjGiKvmKEkHi2Sfp2csUZh6kGilMQ3uAmCKIqZgSqYDxvfX1NbH0LhABz/hzFaQaJGBCpdo2iLDT2454T44zJP2ZKrn3bytCE6ewu4EbOqbVWROCjZzYuZ9qJdFGOeT1PUDRqT9HCBOinLttO4WBCLvmmmezLfmqJAJIDxJfbh376BtYssYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QElO1zrZDPHq1X24auvsot7zs2OPGUhtX5RNSfxi58=;
 b=M9/F0gbTXJSK5bYkrDZ24mZf/0ltOkPP07HqyYtfymf0U9AsLt8jPjELTKcCfI33Jnp8ARUZoVf+tsi9apVk9gItjF2dhXz0/24ueVSjpdkoSa4W5LNVPyMzyPjNrrEOCHouumumcSt22Jg61uGJybTQGtI39a/yX3o039iQqsJUv0Uq79aIWjV3DPQ3vEd3dEC5AkcRpCGBxNQ9LF+/R9CSgMim7xOhidJUc67nrMdmccIRYcIVSnr4cvvcCSMx6Oqw36dHgmgj33cwqkd/eDMDSFOMmODBshBxSpac0BQjDCHWm/R1EKJOm7yXgCI6HzLKpPYlQ4FSWGFbEjMHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QElO1zrZDPHq1X24auvsot7zs2OPGUhtX5RNSfxi58=;
 b=mQBY47XPif9w7OL1EyhYok1PdSb8IpwrTWYNR+tROlpeDfBNBAkGp7XkAFMUFr3tEwpELeYkyD13KuV/QfLcPeRx4lIyaPe74jkSBglJAHxnSdS03FYg5WL9P4Xj0U9fdmTeancTngpfsIUadnSUJy02Vc9UeO6eptkTLKKiWeQ=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 19 Feb
 2024 18:42:49 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::db7e:d46d:eefd:5fc5]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::db7e:d46d:eefd:5fc5%5]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 18:42:49 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Markus Elfring <Markus.Elfring@web.de>, Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Simek,
 Michal" <michal.simek@amd.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Thread-Topic: [PATCH v3] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Thread-Index: AQHaYQQd1oXE4sONC0e7cAjEQuuwLLERdsKAgABfxgCAACxGcA==
Date: Mon, 19 Feb 2024 18:42:49 +0000
Message-ID:
 <MN0PR12MB59537A9F0EAEAC9E844C8DCDB7512@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <ZdMp+QBiays6fprk@x1-carbon>
 <9427c0fd-f48a-4104-ac7e-2929be3562af@web.de>
In-Reply-To: <9427c0fd-f48a-4104-ac7e-2929be3562af@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MW6PR12MB8705:EE_
x-ms-office365-filtering-correlation-id: 453dbd51-65ae-412a-52e3-08dc317a92a9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WNlad6B/V1bTUHJ9qtvNVOkVFSsZA/rr+n1+JRVv6w3JXlmhF4rKIeCfIMYnFUtEBrCOZBJ+DMbuQAYTz/fQ+5VXqBY+VGlTz5dJ58V6hLPJVaHkgNKKmQ6rLlWDY0ruhQtHnT39/FI066QSYGRsSFdrnmZDokWlK5gUwJYdbvUqndBcL4EtZKZx305H5B+/pnIEUC3RhuzbDuD3egfIUJ9uP4dYICBEOfgYN9p+YY1x9Uw8YpNO8CFb1wCWtrrTH1V5yUI4RYLUUef7t2/P2yGlzHD47/15eF+nX9Qz18JYwLOaGlj3P98kfABPwGC0WOVmDZ3SBIi6jq5ynmEbsCgrhBxu3eFfBwZhJ+UzoR92R5VmdlxNB6KaiBlrECPWVV2dRafiK8nU1ijMpp4i8wLhUjidhpdDY66iP3iZeUsAwYGa8l9biO0ZUKSOvsa/24+c9SmzArfoW/PgrfeRf9SuTtV8YH37ancRlDsuBXkNK/qoHxt+Us3c/G7AzTUSR425P/L6hZ9LVL8ooNfoANxR3KXkq6kzkTBTApcTy2cTqAMw2VLLhUuCD6GyGUbCx4ct49DWT34vL7R5FLGe/TOvUBbO9a+wAONEn+kX/y0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmpDQjJqOWUwOVhwUFpvNmY3NDlCZkJyQXlPNXRrclJVK3FHSCtTU20xZUFO?=
 =?utf-8?B?eXRjcXRwNkh2ckVieldJdHMreDdkK29majIxUnZ3cTl3Ly9iWUh1UUdURE4r?=
 =?utf-8?B?bkN6YUh4dzI0Y3pZdnFjZWRWMkdoK3R0dktCOUFqeEx4NDRMNmVlMVUyME5i?=
 =?utf-8?B?MEwzazEwU0hNS25TelBxL2ZkLzlGclhGY0ttWU5aUWhhLzZUL1BzV2VnbnFQ?=
 =?utf-8?B?VGo5U3l4TkRNRjBUSHgyMjEySENJVmxEWFIxQ3RLSkhNaDZnaVNHdC9QVmRR?=
 =?utf-8?B?QUR3NjVLR2o3WVlJNkZxYnRIMGRzT2lnT3BGQnhHOHhXUFE0RHBjcnlETUg0?=
 =?utf-8?B?TlU3NmpjMmxaeVNIRGtIQXBQM2EwM0U4c2VJOFhwMmtoUFdoQUdUSnB1WjUx?=
 =?utf-8?B?a0JoVlpkaFZVcjFyamVKc1lRU09yNjZ3RWhuTlkrTmp3ZHFpN3BBVnVoKzdi?=
 =?utf-8?B?dWRCRTRrUkN4YUVmKy9TcGhRbm5UZDdTU0pNbjlyMHYrVUg5UXVJSW5FUDZ3?=
 =?utf-8?B?aGdGdy9Va3hQYmFPMU50ekNXdzVRQmFwZ3BMU2F0eUpYNE5rQ2J5Y2pvRVUw?=
 =?utf-8?B?aUlEbld1eTVmOVYyRDBLZC8vemd5S1dVeE44N2NYYzVvZENzdGVCOWgvZ2ha?=
 =?utf-8?B?Y3lmOFdPL1dQOVc1eTFHSjZBREkxaHBva0ZCaGtjRDE2c1l4RGFqR001REJC?=
 =?utf-8?B?bWlubXhqMVBrWEdySEJoMHJESWFaWm03dnBPWWZ1TUpxS21pTlNmSG9nMk9L?=
 =?utf-8?B?RUhycVczT3QzN2lCNVdzVk9WR09KN083ay9kcXQ4RnFBM1hONUE2NTUvb1pv?=
 =?utf-8?B?OTUzcDU4eGdhZkRHOTYzUGtLeGVtMkNYV1hIeFRSRVNjZ1JSZkF0QTlVeFF2?=
 =?utf-8?B?NDFGT1N0WnJMbVdOK2QzUnBTNkdmZ3dYZ25wa2JCY01SZ1NCVlVTUlRTc1Ji?=
 =?utf-8?B?WFM2NVdUMXRZNEtlWFZkRGdVM0IrcElnWUM1a1NaUHV4Y05oK2lZUzNtanps?=
 =?utf-8?B?S1NiSlM5cUlVWXMvUzNYSTJMdUJGS2VsL21teWt5eGZUL2V1aTVIVmtxR05O?=
 =?utf-8?B?RmNXZnhZS3JnM1lxZU5tb1JMN1J0S0JOWk1ZY0xueWpmaGJMV0F5aFFBaUx5?=
 =?utf-8?B?OUNFU3dpREV4djRtaEtxMUk1Yms3VE1VMEc0Z0x6RG5JM0ZnVkQ2MmNMNFNp?=
 =?utf-8?B?SUNKMXl3ZDFicGM3Kyt4VlEzb24zVEZqcDRFN0M4R081NTlqUE5jMEcyK1VW?=
 =?utf-8?B?Qjh5MWpwS3JRQXl6QStIaWpWU0hLRFVKZkc2U0NZT3J6OUZEVGswK0V2bGY2?=
 =?utf-8?B?YmFndlFwR2duWnA3S3VndGwyLy9YV1UwekdpeXgwNTlvTkxvNHNCVnNHRHVu?=
 =?utf-8?B?S00xeXd2MnB0ZjZJTjZUSmw1eXI4R1B1M1lmay9MbXY3eWMzRFNHUksyZzNx?=
 =?utf-8?B?RU42Y2hBRktuOVhMaG1SRXA4N0Y2T1FDbEpheFlHaC8wbThuejZXazE5elU1?=
 =?utf-8?B?Wlo3ZUhCVzlDdEUya1JlNlhuUzI0ZUM5ekM4bW1HTTdvd1MwY0NLaS9LZXJV?=
 =?utf-8?B?Ukh6clNvRmRtMnRreUhGcGpCd1VKVXNoS0JQUXUxTENpU2l3Y1M4dmFJd1BH?=
 =?utf-8?B?YUJHUHhUd3NlQ3c3SVBxNDFJV0RWZXI1ajhxUzlZK3M2RFBFaElCZFVHRmtW?=
 =?utf-8?B?VWpkK0UzSnF6L3VmN0FrRUozRUxpK3BLUVE0OFppSTE0bDBCY1krYVBVbDVN?=
 =?utf-8?B?SHZkK3I3R2xIMGdxazZ2eHR3aDJnc3diNjRpdVdvcGozZTkvZ0luRi9tbFBk?=
 =?utf-8?B?MVFJNVNMUXgyWndROXdRNldBWC9MclB0TGgvSkxselZVVkVZMFBIWDZBVUN3?=
 =?utf-8?B?b0VuWEIwUWpHUnRVUklqRHNuWnZ0R2Z4RmRSVTNFSDZQVmJuSFhsSmkzbmxo?=
 =?utf-8?B?SmhaT1JNTkxBZzRkQ1VDekJRNmd6VWp3WTZjZm5LczYvNFN5M2doK2d1VG81?=
 =?utf-8?B?WkNzNVgxYWwvMlJRVEd0a3VoSkcxM2dtM3lXeXo3YU9OVFZwSC8wbjRsb1NQ?=
 =?utf-8?B?U3dsYVl4RDBkS0ZWOWprSWZ2QlVsMUdHSlczYThKVkdJeEFXdnc2b0dpZ0NU?=
 =?utf-8?Q?9ynE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453dbd51-65ae-412a-52e3-08dc317a92a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 18:42:49.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDF8ZsS1vDGHiQ+mLNZa3YW39079w5Nlqi4p4vT//+k+uJvbnFZXlXXInwzrKEYQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFy
a3VzLkVsZnJpbmdAd2ViLmRlPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDE5LCAyMDI0IDk6
MjcgUE0NCj4gVG86IE5pa2xhcyBDYXNzZWwgPGNhc3NlbEBrZXJuZWwub3JnPjsgUGFuZGV5LCBS
YWRoZXkgU2h5YW0NCj4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IERhbWllbiBMZSBN
b2FsDQo+IDxkbGVtb2FsQGtlcm5lbC5vcmc+OyBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+
OyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IFBoaWxpcHAgWmFiZWwg
PHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBsaW51eC0NCj4gaWRlQHZnZXIua2VybmVsLm9yZzsg
a2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTEtNTCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzXSBhdGE6IGFoY2lfY2V2YTogZml4IGVycm9yIGhhbmRsaW5nIGZv
ciBYaWxpbnggR1QgUEhZDQo+IHN1cHBvcnQNCj4gDQo+ID4gPiBQbGF0Zm9ybSBjbG9jayBhbmQg
cGh5IGVycm9yIHJlc291cmNlcyBhcmUgbm90IGNsZWFuZWQgdXAgaW4gWGlsaW54IEdUDQo+IFBI
WQ0KPiA+ID4gZXJyb3IgcGF0aC4NCj4gPiA+DQo+ID4gPiBUbyBmaXggaW50cm9kdWNlIHRoZSBm
dW5jdGlvbiBjZXZhX2FoY2lfcGxhdGZvcm1fZW5hYmxlX3Jlc291cmNlcygpDQo+IOKApg0KPiA+
IEFwcGxpZWQ6DQo+ID4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvbGliYXRhL2xpbnV4LmdpdC9sb2cvP2g9Zm9yLQ0KPiA2LjgtZml4ZXMNCj4gDQo+
IFRoZSBlcnJvciBjb2RlIOKAnC1FSU5WQUzigJ0gd2FzIHNldCBiZWZvcmUgdGhlIHN0YXRlbWVu
dCDigJxnb3RvDQo+IGRpc2FibGVfcmVzb3VyY2Vz4oCdDQo+IG11bHRpcGxlIHRpbWVzIGluIHRo
ZSBhZGp1c3RlZCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZnVuY3Rpb24NCj4g4oCcY2V2YV9haGNp
X3Byb2Jl4oCdLg0KPiBJIHN1Z2dlc3QgdG8gYWRkIGEganVtcCB0YXJnZXQgc28gdGhhdCBhIGJp
dCBvZiBleGNlcHRpb24gaGFuZGxpbmcNCj4gY2FuIGJlIGJldHRlciByZXVzZWQgYXQgdGhlIGVu
ZCBvZiB0aGlzIGZ1bmN0aW9uLg0KPiANCj4gDQo+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8g
YXBwbHkgdGhlIGZvbGxvd2luZyBzY3JpcHQgZm9yIHRoZSBzZW1hbnRpYw0KPiBwYXRjaCBsYW5n
dWFnZSAoQ29jY2luZWxsZSBzb2Z0d2FyZSkgYWNjb3JkaW5nbHk/DQo+IA0KPiANCj4gQHJlcGxh
Y2VtZW50MUANCj4gaWRlbnRpZmllciByYzsNCj4gQEANCj4gIDwrLi4uDQo+ICBpZiAoLi4uKQ0K
PiAgew0KPiAgICAgLi4uIHdoZW4gIT0gcmMNCj4gLSAgIHJjID0gLUVJTlZBTDsNCj4gICAgIGdv
dG8NCj4gLSAgICAgICAgZGlzYWJsZV9yZXNvdXJjZXMNCj4gKyAgICAgICAgZV9pbnZhbA0KPiAg
ICAgOw0KPiAgfQ0KPiAgLi4uKz4NCj4gIHJldHVybiAwOw0KPiArDQo+ICtlX2ludmFsOg0KPiAr
cmMgPSAtRUlOVkFMOw0KPiAgZGlzYWJsZV9yZXNvdXJjZXM6DQo+ICBhaGNpX3BsYXRmb3JtX2Rp
c2FibGVfcmVzb3VyY2VzKGhwcml2KTsNCj4gDQo+IEByZXBsYWNlbWVudDIgZGlzYWJsZSBuZWdf
aWYsIGRyb3BfZWxzZUANCj4gaWRlbnRpZmllciByZXBsYWNlbWVudDEucmM7DQo+IHN0YXRlbWVu
dCBpczsNCj4gQEANCj4gIGlmICguLi4pDQo+ICAgICBpcw0KPiAgZWxzZQ0KPiAgew0KPiAgICAg
Li4uIHdoZW4gIT0gcmMNCj4gLSAgIHJjID0gLUVJTlZBTDsNCj4gICAgIGdvdG8NCj4gLSAgICAg
ICAgZGlzYWJsZV9yZXNvdXJjZXMNCj4gKyAgICAgICAgZV9pbnZhbA0KPiAgICAgOw0KPiAgfQ0K
PiANCj4gDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBIb3dldmVyLCB0YWtpbmcgYSBsb29r
IGF0IHRoZSBleGlzdGluZyBpbXBsZW1lbnRhdGlvbg0KaSB0aGluayB3ZSBzaG91bGQgcmV0dXJu
IGVycm9yIGNvZGUgKmFzIGlzICogZnJvbSBvZl9wcm9wZXJ0eV9yZWFkKCkgQVBJcy4NCmFuZCBn
ZXQgcmlkIG9mIHJjPS1FSU5WQUwgcmVhc3NpZ25tZW50IGl0c2VsZi4gDQoNCklmIGl0IHNvdW5k
cyBvaywgSSBjYW4gYWRkIGl0IHRvIG15IHRvLWRvIGxpc3QgYW5kIHNlbmQgb3V0IGEgcGF0Y2gu
DQoNClRoYW5rcywNClJhZGhleQ0K

