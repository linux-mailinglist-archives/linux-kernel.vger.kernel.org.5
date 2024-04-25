Return-Path: <linux-kernel+bounces-158742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440898B245B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FC31C2139C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B6E14A0A0;
	Thu, 25 Apr 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g49clDRz"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3B14A4EC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056668; cv=fail; b=Gy5R3zIKBH9hqSDPUfpG4m4WNG/daXLzDbufBpHIwtlztLICUrkSWoCBUBTsIqvlQyedxEE5s9ju14S+pdrm9i0ofndATZFH8klsuOl/G7gamhhW+OgJQXf0FPMerZ9hc8jGQgbmpY51ogcI4v6AY5LC/fuojsLADWvU2n3IXJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056668; c=relaxed/simple;
	bh=WW9nl2wSfSJhyWcgw6xZDAGUYNnEoh/DdnMGDdVLSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzXiTtjkplUp85yZyuk2h5G6uoviEJRwil56BZjm/1W96EL01LZxy+AZCSXMy+6/vRVw39afqbOtdKE6NNEydP9nM0VMyO8eY2RNCZ6484ZhuyEyCqSuL0tyhxJWCoK3v6BMSErfknyWKYjKN1HYK0pL5S50hivyPWOqmwu4f/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g49clDRz; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaQwKD3REr27g/BLnLRickt6voM0kdx90YBKCT2dffRRaQEnlZ4/EISMdzemDZqdOGUAf9iyawTx7ZkI21xmc1gcrD0LGNAJ0GI6FRL98uEiQPuZkPXFKnWOYdO8iz/DPnXbVyuUL0ynFev5RmSQKSESP1rRtZHtxzx9wgWIiu5LorJMZB3Sj8f1U+rRlszoJvLUZJ6ZrsaLgj6grJYePvGT3ks20jf2/o5JBJI4nCWe2oBdsA2r6WB5LdB0InIyLh8g9ZYuyrtk5U0Fx9ZU60XEVsYiizOholNfMB78nON3dXvuFktxJEdptNHEdR5wQ34SMKN1cg2S4eFr1DhVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWrd4FROV710w5QwG99U7ZaWwQ0cfZLHfw6ucqyrW9I=;
 b=JmJpgG1IiUYfntij/KQcPvhiRYeAUL/vEWrTNGyuRC17fXpt1z+Y7xBtARxhphRD0azk9qJX5mnvKVxp8ot8/NbhWgKfXA2631B36kcdV2d0r5a11TSfTxhpY0EMa7cJl3vhrqqyC3ODSiZ5ioswogQieRdIBHnWK+HNffkbvFAw/1FFa8xOr85cVA7yeVh8affB/YY3rXBBeqH0k3Ao0/x+g5S31LM4Z1BWbbSYGmqzUF4nxTM18Y4WIt1ypma2SqA9hFgSS/JQ9aLGsRaG6CfkomPDAR5xc194Hp+5+oqGJE+QLvItNDxFmUx2VXx+4qGFB/Vd42P5KnKOw5L6pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWrd4FROV710w5QwG99U7ZaWwQ0cfZLHfw6ucqyrW9I=;
 b=g49clDRzXnxhNtjfiLxU6pLmDnYijG7wtjSYFxEaLpLPIOQelFUGGJp36CJYLDOhsw3ut4WWz/gFp6s6HTEdeZm/9xKbwoMSEKZwH+bqpGJnlCrH6zriXysFlgW3vW4atAjRyP0cc2vcy5QT7IQws6wTGCpoR7RMZ2EJLX/aIJOsMMMPM/C++nAxyrAdw9JguqcDwvunBfrLGcNY54dQlN65mJpY1Sa/QSwsSG2cg1l5lPouA1ZdEV9E+CFdx0LlBqff5UbZibeaSJS8XB3Q9Dj5yfR4CCPKScdeh3ebq+WrKqtdLbZ3q7JR1qipM4OS2opOrAvlUrCIAvsLsqIfpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 14:51:00 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 14:51:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Thu, 25 Apr 2024 10:50:58 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <935E19A6-752C-49E7-8D25-8091195E0104@nvidia.com>
In-Reply-To: <815e2114-f739-4f2f-b09f-a23a2fc3214b@redhat.com>
References: <20240424211031.475756-1-zi.yan@sent.com>
 <CAHbLzkq61sTeRxU23gg3kMNBunxXH3GpkL6D56xcaepsDzFCJA@mail.gmail.com>
 <C617533C-4926-4FBA-8275-4446FDF48F31@nvidia.com>
 <815e2114-f739-4f2f-b09f-a23a2fc3214b@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_632007BF-731A-4F69-82A3-A1AF8048BB9F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0012.prod.exchangelabs.com (2603:10b6:208:10c::25)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: ca135c3e-4810-4d84-6972-08dc65371f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2pwUmtlR0poQlFGVW1vN3FKaHc0R2tZSGdzSHRLSWZkdkdsOHhwZW5TbkVh?=
 =?utf-8?B?cHNFZS8yYXhEWEp1TDBnUzVFOFR1NjBkcVJubERqd3h3eHRBUEhudTF2Tzl5?=
 =?utf-8?B?b3hucXNtM1Jkc2tUYjBPaHNVNzJVUnRHMWZpWHJ4UGJOcy9SM0liNUFKcnFZ?=
 =?utf-8?B?S1daUk9oZ3VTYlFQNjdnQUNHQU5vbzI5UHFmU1FLb0dvMXBLSTNUUktONG1l?=
 =?utf-8?B?Mm9jQTNMRXljMWl2MG1qL0FqZiszeUY5cmZJVnNlc2ZHV1cwbFlXZy80MFB1?=
 =?utf-8?B?MzBEMjlTeXMxU0JSVjhjcnZvQkNkWFlEb3luRStib2Uvcmd0cHJTZlhkS293?=
 =?utf-8?B?czlYa3lmMVJtTDNLT3RqbnN2L1dFRTVmWktCV3RrR3diVU5MUHY4Z0w1cjYx?=
 =?utf-8?B?UTE1NHpjWXpZMUxmYllUaXA3RnJqUTZGNjJYREY4VGlpd0M5N0FnbDBRcXlY?=
 =?utf-8?B?UHkvUzArU1NwdkxPR2JvOURPUGt0c2M5Q2FoNE9JL3FkeEJMNVFrSm9XbjBx?=
 =?utf-8?B?RDY3MHNMNXlpSmJJSkFXb2RxTHZJQWdKM1FwL3pnWkcranY4dHRhajdRUlZT?=
 =?utf-8?B?VjF0L0p0SXZkdW5PNlI5SFdlT210TmZOVXV6dGdWd0l1ZzJianpLTEFHc043?=
 =?utf-8?B?NzZzWkdlVFVEZ0YrTDlySnk5UFBTTWRJelcvaE4yYXVrZkNrb2h3WDgrZHFM?=
 =?utf-8?B?Zyt2bDg2RkQvVFZMWHJpb0s4OTZsSEpoVkZSUUR3RGVBc3FxYk9ISFhOUTRG?=
 =?utf-8?B?U2Mwc0ZNNVkwRFdsNHYxZjdjdkVkUGkwdkRPVi9mR08yNHg0cHFRU3BVU2FW?=
 =?utf-8?B?azRqL2JsSnhlYkpKNHUvdzM0ajdNNG5heVBYRDhBRGlUTkFGTnpSN0hqQUhK?=
 =?utf-8?B?U085RTdKdXFJYVNXbmZZUGNubDZoVkxoYkN4bUhSdlhWcytOejI3a1A1NWUv?=
 =?utf-8?B?QUNLVCs4YloyTndsN1FtRkxjWjF6QndHTmcwWEZEZFc1anlML0w1RlQ3QnBs?=
 =?utf-8?B?QkNFcERHbmRwTENwY05vUktINmpPekYzMXVTaC9zb3JEZ0YzcVpQVVZOS2Vr?=
 =?utf-8?B?dUZBRFdhdHQyY1VzeldiZGVhL1g4bE4vOE9ZTWZlMEdPYjZTWmVSYk5DNXhJ?=
 =?utf-8?B?b3k2WHMzOVB2RUxNRTBEOUYxbjJ6dGx5cTI3NjBMa25wM2UvdlVDK2pORHF6?=
 =?utf-8?B?a3VQbnF0OWVUWFFkOEFnRCtpZWtZOFpacGFxRElhYTIwV2thOTNjS0RQVXpq?=
 =?utf-8?B?aWxwc2JHUHE3VnlNRzQyOXh3Y0NoWVFjZkt2WFhreUhyZXRKeVluMDA4Qmp5?=
 =?utf-8?B?Qi9lREI2RHJKTTBmTnZBdEVMWVlzT3hzZW12emVvTm1KOEs1RmM2S1dLVnpZ?=
 =?utf-8?B?bXh1cTlOZWtBSTd3d1NocUFsdVpxVmE1N24wVEZiZTlWSnJDeTExMlJVNEJ6?=
 =?utf-8?B?bnJQUDlCOXVNSnQ4T0pTRHhXc0JqcC90STlHTGxCK28xUUZ6ZGxnL2thR00r?=
 =?utf-8?B?V1hpcGovZUhWWTRiNjRlc1IySGdES09GNEhwM2xGNGZ6L0lHTHNOMWNWdGF4?=
 =?utf-8?B?K2NtVUNLbWRTMjJBYW9ubm9mMXJvVWgrRDRyYXIwYWRZd2lWMml6Sk9NTUs0?=
 =?utf-8?B?SzUzY1FHZS9DbHZnR1NQMTdzN1VJYWVXNkl2TUEwekhmWFVmcHgyVFJEak84?=
 =?utf-8?B?YW9IRGdCRnBWVE5NSHg1RTZEYVdQUU1OS3lsSzBUa2V1MmxjWTJtSFR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWJLeXowaWtvVDFCZkJ1eldVeWRFUm9rSmVHWlRQdkxQSDlqUE85a2VpeEww?=
 =?utf-8?B?UjBiV1I3UDIxWHRoQVAxK2VjZlNNMkRtUksyOTJBQTdTR3Z3M1hQN1pkY0Fh?=
 =?utf-8?B?ME5Ha21vYnNiZ1VEdWJ1K2VJS2Z5VGpDblMxZ00vNUhhVVFDVGlqQ2Q4WjlI?=
 =?utf-8?B?UFZnV1VtMjdWQ3haWGpXaEp0bHEwNWRoT1ZoRFhiQUluZDRVdGJxVm9jQ01y?=
 =?utf-8?B?WDBJYmhyRDQ4VGd5azJGOUhUc0g3ZzJ6eFFPbE9mT3F0UGNSVGMvTVBjQ05R?=
 =?utf-8?B?UitFY3V5YUZXUHpGUXN3Mi9nT0U2S2M2R0FYL1k0bGorM0JWZkpzTlUrMHpJ?=
 =?utf-8?B?b0IvbWpYd3JhRzVvYlcxUWJuUDQwSEg5K2grL25mV1N2Sk1NR2ljdTQ4eWY0?=
 =?utf-8?B?cy9XeURmT2JFSVhzTjV5K0ErMHI5U3lWU3VjbUFXeVZTK2NuWkI3QUZrV3RT?=
 =?utf-8?B?QnRRUC9xQm5TankwTGZ1eFFjUHYwWndHeXZaeE41V05GRkphV2xPdXZxV0dU?=
 =?utf-8?B?WW5kcHpnVTArMzNTVlpxTktNamRsM2dCRE43emhMSU10Y2dIMGlyTWxnN1Fs?=
 =?utf-8?B?azhkcmhTeEFxSzRFNHhraWZ1TnIxbXk3K29KOERadFdsK3VpYWNtcFRiMGRX?=
 =?utf-8?B?WUFXVnpEV25EZkZsbm1Ic3dLZXNvR251NmxsbTFXclZibGozSktWV0pEb1hZ?=
 =?utf-8?B?TklnQ0h5NHkxQXI0Q3Y5NU9GTkNjeWlrQjIzZjVqUHdLR0hPcHhac3JIMU5p?=
 =?utf-8?B?UG15NFF0cmVhTjZYQmtwOE5KNUtrS2dmSGZZTXpTTlI1dUZhSjVBK0h4RzNl?=
 =?utf-8?B?N2UyZ2Z2RDNlZ0hWV0FzbzJKRG1ZNnQ4eE5BVXBiZ0MwNlp3OTNaRndBR2VX?=
 =?utf-8?B?T2wvaWhVZUVBamZuME1DZjdRbWQzVXYrQk9ybXVWTlJyL2t2cWZuMWpsWlNq?=
 =?utf-8?B?QXJwbmFXaTAxSHRMN3Z2dFR1dUtYcE1KMVU4ZEVyTUJnSHhPM0NJZFZCYXh1?=
 =?utf-8?B?Nm5BUml0UTVrK29tbmY1YUczV0R4MGg2NzRGVUNzV3FWU1BtdE5nREZQVzkw?=
 =?utf-8?B?R01Xa2tDcEtmdFBlZ3h3czFMYW1Qd1BVVXNBM3VXb29HYkM5OVZ0Q2NDeDEx?=
 =?utf-8?B?UXpjWTRVR1NTV1pHVXZVQTVxSzljbS9CWFIxMFpBZDVpTGpTbGl6eWtTT3Fu?=
 =?utf-8?B?MGlRbjNRd2tOTkR2SE9FMFkvNW4yazFDV1lucmZFTE53NTk0VTA0Tm1zdER5?=
 =?utf-8?B?dmdzRDdaRDBGVVkzWkgvU1RtaVI4NTIxTFRML1pHcFpza0hjT3FBTldDYm1U?=
 =?utf-8?B?UE9BSlJnRkZwMjdCQTJwWmluTnlSaktXRWtOM3NRK2VDQTlBTjhPMUx6ejQ3?=
 =?utf-8?B?Y3BjckFkNzB6eS9oQVpJQmIxNjRFVGduREJSaHIrL0ZYWUVsalJtVVAwNXVO?=
 =?utf-8?B?WWNxb1RPaFlvTUJYWThraGI5bzUwYzRHdDhPYU5EWlRIVzNqYkQvdThUcW5a?=
 =?utf-8?B?bnpZUlk3M2dvdWJvZlB1M1RiM3l5KzNqMkVvQkFoNWdTS2VXV0lCN0RmV2Mz?=
 =?utf-8?B?UHl4SkU3NnRnREhFVk14eURmSUZZbWljNUFsSTRHbDZydkdvcjRFUVVRQUZY?=
 =?utf-8?B?WXJWeEo0VWhzdXZxL1F1V3VTZXJzaFlIbFU4SVhZT2dUdXRuNFNlL0tmZHp1?=
 =?utf-8?B?ZytaZXpMbi9ueDNpSHErNjZROExJQnNRVW5Gd1J0R3ozeU05c09ZeDFBZnhZ?=
 =?utf-8?B?UGRBUWhCNHdZTFJvQnFsSENranVGQWxtaXNpeldieWdqMTRCbHNheXFuZjV3?=
 =?utf-8?B?RnhDaUF6SVpCcUtzMk1leVlTclF2OWpJWWEyNzFFdjFTSHZqUWt5SnM0MTVt?=
 =?utf-8?B?azZjcTFvalBPdjFCb3d0QlpJazJMUGM5elpwZFJlQzl2aHZ2cnVSZWRUZUdR?=
 =?utf-8?B?a0ZSUGZtbHFXVHRiSmQ0aU44OGVBVlQza1cvZFV4SkJja2ovQTJJR3V2Smdu?=
 =?utf-8?B?ei9OeEJRY2lWSGV2b3ZzUDRGdXVqSDdqQk1NZURyNDlQQ1JoY2VDTVA3TERa?=
 =?utf-8?B?bjF1eUF2ZjM2SGlGQ3ZCTWxUbGdEY2xCcHVpMzlGRWlrUXEzWnFNRTdkdTZs?=
 =?utf-8?Q?HtyU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca135c3e-4810-4d84-6972-08dc65371f32
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:51:00.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtnsK/YNf5PoLCYLq2+BDHN/BnvRVh95lQIoYUDruLNvWmnKhXERJzudYTKV381z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343

--=_MailMate_632007BF-731A-4F69-82A3-A1AF8048BB9F_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2024, at 3:15, David Hildenbrand wrote:

> On 25.04.24 00:39, Zi Yan wrote:
>> On 24 Apr 2024, at 18:32, Yang Shi wrote:
>>
>>> On Wed, Apr 24, 2024 at 2:10=E2=80=AFPM Zi Yan <zi.yan@sent.com> wrot=
e:
>>>>
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
>>>> if any page in a folio loses its final mapping. It is possible that
>>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>>> to deferred split list at all. Fix it by checking folio->_nr_pages_m=
apped
>>>> before adding a folio to deferred split list. If the folio is alread=
y
>>>> on the deferred split list, it will be skipped.
>>>>
>>>> Commit 98046944a159 ("mm: huge_memory: add the missing
>>>> folio_test_pmd_mappable() for THP split statistics") tried to exclud=
e
>>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does =
not
>>>> fix everything. A fully unmapped PTE-mapped order-9 THP was also add=
ed to
>>>> deferred split list and counted as THP_DEFERRED_SPLIT_PAGE, since nr=
 is
>>>> 512 (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_f=
olio()
>>>> the order-9 folio is folio_test_pmd_mappable(). However, this miscou=
nt
>>>> was present even earlier due to implementation, since PTEs are unmap=
ped
>>>> individually and first PTE unmapping adds the THP into the deferred =
split
>>>> list.
>>>
>>> Shall you mention the miscounting for mTHP too? There is another patc=
h
>>> series adding the counter support for mTHP.
>>
>> OK, will add it.
>
> I thought I made it clear: this patch won't "fix" it. Misaccounting wil=
l still happen. Just less frequently.
>
> Please spell that out.

Sure. Sorry I did not make that clear.


>
>>>
>>>>
>>>> With commit b06dc281aa99 ("mm/rmap: introduce
>>>> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-ma=
pped
>>>> folios in one shot without causing the miscount, hence this patch.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>   mm/rmap.c | 8 +++++---
>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index a7913a454028..220ad8a83589 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
>>>>                   * page of the folio is unmapped and at least one p=
age
>>>>                   * is still mapped.
>>>>                   */
>>>> -               if (folio_test_large(folio) && folio_test_anon(folio=
))
>>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_p=
mdmapped)
>>>> -                               deferred_split_folio(folio);
>>>> +               if (folio_test_large(folio) && folio_test_anon(folio=
) &&
>>>> +                   list_empty(&folio->_deferred_list) &&
>>>
>>> Do we really need this check? deferred_split_folio() does the same
>>> check too. Bailing out earlier sounds ok too, but there may not be to=
o
>>> much gain.
>>
>> Sure, I can remove it.
>
> Please leave it. It's a function call that cannot be optimized out othe=
rwise.

OK. If you think it is worth optimizing that function call, I will keep i=
t.


--
Best Regards,
Yan, Zi

--=_MailMate_632007BF-731A-4F69-82A3-A1AF8048BB9F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYqbdIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU6DsP/1FJeK3NdoYepMuNpvyJfGXE+nlnSkIx4cd3
h/jh6q43eQriaDdosq827FOa1qiAMc0bNlK//4FOQmoTEh3kU9TspLqlCZapCrHo
2acWnyQ7TqzKFVgIWaZLqUvqeYn9PQw9cdBrA7vrXw/eNQPQPLoiN+Yqj07C/tJS
ZQ8xQV6aZcj54Ks1dyxwwrTVDmmb98CDNUx8nPgtIYBwE2bDIi5vxMoK/CN+EZRi
fi1/xZ3dbIcYCYb1JyRjS48N4VDIIs9rLUifQfuN8bEhP2msBEAeYoREpuNJFAUI
ajrh7wOLw8DbXuH8U2WoWI0hASENyHUW26Obbvb4waF0Exzm3rOhrLOKQqIRLmlD
9JY1c8wtUxUmLiyArEsH6isaFKDnmM2QzGK3kyufU4D4os9zVLsX5rRXYhjGy9AI
nTEfkVzYxIIent+nFv/VydSZEdwEAtAzKWOQh4lVnEfXuI5OVBgwX4UhJrAmZPph
EbJI6lbCJG5n3hEbdXXVOBukH7VTnqD99B/i5NFXlBkObYSYx7OOZZmcNWuhQIxE
E/1b6H/S4xBhgWQVnb2sezlLBgSRuOtjNAeKcL6u4PBcWPsrDbJFf2bENSSOfdRr
5rKi750F5cqKFwsRnIabjgjiTO0xAMVWPH6xlmm6cGfegGXicaWK4ffgvhDVEpQH
w0oslKRS
=ZMi9
-----END PGP SIGNATURE-----

--=_MailMate_632007BF-731A-4F69-82A3-A1AF8048BB9F_=--

