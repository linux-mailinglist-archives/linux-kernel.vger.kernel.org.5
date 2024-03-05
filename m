Return-Path: <linux-kernel+bounces-92619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310138722F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BF82876EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3B127B44;
	Tue,  5 Mar 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5ina4Lp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E618595F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653144; cv=fail; b=OwgElLXpiyQkLt6cTQr2yofi5WEV34vEYO6suFefrSNgBWd7UZrrRj3Jajqf9PHX1QuYk12pyyNM02e2t2NeDQXIyPWmi+F/oA0QjDHCRQ+2wjXWVDniyFwgex+Z8E38ZpZLB8knoFD9x6xMor30SQWCcBwQ4vqrT29Qe3DuX3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653144; c=relaxed/simple;
	bh=PHNDRHV5/FmQSdWDJ8tuQY3CU9MNamRat4NmvNkmZ6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dFTVjPjvIfIKne88Ev0pcPh1iKGnULzp/ZykrNl7IqswALs8IwkdnNSZJFAlbTaoyGRX9c0Qlh5FESwatntXha6xppjyntbu4Hi6LqZfPeHeZA+VKSTlbRO7nmKBVvmBiaU1tNJIExZSYONQoMX3laigF4zp6UWu8W2q47TYzC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5ina4Lp; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709653143; x=1741189143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PHNDRHV5/FmQSdWDJ8tuQY3CU9MNamRat4NmvNkmZ6c=;
  b=M5ina4Lp/eQsnR0U1lO+MNb1e4RgWIR6jglwej4asAg7qQbzGtk8ech1
   Tn0FgGNYQ3GLF8s3kfrG1HbOFWIRxN+WwnYxacw8poRK6jvYf+8Dce22I
   LT2HyQhWRr713FD+b9487QjIdWeXpxK5xI40AZ/zjs84ObGE/4K1EQY+F
   p6kwrMmcN231Uoc5iN8x+0OPgg9qF5MMJjSp1QTVUypl1FbnEfGB6Y4Fw
   wE8zckJpEp54S48i/F+P65mg7W2/5ZkuF+LuG+aMOco+rmjsvzI4Fqxi5
   Q8V2iUOddYv5WPhxzORpnbR9T+EpKWelgis0PvN06ByaAEZufkn7Slb8G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4337459"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4337459"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14078549"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 07:39:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 07:39:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 07:39:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 07:39:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 07:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbVdgrIPtUbJQFkerleeiVyq2M8ix+I0hzM1lW0QBhfNU5BrrC0lEjfFI/uDPqWDi+eAqgRCnRco16LU8i1UnePaCsXP5wAc19zYpWytcJeuo5zRyHefb1G3M+t81ews9ZXYzy2LoYtwQf1XJWpmdeicLOYvOxXHoi9gWgdLiMQW6JPtNSAcQZN9jGHEEaKdDq2XkClYteOAi/iDE8SFmIb5KS3Xot3BDeM7Wm+RnvJa2zgXM6/FEMt8jVHvjuJHQ4ZYNXwT07AcgyieMSLbH29WV7XK/GHkUvueKO2PO174WC4LpqfHnPKkcjMrv8YqF8IU0H6R2wROk0JoHD2cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHNDRHV5/FmQSdWDJ8tuQY3CU9MNamRat4NmvNkmZ6c=;
 b=EuTccdHuRzBjdpZuePvrThY4X0ock7LBi9ayuxN1PMrfQqj+MBsOZP5PoeaXfjW10UdAhc1mAIiCIBM7KVuUFEhr5T1P096vLXyY+V7oaGDsF6CFlddn/nRet3NfGulHpw2/uASqEyDFhmjyW89oRmNebZ1NSRStnKf4R96QFEmpBieGztDyDRfMp9l6YfKz470CZPDW8tVhwogBtcM2YG10hWh1TQMxMvUBF8eQcXG216xv2d+517IJHIy6QbFB8e7cR04RKz6/3FUqd1Nj9sno4KYWLMTdjkMblJlxwWFsQOULC/dvgyc9wSysNLYKZ7FlPWxGHaTVLa2WdI6cmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 15:38:58 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 15:38:58 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Topic: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Index: AQHaamc6S3UimQVv90Kct5lCKqBGwbEf+/WAgAAOAYCAAojygIAFGOOAgACeWICAAPHyAIAAEPgAgAAEnAA=
Date: Tue, 5 Mar 2024 15:38:58 +0000
Message-ID: <04cee1ad22cdb1d6a6a4a7482e4ebf7d28cd63e9.camel@intel.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
	 <20240228165709.82089-2-jose.souza@intel.com>
	 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
	 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
	 <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
	 <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
	 <zfrpz4vuhjwmilbqft5d4qh4s3gs3okzyxbsh4lc5rhzjy5ktx@xuu32mxhun4c>
	 <f7c2d3381e50dd9c5e9211461e0abe487f5059df.camel@intel.com>
	 <u4tngmdxcciblq327yi75fdfkadv3fomnopnpgbwkk7smh3knp@d2h7373q4msf>
In-Reply-To: <u4tngmdxcciblq327yi75fdfkadv3fomnopnpgbwkk7smh3knp@d2h7373q4msf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|MW5PR11MB5932:EE_
x-ms-office365-filtering-correlation-id: b5fe69a5-146d-4f5c-55d5-08dc3d2a5fb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BviS6SP+0nIdN2SC33JGxEQWzvJNu2gmWZzIesfArb4q5UWrCm4SOYFcHkw5i2T1jbkkUZanobp9WH7bP4BywRS5AM9kn/lbkPjKy30TcAyScXiq6/8yISmzRKq2U5pGStm3CF/gPJZV71m4z6syepm4WC/saaHMdomyF0DCRw4YZ8/J+SY08eCqt2bvsYCYRGTV9MKDfv2RDXGu04uDLNVdJdmhM4i4PUjeFVF9SEv/EhZHG1kidcmvmoqERTzNorl85A/P47qLRUC3fQiWH+Ho6y1dxrvbMdU7haW58Zv2IucLnLEnRoi5xsv4IKthN7oC5qeXVh27AUOAYFWA7kvBc/6QtupI0nL6MZjc3wrpg0UcrkuO7DuZpG1QUY1mp9qRlc6jdvV92UWE/d8JOaJlerd2cMzXuvdRcyk4E5BxSPUTkrno76qfnWttG+DIuvsh9J+4VtoD6gBcYbQpwPpvnsyfzRO7H0ppO14/vYmk7YPHL/Vd2u5zQZCUFgePJQhLtLBodae9wUsNkvMcKhnQu4TBsooPZTUQhLupuZKS5W6xT865p6O0zfXjqa+WL8srJ0t5g4vWMATBekBaAPM7cx6BejkaYvmc3xjRuaQ2noxLtWZA+U2e0N9DHam8JzzpFUzlEj7RijDPcN5yCmsLFp2yqgi80aIYHdvSr5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3hMcDBDbFk1L2NkNGhGSXI3bFdtWTE0OVpYc0tTK0xmOFZrWVF3U3dWVWV5?=
 =?utf-8?B?RldVRnRGV1g3MlQyalNRR3R6VEZRMEhnemgxMVhvZHVvdm9MYWlVK2lKQnpa?=
 =?utf-8?B?KzV2VkFlWlVIMDUyWVJmTnNCTkRmVHVnV1FrY2Q3eUdyM21lb0pwZmplL1p0?=
 =?utf-8?B?MU9WUkRZZS9wbGpacE5DSVU0TjhEMzFEUUJOWU04S2hSTFFDS3ZoQlN3Q2xO?=
 =?utf-8?B?WGlXVjAzTUFzdC9UWWVWN0tFc3hRekJ2U3JQOHhGT2pPYXpScnNDL3k0VGFi?=
 =?utf-8?B?TDVEd0JrUWMxaVJsTjdoM2JRdWlPdzBhZjBxa0VYeFB4Y2RJdjRLandydk41?=
 =?utf-8?B?cGhTNXpLREdld1VKMXB2Y2dqNjNoWjJmaS9GcS9BWnhsNVd4RUFwL3JSQ2hp?=
 =?utf-8?B?bmJCdUVtbmxEZWZnaEhVaGI1ZnFDTUh5WUtuaFU2OFBabC8rVkhIcG5CcFpY?=
 =?utf-8?B?dHJsU1J4LzRGVTVlTlBHc0pBejF4QnNMOE82ZVMxS3R0MXI2VEYwYm5KZWtu?=
 =?utf-8?B?QXFiRWVzS21vRXJ6SkNxNWNpTkkzSkIyUVc3QTNXNmJIalBPWm9xQm02cnpX?=
 =?utf-8?B?NHBOVmFwR3o4RnVEN0Jid01sZkVucUJXUlBsa1Bocmh5Q2tkdE1Jb0JzT2lI?=
 =?utf-8?B?UTJ1VG9YUEMxdmR0RzJMVjMybkN6R2lGbWNQUkozSDBONWFNVWdMd3pWUzNW?=
 =?utf-8?B?eUZqdVpoc0NMdmhNTDg1NGJ6U2oyREgvNndLOEl1YnRDdk9LOHBzaVZJOTFq?=
 =?utf-8?B?bFQwUDhERFFzT1AxZmF6MU94SzZBdGh0QVFucm5WWWR0UGpEeTVGMHFsSHMz?=
 =?utf-8?B?RGorOWVibzhwaEF2cHdRcnhoSVM0d0lwUVc4MllYOTc4OFBvaEJNUzBLdlV0?=
 =?utf-8?B?OFhYU3pSVTNNTWFGUEV1SnZPWXh2T0hHaDV4cXl5eExQN3FMeXRDZVVQNTlj?=
 =?utf-8?B?aHlpMjNxTzJIM2hPMk8rclYrWEhQSkc4a3d6aTVYa2ZkQjEwNENZVW56NkVS?=
 =?utf-8?B?NVloZzJyKzE1N2c1WEgyNTNvWFR5Rk9zSGs0ajRZcVZHZi9qSUF2R1FpOXNl?=
 =?utf-8?B?WHlXQUxabGFNVzBndS8vNUl1Um5RNSt1T2JNSEVHelJoL0t4bnR5ZndjeWxZ?=
 =?utf-8?B?dFhsdW1vSTE2N1BFeHFubTRWV1VKcXpDQzhodkl5WVV3QmFIKzlWNFJrZGta?=
 =?utf-8?B?YVBZN0ZDU0dsb2F2UDN2T1g0aEpqeGFucFQreGpGUkdrcXBaT20rbStuOVVs?=
 =?utf-8?B?dXlydEFJeDZaNXFLZWVvWHRGU0FrT2M5d1owcTR4VDZ6YVRlUUlldnN4alAz?=
 =?utf-8?B?dHpBS0RRcWtCR0NpRXN0dUdVbWNUVDEydStWRUpNQzI3K3prcjl1Y0pwQitt?=
 =?utf-8?B?TGlHUVY0MnZjdG4wSE5LUEhmcWNRUnlZb2pkRk51MGRtWm9QWXdUZnF4Y3Fu?=
 =?utf-8?B?TUdUTU1LMUhWUDNnTERNYTZvMUVMOTZyTE5hc0lMMFNIV3BTam5JNTQ5bzI2?=
 =?utf-8?B?NmtIa250WU02OUg1ZncwclBzOHU0U3hKTjdxdEhQdkpiOWJEUjRkN1JGenhz?=
 =?utf-8?B?K2NYNnVBbDlEWUtIdFFPcisyY3VMcmhTdXpXOXFSZmhkUmUvMG5WRUVWNGJa?=
 =?utf-8?B?NE9hWWtwdGx3Q1N5SG04ZThaVER0UjBSQjhPWmloWGt5dDFXS2t3UEU1VUo1?=
 =?utf-8?B?eExUSmtJeDlydG45emJMcTJIOWNkeFg5YjVkbUJLa1l1Nk9FWUM1TXdiNU9p?=
 =?utf-8?B?WlB1c29WdjlBY3pmcG5aU2F4ZnRqaEtRVFlsQmVHWXRmc3NXQTFEWllicHhx?=
 =?utf-8?B?U2VxTkRtTHUzQ3NlVEUwY20yKzBiOHJZYm13Vzl6cVJibEcvMmRBWWdFL0RR?=
 =?utf-8?B?dG1Zek9HL3hlOVZMbXlmZWcvMmtrZ3ZVNjJ4cFVLS0J2bldYZDFoR1l5a2xw?=
 =?utf-8?B?Nm9NVlBNb0FLQkhTWVlzdmpEUDY5T0hldXBuMHk4cnI4TUhjN0xBNkNXVlJi?=
 =?utf-8?B?c0ZDMUxVWitHODJ1ZXE1NWExL090TXZtNHlYcmlWN0xwLzZ5dFVqU1VlemZr?=
 =?utf-8?B?WjRMNm1HRDZvT2tjRk84VG1ucTE5ZHp4V09WVXp1dkJFcGZHQ0NJWkZLTkdK?=
 =?utf-8?B?ODVNeU0vTERaOFVKL1JGenNmeE55SE9RaTl6OG5qdFp1NFJicUdpMVVReEFM?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABC68F12ED84C44AA8451E71EDADCEA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fe69a5-146d-4f5c-55d5-08dc3d2a5fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 15:38:58.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7xJggGqI6Hz93mAAcgz43VYHDZK27JcYZGoe0FN5L9ykebzmSv39W3ZvCsNTkk76kWCflEX8C4WepSUc8+ugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDA5OjIyIC0wNjAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6
DQo+IE9uIFR1ZSwgTWFyIDA1LCAyMDI0IGF0IDAyOjIxOjQ1UE0gKzAwMDAsIEpvc2UgU291emEg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDE3OjU1IC0wNjAwLCBMdWNhcyBEZSBN
YXJjaGkgd3JvdGU6DQo+ID4gPiBPbiBNb24sIE1hciAwNCwgMjAyNCBhdCAwMjoyOTowM1BNICsw
MDAwLCBKb3NlIFNvdXphIHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIDIwMjQtMDMtMDEgYXQgMDk6
MzggKzAxMDAsIEpvaGFubmVzIEJlcmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBXZWQsIDIwMjQt
MDItMjggYXQgMTc6NTYgKzAwMDAsIFNvdXphLCBKb3NlIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiA+IEluIG15IG9waW5pb24sIHRoZSB0aW1lb3V0IHNob3VsZCBkZXBl
bmQgb24gdGhlIHR5cGUgb2YgZGV2aWNlIGRyaXZlci4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiBJbiB0aGUgY2FzZSBvZiBzZXJ2ZXItY2xhc3MgRXRoZXJuZXQgY2FyZHMsIHdo
ZXJlIGNvcnBvcmF0ZSB1c2VycyBhdXRvbWF0ZSBtb3N0IHRhc2tzLCBmaXZlIG1pbnV0ZXMgbWln
aHQgZXZlbiBiZSBjb25zaWRlcmVkIGV4Y2Vzc2l2ZS4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiBGb3Igb3VyIGNhc2UsIEdQVXMsIHVzZXJzIG1pZ2h0IGV4cGVyaWVuY2UgbWlu
b3IgZ2xpdGNoZXMgYW5kIG9ubHkgc2VhcmNoIGZvciB3aGF0IGhhcHBlbmVkIGFmdGVyIGZpbmlz
aGluZyB0aGVpciBjdXJyZW50IHRhc2sgKHdyaXRpbmcgYW4gZW1haWwsDQo+ID4gPiA+ID4gPiA+
ID4gZW5kaW5nIGEgZ2FtaW5nIG1hdGNoLCB3YXRjaGluZyBhIFlvdVR1YmUgdmlkZW8sIGV0Yy4p
Lg0KPiA+ID4gPiA+ID4gPiA+IElmIHRoZXkgbGFuZCBvbiBodHRwczovL2RybS5wYWdlcy5mcmVl
ZGVza3RvcC5vcmcvaW50ZWwtZG9jcy9ob3ctdG8tZmlsZS1pOTE1LWJ1Z3MuaHRtbCBvciB0aGUg
ZnV0dXJlIFhlIHZlcnNpb24gb2YgdGhhdCBwYWdlLCBmb2xsb3dpbmcgdGhlDQo+ID4gPiA+ID4g
PiA+ID4gaW5zdHJ1Y3Rpb25zIGFsb25lIG1heSB0YWtlIGluZXhwZXJpZW5jZWQgTGludXggdXNl
cnMgbW9yZSB0aGFuIGZpdmUgbWludXRlcy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhh
dCdzIGFsbCBub3Qgd3JvbmcsIGJ1dCBJIGRvbid0IHNlZSB3aHkgeW91IHdvdWxkbid0IGF1dG9t
YXRlIHRoaXMNCj4gPiA+ID4gPiA+IGV2ZW4gb24gZW5kIHVzZXIgbWFjaGluZXM/IEkgZmVlbCB5
b3UncmUgYm94aW5nIHRoZSBwcm9ibGVtIGluIGJ5DQo+ID4gPiA+ID4gPiB3YW50aW5nIHRvIHNv
bHZlIGl0IGVudGlyZWx5IGluIHRoZSBrZXJuZWw/DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgb3Ro
ZXIgcGFydCBvZiB0aGUgc3RhY2sgdGhhdCB3ZSBwcm92aWRlIGFyZSB0aGUgbGlicmFyaWVzIGlt
cGxlbWVudGluZyBWdWxrYW4gYW5kIE9wZW5HTCBBUElzLCBJIGRvbid0IHRoaW5rIHdlIGNvdWxk
IHNoaXAgc2NyaXB0cyB0aGF0IG5lZWRzDQo+ID4gPiA+IGVsZXZhdGVkIHByaXZpbGVnZXMgdG8g
cmVhZCBhbmQgc3RvcmUgY29yZWR1bXAuDQo+ID4gPiANCj4gPiA+IGl0J3Mgc3RpbGwgYSB2ZXJ5
IHZhbGlkIHBvaW50IHRob3VnaC4gV2h5IGFyZSB3ZSBkb2luZyB0aGlzIG9ubHkgb24NCj4gPiA+
IGtlcm5lbCBzaWRlIG9yIG1lc2Egc2lkZSByYXRoZXIgdGhhbiBkb2luZyBpdCBpbiB0aGUgcHJv
cGVyIHBsYWNlPyAgQXMNCj4gPiA+IEpvaGFubmVzIHNhaWQsIHRoaXMgY291bGQgdmVyeSB3ZWxs
IGJlIGF1dG9tYXRlZCB2aWEgdWRldiBydWxlcy4NCj4gPiA+IERpc3Ryb3MgYXV0b21hdGUgZ2V0
dGluZyB0aGUgY29yZWR1bXAgYWxyZWFkeSB3aXRoIHN5c3RlbWQtY29yZWR1bXAgYW5kDQo+ID4g
PiB0aGUgbGlrZS4gIFdoeSB3b3VsZG4ndCB3ZSBkbyBpdCBzaW1pbGFybHkgZm9yIEdQVT8gIEhh
bmRsaW5nIHRoaXMgYXQNCj4gPiA+IHRoZSBwcm9wZXIgcGxhY2UgeW91IGxlYXZlIHRoZSBwb2xp
Y3kgdGhlcmUgZm9yICJob3cgbG9uZyB0byByZXRhaW4gdGhlDQo+ID4gPiBsb2ciLCAibWF4aW11
bSBzaXplIiwgInJvdGF0aW9uIiwgZXRjLi4uLiBvdXRzaWRlIG9mIHRoZSBrZXJuZWwuDQo+ID4g
DQo+ID4gV2hlcmUgYW5kIGhvdyB3b3VsZCB0aGlzIHVkZXYgcnVsZXMgYmUgZGlzdHJpYnV0ZWQ/
DQo+IA0KPiBpdCBkZXBlbmRzIG9uIHdoZXJlIHlvdSBpbXBsZW1lbnQgc3VjaCBhIGxvZ2ljIHRv
IGNvbGxlY3QgZ3B1IGNvcmVkdW1wLg0KPiBJdCBtaWdodCBiZSBhIG5ldyBwcm9qZWN0LCBpdCBt
aWdodCBiZSBhIGRhZW1vbiBmcm9tIG1lc2EgaXRzZWxmLCBpdA0KPiBtaWdodCBiZSBleHRlbmRp
bmcgc3lzdGVtZC1jb3JlZHVtcC4gIFlvdXIgZGVjaXNpb24gb24gd2hlcmUgdG8NCj4gaW1wbGVt
ZW50IGl0IHdpbGwgaW5mbHVlbmNlIHdoYXQncyB0aGUgcmVhY2ggaXQgd2lsbCBoYXZlLg0KDQpE
b24ndCBtYWtlIHNlbnNlIHRvIGJlIGluIE1lc2EsIGNvbXB1dGUgYW5kIG1lZGlhIHN0YWNrcyBh
bHNvIG5lZWRzIGl0Lg0KDQo+IA0KPiA+IFRoZXJlIGlzIHBvcnRhYmxlIHdheSB0byBkbyB0aGF0
IGZvciBkaXN0cm9zIHRoYXQgZG9uJ3Qgc2hpcCB3aXRoIHN5c3RlbWQ/DQo+IA0KPiBJZiB5b3Ug
ZG8gaXQgaW4gb25lIHBsYWNlLCBwZW9wbGUgd2hvIGNhcmUgY2FuIHByb2JhYmx5IHJlcGxpY2F0
ZSB0bw0KPiBvdGhlciBlbnZpcm9ubWVudHMuDQoNCkJ1dCB0aGVuIHRoZSA1IG1pbiB0aW1lb3V0
IGlzIHN0aWxsIHByb2JsZW1hdGljLg0KDQpJbiBteSBvcGluaW9uIHdlIGNhbiBoYXZlIHRoaXMg
YXV0b21hdGlvbiwgbWFrZSBpdCBzdG9yZSBjb2RlZHVtcCBpbiBkaXNrLCBkbyB0aGUgZHVtcCBy
b3RhdGlvbi4uLiBidXQgYWxzbyBoYXZlIGEgMSBob3VyIHRpbWVvdXQuDQpUaGUgYXV0b21hdGlv
biBjYW4gd3JpdGUgIjAiIHRvIGRldmNvcmVkdW1wL2RhdGEgYW5kIGZyZWUgdGhlIGR1bXAgZnJv
bSBtZW1vcnkgZm9yIHRoZSBkaXN0cm9zIHRoYXQgc3VwcG9ydHMgdGhpcyBhdXRvbWF0aW9uLg0K
DQo+IA0KPiBMdWNhcyBEZSBNYXJjaGkNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IEZvciB0aGUg
cHVycG9zZXMgb2YgcmVwb3J0aW5nIGEgYnVnLCB3b3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gaW5z
dHJ1Y3QNCj4gPiA+IHVzZXJzIHRvIGdldCB0aGUgbG9nIHRoYXQgd2FzIHNhdmVkIHRvIGRpc2sg
c28gdGhleSBkb24ndCByaXNrIGxvc2luZw0KPiA+ID4gaXQ/IEkgdmlldyB0aGUgdGltZW91dCBt
b3JlIGFzIGEgInByb3RlY3Rpb24iIGZyb20gdGhlIGtlcm5lbCBzaWRlIHRvDQo+ID4gPiBub3Qg
d2FzdGUgbWVtb3J5IGlmIHRoZSBjb21wbGV0ZSBzdGFjayBpcyBub3QgaW4gcGxhY2UuIEl0IHNo
b3VkbG4ndA0KPiA+ID4gYmUgdmlld2VkIGFzIGEgdGltZW91dCBmb3IgaG93IGxvbmcgdGhlICp1
c2VyKiB3aWxsIHRha2UgdG8gZ2V0IHRoZSBsb2cNCj4gPiA+IGFuZCBjcmVhdGUgYnVnIHJlcG9y
dHMuDQo+ID4gPiANCj4gPiA+IEx1Y2FzIERlIE1hcmNoaQ0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSSBoYXZlIHNldCB0aGUgdGltZW91dCB0byBvbmUg
aG91ciBpbiB0aGUgWGUgZHJpdmVyLCBidXQgdGhpcyBjb3VsZCBpbmNyZWFzZSBpZiB3ZSBzdGFy
dCByZWNlaXZpbmcgdXNlciBjb21wbGFpbnRzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBB
dCBhbiBob3VyIG5vdywgcGVvcGxlIHdpbGwgcHJvYmFibHkgc3RhcnQgYXJndWluZyB0aGF0ICJp
bmRlZmluaXRlbHkiDQo+ID4gPiA+ID4gPiBpcyBhYm91dCByaWdodD8gQnV0IGF0IHRoYXQgcG9p
bnQgeW91J3JlIHByb2JhYmx5IGJhY2sgdG8gcGVyc2lzdGluZw0KPiA+ID4gPiA+ID4gdGhlbSBv
biBkaXNrIGFueXdheT8gT3IgbWF5YmUgZ2xpdGNoZXMgaGFwcGVuIGR1cmluZyBsb2dvdXQvc2h1
dGRvd24gLi4uDQo+ID4gPiA+IA0KPiA+ID4gPiBpOTE1IGRyaXZlciBkb24ndCB1c2UgY29yZWR1
bXAgYW5kIGl0IHBlcnNpc3QgdGhlIGVycm9yIGR1bXAgaW4gbWVtb3J5IHVudGlsIHVzZXIgZnJl
ZXMgaXQgb3IgcmVib290IGl0IGFuZCB3ZSBnb3Qgbm8gY29tcGxhaW5zLg0KPiA+ID4gPiANCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQW55d2F5LCBJIGRvbid0IHdhbnQgdG8gYmxvY2sgdGhp
cyBiZWNhdXNlIEkganVzdCBkb24ndCBjYXJlIGVub3VnaA0KPiA+ID4gPiA+ID4gYWJvdXQgaG93
IHlvdSBkbyB0aGluZ3MsIGJ1dCBJIHRoaW5rIHRoZSBrZXJuZWwgaXMgdGhlIHdyb25nIHBsYWNl
IHRvDQo+ID4gPiA+ID4gPiBzb2x2ZSB0aGlzIHByb2JsZW0uLi4gVGhlIGludGVudCBoZXJlIHdh
cyB0byBnaXZlIHNvbWUgdXNlcnNwYWNlIHRpbWUgdG8NCj4gPiA+ID4gPiA+IGdyYWIgaXQgKGFu
ZCB5ZXMgZm9yIHRoYXQgNSBtaW51dGVzIGlzIGFscmVhZHkgd2F5IHRvbyBsb25nKSwgbm90IHRo
ZQ0KPiA+ID4gPiA+ID4gdXNlcnMuIFRoYXQncyBhbHNvIHBhcnQgb2YgdGhlIHJlYXNvbiB3ZSBv
bmx5IGhvbGQgb24gdG8gYSBzaW5nbGUNCj4gPiA+ID4gPiA+IGluc3RhbmNlLCBzaW5jZSBJIGRp
ZG4ndCB3YW50IGl0IHRvIGtlZXAgY29uc3VtaW5nIG1vcmUgYW5kIG1vcmUgbWVtb3J5DQo+ID4g
PiA+ID4gPiBmb3IgaXQgaWYgaGFwcGVucyByZXBlYXRlZGx5Lg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiBva2F5IHNvIHdpbGwgbW92ZSBmb3J3YXJkIHdpdGggb3RoZXIgdmVyc2lv
biBhcHBseWluZyB5b3VyIHN1Z2dlc3Rpb24gdG8gbWFrZSBkZXZfY29yZWR1bXBtKCkgc3RhdGlj
IGlubGluZSBhbmQgbW92ZSB0byB0aGUgaGVhZGVyLg0KPiA+ID4gPiANCj4gPiA+ID4gdGhhbmsg
eW91IGZvciB0aGUgZmVlZGJhY2sNCj4gPiA+ID4gDQo+ID4gPiA+ID4gPiBqb2hhbm5lcw0KPiA+
ID4gPiANCj4gPiANCg0K

