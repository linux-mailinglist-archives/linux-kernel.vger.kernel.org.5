Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5AB773C99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHHQHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjHHQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDE729D;
        Tue,  8 Aug 2023 08:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2V0KYftGF19E8h3Id2KWxL/S2LG5G6dC9FT2c8WSrhUJR+5jex/fqirtq8VOleUts0DHIVk7DyhSEQ4LSzsgCSTUGW1WsujwCOnzHo+K05ZEoJkYRltRvYpvFClVQoLi2/mNiGJglZKP8X+0Nhgt71Uj925dE4bpWY+N2TLwK/fi74FwiiIu84+yHWBtoxK9ng64Lk0AeMyIGGKTBcNHz8SBW5rhATwrn9IkgGwWwd0vxtmf3uaoJnCMm2CMaKHKHqPnv0Er6RG/8ruM4M4qDAVg+AlMu5nRMIfTSVRMZGblLr1NaAE0uI9rL75+3TrvREPOzuHDngy5jUH+AYA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9tL71pqQz3IJjk+70GlRPiNsV8/meuwjRTgGsCLjHA=;
 b=PyCR4zOwESgclLt2U3h7MWyTf8OPGDBT0bjLTSKRTEkTJQJKbsf2hjjwLGw8dPdXzm6VtZ8T99nuGUzJF2OIELrjvNOv0LonfU9zH9thGSd33rsoMU9mTc7sqGzCwB0c+mDFQvudoqlr/MZAHKOwdC1bs1dIxMyuMxmKG4k+EL7y4aWR+yOutLo8GV/rHRPrYAKj34jsKjb6Os//4y61NPKBlxUSaN7PMFaSH0rSXqLrFCDwxjwQIUUkeufirO8kIQV2Jby3C7Wb7XtNVZ97THwjzJXqfZzGi5zSDgruvrxd1iu96dWnRG5XPNMu3kzuis2rDOhshk9JE4D17W/EAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9tL71pqQz3IJjk+70GlRPiNsV8/meuwjRTgGsCLjHA=;
 b=SU+Qox2VkU9SX6/uUdS3ywdBa/AJI/ZEqU8xGTCY/MqlsnHV6yatL54uvqwe7Tk5Ak5WQHsHTsDyzizw/xWASvNazEly8czzW6UjgxWKEgl6lUvB8hPKLl/iTnyo5n1es0hCEL4e5YnR5XH2moMkeB9YWdikv52jXDYwiEVlX1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:18:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:18:10 +0000
Message-ID: <b5609e88-2bdb-44ad-8a3a-b61196ee540a@amd.com>
Date:   Tue, 8 Aug 2023 11:18:07 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
To:     Borislav Petkov <bp@alien8.de>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
 <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
 <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
 <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
 <20230808142007.GCZNJPFy8PqTJgTAN5@fat_crate.local>
 <a62282e0-3784-4d96-b632-fdd6d2627ca3@amd.com>
 <20230808143735.GDZNJTL0DlJd3225db@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230808143735.GDZNJTL0DlJd3225db@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:408:ec::17) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6eadb8-71e6-4092-a2d8-08db9822acec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0luB0BUSRnE5FjGrMlla95Lj+WDtgwGzjSOg5P56M+J4x4tgwcEtWviR+ReQeawkpqiqsEqB65R2zscRIUcBmNlFUjTPJj2C3I6jDdvp0EhO0aEgEoedET386uNbZ+vRFOzNiUDRDzVzrV8n/zxZwKHugUH6GFHqITDUHPDdgCr9TzeDj3lTzBXmLjuStK7dL0EQcZ19NmWgznETCJifL4aBucR+igji+LHAPa6PpC7Q8Uyr7y5T6Ct2/A6iU4HvUvLavQT1YjyBoxKQB0gevz4YHqNJ7TiNS6gjM5lCAH3CD568YXbbOLWVMRLWc1nwQXv4Nsf3KVewp71tggCyA+MzLt4qnxACE1o7u91J9J3/v/hUnSGy7KZhPyzQv5zSVy5/HSn+CwnW/oeRlBIxPbHsyAS783dCdxo0eoooO3naUR3OQXzC3ftcBxs3r3zmvIPkOz5H3tv5ETXKIEk+TAl0gt3tyz83HRwiwu/rioQeuBtp4heWk9kj4TiPZYGH2+7j2teAG7LHRRlueDZhjnapa2mVKJU2O+9blRPT+X0tqZWiv/DoYKfXI2DERH7MoyFJB5aUgNqiQLWBSeLiQeGgeulOz/9aS1VMP35TAfU6TTsHnsobEjmz4jV8S1o1VBKcS/PbStZUVcKQSeT80Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(1800799003)(186006)(2906002)(41300700001)(8936002)(316002)(8676002)(5660300002)(44832011)(36756003)(31696002)(86362001)(2616005)(6666004)(54906003)(6486002)(38100700002)(478600001)(31686004)(53546011)(6506007)(26005)(6512007)(66476007)(4326008)(6916009)(66946007)(83380400001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29CaVZkcThGOGdPODRzVzliUGRLMjQzZ1E5RW5SNVZNdEZkMWFhSElwUTJW?=
 =?utf-8?B?NzJFMnNiVDNjVllwbXNPQ01Kdjg5T1cyaFpIRXlXWUp5dlY4aXlhbTR0cENr?=
 =?utf-8?B?NWlQaTQ5Sis4c2E3WnhodU5RdzlOUHVvRFJHQm9DdWRUSEdvZ0FiTHFIRzRV?=
 =?utf-8?B?bDVQMXdZd21ZL1MzRXhobjcvL1VZclNnd1FDNnlBbE13RVdTMGpWdmhXczlh?=
 =?utf-8?B?dDE1L0xKYzdNYVlCbjgvTXZVaUF6bDZpdlJ1Z2xFc2dXSGdhVXpCa0JCU0JP?=
 =?utf-8?B?NXJ3NmRoS0Nsd2ZBamF6NDJOODBOY3h4Uk43cnc0dGpVYmN4cVFxRm8xMllR?=
 =?utf-8?B?K1Q2WGVnMlk3V1RsTjVmdlpFdGtncUFWbElBbGpDQ3VwVEZlNG9OZEJjc2JV?=
 =?utf-8?B?K0pwTTU5eHdvZk1kWlErOVEyWGdMMUU1clV0ZU9vTmZ6VklwN2tBdjU2SGIz?=
 =?utf-8?B?SjZuRU41WGsxWC94NzZGSHlDNlE5Q1M5cTk0MlNjNzhBTldzSWloWjNjT0E5?=
 =?utf-8?B?WTR0WGIyZWFRUndsZis3dC9Nb2JlVjhiNWFYUVZYOVhMV1IyMnM2NWNIQnkr?=
 =?utf-8?B?MGZtVjFnT0hvaFd3T1FRZWx3L3JjYUdYSjFmeWF1UTF5d2NKMTZCbU5Zc2RJ?=
 =?utf-8?B?RmtCcU91eXY2MksxNmk1MzdyZXZhZUUwVmsvU3dwSlBncmhBcjJQUlNMMUVt?=
 =?utf-8?B?NWl4UFZ1MjhoTW1IVG4xS1BpSlpXR3RYWWlweityZzlkS2w0a1RQYWN3M21V?=
 =?utf-8?B?VGFKNXhOL1ZoRTcwUHF1eHRYaE1iRDFJdVlUY3p0Skd6d2N5SEl6K3ZWOWY0?=
 =?utf-8?B?NTlkYVRrOE1EWEkzc2ZUVk5MaGJackdxNERMYUR5aVlvbGNiVTRlcStqc0Yx?=
 =?utf-8?B?ZS9MM0IxYldhMFFvZnJrWTBqajZ4RnVCamRJb2JXblcvaXZiMzZHUitINHdy?=
 =?utf-8?B?ZFBzOTg1OEhnWkg4NWZnSHRrVVRLRW41ZDYzUGFTRHdjUnJhM2RQbHR2ejQ3?=
 =?utf-8?B?Ui9MWnAwRW9qbmJkQUgzRHgyaG4rZVVWSEJqZm1BdktqS3VFM3hVendnU3VU?=
 =?utf-8?B?OUJ1V1hMYVdlVVZZM1Jtc1d1QXRDUTdTTUIxcFNIZnQrZEVRQkZsazRJc1or?=
 =?utf-8?B?ZmxzaGFLSFNWSHZUdXI1ZTVEOWJkbHV4WEdRMzN0cTJQWTJpVFRsd2ZHKzQr?=
 =?utf-8?B?L2VEQjViMm9OeTJ3SGJ2SWtTT2ZTZFpLd2NkSjZSamprOG16VGNwbVBmMUU4?=
 =?utf-8?B?L0xDd1V5TEowRzdCV3pJR0UwQzZCTVJRY1Q2MVREbWdEdUJxTXBDR2FOc1VI?=
 =?utf-8?B?a0lERlBOTG13MG5hRDNBUGJkZHdmdG9ReXVZZXVuWTdaZ1B6QjBYLzBCamsx?=
 =?utf-8?B?VFBxblN1ZWVvY1lXSDBrWFp2YWV2dUVlUmowdldRZlBBYVQ1cDJZekJOaHpC?=
 =?utf-8?B?K0d6WXh1aGFQWE02c0MxbGNnUXJmRGFSUmU0RTFzcEhURGZJSytvQVUyZmpm?=
 =?utf-8?B?NldWMXlVUnJCeCtST1ZDbUlEcTJpRUpQcHNtWGVDeW1EUnVic2FkWkxsSVFU?=
 =?utf-8?B?Q2FJeWJmdmZBNWRYSzdtajlqbUJQczV5UzM5dHBUK05ObUpZNCs4NEJyYVpt?=
 =?utf-8?B?bjgvdk5LSDZkR1h2dnRFUks1ODUzSE5PQyszemhUYU4rcWJTbkVsYmJBa1lO?=
 =?utf-8?B?WExVWUhaUGZuMzVhbmN3cVI4Vi80SXRMMHUxdWUxZGNTcmtKcE90bE5Ra2xp?=
 =?utf-8?B?L3k5M1ZXempGbDhXRXBqR2dNdjVzQW04NGNZZ0RDdVpjTWtTRTBIOXlHeURT?=
 =?utf-8?B?TmhHTm1oUXlENWJPU3YwdDhsZ3hpOGJwUFM4RXphTitJS2FqMXcweE5RcDQ3?=
 =?utf-8?B?ZDh4cllnd0xYRXNWVnBZV0N1WmtOQ0FNeXZaM0xrQW81Zmo0SWNsY1E4Z2lW?=
 =?utf-8?B?bzdQOUFKcXRmbkd3M2FRK3FjUHVRaHkvbXdteko5SnpULzh3ZGNOQW1iOXZ4?=
 =?utf-8?B?MU5uNFFIblRnbTdHODRma0o1MXp3YlVQbmk2dHNxTitWaWFxMXlKRDh2djJl?=
 =?utf-8?B?c3lPUGtaUiszd09YWGhtSTFDeVdGbHl1ekx0aGJDQkloY0FlZkxqZTdPWFlK?=
 =?utf-8?Q?l+Nyj9M0/UOGTJP1Qe5XUCPfy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6eadb8-71e6-4092-a2d8-08db9822acec
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:18:10.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRe76hEGJF7P3h/7waN8qvlDdUzXkuUuwuaBSa7pQepYkSLxNCz4tmdinF9xTpjKuXmGsCFwnFQVXUTUv3hWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 10:37 AM, Borislav Petkov wrote:
> On Tue, Aug 08, 2023 at 10:28:51AM -0400, Yazen Ghannam wrote:
>> Because this isn't intended to be only for MCA errors. The translation code
>> is related to the AMD Data Fabric. And it'll be a common back-end for memory
>> errors coming from MCA and CXL.
> 
> But EDAC is not only about memory errors. Why not extend this into
> something which does other RAS functionality instead of doing a second
> one which is more or less related?
>
> mce_amd is already loaded on the system, why add a second module if it
> can be part of the first one just the same?
>

I think it would be better to avoid dependencies between independent things.

For example, amd_smn_read() is mostly used in amd64_edac. EDAC was the 
original user of SMN accesses, and all the SMN stuff could have been 
included in EDAC. However, SMN is not specifically for EDAC, so it was 
added to amd_nb.c to be commonly available. Currently, SMN accesses are 
done in other modules. I don't think it would have been a good idea to 
force other modules or subsystems to require EDAC to be used.

This is my reasoning for a separate, independent module for the 
translation. EDAC is the first user of this. But there will be future 
code that can leverage this, like CXL, and even the MCE subsystem. And, 
yes, mce_amd may be already loaded, but this isn't a given. A person may 
want MCE and CXL support without wanting to use EDAC.

Furthermore, some things using the translation will be built-in, so the 
translation module will need to be built-in. And it seems unnecessary to 
require all of mce_amd to be built-in just for the translation part.

> Strictly speaking, this all should've been drivers/ras/ from the very
> beginning and all EDAC should move there but that's going to be madness
> to do now.
> 

I agree. And I don't think much of the existing things in EDAC should be 
moved out. But this is new code, so there's an opportunity to have it in 
a more appropriate place.

And, thinking on it more, this could be another example for future 
"common RAS" functionality. Isn't that why the CEC is in drivers/ras? It 
seems like things go into EDAC because it's thought of as the de facto 
RAS location. But why have something in EDAC if it doesn't provide EDAC 
functionality? Other RAS things, like AER, APEI, etc., don't live in EDAC.

Thanks,
Yazen



