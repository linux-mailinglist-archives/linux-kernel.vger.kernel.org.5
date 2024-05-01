Return-Path: <linux-kernel+bounces-164964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999508B8587
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47252832DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD24CE0F;
	Wed,  1 May 2024 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VGAv/DLD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2843AAB;
	Wed,  1 May 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714544446; cv=fail; b=dM/dY2mo4UM9EObLs2cnCVtThn6Cm/SBm2bfKmAZ+T2gk9uXP/eLH+qt8lc8I8TE1FoepTtddjMxXJJGoU5qKvT6kYr+TmQTgVEUbX1ij/zVvtvJNYz2/YhBeDNFagH37N9Gake+2cRClQMWMQ9nQ+NXCYMPwwQmhT1fBzI250c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714544446; c=relaxed/simple;
	bh=/IbwpI3JzhyH5eoWqT0CzlCZCGmf224wZq9v2v4vrsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lxF0plD7rUjHF0q/8sfWutHIRQkyKmYkFp1BDzWYg6kTUVntp/O+w7SCV3TXU6jXEwciaNhrVymfsaT+sG4atzbo7P9d1t5f4x16BVc8LPlnkBKpelwRLfsiiDnix9Fmi9Fid0xJ/1C99UlO6L2ggCfE5kfC+b/Op3zsXOjlhbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VGAv/DLD; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHsaxdpX6GWyQ3ScWyMFk7u0K51quV434uDVZzjDynXCXACNk+eT7HKkMXfz/POJdDt17exWcKGfhGe85JYkPLqp133jAF6EWmZoYfUpVYJDliQjUnksbUsdFieyQRktqfk+R0heGVJOLIpJhlZyVLYTSW6J5u7GMExH+likY8KUgy0zARWHr8AZtML3nWrgfEBFosFuMhJYdzwz23vAeKHRFsk4hkV4PGV9ZdJMGkWd+GZ3msjFXNUsBwL4Pyv+Bm9tVkUHXs5jJZbEdZhJ+WNNnEGKKj+65o8hRG5Hy74poSEWRcDeZ/nU81rFZsDtvol54WKrYNqVt3DGWShaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IbwpI3JzhyH5eoWqT0CzlCZCGmf224wZq9v2v4vrsU=;
 b=El77AYQTw9EEbQUF91cojmmV78ZicQHiT3syoVvTg5nSRLcBTTqpwB1wT+n94fiWTcXpk2817NY88uvV4gfds/6ikTM4Q96LewRvt/PRbmsgo5SaX/dJQpYBaEE8CzcBTfnsn6qW9SIrEdmNoRXx/UG3z1AUL0CRvi7HNI9M+j1z+4JyqOdQBtgeutiBtBztSweHpoGGr9K5pDPcxuXtxR7yFWzKKSBiQUSkx3a9/mAg3cDjXFYIuCfxDNBdncSaePn0plU63qUV+abHKkJkG8TPGVFH2TIB2z7jR8rGxolIJb3DApineJS/MiYKDhiC8B3zW8HX4qKbnmLblm2crg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IbwpI3JzhyH5eoWqT0CzlCZCGmf224wZq9v2v4vrsU=;
 b=VGAv/DLDddPvsJOxzjGExoFFFDl1iMZ2AYYk5Bx3mzNa4YGWZnHBrZuz3ZhRL4WaPE6AwcG58MfzG8KD+BWMWJyph3SkwftY7gs2ZxwBoT0b7TEZanEVW4vf/kCRHQzqG8BisDBudcxkUuyaDYn4KBKgo3/vNlZrI/SmTc2uQLDwxXrf+zuULK3Wd27seWjlVm1wBR26vrEj3112TnRc/hdZokQ7Z5YcjLsobPUWbMt2KS9tG3yphytMnbqepuGobp8H2+G85XK4W1SruP4RzzWnbgawIgsAaBk1mh4aYbfy+QSUWjzYHcEJwLntx5WESctDHG+gTG4WUpZJtfAcfw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 06:20:39 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 06:20:38 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jianbo
 Liu <jianbol@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"almasrymina@google.com" <almasrymina@google.com>, "edumazet@google.com"
	<edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Topic: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Index:
 AQHalmh2YwjSjfzzmU66VYtjn6H0WLF3q+gAgABPNgCAAKoVgIACipOAgAO0DACAAw65gA==
Date: Wed, 1 May 2024 06:20:38 +0000
Message-ID: <7a5a1d74040052afc8cc6cc5c2700fdf2e836b0c.camel@nvidia.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	 <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	 <20240426160557.51de91f9@kernel.org>
	 <c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
In-Reply-To: <c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SN7PR12MB7321:EE_
x-ms-office365-filtering-correlation-id: 0d9517cf-a304-4e0b-0f98-08dc69a6d206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NktZU3NJRkRtY2pqKy9veFRmcll5WWhKdnRDN3V1TU9Xekk0U2pMSjllV05n?=
 =?utf-8?B?Wks1eS9OLzJiNXJnV0kySHJHRGs2NnVwSVo5UkgvaEJxNVVCaU9YTGdVTTk0?=
 =?utf-8?B?Z0wzZHYyaHRkS0l3MUtLMy9lSXdOamhEMkdwdEkrVzRmUSt5VC9obXNDUTRV?=
 =?utf-8?B?ZmQ4U2hsWSswclJjelI2TWxoeWxMR0VNaWlMZEx2UVN2MDFwaC84eDViRDd6?=
 =?utf-8?B?UGcwT1RDWklmUnBxVEpZZXA5TWxKZFNtQVRSUjZWQXV3bHR5R3BGdHlQQnFo?=
 =?utf-8?B?RVFpUkJVYjAwWU1yMEgyMm94Z25xZFdIT2dBbEYzQklLOUFnaVZJWEw2ZzhM?=
 =?utf-8?B?UnZWWklRTkRBR2gvdE9TUXBGdkRmS3F3RC8rTmM3blZoVzlaU3M0YjVkZVlp?=
 =?utf-8?B?VHl3bnVsb0xHUGZYNEQ1eGF4T2tGTmhTamhpZS9tVXpSTkxlMWhXcUR1UlV2?=
 =?utf-8?B?R29VL29wK2xFd0FtOE45bW9CamlodzdEZ0l2UzJBdnJLU1RHZFBqODAvaHJh?=
 =?utf-8?B?VmFvOHZPL1R3MFd4emNDcDN4NjdhK09keXdKK2hlb0tNRkpHYVo3QThxdEVl?=
 =?utf-8?B?NkJHeFZNYmpvTzNiTW9la2hlRmpLS0NrQ2s2UmorcVJCcG51dTJxb0JkcHB6?=
 =?utf-8?B?cmFCbzBCbHJBR2JoeVZQVm5yemtBMjNNdDhxUTdZNXl3T2s0djVMNXFkNzRG?=
 =?utf-8?B?Wi9IOE1oWnM5bmpvbFI0cWpxemZZRjQyazBscFFNdkxWQmJlUDYvVUwyMWFN?=
 =?utf-8?B?OG9yM1JTNnExSmV6TzhLeC8yOHVKMkJEUEZIMjVkQVZUdDVtOU1tcE9GK3dZ?=
 =?utf-8?B?SmxGc0hpTXIwVUtEaTdLVUFjMnplUmliL2paa01SVnlzOXhNbWtzMkNVUU9L?=
 =?utf-8?B?eEZnNUNRMUNoeHhpdnZnbTIvNFNicnlhdzJ3YThidlZLWjhkVXVPTWh3bndo?=
 =?utf-8?B?TDBEM1ppU3NJa21CRkVNM0JENStMRUN1OGJLNTV4RnlDa2w1ZnlqMlA4bVNa?=
 =?utf-8?B?ZjVrL0JSeXI4VVlRdDI5Z3Q4Q0NEcEFjcWhnSEZxZ2t1WkYxcHp5eVpwUzVJ?=
 =?utf-8?B?RnVIRGErNGx3ZE9KQTQ2czhMNVFsNmtYdGEyS3lFT2ZUQ1FPSHUwRHhXUHEw?=
 =?utf-8?B?NlQrcDgzMzVLSm1WVmEzZFF2cmV5UGY3eTNNVjAyVm1WU3pUMUYvWDQyV3Ax?=
 =?utf-8?B?dEh2MmcyUEZDaGtLbEVqcnlycUJOVFNDaU5iN0lzem4zRWJRR1VYZjBnYUxm?=
 =?utf-8?B?QWRQbDdsTnFoRlIwamFiZjRUZ3RTR3pBcTdOSTNwbmtlRU43TWtmb1dnQUdm?=
 =?utf-8?B?cWJHc0RQdUh2clpoTDlBQ0czd0RmOE1oaEo4V1BCTkFmdlBEdjN0Yk4xM3o0?=
 =?utf-8?B?SDJmM3hzMEh5SThKaVBlYW9iN0lKck05VEF4N2M5dzNnclFnOGlFaGVFNmJN?=
 =?utf-8?B?Z00wbWF6NStKcEZBT2haSDBYUUF4cGNoSE9oSVRtTnpzajFDNWg1azl6MjZ2?=
 =?utf-8?B?bkZCZGIyblR0NHJDd1hnQlQwREFnVXl3MjUrM1YyeFNOQTdNS2kzT3dOSldZ?=
 =?utf-8?B?aVVLbUlVdzVTUVI3eGZUVUFVUmpCMDRlOHFlZXA5QlMwc1NkS2R0Vjl6YUkz?=
 =?utf-8?B?dE03ckxvMUtGNEpZNGZwSVBpNkJ5cjFVZENHV2l0VTdVelBCejdUbW1udmpm?=
 =?utf-8?B?ZkY1SHV4TDIrdGNNWkx1cXhHbm1Bc2NYdjFRTnJQUHRIZlFCVnhZWEhUMTEw?=
 =?utf-8?B?dmVvQ3JTNkJBOEgvZndiTWtJVXlodVJ2T0NBTS9ZVXJTUHlTckd4Z1hqSW9C?=
 =?utf-8?B?TUQ2cXVIcTFNMEtyL2Yvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OThMN3krdnkyRlBLdmQ5ZjRRbThiTk5wTk51bUFiWmJ0aGE1RlF0M3JicWdi?=
 =?utf-8?B?RTJaTHUyaHdTYTFzTExDZUNTT2hqNXFweDUxYVNtV3NsU2RBS0lNWjN3emx0?=
 =?utf-8?B?ZGk4VXhCSTNsc0tIMDJ5OGdkMVFwSTVqRjRNeFk5aHd6cjBKRmVrSzdYUkkr?=
 =?utf-8?B?UXVGZitxZ0FQL2FseGVGRmVQSExKcFZlcmxkQ0NDNCtiTnVNU3YwVjRmV1hU?=
 =?utf-8?B?NmlxMTdrekU2NitrMDBBRDl5dE1aZ3VXWkZFd3Z6TStUdTNjYjBXMVlhaDdk?=
 =?utf-8?B?S0VrbW9aeklycFRhWklNemZ4d1FMaVpsVnoreG13WFpTUDdrTk41RFB2SXM2?=
 =?utf-8?B?UzQ0angwL3J4RTA5UC9aZlp6cjdvZ0Jnb1BiWHkwWVJDNEpPK0M1cHF4SHNs?=
 =?utf-8?B?bHZ4QjVDRlNJZlN5Wm1TNXM5aC9sSWJxaXFtbFpnZUhmaUVWTlppd0lEYlRo?=
 =?utf-8?B?aWZzenFpOXRxaG1IdzBlaTNmbWVuaGF0NU9MQkRNcXBmdVVhNjUrZzZmRzF0?=
 =?utf-8?B?R3V4YUkyQjJROFdRaE1VNEJ1UTRDRU80OGgydFpKNk9zWUtIVWJrU1hNY25y?=
 =?utf-8?B?ekM0akF0OHNoR0xJU3J6eE5ZRDQ5enFlUFNDbW5vcnZrOXdvS2tzbEJybWZO?=
 =?utf-8?B?WkkwaSt3b2lVaU4xSWRpVmdLVlZmQjNFSmYrd2NVTzJWVHZRdmE5d2xBTVRE?=
 =?utf-8?B?eDNDNkkvaVpod2VybERRSjRSOFppaFRhSlZKOWt1N3djQjAzbVFSSFZvOWRz?=
 =?utf-8?B?eURsQjdsekZ0ZGRCbklpRkFSNnNFNEFXdUpjQkg2ZlVyU1FYRHFVczBlOFU3?=
 =?utf-8?B?TjNUeWRib3hVbUdhVHk3L0xZRDIvMmkvODdkdTNheTlWcUI0LzlqNkV5ZkJ5?=
 =?utf-8?B?Q3RMRE5hdlUvQTVUYmhzSCtWSmJZWFlKSlMwWHBKZ3Eya1BhcTFVRWR2STZZ?=
 =?utf-8?B?MTZNYi9nQzBPRm1CbVZuN2lrNWxCSkYrT2JNcG1WUU9hMWJ1cEM5ZlZZWUN0?=
 =?utf-8?B?aGNzTHVEV0pTd21NR1NMdU8zUWZ6MDJReXhxcmdQSjFuNHFNYkRZeCtBcndI?=
 =?utf-8?B?anR4Z0hYTzdFOHM0aEpBMDZyalZVYU5IUGtPREFlbjBXTXk2M28zNXBYTURs?=
 =?utf-8?B?ZHNVbStITG1yeUs3OWpIc1FTNlJ1aTlTejVIMlJremtxYUpJR2RVemxFQisy?=
 =?utf-8?B?TU5NOE5wbTZ6RnBBZFRzWU81TERENXgxZEY0S2w0dHVweHZaYXVKR0tYNHpl?=
 =?utf-8?B?dG0yQm8yWk1qUlJ3bnNCaEpOZ1dSSWVXSUdQM2FBUjB5aGFpamU2NUFGY1Zk?=
 =?utf-8?B?Nk9QZjNTZUMra0xIUjNMa3RFN2ozYWJwNWQ5cGdqc0lmVEwydVUyc21NbzM3?=
 =?utf-8?B?L2xoTTlwOHNjZk45RFpaMUh2ZWJzbVh0RWQxUVZONkgxZHVGdXNwcjRBLzNm?=
 =?utf-8?B?YTU1aGJ4SkNDbmVQVTEwUlZjc1JIU3ZRWHZ4R3lZcjF1aXlzWDBKS1dPcHl4?=
 =?utf-8?B?MFhGODNaT2RCN1I0WVBzMmROeURhZUJVbklGRUtlTkRhRGZndjZqYk1RY1Zj?=
 =?utf-8?B?dnIxb0VSMEtEb3hqQlMyYnkwMFpUTnBMNk9xbnBkUkhWMllUNjJJQjZtUUtk?=
 =?utf-8?B?bE1XUGQxYzdQbHZiMUpWc2dvQk9yL1pEMG55RmIrZkNFZDNuM21UV1RiNllG?=
 =?utf-8?B?Qlp3bzNHNGxvQnVmUDY0OVVGYlFGR1lCY3A5ZFE1OXlsZzNSbDc1aVVGdGZs?=
 =?utf-8?B?TDFBVDVIU3JVbEFwWjEzdEgyZVEvRFlYS1N4SzhnOWhKdUZWSFV6SmlJNFpw?=
 =?utf-8?B?QmhhaDhQUS9IOTlrdFljeXVLRHBLc2JsR1Q0VUQ1dnplRWhGSTliY2UrVnBk?=
 =?utf-8?B?d2hVQkVnWDl0Ynp0NThkYXdUNXl0Vmk4ZWhFRGVZR2xBNi9LVjhVVXpCV3RX?=
 =?utf-8?B?OTlIZTdJVVZOWEZtZ0U3QW5Hd0hjSzA0OXI1bGdwak01Z0x5Z0FHV2RNSVQ3?=
 =?utf-8?B?UGVUOXkrZzN3TSs3dHIvczFuajJnQTNCVWFlaCtEUUNMdFkxL2VJVXM0ekFt?=
 =?utf-8?B?MyswWFNKaEtsZkYwWHNUclBUckxIclNGYlFjUU9kU3VvN2dSd0p4NmZoeXkz?=
 =?utf-8?B?Q1BMQmE5TEtxUXhlRitOaDlaVkkxaThhRFUzRXA0YTZDNDMranl1T0VId0p1?=
 =?utf-8?Q?0mxHCTnpsXYTJIn2rAzXMW0S+5umse+7wOvbbv8S0mrt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FB9F4916F584F4FB6FBC3CF9F2FA233@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9517cf-a304-4e0b-0f98-08dc69a6d206
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 06:20:38.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnMEBN2fSIYqwcALO9RMi2HoRSJRxhymm9UgEgqpw+Jl0RosWg46hcxq9Ux1D0m7NWy3FhkbQHj9XeZg87X6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDA5OjM5ICswMjAwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToN
Cj4gT24gRnJpLCAyMDI0LTA0LTI2IGF0IDE2OjA1IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90
ZToNCj4gPiBPbiBUaHUsIDI1IEFwciAyMDI0IDA4OjE3OjI4ICswMDAwIERyYWdvcyBUYXR1bGVh
IHdyb3RlOg0KPiA+ID4gPiAgVGhlIHVucmVmIHBhdGggYWx3YXlzIGRyb3BwZWQgYSByZWd1bGFy
IHBhZ2UNCj4gPiA+ID4gcmVmLCB0aGFua3MgdG8gdGhpcyBjb21taXQgYXMgeW91IHBvaW50IG91
dDoNCj4gPiA+ID4gDQo+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTJjYzNhZWI1ZWNjY2Vj
MGQyNjY4MTMxNzJmY2Q4MmI0YjVmYTU4MDMNCj4gPiA+ID4gDQo+ID4gPiA+IEFGQUlDVCB0aGUg
Y29ycmVjdCBmaXggaXMgdG8gYWN0dWFsbHkgcmV2ZXJ0IGNvbW1pdCAyY2MzYWViNWVjY2MNCj4g
PiA+ID4gKCJza2J1ZmY6IEZpeCBhIHBvdGVudGlhbCByYWNlIHdoaWxlIHJlY3ljbGluZyBwYWdl
X3Bvb2wgcGFja2V0cyIpLg0KPiA+ID4gPiBUaGUgcmVhc29uIGlzIHRoYXQgbm93IHRoYXQgc2ti
X2ZyYWdfcmVmKCkgY2FuIGdyYWIgcGFnZS1wb29sIHJlZnMsIHdlDQo+ID4gPiA+IGRvbid0IG5l
ZWQgdG8gbWFrZSBzdXJlIHRoZXJlIGlzIG9ubHkgMSBTS0IgdGhhdCB0cmlnZ2VycyB0aGUgcmVj
eWNsZQ0KPiA+ID4gPiBwYXRoIGFueW1vcmUuIEFsbCB0aGUgc2tiIGFuZCBpdHMgY2xvbmVzIGNh
biBvYnRhaW4gcGFnZS1wb29sIHJlZnMsDQo+ID4gPiA+IGFuZCBpbiB0aGUgdW5yZWYgcGF0aCB3
ZSBkcm9wIHRoZSBwYWdlLXBvb2wgcmVmcy4gcGFnZV9wb29sX3B1dF9wYWdlKCkNCj4gPiA+ID4g
ZGV0ZWN0cyBjb3JyZWN0bHkgdGhhdCB0aGUgbGFzdCBwYWdlLXBvb2wgcmVmIGlzIHB1dCBhbmQg
cmVjeWNsZXMgdGhlDQo+ID4gPiA+IHBhZ2Ugb25seSB0aGVuLg0KPiA+ID4gPiAgIA0KPiA+ID4g
SSBkb24ndCB0aGluayB0aGlzIGlzIGEgZ29vZCB3YXkgZm9yd2FyZC4gRm9yIGV4YW1wbGUsIHNr
Yi0+cHBfcmVjeWNsZSBpcyB1c2VkDQo+ID4gPiBhcyBhIGhpbnQgaW4gc2tiX2dyb19yZWNlaXZl
IHRvIGF2b2lkIGNvYWxlc2Npbmcgc2ticyB3aXRoIGRpZmZlcmVudCBwcF9yZWN5Y2xlDQo+ID4g
PiBmbGFnIHN0YXRlcy4gVGhpcyBjb3VsZCBpbnRlcmZlcmUgd2l0aCB0aGF0Lg0KPiA+IA0KPiA+
IFRoYXQncyBhIGJpdCBzcGVjdWxhdGl2ZSwgcmlnaHQ/IFRoZSBzaW1wbGUgaW52YXJpYW50IHdl
IGFyZSB0cnlpbmcgdG8NCj4gPiBob2xkIGlzIHRoYXQgaWYgc2tiLT5wcF9yZWN5Y2xlICYmIHNr
Yl9mcmFnX2lzX3BwKHNrYiwgaSkgdGhlbiB0aGUNCj4gPiByZWZlcmVuY2Ugc2tiIGlzIGhvbGRp
bmcgb24gdGhhdCBmcmFnIGlzIGEgcHAgcmVmZXJlbmNlLCBub3QgcGFnZQ0KPiA+IHJlZmVyZW5j
ZS4NCj4gPiANCj4gWWVzLCBpdCB3YXMgYSBzcGVjdWxhdGl2ZSBzdGF0ZW1lbnQuwqBBZnRlciBy
ZS1yZWFkaW5nIGl0IGFuZCB0aGUgY29kZSBvZg0KPiBza2JfZ3JvX3JlY2VpdmUoKSBpdCBtYWtl
cyBsZXNzIHNlbnNlIG5vdy4NCj4gDQo+IE1pbmEncyBzdWdnZXN0aW9uIHRvIHJldmVydCBjb21t
aXQgMmNjM2FlYjVlY2NjICgic2tidWZmOiBGaXggYSBwb3RlbnRpYWwgcmFjZQ0KPiB3aGlsZSBy
ZWN5Y2xpbmcgcGFnZV9wb29sIHBhY2tldHMiKSBzZWVtcyBsZXNzIHNjYXJ5IG5vdy4gSSBqdXN0
IGhvcGUgd2UgZG9uJ3QNCj4gYnVtcCBpbnRvIHRvbyBtYW55IHNjZW5hcmlvcyBzaW1pbGFyIHRv
IHRoZSBpcHNlYyBvbmUuLi4NCj4gDQo+ID4gc2tiX2dyb19yZWNlaXZlKCkgbmVlZHMgdG8gbWFp
bnRhaW4gdGhhdCBpbnZhcmlhbnQsIGlmIGl0IGRvZXNuJ3QNCj4gPiB3ZSBuZWVkIHRvIGZpeCBp
dC4uDQo+ID4gDQo+IA0KR2VudGxlIHBpbmcuIE5vdCBzdXJlIGhvdyB0byBwcm9jZWVkIHdpdGgg
dGhpczoNCg0KMSkgUmV2ZXJ0IGNvbW1pdCAyY2MzYWViNWVjY2MNCigic2tidWZmOiBGaXggYSBw
b3RlbnRpYWwgcmFjZSB3aGlsZSByZWN5Y2xpbmcgcGFnZV9wb29sIHBhY2tldHMiKS4gSSB0ZXN0
ZWQNCnRoaXMgYnR3IGFuZCBpdCB3b3JrcyAoZm9yIHRoaXMgc3BlY2lmaWMgc2NlbmFyaW8pLg0K
DQoyKSBSZXZlcnQgTWluYSdzIGNvbW1pdCBhNTgwZWE5OTRmZDMgKCJuZXQ6IG1pcnJvciBza2Ig
ZnJhZyByZWYvdW5yZWYgaGVscGVycyIpDQpmb3Igbm93Lg0KDQpUaGFua3MsDQpEcmFnb3MNCg==

