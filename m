Return-Path: <linux-kernel+bounces-55298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED784BA96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F3B1F2382B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3088C13474F;
	Tue,  6 Feb 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RAl411c7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6A134740
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235568; cv=fail; b=Aq4IxfeQnZI3hYuOL3j72ISjUbBepqhFYj2YBlZsZ3oiUK+GbI9iUMHvdDMR50nhgVoptO2xPFpfugrLgQaymi2mYcccCruVZx3xoFoSi3g915zCohMKRn3CqbNwH/rmw9Y/gMIic/odh5+d0EWrdM4yVonLVoCvdPFZPACGLqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235568; c=relaxed/simple;
	bh=U27oHMKTd0VmZl+3hbmtj1aCObkwZV8bCk4G4+ERasM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eU2KUhGAyTQscsKKt+boYLZ5+bplJqaF3eNHcXQ6iR4UjYVKhLVFM8MHLVekq8yxss2qCcc5ovLKdKHCflVbzzrhHU+OWWSRFtzaYJd0/upby38b0VqhlsoDSeTrYg0bu4xfnwomqHHTHDmsQxH4pD7+rY40N/9e22OfEwC5Z1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RAl411c7; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrvO3xzw+9G0Gobj1uw+X3S43AV1QDF2fyMEytDulbgHU7BGjVQLKkkABHAvUh7vZL5Zj+/zL5Ura0In0BRB2kjye2l9vpV4okDEduUJwtrh1NxTSSUEGNGI75+2jx9cu0aQqZRn2mMBDKwq6ZO+Idqha6/E2WfRArJhvIW/iqAmiC7jAnzl+keHJW/qXggisg35UxnR5rZngYzNDtajGYkakEjfDweFUonbSIdHkLY2ukUMlCyKMW1V52nzLe2wEo2o56wxlTEApKa5CEUppaPfETRUsB8X0eBPgYXNCVyzMaEPNoIwAROu/a6IjAbZaLqUN/JPUBu3wUdrFDK6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U27oHMKTd0VmZl+3hbmtj1aCObkwZV8bCk4G4+ERasM=;
 b=XLftow5oM8dWzagMl6fh+85sVYlQcC06Ko+SPs+Vo86BnnUSx9avfo6jmdWmA48//OMsQLUGUBVmoFBy4RPWVBEdT8qCOZiVlfIaEolddy4wD3ySdkn3BUwmwIyUzao5yaGkgUrGQrRH4tiCtXc6wWTy1qLPZISUG8P8u79BocAovM6zWt53PCx09y7xLSR9nnhsijOAmRTvLtS0woLai+be95s8s4BeoetlhQ4bp4dyuAn6LZiW2q6dSvDcNGfDCyvC/hMUZKdEqceOAK+IaJrxpa8XwLcwJOoxhw9PTckL6cEUwq6mIj43Ixx6kinxr8qJoZnH0BTiUWHTVLt/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U27oHMKTd0VmZl+3hbmtj1aCObkwZV8bCk4G4+ERasM=;
 b=RAl411c7q68VG4kV6rCY+aOHaswm3+xeJNmhVclrYVai1OrVlxgXvFRcHyzt77+Gf0SVItsG6PaVx0BbtF6oDOq14tbv1o0x1AjkRsCBieBgDMomiV4AIn9DMflG94IMcr2Iyyfl9N3tUno6wvbnez5NuflyZw57nIFBPPmg3eU=
Received: from PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 16:06:03 +0000
Received: from PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::ad61:6617:f44c:105b]) by PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::ad61:6617:f44c:105b%6]) with mapi id 15.20.7270.015; Tue, 6 Feb 2024
 16:06:03 +0000
From: "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "Pillai, Aurabindo"
	<Aurabindo.Pillai@amd.com>
CC: kernel test robot <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Li, Roman" <Roman.Li@amd.com>
Subject: RE:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12:
 warning: stack frame size (3368) exceeds limit (2048) in
 'dml_core_mode_support'
Thread-Topic:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12:
 warning: stack frame size (3368) exceeds limit (2048) in
 'dml_core_mode_support'
Thread-Index: AQHaG1WL8ysrg+jSAU+h9AUkufiOiLD9x8iAgAAt+0A=
Date: Tue, 6 Feb 2024 16:06:03 +0000
Message-ID:
 <PH7PR12MB583196EB28781C92A00970C1FB462@PH7PR12MB5831.namprd12.prod.outlook.com>
References: <202311200955.pmjdQEM1-lkp@intel.com>
 <a856cbeb-dd2e-436b-a7f2-74d3493df18e@intel.com>
In-Reply-To: <a856cbeb-dd2e-436b-a7f2-74d3493df18e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e23db06e-66e4-4964-99a2-a4338b22c2f4;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T16:04:51Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5831:EE_|LV3PR12MB9331:EE_
x-ms-office365-filtering-correlation-id: 7627f42e-39ab-48b7-cb55-08dc272d84a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jW2IY2EBCVRDSHcBCTR5gvgiRy7NRwvzHq/wl7F5Y4/eBq6GJIbyOYfrLomFkgrAg01BEMK/i0uq+zpi4l4IEuV8km0SxFGxsFYZZOKufHVZzCQqvvXhOG2i+g0UmdRi1yVNnUbSv0aaBRNkmhwjw9IHeTMLu/3R6O/bAaHESZNaeUQ24ESN1B8n8qZ+M7iHxb5JIaCxsW8245i8D6J+wEVdG+oGlUGRfH/ImdLI9d6qKI6kaOH2Tz9QcGEFvFucM7PQEJd4m9+U+tOQa5hYGfOsrG47Oy379VXBP8+gLw6D8BakSN6wj2XLRY+kSF0nZqY9LirKgnWnGdVSfcPJR8e86pwza+nn1NbZIYLo6LwK4wl3agPi0emjfH58uPtC0tqyYspWUd04wFWLu2wURr7S1gyrNYiJxbAAN8Yc7QT4IxByT+hmw+U9zHk1zAKIasjK0CHkoempzEEp0SW9BE+I9T8wT7e01tBU4s0NZdfO/d5vzRpjlDPVvU44pNYcy+Ps1qJt03IHB4Y6ALDmL/XXdY5TVnpLygd5enCOpnLcy3UjLWmMkdBF4KU/2rgM0X0IO4FnXsIjmxgdLdMVdNPw19/RFmRo7fSpNFUW3K5LYFiAGOPmq07fSQKCbLkyLCMQma5tR3os8NN/6LbAgQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5831.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(55016003)(38100700002)(41300700001)(2906002)(6506007)(7696005)(26005)(83380400001)(71200400001)(122000001)(53546011)(9686003)(64756008)(6636002)(316002)(76116006)(66476007)(54906003)(66446008)(66556008)(4326008)(966005)(38070700009)(478600001)(86362001)(33656002)(8936002)(5660300002)(8676002)(110136005)(66946007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eit5dnJTQ2diNUtuQWdEMUZYTm53OHJHd0F2Tk1Zdms1VVA2U2hxWTBqMXQx?=
 =?utf-8?B?b1JtK0dXYXhRVUZ0Wm0xSnVSaGxVSmZ0S0cxTVRZNXhwd3hxQm5Hdmh1eHF2?=
 =?utf-8?B?cTZxU0tMV0lVeHhuWklqRVZuTDV2bTRCZmQwWUU0ekJ5d01oSHROa0s0QVFj?=
 =?utf-8?B?U0hZM2V0OGEwbytMOXpaYWVBcEZLcFN4d3dzMHFnRXhveDNRZWdTVEZ4dDht?=
 =?utf-8?B?dTI3bWJiQzVyT3dLdEZ2OUloODcvVWFpN3BycjM5YllDcEpDWkh6NU5rcnp2?=
 =?utf-8?B?bXNFQWhWdGhjQlg3NUdETDR3NDIzamdaTkVlV3JrdGhSSmxFRnF1VFNiNXNm?=
 =?utf-8?B?UU9qeTc3amhFVlVDVG9WVkZueUFra2c0Q3VIOWdJa0p1ZWQxK29EQzkwSTdQ?=
 =?utf-8?B?ZHNubXl1c1g5K2NhalVWYnJ6RUFmam1nclIwWFFqV1BPdElSNjFsZDJ4aTRv?=
 =?utf-8?B?R25tRStaMDNZWStGVk5xNmR2bjA4eU1RQ3VINWQ4VCtMTXJsa3dYNTc0YlZP?=
 =?utf-8?B?dkpDUi9XVEQ4cCt1L1dnNWtVdXcyQ1pNUHVjbVM1dm9LVGF0dTY3N0N5V3By?=
 =?utf-8?B?dy91YVlnNkFDTElRQnNCS1pQb1dCRVRCYVpBUmpoRDRVZXhlYzREdmZteUpM?=
 =?utf-8?B?eWh1MlZpL3hERkhxUEdRMFdNa3JySUIrbCtuNGhMNUpzc05UbUwvTFFmZkFx?=
 =?utf-8?B?VTJ6clRSYmRXbzZIRlQ0eGJQcE5rRlh3dDQrYUtnTmxYRllkeHNRaXlENzdG?=
 =?utf-8?B?Mk9jd1BXOThWNFlVa1FDbk9rQ1JpMEt1OXd1b2NMZk8zaEJRaTRjbGlyb1g4?=
 =?utf-8?B?Vm11czVOQmFsL2I2UTRUNHFYaHZVMlFqSGFIK2pFV1JzaytMakxWa3FyNTg3?=
 =?utf-8?B?a09OWC8zZTZFWG9ocTl6TGxEZ1dmUUViOE9Ub21hUEtyMzNXV2JNTDlUNXo1?=
 =?utf-8?B?bmdhQVNFU0I4VS8zYlY4UFRWV3RlYTA1VEl4eDdEemZhY1ExNVVkc3d2cUNK?=
 =?utf-8?B?S3ZXREdXYTRWekR5cTF1RVRKaGhBNlU2L0MyNlVTVUJUSGppWnhKck1JVmhX?=
 =?utf-8?B?Mkg3NGtzelJKVGZJZDlveHBqV3ZpWXo4T3FKWTZwYmQrSUpuY2dueGd6RU1m?=
 =?utf-8?B?NVphU2lHazRPTWM2YnZxK2d5R05Yd2ZYZFhpK2s4cTdWc1pOWGdGT2RiMGRs?=
 =?utf-8?B?cHluN3JKUFpFRllxYVovYks4cVZOdVBLOFRFdXY5eFphV1cxU0FLdkJzL08y?=
 =?utf-8?B?ZWhnRGtuejFkektCL01XOU1FT01TZjBXeWE2TDcrUUg0SElVZ2x3WlFaRmhT?=
 =?utf-8?B?ZTcwUFYrMm9NdjNpdGhic1E3VnlpZGxqZ1VzRi9sVEJiYThINVROaTlQdHBx?=
 =?utf-8?B?YWV3ZnVKbHdJQ3NmaWdPMllFWVN1bUtFYmtqZjF2bnJJZi9IV1Jia3RuYy92?=
 =?utf-8?B?QU1kUkNjRFRpc3c2bENHc2UvUklXQmgvblFjcjlpWjVqcFVkc2FkZGNUaUxz?=
 =?utf-8?B?VUI3TTZBa21ndWtLaWpQTDNZdnY0UlhKRFZjZG9sOUE0c2N1SXJUblFxbXB0?=
 =?utf-8?B?d1FYY2hidXR0YURFd1lsWFU1MzVNTU9TUG16Zlp1WGFpSDhHS3Q3TlBVWmho?=
 =?utf-8?B?M1QzTUpUemVhVE83SWNaeVc4d0szM1dXcXlEbzU5TkxoMDNvVW0zclAzZ2Zr?=
 =?utf-8?B?UWxzNHgweGxZd2dabXFhaWtsdGszenU0ZFBjN3Y4NTVkb3BaMThvUXFtSFRR?=
 =?utf-8?B?Z1BPbm5GSnN3SE9QelMvdFlZTnl2NnVPdk90aVZ1TUZlcGlvREFxdXRIcjlt?=
 =?utf-8?B?YXdTMmVjYW8yL2tsckRPb0JQM0RQRUJmV013VnpubW15V0hZckFhUHVSWW54?=
 =?utf-8?B?WHF6Q3dmbGd4S2JZTWpZMnVLdnJtSDkrUncyZFVQc0tUYkkvOHd0MG5FdnFv?=
 =?utf-8?B?SHZ3anRtT0RQbllxWUNyRFFnbmVqRXYvZlJoTUh6WExGUGRkaUZ2VkE4Q2Nj?=
 =?utf-8?B?eEJqU1NQeC81WTBNMGJGMXFkQllhNlJwZnRVVVlKWmttWk8wakJNQXgwS000?=
 =?utf-8?B?cDNCVzdEbVFieUluWkd2SzZtY2hDTFd3LzlLbDBKMXJEOCtKZEpXUG1DNG0y?=
 =?utf-8?Q?/Vb0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5831.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7627f42e-39ab-48b7-cb55-08dc272d84a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 16:06:03.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cg930CPEJW1no7lxvuE5EbEfzU9w4DqDLtpXae07azwLdmUM7PVLJtD8pcP45mu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCisgSmF5LCB3aG8gaXMgbG9va2lu
ZyBpbnRvIHRoZSBpc3N1ZQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxl
eGFuZGVyIExvYmFraW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQpTZW50OiBUdWVz
ZGF5LCBGZWJydWFyeSA2LCAyMDI0IDg6MjAgQU0NClRvOiBaaHVvLCBMaWxsaWFuIDxRaW5ncWlu
Zy5aaHVvQGFtZC5jb20+DQpDYzoga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+OyBv
ZS1rYnVpbGQtYWxsQGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU2lxdWVp
cmEsIFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4u
TGlAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2RtbDIvZGlzcGxheV9tb2RlX2NvcmUuYzo2MTkzOjEyOiB3YXJuaW5nOiBzdGFj
ayBmcmFtZSBzaXplICgzMzY4KSBleGNlZWRzIGxpbWl0ICgyMDQ4KSBpbiAnZG1sX2NvcmVfbW9k
ZV9zdXBwb3J0Jw0KDQpGcm9tOiBLZXJuZWwgVGVzdCBSb2JvdCA8bGtwQGludGVsLmNvbT4NCkRh
dGU6IE1vbiwgMjAgTm92IDIwMjMgMTA6MDE6MjEgKzA4MDANCg0KPiB0cmVlOiAgIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dCBtYXN0ZXINCj4gaGVhZDogICAwMzcyNjZhNWY3MjM5ZWFkMTUzMDI2NmY3ZDdhZjE1M2QyYTg2
N2ZhDQo+IGNvbW1pdDogNzk2NmYzMTljNjZkOTQ2ODYyM2M2YTZhMDE3ZWNiYzBkZDc5YmU3NSBk
cm0vYW1kL2Rpc3BsYXk6IEludHJvZHVjZSBETUwyDQo+IGRhdGU6ICAgNiB3ZWVrcyBhZ28NCj4g
Y29uZmlnOiB4ODZfNjQtcmFuZGNvbmZpZy0xMjEtMjAyMzExMTkNCj4gKGh0dHBzOi8vZG93bmxv
YWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMTEyMC8yMDIzMTEyMDA5NTUucG1qZFFFTQ0K
PiAxLWxrcEBpbnRlbC5jb20vY29uZmlnKQ0KPiBjb21waWxlcjogY2xhbmcgdmVyc2lvbiAxNi4w
LjQNCj4gKGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC5naXQNCj4gYWU0MjE5
NmJjNDkzZmZlODc3YTdlM2RmZjhiZTMyMDM1ZGVhNGQwNykNCj4gcmVwcm9kdWNlICh0aGlzIGlz
IGEgVz0xIGJ1aWxkKToNCj4gKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2
ZS8yMDIzMTEyMC8yMDIzMTEyMDA5NTUucG1qZFFFTQ0KPiAxLWxrcEBpbnRlbC5jb20vcmVwcm9k
dWNlKQ0KPg0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1p
dCAoaS5lLiBub3QganVzdCBhIG5ldw0KPiB2ZXJzaW9uIG9mIHRoZSBzYW1lIHBhdGNoL2NvbW1p
dCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MNCj4gfCBSZXBvcnRlZC1ieToga2VybmVsIHRl
c3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IHwgQ2xvc2VzOg0KPiB8IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzExMjAwOTU1LnBtamRRRU0xLWxrcEBpbnRlDQo+
IHwgbC5jb20vDQo+DQo+IEFsbCB3YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0K
Pg0KPiAgICB3YXJuaW5nOiB1bmtub3duIHdhcm5pbmcgb3B0aW9uICctV3N0cmluZ29wLXRydW5j
YXRpb24nOyBkaWQgeW91IG1lYW4gJy1Xc3RyaW5nLWNvbmNhdGVuYXRpb24nPyBbLVd1bmtub3du
LXdhcm5pbmctb3B0aW9uXQ0KPiAgICB3YXJuaW5nOiB1bmtub3duIHdhcm5pbmcgb3B0aW9uICct
V3BhY2tlZC1ub3QtYWxpZ25lZCc7IGRpZCB5b3UNCj4gbWVhbiAnLVdwYWNrZWQtbm9uLXBvZCc/
IFstV3Vua25vd24td2FybmluZy1vcHRpb25dDQo+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vZGlzcGxheS9kYy9kbWwyL2Rpc3BsYXlfbW9kZV9jb3JlLmM6NjENCj4+PiA5MzoxMjog
d2FybmluZzogc3RhY2sgZnJhbWUgc2l6ZSAoMzM2OCkgZXhjZWVkcyBsaW1pdCAoMjA0OCkgaW4N
Cj4+PiAnZG1sX2NvcmVfbW9kZV9zdXBwb3J0JyBbLVdmcmFtZS1sYXJnZXItdGhhbl0NCj4gICAg
ZG1sX2Jvb2xfdCBkbWxfY29yZV9tb2RlX3N1cHBvcnQoc3RydWN0IGRpc3BsYXlfbW9kZV9saWJf
c3QNCj4gKm1vZGVfbGliKQ0KDQpQaW5nPyBUaGlzIHN0aWxsIGhhcHBlbnMgb24gdGhlIGxhdGVz
dCBSQyBhbmQgbGludXgtbmV4dCBvbiBMTFZNIDE5IGF0IGxlYXN0ICgtTzIpIGFuZCBicmVha3Mg
Q09ORklHX1dFUlJPUiBidWlsZHMuDQoNCj4gICAgICAgICAgICAgICBeDQo+ICAgIDIxODMvMzM2
OCAoNjQuODIlKSBzcGlsbHMsIDExODUvMzM2OCAoMzUuMTglKSB2YXJpYWJsZXMNCj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kbWwyL2Rpc3BsYXlfbW9kZV9j
b3JlLmM6ODI0MTo2OiB3YXJuaW5nOiBzdGFjayBmcmFtZSBzaXplICgyMjMyKSBleGNlZWRzIGxp
bWl0ICgyMDQ4KSBpbiAnZG1sX2NvcmVfbW9kZV9wcm9ncmFtbWluZycgWy1XZnJhbWUtbGFyZ2Vy
LXRoYW5dDQo+ICAgIHZvaWQgZG1sX2NvcmVfbW9kZV9wcm9ncmFtbWluZyhzdHJ1Y3QgZGlzcGxh
eV9tb2RlX2xpYl9zdCAqbW9kZV9saWIsIGNvbnN0IHN0cnVjdCBkbWxfY2xrX2NmZ19zdCAqY2xr
X2NmZykNCj4gICAgICAgICBeDQo+ICAgIDE0NDEvMjIzMiAoNjQuNTYlKSBzcGlsbHMsIDc5MS8y
MjMyICgzNS40NCUpIHZhcmlhYmxlcw0KPiAgICA0IHdhcm5pbmdzIGdlbmVyYXRlZC4NClRoYW5r
cywNCk9sZWsNCg==

