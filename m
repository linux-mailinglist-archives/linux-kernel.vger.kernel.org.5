Return-Path: <linux-kernel+bounces-65357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8929854BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955DEB2360C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23B35A7B6;
	Wed, 14 Feb 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IoEa8p6q"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C45A7B4;
	Wed, 14 Feb 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921920; cv=fail; b=IMB5oITZqPLE9iNANah9sa6y0kogLoFe3xNB32YFBbKSyEXUfFGO2bT/bPe0E2Jtowr3iuHsDzPEweViN8Zg07YgX8AgUMC9pxfmwugICpQYGxL9pYwnrzNJoJFihwJynzUOaxQddUyjQ72mZq7Gs37vMIXEGMAgh8mzvjp/X/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921920; c=relaxed/simple;
	bh=cqIXbpy8kI6AG3hfTs3jB38Yd7Xyv9AIon3sponqbQo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+wWgc/ACthN84b5gbcWqYLykdLEyZctq4BQTdzmS0K11aEkDSoYiYcFSNxSb6F7XeQCUqGQIvWMu6v5a5wL2ZnwN6oAVTUrqpGRd/pCKfQAEfkoiqtX5JdCrkxIIULocDMS5JAUFOdUFQ8jdAoe2dfIf+4Zcwbvg3P2Y0zocno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IoEa8p6q; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k151eKWOHk7bpBmgyV0yvvFryZ0NqK1TjWZjuBdbj3O0svGZwXxcL+LPRFWV7edj4gahdYUI9uPOeBvC9OvqX5Gt6PzqyrAK9Oy9f9aH3bQXBHv/qi1K3CZeKuJZuyjUEs7f7V0HI9eVbn11aMNvS+RZNDQ99I5Hm4tZItbpq+C+stM3JeSY3g8jkJwEzdG5LuzI2Ubdqf993O4ysUjAPxR71sxtEpcFvn6dC6a5mlXbccO8mhLhHIBmToHuMLHe60T3qmBtiuECoWT5c0bBexGWC1gGF74B2NmxlUmOg8hLi5xkcWLsfeuyAQFL9e0MD2Ab+n4+OSqazvRaJE83Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxGlMvegfLIpbBrw0sZfleotNbdFsKmr8leW1LhBqZo=;
 b=T9iu+DW8Hr0AWmLw9kjd9uPwLU8pSD0leD8CAJSJN3c7gsQpi3WY3jJT3sxZSHqZPUzWbzk2jkMW/cUCqCd5cLcnSTgVImJG0PvCCsZYDsb2izuxIIWo2mi2o47p7nV7EMvdmZupEbyCUiimKpIVzbwqNwi5rWi25h63qse2N235ZuNWTke6SFoNTejVBWshyuPz0zFq6Qywpwq1iaumSaZY37f4lPUIHIfjP85/7iJp9tCbWAPbAoPk56pAW598zzCTzViP+xQg/TlIn3FF51tIn5s/c8tz63RqaIb5tr97tW3oFXZVVeXc9UfBlA1HOig2BQpqKDFz+cXumXwdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxGlMvegfLIpbBrw0sZfleotNbdFsKmr8leW1LhBqZo=;
 b=IoEa8p6q5dm78fd+PSt4gzcm5wX7v029MqLpwFF+EWWN6ElcOlQ8bOxvXljEDixa5jewI8LuTXckFk5MZq/0qRT57mNusEBVyRtDshR0fRVXgdro4kqMd0CkN4ulH8BBs2yigltY2kf6UCvHLoKup6NUH95KRkvL4Kx2gOggAu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 14:45:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:45:16 +0000
Message-ID: <2a83026c-ea36-44ca-a101-74a8b3a2ea89@amd.com>
Date: Wed, 14 Feb 2024 09:45:14 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214102926.GCZcyWBuEBe7WRXWYO@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214102926.GCZcyWBuEBe7WRXWYO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0635.namprd03.prod.outlook.com
 (2603:10b6:408:13b::10) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dd1108-9872-4170-cee2-08dc2d6b8f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GyHdXpvulc9AGkm5Py69aaogesJILKtWEiOhuQbO+gB0cyFY079zLXhS5XVoJoRuAqds6T0LDp4jMyfkqb3m9GCYmLSm3sCVcOZ9RRVqGc4RPuxMxzYeJssrQKA/1xN32Izn4cfd4Z/LjASYtt0Q/MGoY2ZEsoe33D70fmFNfcZ3lcQY6vdzmTxZS3yXm/Be9ts5ScrlHzAYK2WhCgB/Dybsn//SA166Lieo1yHnsM6v05oTaoptPBhhj4i8uvefKdmeEZCXNdw8B458HbRygcF1TuzhXdml3lc2CcN8bU7Gx+tHUqEbZF9fscvZzEK/2opOtYtnLTfOuDhYfZ9Z4wmEgmzPR5CFGQuVkSwYt4C8nVwO+81IcCikeV/63j5QE8TXJiZECfS55VI8REXuwnOFYzW6wordFoH3CavtnUjxT8ls8hINpYytt5cfOxltDg8eQ0r/Thj8tkqQKnTMiYQlV0ZEI3FSrqfbR9tOACiY9DfFPRRAFFmN4m5KfsgEfWVjsjFj21yTB86oABTKOXbj5rk9u/IWVdecS3HjQeiWZuK6vKQqnAbF2PIfZWQ8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(5660300002)(4326008)(44832011)(8676002)(2906002)(83380400001)(2616005)(26005)(36756003)(38100700002)(31696002)(86362001)(6506007)(66476007)(66946007)(6916009)(66556008)(316002)(53546011)(6486002)(478600001)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGdkaU15WWtxNDUxa1B2NDEzN0xNN2lRRldTbngzeEdxRmZLYWVOOE92b2V2?=
 =?utf-8?B?L0RjenZIRFRNMzkwVEVIWHFUYmM5TkJKcGI1bmxDOWUvQVF5MmZ4VHFNZkF1?=
 =?utf-8?B?TzRaSkVXa09COUpaUExKY0pIUDJTSTdJTnR1c2FEUWF5b3g1TFl4ekxXMG5V?=
 =?utf-8?B?QXY5TkpPV0txL2o3d0NhOGtTY250VlhGcVRBU0dQOVBlb2tsa0dJdnJNOWsw?=
 =?utf-8?B?TW4wSUx1SkFyWXhkZlN1em8zWUY0UWRwZk83bFk4ZXREakxIdG52ZkhLWGxU?=
 =?utf-8?B?LzV4WGVtMUh6R3Z6dTBqTGo4ZFFMdU0xYnFKdkhGLzB6ZFluYmlocm44UGdS?=
 =?utf-8?B?bnFYMXp5dyt1WS9lTFRPNk5PUFVaZklQejVpaFF0NU9ENUtRVFVLdnM4WHh1?=
 =?utf-8?B?N0lkck14RWRnYXBvVWlyN1VzZ0pWWWhYNFUyS3Q0bkE0eVNKUTlMZ3djdUlt?=
 =?utf-8?B?cXlScjczdzArR0gvZWRKbzIrbWVNelpKbUhNNG5MVnVIOHhmUjk2K21iYVlp?=
 =?utf-8?B?YUJQbDdDNUFnNWlqWUJMa2dhVFZ4UUlKRzY1SHdtNzloQmdNYzc4S3VIbzVt?=
 =?utf-8?B?UUdObkRiSUVMMFdjN3JBQ01SRGFtMFlTRXZNcTNrYUo2MzBHVkYrMUhtU0Y1?=
 =?utf-8?B?NzM4LzJ1VmdSaEFiMjZRekhJWEwwLzBIa2VjTGdlaWM1V2ViYjVBRm5sb0lN?=
 =?utf-8?B?VWJxSW9MS3lPdUI4L2t0Tmh5aWJUTHdmZ3JMWG5xN1VQTUIxY001ZGk1TVB1?=
 =?utf-8?B?RHFBNDNnUVY4bkpCUE1MUy9BMGxsbmxrWDdrWE5XMndray9rWDdZLzhTRUcv?=
 =?utf-8?B?Q25YQkkzR2ZtVmViQUpWdnF6UzZOUFdTa293WXIwVXYxejF3V3dFYlI0V1ZK?=
 =?utf-8?B?am13N1lJNkNEZW5BN3FIVmc4SEptZWNtOFE4bFplTjNYR2FaUmJYdmQ3amI3?=
 =?utf-8?B?Vjc4TnliSnhLY3RpSlpvWTY0N1NsR0dnek5tWU4zc2V3cXhLNVRhSi9vWnlw?=
 =?utf-8?B?d1hRbk81clFsNVROOThEeEU5QmRhYzFTaGpvd2RxYVZGa3NpOXcxQ3VYM0hj?=
 =?utf-8?B?Q0QwdkhaZVZWZjF2V3RPRGthL1dvdk5XenRYZWJ3UGx4Y2JUaDV6eDJ6V2pa?=
 =?utf-8?B?c0FSWmhHNWlDcnl4V0haMzBHRnVqRzAvWEdjSlV1MmhRTXQrcXBwVGJiZThy?=
 =?utf-8?B?OC84bWlqUWNIbUdCeldDY05oemVySUR0cGxLVVNrR2FQcys4YUkrUFB0KzM2?=
 =?utf-8?B?cWVCWitqbTFSQVozMnM1aEJWcCtIMjluZ0IrWThUam0xejZtOUJGdDdraity?=
 =?utf-8?B?R3o0NmRDZjRjZTdZQWVRRzg2U0d5UER2U2tBcmwxZnVjL0dkaGcrWE5FRkZO?=
 =?utf-8?B?WUtra0JtcWcrVmNuR2JnUVJyTThpb1NCL2lqVWFiZHlxQXdQMXpjYUJwcjNP?=
 =?utf-8?B?K2M0UElwRTF5VDF6b1Y3S05IR2l4Y2xtZ1J5bHpmKzhUb3ZlRk91TjYrMlYx?=
 =?utf-8?B?VzA5RlhsUHRROWpmNG9EOU1EaStuWmc0ekg5TTk1cG5CS0RkM1ZMc3BtVVRZ?=
 =?utf-8?B?Y1BYcGZRM0l2OFRxdFFmUWhrUXUxWmJhU2d1cHZLdUM4TlRoRVd4cHI1VXRl?=
 =?utf-8?B?MmREY2g4dWprYjBvZlRXVzJpU1J6VXdEUkpxT2pMMTh1emltRHZsbmxZVzdG?=
 =?utf-8?B?c2R3SDJZNHd1MTB5SmI3OXVNYkMwRVR6YjVjK0tlQnlLWGNPTHlHWnd2SmlQ?=
 =?utf-8?B?dnIrRUx5MWFNU2FSRUFCZXpHdUdyNjlsR0tOSFFhbTIyYndyMC8xNGJNNGM2?=
 =?utf-8?B?TFlMNjJYalhiUWliVndoL2pJbGFmZXU1TWdyNUtHNE80ZFlwUlppVnk5a2tT?=
 =?utf-8?B?TkpENllCcGZ5YXNRY1krQnNmSVNZcDBwaXRoZCtuOXpUT0hFSE4xU2ZZYVND?=
 =?utf-8?B?NWFkbWhWK1Zad1NHMjVVNlVEbERCTnNCTHFsSWlwR1djMGNVRUdyMElUeWk5?=
 =?utf-8?B?c0ZjbnZaVEpDdVFmTUJCeFNNd3lQbnhmUWtYN01IV2J4eVVYY3dVZnlacnpr?=
 =?utf-8?B?OEJteG8yWDhlNlFoTm1GcWM5d2RVQlZNSHpGeURLN1g5dmozeVgrS1VqTFBK?=
 =?utf-8?Q?U/pP3qKJp0+In+5Xt0g9/Xm7N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dd1108-9872-4170-cee2-08dc2d6b8f0f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:45:16.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+Gv1VRxxkelXZdwckUtuxjBFN6XuaW+2DfLk6fXCUyDx/Z0VJkGOWylzKVjexkDgPkhht6Y1ErqZ6P1NA+1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752

On 2/14/2024 5:29 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +/* FRU Memory Poison Section, UEFI vX.Y sec N.X.Z */
> 
> Whack those:
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 328e0a962c23..0246b13b5ba1 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -72,7 +72,7 @@
>   /* FRU ID Types */
>   #define FMP_ID_TYPE_X86_PPIN		0
>   
> -/* FRU Memory Poison Section, UEFI vX.Y sec N.X.Z */
> +/* FRU Memory Poison Section */
>   struct cper_sec_fru_mem_poison {
>   	u32 checksum;
>   	u64 validation_bits;
> @@ -89,7 +89,7 @@ struct cper_sec_fru_mem_poison {
>   /* FRU Descriptor Address Types */
>   #define FPD_ADDR_TYPE_MCA_ADDR		0
>   
> -/* Memory Poison Descriptor, UEFI vX.Y sec N.X.Y */
> +/* Memory Poison Descriptor */
>   struct cper_fru_poison_desc {
>   	u64 timestamp;
>   	u32 hw_id_type;
> 
>

Ack.
  
>> +/**
>> + * DOC: fru_poison_entries (byte)
>> + * Maximum number of descriptor entries possible for each FRU.
>> + *
>> + * Values between '1' and '255' are valid.
>> + * No input or '0' will default to FMPM_DEFAULT_MAX_NR_ENTRIES.
>> + */
>> +static u8 max_nr_entries;
>> +module_param(max_nr_entries, byte, 0644);
>> +MODULE_PARM_DESC(max_nr_entries,
>> +		 "Maximum number of memory poison descriptor entries per FRU");
> 
> Why is there a module parameter?
>

I didn't think too much on this one. I kept the idea from the old set.

Murali, Naveen, any comments?
  
> So that people can brick their BIOSes if it can't handle some size?
>

The ERST operations should fail and return an error status if there's not enough
space.
  
> Can we read out the max size of the area destined for FRU records from
> somewhere and go with it?
>

This idea was done in the old set. But it's not correct, IMO.

The 'size' we can see from ERST isn't necessarily the available storage size.
For the !NVRAM cases, it's the size of the temporary bounce buffer that BIOS
can use to pass records to and from the OS.

So it would be big enough to old the largest record BIOS expects. It doesn't
have to match the record size used in this module. ERST is used by other code
with different records.
  
>> +#define FMPM_DEFAULT_MAX_NR_ENTRIES	8
>> +
>> +/* Maximum number of FRUs in the system. */
>> +static unsigned int max_nr_fru;
>> +
>> +/* Total length of record including headers and list of descriptor entries. */
>> +static size_t max_rec_len;
>> +
>> +/*
>> + * Protect the local cache and prevent concurrent writes to storage.
> 
> "local cache"?
>

Yes, we keep a local copy of the records within the module. That way we just need
to update the local copy and write it down to the platform. This saves time and
avoids interrupting the platform to do an extra read.

Thanks,
Yazen

