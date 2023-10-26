Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC57D8344
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbjJZNGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:05:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A0C1A6;
        Thu, 26 Oct 2023 06:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBtO9nXtGHKF3EBmVlF1aR7iU30S73Eqp6rDtC05ZjF6TvAqrQBrkIfqxOxpBW1piNy0vgC3wroSnJnJ4LHggMT0LTdhsZeCaIvjQrbAUhBo9HsKOnbIZ4hCSLFfsDFegIsJqOO6LOWbls8syGMuoJYcxiZnC+5C7WIth9kraHn9Es/0Len7+midFsO+Q4+VfimFuPvy4JNy8n76+O5pD6PN40XdPAgW/iuJGShPfn8DNCdTVfWZSZoh0EabfTNJWjmi+epjXun59JyFsz6prGQW90vb2g2uh/tUXYPwcg/Rqb3B//UYOhEEbFhPKRWkNSaV7Qlxa8OVBDSwJDkRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5Gr7Rd/2b/T2NPoBs07IjSJnKXbKqRzQr6T8o31WbQ=;
 b=YQUU0+Factuh3ZAMNzGXnQbmS4SoSfZmc9fzvAzOohpXPV2YPqziv5sABlaMNUCDeYPyQZ781bOokU5T8ZXOQb0eIDpAfu2iYDtpuBIloIwGOw7Ddv48Ohi8ncNEF0jDKTgDuXMcSKurVM/BwyQ8tc4tHYLcMnM5V3nvAUUTr6q0n1fxmqdWZPbYBmU7tBESxisxceZqkmLvzVXFbXpHKFQbU/wesexQdyRCrEmetGeOFZ1LxWcTOVxNvvmrowTsWcZtJngvnoPyrOHH7WBliCQNfB1cc0YJlVfkQ9aBya1G4UxmK59HW01HEcsIJge1q8YoAMphznw8iN4ICmKf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5Gr7Rd/2b/T2NPoBs07IjSJnKXbKqRzQr6T8o31WbQ=;
 b=NGBMTs2MuID4muyXe9z8mX6t1Dv5f7pzyU19zXZnP4qkApy67uQRHMpHMA7cC5nTfWRGq5ZV4SRWzL227ER01nnhH9/ZpgeKMI2okXri51AdkE9wTFyonDnDmexv9XGh8b3Zm/M74PTTKt+2g9fVAs7P5MEKnP1dtQclDI1F80k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 13:05:54 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:05:54 +0000
Message-ID: <dd13363e-fd7e-4e88-8c23-91cfffe11dc3@amd.com>
Date:   Thu, 26 Oct 2023 09:05:51 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
To:     Borislav Petkov <bp@alien8.de>,
        "M K, Muralidhara" <muralimk@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
 <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
 <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
 <850a3e78-f663-c696-2141-7aefb043b6da@amd.com>
 <20231026123754.GBZTpdojw+pNuZMyJy@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231026123754.GBZTpdojw+pNuZMyJy@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:408:60::43) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: af04a31a-4060-4d84-5700-08dbd624493c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eX4y0ULwQiBqksGB697x0keKMK2UCBiF5OZ7h/JBLg4dJRJDDQu51v1D6ycaZT/Xg/xcZOP2OK8cQBHWSomFmU29yQiymLYCna/M0rRUA0T6tuA93H5f7+OLXvzB65b01RASbGueEqKLoDmUf8SVD6Sg4sD9F9q6BhV/U5wY9xcfPf2dCwiXFITrb48pTNFmih/4mOTpvhxZPiiOI5RtAwP9w0qyZIQ+W6FXlLxRKA8vEbQVw5JHOtHn4gGAxQggdKx04EDFZe5Ep4btS/Id1XvvKHF58Tqv5kThNfERFYvvAY1dbelx4rdLNU1x/FlrxElxOwe233oYTA8PNRh5kI+QfUa/GWWY0TWUTO+DqFPJntW66IJgg0KuzXXwtPh4IZAeE3nvQhSJcvlCzHAG116V1pvkEFJfeI13toyu11imNE8SoSx5hB3iFSRFqlVHvRIkmqbaLlyLuunzVg0J+s7CSEXh+2GiZm6rqhw+3GfvzclkqPmSPIs67TZfa1Pr/K47603dLcnD3FEnlB6LAGbNaI08HNrbGfRz7g62egjY4f2a4xjB4WbIsnw69JmcaCr3bow8+DN1ng6+O7Un1Mj3ps9+376X13p/OG4ZhLq89yDob8PAAIW0XbjOx36HgGGSQMCS0+Exn3/Rez/4lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31686004)(2906002)(4744005)(41300700001)(6512007)(6506007)(4326008)(44832011)(38100700002)(86362001)(83380400001)(5660300002)(26005)(478600001)(2616005)(53546011)(36756003)(8936002)(8676002)(966005)(31696002)(6666004)(110136005)(66476007)(6636002)(66946007)(316002)(66556008)(6486002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtxZW9nU0ZGVnFYa3ROeTZYOHJHS0JlWjROVFY4eXhremwvOEh4MlRZSGJN?=
 =?utf-8?B?SHZ6RnJvNTkyb05OQWI1eDRoaVZBVmNQR1RwUkRpRE5vVEFDa2RNOUJYNElq?=
 =?utf-8?B?dDB1aldtc3JwV29haHF2THlZbXlDWXF2cFRaMnZKSGdaWlBUbzZBc3VyblJ1?=
 =?utf-8?B?VWxrcnM1ZW9jZG9SWU5jU05SWmZmdmU0V3Vtd2JhMzJPZ2l3Rk9Xd0YzY0l3?=
 =?utf-8?B?RXdDWFhJYVpCVUlXeUd2UkNsc3NPOHVmbjRqNUl1MEdReWJ0MVlMbWkrNmFv?=
 =?utf-8?B?NG5hZ0c4ajZnekp2N2FkUFF5TmZUZmRXMGRpblBQeVh2WDlzQlh1VFVMY1c2?=
 =?utf-8?B?alJhZUkza1VyQS9nTzl4bDM5VDl3WkxNamNZMnM2eEwzWWNRQWNKODB4a0tz?=
 =?utf-8?B?VW9hUWViTXkzbHkxb2gwUTh3ZUo0NTNDc3Z3bENtSnpWYkF5MFBweUdtTVBq?=
 =?utf-8?B?eTU1cFVnWDRjcUdxNHh4a0l5bjRRVlpqaThmdExHcXZFV2dMVHhPV1lWeTht?=
 =?utf-8?B?RnZqVS9IdnRsU2dJK3l2V0ZLdTBpTjc4cDAwQk9mTUV5ZzV5emxVa21RZElx?=
 =?utf-8?B?OVd4WDZPdVF1dDZ0cjVIeWVrWmEwcXVlWDlaVmFZbnIrTUo5bHFkbzFHcWxq?=
 =?utf-8?B?dlhla0dKTjYvSXVidEtkeE5vc09MaWxGSjcrdW9laVVRWHAyWEYvMjQzYnF4?=
 =?utf-8?B?MTAwYjVxZldLUjNZeDFEdDFidnFJaFJCTjVsbVo0YWEzclpQUWlMT3V6L2dC?=
 =?utf-8?B?MjJnTHVNUS9zeGtZdlRnRlpVdDkvV0QxWU1aZVc5MUNaYzFsT1hCWGR3b29K?=
 =?utf-8?B?Y1pleHdLRSs5TysrRDN1dklIOGZ4NzVyQzlVMXVJZjBSaUNkcGt5YXhTTWg3?=
 =?utf-8?B?WUhXSXAzdituL1dxRDZCY0pFc0hXLzFsRjlLM3dpNko0TE1rdHBXUytPZldL?=
 =?utf-8?B?NHNBY0xtZXl1NGczSGtWTTJiWlNQNXZEWUxDSjM2NHhWSmwydEdTbmljZE5o?=
 =?utf-8?B?cVExeWI5K2UyL0VjTWpncWYzbTkrcUQ0T0V0K2dPZy9MZ1p3UmNJcGYvNjN5?=
 =?utf-8?B?UTBGbytYM1RBWnRRQVBvcFdFbmJJMkVNMlJoRDdRZ3BYa3MwQWF6UkdyME1M?=
 =?utf-8?B?UmFDUHZNMzB0YUZuaHRiQXk3bkYwaTh0bTZmUDRKblV6ak9vdHhUMjhqRlIv?=
 =?utf-8?B?eFBRMm9GUjljWlNvbU5ycEpZTmpmam1Ea0ZaRlBNelcrU3F1T2VxQ3N5UFEr?=
 =?utf-8?B?SlJ4dHlIeExGMk1ZQTZwRmNoa3hSSGZDcmR1bk5KQkxMbjNuMno1US91ZDVu?=
 =?utf-8?B?eUpZNk0xS1hOelR0a3o2c2drL2NDZFM4cWZVNWpZSW1wNFpxS3hJMjFOdnE1?=
 =?utf-8?B?TTYxS0twMDZCeGFlNDJLbnNaQ1B4VXllRncrWDlQTHFQSXJKVFVPbi83bXQ0?=
 =?utf-8?B?aDh3VjBGd3JMeUlweVIraXplWklpVitsVGNxZGlJRStLZkRaZEZKVDg2bGpu?=
 =?utf-8?B?YUNkcm0xRGl2Zm10bm8zY3JUaGo4b25PdUpsRGFJWlhieE5MbERIMW9NNXlZ?=
 =?utf-8?B?K3U2YUNGNFUwTDRLRkh2ZE1KREt1clB4Nk1CakdKSEoxZXZHb2d6ZEpUUGdy?=
 =?utf-8?B?MmZNZTlPVHFBMlUxZ0J1a01ZRFhVR1YxeHNvWEtiMzhOcWh6QnRtY1lZUGRj?=
 =?utf-8?B?Rm1UQ0lGTm5kUXRoWEErTW1HNUtsMk5ZbzVwa2dlYTdxMUlHUEpoVzcyREtW?=
 =?utf-8?B?ckpyVUc0RWZiNzQ2eTNvaTgwaTlkUS9UTklRWDJNc1VwbzZNVzE4d1F0aDVw?=
 =?utf-8?B?bGZNQ3NaOTRSZjNpdmh1dDJ3VE5NTDFZR0I4dzAzbVp5VWJrY1I3SUswN2wv?=
 =?utf-8?B?eEpQUU5pelZtbDhBQnMvS1lpOVR6MjhwNWlRQUNiTFJrbkZyV0NlVGh5aWJS?=
 =?utf-8?B?ZCtpRXdzSnFSd25JOG1pZ29WU0tRVTdSNEdrT29BZFQvUnp4Nk53OGJDSU5p?=
 =?utf-8?B?eWtwVmpZMFkxM2p1dVA4YUhCZm16SjFZbDczeWkzSGkycWMwSTFPaE0ybmdG?=
 =?utf-8?B?aVNQcjdoNXJKamJ6eWxOUGJHUXI5VzNFOWZjSnFYVEEzNHhsdUpUSzROSTc4?=
 =?utf-8?Q?6LEj4jna8xgADZvJDn1TSh1Gb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af04a31a-4060-4d84-5700-08dbd624493c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:05:54.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuQb+08Lw0xofs3k/WzQbIBLuSVybi/0TovurWU0l4GseGWZcQU8mnchqRFssivvSM7Q8l+mZca7IJDYhwRjPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2023 8:37 AM, Borislav Petkov wrote:
> On Thu, Oct 26, 2023 at 05:32:17PM +0530, M K, Muralidhara wrote:
>> Not possible.  User has to check the kernel dmesg log and using "Ext.
>> Error code" user has to refer the "error string" in the PPR for
>> a particular Error code.
> 
> Let me paste from my previous email:
> 
> "If that is not possible with rasdaemon yet, then this patch should not
> remove the error descriptions but limit them only to the families for
> which they're valid.
> 
> Bottom line is, I don't want to have the situation mcelog is in where
> decoding errors with it is a total disaster.
> 
> IOW, I'd like error decoding on AMD to always work and be trivially easy
> to do."
> 

+Avadhut

Post-processing is one of the features that Avadhut implemented.

https://github.com/mchehab/rasdaemon/commit/932118b04a04104dfac6b8536419803f236e6118


Thanks,
Yazen

