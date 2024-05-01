Return-Path: <linux-kernel+bounces-165021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3D8B86A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B261C22F76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A844EB2E;
	Wed,  1 May 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJ5oWxAV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576F26286;
	Wed,  1 May 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550289; cv=fail; b=r6cKjz1G8MAsVKOXezOzmdgfiLEou3hcCoYwFSV5FSieWXuW33xyfB/OJt/BQOshvcLn5fzhcb6HTaTeMPLJ5en0i9zUw3HvkRzW0/2UOX0isjjXDG8AShAffBJ2M9kljJ1+hJta1Vvmu6Qj4zMtEKKpy4JRVJ8ufl7GJgu0bgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550289; c=relaxed/simple;
	bh=zZ8NURTICyMo+P7Tnpa7X8ZTFzpYHJvWFahRH9tmWCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DU5+wvshaXjq3rfUwtzBGloIqRLjOyDL7pyLNG1EhXD1WSiepV0SkQcVnMAQHZhzweIltupnjtnopzOIEYDaODS1egBQmcohwWfX1y19moZyN7HTqyT4NkqcZKnokHSSpm7fre4LMeImHFZlKf1uxGKXTr/XIl+Mp177F6awP1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJ5oWxAV; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkfNC0rRVkSPNj2nlVVGFwJ9o6aFu/27PmYUpmeHWHmlJwzxM8sfuezph0YD1EP/Yr69t9hADvEGZMyXiUjXuKAxTPbQf23eWsy9XOHeQA1/2EHEMSB3AK2khs1lNby4KPle2KSJ2wq5UqNYJX10NniRbvLvAmJRW74pLzZ4eC7oFENdrP0Yt0ekvC3mBNromAwnn9AJlmVZD5iTiMI/L2Xp0aSp5+sTOU0mOnVjIwaoJqIbrPMHILvFCiTlbBy2X/o/et60ioNptQB9rakfXAUWFVQ5lTMWXTdP9ljoFraPVK5bSosGqnc+7Sdgt2rzY419IeZDIpQoGwMIqRFP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ8NURTICyMo+P7Tnpa7X8ZTFzpYHJvWFahRH9tmWCI=;
 b=m7/+Ct4t2bJ5oevNGFl4OqhQWJglDvbc1Xh7VB8ynlMSLfxRg7FPspaMaQv1GtWa95UJWu5/+o7EHgQRC1IFPOzMOuX4B34cvyLiQA2F3Q+cN7UTF/9ZQxXF5krUe7I6LDjo8IOm7rBgABp13W/nbMBMmKUz6dfW8chksh+1Kb+D/qP+OUsRRCWQiSDiRDP38MBvVzHYgeoNobdOFEgTlcgH8rSDlNLX2SnGWUaIE7Bu1InljGkpMLXjA9GaT+YayJ4UT8Qnq+6Ehbq5RdBS9OhPsXwqfYWRjLxPNW+5wiFpGuEN9ykD0sjqDAdD383sp9c4nrEkWu3EQ8An/oAZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ8NURTICyMo+P7Tnpa7X8ZTFzpYHJvWFahRH9tmWCI=;
 b=mJ5oWxAVjyFh4ozb+DQDYFgO6ATtCdRKQedhkTcFz8No4vXrys6G9P1Fm90voRozUtG9r6AiSw5JthrP7I64ZblJZ/L5UaWNmTC9bjJn0EFFvuQ4r2l6+edecvtXSviPkjhQqEKfCt4G/GOJKtjFYIrVwAOk8VKeshfe7ufnhGmKYQOc8zmfBv46ds/kN0ohtA44lMo0GI/valYHXlcdunzkeVzLckaCfGZMepReMFsdsAsJeNlPN/+a3O5rwN7Gk2wf0hcyh/h263pBszMWi1GGVu7SXgBOzBXu41038AApZN8xv99CgidQI+e4eGy9HArUdJo8yznrTeqAnBSqgw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.37; Wed, 1 May
 2024 07:58:04 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 07:58:04 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "almasrymina@google.com" <almasrymina@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Topic: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Index:
 AQHalmh2YwjSjfzzmU66VYtjn6H0WLF3q+gAgABPNgCAAKoVgIACipOAgAO0DACAAw65gIAAGJ6AgAACm4A=
Date: Wed, 1 May 2024 07:58:03 +0000
Message-ID: <35886d135459121fdf1e7cdec9d0f18801d99ddb.camel@nvidia.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	 <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	 <20240426160557.51de91f9@kernel.org>
	 <c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
	 <7a5a1d74040052afc8cc6cc5c2700fdf2e836b0c.camel@nvidia.com>
	 <CAHS8izOsFqiSiS4Z-E-jfD70aogNp5Bcyt7Rk8xFoR2TcDjz=g@mail.gmail.com>
In-Reply-To:
 <CAHS8izOsFqiSiS4Z-E-jfD70aogNp5Bcyt7Rk8xFoR2TcDjz=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MW3PR12MB4428:EE_
x-ms-office365-filtering-correlation-id: 61f2d8c9-1eae-40f8-db20-08dc69b46e01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cU5IYVJqM1U1bncxTGNjM1Z2RXljOU92aUpvdVBsNVhGcjVTam84TDdQN0p2?=
 =?utf-8?B?QnQ1N3RnbmVkN0xlV09XU2owMnltQ1RyVUdqcGF5aklKQVg5QndOVVpjVHpx?=
 =?utf-8?B?b3pHdmRTR2ZaNzl5WlVjWnlPRGNpWG1wYU9oc1h2WFduL3JCTVp0SWNHblpy?=
 =?utf-8?B?Ui9Ec2orem9SL2FiVzlKOEVYTTdCbllSSjRIM1hKU2JKbzd6cnV4R3NQRDhS?=
 =?utf-8?B?WTNTYkpyZ3ZTU1JIL0taalVyRzBmSkVBOEVVTTVuQUtIN2laUDJNdmt6empT?=
 =?utf-8?B?OThzYXU1M1lseGtCVU9iQUhMWlNPeWFSVjRweks5MGllNTJ4enNLS3hDS3Ay?=
 =?utf-8?B?Y0dBVkxaSE1ZamhkUzByWVBraklKRHBBekJMTys5Z2VIV05RckdBZlFpQWtH?=
 =?utf-8?B?STJLaWV6OVpPaTBUdjVaY3p0Uk5iNWpVZm5TMEtxNkV0Z1d4U3NiaCtZblRO?=
 =?utf-8?B?QTBKaWtLdWMvZkxkTHZKaDRmT2VrdkV3UDNiT01PclhNSHBlclZZQjZTN2I4?=
 =?utf-8?B?TllDQUhrN2ZOSG5wNE9ORzk2QjdIOWJ2bit0M3d6SnlEOWE4MGhhVVlEVUVy?=
 =?utf-8?B?TkZ6cjUvbURpclJRZnpHMEtIYmUrMUR6UHdLVHZzTEp4bXZSVmh1QkJSbFVu?=
 =?utf-8?B?VzdkSVBpbVhVa0FKMCtLUFkzZHJyOVpaZ0cxdnQ5UW9kNkplNkFzc1VXS1F5?=
 =?utf-8?B?SmRidnU1Mmo2QmtaaVlmWHErTTJmQU1JdTBDY3ZzUVVjNXZHM3lvNDBGTHRx?=
 =?utf-8?B?REZqQytraVNNSExHMjNRR0pEZGdrclJRK2VyanlEb1VZTm1CbjN6WkRQUGc2?=
 =?utf-8?B?a0JhY3JhVzJWanBJYUdJTktLRTJ4QkFDRWhGbFdNMDVhamdnODVWTjIrMUE0?=
 =?utf-8?B?N0lCY2dleGtuVkpYTmdIN2J1LzRnVnd3RGpUOGQxeElzb2Fha05oZFltQjZX?=
 =?utf-8?B?YW1DWHpXYlJXRTYvZ0xycDc2TzNVZnRGeVdyWUovQ28ybXUrdWg5Z3lOZ1Rm?=
 =?utf-8?B?QWdoWFNYTTR5ZVU4czFQajFjd3RXUVFDSGtMNmp4aURBcGkyZnpncDRnSVo3?=
 =?utf-8?B?ZFQydGlWUlBHYWs1YlBCa0daVUdjRmdvbjhSb1J4OGkyNE5pdWNaU1lqSXh6?=
 =?utf-8?B?a29SKy9mR3RFcVBVRkhUdHpXYWZvVGtVaHlORzRWNUtQRkhudU5rK0x0bGsx?=
 =?utf-8?B?Z0txYzdTZVlxalFZdDMxSktGcDBsa0h6V2Y1Z093Y2pvTXRXbmxyaXR6Q0ZK?=
 =?utf-8?B?VUlxWkdTMFlmbWZ2ZFdVeElSSVZCbEk5QjE1RWN6bERpSVltbDE5WnVrVlcy?=
 =?utf-8?B?YUswZDVqTzVNNXZmb05adVJBeXZOT1ZJUC95Vk9YU2R5dVVKbW96N2ozT1Qv?=
 =?utf-8?B?QmZDRmpVSjF0OWNRWHBHNko0empiSW1FOXliSVIrUVNBeXVqQzlpNi9hTFJ2?=
 =?utf-8?B?VTBLTDVDdUF5Y0NGVnRKWlBhbWZ3eFlpd3l5TUJXUHRCTFNYUEpsZThWeWRE?=
 =?utf-8?B?VkdSZEI5dEhGU0pKR3VhVVdOYXN4UGJyNmxtZ1NyUlI1NTRGQjVHbE5XeDhB?=
 =?utf-8?B?dE5mcEk3NWxUSGJmMkdxS1FwM0ZoQytWQWs4S0VQaHlXb1JqQnNySkpSTEZO?=
 =?utf-8?B?SWljZWdpOElIb1JOSnhNQkxlNU85ZW9kL1pLNndzWWgzOVg0RDhJeFk5eDE3?=
 =?utf-8?B?ZTEvSFBsRGdaWU1tUzJRcERJYmFCL0Z4RHBleHVoMGhRN3dJUllTR1E2bXYz?=
 =?utf-8?B?YWNOcUVTUEpKRUpvazZGNFVOaFh2MVlxUFlKcWhSUVRVdzNIYS9NMjh5Njdv?=
 =?utf-8?B?QTBYalZwbUVsZlJ4Vkh2UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU9wY1FOVEg2Qkp5VjVyS3c2ak5wbWcrNlllVkhqZjQ1TG9YckxmbEdidHB2?=
 =?utf-8?B?YThiNWFLTW9DTTNTNys4SkFJM09JdGJjMzBjRzYwc2FzMFV5Wi85RHh6Qzcr?=
 =?utf-8?B?WDMwK2Y1aTBGb1phWFNvNzFuL2RnSHNDbHBVNUx6S0w3bm5HYmJkamt0ZDFy?=
 =?utf-8?B?cDRsWm5iWlhESU4vUWxvOVdPOGE5b214cEFEL1orRG1kdWF0cS9nbDVrd3Ru?=
 =?utf-8?B?UTBJamsrVVQ3U0toRk9zbU10Y1RSUHhPMnVEVHI4MStLcmFnTFZWV2NWTXJP?=
 =?utf-8?B?QTM3ckh4U2VqRTFFdjNDU0hLb0toOS9DVXhUelF3QkczbzEwQkxPL3dIcnNs?=
 =?utf-8?B?aGRXcEFqS3p0R1F0TDd5Y2lpNjIzZzVIdmVJd0NWeTNzdXg1d2dFMmxLRTVx?=
 =?utf-8?B?UjhFcjl3a0lqckJLajJ0ZFJ3OURuaHZTbFBZSXFNZWNlYXZzcTFvaWtKdk9J?=
 =?utf-8?B?TE5vZUdHQm9Pb3BEeWV5MHprdjVYQTcwNmY4YWRWZ01NY0dBSzRhOE1FQ1JT?=
 =?utf-8?B?NVh3eDgwWlJoN1RDTXMxWTRTTGV0VkZubkk0TTdaZ2pQdll4enFlRXJ1UjZm?=
 =?utf-8?B?UWQ5L1hzeUtRTmFqOUM0ei8rM3BsaUFGMUlLZXZpS0hqYnp5amc4TWJjby9V?=
 =?utf-8?B?RWIvckV5WUdTUkE0RVJRTS95SjRJSUhlbmRmbGpZdmUwNjhDLzU2dnFTYk90?=
 =?utf-8?B?MmpxSmtQNTkzWmsxNk5Zbnh3TzYyc0d4bEd4QVRTVytnS3F5S1g0bE9mK3NO?=
 =?utf-8?B?ZDZod2V4VnJmMVZpTE0wWTA1eFNQTnl1YVFVOEVzcFAydElISEFkZ21wNEJ2?=
 =?utf-8?B?bUhkWUFXODhnSzdISDgraUY1Y3BsY3V1ZXlzY3gwOXdCOXgraTZHR245NkFs?=
 =?utf-8?B?WFg2ZXcvQU84cHhrTFRrTm5md05EdzgwQnVLTi9pU3l2SkNXOGZJdFdybjhI?=
 =?utf-8?B?QlBWTytrUEczT1gwZ01LUE90QlRWZEluKzg0VGV6U0IrMzNPTEtqaitONG85?=
 =?utf-8?B?dEZEems2RVFXcEhoOHppY0JiZmkwUGpnb3cwNFdwSi9zTkhoVkxhaHFCaG5S?=
 =?utf-8?B?WXNmRkptblIxYmVlVTVQZ0RBRFFvdVFkZDFuVFRZSTlGc2t2dllQRUVtMi9N?=
 =?utf-8?B?cEg5OVJadVB3K0pJS1Fhc1JIQjh6K0dYaFN4QkZEZUdwSzUyYm1XdmJhYzVj?=
 =?utf-8?B?WUdma1hOQVN1bS9sMGp1d1ZVb3dYMVA3Z2hPOG1Oa3ExUWZ6VUJ1Tlk3bGhY?=
 =?utf-8?B?a3dDYWJiZjBDcDAxUnB5cHRONzF4TjNmcnoyU0kvVXdMeEFjL3Y1bTd5cXRO?=
 =?utf-8?B?TFZrL3hNZ0pyOGU4MStsNEFNYWxTNVNvVzVvandsVmxpaWVsWUxkMDVCZ1ps?=
 =?utf-8?B?bHhqQlpPdjdiN0pWcTBQYnBnbG4rRktBYytZM0JlaFMzcExpRFVCblhVakdz?=
 =?utf-8?B?U3ArWmNKcGRHRkgyc0FrNE9sNVZEM09JKzBpa3hVaWNxNFpxd2hhZ2g2clRE?=
 =?utf-8?B?QXdGVXB4U1M0aWt5VkFyREt2anZZR3VVZTQvZzR3N2NtaWI2bUNPQ2xtcysz?=
 =?utf-8?B?bkhWTVIvUmdndGdGUHZsbjZycUtDMCtZQis4Sm5zUFIzT25jT282aHJ4MU9F?=
 =?utf-8?B?RC9iWGowZGtWb1hMZUF5dytkZEpxazZmVHBhWUJxcUtQSThyY0ZObVdnVlVK?=
 =?utf-8?B?NmJQWDJPcHJ5N1ppSzRvNjkvR2dMNWM0K0NTM2k3SmRJMWlXQUo1QWswMVox?=
 =?utf-8?B?Ti9VbnRRS29DR3VVZWs3ekpVNGwrVC9KVnVNZWs4b3BiVVk0cTVuU214SlRr?=
 =?utf-8?B?WUtYS2s5d0x0SXVUME5iaGtZa1RBS2tiOUxRWENVWmhTZ1V3WmlWT3BzUnh4?=
 =?utf-8?B?OEF6UEVwc29GZ0R1Q2I5SE4rNnM5OHg4K3laYm0rMUNmWnZHM2M4Vk05aHRx?=
 =?utf-8?B?UWlFNTJiRnVFNkxQcGwvUktFSVVtWUZKSG44OGFNbVRHZEVzd2hyNko1Ni9O?=
 =?utf-8?B?eUNPcUFFMTZ5aTdKUm5nVFJIN0xRV0RaTE5URHQrOVkrd05HSktZQUdzUWh2?=
 =?utf-8?B?ZVBaTmZCTHJYY2x2VENqU2t1cDIxMlFjM2l3RHNGQ0thV253SjU3bnh0YkJs?=
 =?utf-8?B?OHpOVlN2cnBOMXZSQlI1Wmc1dkVEak9oSGwyQUx0bXpkTGxEY2VwZTZRWlFF?=
 =?utf-8?Q?u9ZJVTRw2bXT3619IFzgWzaiD32eZTP4hIM0Pxc3sRsT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72B753789EB348498C0CC7311253F0D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f2d8c9-1eae-40f8-db20-08dc69b46e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 07:58:04.0048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+CC3nkS9YGn6IZwXC0VelnV6KbBpEvlu89KW8Xs5jB41kb50HuHNtaQ5+PpniIJYP5WLBrxWV5DX52fwE6e6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

T24gV2VkLCAyMDI0LTA1LTAxIGF0IDAwOjQ4IC0wNzAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IE9uIFR1ZSwgQXByIDMwLCAyMDI0IGF0IDExOjIw4oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1
bGVhQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNC0wNC0yOSBhdCAw
OTozOSArMDIwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIwMjQtMDQt
MjYgYXQgMTY6MDUgLTA3MDAsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUs
IDI1IEFwciAyMDI0IDA4OjE3OjI4ICswMDAwIERyYWdvcyBUYXR1bGVhIHdyb3RlOg0KPiA+ID4g
PiA+ID4gIFRoZSB1bnJlZiBwYXRoIGFsd2F5cyBkcm9wcGVkIGEgcmVndWxhciBwYWdlDQo+ID4g
PiA+ID4gPiByZWYsIHRoYW5rcyB0byB0aGlzIGNvbW1pdCBhcyB5b3UgcG9pbnQgb3V0Og0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0yY2MzYWViNWVjY2Nl
YzBkMjY2ODEzMTcyZmNkODJiNGI1ZmE1ODAzDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEFG
QUlDVCB0aGUgY29ycmVjdCBmaXggaXMgdG8gYWN0dWFsbHkgcmV2ZXJ0IGNvbW1pdCAyY2MzYWVi
NWVjY2MNCj4gPiA+ID4gPiA+ICgic2tidWZmOiBGaXggYSBwb3RlbnRpYWwgcmFjZSB3aGlsZSBy
ZWN5Y2xpbmcgcGFnZV9wb29sIHBhY2tldHMiKS4NCj4gPiA+ID4gPiA+IFRoZSByZWFzb24gaXMg
dGhhdCBub3cgdGhhdCBza2JfZnJhZ19yZWYoKSBjYW4gZ3JhYiBwYWdlLXBvb2wgcmVmcywgd2UN
Cj4gPiA+ID4gPiA+IGRvbid0IG5lZWQgdG8gbWFrZSBzdXJlIHRoZXJlIGlzIG9ubHkgMSBTS0Ig
dGhhdCB0cmlnZ2VycyB0aGUgcmVjeWNsZQ0KPiA+ID4gPiA+ID4gcGF0aCBhbnltb3JlLiBBbGwg
dGhlIHNrYiBhbmQgaXRzIGNsb25lcyBjYW4gb2J0YWluIHBhZ2UtcG9vbCByZWZzLA0KPiA+ID4g
PiA+ID4gYW5kIGluIHRoZSB1bnJlZiBwYXRoIHdlIGRyb3AgdGhlIHBhZ2UtcG9vbCByZWZzLiBw
YWdlX3Bvb2xfcHV0X3BhZ2UoKQ0KPiA+ID4gPiA+ID4gZGV0ZWN0cyBjb3JyZWN0bHkgdGhhdCB0
aGUgbGFzdCBwYWdlLXBvb2wgcmVmIGlzIHB1dCBhbmQgcmVjeWNsZXMgdGhlDQo+ID4gPiA+ID4g
PiBwYWdlIG9ubHkgdGhlbi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgZG9uJ3QgdGhpbmsg
dGhpcyBpcyBhIGdvb2Qgd2F5IGZvcndhcmQuIEZvciBleGFtcGxlLCBza2ItPnBwX3JlY3ljbGUg
aXMgdXNlZA0KPiA+ID4gPiA+IGFzIGEgaGludCBpbiBza2JfZ3JvX3JlY2VpdmUgdG8gYXZvaWQg
Y29hbGVzY2luZyBza2JzIHdpdGggZGlmZmVyZW50IHBwX3JlY3ljbGUNCj4gPiA+ID4gPiBmbGFn
IHN0YXRlcy4gVGhpcyBjb3VsZCBpbnRlcmZlcmUgd2l0aCB0aGF0Lg0KPiA+ID4gPiANCj4gPiA+
ID4gVGhhdCdzIGEgYml0IHNwZWN1bGF0aXZlLCByaWdodD8gVGhlIHNpbXBsZSBpbnZhcmlhbnQg
d2UgYXJlIHRyeWluZyB0bw0KPiA+ID4gPiBob2xkIGlzIHRoYXQgaWYgc2tiLT5wcF9yZWN5Y2xl
ICYmIHNrYl9mcmFnX2lzX3BwKHNrYiwgaSkgdGhlbiB0aGUNCj4gPiA+ID4gcmVmZXJlbmNlIHNr
YiBpcyBob2xkaW5nIG9uIHRoYXQgZnJhZyBpcyBhIHBwIHJlZmVyZW5jZSwgbm90IHBhZ2UNCj4g
PiA+ID4gcmVmZXJlbmNlLg0KPiA+ID4gPiANCj4gPiA+IFllcywgaXQgd2FzIGEgc3BlY3VsYXRp
dmUgc3RhdGVtZW50LiBBZnRlciByZS1yZWFkaW5nIGl0IGFuZCB0aGUgY29kZSBvZg0KPiA+ID4g
c2tiX2dyb19yZWNlaXZlKCkgaXQgbWFrZXMgbGVzcyBzZW5zZSBub3cuDQo+ID4gPiANCj4gPiA+
IE1pbmEncyBzdWdnZXN0aW9uIHRvIHJldmVydCBjb21taXQgMmNjM2FlYjVlY2NjICgic2tidWZm
OiBGaXggYSBwb3RlbnRpYWwgcmFjZQ0KPiA+ID4gd2hpbGUgcmVjeWNsaW5nIHBhZ2VfcG9vbCBw
YWNrZXRzIikgc2VlbXMgbGVzcyBzY2FyeSBub3cuIEkganVzdCBob3BlIHdlIGRvbid0DQo+ID4g
PiBidW1wIGludG8gdG9vIG1hbnkgc2NlbmFyaW9zIHNpbWlsYXIgdG8gdGhlIGlwc2VjIG9uZS4u
Lg0KPiA+ID4gDQo+ID4gPiA+IHNrYl9ncm9fcmVjZWl2ZSgpIG5lZWRzIHRvIG1haW50YWluIHRo
YXQgaW52YXJpYW50LCBpZiBpdCBkb2Vzbid0DQo+ID4gPiA+IHdlIG5lZWQgdG8gZml4IGl0Li4N
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiBHZW50bGUgcGluZy4gTm90IHN1cmUgaG93IHRvIHByb2Nl
ZWQgd2l0aCB0aGlzOg0KPiA+IA0KPiA+IDEpIFJldmVydCBjb21taXQgMmNjM2FlYjVlY2NjDQo+
ID4gKCJza2J1ZmY6IEZpeCBhIHBvdGVudGlhbCByYWNlIHdoaWxlIHJlY3ljbGluZyBwYWdlX3Bv
b2wgcGFja2V0cyIpLiBJIHRlc3RlZA0KPiA+IHRoaXMgYnR3IGFuZCBpdCB3b3JrcyAoZm9yIHRo
aXMgc3BlY2lmaWMgc2NlbmFyaW8pLg0KPiA+IA0KPiA+IDIpIFJldmVydCBNaW5hJ3MgY29tbWl0
IGE1ODBlYTk5NGZkMyAoIm5ldDogbWlycm9yIHNrYiBmcmFnIHJlZi91bnJlZiBoZWxwZXJzIikN
Cj4gPiBmb3Igbm93Lg0KPiA+IA0KPiANCj4gSSB2b3RlIGZvciAjMSwgYW5kIElJVUMgSmFrdWIn
cyBmZWVkYmFjaywgaGUgc2VlbXMgdG8gcHJlZmVyIHRoaXMgYXMNCj4gd2VsbC4gSWYgd2UgY29u
dGludWUgdG8gcnVuIGludG8gZWRnZSBjYXNlcyBhZnRlciB0aGUgcmV2ZXJ0IG9mICMxLCBJDQo+
IHRoaW5rIHdlIG1heSB3YW50IHRvIGRvICMyIGFuZCBJIGNhbiBsb29rIHRvIHJlbGFuZCBpdCB3
aXRoIHRoZSBrdW5pdA0KPiB0ZXN0cyB0aGF0IEpha3ViIHN1Z2dlc3RlZCB0aGF0IHJlcHJvZHVj
ZSB0aGVzZSBlZGdlIGNhc2VzLg0KPiANCj4gSSBjYW4gdXBsb2FkICMxIGluIHRoZSBtb3JuaW5n
IGlmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zLiBJIGRvbid0IHNlZQ0KPiBhbnkgcmVncmVzc2lv
bnMgd2l0aCAjMSBidXQgSSB3YXMgbmV2ZXIgYWJsZSB0byByZXBvIHRoaXMgaXNzdWUuDQo+IA0K
WWVzIHBsZWFzZS4gQW5kIG9uY2UgeW91IHBvc3QgaXQgd2UgY2FuIGFsc28gdGFrZSBpdCBpbnRl
cm5hbGx5IHRvIGNoZWNrIGFsbCB0aGUNCm90aGVyIHRlc3RzIHRoYXQgd2VyZSBmYWlsaW5nIGlu
IHRoZSBzYW1lIHBsYWNlLg0KDQpUaGFua3MsDQpEcmFnb3MNCg==

