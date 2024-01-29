Return-Path: <linux-kernel+bounces-43219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30B684110F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8BC2877DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742BA3F9F8;
	Mon, 29 Jan 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mrIaPY8a"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9243F9C5;
	Mon, 29 Jan 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550193; cv=fail; b=JKRcOv+36oMdwrE4Y3eDRJbUGjfl47QyBFrH1jH4eoLuV63B53w5/znyIxDnEokBqdLaBzoe/eldXIREyfs6DERWKU//1mOWxxZO5urK4lgbwlj6LAzYGW5jZchWy8CygpYpfFhX/zExHBJs8eIZ5TBu+xL402m64ncvDwxJbYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550193; c=relaxed/simple;
	bh=EfP6WiGr1629wtPubRwBs6PLNqEGeChXpigrPm7CJy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OgaNQGXpv8XFU1vDIh1/GPx1p92ikPTFOwcAuWNkhYKWtKdwT43Y3tCIWEyNvU8gywJz7oDpt3a7poqoFNYNbFJsJrAxBs/G8LvtvkMAVgqV2RCsloT1Reg5a0Mc2z8Uc78CJeKSskEnuz2mEtnH+THEwk3qxMdWI9L5f2aGzB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mrIaPY8a; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlFq/vPw/AFTo08pTCtUMCwjhquUADTEuWGHN6ocFELmY+R0UKVt0B7jSV4KYw4l9HkjIHc3IKml72jOOGdoZVrni7FDn71lL4LADNqD24T9DVFXCFbPno+5u+IhNIKExdTPdoOVOCqVt03FfZWDgZM/VG//HtFG8JhMaH8dVX1NRFR8UBseVy6VE71DfFSlulvLSiA2SAoNEK3DzNY2U5aZHz+g+q/o6dqMTEWtuBQNUu6IfUQRXsGSjmtByPcsM6nkkkNTfQKtoVPE03NkHKbjwcOYsRuewjrxUSloUlCuHnN7RnIYmqCfU+sAeNSUGQsXLy8Sqa5X37v2qsNXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A68yJMSTGjXTicdtWEAWe+UWxJuMS9k2/TJ2HKXyLDQ=;
 b=KfZyx4xb+pZ0ZncfQugbL7dVOrdWagYqSMNOJG04WmvvJdA8+CV1RABs0lW1uuMqxNyIUJZE9AoGZLV5Utdx9MMe0Wx5W3k8FAFUAqojfLwZlpwFLDlKlk5+0QdVUFhIEAQHdbo7QpI7V9tc9HhYFU4MAHSI/FoK7HIPgkeqUevRAzW0ZZ3uRg5MTzobsT0UzjYqb2/Hll1W2rFIAze3TZX2K1Knmm/NMUR2E/RoPAk2DhyfkBpzwaGkfZUxAEiy/aSE7ykIui257T12W+qEvYQTBTC1kR7eDxPuwP1BhnoQasHEyVb0XXNRDlxC8/psVZOXysAx5mwzi0yanEdgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A68yJMSTGjXTicdtWEAWe+UWxJuMS9k2/TJ2HKXyLDQ=;
 b=mrIaPY8avYpq8x1JihII6R8xHEBU39TRMSwq46tjOA1W+r5gR74ZPqXQjP+32UJ2PbsHamKj73/R3mObMvfmrxtSDo7u0rOTYu7EunD2oG/N9dxE9y9+Em6NY6bWIT4HDNyRXU5lkY37bev3jUo1pP9ZhYtVT9YTjpRFOUWBpIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:43:09 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:43:09 +0000
Message-ID: <ef007d96-4aa6-4e29-bbe6-3d6cb82475ba@amd.com>
Date: Mon, 29 Jan 2024 11:43:06 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 2/2] remoteproc: enhance rproc_put() for clusters
To: Bjorn Andersson <andersson@kernel.org>
Cc: mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tarak Reddy <tarak.reddy@amd.com>
References: <20240103221124.3063683-1-tanmay.shah@amd.com>
 <20240103221124.3063683-3-tanmay.shah@amd.com>
 <4xqmpxq4uqqxmgsf5lzxo3qjxmoeu6cpb4iqvtxefyiqlt3pzk@g76y2r4uxkiw>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <4xqmpxq4uqqxmgsf5lzxo3qjxmoeu6cpb4iqvtxefyiqlt3pzk@g76y2r4uxkiw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de4e9b9-7210-494f-6172-08dc20f1c1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xnm9VqdrACEsp1PIQ0ObPqJrisFrONM7w4oE1f35xeo5J/qS9jYMgwrcVuv5dS+ccaScxes/W2ORtTFQjT/XTp3cZAB0Cje/GufnMTvRNkcpNMrxkoNKNpQTnVWSSkfsSqUH58hf9MLCHTyqza/09VADv0c9R2TI6xWvGvJhIaSkC7K5JtdvXuERKLKeoW8OdY4Wv8/nkNHD7MlSp4BPUgvpIAzddTY8lou1l1LM/LsdCPI4l8XAAgRXiynfGeX3oc2cWA0h9UxD7+oktvky1SvlIeITZkeXc4O3Ln9tt3Y2MtiLn2dGVoxj5ey7VPB0X6rzm7XTqioJZLabklhmxaue2xVtj+wLfkQnJOiTxOVsmd1ccaplg/LHq6Tf0ZySxQm3nJFqR8Lm+qONtXPhu6QTkynimaGIE5kY7BGreogEHdebrAljGLcafOxyXfprfW/6ZqSm8qGeTJQpToNvVx4lsdHCI1njPbB2nTA6Dk+v3Je/e4Bv8fC2q4fvKt76VluUHsYvcI+OjaEChj2TYZB5nevTqon46c8dfcCPpdTZJ49lpaeLPnTj1jJ+Ua++XgHU4zIA9wySqu/SvZdzh2voOISdSu4Y97S+GQ91qNXBAB490NVUpUghE19gqQNXvU6SgV9q4VMoJ7TOIPt4VQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31686004)(38100700002)(316002)(6506007)(86362001)(53546011)(6916009)(66946007)(66476007)(6486002)(8676002)(8936002)(44832011)(2616005)(5660300002)(6512007)(26005)(478600001)(2906002)(4326008)(6666004)(66556008)(31696002)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHVVNktMbHNBRHhmVjVrTG1BVk1HRk80UkVGN0VYcm9tekwwL3QvRzN0NkRy?=
 =?utf-8?B?MjZWdW9Mdm10dnRoMnJHSmQyNEpsbXNWTXNhRW9GZWg0VFdqd2x2Y2g3U2xU?=
 =?utf-8?B?RG1Pbk5va1dxcnZBem1Vaks0NENocmt5UXFSQlk2ajUwdHRzZnFuWkdHeGQ1?=
 =?utf-8?B?MFZjYzZqd3pCWmw0YjRaRWVXOVVsNjFlVU9wTmxnVEZIeHoyaW9SUE11WTJC?=
 =?utf-8?B?Zk94djRFWmpsL0FEcUNJZG9wY2FlOG0vNjZUVU1ZckxpRitGdTM1anpBWDFC?=
 =?utf-8?B?UXR1eFdaYnN0dWZBRklRaDU5dVdmbnRBTWR2S1o0dTc1d3BYaC8zWGNSMklT?=
 =?utf-8?B?Zi9uVG53NHpPVE5HUktmeEZVOUJORU42eUU4aEp4TzdUL2N3Q2VnMzB0dmxR?=
 =?utf-8?B?UytYN3Jmck9qazJOZUJrZjhsckxGaVplcW5PK1NxZHZ1TlpvenJkZHdTV2hP?=
 =?utf-8?B?TlFUZUZCaHpWUzFPTlNHbW9HWnJsYXVNeHkySkJzWlJjV0QxdlhBNFNhYW12?=
 =?utf-8?B?SmhhSTdLVzdLTUlZYTlIaWVuaCtEbUZ4dVZPVUlZM3Z0L2hXSENldHJJdEFy?=
 =?utf-8?B?cUxqUW1Jd0hwbG85OG5MbUQvRUVYVDZPTGduZ1AvTUdZL3dZSmRMNmdhNEE4?=
 =?utf-8?B?dkU2UlptVTByT2hmM0FwcVVzQ2xCYkRrWFUyb2hBS2VlL0Z1NjZMS21YQXpk?=
 =?utf-8?B?Qk9MWHVPLzNERzZkbDBYR0RzRkIxMkhQMHl0OUZCSG9jVTFiT1VBSWZoakp1?=
 =?utf-8?B?WFV6dStxQ0Irc2x2WldiOGVldnJleEtnY1Q2WW5IbFJWSmF3VkxTNENLRFJh?=
 =?utf-8?B?aFdnZ0ZtdHFTamtSTVQ2TXJSb0pwODYvSXAwVHlxcFp0RXJOclJlU2ZzYmpI?=
 =?utf-8?B?TklFZlRxVktlczNSQjFSanhZZXhrS0ZBK1AyYm1VOFlTWHlmZFBKTDRPUGlT?=
 =?utf-8?B?bms3QVM2K1VvVVhySWNtM09GVUtSdWZ6K2pIUUkvQlpPaXJOczJRQzVkeXlk?=
 =?utf-8?B?YmNkTWpQRFp6bXBOVEFZVWx3bTVJZi9ZbHRKRXgzM2J1a0NvU3l0dE5rbWdN?=
 =?utf-8?B?S1Y5T0RFdkwvSENaRVVrWHdmeWRhR1pVN2l3LzFNM1hlZDNReS9CMVJobzdS?=
 =?utf-8?B?RmQvTTFUK2dCRGtQOVV4SUZNVkdKdnVOZGdaTk9SeHppMWY1WGQ3aVpsQ2Zl?=
 =?utf-8?B?a21mUm5HYWdkT1BmTkRDSzJCOWtmSEkrQlppQ1JmODY0ODRyMndMUWJ1ZWRN?=
 =?utf-8?B?MEpaRUEweE5sazJNcGFJQ05vd2pyNDhCNlNHVnVQRW15dXVqOXQrcVVMckRQ?=
 =?utf-8?B?UHhsb1VIT3pTMlNXcFBuakw5cnA4K0tZM1kzME9ocXZxK3dDbWp6eFg0V3Ez?=
 =?utf-8?B?RVZhZ1kzM0lLQ0NoVEFQRGV6WlJxdmtRYTRYQVcra3pkVUpzQkFjSW1UeW5C?=
 =?utf-8?B?MG5aNDhyMytxU0ppb254dlZDL2NEcDcrL0NmTTBIOGFjOFoxcDVmTjM2bi9k?=
 =?utf-8?B?MHpOdkNCRzNlZWpCdDZCOXNVeHpaVmtpeEpjYVppNk5IUFhzRGFUVjI5a1Ri?=
 =?utf-8?B?RVdaUFVwdXJLVUlrS0VIVWs2MThnSWhpd1BVMitNeDZuc2lPM3ExVHBUdGlD?=
 =?utf-8?B?cjd0dGkwK2RHWThNWTJJaTZZWmtrZnIxWU1xR0pFa2pzbmlSYVpNVStLYjJG?=
 =?utf-8?B?NCt6TXZmZSt3ZDdPd2svNnpGdU9zaUwvdWJyL0xtQTRrL25FZW4zMThDS3Bt?=
 =?utf-8?B?VmZub0xNTzdtdUZoeGVRTTh1UXdlWklXUTUvNGMvdCtUT1h6RVlTVldWb1ZC?=
 =?utf-8?B?bS8ydUpYSWtoWjIwaC9wa3NDUExFZHlQU2I4ckRNSE9FOEZXWDd2VVdHSUJz?=
 =?utf-8?B?d0hjSWZmS1Z4YzVzcVJCd0JhNUhKL1ZETFdsckZEd25wWFNSaGl3Mm4vdkM2?=
 =?utf-8?B?MEVhMXlyVkFVanhRRERaQlVoSGk5QTd0NitPMDJROTcrK1h3SXpxZ1JxR3g5?=
 =?utf-8?B?MnJCckNPRTFIMDdLcnJUQzNlRzVuT2dIYWhacGUzUTUvVjIrdmhLWXNYY3Bm?=
 =?utf-8?B?SjRQaUUyVlRseVpSMWY0M29DcVRIVWxTZmpxeEV5MFpOb3ZVUm5YTGk4Zitm?=
 =?utf-8?Q?aMJgsa0Xv+elizDw4Bgi0im3+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de4e9b9-7210-494f-6172-08dc20f1c1f8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:43:09.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmYn9Oypy0xQhmGKDx3yEYX02K7ccaNizlt+eq7iY5G/4CL3QasYr40drpppyVZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449


On 1/26/24 11:38 AM, Bjorn Andersson wrote:
> On Wed, Jan 03, 2024 at 02:11:25PM -0800, Tanmay Shah wrote:
> > This patch enhances rproc_put() to support remoteproc clusters
> > with multiple child nodes as in rproc_get_by_phandle().
> > 
> > Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>
> As described in the first patch, this documents that Tarak first
> certified the origin of this patch, then you certify the origin as you
> handle the patch.
>
> But according to From: you're the author, so how could Tarak have
> certified the origin before you authored the patch?
>
> Either correct the author, or add Co-developed-by, if that's what
> happened.
>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 0b3b34085e2f..f276956f2c5c 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -2554,7 +2554,11 @@ EXPORT_SYMBOL(rproc_free);
> >   */
> >  void rproc_put(struct rproc *rproc)
> >  {
> > -	module_put(rproc->dev.parent->driver->owner);
> > +	if (rproc->dev.parent->driver)
> > +		module_put(rproc->dev.parent->driver->owner);
> > +	else
> > +		module_put(rproc->dev.parent->parent->driver->owner);
> > +
>
> This does however highlight a bug that was introduced by patch 1, please
> avoid this by squashing the two patches together (and use
> Co-developed-by as needed).

Thanks Bjorn for catching this. This change originally was developed by Tarak, but I sent upstream based on his patch so I missed

to update his name as author. I should update author name.

However, if we are going to squash this in first patch, then I think, first patch's author will stay as it is.

Following Action Item on me for v5:

1) Fix commit text in first patch.

2) Squash second patch in first.

3) Add my s-o-b signature after Mathieu's

4) Add Tarak's s-o-b as well. As he developed second patch.

Hope got it all.


Thanks,

Tanmay

>
> Regards,
> Bjorn
>
> >  	put_device(&rproc->dev);
> >  }
> >  EXPORT_SYMBOL(rproc_put);
> > -- 
> > 2.25.1
> > 

