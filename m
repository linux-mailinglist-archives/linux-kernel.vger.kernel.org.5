Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B181B77D3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbjHOULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbjHOUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:11:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0641BE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVWvA/gGubVQVG3NZISloTB+oxAgzDbRg4IotAyMvkPJf/xy8WAlQALy6fJdR+VSWcwbv3R3yC87DkDugHiXLBin65khkTPDg+d2cgaP1BsMEoJPIZJs6L8aRlIpv9YGuj2/maEQbZYQ9UBNb3YsK06ghDxVwMj80ZJeNVd++N5/NZ1m+kzmsqgIvMSQelNqITsbn5/MXnisz8rSLGLg9j3qXYugfHiykpGno0dGQ5kc5HFIDVjUmIvFa9DlmleVghk3XV3qFdW/anEwFpzG0YUCatxmd/vTbdFD3yJbA+/6XiHmtlqwMGKl2hKVmRO+3nfeTh9kE6iOW8tTVKaJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzJh3MHNVIW98qKstqWgXKdU9BxD/uT4H5N5J4utCOM=;
 b=Y3m9cxV5quq93v8RhpTEwUu0wZWgquvr1h8k2T9OmdVUTIdPudn6p6buzDVVBihN7yQKujAkyFPYjElSk9CnGnBLQ+4KSVADxWq1iUtppfkzKUnKO9V8zJKYfNHvHU8ufNJ0EL2JVCl8pogW1dXJA4oVCf+0SUpB4+bS55kGKjlJOMefET42qi3rYDyLFawf6rcAkUokn8cP/4Xpo1twetH2i+A5RZYep4KMX2MM/Izs1szthJBZFl6sSf9CeYno7ovhKbYpEeMk+wC4lLkArP9Q1aFPRW/UkTP0HctEBT7DKeSDh66mjH5JyzdwsB9eToIZi1GZjLxZlKfTm8BopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzJh3MHNVIW98qKstqWgXKdU9BxD/uT4H5N5J4utCOM=;
 b=BJXJ6B3Ki38qvjeeh8wQGm2CKX/bclZY4xner3Q0kTKvgAVTKrLt68xU+mJUJLsrHzK/MS9THlEk8PsG7PqV9DgWRxwdTv1IXPKO4x63tYXi9P3/T6MXywj9+Zcrenv7csMnDRPGRTAyoy9GffXo8tC1y0qAEcEPPWwb89XfgiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 20:11:26 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 20:11:25 +0000
Message-ID: <ed962dc3-1e7e-8959-7921-365fae705594@amd.com>
Date:   Tue, 15 Aug 2023 15:11:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/5] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHbRkFdmdQyPHjOjnnyuYXPLT2GKmQTE8fU9aDFMtri8ew@mail.gmail.com>
 <64dab7a322eef_2138e29421@dwillia2-xfh.jf.intel.com.notmuch>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <64dab7a322eef_2138e29421@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:806:f2::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ef7e0a-d2ee-4bbf-bfd1-08db9dcbcda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTATUGsq05olUwpF32OvUFM5W/x18eRfoiqMxtVYZM2/0Eo6jro8xcZx1spxb0/+BBHNGQ+NcLwicyhviz2RJAosFAMBJ85/e23eLtvFbB7e62V70wa9D/xX6pwt+H0xeGSZGzV418fvAo4au9Q/48o2U79hIpahBSxlnnFdGvYX4AnurmhQwfVZQeh9AFUQO3QIAyuRbvtnXhadBaIsdLHuPRUv/n+LeCnmC1imutU7mT9MdkZrz5U77g+hERoSiAfkVNMOjhVjAiHF1hyyu01skZeWmDeAOb7KxlG4BHGAaF0wIzWnqcg+HklYzmsIWhSOZw6y32+Tx4O/TvTVi5/JlNM+rDsNrtezX9akxNu3btfMlmkk8bVXTvEm+DiDhRRlo0zZwY4KvXJ5OuwIvHVdc4IlFP1JltIlhwtbTvpKXBntfhKZ0hVgHTUbpK5BLUl5c5KtDEH5xiEUpZs8VfuO7a4XogzjZK4V25/gW7PRm5ieIEp8AV0ruY/yTVS3Ps/NMv7cxU0aDt+VXHQM3t3Qe/lUj1zFfh3W+/PP+72B5ZoYVFW1p/gioFbVSEruAQm3uic9PQU6jIROD8Fsvz3GMCZMsCErEIgMFygvkcIaZx+oSQB6HvNNT4RAbJScuM4LPCSM/ccV+r9WSeoQlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199024)(1800799009)(186009)(26005)(6486002)(31686004)(38100700002)(53546011)(6506007)(54906003)(31696002)(86362001)(316002)(36756003)(66946007)(5660300002)(478600001)(8936002)(4326008)(8676002)(83380400001)(41300700001)(66476007)(2906002)(66556008)(6512007)(2616005)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VJajM5dHJDaFZGZ09nMEUvTEhkY0RmbFR2R1J0dTdmWExNa29nYWl2WE5w?=
 =?utf-8?B?MFFnNXF5TlkxWEh1Vnllc0xsaUhLWjJHZGx1ZWFkMVAvcFFMbDR0ZWFWN2ZU?=
 =?utf-8?B?YVhJNy9nOGpnVVN3d1dMbldjL2t2Zm9jWFcyalJZSkplY1h6Vm1hTHRybWww?=
 =?utf-8?B?c3Q0QVJuU1daNUxPSXFwczZTckpUTDBVOCsvdUo1c1FuNWd3NmpQQnlDRFRZ?=
 =?utf-8?B?WlA2VGxKZGtraXhtTFBnb21FQ3FJY0NMVnRjZzgzRTUxMiszMURydXRFRSta?=
 =?utf-8?B?cDA1YUVtTHVESlFDcEVXQ05oMDRTNDZ6VGpQbHBqNXlPem5Oc2lkUngvNnlJ?=
 =?utf-8?B?UUlOTG94OVVKREUrZ2lhSWRpb3ZZTXJGaGlTajVnL05IZVJBd2w4VnpmNzRu?=
 =?utf-8?B?RjloYmtWUFZxbEFmUWNvVTAyb29nUmxTWDhWWlc4MzhQUW5nQXdjK3BhaUhQ?=
 =?utf-8?B?SHN2amhjdDZzTDBwcEdRVkVGbm9zWTRqUkhsc2sxVXFVL0pEWnQyOUJvUjBE?=
 =?utf-8?B?UldUSmdKQzI3UVgrOXg3L1F5alpPN1N2SytaMWd5TTlEbTBwemd5MmppdTdv?=
 =?utf-8?B?WXMyaW9WZXlQUW5NWDA0b3JtZFdMSFVFVjdmTmdhRXR5eGlTZXVTWFAycnA4?=
 =?utf-8?B?ZU5pZTJlTHg1cjZ4WHZtOGhJRmhVdU9KM2t3elpkT0psK285dTV5MDFNcTIw?=
 =?utf-8?B?MWxqcktTZDI2cC91KzZkWmtsVGpXS3gxOCtvWDZ2bU1zQ0pvSFFVaG5VQnFF?=
 =?utf-8?B?QWs4Sm9lK2tBcnF4Nmg0b0pmWVRRMjFnUEkwL1lCSllVZDgrelhkNVE1d0Z2?=
 =?utf-8?B?K3FEbFB1Qmh1WXRkdHVxVE8xK3ZlTFJJMDVjV05XczJhZVJpZ2VnTlVrQysx?=
 =?utf-8?B?OFJKZlJxUG1jWjVObDlBRmtJb3Jjd1RFUmFnM0Z6VG9BMXJ1Z3Q2ZUVBRTds?=
 =?utf-8?B?Nkp0YWYvV1lPekxWZTdxeHA0WWpmZ09ybDBHdXlUSmp4Y2k0bU83MUhmVFQy?=
 =?utf-8?B?dVgrb1M0bWRjeTcvaGg5TXVGdS9SakFac3padkNJdGNnV2E4c0F6c2pGUmxn?=
 =?utf-8?B?T1M4S0MwMmNob3VtbHgwRUczK0M5NE0rcHJTNEhkR1NBLzVQamhPVEJSL1N6?=
 =?utf-8?B?aERjUC80VGtFZGVtRWhiWHl5ckptQTZIZm4rdmltTG1VSmg4akM0L1JLL3Fv?=
 =?utf-8?B?d1ZCN3BjWHhpU2loRjFQNG5EUnRzTzB1NXJFQXcvYUZlOUZJajB0aDBUQ1A5?=
 =?utf-8?B?enVycWtnUFViZ1VxSXphdjZURFdKT0duc0NVYU51NnlGWW10ay83bU9DVmdK?=
 =?utf-8?B?NzFlaHVYOVRQR1pldTFuN1BkY1Budk5KQSsydWFMcGVBdUZyVGZNUUpYVjZm?=
 =?utf-8?B?TkFVOVppU1pndU85dUtnRWlWSkFqMTBrYmJWcmxtdzgrTjRGV2treXpLTjVV?=
 =?utf-8?B?TTVaV09RR0toVzZxZmtqcyt1b28wNm16QTAvYXQrekorN080aFFkdVdBQ2FE?=
 =?utf-8?B?Wm9JQ1pxWXpROWt0U2gvNkd4b1RuZUJLMmd4cTcwZDFkd2JVTUZqOERtaCtu?=
 =?utf-8?B?bE5HUnljWTRHOXBQTXI5c3NsWnRIZlRvUURjZDNRYzR1bDBMTHU5NEp1Y0xo?=
 =?utf-8?B?cEorSWhFY1lxczU4bW9QWlRGVnFZZjY3UU1SZWtuU204OGxUeTVtUE9EVnJR?=
 =?utf-8?B?M2NWVGJUOUNaOVV2TG5EQ01VdDVhUVNuYWVnWFdWMCsxV3pLenE5VWpmekFK?=
 =?utf-8?B?aTlwNzVzcndGR1lINlBFemZqUWJMb2pNNnB5UFBHT1BKMW5TYVM4TkkyYWYr?=
 =?utf-8?B?UllYZmRBSmxrYzZhR1U0dlU3cEdzeHpDdnRDckZ3MHMwenFtTnIxOGFGdDQ0?=
 =?utf-8?B?QXJQZGtzZGFzUVRpeFNxRjJNcGc1R05PanE5clh3Q3BhM1d6ZHEzbVhNZDFY?=
 =?utf-8?B?emc0VXlkZWJNdk9tTVlyaWpoREltUmJtR1N0NDF4Nnh2WGVMTHA5ZzllMFVw?=
 =?utf-8?B?Q2FSSG5CeGhrdFl5YjZIUWpvSTh0UmZwaTAxa1Y1eVZnd1NGWkw3R1F6NXhG?=
 =?utf-8?B?SUhMeUE1Zk00RUNWTUd0OE9lTjVUNjUvaEVkTEFlbUZHemdkQW5WSHlQNDdU?=
 =?utf-8?Q?5E/zDk8Nh9h/vUZyeIOa0x+Mn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ef7e0a-d2ee-4bbf-bfd1-08db9dcbcda5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 20:11:25.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vo543IIoajWE8J87k49E0vLo97slargqRMbM8Lq5E2Hga6vW5X90F78xHQiw8+2dwGV+jiu5IeMVqxJ/Khbr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 18:24, Dan Williams wrote:
> Dionna Amalie Glaze wrote:
>>>
>>>          switch (ioctl) {
>>>          case SNP_GET_REPORT:
>>> -               ret = get_report(snp_dev, &input);
>>> +               ret = get_report(snp_dev, &input, SNP_UARG);
>>>                  break;
>>>          case SNP_GET_DERIVED_KEY:
>>>                  ret = get_derived_key(snp_dev, &input);
>>>                  break;
>>
>> Do we have an agreement around the continued existence of sev-guest
>> for supporting derived keys, is that similarly slated for the chopping
>> block, or is it left undecided?
>> It appears your choice to not include the uarg/karg extension here is
>> deliberate.
> 
> I do want to understand the argument from James a bit more, but the
> exlcusion here was simply because there is currently no support for this
> concept from other vendors.
> 
> That said, if it remains a vendor unique concept and continues getting
> suspicious looks from folks like James, it may indeed be something the
> kernel wants to jettison.

I'm not sure why we would want to jettison it. Just because other vendors 
don't have a key derivation function doesn't mean it can't be useful to 
customers that want to use it on AMD platforms.

Thanks,
Tom

> 
>>>          case SNP_GET_EXT_REPORT:
>>> -               ret = get_ext_report(snp_dev, &input);
>>> +               ret = get_ext_report(snp_dev, &input, SNP_UARG);
>>>                  break;
>>>          default:
>>>                  break;
>>>
>>
>> Reviewed-by: Dionna Glaze <dionnaglaze@google.com>
> 
> Thanks for all your help on this!
