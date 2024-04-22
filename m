Return-Path: <linux-kernel+bounces-152811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0808AC49B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDEEB214F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7B48787;
	Mon, 22 Apr 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tCbR0z5e"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAD11CAB;
	Mon, 22 Apr 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769090; cv=fail; b=RcYQT9ZK819LgD4Zpp3oKiOs8kcLQonGyvR+v7eXc4sTZQzpTTLGnwpwnPpBen5O762FhSxCNDRGqors+dKfN2Nl9YCvDGmmrp1cyXm0gPPBJJAhPFq87lGggXmIdHjb1J8YPeowNvNN32EE3FduqooGXaTokDGtIWeGTADZJ9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769090; c=relaxed/simple;
	bh=ZAs1TykXiHZiLgmRnyKmeUwRhLjiAD/3i+bebpVVvbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2dPO7SNFhiXK3P4chmbw+ur6gYcVmLOBjRzD5/0a86cjzA1mxi8NMkbQs+tuJKBCul8WXViiAOtF7mcrlM9mROXBMX0Hhv/84Us30RxQNKdVHCNVRBJuMpp5+glIZpeXJMI5eQuk5lh+jVs4JmCI3ErpMN+ks8mmBpvSIPKMZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tCbR0z5e; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byLrtrMCIfTKiG1OVOqMixX6N8bEtyXeey1sgcpP9CB4xPHiwaa4Pw0KAA8Zi2Vg8lCdjkOoJjwcCUxd4T9cFxwkA2WagyQTB7gXg4denjbx1bSyvNe/1vUNBE2lXRNKxslf78A63QLzP3kBwn8IHiox4KlXanCzHFue1sP2+IDBqgEmZg6Jcz+qGkraiuFetbRUnCaAQriAizvZmWbVBEjDgLihCsD3zllnFqdkppR2mzjTqswdT2yyKA1RfHvQTybTrbbIuMQu/HUjlR5X7oz492aw/QBT7ToSN7htS0Wc5EQJz48aezGhEl0cQSLzY6HRmBv8Kd7wuELQmNr23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAs1TykXiHZiLgmRnyKmeUwRhLjiAD/3i+bebpVVvbc=;
 b=bMV9L/U3H/aR82UgD4O9AoPcaig1gzYtKtWDL8GTdfTSA9P788SCiwxRW/78ucPh7envkh/DNGKN+PhGsA79u/6iaHQ+0XIKwR8TzDp5AzF8Y6uP3UQuCnBVBTGEVyY8a/IzTP6w0XpdprEZT50RsnVi5fIUutci/DGwsV9IVfa0c4UrgVMxx+PSt6wLBqwad15dnF13tW0vVKqIbpSS1qYaLD5jN/ArteauIFI3Qu9IAhWqF/K9tQipTzfXOzJI562B35vlC9mkvQUCa+Qo4q8vp2nvlTAyHEEGQLhVihlR04sKvCgO02un/PFTYqK+bsVmrC0/ctv/vBPY9KtAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAs1TykXiHZiLgmRnyKmeUwRhLjiAD/3i+bebpVVvbc=;
 b=tCbR0z5eiNQ95fkDfQi9EN7LKPvx6BxDs/Ycl9Pe0HQV+npRx6Om5YlkuQYaIAt2c1ALVjkQFHCBeiYQyvWj1lYLXy54b2/rmiPG/HiobiujOl+LMsxIGVXlZs49gXG1+bk+ieJE1jYd7lbJQZsNnn6P4YIWwKr94WOiPBlPsef/9uQ2DEIqEVHXTdUk7NrTXn25oODD3rSz6A5UoLxecAZd9f3wLIfUQRt9eEzLyIrM8q89DhlKe/TcVNyaL51L1gEnrTOn5h0bor4GO7SFTKGAQUmjyire571TRFaEUuXVlrYYyBmKrfVgWnAgd6WHKIp4uWdVH2kNG7ifZhoenQ==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 06:58:04 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::2afb:c838:f5b0:6af3]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::2afb:c838:f5b0:6af3%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 06:58:03 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "ast@fiberby.net" <ast@fiberby.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org"
	<leon@kernel.org>
Subject: Re: [PATCH net-next] net/mlx5e: flower: check for unsupported control
 flags
Thread-Topic: [PATCH net-next] net/mlx5e: flower: check for unsupported
 control flags
Thread-Index: AQHakM6cGt9n392Rxk+YW4MJ8IJVKbFz4zgA
Date: Mon, 22 Apr 2024 06:58:03 +0000
Message-ID: <16bc67f3767644005a26affad3cbd96f6319ca98.camel@nvidia.com>
References: <20240417135110.99900-1-ast@fiberby.net>
In-Reply-To: <20240417135110.99900-1-ast@fiberby.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|SA1PR12MB9246:EE_
x-ms-office365-filtering-correlation-id: 851c37ed-d4f1-44e6-96c3-08dc62998e30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUZ3SkdYcUFMUUJXNENMZ24wRkZ3cElKTnN2ZW9OanQvVVJqQVpWaU4vRXZN?=
 =?utf-8?B?ejR5cUwvc0pibGtISTgrVVdkZWZEWUNFbGZlYWVOZjU2WTJYQVV2bGlWZ0pn?=
 =?utf-8?B?SGFtTkM4cjFDbi9CcmxmRWZsVDN2bjl0a2ZRR3ROWk1sYjFETHR5RHluTUlx?=
 =?utf-8?B?OFIvRVJBS3VEa1ZzRXRML0RlYzlQUVNvZ05UVFQ5NlBXM2dSZmpMU2tIS3dh?=
 =?utf-8?B?S1c0U3g1YXlER3p4dFhXYkNxOTBjM3UyaFY4bkFXNzltZitiNFVnSkY5VnY3?=
 =?utf-8?B?WTg2MHYzSGt3OWRGdXBTcWxLTWdNanJhUHl1SFk5alRjYzNEVUdLekZRSlBh?=
 =?utf-8?B?MlBFU3AvZ0ROYUs1bG5meWxZcVdsWFFmclRUeTZpTUJyWWlUQi9URmd6c3I2?=
 =?utf-8?B?WEVuWG9mUnY4WlVBQWxaRWsyUDRBYUZDUG91WGFrWFYzOEFzcVR3ei9RdzFI?=
 =?utf-8?B?OTVIRGkwWUxKSUh6cmtHcVhTd013Y0J0U001RExiaUN0b1FIQ3o5QVpkUWIy?=
 =?utf-8?B?NkpBdmV4Y2p1UHBFeWhwZ0NtMHV5R1N5bGVUZXdiMXVwOGFHbnNWME5ZNFhU?=
 =?utf-8?B?NkZMMUExVVp4bUNyN2t6NnBLL0pNZzFIbldrUlVXQ0YwcktMVkVtZDhLU1I1?=
 =?utf-8?B?MGgrWnlkaDNBQU1VVW5xb2hxemkweTJyKzhuZE4wbHVBMFhNOHJIRGU1OXZy?=
 =?utf-8?B?djNRQTNpbVMzTUdsMVcyNlBuenRvVVZNT0JQU2tiVWJGQTg5dE42R09mNERh?=
 =?utf-8?B?SHUwOFJ4T1dYdnBsUWJ5RjBJN01OTVpDdGMxb2R0bTFwTmQxNHJjTFZpSTlp?=
 =?utf-8?B?QUlYS2tVMzAzakdOajhFTkttNmo2UExxNVpsZG1hSEpIdTUxVE04Z0hmazBH?=
 =?utf-8?B?ZGZVRHZBZWZKcDMweVdFa014Nzdycm5iSzF3ZjlDQnBZL2JQRCtRUm5rWjlV?=
 =?utf-8?B?aWlDMzlpeDZzTU52bmdlZnhmN2JSckpoMFl5K1J1T05mT2lhZHM2SlQ2ZGlw?=
 =?utf-8?B?a2RXc3U2MWE4cjJLZTFja1RlbFk0K1NUQXlYVWFHUDZXTy94Q2JJYkw0VzJS?=
 =?utf-8?B?VXFvRWRmQmFNRDVVeC8ySHdWOVRENDJtUUNNTStleitUelJZaWJSVHlGSGRM?=
 =?utf-8?B?emtNU1FNWk4rdmlKTWwxbWN5QXBadEZrK0FoOFp4WlZBSnZsS1NZY2E2dTJq?=
 =?utf-8?B?K3VwVGNkRkZXclVscHVNQjhnblRnYnFmVWgwbENxa3NhT0tGZVRoV1gvcUEx?=
 =?utf-8?B?VlBMNUV4dkpPNWEvQ2M5aW9URlAzUWo4Wit3allMYi9WMkI3MUpMTGllbWto?=
 =?utf-8?B?SzMwd0xQYUVQUjQrU1dOWDMzZmJ6ZGJVNmZxTEQxTDNZZkJNM3F6Smt4UklC?=
 =?utf-8?B?UTNDaEpTTFlRNHdGbTRiTHM5NVBrMnNvQyttTktzZE5ZVlNJZUlZek0wY0Nz?=
 =?utf-8?B?SE03WE8wZ2l1cERQaHpBR1diYVlGUktHYnNhaWdhUVNRS2M1Q3oxU1BGZm5j?=
 =?utf-8?B?YXdHYWRwaFZyOVFWS1VGRUxqSmFXNkpHV0NqcGUvbVNhaGd2Z1hRUU1TMkJw?=
 =?utf-8?B?MlAzMXFkaFcvOGl5cmg5b25xRWE3YzNFN3BrUTNmM1RXVnpPMWw3MlppQk9L?=
 =?utf-8?B?Q1lJNzlabU41ajE0ZzYwN3NZbkZzL2lGMDk1V2Y0RFV4UE1UU2lVS3RRaEE4?=
 =?utf-8?B?d2NxWDVLcUcxdkowOW1RanRmSE5BLzFvOXhZdHpNdGlzdWtpRFJPZE9Vem9j?=
 =?utf-8?B?RjlMdUQzMTVBL2ora2dsRGV1R3VIbDRCd2N3anlkOGM3T242S2ZSTG83d3Bi?=
 =?utf-8?B?Wi8wSkJZdGI4SEpaMVFkZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVdjZjhEN2NKbFpmZ2xRTmczWUJEYnY4RWw5MEV5cFNGUUZ6SUVpTVJTbGI4?=
 =?utf-8?B?ZzlOT3hYTVM4YVBheE5KOTZ4MkNKOEtaOFFMclRzNkUvNm14dndYM3BmMXVS?=
 =?utf-8?B?YVY5ZzRrN1JDcXlhNFlzclZtMXU1c01pYnZQdHZhUWI1UWxmTDZQVEZCNnJG?=
 =?utf-8?B?eTYyZUNDbDRtNVZweFY0eG9UbFk2RUNkNHpva3hGNEdRTXR5am8vdjA5YnVN?=
 =?utf-8?B?YUUxMDRWVkJ4bnhZdkZMa2lZN1FNYzBVdXlMMzBZT2ZkSVF6aUthYWFsaW0w?=
 =?utf-8?B?UlpjazNYQjJ0QzFCcnBUc0xaYlgzeEdKaHNpbEE4QVRjaCtxVytJQlBLZkph?=
 =?utf-8?B?S2M3dEtmcEJLNHhKMkxFckpzZ3FoVVFCZmZwdlVZeUVFeXVKN1FGcWtMMWFr?=
 =?utf-8?B?WW5INWRkamZkUVI4aWUyQWtOMzF5dmtBS1EwaG52NDZQMU9xUmF1MHNxSXlo?=
 =?utf-8?B?WHkwN1hLb1dPb3JJL1M1MTV4R2ZpVDQxRWF2TDUrbkROMm9kK2hkR3JqSDJV?=
 =?utf-8?B?VkY5ejZkMGVYUzg2MmpSVGVrU1dmc3g1dStkd2MzZXJROWRkY3FFaGVveWZw?=
 =?utf-8?B?VFBxOW44Vk5jWGFLWG9sOWZVWW5zbFRhSkpZTm5QTFc3eCtqMGJ5M0pWQk1v?=
 =?utf-8?B?TWtUaHJ1OHluSWo3aWQ2SUoxamVTN2cyaExmMHFJbDJqTHVGUytOK1VTZlFL?=
 =?utf-8?B?WkRyQytld1U0WTVFMHZJTHkrZEhPdnA1Z2Q1cFhvcWtqeHIvTWxFZlFWVVlQ?=
 =?utf-8?B?RGtUQTl0UEpQek5XcE1qeEZZbkh2aWFRaUlkTERRWUQvbU5mNlhSUXZORVZa?=
 =?utf-8?B?MGhTNUxKTnBCc1IxUWFVWmVaVmJSTnA2S2xtaFlicXNlSzlBbExRSXYvaE1j?=
 =?utf-8?B?RHhBTEdvQTk2SllUbklSWjJlb0xsdWtKb1VYZklmcWMxcFMwOUtjb1pUWitk?=
 =?utf-8?B?M3R1NVQzN1BtSzlTWnZRbWd0dlBYcERHRDVPaWNoQTNrdENFY3hvdjdTNkR5?=
 =?utf-8?B?cVNEWno0Z0R4L3hKeFkrWGtFd2w3elpiRjhTT3FIekJlVm5Ga0grbThsY1Ny?=
 =?utf-8?B?anA2QUVOdE1Jb1ZVZ3ZlUm9uZDRubDlYT3lnREdpUjRvSjNudWRvZkJPL2w4?=
 =?utf-8?B?Ly9qdWVkOUJ5cWE4ek1iNTR2Qnp1QkJpVTVpaGtweitJUUZoVHJkRFN1Zlg1?=
 =?utf-8?B?amtpaGV1VUIrNFA5Z2pGUU0wVFJMY0FHRkYzbFJRSnMvakc2dE9qL0t6TDAw?=
 =?utf-8?B?SVNEQXhQRit6dkNVL3dmeDdPWGpFdWd6d1FVbVVxcnlxamZFZDhCczZPYUV1?=
 =?utf-8?B?Z2VTVUdVcjNqQ1FBUkFTR3JUcWowWDM5V2VtS1hLamlaemovc3QvU0pqbnJY?=
 =?utf-8?B?MkNxMzNIay9GTWVsMkFwRy9RQmhrcUlKZWdIeFNtazNVbnhFVmV0TGQvVlB3?=
 =?utf-8?B?cGNpWU5EQ2pKcDJva001QTV3K0dTWjBIcTdrQS9kZXZtTG91UGFaak1XaFgw?=
 =?utf-8?B?ZWJDQVJYb3VQMVJLTnQ1Rk81OXlneTYyRllqc3NxOHlRc1pycG5FcVNWc1JB?=
 =?utf-8?B?VVJpRlYrSWh6N0FmejAxenhvSGxWMlZCSWIxSDM2Q3N3bm9mUjdrYXVtb3JP?=
 =?utf-8?B?MndYTTFGZkNobm5XZUI4cXVGSWNxQXNpZUx4aERpWk9aNUpSUmt1UVpnOWtW?=
 =?utf-8?B?OGlURU1Sakd4aktiUFJ5Q1pubzZrNEVUL09vbjlRQW8xdCtPNUhtM3JaSWRQ?=
 =?utf-8?B?cTN4dkNZelhmb29NRElSd2x5b3VuSWlObmxQMWx2cERUb3UwcHVPK0FueW5Y?=
 =?utf-8?B?RGxrbGpCWENEdFp2ekthb21KSllOSlUwWUZaeHZidVY0bWRZdjcxYlBobWNN?=
 =?utf-8?B?cWtWeEpTcTh6bnpYN2QvR3NEb2M3TmxWYmlsSkVweFhzZmNRVHZURHVrZEpZ?=
 =?utf-8?B?SjFDMGpLL2NLMGNCZ0tPQU5PaTcwRHMwOUZCdUpvL3FZMnRvME5DZytjWkRC?=
 =?utf-8?B?bnFZRytvWU1oTmR5UEQ3UE9QOXRKNDBJZnF5Z1JpUmhQM0FhU1NLMndwZSth?=
 =?utf-8?B?alZ4L3ZXaUpoazhoRDU5TjJLMHBKaWxxeEFaR21uSUo3V3VFMC9Pc3lTczNi?=
 =?utf-8?Q?CZVCM+fKzV2YtsjJW3kdgzt2b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CF242C8E013C444A18CA68A425467FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c37ed-d4f1-44e6-96c3-08dc62998e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 06:58:03.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJDEOXpuBRBDOViCbbqZKf6v/3QeVe8HI6PpysPiPlr5kNSoi1s8WwSOvUKzj2OZiA3m6H47GnqA+yac8Hr64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246

T24gV2VkLCAyMDI0LTA0LTE3IGF0IDEzOjUxICswMDAwLCBBc2Jqw7hybiBTbG90aCBUw7hubmVz
ZW4gd3JvdGU6DQo+IFVzZSBmbG93X3J1bGVfaXNfc3VwcF9jb250cm9sX2ZsYWdzKCkgdG8gcmVq
ZWN0IGZpbHRlcnMgd2l0aA0KPiB1bnN1cHBvcnRlZCBjb250cm9sIGZsYWdzLg0KPiANCj4gSW4g
Y2FzZSBhbnkgdW5zdXBwb3J0ZWQgY29udHJvbCBmbGFncyBhcmUgbWFza2VkLA0KPiBmbG93X3J1
bGVfaXNfc3VwcF9jb250cm9sX2ZsYWdzKCkgc2V0cyBhIE5MIGV4dGVuZGVkDQo+IGVycm9yIG1l
c3NhZ2UsIGFuZCB3ZSByZXR1cm4gLUVPUE5PVFNVUFAuDQo+IA0KPiBPbmx5IGNvbXBpbGUtdGVz
dGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RA
ZmliZXJieS5uZXQ+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eDUvY29yZS9lbl90Yy5jIHwgNSArKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHg1L2NvcmUvZW5fdGMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUv
Y29yZS9lbl90Yy5jDQo+IGluZGV4IGFlYjMyY2IyNzE4Mi4uNTAxOTI4MGNmY2RkIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fdGMuYw0K
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fdGMuYw0K
PiBAQCAtMjgxOSw2ICsyODE5LDExIEBAIHN0YXRpYyBpbnQgX19wYXJzZV9jbHNfZmxvd2VyKHN0
cnVjdA0KPiBtbHg1ZV9wcml2ICpwcml2LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqbWF0Y2hfbGV2ZWwgPSBNTFg1X01B
VENIX0wzOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gKw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYNCj4gKCFmbG93X3J1bGVfaXNfc3VwcF9jb250
cm9sX2ZsYWdzKEZMT1dfRElTX0lTX0ZSQUdNRU5UIHwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiBGTE9XX0RJU19GSVJTVF9GUkFHLA0KDQpXZSBy
ZWplY3QgRkxPV19ESVNfRklSU1RfRlJBRyBhdCBzZXZlcmFsIGxpbmVzIGFib3ZlLiBJIHRoaW5r
IHlvdSBjYW4NCnJlbW92ZSB0aG9zZSBsaW5lcyBhbmQgYWRkIEZMT1dfRElTX0lTX0ZSQUdNRU5U
IGFzIHRoZSBvbmx5IHN1cHBvcnRlZA0KZmxhZyBoZXJlLg0KDQpUaGFua3MhDQpKaWFuYm8NCg0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1hdGNoLm1h
c2stDQo+ID5mbGFncywgZXh0YWNrKSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVPUE5PVFNVUFA7DQo+IMKgwqDCoMKgwqDCoMKgwqB9
DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZmxvd19ydWxlX21hdGNoX2tleShydWxlLCBG
TE9XX0RJU1NFQ1RPUl9LRVlfQkFTSUMpKSB7DQoNCg==

