Return-Path: <linux-kernel+bounces-29607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4988310B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081571C21F85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03862907;
	Thu, 18 Jan 2024 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lAn7lazG"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533A2573;
	Thu, 18 Jan 2024 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540076; cv=fail; b=OvoXQUfZq1kmZ3+yMd92x2UctRXLqVrArLVS6t/dF2w0umqGz42oSkFkdszQT3fXcLDHJ1/AkpwjhQnSQVBTc2RxDr/J630BxZr5wzdWRKfMT3BkcrJKH0vQlVbIBpt7LBiFhmKrfq+pLaRa7GxsWKHFvFsNVED+hgqVDiB7IbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540076; c=relaxed/simple;
	bh=nKNOnHOoZ3gHotlbuHWewfvsySQzw2dgJLTSIlVdEEU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=A1u87nSnpSk2hVTdfhUevytU9l+G3SIJkU0CV+7sT307QeJC9Gt6UpGp/sKFiqeuUkLIoYF2yo0EAYcdshqdi/Hix+ww4o287V1gga4vf/+G+8MTK4LCB+6xmhAnEfq/x5a8ivNj8DiNlO3y/FMgsmCNz0hMSHg2k8KgLJr73YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lAn7lazG; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDSfMz/L5AW7l476EhOCIJpJ909X4CUDNJ8Od8GnXRa00pyR0mDrFeeCT7mpusOjYzZi2yaVyBELyEwCeCqucEV5L3AW3VFf3318Y5YRsiNzlvz1L6mHiothDO4Xnz8NV3xoBUqEwRXAZqY4cL+nS9NDYGIowi86G3e1/HyB20F/qYt78HMblQX2ABNSbCThFy1jVc+wjKFJNL7DnkgBhvx8i2pM8FGAc2DDeKN86SNGNoj3I9+nt3bU4mTOMbZ3G3segkky68hb99o/ZHH+J7Pzu6tOz9OPNcezgxdA3pQ/PlHM749Q7vVe7pdF99ONDllBbR6sRNk/gz4fV6N9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKNOnHOoZ3gHotlbuHWewfvsySQzw2dgJLTSIlVdEEU=;
 b=dz3G4i+rvWZ67rLXtvbsqO4VO5pEkEo/LEYI1gchZfjSGV86I7CB4E5/hmtmJQ2Dw0+wWOf9WM0L+/GQq6m3VbqLKfMshFcim3/O412cKkKoZ861JWdOz1jtELm+2OsOaOFSSsKhSruphdkSq44z2aqWlP3Ka2ajrZPCiu9dR7E1UvqK22BWYy3iNyUeQijA4jZYn5P+AzbLdhlWs4LpqgD3Is0y8wKHIT5l0pElnfVr9B2CAX0hZU1uj490iFMbXJKRvgk298862hvTXzHEOHX1O/jmkiWna2EkF4Q6eCrjGJLFmPov/58XD0A54Sj0qYflU5dt3YYxtmfRdqFrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKNOnHOoZ3gHotlbuHWewfvsySQzw2dgJLTSIlVdEEU=;
 b=lAn7lazG/6cHGXIIjsCLITOG3l/G6eQIZW1x8UvOWkcSJGzxHOpmW41KHEZFVYYonW7uRdSlIZ/zclb2iZVre0JXPBgkKs1KLp0muzKpeuCZLZU9lx9ml7syP5sSVG3IYQYBmuABUFysIXfSRrW1yPxk/kfMK5QkNvtl2m4qM+M=
Received: from BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 01:07:51 +0000
Received: from BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::c1f6:9417:a257:d081]) by BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::c1f6:9417:a257:d081%2]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 01:07:51 +0000
From: "Cvetic, Dragan" <dragan.cvetic@amd.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Simek, Michal"
	<michal.simek@amd.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Topic: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Index: AQHaSGzRwVIu3nT0LkO/+HwAJ5YSSbDcjj8AgAAEYICAAAJQAIACKpJQ
Date: Thu, 18 Jan 2024 01:07:51 +0000
Message-ID:
 <BY5PR12MB424169DA98877B3D5A6CBC13E2712@BY5PR12MB4241.namprd12.prod.outlook.com>
References: <20240116111135.3059-1-dragan.cvetic@amd.com>
 <20240116111135.3059-2-dragan.cvetic@amd.com>
 <107e9496-8b2f-4de2-9396-945a7c822493@linaro.org>
 <7c76ac86-40d3-4c55-a0a8-0b83fe971bd0@amd.com>
 <f3d7d02e-dec3-4292-b00a-d90c8b614642@linaro.org>
In-Reply-To: <f3d7d02e-dec3-4292-b00a-d90c8b614642@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4241:EE_|PH7PR12MB5594:EE_
x-ms-office365-filtering-correlation-id: 4cc71f2a-067b-4947-dc67-08dc17c1e4b8
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TZb+3/HHU3QzJsrK7bbKmdSIpVXgZmLhGY8o+gItP6i1X3SOpq6fovbUyzpNfVAT40lEVJNzTeWHa+WSGSGVReZA/PF3lHAVMc0pCAA3zg+POaCnAfcLPUGWwqNJ+6cOtb7PD67jmpz2uZePJNaXlJGYR7AXTIy7NVdmaOHw7RTtHUQJ3g3joA6t9PFftghAAgT+OGagWJfCOpnKfsMJxpypPMwk78eB1pcoJ2ZUMqaY+p5uquqmWNGHu1cA0SgdNQ3RMI+U2tkfRGYITE/yGS0OpTs8wRHXkssOv3l6GQ9h4bK2T5eTML5JXpFzhC9+54RQzFgnbVHX5EZ+9ttbaAGMJs34lBhDN/ZwhB+jEOSUnt0vkduvPLdZsnLiHQMfV+ysMqi4Y0endDPnY7ML7GFO+q+D4GzeIZsUmtNztzkXAt7bVd/MOU8crL+TmAdZjzYaWnWgQm1//atN3btf+LQmA+QqmoOR+Q0DjiBL86/vbGfBqzldttcdseb4x/jK0v8yOWdPTGMxuJdc2vHp1iD/NUINYtaB/PPKU+aDmYnsuMElnY7em8yPxsD8lzS40CDEIknc8sD37prZ1u6VBloVC+dRd3hVggRx6owq9ziIY1rRHVqUIjOQtsL5i8z3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4241.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(122000001)(86362001)(38100700002)(55016003)(83380400001)(33656002)(26005)(38070700009)(921011)(966005)(66476007)(54906003)(5660300002)(66556008)(66946007)(76116006)(66446008)(4326008)(6506007)(8676002)(9686003)(53546011)(52536014)(2906002)(71200400001)(64756008)(8936002)(478600001)(110136005)(316002)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YllNb1VqQklnUTdnSVgwa2xPUDZJMXBvZDBRcTFLYU50dFFBS1diN2FieHlv?=
 =?utf-8?B?VWJsVkhpMTJKOHVkaUtHTnM2MnFZS2RJeDlrRWE4dnJTTWhZVVRhTytoM0F3?=
 =?utf-8?B?WktkQ0lUNmlXOXduVGFiU0svWDkwUEtZem5qNURmODJTb0NVdmF1a1JiTXFH?=
 =?utf-8?B?akx5R2xEZ0o1ZWlBbWJMTXljQ2pHZUI4S29XbTlkeUwzTE5Jd0VHNDdvbDU2?=
 =?utf-8?B?c0grNER4dWtvcEd0WWttdzdMWFo0bnBrZlRKa2ZOdzRnK294QXJSRmQyRU42?=
 =?utf-8?B?RktZb0FSNnF1YmJjMC9ENWMxRnJGaExaQTlXbnhjM3h2VjJKL2JNWDM3K3ZX?=
 =?utf-8?B?cU12NWRzTjFYMEI5SVpTdHRBUE9nd3pHL3BDR1ZxMWZtS0pPV2RIQkEvVEVr?=
 =?utf-8?B?SG5kL09NOFFoYWYwOWIxdUVMYzd2UER1aDZhd0xPdEpiblN3VzJLajNoVXh4?=
 =?utf-8?B?RjBwdkJBMndJMU9tVXljNFNvM25OaFZacGRpQUlweG9VbnZkQU92ZzJNM3ZG?=
 =?utf-8?B?MEh3bzB3dktFZkZ4bENkenBwNnByOGJBajMvQkxCRmtrTWV3eEVqbS9KaTNN?=
 =?utf-8?B?UmtHL0ZlVUt6cTRqWVArZ0ZmZjVSWUlnVi9LcENSZ3JkY3JYSkpsZ2FVSFlH?=
 =?utf-8?B?aHdQQkJybnk5dnQ0UmdHRHhYVldHM3ViMng4T1dGcFE4RGtFMXdyVU5NY0da?=
 =?utf-8?B?NXVpUkR4UXdrTzZoQlpPeXBoYUw5Yys4N0pIbWJFM1NxbG9VWHRiY1JLcmRp?=
 =?utf-8?B?ZzU5N3FZU3NFazNRSzBlekE4bnA3NFVzbjF3bG10dFBFcjhtTEZ3UUNKRkFG?=
 =?utf-8?B?QnNmdkNyTi9ydU56MHRWTWRYUUV0amlDblNoRTROS29PUnFvWnpMMThpWm9H?=
 =?utf-8?B?dmZUeUQzTWgyUjArVFFCV1F5c3ZtZWVzQlBlRW5OcFFnKzlGb1J0akxlWDBi?=
 =?utf-8?B?R2ZQTjRURWxvYnhqdFBIZGxRbGVXbzFlR0xhNUVrUU5TeVNkMXlWMHgxZmxW?=
 =?utf-8?B?Vk82M2JCUE54alNOeHFkanFXVWcweEF5N1ZpRkppcDZKcFBDQ1NvNU4xR0RY?=
 =?utf-8?B?VkJLcjBCVTNtKzZtVGoycWkxbkxZajF6U3JsVHJHcUx4N1JNejlrM09kbEpz?=
 =?utf-8?B?ZElJRXlOMUkxbXE1SXVDNE1lVSs1bFREcEtLOFRoMDJ3dFc1NWdrL0ZsWk1i?=
 =?utf-8?B?SVliTWRGbDRBcGNwTU0xdnFqU0JabGRqWmg5T1hqa2xzRlFXYmw1SVlkV3FO?=
 =?utf-8?B?a2VFaUF5Z3BUZWJBTCtnZGdRVUtLVlFyelJkbWkrbERhRWdQM2ZTdzNCM0ZJ?=
 =?utf-8?B?b0xaRjRkQUJUM1BoemdxK0ZGTkhSaWtnaDVvZEgzOUtTL1Zlalg0OVZWNVZq?=
 =?utf-8?B?OVZVMGRabDlHUkE5YU9tQktPbTA4ZEFIWnYybUdXRlkyNlRPU0FyVkh2ZFRN?=
 =?utf-8?B?dzd6aGd2QzRDdUxOYStrWmVENG0vQkhvTmdnUXU0NWl0VXBFdDVmQ1lVYXFk?=
 =?utf-8?B?U1dMQTZUQzZJb1R3ZmRubHkzWll6UHduekhwcFZzRnh3MjV4WjdDMW9ta2k4?=
 =?utf-8?B?T0RncEkvb2NiQVFTNUFKNlNOY1h3UndDU1ZHS1QxeDE5bk4xTHRYWXZETVRu?=
 =?utf-8?B?UTNTME1pSFh4RENFRDNVaDNacjlJZU9Ub2VLQ1pCREdycEkvS3QxOW91OFZO?=
 =?utf-8?B?NXdCZTBsR1BRbm9oOEE0MFIwRy9EYmFId0J3a2RUQmhZaC9udElCd0JNd3Vt?=
 =?utf-8?B?WjZCaDdTN0NnWkZ0WEJwbU5wOXdkM3pHZXpiVmtkb0FiQXd5bTBRd0Z6UFVR?=
 =?utf-8?B?SnhmN0xob2Q1cDVGUUNmTE5iR1pwNWxCbVNNRUVVa0FvNkswblNWTXVBb2xv?=
 =?utf-8?B?V252ZFRVeGM3NHFnVytkWFBudXZMOHA1a1B3TnhGYkgyc0o3SE9vMUxmSHBG?=
 =?utf-8?B?MWhPZWx6NEp0YmhWcE9NVkZ5NExjQlZyeDh2VWtsUVl0UmJYcTlFRkJieXBT?=
 =?utf-8?B?N3RCMkRqK3E1bzdPN3JHQ21hU0E2Y012OTN3eFdPVjhKdklJSyttZjNVdkxJ?=
 =?utf-8?B?OGNaeFRXS1NxNnNTMEdKRzF6eXIwR3lSUjcwY1c0UlVPL2NOaVlCV1hWalN5?=
 =?utf-8?Q?wFnA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4241.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc71f2a-067b-4947-dc67-08dc17c1e4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 01:07:51.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPEKsTc7LYAKFGeRGpIbjPmdFNLKMwHyfkRCYflTrdXMMiN2VtCc4rC2Xq61AIRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

SGkgS3J6eXN6dG9mDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50
OiBUdWVzZGF5LCBKYW51YXJ5IDE2LCAyMDI0IDM6NDUgUE0NCj4gVG86IFNpbWVrLCBNaWNoYWwg
PG1pY2hhbC5zaW1la0BhbWQuY29tPjsgQ3ZldGljLCBEcmFnYW4NCj4gPGRyYWdhbi5jdmV0aWNA
YW1kLmNvbT47IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiBt
aWNoYWwuc2ltZWtAeGlsaW54LmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
Z2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkdC1iaW5kaW5nczogbWlzYzogeGxueCxzZC1mZWM6IGNvbnZlcnQgYmluZGluZ3MgdG8NCj4g
eWFtbA0KPiANCj4gT24gMTYvMDEvMjAyNCAxNjozNiwgTWljaGFsIFNpbWVrIHdyb3RlOg0KPiA+
Pj4gKyAgY2xvY2stbmFtZXM6DQo+ID4+PiArICAgIGFkZGl0aW9uYWxJdGVtczogdHJ1ZQ0KPiA+
Pg0KPiA+PiBOb3BlDQo+ID4+DQo+ID4+PiArICAgIG1pbkl0ZW1zOiAyDQo+ID4+PiArICAgIG1h
eEl0ZW1zOiA4DQo+ID4+DQo+ID4+IE5vcGUNCj4gPj4NCj4gPj4+ICsgICAgaXRlbXM6DQo+ID4+
PiArICAgICAgLSBjb25zdDogY29yZV9jbGsNCj4gPj4+ICsgICAgICAtIGNvbnN0OiBzX2F4aV9h
Y2xrDQo+ID4+PiArICAgICAgLSBlbnVtOg0KPiA+Pj4gKyAgICAgICAgICAtIHNfYXhpc19jdHJs
X2FjbGsNCj4gPj4+ICsgICAgICAgICAgLSBzX2F4aXNfZGluX2FjbGsNCj4gPj4+ICsgICAgICAg
ICAgLSBtX2F4aXNfc3RhdHVzX2FjbGsNCj4gPj4+ICsgICAgICAgICAgLSBtX2F4aXNfZG91dF9h
Y2xrDQo+ID4+PiArICAgICAgICAgIC0gc19heGlzX2Rpbl93b3Jkc19hY2xrDQo+ID4+PiArICAg
ICAgICAgIC0gbV9heGlzX2RvdXRfd29yZHNfYWNsaw0KPiA+Pg0KPiA+PiBXaHkgb3JkZXIgaXMg
bm90IGVuZm9yY2VkPw0KPiA+DQo+ID4gTGV0IG1lIGNvbW1lbnQgdGhpcyBvbmUuIEJhc2VkIG9u
IG15IGRpc2N1c3Npb24gd2l0aCBEcmFnYW4gSVAgaXRzZWxmIGlzDQo+ID4gY29uZmlndXJhYmxl
IGFuZCBvbmx5IHRoZSBmaXJzdCB0d28gY2xvY2tzIGFyZSBpbiBhbGwgY29tYmluYXRpb25zLiBC
dXQgYmFzZWQNCj4gb24NCj4gPiBoaXMgZGVzY3JpcHRpb24gdGhhdCBsYXN0IDYgY2xvY2tzIGNh
biBiZSBwcmVzZW50IGluIHNvbWUgb2YgdGhlbS4NCj4gPiBJdCBtZWFucyBvcmRlciBpcyBub3Qg
cmVhbGx5IGZpeGVkIGFuZCBhbnkgY29tYmluYXRpb24gaXMgcG9zc2libGUuDQo+ID4gVGhhdCdz
IHdoeSBJIGhhdmUgc3VnZ2VzdGVkIGhpbSB0byB1c2UgdGhpcyBkZXNjcmlwdGlvbiBiZWNhdXNl
IEkgZGlkbid0IGZpbmQNCj4gPiBhbnkgYmV0dGVyIG9uZS4NCj4gPiBJIGFjdHVhbGx5IHRlc3Rl
ZCB0aGlzIHNjaGVtYSBoZXJlIGJ1dCBkaWRuJ3QgZ2V0IGEgZmVlZGJhY2sgb24gaXQgeWV0Lg0K
PiA+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvM2U4NjI0NGE4NDBhNDVjOTcwMjg5YmE2
ZDJmYTcwMGE3NGY1YjI1OS4xNzANCj4gNTA1MTIyMi5naXQubWljaGFsLnNpbWVrQGFtZC5jb20N
Cj4gPg0KPiA+IEl0IG1lYW5zIG5vdCBzdXJlIGFib3V0IG5vdCBkZWZpbmluZyBtYXhJdGVtcyBi
dXQgd2hlbiBJIGRvbid0IGRvIGl0IGl0IGlzDQo+IG5vdA0KPiA+IHBhc3NpbmcgZHRic19jaGVj
ay4NCj4gDQo+IA0KPiBUaGlzIHdvdWxkIGV4cGxhaW4gd2h5IHlvdSB3YW50IGFkZGl0aW9uYWxJ
dGVtczp0cnVlLCBidXQgaXQgc2hvdWxkIGJlDQo+IGFsc28gZXhwbGFpbmVkIGluIGNvbW1pdCBt
c2cuIE9sZCBjb2RlIGRpZCBub3QgaGF2ZSBzdWNoIHJlbGF4ZWQNCj4gc3RhdGVtZW50LCBhdCBs
ZWFzdCBub3QgZXhwbGljaXRseSB3cml0dGVuLCBhbmQgY29tbWl0IG1zZyBleHBsaWNpdGx5DQo+
IHNheXMgaXQgaXMgMS10by0xIGNvbnZlcnNpb24uDQoNCkFjY2VwdGVkLCBXaWxsIHVwZGF0ZSBj
b21taXQgbWVzc2FnZQ0KDQo+IA0KPiBBbnl3YXksIGN1cnJlbnQgc29sdXRpb24gd29uJ3Qgd29y
aywgYmVjYXVzZSBhZGRpdGlvbmFsIGl0ZW1zIGNhbiBiZQ0KPiBhbnl0aGluZy4gVHJ5IGl0LiBQ
dXQgYXMgZm91cnRoIGNsb2NrICJ5ZWxsb3dfZHVjayIgYW5kIHNlZSB3aGF0IGhhcHBlbnMuDQo+
IA0KPiBJIGRvbid0IGZpbmQgc3VjaCBuYW1lcyBhcyB1c2VmdWwgYW5kIG1heWJlIHRoZSBkcml2
ZXJzIHNob3VsZCBqdXN0IGdldA0KPiBieSBpbmRleC4gRXNwZWNpYWxseSB0aGF0IExpbnV4IGRy
aXZlciBkb2VzIG5vdCBjYXJlLiBJdCB3b3VsZCBiZSBhIEFCSQ0KPiBjaGFuZ2UsIHRob3VnaCwg
c28gdXAgdG8geW91Lg0KPiANCj4gSWYgeW91IHdhbnQgdG8ga2VlcCB0aGUgbmFtZXMsIHRoZW46
DQo+IDEuIExvb2sgYXQgc25wcyxkd21hYy55YW1sDQoNCkFjY2VwdGVkLCB3aWxsIGtlZXAgdGhl
IG5hbWVzIGFuZCB3aWxsIGFwcGx5IHNvbHV0aW9uIGZyb20gc25wcyxkd21hYy55YW1sLiANCg0K
UmVnYXJkcw0KRHJhZ2FuDQoNCg==

