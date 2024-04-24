Return-Path: <linux-kernel+bounces-157794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C78B1644
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E111F23BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9093216DECE;
	Wed, 24 Apr 2024 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwWMN2lQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF81EA80
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998389; cv=fail; b=A2ZFRNDWAf2WRqsDE2XAoPnq+Bu0yAYVeFFzviOZHObVlcFybUOL2PNRmLS0YSHv3PRMGVbOVQIeQc/dcYzzss2JoSOM7a/gWa9gh9BzPEU+U/CHkVDs5RDjTZKVWWgG0ABC8we7IrcSkZ33iYIXlIW/Gab4PqSbeoQztid8C6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998389; c=relaxed/simple;
	bh=ftTNQSdG/W2JeW/hnpcpKR/fJhfsUK7h64IpeEYwSPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ev8Bc1EA/OB4QPhInWdLNj5LnQKQhSjS/4+7iXmbKPeJMMueR3Uz9abhbLeP+VKloEXfZ2c3YjkMZZYr216kokH2/YQ8mIfahFFOoYs73dLM9SkjVembXXtsIAVxqGwtAscXeYYoRSmIKCGWn6ewy4VLFPOVeoZtDuqMBgDUiC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwWMN2lQ; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz8E4HbHhEpUAnIYxn45QikVDJ8TWMXsbbNNRFKezdBUYNj6A9tPTLi0QI490jIooPRybK2z/OhIPZTiq15APuLr11NzTRliW0310jAcwUKL6tki4X3Lvyd9QiXPFzlO0AdK3zt+g/z/r0xGNWll9lJUNHSj0qFnJCqw3DxGHo0IqrAIgpYVkgjk6N5QW4KrRncTeI9ho2X9wu/Dk0/2M3NYlaJ9rSx73ki7141thbeX7sFkexhIoP86XGCYzYyTYa8CAps8kMsNIbEyDEgI9dENCcnhRVoGe1yoCEIlTtSDUxJ7dI0fPhQsY/VfHVi/TJmKwPSXxVftLnzO9JifBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbG7sb9iTQTKbtXv3D9xPMCBO0YmgpG/DwKpRR+G32I=;
 b=ljTpQKidTSl/nSv9fla3QV5VBkVmFzs31MLETvKP8m5nYD9OVtdG9JDdSm7NZec/VKA5z8E8RJ/tCqkPxymT8TbajydMf7XDDaowykoqXSB+s3jDEF13AtPM1N991fGv1hneNlrdHdaQ/2BhN9a97xP0bVpfv+K0VWHHQqkYOjcN7NBpy7WmHzZSzi6Y+DqVIGyQx4Hv2FM/Vex0ibyZbqFOcGS0HxSKzAkSJhmX5dwJSOqx2FxmVHfeB6hLf2aLrtYk6pqFCkp7RwrDPOloK6rH3VDwWi9JlmYsUwdfDDJrnU5yjkfIVT+cvjBPkG4GoyCxVSoQeRudvZB1iXoX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbG7sb9iTQTKbtXv3D9xPMCBO0YmgpG/DwKpRR+G32I=;
 b=lwWMN2lQxVQq5CMMdsgAcXQbWslFkTNFAISe/Vw4kHaZMf5mS/fSjebtJe6Vl8ktjqJSoCsqRgLK4ENz/gucUNB7RWqWl3LR+YQlsmhN5sI98UjzfIicleyZ/aed1COHPUfKG0+s+kjDw2s64Q+2iHfKWtas90hY/S6G+clJYJSA+zl7g/8kVqQzUkgKu5BOpt9Hu+xB/WzzCf9y8fgA4iCCM4y5FWHKFILx0L2+j79JSRDHSFToLpBU6ll0xpTilsVZ6efVtL3+9vYZUcEgbZBv24HzGfLc1hEZEcQoj+50EZwcZM/IAfOve9wC4F+imR/m9Mjj5yInxY9ffRT+1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.24; Wed, 24 Apr 2024 22:39:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:39:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Wed, 24 Apr 2024 18:39:40 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <C617533C-4926-4FBA-8275-4446FDF48F31@nvidia.com>
In-Reply-To: <CAHbLzkq61sTeRxU23gg3kMNBunxXH3GpkL6D56xcaepsDzFCJA@mail.gmail.com>
References: <20240424211031.475756-1-zi.yan@sent.com>
 <CAHbLzkq61sTeRxU23gg3kMNBunxXH3GpkL6D56xcaepsDzFCJA@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4E2CF516-C937-41EE-991B-24E683F9E68D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF0001641F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:f) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 95764397-6e84-47b1-050e-08dc64af6f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1Rwa3pMSHNpOERXS3JBcjZTdFlhTHI1SmFOQmVNV085VWl0Rnh1dFY1Z2J0?=
 =?utf-8?B?QjN1YTZhQk9iRW9nR1VFd3FEL1h6enpEQmVUYXNZaGxPQUZxQ1hmQ1AvOTNj?=
 =?utf-8?B?WmM0WGhMbUZITG1ORDZ2NXBieTJXZ2NlbkVubUlhM0xDb1JNREhhQVh6Y2lw?=
 =?utf-8?B?YUpyaU96L2tXWUJiY0FkTGFnUERrN1hkRWRNVVlaY0pRWjlIcnhjWTU3RmtS?=
 =?utf-8?B?NFo0eUdtdG1KUVpTMUp1eGN5UUlpSlhOWjJlVDl2ZC9uZHdnMW5Fa0NLajRr?=
 =?utf-8?B?ak5nQ1AyOGxUWXZXNEEyMi9YdkF6UWplazVxOVkrYWRLUGRIaE1iKzQxZkFq?=
 =?utf-8?B?ZDYzTUU0Vnc4L0YwSFdRTzRaL2ExT0xqR0dvb3NmMTFhSzlyK3pFNnorR3dh?=
 =?utf-8?B?Z3BMai9Pa2pVK1M5aVo4WkFGZEtPM2JXTU9VV1QxZFhNSTIxeDFuR1JpZjdK?=
 =?utf-8?B?ZDBkMDRWeTRpVmRFWVh1QWFINTNSbklKQ28zWTdNNVNyZjFkdzNTZ0xBNG5M?=
 =?utf-8?B?NmJGUEVLakZFRFFMeUg3d1lsV0FkN2pNaEdyc0MzQ2VISEE1MDFxdG5xeFY4?=
 =?utf-8?B?dE5Mamkwa0xGajQrU05GaDJxai9nTGx3RHFVNDdUeDFsT1dxOGZrZEMxTmcr?=
 =?utf-8?B?QWhoNnRhRFJKQUd2Zzc4TDNOK3Zid1A0S212T3ZzS3NsYXhsYTVRWXh4NkNl?=
 =?utf-8?B?OGp1T1N3S2FkM3l1RU9lZkVSZlJ1NmJlNXk2cUNYNVBrcWFWSFZsVVptUnEz?=
 =?utf-8?B?WVIrQktDK0x0aDI4OEtxRjNaN1pyTEVwek9tQW1iMU5PR1RQUnR4eE9IM256?=
 =?utf-8?B?cktqT3JraGJmbU9ER3dqMVFzTDUzUDlnRi9mQU1ybUxhKzJIQ0lla05yZ0VP?=
 =?utf-8?B?UTJ2czlTZmpHSVVTdGIwTHVVck5xeHZpM0swZDloblZSU3plaW9ta1JGdk5N?=
 =?utf-8?B?bzBRREg1R0VUUWcxSkJFVk5rYnlBelMyMU5IYmtKOThjWlljY0dBcXBDYUhM?=
 =?utf-8?B?S1o2KzhrNkh5TmJRMUY4RXVYbWt6ZThvWDVjc2dWNCsxT0xIMm80NmZzbWQx?=
 =?utf-8?B?SG9ockVMMWxhSVl3aFFaMWNOaWlJOUN6K25PSkNoRmhaOWt1TnBuQXlQY2Ra?=
 =?utf-8?B?ZEV2NDNlbzA3Q0VUc2lTbWx4TDJWSzZORFJib2xONEEwNjFOdUt4L09uQTlD?=
 =?utf-8?B?ZUx6Z1RHWDYzUGRDSFgvL3F4VVpSeStJNW80ZjlWbTQ2d09UeVR4YXhPREVG?=
 =?utf-8?B?bXJJVEVNSTh0b0V1dFV4Rks0T3ZiRFlEbHRMY01aSkJMVnlGNjlxcWhtMnRx?=
 =?utf-8?B?dEF0YldjTi9uMmZWMDZta1hzZmtGeW9JaVNOM25sVVFlZzQ4ZHM5dDFabHA4?=
 =?utf-8?B?MHFUNGhpOEV6UWZBY3F0VnVhbXNWRUtjYzV4SE8zdEQ5YzFEa0NucVRPZmhG?=
 =?utf-8?B?cG15SnlNZUhVWFQ2cDdaUkl1TUYrZlMwQUZ3UjNla2daQWc3QlJKSVVEUjY1?=
 =?utf-8?B?S09kM2szdktJazAzaTZqZWxwb3lRVlpWMjBGMUdaenNZdkZtYURVcWdBMUU3?=
 =?utf-8?B?ZTg1TzZrSERQVm9GNjVuaHNZditaUnNMb1QweDhnT29GNlZmMGlkRmptS3U0?=
 =?utf-8?B?NHpWUVlXSU9zdFVkK3hQcy9ZRVF4dTdqNU1TSUZKYmRMYzVBK1kxUkk0UzJw?=
 =?utf-8?B?SjQ5TStqUmthemRpS2JaaEVKUUtGWHlkWFVRNE83dWtYVjBURzh4cTBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWdVTVFqOXFYT3pHZW8zWkF5RmplYjh4dG1YTFlqMkVod2RwWldxWmxjbXRN?=
 =?utf-8?B?THZrdVBkSTFmclNZT2tBSFQybWxGR21HU29WUlY1WTNmYmdUdUlxRVprWXdP?=
 =?utf-8?B?aUlGZHdoSWlucElib09aY0hRY3VhUUtpTUNGelczQU5raFFzak9xUkpKbGo5?=
 =?utf-8?B?OGRFV3FNQ3dEaEdpS0FJa2h4Q1BkVVo4dGVWaWIwbjMyUFdHVW5rTFpqbzZp?=
 =?utf-8?B?TytZdkNVRnQxRkdKOVFzSkpMMW1xM2xLRlBBM0VKZlZFcmNNLytDZ3RtdUYw?=
 =?utf-8?B?WFlIVktKbGpmWmE4dHlud0hoNlhZMGYyV21GZVRXcGNQc2FFVmc4MkhVenBu?=
 =?utf-8?B?eC83SDY3WWs2ai8xazc1R1F0d3Y1SHZuQmFhVUthYS9JZHVwTWdyWU84N1pY?=
 =?utf-8?B?dUlaWUtuMHRVUDF5S2pZSlFwdzRTenFjdGVtMUdqWkFOajIvMldWa2NBWGc2?=
 =?utf-8?B?dFVacE9pWVNvenVuZFMzbTRFRGx5ajBoaC9ZSUpnUFltMTV0NHVRRmd4SVZI?=
 =?utf-8?B?bzkyWVBlaU1odkZQTlpZUzlBaHJ2RmlCakVtQ1BCMmxncVlQc2NrYU9UcXQ4?=
 =?utf-8?B?dURwZVpKdUVCaWk2UVBpMyt0WVowaUhLd0ZhL1o5NndLakdoSWxrdnJReDFT?=
 =?utf-8?B?aTBXUzhwcnJkd2JKdkhBb1ZUdU9aaisycEV4RmlWeHVqY2lXNFpMZ1RWVWJ4?=
 =?utf-8?B?U3E1WjRyQmFwRkZoUU9HandxbnY2RDg1K21NdnNmR0lxbTM1YmtmL3h5akNE?=
 =?utf-8?B?RzlVQzlFcFdiSm1aY2ZDbFVyZUd5MVk2VzdQTmhlUkhQSU51ODZ3VEtpODlX?=
 =?utf-8?B?TGVvZk9TaVN0YWw1cGZRdjQ5NUI2by9COWZXSzRyM08yQzhScWllRnVQemZK?=
 =?utf-8?B?em1zT0tPdFJoam82empyQXM3ZjdmRDZKNWlMZzFYV0lkeEl4NFByOGdpYUcw?=
 =?utf-8?B?bVFNSUdsRFQ3dFZoT1NXTWJDZWhuUEZiUnU4RE9ZZnJESjdtVy92Y1ZZWlRL?=
 =?utf-8?B?VFI5VTltaVdnSjNPUTNpYTNScnFVNWpOWVc4UzVqbTEyMUJSMXdOUUo2Wngv?=
 =?utf-8?B?ajdTMFpLdEtrdkFhaGJJQ3kyN3htSitBMVdERzNkRnVjSXMyWU9UdzMzeGI3?=
 =?utf-8?B?L3Y4UlJYcXR3QkFRM2VRSWN6YWRNMjkxZjUwRjFFQ3RieHBHcDk3eWNVM1d4?=
 =?utf-8?B?NlBaV2EvUnBSbWlWNGtDK3AxczN0Tkh4d0lTUTROMU5WT3FaOTJ4dkRidVNR?=
 =?utf-8?B?WnZ4TmhMSjgrNHRyN3lXS2svZ3E4Ry9qM3dyOHVFSXg3Ui9FT0luYXM3MlpL?=
 =?utf-8?B?djdEZitPZ1FkM2RjdFpFR1RQZWN3aldqZDVPelgreVdiMmN6OTdpcTdiT1c1?=
 =?utf-8?B?bnoxTU85b3VnaHVyQnlyRU1hSTBaMTFrSWxNdjFlTjU1ZlhXKzRkVjlOTEhS?=
 =?utf-8?B?QVhPeUY3ZGpQZ1l5VHc0TzdwYzhRL2xCZHB1Sm45OWN0dzZZak9sR3NUcTlI?=
 =?utf-8?B?ZFFZbTJwZUNJSW5UYWU5Rk5DWWRZdzhubnJpUk0xUC8rNjRFNnpSY294T0ZK?=
 =?utf-8?B?RXNNZ2w2eExLZytzUmVBMmZKbzN1cHBTMmhNbDM4Yk1pZnY2Rk9KS1VTVVpr?=
 =?utf-8?B?N2EwNjZHM0FoWFMxeDdJVE0xOTdsRFVzSDdaRDJTS2VPTXB0Zk5QZ3lYV2Ns?=
 =?utf-8?B?NmJKZE1Manh6ME43ZGNGVnZmd2NCWFoyRlgzUllMdVZaNG5uRUsxRjlocmxr?=
 =?utf-8?B?c1R3ZFlaTWQvL1V1aVlhNkFtRU1VSEM5eUpUS0FpQWpNOGNyUFlzZnJQa1Vx?=
 =?utf-8?B?ZDdOSm1oNENLTTlRMFROQjBIYmhraFBiMTFWUTZVVnlkZjlLbThObHBhanFw?=
 =?utf-8?B?OFV1MXZyVmtWVzNhdWEzWm1tTFY5UGo2VWJZbndEZ2VFemdQcnFUMzFSU2cx?=
 =?utf-8?B?cTlFd1l0bllzQXFIZVJqZFYwaDBZUmxYcnNTYzZlMHNFbjEvV2FqRFBhdTdR?=
 =?utf-8?B?SENJMXBaMDQ1NWdyVWs5enV0aTBlcDl5cnhjaUxtSURWUXc4Ri8yaVc3cWRm?=
 =?utf-8?B?Z3ZMMVBKZ3RYV0REYStvbjFPMWMwU0xMOEhnWlVxeDlvQ2FNVDBTWEpWbzZ0?=
 =?utf-8?Q?5KHk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95764397-6e84-47b1-050e-08dc64af6f0f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:39:42.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x7z2fec7gurlWxJoC8E/JvbVjYpWfgL54OKGpVFr1KTxw+g1jaC4NVKa7hx73yO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991

--=_MailMate_4E2CF516-C937-41EE-991B-24E683F9E68D_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24 Apr 2024, at 18:32, Yang Shi wrote:

> On Wed, Apr 24, 2024 at 2:10=E2=80=AFPM Zi Yan <zi.yan@sent.com> wrote:=

>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
>> if any page in a folio loses its final mapping. It is possible that
>> the folio is unmapped fully, but it is unnecessary to add the folio
>> to deferred split list at all. Fix it by checking folio->_nr_pages_map=
ped
>> before adding a folio to deferred split list. If the folio is already
>> on the deferred split list, it will be skipped.
>>
>> Commit 98046944a159 ("mm: huge_memory: add the missing
>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
>> fix everything. A fully unmapped PTE-mapped order-9 THP was also added=
 to
>> deferred split list and counted as THP_DEFERRED_SPLIT_PAGE, since nr i=
s
>> 512 (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_fol=
io()
>> the order-9 folio is folio_test_pmd_mappable(). However, this miscount=

>> was present even earlier due to implementation, since PTEs are unmappe=
d
>> individually and first PTE unmapping adds the THP into the deferred sp=
lit
>> list.
>
> Shall you mention the miscounting for mTHP too? There is another patch
> series adding the counter support for mTHP.

OK, will add it.
>
>>
>> With commit b06dc281aa99 ("mm/rmap: introduce
>> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapp=
ed
>> folios in one shot without causing the miscount, hence this patch.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/rmap.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index a7913a454028..220ad8a83589 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
>>                  * page of the folio is unmapped and at least one page=

>>                  * is still mapped.
>>                  */
>> -               if (folio_test_large(folio) && folio_test_anon(folio))=

>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmd=
mapped)
>> -                               deferred_split_folio(folio);
>> +               if (folio_test_large(folio) && folio_test_anon(folio) =
&&
>> +                   list_empty(&folio->_deferred_list) &&
>
> Do we really need this check? deferred_split_folio() does the same
> check too. Bailing out earlier sounds ok too, but there may not be too
> much gain.

Sure, I can remove it.

>
>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mappe=
d)) ||
>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped=
)))
>
> IIUC, this line is used to cover the case which has both partial
> PTE-mapping and PMD-mapping, then PMD mapping is unmapped fully. IIRC
> this case was not handled correctly before, the THP actually skipped
> deferred split queue. If so please add some description in the commit
> log.

It is properly handled before, since the original code is
(level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped), meaning
if either level is RMAP_LEVEL_PTE or
(level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped), the folio
is added to the deferred split list. So only level =3D=3D RMAP_LEVEL_PTE
part of logic needs to be fixed.

>
> Otherwise the patch looks good to me. Reviewed-by: Yang Shi
> <shy828301@gmail.com>
>

Thanks.
>> +                       deferred_split_folio(folio);
>>         }
>>
>>         /*
>>
>> base-commit: 2541ee5668b019c486dd3e815114130e35c1495d
>> --
>> 2.43.0
>>


--
Best Regards,
Yan, Zi

--=_MailMate_4E2CF516-C937-41EE-991B-24E683F9E68D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYpiiwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUsBoP/i1R6Eg/O3e4UD3vZje97FdyclYWCutpQ1VD
4iTRaVY8ZZ6+1nix1RLWzrl9CeHTyXUTHn11Or8AikWero4F3oih+uoc3LOZpSu/
qpCcMR+86KSgCvVoBY9zM2n28ptz998ytoJ32WMvSad4CR+BCgwyZGnoNjZpB/bm
nCh5he72Unu77aHtQbjBbsmAguwcmaHEzkVGgLP/EpSkPnH6wZAaknfMfpC3iRCY
dhpkSthImGYCxb9DWZKbG5YLGz1EKaPaniu267GXT4BProW+0G1yM5X7QxO8NTqd
NKDQ6g6nOAlzVPqzSYKTkFSJ7uzLwGYXE6FM0wONwCJclDHttGNPQxFNSnW6iZaz
6M3oAXtTNRFetRW1cVltBv38TBM4tOeiUjGfUjbJnnQd5z15AqcGwFe65gCrHc1H
PyxNlACEOuzxHEApZJxkt6VeLDRV0cR4gpW+6V7SGLmzHKAeTjwC7RG9rsTPOPTe
wJvowGMSEKxcKLNfYTgiVjIQDLAoy3qtAjn5tBmvDUtLnMXoSlItYVqVY9TdA1jN
nm2qPzCWN2mADVk2jFJ/2ypHZbxgMLYtxmVxRy5T2miBvTuO2yXxH5oSXCGh5o08
3ifiwHf8Vi9pQRKXGP4LBlbYKuFgrq+O9MEP+BdTEaFUqLYiaIoH66xATOf77hN2
Udx91HNp
=q/Fi
-----END PGP SIGNATURE-----

--=_MailMate_4E2CF516-C937-41EE-991B-24E683F9E68D_=--

