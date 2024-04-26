Return-Path: <linux-kernel+bounces-160083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001318B38E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB044285FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3314831F;
	Fri, 26 Apr 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="h3b4oHUZ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B0F147C81;
	Fri, 26 Apr 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139349; cv=fail; b=o6Hf1R23Gs4AeAtbB4830tE5j5e653qcVIIMwkYrD+EiEB113pLdODKsdEPypueVXZEkAExkBJgdXtFwMFj58CAc4kT1XiW0PQAbh7jXx9jC4IUwq4rutIa8terbyqhks/pZ6d+Cc16VLiI1vhrmVu5UaWqhbXnZjR4CjNBv2Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139349; c=relaxed/simple;
	bh=uLsur3497yqqCccaXGYSO4KQ1yqAEHTAvaeJFuqR5ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QeMrCNcqm3NHcpQMEXcw9Hf3yevF8lMLqp8FYd+7PhoV03YHL13u7WPiAQEvM1UbunQ7vBrmm77mQwvnQl0hXO8M1/2n2ZYcF5xc60Ss6qvUGSkl36SjzbOvl/0iTXw/DzT2XRKJTwuKfR/IaFklm3JfBPHVfcUHo4/fC82yQQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=h3b4oHUZ; arc=fail smtp.client-ip=40.107.244.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q24Dm0s+zFecTU8n4xFL1bppQnyLXa6OexbdD13lrl3h4YmHVATi1ufoWE1gux/eI0/AGY2jbsHU031VYonLQtI3tZvZBsPgZLECUVZD4gGC7SNXK5GSSvf5ZcRW2NrzQV4Y8iig7+ZYLNxvHKDk59uUwTeno3oW9CerIXEPIIqwiG47nlZAGz+rzil3AUvplqwxmCXrxzpj0b9Yhch8Ifbwvmzr+dhbYBoR6Np15sRWnbUFt6OVN43b8e1vh7KiI7GJVg88r1coFQYCR6Djm/bK6YQ/eHB49nyFKl8Uq7bV6vSTb4fbcImHMVs8eU/wqcpPA/y25v8N6f0oVWAR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gioXfPmbSfELbLc4acqFcMEenMB2u9OwHiXYtzoIv/8=;
 b=iAD51GdZXmz4q9nQAvw1eClhzy7zUnRcOYVrpgexenMEUOpnwxEhNCKh+Utc6qP9Gi+72uuijjwC987BbiupcQW+rKDWy1ShQFdXkz1eLCgTL78VgqnXgfi2RraY01INeJVSJmE8qutIKBLHiU+OfnNhJ24jecbge9vwyjJiM5XK8PZ/Ml58PWQUV7He0t6RIfs3hhurwZjXnk85q8TYM741ijMPYsHKfIZ89J5vopjmY0HM3D5uXMe33JzcjPMbFvwinw+jvOx8jhpNv63Zz5Lak0tziRbgz7YNjysxHuQK5UC75cljjOoOf7+uxfW8bc2XEjmM88Wt4RuhHwG4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gioXfPmbSfELbLc4acqFcMEenMB2u9OwHiXYtzoIv/8=;
 b=h3b4oHUZzAfBPePa84JdOoJ+0aIScPwmoSgKPr9I7m9FzLPLxSIUCZCmAie7X5r4KGjma616yct0Nw0M2J9hnfuix8uxdGZUbQ01PwXzXlZigNOMEAjDGo6cSwBmFhGGv7pX15Y0cnyrtfaFuPG40D+DldGEL9t4JLwi8nwaPuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6571.namprd17.prod.outlook.com (2603:10b6:610:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:49:03 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 13:49:03 +0000
Date: Fri, 26 Apr 2024 09:48:56 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: Dan Williams <dan.j.williams@intel.com>, axboe@kernel.dk,
	John Groves <John@groves.net>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <ZiuwyIVaKJq8aC6g@memverge.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
 <ZikhwAAIGFG0UU23@memverge.com>
 <bbf692ec-2109-baf2-aaae-7859a8315025@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbf692ec-2109-baf2-aaae-7859a8315025@easystack.cn>
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: fc08dec7-4e36-4eff-6e29-08dc65f7a22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnUvS2JKQStUeFdWQStoZnhqVjEwMlRoeFpkdXhpYkZKRzhFUlNucERaaDkz?=
 =?utf-8?B?VkxtQlpJekJKcHcwVlphSFdCSVl3d1BsVzFwRFlRTXc0bVNFbm1HUUNvcThs?=
 =?utf-8?B?Um5jbjFVQzQ0bGxTVEFXNGRFN3ZYOTNxZzZpOXNXTXdnZk9xckw5QTh2VWxU?=
 =?utf-8?B?KzdnbllqTVNnYnVmVSt2VFFhYmwrdUtDbUlsb2h2ZTljSk1hUERUVllLdU5Z?=
 =?utf-8?B?MXBOQ1VWcU4zSzRRcUxUbHBoS2dBTGlQNnM0TmlQUUtDMktYYnUwNUV6QnRV?=
 =?utf-8?B?TGRTQnhsaDh2ckJuL2cyNWNZZkR6R2RIQWo2VDQrdk9ucHlmaUxXaU1sMEFZ?=
 =?utf-8?B?eGNLWWJMT1k3S2ZoQjBPSVRHTWsxdGlrbUtDNm90aWJhcUw5QzY0Rmc3UTcr?=
 =?utf-8?B?TzNmOHJwUGpyMjd2aW9Xbk1hc2dKM1VjS3NzWUlBZHZ0bUFHRFZ6V3R0Z2lk?=
 =?utf-8?B?QnQ3R20xNzVDZXV6bmtQVHZKVy9WVVpRTmdhY2ZpNkFTNW1CZzJpa1lsVGJT?=
 =?utf-8?B?Mk1Qd1Jpc2NiUjNlVmhUMmpGT1RKRytoM2hxMmNkeHFzLzl0U2FuQkI3VXRt?=
 =?utf-8?B?bTRsSW1jczJDR2tiNUxGOXVNenI1TVNENVFITWt1TXhWMGFZMDE4Y0Z1dldP?=
 =?utf-8?B?U3BOYjlBMUZpbEtCM2l1U3VyME1YbHRzQ2VrUTNyc0VmWEY4aUluZjg5YzBV?=
 =?utf-8?B?dHVzYVgvRGFrd0pnQ3lKTm9mNCs0YTRBRE82ZFNaZFhFT1JjeHNiYzBDMkdn?=
 =?utf-8?B?ZDhrSWtHZFE2eVZxbmlYWnJmcVVJNjZKbGNXd0dlSWRKUURyRjI0MDdYODhB?=
 =?utf-8?B?Rjc3aHMvRkxSWTNCNnQ4MnB5MDdnbWJNNUNmek1qZUxiNGFtV2pjdXhuM00y?=
 =?utf-8?B?bitlVEVvSnBOTVJyOVBWUkUybTB3YTQxZ1hYVGYxSC9yTXNZU1lPMWl2ZFg1?=
 =?utf-8?B?RzlPbUU4Ri9BejJOdFljRXZQUUFUTDFVOHEyTUVTakFCaklLWW92bEZLNWFF?=
 =?utf-8?B?RC9kdnFJVUlmQkw0aWlhVlp6ejhKSkN2QzlBaVhpUGFuTFZzWU95SGNVUTl0?=
 =?utf-8?B?eUEvTzBrd0tKNWZVNitISG52V1cxZzJlMEllVWFnYUwyNURjYzZFbTVCZ1A0?=
 =?utf-8?B?UzhkVktmVk1FK1dOdllPTkRkRDNmZ01YUjNPWThTd2JOVE5CQTJlMDlNVG95?=
 =?utf-8?B?MXhBM2lYWWpuQVFaV080UWIxRUFEbzAvbjRTaDBVUEh0YjdwS1BzZjE5R2NF?=
 =?utf-8?B?YURzT2ZlRUFpTkZmOUVzVXB1clpEaHFWRUdMWjFnMWIyVTFORDdKdUxoamw0?=
 =?utf-8?B?OCtMM1MzcWVoZll3K1J2WThYWjcxdnl4d0xxR0JtTGs5QlAvc3oxM0tRUTkr?=
 =?utf-8?B?bkF0TktSa1QrQ055Y21ZWE9aZlIzTnlsYmlkUXJEa3dEMlVubG0yK0ZkejNK?=
 =?utf-8?B?UlhLcjJEbWk1MGY1VG1LOGtCdXpVMUNibFJ0QVp4Z2ZUQkZwbXFiSmt3SUw5?=
 =?utf-8?B?N2NkUTZoWllzVVdmckxVL2s5TzVreXlvdnJCZVNYSGV0b2s4dStFUUh5THIr?=
 =?utf-8?B?bUhXZWZ1aVQ1dGlxNEIva1J4ZnZJcVpJczZwL3pCZUVkTzVkT3RmczA0Q0Zr?=
 =?utf-8?B?QVI1RWVXdVo1RkJ2N0NoWHRHeWdxZ2hwSFN0bTBvcFlGSEhaaFdNd3U0UHVp?=
 =?utf-8?B?bE1OYTJOZEZ5VzhXS2dob2JSYnI0YUZERExCTjJJK0NJNUNnRHd4eGxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d29ja01aRTRjTXhVaHppTHN4dDZHVnpuTXlYWmZXRWxDWnhQVm1wY3JtUDhp?=
 =?utf-8?B?c1poaGJEaWtTNWpNSVVSUG5FeUU1Vnd5MW15YjU0bE5OUjhZMnYxeTdGOUs0?=
 =?utf-8?B?cDNEUGZyaWdramdva1Z2eWhSSUIzK25RVDdETUI5bkM0bWlqbWFLTHNQazh0?=
 =?utf-8?B?ZFhMU2QwOFhjc1FEdzJyR3Y1Ri9xUzBtL21neXpxR05pOXJDQTh2bHZPUmM0?=
 =?utf-8?B?OXZadUdJNkFPNCtKMTlCeEszSmI0TGtqcWtpK3puQzNSQnhLSlY3cHNFOEJh?=
 =?utf-8?B?bnNlUUZXZkwxOGFtbEZBUk1WdGZjc1FsTDlwUDl6WXB4bWdpWjRrOUZaT2JF?=
 =?utf-8?B?TTA1SWpoOXNoQUpXRFNHWEcvQ29ZdzR3NVhYVHFCcUNlVEk5V3ErYm56V2Vy?=
 =?utf-8?B?d0NQVXgwM1M4dkNsdktzRmY2dE5GdTFkZDhnbGYzVS94WHB4UTBibUorbjdn?=
 =?utf-8?B?MzVzN2psMERWd3d4QjlhNjdHd2VRbW1QeFlxeE8vQnJWRjdPWHM3VVNZYkMr?=
 =?utf-8?B?WnlWSG9LVU45NEZzejB4RTVjZHNlaENMMFg1T1JkZHRYaTdYM0s0d0JVRTdT?=
 =?utf-8?B?bHdXVnRPeFFTRlVNSXQ2K2pIeVBNYVM4cGJYdTdFeGZXQVV1TmFlM0E0b29a?=
 =?utf-8?B?Y0lYaDF0WFhuSVhPSlJoc3VnM3ZSVkdMQXczTFRKTGJNUThGcEdvK3NCd2Zn?=
 =?utf-8?B?UXcxQUF2S1JEQjhydmkrQzJyWkQvc25CU1pPS2pWbU1mVTFUN21nSzdLODI3?=
 =?utf-8?B?T0Y1eUo0Zm9PVFhEeWh6eVlrOHdSUGNkcG5aVlg4RVF0ME1BdDEzVW44Yzcy?=
 =?utf-8?B?TkIzN2VJRytTb1RDa1BJay82aGwreHdKTTdBVnFyZElyVjFXc040MmVSbGZs?=
 =?utf-8?B?NFJWMDZsa3pNazlmZHhLYWJzQTBwVUxDQWpDUGtRb294OUFFSlBLNVNrbE5v?=
 =?utf-8?B?Uy94NDFhdVJVR1V2MkRyUmpKbDc4ZmRJR2pkNEtNU2RJWE5IM3VGeHBGNTFK?=
 =?utf-8?B?NHprN3d1TWdJN29XcTI5SkNKd00rUmk2ZUpaQ3dHSjFVTjI0MkczMnVsbzUy?=
 =?utf-8?B?eHVSUWc5WnBxTjhjV05LY09jMFdUbHBjY3RVdVJ6ZkpyaUdFbnY5U3NLR1cw?=
 =?utf-8?B?K1lTTU5hemdraGxydzlFSDRnQjdNZjdveHlJTGY2djhGQmhZUllJV04xc1l1?=
 =?utf-8?B?R1Y2Nm5lNkRNWVp5dVQ4ajdQc0wrdjVLRjJ4N1BpVDlncDhRM3VTOTROQlNQ?=
 =?utf-8?B?aU1mVko4d0NYWkN4RnBxWUIwcWpJd0NnWDJHWkF5c1NoOTNza003dkpqOEZ6?=
 =?utf-8?B?SDFXVTg4Z0Y0QlZvSWFQSVEwM21sK05rYXNPVFZtNjVJMGRRVTNyTkFUWUdV?=
 =?utf-8?B?Mmh0RGd6bElnQnFjRnZBaERiSzdheFUrNGFzelVCZUREeHh0bGJzR0t1Wklu?=
 =?utf-8?B?NHpTYlpuTDQ5b0JFV1lpUTh1amJtVlZsdUEzVmhNaHo2TTZsTk5Dek80am13?=
 =?utf-8?B?RDNqOWhjNitNVmFaYm9UODdUWkdsYUpWcHUvYUk4VmlGVytOS2lMZ2c2Q1Rw?=
 =?utf-8?B?UnJWTUZQSTUzcWhGRUZTbVJyMU9nOURjbVY5ZlN2dFQydW9xY2UxQmZSYjRw?=
 =?utf-8?B?TlRVNTdhOXI3OVU2RW12cENpK01KVG5HcGlqVC9tSEFHUHl0NzFLK1pKSERn?=
 =?utf-8?B?akY0cUJrcjBYNDZlZUJ5U05wd3VCa3N3RFdZSFFCOTM5MVE0SVY5d1UrdHo2?=
 =?utf-8?B?WlprdWgzNW5pYUI0cllGUlgyaUJ4dUVqZ0hhQnlMcUpPQW40VW9COVFSZHBG?=
 =?utf-8?B?ZjZmbGRqQWdheVduTUdST0pSTGZzOEpUeHBiUThQcDdsZEVtc2dlV09WL1hp?=
 =?utf-8?B?SWxvMzBObzRCM2lOUHVwcGtCMWtNZjZhc3VBSHVhNGkrSCtKMWF2aWFUVHBJ?=
 =?utf-8?B?UnZPQjB3eDJ1RFlmdkxKbmdJeXhrbzhmUUV1K2x6VTNSZUNORERESHdNOVo4?=
 =?utf-8?B?REtFckNCQVZ3cEsxMXVJbWpUS09nVGQzZFJka09ESzJTTER2QnNiR2RMUEpv?=
 =?utf-8?B?aUNobGhRS2pmcWlFVUhLZkpGSHhvbzA5THFZQUFZTytuYnpuV3Z5QjJBeWo3?=
 =?utf-8?B?TjZ6WEZiWFIyNFk0MG9PbzZleWdOY1FvZmhIN0xMSWVnWWNvTUg2Uit6UUl2?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc08dec7-4e36-4eff-6e29-08dc65f7a22e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:49:03.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ka2v5aWlnt3GTRbLR9cjqtMyaOZNUwAOSei1XdXLXnEzBlEUekPcMuR7kzlCB4Q51ktt3WvkBGdwme5kBE6d/YCSRHCGHHHKaT0/HO7KOjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6571

On Fri, Apr 26, 2024 at 09:25:53AM +0800, Dongsheng Yang wrote:
> 
> 
> 在 2024/4/24 星期三 下午 11:14, Gregory Price 写道:
> > On Wed, Apr 24, 2024 at 02:33:28PM +0800, Dongsheng Yang wrote:
> > > 
> > > 
> > > 在 2024/4/24 星期三 下午 12:29, Dan Williams 写道:
> > > > Dongsheng Yang wrote:
> > > > > From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> > > > > 
> > > > > Hi all,
> > > > > 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
> > > > > 	https://github.com/DataTravelGuide/linux
> > > > > 
> > > > [..]
> > > > > (4) dax is not supported yet:
> > > > > 	same with famfs, dax device is not supported here, because dax device does not support
> > > > > dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.
> > > > 
> > > > I am glad that famfs is mentioned here, it demonstrates you know about
> > > > it. However, unfortunately this cover letter does not offer any analysis
> > > > of *why* the Linux project should consider this additional approach to
> > > > the inter-host shared-memory enabling problem.
> > > > 
> > > > To be clear I am neutral at best on some of the initiatives around CXL
> > > > memory sharing vs pooling, but famfs at least jettisons block-devices
> > > > and gets closer to a purpose-built memory semantic.
> > > > 
> > > > So my primary question is why would Linux need both famfs and cbd? I am
> > > > sure famfs would love feedback and help vs developing competing efforts.
> > > 
> > > Hi,
> > > 	Thanks for your reply, IIUC about FAMfs, the data in famfs is stored in
> > > shared memory, and related nodes can share the data inside this file system;
> > > whereas cbd does not store data in shared memory, it uses shared memory as a
> > > channel for data transmission, and the actual data is stored in the backend
> > > block device of remote nodes. In cbd, shared memory works more like network
> > > to connect different hosts.
> > > 
> > 
> > Couldn't you basically just allocate a file for use as a uni-directional
> > buffer on top of FAMFS and achieve the same thing without the need for
> > additional kernel support? Similar in a sense to allocating a file on
> > network storage and pinging the remote host when it's ready (except now
> > it's fast!)
> 
> I'm not entirely sure I follow your suggestion. I guess it means that cbd
> would no longer directly manage the pmem device, but allocate files on famfs
> to transfer data. I didn't do it this way because I considered at least a
> few points: one of them is, cbd_transport actually requires a DAX device to
> access shared memory, and cbd has very simple requirements for space
> management, so there's no need to rely on a file system layer, which would
> increase architectural complexity.
> 
> However, we still need cbd_blkdev to provide a block device, so it doesn't
> achieve "achieve the same without the need for additional kernel support".
> 
> Could you please provide more specific details about your suggestion?

Fundamentally you're shuffling bits from one place to another, the
ultimate target is storage located on another device as opposed to
the memory itself.  So you're using CXL as a transport medium.

Could you not do the same thing with a file in FAMFS, and put all of
the transport logic in userland? Then you'd just have what looks like
a kernel bypass transport mechanism built on top of a file backed by
shared memory.

Basically it's unclear to me why this must be done in the kernel.
Performance? Explicit bypass? Some technical reason I'm missing?


Also, on a tangential note, you're using pmem/qemu to emulate the
behavior of shared CXL memory.  You should probably explain the
coherence implications of the system more explicitly.

The emulated system implements what amounts to hardware-coherent
memory (i.e. the two QEMU machines run on the same physical machine,
so coherency is managed within the same coherence domain).

If there is no explicit coherence control in software, then it is
important to state that this system relies on hardware that implements
snoop back-invalidate (which is not a requirement of a CXL 3.x device,
just a feature described by the spec that may be implemented).

~Gregory

