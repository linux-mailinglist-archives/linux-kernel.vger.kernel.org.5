Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB87DFE98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjKCEs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCEs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:48:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731AE1A8;
        Thu,  2 Nov 2023 21:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY3HeFT5wljIrZ83PTfKolcg1ttW8SDPtTWwv5SL6oBp2goukl1KaaGUqXBanWwvf87tLL7EWiop8/3NFNz7riEpv8E/qRGTdPvy3sBU+VuC6Ay/LaRrtJFpvZln5ykVqoZr7ahWMIf5/wcwKrgugWjhtY1lCQIv0CDc5IdjvZqqzfenIsyXK2mZljR+vRQh0pN1mlJ4njFTTNnnPC+IxCypcLMsU+ZlG3J9zWQGRgg4J2i/zamUKCVet/eYUjCn7Q/GU1f1w+zM2WIjmsVK7AFimJCnGHoE12Xd1ECf8FtqJALVlmb8Jag0B3MsqFi+aPPOA5lIc59Mgd49uhc6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqrAK7PkF91ClNtxX2Gg9URxZYOOLCKCwjZld22Ov/I=;
 b=dkAN8IZAAFgln5L4+yI8eRGgyq3UaWlUoy3reCp35OsQdbBQytLxr/Jh98u+vlR+fv+AJuBelPdzqggx5/+2MwQV7vkrjJyhq+6YoaVuvgKyEwqGqAJQzAjAF5NC21cbI9fUyH92qA4r4xGP831NnBUU040db/VxKORm1r5h0NjV5QcTjF8k+0+JQxMdXCIdDPXDCAVnDujQsdcScazOhJ1hHyboRVBwDCzZ6AF9iEsIiUFEchWABKvV2qopdCbMH+Zx9MXY3BclYJWACUXWdXS3oBC1nuTexewY4FUUQjspDP8Rjvjcn62uvOJ6DpjZZGk652yE3/PhsP6of9NLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqrAK7PkF91ClNtxX2Gg9URxZYOOLCKCwjZld22Ov/I=;
 b=1O9ZtPzvm6T4UW9MzApvcYkkCUN75DJ1SKlkYCjlf5N/6od7B40v3BqsuzChsIswgOKXq0leoFVVvNEynmU4B08SVpe/wqGaos6QHh0XQKNYCVRikHLsyDiyja3VanvfMq7uWa6RgjxucrC0KqwcJR40FzhY9t/+y79nT4bDJis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 04:48:47 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::969:dd13:fb4c:fc56]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::969:dd13:fb4c:fc56%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 04:48:46 +0000
Date:   Fri, 3 Nov 2023 10:18:34 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Peng Liu' <pngliu@hotmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liupeng17@lenovo.com, lenb@kernel.org
Subject: Re: [PATCH] tools/power turbostat: Fix Bzy_MHz calculation equation
Message-ID: <ZUR7oh8oWyn7/mz2@BLR-5CG13462PL.amd.com>
References: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <002801da0da1$adb83fc0$0928bf40$@telus.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002801da0da1$adb83fc0$0928bf40$@telus.net>
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f00c2d0-ddf3-49ea-8781-08dbdc282999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZWsx4tdIJjRn/Gly/mBAt+z7fCw5G5MS9WRIt8/dxgkEtZ83gmmg4U5dsIrxEEjrv1rg7biLcD8ZnOKhc1RhWFg/7AktQgmJJreZGGnEuHTYENh5aPHrygQIHjMxQaEO2jcrjygSubLrKEC5igL8muWbhyxeKj49v4iI7ueTw2WXJaCJO1OEAqj+p21iYAc+MCa/deRmcyInHuyuh8eCTmNnWEAdo6nyNXeN5HNd0Rz2c0K50qZc6pz98L7L7rZv1kufl6oyGwZ8nsCjnPmfGszHyXhMyLyPKUiN47ih+EGKgebhabohY30AGc8QPYEHRwKXxhP4k8DurpgdhIeHB3vBmzuQqbRjccxHTjPHGwG+usUgalNMmhcfRg9TaukN7xSlnE3MMavvtnv0awIVhhlRjNWAXTqc0IzJlWNGhK4p+vOk3sbo0LYVvVJ94Hk5nMI7y3p0F5BDarABjWK9WPM4j3JWtUsnhw2+WSi59r3Qmw2pZxIenVG2oAv3QDeTWJrqpY+PHtILROyWiY7CZw7xuVNdvOmFkIYjFhOuRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(41300700001)(83380400001)(86362001)(2906002)(38100700002)(966005)(6486002)(6506007)(6666004)(26005)(478600001)(44832011)(6512007)(53546011)(8676002)(4326008)(8936002)(5660300002)(66556008)(66946007)(316002)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w77XORuvM5dmY4dA6G0SkTchdMtBS6wNaDroyJ1+QfjjGbd09o+lEjTDIhlw?=
 =?us-ascii?Q?XAu4axmwWp6EwPD60UY1Pw2a5YXopj4K9g65jXVezl1osrJ9pJKpDXBSKfBr?=
 =?us-ascii?Q?OvUERLEbNEWN1ewVpcaYbtLJyVmmQpgME9z7KGtohOvkiWouTb39setdAvok?=
 =?us-ascii?Q?TaeYRJvCDmknAutROo6XK1tn9ApDqV3xjMOcMIONCC0rSIwYSMiLm408jDPH?=
 =?us-ascii?Q?izVPeB1sipVKDX+suNQRdJmDEcVRxAShFfaxC3TqOiigHpvemVmLV2fwS3JV?=
 =?us-ascii?Q?w8a+JRuRQnwVSadQHmtwjBmNGDZKXBMagxeLDWOCAQfTERykwPrnoMvsSCtw?=
 =?us-ascii?Q?EPIGFpxkx5UBbpvjzqwQtaJGZsigI1Re6Kwqg8Nmw+523viTTUF4CmEL2Qww?=
 =?us-ascii?Q?pRCXwoOGoJwfVoKBO42kt+Y3qcTE3VmiCwBJiF8bNVTKhSZ6Sjc/6By7NiMa?=
 =?us-ascii?Q?fzLPUBpa1HTUMGEBfpxQl4HR36GgcF0zCzAFCt84OrhlVFBgx984oKqdwaMI?=
 =?us-ascii?Q?H2QrdaCDcHlVwmtyj9NzCmW8pW9TDEK6Kbx7FwslFNugqKEBtDe6nQBJOjKX?=
 =?us-ascii?Q?pSf+YjhjofLHpKkSohUzTvfG3o/n8dOXbMexVyM6oAUI2iZtzc7SNTcGEFtt?=
 =?us-ascii?Q?vdFR3WihqM7OyBGpOb+eOtNMzzkKxjbbGz+9/r/VGY/cGe1q2Xbs3+tKUgf+?=
 =?us-ascii?Q?SgooKU7fohCPQ5seAgmu68bedo6aZSvtPALCMtAM3OZzFgM5F1QdLRltljEV?=
 =?us-ascii?Q?sQss5uxOcgcPG/VZlWukMthah6KN3BJtDXaoQmZDKYkK4Q8F+eptmtfC2JXA?=
 =?us-ascii?Q?D06fAzPPO3jHyJyethXz4HZXGILjAJGXaiIedfS43v6VDwMm2Av/zyx2UdA2?=
 =?us-ascii?Q?SMFlfCcc51zjugq+Faa4q6emrUdXtcA35fmtKE10U9lYUAOdJvxXvfGrl3kv?=
 =?us-ascii?Q?DHwWrd/0v/yn+aNt2Cm+c1hGzPMe5PTgw/3JSl8yXe46gLKylY8qabuCZEMs?=
 =?us-ascii?Q?zHRYhCZqYBrtrp9MC3aqpvrqOmg8TNUua2Mev3An+vLY1mK+5jORj1PTHyv3?=
 =?us-ascii?Q?sCHKADp5AAgjeDB5FQ7EEDzIkM2FbT+LzWR/dg+KsZ7FavW6mHa38t63zMsa?=
 =?us-ascii?Q?5e+D8BcXIU9LaSgPbO1PVYVDKapj8tNVD5a9QOiMKSQRDc34UZpYU2lsbXmQ?=
 =?us-ascii?Q?Ht/76Z1coc3T1IBfvfQtKgLT+yZ4yxQpQlRoLiNoWTYsFLpWwyyuT7sIyBNY?=
 =?us-ascii?Q?YIGKrwBtBs6RcBr1Nw95RrpI5YBrQ+57FAksdsXTD0Q8hS/MW0olc7gHnxtq?=
 =?us-ascii?Q?Fjg3ZiWirBmGrDnXryYWdufLu7CN9xGTT6fBsTawZI/zqJ+JR7HmsDqFZbbf?=
 =?us-ascii?Q?RXWQXXAXDhV/kWeFZiBwoI0hgIwVFKPY1VOAaJ2XbFyKUFapcLMaAftUYurk?=
 =?us-ascii?Q?UFU8fg/crmOvQZSJGr4p9gtkY8LZkEEgufEVjhoQWvP1OokqK7wXbjLj2SgY?=
 =?us-ascii?Q?zopFLyZ35nA3wDkKaTCfJcTfJqz7c8rh1CiYjUAGGDFqOfQ21xXhgCGmuJqY?=
 =?us-ascii?Q?fe7dY5y6wxwtIBKytHP7megL3PZWYfk5WLYbNnFe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00c2d0-ddf3-49ea-8781-08dbdc282999
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 04:48:46.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKldDXhT3gYLcr63utoEs4XvMa52gJwU1zyTDQmDPDqrDgfzfp9ItL6Wmnw4ypAyiLGDjn9589NO3l7kJhT/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Nov 08:31, Doug Smythies wrote:
> Hi Peng and Wyes,
> 
> Just for your information about your recent "ping"s about your turbostat patches:
> 
> Please be aware that there is rarely any reply. There tends to be about 2 turbostat updates released per year. Your patches are in patchworks [1], as are some others, including an old one of mine from 2023.04.03
> Eventually there will be an update, and hopefully it will include all our patches.

Thanks Doug for the information.

Regards,
Wyes
> 
> [1] https://patchwork.kernel.org/project/linux-pm/list/?series=&submitter=&state=&q=&archive=&delegate=107
> 
> ... Doug
> 
> On 2023.10.29 08:12 Peng Liu wrote:
> 
> > Ping
> >
> > On 2023/10/7 13:46, Peng Liu wrote:
> >> From: Peng Liu <liupeng17@lenovo.com>
> >>
> >> To calculate Bzy_MHz, TSC_delta should multiply APERF_delta instead
> >> of dividing it.
> >>
> >> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> >> ---
> >>   tools/power/x86/turbostat/turbostat.8 | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
> >> index 8f08c3fd498d..1ba6340d3b3d 100644
> >> --- a/tools/power/x86/turbostat/turbostat.8
> >> +++ b/tools/power/x86/turbostat/turbostat.8
> >> @@ -370,7 +370,7 @@ below the processor's base frequency.
> >>   
> >>   Busy% = MPERF_delta/TSC_delta
> >>   
> >> -Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
> >> +Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
> >>   
> >>   Note that these calculations depend on TSC_delta, so they
> >>   are not reliable during intervals when TSC_MHz is not running at the base frequency.
> 
