Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0D7FA3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjK0PAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjK0PAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:00:00 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D2A8;
        Mon, 27 Nov 2023 07:00:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drtO6lKZGcWG33X7pUiZq1CoiXJtIzPB/Ywy2UvGvuqLtw2WisQsYnd4jIfCiiRO7dHAVeU3e3sD6e8Xcw/fXUjevxI2HA/v7Cmk/7eL8Mdj/A2j8qp1KE2NjcdHleLTqQ9VRXJObuL1I6PEUeiItFKjYf4ugFEIFuFnCshUBjIc1/6dZCA06nBAuD9GF3xoVImcket4DFamtqjteO30JjUS+2lA+xZGp/DtAxZZ8Hmh7wYH+KSqpcIbaqnyp4C4+dJoOXgJqyzjRSMyJKX4qfrE2gaZ14I2K/KuqX2DxVOvRwwazPw3eROOw9afazmCmP4Yx0+ysW/Na21LrDUesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA0uhSJgnP48ukMxecgWGXXl+f8IoJF64sm9P1OzB8k=;
 b=Iukc0kiqlScFaRnJtbG0BjuaxWa8guK+bjst9VV0eyK9PzHoXlWH0LLunKqWF9qegQ3sVb39U26uexq2542GvJQa1tlg/mYgFBefy5EWxVripRdxZhf/x646fr2qr/2yBEeZMW/L3oHKOruwW37hg1+em8HQSk+QHKjV5QIjcc9BGJn2HZES2E/bFJsGWj/gpSTf52ZmEPOkSVwKaSaZkMrJykmz2lEDjh+6/UK5R89wx1MuHKuTX0MZdmPjV8VMT5sxw9m+QJQd/6yuf+6nzK6CJQs5O8AAZRt1yAecDEqUb2hawpudSFmoiozZgSIgZYdDNSINdU1aOxRXqOQzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA0uhSJgnP48ukMxecgWGXXl+f8IoJF64sm9P1OzB8k=;
 b=c2Gvn9NWqwy1au1q854HOhAfamuPLKdU44F5FpG+GLwn5xAU/KWaagiPgLZHclKA72LjQMCD1YirElsSrKDbM6hSIBI87avxsP9VqzVjli9EQrmdUEAahPMmnnkFTELE0rZXuQOguhqv1L97DvNXH/SX79DDxxBbTd8puciFjWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 15:00:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 15:00:03 +0000
Message-ID: <7b6d0d32-c1c5-4c57-a34c-81c9699c0d49@amd.com>
Date:   Mon, 27 Nov 2023 10:00:00 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Avadhut.Naik@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        amd-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] x86/mce/amd: Use helper for UMC bank type check
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-6-yazen.ghannam@amd.com>
 <20231127114349.GMZWSA9QADGqCXnTYe@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231127114349.GMZWSA9QADGqCXnTYe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0507.namprd03.prod.outlook.com
 (2603:10b6:408:130::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 2addec44-46fe-4d08-ae48-08dbef598914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBU5cjUrg9RkHKBbXHmuf+2Da9azrBMGO5gpNNVVv8ra8PP7/+POQshH9phrLE8t/tjazsQ7T9i8D8fn418hF0L/1ta70kUnUkxJrr0PBBXrTGmvoydFSl17tGYyrxLyIAeSmhE7cDVvvqb4xYHmKV7xJfT3CI3dklTREM06uQN8Xi99ObL0iwsqG6U9JMhU5ItqhIswd8NxEpEPKyBdrCoOIezWUDloxgYIFIzARJ3yBHfa+VCaop8ghmYx7wfJpiyLBndYzy7s2cyMoRQ+thnE6iSoUeIOJVI7LFfsxNhNIqPWYLne2quFevcUh7eSmEuZXuSWgLjQb/k/B6ms/1rwSyidwKLzL1mNkNqXxuHga2tBzef0LI57LJ/n5JW5xavAuONOCcVVCO7T6QDfoOV/IbYbEBvAZiYweTEdlMhCxoaQ3LHCTUB2EW7C/bS2v/0Q2NBiPil6tNyq3EIBfoNKPkUBgIhdTIe4dPdCbIMPfbH7nbD1ruHESwXuuaWL4lBPr7Pj3RNoBzFEW/7PTl8A3mRRNatSjYv1PQda2ykwSZycmCNG33VdE7CiDb/tOuCRWdfSmc52XSaPZBSQH8KNjlTg62VFjZxDF2JG+ZeEV0wRhdMN1p+/UxNhRMyDxmjJi0LuwJWqmD86VXLndA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(6506007)(6512007)(53546011)(4326008)(8676002)(8936002)(5660300002)(15650500001)(6486002)(31696002)(44832011)(86362001)(478600001)(316002)(66946007)(66556008)(6916009)(66476007)(38100700002)(83380400001)(31686004)(41300700001)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REo3RStoV0tSZFVRdVYxUThuZFV4NlVWNWtZdVdIbS9XTXNIQUg1ZnZTcW4v?=
 =?utf-8?B?MUFhSXhDNWNyUis1TDA2d2dmMHk5V1hETnB6bjlsajhyOFFQejNqc0ZHcFlY?=
 =?utf-8?B?NnZDOTRLUWdFWHMyaWpxZ3hKREJ5RTV2S0FhdG9qZlN6ekF3ZG1WaytRS2RF?=
 =?utf-8?B?Zzh0L2Z4RjVBUksrZ2VNOTlYSkdhSE5GSlFxMHFlQ1RFcWt4V3pKaUdGSWgr?=
 =?utf-8?B?dUxYc1JtVU9SQ1NxYWp0MFE3N1FDQTBIWitnT09aSjBaRTBDREtwWktoVnRF?=
 =?utf-8?B?OTh4YnFoSGZKMk9pdWUvMjVWbXJzdE9qSDZOS09RRXJvUTVTdzdTM0ZnTm8y?=
 =?utf-8?B?eGZyaGJ4ejJNRlJYSnJXeHgvKzJ6WmxOczRxNmljSlB5NFBRRnN3OWdMQVI3?=
 =?utf-8?B?eHN1anVEaDV5Y0ViWW9STjRkeHllZkVlWWZsWWRNbWJBREFlcXVJdmVNSXRs?=
 =?utf-8?B?NDNWUGtPZ1hCYzZRRThGU1I0YXA3SklUVVN6QlBpVFlBK3ZTb250b3hkcU1H?=
 =?utf-8?B?MVRYMVAzS3k5b1o3ZGJSaGdIaS9EQThqc0E0blRPZUhYeDFCV290ZFhwWHJE?=
 =?utf-8?B?R0YxclcvZzRDcXhuQVFZeEhSdG04cXBHNFhnLzZQdXBWaTdmZzdKU2dSWjdS?=
 =?utf-8?B?VjdZcHFqZGdKQ0wyMTlXNlNkb2hZL2ZDdUZqbTFMWWhPN3ZWeG5obk4vc29F?=
 =?utf-8?B?QnA2Vk5SaHhzMHYrcWxVdS9NMU9scDhNdUlMZmpValdXVUdyZXZyWHlKUjB0?=
 =?utf-8?B?UTRyWXdOUU1TOEpkMmlKemdFUVovbXJ0WStmVkxRRzVZSGROVk1adTRvZ0sy?=
 =?utf-8?B?M2V1TTNlYlFKZFBEMEFMazZVRmRMaUYwWUdibGhYT1B5c1A1RFgrUjZiSWpJ?=
 =?utf-8?B?Rjc4TW4zM0VYVmkwYk9janE1VTZ0aHdpOUJDU3FHVGxqb291blZqSjA2QWZI?=
 =?utf-8?B?K1lPSUVEdFBMdkhHYmR1WVVEa1pxSkhCRk5FdkRXTFJkME9abnh0NktuZTFv?=
 =?utf-8?B?OTVseEJMU1E2c1I4ZjdpNC84MGFNZFEzN2lZMW9kMjhCenN4N1huaEU4YTlN?=
 =?utf-8?B?cnh5bUxWRTMxZUJlcEFpdGpDWmFQNUdrQWJHeDlob3dhYy8vVGd0T0JWTGI2?=
 =?utf-8?B?Q2x2NHM0NWtaWS9ZR01IY1lSR09XTDhyNFNaYTMyNzBTNFpXREJOVzBtR1Bn?=
 =?utf-8?B?Y1ptcjJybHlvamNGYU9kaktDZm1kS2JUQ1hDdVJCeWNCVkNYZncybGNnVXdO?=
 =?utf-8?B?L1VTOTBQN01ZYy9FYStLY016a1BLbFg0Z0JsNXNxRU56elFYQngwclloTldi?=
 =?utf-8?B?UjBxMDFwMFRyaHIySzRwSnh0cHhzQzR0UC9nTkg5RlpqTFJXdWlMRVJEYnRH?=
 =?utf-8?B?QmJndUtwN3M4NWNlMDhXUlJpZVozdFMwbDR2djl1MlZ3NDNGK2xsY3FxNklM?=
 =?utf-8?B?Z0xXc3MrU3VobXN4VUtZOU8yNldmenVDd2tEbjVtTUV2YzRCbkxiQVk2eVJZ?=
 =?utf-8?B?ZS8zbVczTG52ZlIrZ1ArNmE5cHdPajNLek9LekRJTlJZQ0lzV0YvcHoxOFUy?=
 =?utf-8?B?a1V2OGtnbmtXQ2lsb3I2eU10V0ErYVZ5TEt5aTc3U2QxdU8zbUdNK0dnOVYy?=
 =?utf-8?B?ZHpzb2MvaC90Y3JiRXdjeitWNEY0WVFZVjNlN3FLZ2orOHZERHR2STBEbVQ2?=
 =?utf-8?B?WUhBa2QrUUdSdUZoUUtMelUwTHhKR05rVGtCSmJ5bWp3alArbFI2L05IbnVB?=
 =?utf-8?B?UnVxbWY5ZHRpM2pnYlR5ckZiM0pFc1NFeXR3QzY3eExsMGpmTGVTN1gwRDZa?=
 =?utf-8?B?SlozdWhsWk04dXBxUVZ6Q1ZlMkUwMVloVUZxcTFjOVFxSWlYZDJJRkdXTldS?=
 =?utf-8?B?U2ZiT1pGeDF0Q2l6blJnRDEzaGdXOUtsRWJuVGNFRDhBMU9TbCtyNzdjNXVl?=
 =?utf-8?B?NUsvZmZ6UWY4MGY2dTMvN1ZkM1hQVUR5bHNvU2VhdkJtUTZ2cmJoOGpSQ21N?=
 =?utf-8?B?bnJTZVJYRXRKQ3pDb3AvaGpXODRNL0lieGVYUU80UlZDYk9mR0dYTExTMmtk?=
 =?utf-8?B?ZDlNNFhPQm9wYnpFWEF6UitzWXc3RU9tc0ZDSXgvZGhibTRhMHdBU0tZS0ov?=
 =?utf-8?Q?jCKkZTwj24OtlJfrGpq5wiGIk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2addec44-46fe-4d08-ae48-08dbef598914
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:00:03.5060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+0ufRzDEZQmJpdVDQexdBygeigvM+qHZbbExvJAk/57oiEj7ieN2S/cWI5O7xSQpmIWW6Oz7HMfBOfNa7741A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 6:43 AM, Borislav Petkov wrote:
> On Sat, Nov 18, 2023 at 01:32:33PM -0600, Yazen Ghannam wrote:
>> @@ -714,14 +721,10 @@ static bool legacy_mce_is_memory_error(struct mce *m)
>>    */
>>   static bool smca_mce_is_memory_error(struct mce *m)
>>   {
>> -	enum smca_bank_types bank_type;
>> -
>>   	if (XEC(m->status, 0x3f))
>>   		return false;
>>   
>> -	bank_type = smca_get_bank_type(m->extcpu, m->bank);
>> -
>> -	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
>> +	return smca_umc_bank_type(m->ipid);
> 
> 	return FIELD_GET(MCI_IPID_HWID, ipid) == IPID_TYPE_UMC;
> 
> after having done:
> 
> #define IPID_TYPE_UMC	0x96;
> 
> and you don't need that silly helper.

The helper is also used in the following patch. But in any case, it may 
be overkill. So I'll drop it.

> 
> And then you can do more cleanups ontop by doing
> 
>          /* Unified Memory Controller MCA type */
>          { SMCA_UMC,      HWID_MCATYPE(IPID_TYPE_UMC, 0x0)        },
>          { SMCA_UMC_V2,   HWID_MCATYPE(IPID_TYPE_UMC, 0x1)        },
> 
> and have all the numbering properly defined and abstracted away.
>

Yep, agreed. Thanks for the suggestion.

Thanks,
Yazen
