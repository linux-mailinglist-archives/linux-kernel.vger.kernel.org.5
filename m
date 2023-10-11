Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE6D7C5AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjJKSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjJKSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:04:32 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3899D;
        Wed, 11 Oct 2023 11:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcE4rmRfsFm2q45Hq2+wHh5WqtzQ4cfH85JcBHeruedOkuB1OhKEPsRG/V4lcziWNXcCJJ3nvihdYzbtFYKooLOKM9DLI450bf/lIO78u+yd7G/eyjYxVgGGypYl/VUS52nMLSq/rXYWsrEG3Akk4xnexGiOC0Rn/i9NDWfCGMO5SZI94qahTPj+O2L2MllKUf0zTqbWDpvlCOG0AWfvy4nxJjVw6OFTC2Rh0itRQkeBujnkTD58VKyWbEM/uWx4aetxYi+HLnWnAN3kCsVYeTJtPOJVrUlR4zLXCMLP1xb1KdRipgcrXn+ds/m3bl5s5yoC3PKicyDjccl2wU3Bzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHu0i7th8KwH4T3VQvf6lZYnFYZ2oimZgXOUNaup2Jk=;
 b=JdKOtc435M3Ja23XaRa33q54/06rRCWc3ybbtA4d6dS0DFaMptEX9qIEJCHkF8+b4E1yJ6eRA76wmV6Tn085tEY01uFdVqM+0MfqsLQjcCaTIS7agB6EYn3QZug/whHgymPQVvSIT5o3jbrx+f5tWW9JUyUwin9qT3ZVHhuLM1Abjc5KueXdpyR992fUxBJEYCCNFRIcOo4AuKuwB2+pgcDVsms+rPN5nmA4liGvSAv8PO/jjFWk03lSiNCaOMZrIAUbchAw2vzzJ7NO7+rVJxXbslu3OwrYZuSwB37+Ajk31aBAUtEsHAWC8bo+68SeUGWKoiqBczLcxHOCHgkEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHu0i7th8KwH4T3VQvf6lZYnFYZ2oimZgXOUNaup2Jk=;
 b=fxpEpepbvt8iFZZvzIpqWrU/TDA8Gbi/MzzqmgQmqU81ObtXjC0US6z4LA4RG5E4LTC+s3AtVspTt47J0CCJZo8NPfCP1k3+FSWi1w3x1bgXCh+fMo6ZuUWwcVfZ89jM6mep8CCtFLdkUPNFtFRYM7HXdans1OHnv6UDd9ri93yrUazv+8Bhb21fvLmvZRy18bW+txSHUJbdS59IW1tGFvLpAEkSitTprzvYBLJFG9Kd5qnaXMmQ9Ypb+Fjb+jKpyjMMewwuxHgdlzxDFCVx4Yu0l0lzYl5WSsq5q49u7j78QifcCr3Esr0gmRr5h+HwbKYHUpXq7BSSITgGGker6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 18:04:28 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:04:27 +0000
Message-ID: <e51793c4-e58b-8b4c-e936-2938718ee6ce@nvidia.com>
Date:   Wed, 11 Oct 2023 11:04:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 0/4] hte: Improve GPIO handling and other cleanups
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mdiuth0=XPBsoStXN81ydfpUfqm1BMc2TZOT4Kmx6jNkA@mail.gmail.com>
 <ZSZzsfaunP5yRvZ4@smile.fi.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <ZSZzsfaunP5yRvZ4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c212f7-e70c-490c-163a-08dbca848274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtL0bs7wg6tNl+3RgjiElWe26tJuAVHXmwN6N/0gza7Ve++fS/+R/hq66NnV4NSUP/NgJNv0pXASQi2vWwU2PIZgTJ5R6THamD6o2RDoPYddSUifmjUdnJ87ps13O/KC6dS594gFJtyqAF0rOPASz5r+Ij7N4EqU/GRSln8B9e4rJMzenahrzTzyvCmJVhm10HuG0bUu6WWWw82kh+5xa3nLoXfEuzgJvC6EVtwkV5oo1UAHI4kw0D2y8MoHBjmPuP/oi6dgRTKaMC4bYY9rS5Q20KZjCq0xLb6LUNB/JBwO4Ey7ZQ+fgY39lD3euvffNohSxdUb+kj9b9UQIvIeZe17OL5jXoh4OkQtagqY7acXsnZmC7pJ6UY0JGei9odvZwbo0TiVW+vKCE3/9myg9FnrK0hq3nS9aTFvPYAgOfMOQpWO8Qr5LUfgHBQohhAFqIIx/uDdZc+kSnysVDOOdxDwqy7FsVW1aeHDDEdx1G4U2b5kAwwoxoMuSsoShsewzRMMi/cZHMVFdGwwGOJVD9gBSUFiGrPicjId3+2Z/r04KR6S7bZqG238Oi7rvy0IjdsIcBjJUwJu/KpfFjdxm0M4jjY2GqQtSLmpgA+SnBrW/QJLBJN0tXoFzRr3c7u1qKZjlSOE+2G45YV4z96LWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(110136005)(54906003)(66556008)(66946007)(66476007)(2616005)(316002)(53546011)(6506007)(6666004)(38100700002)(6486002)(2906002)(8676002)(5660300002)(8936002)(4326008)(478600001)(31696002)(86362001)(107886003)(31686004)(41300700001)(6512007)(36756003)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXpJL1FvUkVwdWUxRGNUMmEraGFoUE1vRWU3KzUyN0FSSmlYWGVSbUJjMEcr?=
 =?utf-8?B?WVI3cFJ6c2Q3R1FYcllCSG0zdjhhMFhVTGZWYjZsd3BGWnE4NHByenhhcWxt?=
 =?utf-8?B?K0FmYzN2VzNOeDY2dkRpOXpIUTBVaSt0ZEFCV3cwbzRxRXJjNHhwR0QyUnZr?=
 =?utf-8?B?OXozMUU4MHBSR0Y0REZudnIyL2lSYXV3MmxZeGdSUm1Wb3VZbXlJQ05KVytt?=
 =?utf-8?B?VGlseGpXSExSczdUcStYMFFnZmhydGZrdzA2OWFVRFZOUEhLSnFUM2g1SFZS?=
 =?utf-8?B?UXdueU9GSElOa3JSMkVaaHNBdlQ5eWZnd3JFcm85ZEs1S1M3OEdBaUNZZEh3?=
 =?utf-8?B?VjJnS080dVpvMUVJQ0dJMkgxU1ljZWswNkk2b3NlVGVOYlJydlZ3dDFvK3dF?=
 =?utf-8?B?MTlMOGRiVWNxSi9xNnhsS3JUMk5SRlFCSE9kS3BFTytlSWc0U081Mkl4czI0?=
 =?utf-8?B?L05mK0FveHFOS2w1ak9JVHpUM3NMZ0tQUWc2S29mKzl0Nzl6YWpIQ1BZd1Nr?=
 =?utf-8?B?WCtXWExuSi8yUHdQdnV5d09lL2dteVE3d1BzNy9KcnVvNnBsMzBodTZxQjZO?=
 =?utf-8?B?aWw1bUJBdk9Jc21qUFpia2s5RHRJL0p1WTJMWlVySVM0M1JiY3BJbVppNWtl?=
 =?utf-8?B?NytVK2NWVHo0NE1sOGpoV3p1dFY1QVN2dEFIVGVVeUN3MW1heDBOMzd0TnFS?=
 =?utf-8?B?SDNndmk1dVVOYXRzaUQ4TkdNN2VjWXJacnVJODlEQ0VYdXJxNjVuMUM3YzZr?=
 =?utf-8?B?aXRrRWNDcTFsWUg4UDVjaWVMSCtNaUZVZCs0ekVSb1orWVN4d0lmY0l4bE5N?=
 =?utf-8?B?bVE1RVIrWm9Md2pLVWtaWlMzZ29odDVnb0J1emFDNjN2THFpelY5cmt2N2FI?=
 =?utf-8?B?RElONVFZc25XYmpGelY1bEovaC9WODh4WnBjZDhrbDFYaTFpS2t1VXNNUEZT?=
 =?utf-8?B?UzNPOFlKeFBYYndCQTNDbEQ4TDl5alIrdXRZWW04ODJCS0l0clNtZTlkQ1Rt?=
 =?utf-8?B?QXQ5T21mdHM3NXcvWU4xZ2c3bnpnekV1Q3BUcEEvOUFzQVdBbUtPOGQ4Z1pi?=
 =?utf-8?B?WG80NHJLQUhmejh4QVhWcytnVTdZRVc1MTFGTWV6MEw0b002czByMGNORDZ4?=
 =?utf-8?B?Q2hwSjBES2ZpR2Zvc1RkLzNWelBCNjduRWtNbFFyY0dYZ1c5cmxXVjRBT0xG?=
 =?utf-8?B?YkJDeEFIU0FWcGZ5TG4rM2lsRUw3ZnVxV0ZoU0U3N29BYnpBNWdadklpckdH?=
 =?utf-8?B?UE96RncrcTloQVVZSUV2YklnUkJVc0t4K0lBZ3AxU3J0RVh6RzV4eWJ5ekRS?=
 =?utf-8?B?bjJ6bmo2NEVGcjNKT2xmUmExTjZhT0o5aUFZSlJGak9NcUkvN01odmowOCtV?=
 =?utf-8?B?WHg3TGFGY3J3Y3d1a2FhQSt1cXhTS0NhVUJ1bTBwQStmaEhpRk1hSlljWGMr?=
 =?utf-8?B?OWk4TUJuNWZwR2hZVnF0TVBmVGtuNnQzamZXZEhMREoyZWtkcTVPUnVHS3Nk?=
 =?utf-8?B?dUFxQ1BxR2d4VUpzRGJZUmFlNjR1L2R6bG9LWTBmZk5meWFaNit0dklkSDZm?=
 =?utf-8?B?NXdLa2dzc3dteCtsK1JNRmNHU0Q3TW1mdXAvcUFZTlBkT1lmbVpMLzFtdkRT?=
 =?utf-8?B?ZjZTL3dLUUc1UzQ1S1BESCtwWVRRNERDai9kV0hQZ1FZRkpQVXhEYzA5bVU0?=
 =?utf-8?B?RXl1c1NxYSs1RnFpTHllVnk1S1BsYWZPeitleW8xdXZ2S0FKRldXeG5ORThN?=
 =?utf-8?B?emozWGcwdHVWM0tGVjBmNkRNelh4aVJmaE9BdmNobXFuV09pUlIybm10YkY4?=
 =?utf-8?B?Rys2M2RNTkx1Z1ByNDdHMWpYOEhhZ2F3VFZkMmFqaU5PbzZEdWt1SjM1OWVQ?=
 =?utf-8?B?MzZJcXVYakltRnMyRDNnbUZwa3dPejVJSDVKVDZyYURkdklPbVVyeURlNStM?=
 =?utf-8?B?cDAvSHhNU3ZGdHYwUjJqd01wQ3JFQmd4UHVJQVF5ODAzRUVqaWpBekJDdDlH?=
 =?utf-8?B?eGZrdFFqVkZ5YzIySUFQRmpDVmNHQkdMdlFGQmp6dFUwc01rUG5ubzQzYUpH?=
 =?utf-8?B?ekdQTWlFSlhmSHlFU2xid2FJeXBHOUxsc01NZlRkR00wSEUwZmxMdG1lYlpD?=
 =?utf-8?Q?mplEIbrduu/kD8wkj+fU6/vDc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c212f7-e70c-490c-163a-08dbca848274
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:04:27.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQKDJ/Qeov6v1XYERSEpygQ2QTi+Sv6bnNZ0aLANELECsgZWZjdjz0dyrZTcRastW8o3+Cu4nMJZcO3V5vquTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 3:06 AM, Andy Shevchenko wrote:
> On Wed, Oct 11, 2023 at 11:33:51AM +0200, Bartosz Golaszewski wrote:
>> On Tue, Oct 10, 2023 at 5:18 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> This is a series provides a new API to GPIO library (so far only
>>> available in the GPIO tree), and respective update to the Tegra
>>> HTE driver. On top a couple of other cleaups (patches 3 & 4, they
>>> can be applied separately).
>>>
>>> Patch 2 inherited tags from its respective discussion thread [1],
>>> but I believe the Tested-by needs to be confirmed again.
>>>
>>> Due to dependencies this either should be applied to the GPIO tree,
>>> or to the HTE when GPIO updates land the upstream (optionally with
>>> the first patch be applied even now to the GPIO tree independently).
>>>
>>> Another option is to have an immutable branch or tag, but I assume
>>> that was discussed and rejected (?) in [1].
>>
>> The series looks good to me. I'd like to take patches 1 and 2 through
>> the GPIO tree once v2 is out. This way we could potentially remove
>> gpiochip_find() for v6.7 already.
> 
> It would be nice to see it being removed sooner than later!
> I'm waiting for the test results by Dipen, I'll send the v2
> ASAP if tests pass.
> 
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
After correcting typo manually
Tested-by: Dipen Patel <dipenp@nvidia.com>
