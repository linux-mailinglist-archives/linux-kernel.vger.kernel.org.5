Return-Path: <linux-kernel+bounces-104446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4D87CE00
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0641F21F70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93760288CF;
	Fri, 15 Mar 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ezm8idau"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B628DA0;
	Fri, 15 Mar 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508727; cv=fail; b=Sm1mKbZ1MX/FroqpEsd0bG8ZYBP+2rj6MMF9YNC/vguYJxTaGitQ/kI6pjfjC3Sx9cb6Mw1bPgo1YttClKxl32CO3gDYndz5jvXnvW4XxoCDkrczetSKNV5sBOBuB5Tg5XVJ9AV5utrieYOAP30/+dQv6iSLr0BD5nG7wJJKsp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508727; c=relaxed/simple;
	bh=m6VlqEHyv6e3KydTFV9uDdZdy+m61OxlNEzik0YZE6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pP+97+TrjLX3klsCWa5piwbTwepnoAM8rd2LM58DOp157BOvUawE5XLPfEy/LqAcXNgDZmWWF/viZy+cBk7+toZpO0VUQTxLkUgP5OB8Ok2deqam4jQLisjTWQes3CyYGtVQiV9wNqqMt/s6eB9iI71GS6DJVknaC3WvBBELqWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ezm8idau; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqE/kvuWIA5I8/tpILgnfaNUr7HA01v1+uOHfiXnbgoBnAC61jbNyvayQRpjl/2ud8LKmpw/seB3XgdFj4/Lx9jBY8dFBdiIvAP5gFHdUvh8b8ARSjhb5snZaX1OCM9zx+JHcnQXG7R6YvQc1SDPP6YHXj7gpCHDuqnQDWMCXqSpVP9o4LPWAtdAR/vaDT2yHc/XKbH0ZZYZVKhRYJgMRlG4kCgoBfYHFAJM8/2O1it635YineUsoyNaqQ9ttfeIA6cxQG80rFolUywLxHj29Pvj1eDxq1I70X9yq/se7yXvU/mKmMK3abdIV8n2NLUH6BSvg2tCjUPqakSvZmvWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6VlqEHyv6e3KydTFV9uDdZdy+m61OxlNEzik0YZE6c=;
 b=PBslHJEnJhet8XZ/8A5MGO0HeajwdbwRDfjB+wUq6xH15r7kswqazXIrgq//fr29KyXO6hFMbjTuszGjSxincpBeEB6BiSF6+XdGwOWAO+d/2UFTTOGbuIZXjAf9iGFgbMrkn3NFveQr3NOwE0SBjjGGwGS9s5ibw6EMwTpHsTDTTHTYCTIvfv3dppkxc6A1/9Jk0Lqa3hj4VX3e/qNQbMb7GSupKggCZpZ9LvELt8x26DUSa/1x1nL6Y5y04tAPzPejxhVcpefWhLpvmY6YQalrTU7YxY5YbxNNhHT6HtS70P5AHAg9jCqpB0s+groNvIDUccNeqPmEx7zUfI5nHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6VlqEHyv6e3KydTFV9uDdZdy+m61OxlNEzik0YZE6c=;
 b=ezm8idauGlb1YM7VjX0M358GoPVyCTHmZ1pD9DCzqNKrNfq5ZjV5G/j6gMK5daSEbX5vDBRUxr3RZhk+YuE6UcCVymDj+xcqnxVqF+4E7ftiftSGX8lTyDATAYHm3tCHIl96FZKv6VJdGiuecg2RplmUiovXAMF1qTSkKtpuakU=
Received: from DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 13:18:42 +0000
Received: from DM6PR12MB4217.namprd12.prod.outlook.com
 ([fe80::65a1:c4cd:8643:b58c]) by DM6PR12MB4217.namprd12.prod.outlook.com
 ([fe80::65a1:c4cd:8643:b58c%5]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 13:18:42 +0000
From: "O'Griofa, Conall" <conall.ogriofa@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
	<jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Thread-Topic: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Thread-Index: AQHac9Ev4TnvwaW8Kky5a+tte9hg/rE3ZnUAgAAccICAAUgQIA==
Date: Fri, 15 Mar 2024 13:18:42 +0000
Message-ID:
 <DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
 <20240314154824.37150a54@jic23-huawei>
 <a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
In-Reply-To: <a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2c70b7ef-351b-4566-88ce-22eefc030e4c;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-15T13:04:21Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4217:EE_|DM4PR12MB7767:EE_
x-ms-office365-filtering-correlation-id: 88265397-2a1d-4f9c-ba45-08dc44f26f59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1uKdpI5AnS5V2EEjCgoc4zBcEt65OK0issErlk0CTQ/HQNTGy8b95x7R4uU08do0fB4wr6x+ZsxW22153oDzw/DC9JAYcLMc2Bw+DNmicvQg0I8Ztzy1CQLjCNk0+HVd6lVjfEwF/MfyhDl9F/u/hsvz1NlWYqSEfK7lGOGSmchLgfpUxeqYZOzfL1f/UNs6GT6jnjhxW1/REbJLueXyrESgAfVzpxVSeQS6BwYMVFyXnQFyISjdh80C3vk8VJArWkWrBVGM48pE7bjgPCzfNRM+zYkoEAcDaY6Gy8LgrA6AnPuxMmBY2Xx/krPyg4RYvYda8ktbFTirWJ31p/no1RySOjHG9ThkT/bcWIyAmk5D6GiKjypVR8LePZA6c7ax58SEtoApI7SUvZyAAiKkWcaWt5wqpkNryyvcTmGLTw1vyXK10ppiYj2gOP8KgVYQf336jbZK9QhiHWDPaqLA0LbGvzN6qKnnHgNhmW35uyexlgBgpKCWFxHhFR1SdKs6lNSttNQXK36Acnr321/Gw2+0maVdbaTynFKEd25AvkN9ZmdvUDTtLFYKizyoLseTt5WLbC8IpaNrHUgOlnVOmC6viJQjG1PQQks+209/RvFUCpmD+AdnBiSdq8LIc4urvX2F9oQC0NrPQYPqdK9PuhqRVUe/U4ZF4PiQQOQlcb4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4217.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmxyWDJEK0x3QUpqc1BwanBVNXJOcVNzRlZjeTNva0g2N2tDVWF5dHN4S0pu?=
 =?utf-8?B?cnFPWTlidkV4Y0I4MTRGYjF2dXNlQmU2Wit4MFQxRFRVL21pL3N2MUV2V1d1?=
 =?utf-8?B?WEI5Y1VkdG9tT3ZwekxoRWdIQkxCQkwvZTQrdnpTbFUwQXdrd2syZjNUSEVy?=
 =?utf-8?B?T3BleUgrdVNtKzRUNW5VVk9TMkFGeTgwOTFaSzJzMkROOTJ2THVxWEdOeHQ0?=
 =?utf-8?B?ZFg3MUxYYlFYRXAvcElST3FNb2c4UVVIR1BQcUlxYXd1VVdBV1BRMy9Qb2Vs?=
 =?utf-8?B?THE0b2JJaVRxbVgvRnBxV3JMTTYyUzdZd2lrSW1KMkdHczJKNXdBRmgrcm40?=
 =?utf-8?B?a3d6TVJMUlFKdkR1Q3VGNVR4ZlpHbjlTUmRmVWU2YTdsTCtHTW9hUUNYRkhl?=
 =?utf-8?B?TVhHRWtib2Y1SGw1OGhrRWY2aUVOcDBkTU5zZXg2RXR2ekZXMEdHMXRQL3ZQ?=
 =?utf-8?B?cUtManRqeU9SZVg0VTlUOWNkSHRVTzZGMXF3QjZEcjdxMjBLTXJ2dVJlS2F0?=
 =?utf-8?B?aENJTkNzZ3lmbUR3OS9UNm9QNkt3b3Z4a1hLZEdjQmZVYmowTlRXSWVUbHZx?=
 =?utf-8?B?L3VHak9SY1VhZUZzUitaUk1seDhuT1NpUW9ySFJrQyt6c0djTm80YnJqYW54?=
 =?utf-8?B?N0RMeHBDd0MzcksrWnF6UHpwVTRLVUlEblpNaGFERTlWczZoeUNzQnFDaTRt?=
 =?utf-8?B?cUorZzlJWHRaZGF2L2dHc2hOTkVMdXU2Vzcxa0h3YUJpdDBGTEVWdzlvZmxj?=
 =?utf-8?B?SllZR3o4TUFpSnFrVWdBY2h0SzM2WGtRQ2lWN2dzcDVLdll1VWlDNkNiQUto?=
 =?utf-8?B?YldvUFRkYjBVLy9JaURWMzk3TXBkWVc5TTFCVjNOSTF3aXJvcEMrQnBveUgx?=
 =?utf-8?B?VFRNSXVRUFdncFBZVlNLeEIrN0VRTEtUdHN3NS80bWtOVUJFM2U5NnJ3MklK?=
 =?utf-8?B?QnEzY3dPanVrT1FMU1VpS01tNXB2aGdNdWltcXY1alFlc3Nhayt5WWhpZmJH?=
 =?utf-8?B?WWZFQldDNHdPeFJENjFDdVZXSUlSSUlLQS9veG1UVU5mS2Q1ZEc1RE5SRzFR?=
 =?utf-8?B?ZTIrZGlNYWYzU0plb0VzcDBFdS9iQTMzejFPUHYrKzlWZTNtVGpXZlA0TGRQ?=
 =?utf-8?B?UDdDTXlQVktWcmh4YUFMV3AyODNDbkFBYzRCREo2SEwxN2xLNEMrU01zdFUr?=
 =?utf-8?B?UVhRb1kwZk9OYkVUWFgxZWIwNk5xTEFoQVNrUTFsQy9DWm9qTmVmRmh2c0s3?=
 =?utf-8?B?cy8vWVdIVkErQ0ZBbWVST05FUnVRMnZybDQyYWx0dlZ2TGlib0pNWThhbE0z?=
 =?utf-8?B?MUs2YzVIQWRRZktKSlR4bWxqZTF1YWlzNXR5aS8vV3l4UGhQdmFnZFRCVWdu?=
 =?utf-8?B?U2JoUmJnM3lYZXZKOU1NVk81VEZoWEVhbFljb2xKQnM4QlJCcWJIckg2THl4?=
 =?utf-8?B?SEM0dnpaZWJwTFJIZWxvdDJhTW02akZLMmJWZWlJa0tkNnVDSUY1VW00T0hY?=
 =?utf-8?B?YnIvY09XS3JOU1lMOVV2NzRXQUpXM2FGSmNhUlg3MVdNVFEwd3FXNTBENldJ?=
 =?utf-8?B?cDZrMHRSanBjYlZkZjNXMWtjZ2tFbDdpN1VyVE5kM3htcUQzRGs0KzNaV0FO?=
 =?utf-8?B?S09ERmNuZFFRZnFaaGNPL0dweVowRis1S0pydGlZSDRoUUJaNnJQTmtyM1BY?=
 =?utf-8?B?QjQzS2lQYUUrZFJxQ1FWN1Rjcy9XWUlsbFhMYzk1TzRFSHZ0MHB3ekIwa2py?=
 =?utf-8?B?Q2VxVGU4OW5vVTdMeUlpTms0d0dweXZ3Y3BXUWhoT3NPZzV3WDZ5TlFmVWdC?=
 =?utf-8?B?dmV3Ky9IQkdvbUJlTTVJaEdwNlo3MkNUeUFQeVROWGp6Qm1udVFFMjRmSHNN?=
 =?utf-8?B?aU0zdXlSOVR6OHZWdm5QWi84cUt6SDFKRUJoM1FJdEl3TzcyQmNJcVFhUXR6?=
 =?utf-8?B?cDdhRzkvcndzUEhGL3Fkalp6cmtrdkJjUEVtUmJQUCszNUgvNzZFLzF6eFoz?=
 =?utf-8?B?MnBLc0pKYU9BY0g4bzZBMTVYWkNoaVJVTE9sYXhDYVJpR1JzdXljRnN5UjVy?=
 =?utf-8?B?RFByclBOTGJqTmVFbUI2NUVHY0liRndDMjRBYmdjYWlBYnVpVnlxeEpoL3Rh?=
 =?utf-8?Q?Bwhw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4217.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88265397-2a1d-4f9c-ba45-08dc44f26f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 13:18:42.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPMxK6u2rj6der7/qh/lNEEdsdrF4JxbcTfrzRjFDhFh7crZqy5PGXOedadBUOn5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpLA0KDQpJIHRoaW5rIHRoZXJl
IHdhcyBhIGZpeCBmb3IgdGhpcyBpc3N1ZSBhcHBsaWVkIHRvIHRoZSB2ZXJzaW9uIHRoYXQgd2Fz
IHJ1bm5pbmcgb24gNS4xNSB0aGF0IGRpZG4ndCBzZWVtIHRvIG1ha2UgaXQgaW50byB0aGUgdXBz
dHJlYW0gZHJpdmVyLg0KUGxlYXNlIHNlZSBsaW5rIGZvciByZWZlcmVuY2UgaHR0cHM6Ly9naXRo
dWIuY29tL1hpbGlueC9saW51eC14bG54L2NvbW1pdC82MDg0MjY5NjFmMTZhYjE0OWIxYjY5OWYx
YzM1ZjdhZDI0NGMwNzIwDQoNCkkgdGhpbmsgYSBzaW1pbGFyIGZpeCB0byB0aGUgYWJvdmUgcGF0
Y2ggaXMgbWF5IGJlIGJlbmVmaWNpYWw/DQoNCkNoZWVycywNCkNvbmFsbC4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29u
QGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE0LCAyMDI0IDU6MzAgUE0NCj4g
VG86IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1paW9A
dmdlci5rZXJuZWwub3JnOyBPJ0dyaW9mYSwgQ29uYWxsIDxjb25hbGwub2dyaW9mYUBhbWQuY29t
PjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBMYXJzLVBldGVyDQo+IENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiB4aWxpbngtYW1zOiBEb24ndCBpbmNsdWRlIGFt
c19jdHJsX2NoYW5uZWxzIGluDQo+IHNjYW5fbWFzaw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9u
DQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+DQo+DQo+IE9uIDMvMTQvMjQgMTE6NDgsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+
ID4gT24gTW9uLCAxMSBNYXIgMjAyNCAxMjoyODowMCAtMDQwMA0KPiA+IFNlYW4gQW5kZXJzb24g
PHNlYW4uYW5kZXJzb25AbGludXguZGV2PiB3cm90ZToNCj4gPg0KPiA+PiBhbXNfZW5hYmxlX2No
YW5uZWxfc2VxdWVuY2UgY29uc3RydWN0cyBhICJzY2FuX21hc2siIGZvciBhbGwgdGhlIFBTDQo+
ID4+IGFuZCBQTCBjaGFubmVscy4gVGhpcyB3b3JrcyBvdXQgZmluZSwgc2luY2Ugc2Nhbl9pbmRl
eCBmb3IgdGhlc2UNCj4gPj4gY2hhbm5lbHMgaXMgbGVzcyB0aGFuIDY0LiBIb3dldmVyLCBpdCBh
bHNvIGluY2x1ZGVzIHRoZQ0KPiA+PiBhbXNfY3RybF9jaGFubmVscywgd2hlcmUgc2Nhbl9pbmRl
eCBpcyBncmVhdGVyIHRoYW4gNjQsIHRyaWdnZXJpbmcNCj4gPj4gdW5kZWZpbmVkIGJlaGF2aW9y
LiBTaW5jZSB3ZSBkb24ndCBuZWVkIHRoZXNlIGNoYW5uZWxzIGFueXdheSwganVzdA0KPiBleGNs
dWRlIHRoZW0uDQo+ID4+DQo+ID4+IEZpeGVzOiBkNWM3MDYyN2E3OTQgKCJpaW86IGFkYzogQWRk
IFhpbGlueCBBTVMgZHJpdmVyIikNCj4gPj4gU2lnbmVkLW9mZi1ieTogU2VhbiBBbmRlcnNvbiA8
c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+DQo+ID4NCj4gPiBIaSBTZWFuLA0KPiA+DQo+ID4gSSdk
IGlkZWFsbHkgbGlrZSB0byB1bmRlcnN0YW5kIHdoeSB3ZSBoYXZlIGNoYW5uZWxzIHdpdGggc3Vj
aCBsYXJnZQ0KPiA+IHNjYW4gaW5kZXhlcy4gIFRob3NlIHZhbHVlcyBzaG91bGQgb25seSBiZSB1
c2VkIGZvciBidWZmZXJlZCBjYXB0dXJlLg0KPiA+IEl0IGZlZWxzIGxpa2UgdGhleSBhcmUgYmVp
bmcgYWJ1c2VkIGhlcmUuICBDYW4gd2Ugc2V0IHRoZW0gdG8gLTENCj4gPiBpbnN0ZWFkIGFuZCBj
aGVjayBiYXNlZCBvbiB0aGF0Pw0KPiA+IEZvciBhIGNoYW5uZWwsIGEgc2NhbiBpbmRleCBvZiAt
MSBtZWFucyBpdCBjYW4ndCBiZSBjYXB0dXJlZCB2aWEgdGhlDQo+ID4gYnVmZmVyZWQgaW50ZXJm
YWNlcyBidXQgb25seSBhY2Nlc3NlZCB2aWEgc3lzZnMgcmVhZHMuDQo+ID4gSSB0aGluayB0aGF0
J3Mgd2hhdCB3ZSBoYXZlIGhlcmU/DQo+DQo+IEZyb20gd2hhdCBJIGNhbiB0ZWxsLCBub25lIG9m
IHRoZSBjaGFubmVscyBzdXBwb3J0IGJ1ZmZlcmVkIHJlYWRzLiBBbmQgd2UgY2FuJ3QNCj4gbmFp
zIh2ZWx5IGNvbnZlcnQgdGhlIHNjYW5faW5kZXggdG8gLTEsIHNpbmNlIHRoYXQgY2F1c2VzIHN5
c2ZzIG5hbWluZyBjb25mbGljdHMNCj4gKG5vdCB0byBtZW50aW9uIHRoZSBjb21wYXRpYmlsaXR5
IGJyZWFrKS4NCj4NCj4gPg0KPiA+IEkganVzdCBmZWVsIGxpa2UgaWYgd2UgbGVhdmUgdGhlc2Ug
YXMgdGhpbmdzIHN0YW5kLCB3ZSB3aWxsIGdldCBiaXR0ZW4NCj4gPiBieSBzaW1pbGFyIGJ1Z3Mg
aW4gdGhlIGZ1dHVyZS4gIEF0IGxlYXN0IHdpdGggLTEgaXQgc2hvdWxkIGJlIG9idmlvdXMgd2h5
IQ0KPg0KPiBUaGVyZSBhcmUganVzdCBhcyBsaWtlbHkgdG8gYmUgYnVncyBjb25mdXNpbmcgdGhl
IFBML1BTIHN1YmRldmljZXMuLi4NCj4NCj4gRldJVyBJIGhhZCBubyB0cm91YmxlIGlkZW50aWZ5
aW5nIHRoZSBjaGFubmVscyBpbnZvbHZlZCB3aXRoIHRoaXMgYnVnLg0KPg0KPiAtLVNlYW4NCj4N
Cj4gPiBKb25hdGhhbg0KPiA+DQo+ID4NCj4gPj4gLS0tDQo+ID4+DQo+ID4+ICBkcml2ZXJzL2lp
by9hZGMveGlsaW54LWFtcy5jIHwgOCArKysrKystLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMNCj4gPj4gYi9kcml2ZXJzL2lpby9hZGMveGlsaW54
LWFtcy5jIGluZGV4IGE1NTM5NmMxZjhiMi4uNGRlN2NlNTk4ZTRkDQo+ID4+IDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jDQo+ID4+ICsrKyBiL2RyaXZlcnMv
aWlvL2FkYy94aWxpbngtYW1zLmMNCj4gPj4gQEAgLTQxNCw4ICs0MTQsMTIgQEAgc3RhdGljIHZv
aWQgYW1zX2VuYWJsZV9jaGFubmVsX3NlcXVlbmNlKHN0cnVjdA0KPiA+PiBpaW9fZGV2ICppbmRp
b19kZXYpDQo+ID4+DQo+ID4+ICAgICAgLyogUnVuIGNhbGlicmF0aW9uIG9mIFBTICYgUEwgYXMg
cGFydCBvZiB0aGUgc2VxdWVuY2UgKi8NCj4gPj4gICAgICBzY2FuX21hc2sgPSBCSVQoMCkgfCBC
SVQoQU1TX1BTX1NFUV9NQVgpOw0KPiA+PiAtICAgIGZvciAoaSA9IDA7IGkgPCBpbmRpb19kZXYt
Pm51bV9jaGFubmVsczsgaSsrKQ0KPiA+PiAtICAgICAgICAgICAgc2Nhbl9tYXNrIHw9IEJJVF9V
TEwoaW5kaW9fZGV2LT5jaGFubmVsc1tpXS5zY2FuX2luZGV4KTsNCj4gPj4gKyAgICBmb3IgKGkg
PSAwOyBpIDwgaW5kaW9fZGV2LT5udW1fY2hhbm5lbHM7IGkrKykgew0KPiA+PiArICAgICAgICAg
ICAgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW4gPQ0KPiA+PiArICZpbmRpb19kZXYt
PmNoYW5uZWxzW2ldOw0KPiA+PiArDQo+ID4+ICsgICAgICAgICAgICBpZiAoY2hhbi0+c2Nhbl9p
bmRleCA8IEFNU19DVFJMX1NFUV9CQVNFKQ0KPiA+PiArICAgICAgICAgICAgICAgICAgICBzY2Fu
X21hc2sgfD0gQklUX1VMTChjaGFuLT5zY2FuX2luZGV4KTsNCj4gPj4gKyAgICB9DQo+ID4+DQo+
ID4+ICAgICAgaWYgKGFtcy0+cHNfYmFzZSkgew0KPiA+PiAgICAgICAgICAgICAgLyogcHV0IHN5
c21vbiBpbiBhIHNvZnQgcmVzZXQgdG8gY2hhbmdlIHRoZSBzZXF1ZW5jZSAqLw0KPiA+DQo=

