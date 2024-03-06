Return-Path: <linux-kernel+bounces-93483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E387307C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2C41C2095F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A75CDC2;
	Wed,  6 Mar 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwyFDEoV"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D65CDE8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713072; cv=fail; b=gQ13jbOIHpYxUsIX03u4vzR2oc0Fx0/vNknUKRfzXHcK5voXjEggo4ifrCrZROdor4OrYIGMMBwrZ4TPJV4b4ec0sIljPvaK6vSs0z1apj4Xd5/f3LlqiptgAl7WJEBsrG+NGHXQNlq65qM/WUS01OcuYPnPk8+OHikwAg9lEnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713072; c=relaxed/simple;
	bh=kyjs/A6AnzbPXoRg9za3272ECehWoNml6Qhon0ib3jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJC0ecppOm07AU7PK4NLGc3hEUYBuj0pZCVGzBmQ5CUarb2l6GlBz8u1xzhVy5RVoyuXdpz31sMgwi/BfhrB/sgQbabHBynh/zzwmHzgdnE8asn0TfQ6rmWqsE13zZXT92OpHnLquLvNXP9skL0ZS9ojmrHdeMchtQkVafiMcco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwyFDEoV; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfIBrVf/chzUvzCd2R6weWZfDYJACPkJldmqftBa9NRnDiH8XOVUTaTbQLea85hC9fBL6USL5p33bo2MFDG3WdLUbQ0hqXbD4vOtrtBTg/B1zFPVvYjxKQMpZ/vnmh7CFVT7ZJy1Y76Bz4m5kseqs74OsMcGB8YQIrrdXrIMDPZM1gVd+0kCumLzJ5VHx/o64SCLtyDcBPTFk1MuaedJT88eWorR/Fu/7TJ9fsuhJx7mks1ecyX7+O4bna64Hvzg2RSYOIMelumlLXlgMRUOHtdHueexBMSAfLHz8434bpI1dmq8ofkxt1SVpX1iFXrvia+oC6ms52MkQZK0i992wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyjs/A6AnzbPXoRg9za3272ECehWoNml6Qhon0ib3jY=;
 b=T1WdjCtpKrARCZp66fBQxDNXccsYShiWm5D/dbc0JVWyEKCeYFrfOh8s8e5GfXCZwybOl8bqWVGFat+UA4ndrI7qTVRIeq5WfNHWGSwI+CRHL5xivYw2Qa5ks36XpUA7oyVRzsF4SRQ6b/XSOBV0dXMrJySLDeB8ywMFJOBzCP46szowayRaeaaj9s0QtiSgZNSokXLoKrGozmdDuPWABdCFvpntpqsz4IEyr68gzpi9Y7YdLqRZtSdCyDeidCswt4t+eqvS4vK/iAJywEEXTUdPSLlczH1vaPqfZMLJGPBq7Hw4TWSbutYGQqNVDvqoA2GhQ5Dsa+/EYBt3ESf+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyjs/A6AnzbPXoRg9za3272ECehWoNml6Qhon0ib3jY=;
 b=gwyFDEoVtGi4R00oixTl3hiT+Z1/0H2CJfsLblodhLYr6D4bedZIzsjca41OB/dLh3U9HKhlBSbuREPAqUk0AjSKRfyCydR3BxRY90sChGBG2N0lxBrUZV728ymvvxpdEkVxj4o1ilII09hxqUr+y8l4nbuQVQQ3xyf1NubKwI5dsdo4CAUd+SB99xoE8EUj2Ss9gXL91AmtLMj/n8t5dTaEVfuT0ZJhuFMjAT4Xv3zkcEZ3FTkJ6FsyZxrt+dnpAyoWr8FAss9+8jHKflp47nKRiqdW+hL3t9bTmLPVHFUQb0koTaxRVpNMjRlVlMXRijNMdwgTGqmPv/D5MBrF9g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 08:17:48 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 08:17:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] nvme-rdma: short-circuit reconnect retries
Thread-Topic: [PATCH v3 2/2] nvme-rdma: short-circuit reconnect retries
Thread-Index: AQHabtM+X+xWHxukWkSqizxpZgICXLEqXiMAgAABwAA=
Date: Wed, 6 Mar 2024 08:17:47 +0000
Message-ID: <c46e0284-6a19-4240-b41f-8455d663b1e4@nvidia.com>
References: <20240305080005.3638-1-dwagner@suse.de>
 <20240305080005.3638-3-dwagner@suse.de>
 <fdac5ec0-a2e6-4485-9b1e-af0d34e85e9d@nvidia.com>
In-Reply-To: <fdac5ec0-a2e6-4485-9b1e-af0d34e85e9d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB6900:EE_
x-ms-office365-filtering-correlation-id: 1d0c0b4f-9fe0-4cee-0ca6-08dc3db5e826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gLxAadYWrH7E4FS0PzXa5Wc+izxb/i41NBfjoO23fgURdLOzjqgt+udV6l48fSSdxIzRslxg2K1HqEU84pZQcERcxaAZIBjrcDRNjjK7QD49/HJ9eaqzUu+22wJ7SKuv4UupZZMK0KyvBooRMNw86Ft0NchyJtYJX5f9WF2GPgphsVVE1OVdRAxb6IuRorqtTKk/Zt3c+JoiW9KARYCYrEpQBIKvK4CPLNeqKnWz6s1SogqlHUVFyMNCFfc8jEB7MY0ZhvhfxuaVnIu4Tf/Qo8oKc/4EMs+uwmOFPJgsZ5WnJeJ6rxTwDNOfiWQ7RQ8Gh+ez3t2u7K0L9Sdeu2shu1xMoAZ2tVu+gay588UMp7pIcKh3ALf0ELZFxuwKDpuGe0qPN//VT76bko4J7Gqhwttia8kZ3kILog8p9l0y18n+/tTGEEZnjNWySYt4cvHTpIjwPUO6bG0DCqtrnEQTf96XBSUBylGIyujag4WVqbpKVY9dcSgLt50V3uwVrHbYLOKlg4jXdKixH/F4b9DZDdDr3BEsBWddzRrjde0pepJBSE4RSrsGaXawzlBTMqdyhw7XCRoZMkJLx37oW5eA8EUCIaPPOnyonH7W3oiTCz5fQMWQzGATncK9ryzB9/bU71s3vnvA59h2f5buj0OK8gdF6b7Yob6+NZhX3QDwEu0xkNjMxMe2Pt2LtoQwpAJKSRf/1XppS1fISbYASMD1ecjFnQhKKiqVYxfPXs1g0/M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1IwbU44OWFWR1VNTnFZVktYYVo3SzZvS1NMbDVnVVdvMFNtRnFDeWlJVkZm?=
 =?utf-8?B?dXJOZUl0eGFFNlpNbGFMWFdaRmN4ZFljczVsSTBSTlhJbldzYXhzRldYam5s?=
 =?utf-8?B?bE1qZzNwTlplL3ZmdnFFK1RXTnBkWTI3dUNBMDUrdUxMdjBwZnVMM1lONnlp?=
 =?utf-8?B?KzU3dC9QSW1PUnJrZ2wwSldSRFdtV3plKzg4cnBmQ0JHc1RUY241SEplYUNB?=
 =?utf-8?B?R254bXpDcGp5VXRiMTZGUVVwazFodUx5dUorKzVBYmZrRW0xSCt2UE4zcmxC?=
 =?utf-8?B?MDNkcUJjb0hTcHZNYXJ0VS93bHNtZTJrTTB6RVRsdThDWkpyUEFSejFBd2pN?=
 =?utf-8?B?ZGg0THRPU0J0ZDkrZ29QY3J6NjQ2NldBd3phWk12bXVnSnlOL2J3MmtUNkZK?=
 =?utf-8?B?QkZoOS9LeUR3alAxL2tEb1Frdm5Wd3hUblZ1VDdwVnZ5YmFMQTJiczhaRDJV?=
 =?utf-8?B?Ync3ZHFyL1pNSFhCVjU5NWQxamdkbUIyL2pxa2lqZGFCVkVkRktqZ2VRbEIr?=
 =?utf-8?B?cjJEOWYvNXYzaGdPS3RKY3Zld3VpUXYvTVZoVlpDK1NTUTF4ZXg2WEVINjc0?=
 =?utf-8?B?TUlFenVtMWtXZHNmZnVCVG5YeXJ0L1hPcEE1RXF4cHJVbVZOV2h3di9YcDVw?=
 =?utf-8?B?WDUra0ZWbk9WZzhqZHE1MHVqeW1TT2xLOVFFOEJuQ2hkU3VKazNlb0Q2T09U?=
 =?utf-8?B?UkhvUFBLOFN4QnZYdmU4N2dBaVhWTng0SFlhM3Jxc24vaGgzZElkWHF2L0F2?=
 =?utf-8?B?Q0FKeVowWG5pd2tobnZjM1dPVU1EVWVMWk43SDZuR0RTYjIxQ3R5NXYvMDcv?=
 =?utf-8?B?Y0V0TWNCc3g1TC9jemVyMlI5eGxyNGZoZnhnVUhEZG1wQXVSVStBQ21LaGdT?=
 =?utf-8?B?cnArSnp6dVkvZVVQd3Q3cXU3dmViNENBTDJuVHBscXByTEpZd1lqMm91dGVN?=
 =?utf-8?B?NHBZc0oyOG8ycTRmc3hiVVVteHEySHdLNG91OFlrdFI1WVgrUmd4V3FYTFpp?=
 =?utf-8?B?OUxMd1hYY3ZwU3FidHJWejRTT2padHlYdnVweHQ3V3VFckc0MnUvNS9XNjNp?=
 =?utf-8?B?aUwxT1BvdEE5a2IrQWdpQ0U5RUl4N1JiK3YxS25iRVlDc0pvYUF2OTFNclhG?=
 =?utf-8?B?TEc0Q1pqQTdjVXYwM2djYmVXNEhRK1hyV3ZRcEJJSGFLMDBtTnVCWXpNQlhY?=
 =?utf-8?B?T0RxVjRGbExxU2dIS1pzSmx6RjlKYUljUHBPektNK1lNaVpFZU90bnJQb3Mx?=
 =?utf-8?B?Q2FFbTRPRmZ2NEF6NkdwQmFjZEZDbjROaytDRUxFaVEwZXF3TzRvOTZISHp6?=
 =?utf-8?B?MlhsekdLejR3dTk1cStqUmxiS0JWWFJEeUkxaDgwOFNSMzEyMitYOEhZYnFX?=
 =?utf-8?B?bnNOZmh0WkU1L3RMSlg4aFFFejBQUEpVd3JqVU5kVTUvek1HcVVUUk5ueUxv?=
 =?utf-8?B?MGJDR2pDbkFwSEVrekVmQnYrNVRSUWc0cVFPWHQrVDdUMHZENm5tMXpMSlUy?=
 =?utf-8?B?MnpjS2RJaGJzSnpyVEw4Vm5sMWFoVUlrVFNXYXdSeWxjOE54UzU2Qmp6U0d0?=
 =?utf-8?B?cWsxcGZwQVh5dWFUVGhPVm5xOWxGbC9KMysybVZzcld0NWRSSEJITDRzUGFM?=
 =?utf-8?B?eHhuTldxTGlTRnpjSUhJckMwYURndnJyajJ6aGUwbjJjeXBaQlJ0aWg0S08y?=
 =?utf-8?B?WDJ1T1A3eFZvZnhLTFNoRUJySndFd28razh5SW5BY2x0MDNtWndPcEVGdjZi?=
 =?utf-8?B?VzBMQVE1dUxWRys5SCs0dnQySHRqdndhcWFma1BEV2ozZ2l0ZG4wSDZxMjZM?=
 =?utf-8?B?YVJwM0RCR1kxT2xhZHpjMkFCdmpNNXVGQkNCOU5BY3ZpamZQSzhZV2ZnVEdt?=
 =?utf-8?B?Q29mRmVjazFQSFN4NkxQZGVpWkEzZlhrQ3c1VVZidTlNOVdKcW9XQXdYc0xG?=
 =?utf-8?B?KzQybFhNY2Y0MDUxTklIUGFrOU1WNkorSDd6S1ZPbmthV09QdklFR3R4RHFh?=
 =?utf-8?B?MTJma2RMSi8xVEYwMjBtSFJFaG83Y1VvY2hpMTJDamZ6Uk5JdEhuaGU3L1li?=
 =?utf-8?B?bnR5bDdLSUJXTU9xZUFNNWptWmJqamVPMzBSWG4xNitpMnRFZU9Zd3MrREND?=
 =?utf-8?B?bGQrY1BlZzNCeWFIaXZwVXAzVnRkVW8zWGc5Nzl2Nm5zZzZQQWVySUpaV1dK?=
 =?utf-8?Q?wJdF+3tqgnQcBHifjgE5/C+mFDO/dRnPQtZMLNKfjs4+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7F3F612009DE845A1C26C983E85481C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c0b4f-9fe0-4cee-0ca6-08dc3db5e826
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 08:17:47.2653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiaVXp0ybghL8ho3rxkntWYvDJboQDINVXcEVGonuXUjLyNl01PJpLPX/3qG1pYKFhL0PWHG9OUrSPg52akvYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900

T24gMy82LzI0IDAwOjExLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IE9uIDMvNS8yNCAw
MDowMCwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4+IEZyb206IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPg0KPj4NCj4+IFJldHVybmluZyBhbiBudm1lIHN0YXR1cyBmcm9tIG52bWVfcmRt
YV9zZXR1cF9jdHJsKCkgaW5kaWNhdGVzDQo+PiB0aGF0IHRoZSBhc3NvY2lhdGlvbiB3YXMgZXN0
YWJsaXNoZWQgYW5kIHdlIGhhdmUgcmVjZWl2ZWQgYSBzdGF0dXMNCj4+IGZyb20gdGhlIGNvbnRy
b2xsZXI7IGNvbnNlcXVlbnRseSB3ZSBzaG91bGQgaG9ub3VyIHRoZSBETlIgYml0Lg0KPj4gSWYg
bm90IGFueSBmdXR1cmUgcmVjb25uZWN0IGF0dGVtcHRzIHdpbGwganVzdCByZXR1cm4gdGhlIHNh
bWUgZXJyb3IsIHNvDQo+PiB3ZSBjYW4gc2hvcnQtY2lyY3VpdCB0aGUgcmVjb25uZWN0IGF0dGVt
cHRzIGFuZCBmYWlsIHRoZSBjb25uZWN0aW9uDQo+PiBkaXJlY3RseS4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4+IFNpZ25lZC1vZmYtYnk6
IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4+IC0tLQ0KPj4NCj4gc2FtZSBoZXJl
LCBkbyB3ZSBuZWVkIGEgc2FtZSBmaXggZm9yIEZDIGFzIHdlbGwgPyBqdXN0IGN1cmlvdXMgLi4u
DQo+DQo+IExvb2tzIGdvb2QuDQo+DQo+IFJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KPg0KPiAtY2sNCj4NCg0KZmMgYWxyZWFkeSBoYW5kbGVzIEROUiBp
biBudm1lX2ZjX3JlY29ubmVjdF9vcl9kZWxldGUoKS4NCg0KLWNrDQoNCg0K

