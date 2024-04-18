Return-Path: <linux-kernel+bounces-149887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B28A976A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D71F235B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5A15CD62;
	Thu, 18 Apr 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hZuOB7EB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD98821;
	Thu, 18 Apr 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436327; cv=fail; b=gUkBOT8ZlDGKZ7PoKpCiEfBo/DWwl9hZ4jPEbCsLD+Y5yC+EouZr08aHd0KQAG/U087569/NVC8B7mbBhh7F/6e0q07WstsFA429+q3NPcuZYB2kHUBeC9iEPN0wk18Bc4TBMIrL0NYiV/yaMxEERDjZ3if7fL5D/himFN0qfjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436327; c=relaxed/simple;
	bh=HHO3qkqeOs7lkEwvVwdoZuYNlrtLAt0vbYdjdh4eK5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r7WBgy/buLgYoW0kXuYIzB2DaXQgELjTzE8RTGtxGppVm56XVv/OBAfNZowTkcoenzmMGynYxqN6AO26D8dEcs/2bZ9S4hwC2+hjzpkJXAfNSHCMO9SUQJQE4DuWEJjFU9m/CH+lX329PPmHIB+YVOy+yKRIykSIqz1URsGF5pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hZuOB7EB; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANB9H70RR2mV8Unq7ZfNXbHbwWsEu6Mk9lFccx2F08D3plJHEbTU7fwmq2RdhrmQceWnTl5C9jPVUgFkUdVJDBWdl2j5HQvTViPgTQTBP3dOH8hZUDJ6UGQNC8CvQoofkDRDe+QwGWePdPkiwcnu8aY+rzbYXsBiHLlj7IX7uubRtqGMUJVWl0nlOTKfQk0IyDFxo4bWf0O7KGgdAUV1xNO42xWDF8kHS+hIhNQS7GTgPbALx5ZGI6MMlI3Wf12jSEr/TwO3fWS+0HWFhJcf0V4+1a2JYaRVAazff1tU4m6Pu4m5FXSfnA4YJBERE/bCOFwdNxe5QLiWqveKqJX7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHO3qkqeOs7lkEwvVwdoZuYNlrtLAt0vbYdjdh4eK5k=;
 b=C4BFQUG1m5t14LtggNUbFCyjOIwkkUOJ2n6b0dY2GM/VvuBmwpDRvCUaubWLwr/lGiFMsJJGPVUKK9N3e8zdsJSvs/M89N/+kLxfNGOLBuJR6TbLfIQQjN/N5b+rSJT7d45uHbvNhGEvMSMt8Rj5MkcXhDAWUzBqoEy1r2C7yScPQCgU4nkoKNj2LtmZcTS8ogx2rXqzbYnxImpgL0rrPgDszWqu5zTP3ccysaJOzEULy8sXzUmMCv6JHlq1EYWYl2O89wn1MIDeRw7RjzYpZdWwNMCTDY/7XjojutcSYN0AgqOMDHiFfIDs8t3LE1yVnhT12ETdob7tMJfeiccf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHO3qkqeOs7lkEwvVwdoZuYNlrtLAt0vbYdjdh4eK5k=;
 b=hZuOB7EBrEifFOld1zCsG/MtMIe2YpWp5j+0c5s3rfuyAzIqRlZNKGQQgrFXuvJLYmmcKz4hdiHPok53PbzoK4WbK4wt8cBHurVwrPdzxMV7BWoOSCzdjW+N4v+F46WsRl9QvnjpgJh4C7C/+byrAr53k+zw3c6NlQUToVfgJQ/PAVYcvvycvI6e7AgctzDi0WtqqAxb3bKgDE3pqpcU/FaMnVEkh8D3StYrEUg7Zutldue6mZVN4+fA8iM/CC2wbVxoqF1bkUvI3WdL8yRROcBX4ETPvUF8h/kwSVuhx25fzhtyMgkVrKF5r23pd5Y2b1ssl5AW0ihvdliLi+nKgA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:31:59 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%7]) with mapi id 15.20.7452.050; Thu, 18 Apr 2024
 10:31:59 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "sdf@google.com" <sdf@google.com>,
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
Subject: RE: [PATCH net-next v3 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next v3 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHakKTxrH8sJv69rkiBCo6Aop8slrFtyQiAgAAMvXA=
Date: Thu, 18 Apr 2024 10:31:58 +0000
Message-ID:
 <DM6PR12MB4516620237E912F1A90B13AED80E2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240417085347.2836385-1-danieller@nvidia.com>
 <20240417085347.2836385-8-danieller@nvidia.com>
 <20240418094535.GB3974194@kernel.org>
In-Reply-To: <20240418094535.GB3974194@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB7738:EE_
x-ms-office365-filtering-correlation-id: cae00c3a-f8dc-4e5f-7209-08dc5f92c71a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Q4jYBYi8ZSz6ldTesDxxOLEdDafE10eyWw3AX94/yCOYG89TrD2C5KLE6i+5IJ3A2n/ISgf7ysJGuTAWHQs2FlCMGWGHTExLQjSTk9HmeHQPtctRydetZHZED/wgurKp80Z9PiUEknCdpKkpI4J9mbUCbgwakH+AnTH8sY5DP/HHemyESovKaRWW7kI05CNuE0HRhNDWDUZDftq6bG5caQrpEZcXjh+/Zb+auBUgmjP0d09mcbMqybo2p8xYQSPkdOau9bS7n7+06jty6P73LUk1A6yg7PmVzF3VxY7mcmoBZp2rUTwGxQjvK6q9rnxTi/YI1JOq0rTHKFPxrch8gFYyOBYm34191nzkj1a1GlMB3k/gLD6drfelOCJL1ijQgomxH/xlejhoi7+2WK6DjrVv2x5CE2V2bYj8W7FLCFrvY6V8g/PeU9J+W8/s42UPn9fhjyuZfuzC7ds1WOy4nkOfHDDYZRBS8Ht/nQg1MmgJf8irGRg4Og5XEX98/oePJBTGvrZskBAa7GZCiiOGQlQ7oFAxhJY2Kj7EKLDalXWljVvbeo6rUhwMoPRIFYr3wklIHQbFIrDHFLGg9YhFzxjo6dLnG81CQTH9W4W4vUXEMshMr/k3FBSprCpLCsLRvCOtycirC/LZN5SWYtaxB2MEUSS4CbD/S7V33MiBzOlhJe4Kn7MlDBWIEwLDRysPGbVsxUKrny7vIV4wXK11Kw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlRCeFU1cDM4Wm96Z0NXWHoway9hS3dsZVIvNGFpTGdmVmV5TGIxSDJSRWh3?=
 =?utf-8?B?dVVURzdJdFFER09za2VaMFdPWk9MYzJTV0c4MEJ5RE42R2J2c1VwRksxQVVD?=
 =?utf-8?B?MU1yaEJHZTFsMS9ZVFpPcm9BNGJpNk53aXFiUzlFem9Gb0EvRlhHdmhjelhk?=
 =?utf-8?B?YjVHQUw3a0NVdG0vRU41MVBjZjJremg5Vk43dmtWZkFNRVQ4dVZEc0JUUTYw?=
 =?utf-8?B?Q0R3ZzBYZWxiNm9CN3k4WlBOUDlpYy95bnJhTmZCaFhMcnFvZ1E4bmkwOStX?=
 =?utf-8?B?MUdvc2RIR215Ty9FL2VjSGtWRWo1SlVjVjNJTzVBQnpndzhQdzk5S0JMWTJs?=
 =?utf-8?B?dHlzN1FubkVqVHJYN2p4d3lFQkhRTkF6c0Z4dmx1VEhCOVBDVlo3UVVDVisx?=
 =?utf-8?B?UHhOeTZDZTB5T3FZNmEzc00yNUx0QStRcEY5ZmVSYnh2VGIzY2I2UldZNkFS?=
 =?utf-8?B?N2FWdmpBVjcrNWpBWk0zKzBvYUJhNUhFSExoV0kzY0dKbDYwRkZldFpnZlcy?=
 =?utf-8?B?UC9USVVBSGR5bHdwSVdmUThTb0VKS08vQ3cxdm4xT1I3MG9sbFFCOTJEU2ha?=
 =?utf-8?B?L0cvQjlaaUZ5VHlOck9LVUhNYW1UZVM4bEovNnNPZ3FVRFphYklqRjl5SFRV?=
 =?utf-8?B?UFlGNXlzUGlCcDhxL3NvYlloaGczalRTS215UG9MajFHdlpwMXNSeTAyZXFR?=
 =?utf-8?B?d0g2Tnk1eUFzRlpMWEUyWnczRmlzVlpyckpRaldFMkZ6aURiMXlnYXVWT2dW?=
 =?utf-8?B?b21wTXZEdUVycGtITmZ4bHZYdUFoSjBqd29Hc2VHS2hyY1I2RURLdzU3VzlI?=
 =?utf-8?B?ZHlkUjE0b212V2V1UnM5bjhBVW0xSnVGQnJMa2hNRUs5ZkJRZFYrKy9CL0Jm?=
 =?utf-8?B?RjZ3ZGkzL3pRaFYrRC9nMFRCRzFIbDNhdTVTMTl4VmRYSHQyUXJ2VWZ1SExI?=
 =?utf-8?B?SzZaZlJWZWNFY1BKZ3VUbDZzU3FUNHl6dlJoMnlkZlRIZUh2MDRGbVI1cTBO?=
 =?utf-8?B?NGtNN2Q4dEVDSG54aHBZVmdjbzhWRGNRTGpneDZNN254V2ErNnZmNm1oWklL?=
 =?utf-8?B?ajI1QW1uMDF1SnpqZFBqOGZNbkcycXFIam1xSnEwY3FGeExzdENlRUcwcFZR?=
 =?utf-8?B?eXk5ZERpVjk5Rkl5WXViY2UweDltOXdFRVU3bmsycGp3b3NUbyszSjVGWU9p?=
 =?utf-8?B?SFRxd1ZkMG1nTlNzSWgrRFIwc2F1YjczRkZVNWtEbVdjczVCWi85QnlnT3JK?=
 =?utf-8?B?SGt1T0dTdzYxQUtPYXRyOUFza0IveFNPUFZTS2lkK2gzejdRMnEwMTNLSnNO?=
 =?utf-8?B?aHdhWmpBNVgzdGJubVFwOTMxcXNtdzBqQThuekNKcFJucHFKamtvc2lhTWVD?=
 =?utf-8?B?WkVhSmpraEdTSjB3ZkFPbHVxSnBoUVZZMEJiMnh0d3RReG9JZ1RwWkU3V3I5?=
 =?utf-8?B?VWwrT0w1T0w0QjBRNXFWZUVsQ2VuV1EvQmhlQ3Z2cGx5YXBjaXdpR1l6V29r?=
 =?utf-8?B?SFk3S1QzWWVBdjNVY25RSmUyUWthbS9HWXo4K0h0MUw0UGVlbDdOOU82OXlL?=
 =?utf-8?B?dU9WaVdpRVJBK0cvWndRcUNteWVTY0p5Y2dUZG9HTCtmVUc1WXQ5YXI3TEhw?=
 =?utf-8?B?cVNCKzFwemYweFFFcUpzRkZTUGFpT1dvUmViazI4cWh2TzBSTzlISUI4OGVl?=
 =?utf-8?B?YVRlRHV4S3dxSGlqNm9KRm9pcTFleGdRd09jenFJZnlncWhDc1FxaFdmc3Iy?=
 =?utf-8?B?WUJybDI1OFg2eVBQQnI5a2phQ0FuVGZYdHduY0xkSkdMYTg5NlhqTUNCNGxV?=
 =?utf-8?B?b0dDN29ZQmhVMWRWaVh4R0tyT09ubnFkMUJ5SlRPNzFxS01GZk93d3d3ZXBh?=
 =?utf-8?B?RlgraHkxL3orUVNQQW1zdEJBc2tQYzRycW1rVDM4MHRrZnYwZE5SZE0yU2cw?=
 =?utf-8?B?Q1M0SkhjTitjZWdqNVRjMHhQZThxOGFHRUNYZ2FWSGNyYUhTTlZBSWJqRzVT?=
 =?utf-8?B?cmZyZEt0SXlDQjRKSTQxejVKUVJxd09hNHdEREVMYVEyZE9BQzFEeTBmaUs4?=
 =?utf-8?B?djdMTWUvemxPVnVDcDAvaEorYUpLeEZrVkZmMmxQK3dKclVBbnRDbUdkSHNW?=
 =?utf-8?Q?k/42s/914WBmSdsKqdvyx0Joi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cae00c3a-f8dc-4e5f-7209-08dc5f92c71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 10:31:58.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVQyxxrSFGzCCDOHKuHArDjviVvCWJ9FiCbB9DJLq45qnj5RyX4NkujzKjdJ1FnY05Ewd/cDotD1+f14jzLMMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCAxOCBBcHJpbCAyMDI0IDEyOjQ2DQo+IFRv
OiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsN
Cj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgY29yYmV0QGx3bi5uZXQ7DQo+
IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgc2RmQGdvb2dsZS5jb207IGtvcnkubWFpbmNlbnRAYm9v
dGxpbi5jb207DQo+IG1heGltZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tOyB2bGFkaW1pci5vbHRl
YW5AbnhwLmNvbTsNCj4gcHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbTsgYWhtZWQuemFraUBp
bnRlbC5jb207DQo+IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgc2hheWFnckBhbWF6b24uY29t
Ow0KPiBwYXVsLmdyZWVud2FsdEBpbnRlbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtbHhz
dyA8bWx4c3dAbnZpZGlhLmNvbT47IFBldHIgTWFjaGF0YQ0KPiA8cGV0cm1AbnZpZGlhLmNvbT47
IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
bmV0LW5leHQgdjMgMDcvMTBdIGV0aHRvb2w6IGNtaXNfY2RiOiBBZGQgYSBsYXllciBmb3INCj4g
c3VwcG9ydGluZyBDREIgY29tbWFuZHMNCj4gDQo+IE9uIFdlZCwgQXByIDE3LCAyMDI0IGF0IDEx
OjUzOjQ0QU0gKzAzMDAsIERhbmllbGxlIFJhdHNvbiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4g
PiArLyoqDQo+ID4gKyAqIHN0cnVjdCBldGh0b29sX2NtaXNfY2RiX2NtZF9hcmdzIC0gQ0RCIGNv
bW1hbmRzIGV4ZWN1dGlvbg0KPiA+ICthcmd1bWVudHMNCj4gPiArICogQHJlcTogQ0RCIGNvbW1h
bmQgZmllbGRzIGFzIGRlc2NyaWJlZCBpbiB0aGUgQ01JUyBzdGFuZGFyZC4NCj4gPiArICogQG1h
eF9kdXJhdGlvbjogTWF4aW11bSBkdXJhdGlvbiB0aW1lIGZvciBjb21tYW5kIGNvbXBsZXRpb24g
aW4NCj4gbXNlYy4NCj4gPiArICogQHJlYWRfd3JpdGVfbGVuX2V4dDogQWxsb3dhYmxlIGFkZGl0
aW9uYWwgbnVtYmVyIG9mIGJ5dGUgb2N0ZXRzIHRvDQo+IHRoZSBMUEwNCj4gPiArICoJCQlpbiBh
IFJFQUQgb3IgYSBXUklURSBjb21tYW5kcy4NCj4gPiArICogQHJwbF9leHBfbGVuOiBFeHBlY3Rl
ZCByZXBseSBsZW5ndGggaW4gYnl0ZXMuDQo+ID4gKyAqIEBmbGFnczogVmFsaWRhdGlvbiBmbGFn
cyBmb3IgQ0RCIGNvbW1hbmRzLg0KPiA+ICsgKi8NCj4gDQo+IEhpIERhbmllbGxlLA0KPiANCj4g
SSdtIGZpbmUgaWYgdGhpcyBnZXRzIGFkZHJlc3NlZCBhcyBhIGZvbGxvdy11cCwgYnV0IHRoZSBL
ZXJuZWwgZG9jIGFib3ZlIHNob3VsZA0KPiBpbmNsdWRlIGRvY3VtZW50YXRpb24gb2YgbXNsZWVw
X3ByZV9ycGwgYW5kIGVycl9tc2cuDQo+IA0KPiBGbGFnZ2VkIGJ5OiAuL3NjcmlwdHMva2VybmVs
LWRvYyAtV2FsbCAtbm9uZQ0KDQpIaSBTaW1vbiwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudC4N
CklsbCBzZW5kIGEgbmV3IHZlcnNpb24uDQoNCkRhbmllbGxlDQoNCj4gDQo+ID4gK3N0cnVjdCBl
dGh0b29sX2NtaXNfY2RiX2NtZF9hcmdzIHsNCj4gPiArCXN0cnVjdCBldGh0b29sX2NtaXNfY2Ri
X3JlcXVlc3QgcmVxOw0KPiA+ICsJdTE2CQkJCW1heF9kdXJhdGlvbjsNCj4gPiArCXU4CQkJCXJl
YWRfd3JpdGVfbGVuX2V4dDsNCj4gPiArCXU4CQkJCW1zbGVlcF9wcmVfcnBsOw0KPiA+ICsJdTgg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBycGxfZXhwX2xlbjsNCj4gPiArCXU4CQkJCWZs
YWdzOw0KPiA+ICsJY2hhcgkJCQkqZXJyX21zZzsNCj4gPiArfTsNCj4gDQo+IC4uLg0K

