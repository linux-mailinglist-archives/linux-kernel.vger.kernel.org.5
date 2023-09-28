Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1EB7B112E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjI1DZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1DZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:25:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A411F;
        Wed, 27 Sep 2023 20:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6BCF8LShCTDWh54KoYc98SFiRH3sxr0/vUsVFfoubFhwOdYYF5WfoafJwKbi0AC9+bqsWjKBJZIgnteUB4VidHXMZWrNCbzxHKh1OzzDBroKtNBdiqqDONV9rt+w8Ol9u8fiOw189FsKKVc7Nepg4UYEQYoZm2r8Z+VPvS0+Buw/LCBxGI7ESes1QyVEI0U7zRmNehmKDe8AKyjuvvWXQLGm5yIpYSAgcoMODwL7Va/Ve4Bla/h6JGzGNthj2Xiyr26g9PUomp+2BrMZiOzJtSrSqtaSu1h09XVuonfM0Vt5n/OTQOQMzEO+0RHLMEQ8+Yh/HOsK7g3bqWSeCDWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jckSvk1hFYc/b0KKpnq38oeIXRvjm/B2awV8mdYC0t8=;
 b=Rf7tRSNPxkiuPfTw/VVga8s1+5d4w7+q3FKitGabyCLwPmTZVxC1Lc/JD0vhEnzmZm0E8A3pexpB2PP3T7Gb82X47dSjcB4JOKz90i2XfxPbu/o85rzWuNWf4KdA76A/eB4gjL9gdYSotYe3SmHfsh6xJH95bD8F5/4M4Vke4iRAKOgXvSUaxYgM1NP2KN/H+jNODnj1Gb+WSWJunUNSmBk/Z0t1YguwWoh3HdCxzvRfY4MQHY3sBM9YE1zowmi/670Ib+fZnmyawGtQF7BgfvaWhp/m3Saa3neEg2hVBVA9wYVk0JIqhD8/HTG3yblX0ozu27RfY6u5MmS2na9F4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jckSvk1hFYc/b0KKpnq38oeIXRvjm/B2awV8mdYC0t8=;
 b=XFS3sKHaYLMu209a/NEjo2UvOE98YbZrnnq4FftgiQ7KToPWQWdOtqVzlzf8MJTWb+FnArjibft4u2RUfDfy21KV5r0V7oU5sCV8FAudeH7tsLow73eEIs6KO20koluCsHMi7fEOz5H3V6gNdYM6DQVOrYVfRBaFjgvl5MNuVJ9tQt8UEz4zl3dLU5Y6zUvsgwg6C8bqt0a0xqEoDRbsZDhUOtbP2OiKyHAMYz/EVtF//TX+rjXTmlORPZGJAd7q28efm7y232YMZeMp9oUen1yoFShjeb5p/qdJEcqxL8MzLNXpb6dt3vqdCvaSFxZkvio9XxfBhpkkYmibk70CNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) by
 BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.24; Thu, 28 Sep 2023 03:25:14 +0000
Received: from DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454]) by DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454%3]) with mapi id 15.20.6792.021; Thu, 28 Sep 2023
 03:25:14 +0000
Message-ID: <23f8d25d-b6ae-dd9e-09d2-c28772f9c272@nvidia.com>
Date:   Wed, 27 Sep 2023 20:25:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hte: Annotate struct hte_device with __counted_by
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     timestamp@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175344.work.987-kees@kernel.org>
 <0d9a5fc1-1481-2c62-2a77-c8d46ee54f92@embeddedor.com>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <0d9a5fc1-1481-2c62-2a77-c8d46ee54f92@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To DS0PR12MB6607.namprd12.prod.outlook.com
 (2603:10b6:8:d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6607:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e35c403-fa1a-4b9c-4232-08dbbfd2874b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3tHpxioOqQQLQzVgFd3tvRAnkZDu7zv+ksUyE54wTzz3wZgWF4EBDDTzyaHWDmtoa+aotoC9rI3lFT/cv/U8R6YEcDjg7j6IhfxmV6XtfrtMRenuwLlnIUCV6XuGbTFinRw1iMV201y4ax/W+UDMAhWE6IjyMH3YJa1AwhEx2S0Rcg6Is7k4rZU/ChSyDw8l/H9fzsUyzRuFNKMsit4EokIQeU/ipUHwQ6HBPnbn+Atkpr70YRS0oQn1nVU+qEAJJZIo/r+jYzvGhXlyEaytoOR/sXewKRVr5XhNFFEnWhc2+b2n9wwt+OJv5Nw+2Akn7WHX7w7SlzoQHZGVdgLKeFlfk7D27wWRfZ5cBpz6rmu9d3Ubf+G9SmI+BJqJ/BjTl83Yuy2GknzsDQN11dL67muM/cML2+KMM4XsGIpKHtH6VdWiexWiBuINtIlu4IiNVuJ38SCW53/QL+Fn4yZ3V8/06OnEheyD1z1S8Rp28pnIpMv8urecQ3McWJEhvpHgUzP+JzWCz0aqK8eHAcVMseN387P6sjKjPu3L5SaxpgSrUoeMHyU9KAxafE9oPzX76ozEjBTNLSvt0zdp1kNGtHqkuycJCeLRac7jpyXyh/iZ83Zhz0zTD804DMghz2krOJZKMr+B+qQ0f85uZo2OCi59zhwAo8mmIL1fq5lnD1O18NYpTQHnBxMtcZmb/Xl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6607.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(2906002)(4744005)(316002)(8936002)(41300700001)(8676002)(4326008)(53546011)(5660300002)(36756003)(54906003)(66556008)(66476007)(966005)(110136005)(66946007)(31696002)(478600001)(86362001)(6506007)(6512007)(6486002)(6666004)(2616005)(38100700002)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hDY3d4dDloZkpQM1dmS3ZMazk3blVxbDlwT3NrUGpMNy8rNG9DNUdDY1c5?=
 =?utf-8?B?bUtKSGxmRmxpNk9rTlgwUDdnY3YrMmdRTGNOMERERWkvNTdobjFIZzFBTjBh?=
 =?utf-8?B?blVLdGZUZ016TW9yeDlJdm9rQ1J1V3M1bkN2N1ZDNjFMVTlHdEhMTm1ZMHp3?=
 =?utf-8?B?YnlDT0Z6ZFFBZC9SaStvSnJqU0N5dnUxSkJXeWxiSzhUaDh2RmVpb25WU25T?=
 =?utf-8?B?SzBNK3NGQTc4dTVzNFQyUWU3eDdnSU9vS0xSTHErZTJYYXl0aGtWd2hUWXFB?=
 =?utf-8?B?a0s3L2ZpbTlWbnNjYWU5b0toZUgrTEVPYVZvQ3BmRmtwN0ZoN0hDQVM1YWZF?=
 =?utf-8?B?a05EdEhtV1NQUS9mUEdZcHNpeTg2MDVOMDV5V2oxM2xzSHRVNGtYSjVvQmtP?=
 =?utf-8?B?cXFJUGtUMmFEMk1YWDJ2bGNCUVNRUUlydm9td0R0YVZENk1NbSt0ZEFIYmdB?=
 =?utf-8?B?azFoL2NiemJuOHNqNzdHSjJOR3djcFVISkQzMUZZaVZzOXI1QzVDS0F5WCta?=
 =?utf-8?B?MXhpNlM0aTN4RTRQa0RWdWRwcGtqckRQVURZa0t1WlNneG81V1NjQ2hBMC9q?=
 =?utf-8?B?R2ZmeTZ0eG5OUW1VamszTzdoVU5Ob200SFFZSEk0MXF5YmoyeHgreHlSMTh2?=
 =?utf-8?B?REVpc2xYV0FMb2VnMi9POFkxbmdsOWxQbXBURXFEMVUyWUY2YjJsNlM2dEhL?=
 =?utf-8?B?ZHNiZ0oxbXdKNWF0L2Nqa1lVUXZHcktCcnNjQUVzZDZxa2Fyd0JlTG4yYmxv?=
 =?utf-8?B?Rnd3YUN1aEI5MTA0S3crbk5UNVpodGsxdVI2OG80Vmd0azhnNlpvcGpzVmJK?=
 =?utf-8?B?ZmJPb2p4VGdTYkVVMm1tbitLWFlKWDVteFNlc1NJdUNWeEhEZWtYUDhuRXVT?=
 =?utf-8?B?aHU2TmQrbFU4UHJmUGRCZkhHWHlIVThKM2QxTDhvWTVTTkplT2tjZ3RySWF3?=
 =?utf-8?B?OHYvOXBacFJuN2Mvd0RkNy9qYXkyZnlrZlMyT2dacGZpS2w3b0JNWFJCZXNE?=
 =?utf-8?B?NFBQMlYwZU9ELzl1YVdzZDYrWW4wYVI0R1pmODhhYXNVNnUzUzNvcDVNNG9s?=
 =?utf-8?B?WjAvMUFwazhQamJkVnJXVWtTSS9XLzhqME1iNDVTTElwTWdhQjFUVkVZNFAw?=
 =?utf-8?B?SUlSSytCRGZWU2VBVjUwRkppVHlIVG9mbVhSVkQreFNFQnNiM3Y2N2JmQ1dW?=
 =?utf-8?B?WFFhWVNTWm1qQ2o1RDhaSkZkb0ZNWWtIOTJxTW9lbXJMUUo1UFlzeXg3TU5n?=
 =?utf-8?B?VmpLellZZ0xVcDhwS243ZVNJVmRKZnVJbSt5ZGNEdTFDa2dXWW1zbktxWmJp?=
 =?utf-8?B?UW1DVVNKTUFHMkJSd3JkV2tRWGMwaCtseVdSZW9uV3VqVUlhWUxISi8yS0sv?=
 =?utf-8?B?VldVN3JhNUYrSXhOTStUU0xHYzJVbW94RmR6eU5QMEQ4Tm1BNkZsUHJUS0Ri?=
 =?utf-8?B?QVRjcEZBcUc4VE03RGpRSmZHMFIwU2piY0k4VHQydGRMYnc1TFBMMGdlMC9v?=
 =?utf-8?B?ZE94OGNrcGt4L0ZZZ1B1MStyV3oxNmVKU2xXL1h1cDdJRmQxYjNMV1pWamdi?=
 =?utf-8?B?ZmRIc1BKQWR2WkZrZjgzdG4zclBiSHk1TWlGU1cyWlNnRXI2VUs3ZExIMk00?=
 =?utf-8?B?SWlGS1ZzWDZzTTdUbWs3SnkzSE1JK1h5YUZTZDZTSjZTTmlYTVQzdjMvSnVu?=
 =?utf-8?B?Nkw2SEpjTVZST3NuMTJJOWllclEyTWJkb2hFMTZoNCtid09uVFNJeFJmMDFn?=
 =?utf-8?B?bGNJa3h0Z1BFTGFvRXlrekIyZVZpVWlLUXcrUklzOE12ak9uS2MzTk9lQ1dG?=
 =?utf-8?B?bXoxeHNaWUxsOVRnMXhyeFBnRjRQTnRWbHdSQ0I2dmJMMHNEczlzMW14VGJY?=
 =?utf-8?B?Z1g2dm1LaEovZDltbWRlLzQxU1F2cE5ZbE1pV1VJeW1jRisvVjJTcG81akg4?=
 =?utf-8?B?aWZ0Zk9JM3RuNjI2NzU0OTVFakh6ZjhFK3NUc0JESTBlQ1ZYc1RkMXlFQ01S?=
 =?utf-8?B?S1FrUXp6VW91a0dCbm9QRDNHOFZlblJyQUhoOFZjNTA4TnhFRlYwbENQcHFL?=
 =?utf-8?B?bDlxcDh2OWxxVEZuSElyNHBMNlp3eEg1YXFOT0hJTGs5SkVqa2dTM2FMcUZy?=
 =?utf-8?Q?T6sIMF8F+PVNAknrQHRZAwrwz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e35c403-fa1a-4b9c-4232-08dbbfd2874b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:25:14.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dijSN1aOLjE2HbDQTQ8IDga/+qhFepQFYubmVDRXZXmmjiaXYmA+h9imFHMWqIVyhwzvV+xQmgPbUfUSUXOYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/23 9:37 AM, Gustavo A. R. Silva wrote:
> 
> 
> On 9/22/23 11:53, Kees Cook wrote:
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
>> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> As found with Coccinelle[1], add __counted_by for struct hte_device.
>>
>> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>>
>> Cc: Dipen Patel <dipenp@nvidia.com>
>> Cc: timestamp@lists.linux.dev
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
