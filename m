Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9178E02E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbjH3TTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbjH3Qav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:30:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DEE19A;
        Wed, 30 Aug 2023 09:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBgWI2cKv6F2Xk7IPx7LedbH+CjEpyCI8tUSo6VjmnkkvIXexuWIhD2ojlanxoYc3DrzXL/VjDd5obzJ0ErEfEZkEcIijvExG15A5NphDi0LGN40D+6iqRWpmp7nNEBEIulhA7QGBrcTyrofULDvZ224qCd+KWqdfpqaSlifk+vupouNViZGKT5IDC0xRYmRyFT5+15JZebHDryDYyyhvDMv6jq7XxRdLummHao5KxqNQHQl3tqcPmPvpj/KxfYE4r1K0ioi6ltbBWhEn238Pu2a8MLADsLH2tXWeW/aB6S6nhqP35wJdxORIGpP3WFnLhK7NX8AbN6UpROXg2/H3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q80TxtnrTsCf04qidjzG4AFpuBOwwSxbTkrnb1PBErM=;
 b=J2Dsbv7OxdI0FrQkDxT2XJ9a0Rg3n3wGtLROpNepptCfIVrEqGxgGxEbLEd05MzdjIKL1DFp8OQuh5K/VoS6Y5NnX3+HobnFWAhMK/2N5sSOjWOR8rtgeHxE3u8DFZ4LFwk9kjrTVeDnmEzthxD811lucDPh4NelRffN/giDJHF1gkyYyl4hoYj2CsrxrYEy37ij8SGsGnhYagct/zAmh33Xlmkxd0LOgScI+ZXSdmCZI+V4fjdOyqilnKBqLoOfGfHww94lt90Vuf1rNh9C7dPdrGzLdhKrP2IYEhAkA7iTlccSpp7IdqcNDotP+qrBWnysTttlE7zwnAU8dgGTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q80TxtnrTsCf04qidjzG4AFpuBOwwSxbTkrnb1PBErM=;
 b=VdmyVzt8WWwW6yiGJviiXOYfDe3ibqSotPTdve0jCqCEZ057mOlhWOsB56z/fUQi1ywMh3MyOJ73AvhQmE1jFAZCYeytqp0ISxLpqu5IQPD/mlRFlWlbiAfFbOnMLa2AF/GCiZ4ukYG1xIvawef9NyHPrn3kenjsi13GAu5EmgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 16:30:45 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 16:30:45 +0000
Message-ID: <22b629ae-a836-b6af-6879-62f8818f0ec8@amd.com>
Date:   Wed, 30 Aug 2023 11:30:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-5-babu.moger@amd.com>
 <410830e4-51ba-0e22-ea73-3a71fbed3643@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <410830e4-51ba-0e22-ea73-3a71fbed3643@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 431865f0-984f-4504-0455-08dba97675c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQl1jVmp0Jy2MSIccRnGEHF9qmqrWSX35gqIgAQqcljQGB6MyV0M7ao7FXJHakIyRnZuVbtw64v/HVNbzYo7HkMrDtqN5KO7Ijj/sqSr1A3O+3D8UgRGTpg/v2K6WiyVUQInZNoh6k/eYAfblzJcOVui8/Kv11rofjs+Gyu6vPkv973mkCjUC0LIT1OvLIb4U5GWQLLgBzNnAL9SzSRopBpE+SzYjT1W4GOYBwaSgaQz7l9Ey+tLT3bjOOc2EZ8SdKT2FL+A2niFWPYHD79MVJBRMVpsJbJ6ziiBJPL4FL1OQT7iwlfjru1sV0bb93XDW+9YdobxaLV1uiTtgaDoQh3bVjJPtdav6jigS3kLwb/X8DNlDSia6Kt0KH8hY6t31ceItFBI2Z8xF7mWQhJQYQMd8U5Gk9HtdLGNXVJWx9cbTHT0Nm5DtdH605mWOYvVYH/FPVJnx+YVhnkPRmLz49UI83TG/EbXsjTbklCij6Jul0Yy2kDGTlSKJAkY/1pJdjPZ1CHwEn5FeJg4BlvMTQpzikFWRV9b2T/lKGqCVQeXMZCwGF/5VPB3P2cu8JQu/uamXobKddKcHZeZE6s78hWyQZ2qblI7MjUKydr8kpefJavVyc5q3YRF9qtW2/kbWvX5Gke0W2jmW2aS0vrhnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(186009)(451199024)(66476007)(66556008)(66946007)(316002)(38100700002)(478600001)(4744005)(3450700001)(2906002)(7406005)(7416002)(31696002)(86362001)(8936002)(8676002)(41300700001)(5660300002)(4326008)(53546011)(6512007)(6666004)(6486002)(6506007)(26005)(2616005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My9obVRMd0tlaFVNYWRGQzIyV2tzTzlnaEcyVGxNelZHMXFHZkw0dlhYajMw?=
 =?utf-8?B?S2pBYmV4aFA0UEtReHk4YktZeEh5blZoalhMblRYRGdKMHk2NjhmS3Z6ZEdi?=
 =?utf-8?B?V3BxZFZ0UW1TZ212b1FYK2pWUHQ5VHVEMnNKWlY0MVdReS9yOWdzM1NIbExN?=
 =?utf-8?B?bUYrMm9COXNOSE5TaHZyOVJPaUdDd2xkR29lL1podzBpR1ZKbW1XVE5rY2Jy?=
 =?utf-8?B?enpoOUVwTXhway8rRTNDSkx4RXBYc0hDWWdSY3hSNjZKak1WR1R0NlNOM1Jm?=
 =?utf-8?B?Nk1ySTYzYkYzTlhGZVBWZldkZHBibHNqWGt0b2tjaSt5RWhtY1NiSUluaTRU?=
 =?utf-8?B?YVYrOUovRVRNRnZjb0tWanBMcEdPV0x0akkzUVBhNkFOUzFUZFE3bm1LQWxa?=
 =?utf-8?B?b1ovUWhNWmV5RFRiRUo4dGNtbWNELzZaVkFpRGNjWFNnUk04VkJPZERHejdq?=
 =?utf-8?B?S3pxUDlWZWJsU1I5NitmSjViQy84QmR3TFlNSFk2UUpXQzRoQlNUSjBEb1la?=
 =?utf-8?B?THdaUXdKZ0l6VmFMRU9KMmdGLzBvdFFXbkY2RHMwTFRYSGQ5b09UYUsrT0lh?=
 =?utf-8?B?ZXYvWWUrcW5NQVRQOGxwOUV1dTM4R3QramZCaXJWSktjQkJNNHpWUWIwMHlx?=
 =?utf-8?B?dGhQbmYxMCtYbk9iUkFYenNCVmwzbVd2OXZPRjI4Ti93ZUE3dlg4OU1VNExV?=
 =?utf-8?B?NzN5VDJVdk0zVnJOZ0NpRW55ZWV1NFMwV0tFUnBIZnlDTUdzc25zc2NrODNW?=
 =?utf-8?B?cGdSZHJkd2hWbEltenBkOFRXT2c2dTBhbXVWbEpRY29ad1RsNktwTmV2aWlO?=
 =?utf-8?B?QlFxYUJtWlhmb1JGVFZaeTQ5N3NLa0NjenViekJJODNYTkFJNU5tWmtzVE95?=
 =?utf-8?B?RDhGc1NPOUFLUnJYTnJGTHJ4Vno1VmZRK2wzaURyeWV2NGdhK25pM0NPL0U4?=
 =?utf-8?B?ZFlPL1lEN1kwMWNtcUk1d2Nrd09jV2c4cVdIdHVQT0VNUXJNaXhVY3lQYUZp?=
 =?utf-8?B?Q2xIdXBVL1UvZ1FMd242dW4yOE5XUzdmbzJCekxLOVlmOEwvT0dzZCtRR0ti?=
 =?utf-8?B?Zzg1RnZKTzU2U1V3TmVuR2VaejcwcUVST25qc0RwM2RORkNla1R6N2ViZGtM?=
 =?utf-8?B?dmNnWDkwYTJFellEZkt0cTF3ejlrQ0Vna0tMTE5zM1NoZ3diZktNY3MweGZa?=
 =?utf-8?B?QWVxYkNIVXR1N09rZFo4L1kybFZHZkVMaTZDYjF6S1piRVVCcis0ZVQ2dWtJ?=
 =?utf-8?B?aFRDMTZBemhrMTZCUE52ZHdPL25pUXBqVk9NMlRwNklTdEJXa2NJNTQ2dEdD?=
 =?utf-8?B?ajhUUzVmcHUvTEw5Qm1sYmtlcS9JUW5MWVBPNitDTXcvR0wwTzAvaXpDa3pj?=
 =?utf-8?B?MWtqQmJYcEc2OGtNKy9MK3hBRTFDMlg1QTV4cG9haE1ZYzZlVFhhRnRTM29y?=
 =?utf-8?B?VzZWeVBZaitrckUzbUpwKzd4ZEgwZms4NlRSK1Nwb2ZNLzFIUmovSW9pc1ZT?=
 =?utf-8?B?dkwrTEJ2d1VucU50K05URmpxVDBseDhPd1NyNnpXd0JvZDErQkFMWUFsWGNn?=
 =?utf-8?B?WkppWnZGcDJnUVJ1dmZoczNaTEpqdTJjb2JTSmg5R2piWGxrdXJuaUd3amZU?=
 =?utf-8?B?Qy8xQnNaVFFDalBZNUtRQStLeHpjdXNHZG9LUlpEdURxUUltRVhPbXBrQ2w2?=
 =?utf-8?B?djRGaGk4Z013WlM1YTlrSnpUNlQrQ2hmNDk1dURsOHc3UURwbjc5N2tmY2Nr?=
 =?utf-8?B?MmQzVUlOYnFHMXp5MkU0dnBQOXg2N0RkcjBEaG1xeDFrYkVoVk0vbGdqbU9M?=
 =?utf-8?B?OXFYbmVtSDdyWEhOZmFLb2tWa1NLRVl0WnFUNnBQS3hLUEZBT2xWcDNoT3Na?=
 =?utf-8?B?NFQxNjN4b29jTTFqN2FWOGU3d1ptVWpGNDhHOC9qUXp2YTBQbWowVDMvdWNx?=
 =?utf-8?B?WERwQWZITDcvV2JHd2hzM0pUSTVCY2dnZTRrYXRHK1hTdXF3SWwrNWF6NlJj?=
 =?utf-8?B?OFgrYk9aUis1c2s1VEp0YkhEaUdWWkhrS0pYcFpDL2kxb0RqNmJEZU50UkJJ?=
 =?utf-8?B?QmVWdGErRE02dGpmMkFwaURwcmpqUnU2TlVwU2FWdGhNMmsrOVg4emtQa2xz?=
 =?utf-8?Q?L10c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431865f0-984f-4504-0455-08dba97675c2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 16:30:45.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPXPXrkRNjFeyUYEaJCs4QOX1F5+Vsfc0+bCtxtiNgSa3mlENkgedr/TXvDqc9ls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/29/23 15:08, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/2023 4:30 PM, Babu Moger wrote:
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add
>> comments to improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> After the typo that Shaopeng pointed out is fixed you
> can add:

Sure.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

-- 
Thanks
Babu Moger
