Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBE7D7165
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJYQBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJYQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:01:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D88136;
        Wed, 25 Oct 2023 09:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myQMNlCmJZsf55SnHMWkuvFWU59j+tnbKdfjjg8R1gZbG11vOyjpLZgZj4UGdyTKGIZNxZEQRV9dETGa+qFxkqOHrnMnfqy7wHyVtD9wdWcT4DYTLyTiJBGy8W1e2d3jS6cxyet16umw02gFucGyKfpugknLcN+0+qYZm0smJC2tQXs7ZBaL1nJJq4rr1BJK2CRHfsfk2b5t7KLUwwKWwHWRQ98ARUbWbg8Q20TWE6+umxHqEPgYq9Xff6KzySe9MTsqW66oibyZBPyymm7mOSwjeYw0TF87tEq6qyb7wrBb4MdusXrF1ovcatRW6XhPIaUPgZHA7AtqE2ZL0icolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLnW964FuWBfeeXovqMYPYNZvlfbKmGkHp81NxqgNTA=;
 b=Jwu7JcK8SkCnbeJCDeOStuUETamQMcT4+dMkWXwHVKo0t6qqtMN52cA+OSIHd1+MfybTRULDT38ZDveHzVZP2Q6Z4s3ucw0UkHmt9w/VEv2MBrOLr4OJOZnMzZ4QaLnrM67x4jIPrFe/5tD9jE8YMzxJGTfvrXA3QLHYvoFGu/FZy3dLWouLx3uv9vGiPeJPLwt/OdPT5cYejgTOjDsPXECrGWeuyKpFkphPOj2EoTpExiAORnN5zX5yh719xXGN+sY7jttViEHCo7LDQ+e0cgJWYrIT6T2v6LxlwLiNoJM54ZjzIfR8Ogo2otaBHRXaMiHT36tywu2KJ3fhDmFSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLnW964FuWBfeeXovqMYPYNZvlfbKmGkHp81NxqgNTA=;
 b=p1n/GnLwJUwEUVhb8InrAEtEItwypB4xlRdJRUeLyT6epSjCC3L3OKPZt2BKF4A2pvZj39at/1hKVZNJWyAshEhp3Vw+gmrAHKAI8jxy2rlde7nju+oH4xtCHZIkqjCV04CrDybGLlP/VmAYcvxAH0XMXjhyTG6ODzT+Dr3E8uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 16:01:26 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%7]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 16:01:25 +0000
Message-ID: <74a372a8-6908-4f9f-a79d-febeb6136379@amd.com>
Date:   Wed, 25 Oct 2023 11:01:22 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
To:     "Luck, Tony" <tony.luck@intel.com>, "Moger, Babu" <bmoger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231024181600.8270-1-tony.luck@intel.com>
 <2504daf3-16fa-9474-e9c5-cd6aa99d4776@amd.com>
 <SJ1PR11MB60838985036B7A3F2296448FFCDFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB60838985036B7A3F2296448FFCDFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:806:f3::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c03b596-1264-4d3d-6937-08dbd573a400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iQLPpYax2PQQl6Uf90OrfmcScYsQWeN+wTrsVj3cxPMlI7afCdGkUsYewAC0YJE05bQlXhFaFrqZUW/D2rEVyWNKDXJIo20g1cJo94FS8N1Wc81PGe/vyxrN/FDf1T9gBVPQZpd0CmlR+rbKN6jjFdG8KOhQyEPbYOglX+vSL5I3AKW/fImpkX1HhPkvTlT/Que/Yk+T3qwgvpxXjQGAkE3axwjf3sXhDk0O+UtjyKnBBIbzKnQD2BlVxKxkXaaNPLxNr8uwzTsfY1T/JEdqF3tTKuHxsxjp+uqV8zYSPwT5r3sXgOvzXuGv6ijkfP4TaniOy2X3VlpY4WZs0GiC2iL2UqbfD6LmU6VqO1G//x29X+X2wrcw/Lxgt5fDMeMo7L/qYME8kC4EIf1RWdr7eaDpnSlohXYao6nzjzeRqF8gZSVZrgz0Xw7t4NIGOF2KOJXIc3nwom+CVAKwTycipTtxoO8zZc+rq3GhaKkBpdHdJT4yM18UQHxHjhKzy6o10LAQpKF9B7IQTzxWkgJsKMve45Eu8ndgKA/uz9iQPj2xIPmLZrI2yzRDTKThbk8IDqlIudZymT6DV4mv4xZ42JfieAFUhMiIsKTNq1fz0A635s4Jif2z2YGet23et90uKMBjTI3O6uehC+9z5bv8O3cxt2u79NSnzxQcDtD5rQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(110136005)(6506007)(6666004)(53546011)(8676002)(7416002)(4326008)(41300700001)(478600001)(8936002)(2906002)(5660300002)(3450700001)(6486002)(54906003)(66556008)(6512007)(66476007)(316002)(66946007)(86362001)(31696002)(2616005)(38100700002)(921008)(26005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJBcTIrWDBBdkZiUml3NUhLTTFqSmVFOUNQb3pUVTArU1liVnZhd1p3b0s4?=
 =?utf-8?B?S2FPM3ppVTAvM2FDNnlJeHJQbWJ1UlFYSWoxTlVlQUNpSEw4bEtkeUF3aHFq?=
 =?utf-8?B?eXlBa3FhK09wQStVdjRRUUlDMngrZE53R2xFQmJieFZDYUpVQUpmMGJKSFVM?=
 =?utf-8?B?OXhwNkRjclN1V1p6ckFDQmpGYXMrNUZHTjZxaWpMU3FDR2VFN2dOS0tyUDFw?=
 =?utf-8?B?Z29IdWZVSUpjM09DN1FLdHRIcS8vTlg2dnNxRU9mMGF0T2VnWFB3cGZHQnpZ?=
 =?utf-8?B?NU5xTGRteDJYU0hiQVd4QldhaWhQL2g5czdrVUFERCtOdm40dTJVZ2lzL2x6?=
 =?utf-8?B?RjBOTFRjMWVPV21RZlliOExyalgxbFJqNWF4ekVmanFYWC9xMFZibFJ0MCtE?=
 =?utf-8?B?ckxGckhJRGU4QmFvaVpGaXp0dERNbTlGS0UrejFYbXdGNituNmF6NXgwZktj?=
 =?utf-8?B?dHhTRHh1c1Z1Si9mZ2tTaXQwK0E3cWVjbXhpOWx2TUFCN3hwNGZKdXltdDBi?=
 =?utf-8?B?UGp1YnJLb2k1OGNQYlZnTm1TZFR5a1pvUjJrdzMyWlc5MU5LUlVBaG5hSjFm?=
 =?utf-8?B?bFhzRXVZVm93d0pRL1Y4ejZXUFcrYktHZTEvSlRDT1lGVVBDSmZveFkvRU1B?=
 =?utf-8?B?eW1zcHR5R1dIR01oMkZqc1UwcVJZMVBvRCs5cWtSbEFhekd1eTE0ZmZXdHZZ?=
 =?utf-8?B?QjEwRFF4TUU1MXZuVmtqajUyZmkxcHp0R2xmeFVSMVlVWWs1MGdOWTh5NVkx?=
 =?utf-8?B?ZFJMR09vMllTcmkwZHdQRFVDRUVmSHlKQWx6S2p6V0tqWmRBelZ4c1Q4SWJv?=
 =?utf-8?B?TXUwckhmc0F3Rzl6TUd2RGROcnFJZHFNZHJTaUtxZWxGZnBncUJ1cUE0TnBC?=
 =?utf-8?B?VGljbFFFZFZxdFZJYUFCT3VqdWVpRFYyQWVEMWN6Smd5RjFZMlc5RlhjUHd0?=
 =?utf-8?B?Sm5oSkYvWE1VaDA5VlBmSGhjYnRXY0twWXJOYXRXV29NeUNlZ3ovRkZmS1FO?=
 =?utf-8?B?dzJWV1NtSWt6SkpaNTcwNHZraHUwdGs3TDZ6WUZrV2xCeVc2cXhKT3VsV0g4?=
 =?utf-8?B?YlQ3alVvT0c2TjFpQzBzTWxGdDZsNjlML2pLdFp5a2dEK3NRVFRmQkl1UVJE?=
 =?utf-8?B?ZHNoY0JnbFhJQWI1Nm9CUEdwQU9DWk5mNGF2VmZFYlZvSjB2ajNhWDZCWTJw?=
 =?utf-8?B?M3hEMlB1MzYrZ1lhNXpBcGNRYUdkMTRQcDlnVmg4aWgySVp2TnhZM1ExTFdQ?=
 =?utf-8?B?ZUxDdStzQkpGQTNNS0tiYjZrSGFwRExxWUZGNG5nTHR1Q2N2QWx5c2JjMWh0?=
 =?utf-8?B?dk9mbGFFVHUreHlyZmlRZVZNUkZaenVIZFFSbGtZbU1hMGJtRHN0ZUVlTTVO?=
 =?utf-8?B?T1hvQ3NaM1Rkc2pnS0Jma2Npc2p6NXM2ZGI1c0hXVXA3YnkwVE9VTmZNUWxn?=
 =?utf-8?B?cEk0MXlXWjRPRndHRzBBRzVpaitYZ0hCOEdDWEZlU0IreVRHN2JYR0psWlUx?=
 =?utf-8?B?akNTZGhaRXdDdEs5Nk1LVVBhbm9OOXlzRlU1bFp5VGthVDBnajhibXNQUjI4?=
 =?utf-8?B?K0xJalNTaVpXVmVZc1lGenRzL29xcFBMUW1XbG11aXVoNlFJN29LZmFZeit6?=
 =?utf-8?B?VVNUNDZJMnd5N2E1L2xKU2RwcUxVMHZONVdQUEZpczVvQ29pZHdEdWVIeDZM?=
 =?utf-8?B?U1NXRVYzTWhpQTJRRVVTa1N1YUMxQkVhTERZMEpPd05CeHZBdFJ0bjgxUnp3?=
 =?utf-8?B?MWJXWWhCM1ZaN2xzUXBvSEVzZU9PTUFLZlRkREM2bHNRK0NwUWowckxKOWla?=
 =?utf-8?B?N1BhcVd4K0VLV09ndXJXdysvaWFseldRNTZvdkQ4VVV0eElrYzFCNzhrQXRK?=
 =?utf-8?B?eEZBZ01kQm5ITlRHU1hRZDFpNVFoSVRnRGxieHJubDFNZGRlNkFvdEE2UlRO?=
 =?utf-8?B?N0FtNFRycWZjck9xd1cyWnZaQ29ncWJkR2tCWTJnNUdDejZZK21nV1d6Rmd5?=
 =?utf-8?B?ZFBEOGRlZDhkbnAxOE5JV001enkyMWVHTjJXNmdwRHVzcGVIMWF4Y0NoejNq?=
 =?utf-8?B?bjRXenZlUGJyclRxekhxQTN2TVN0MzF3NEtkMkNwMS9TN2ZHR05iTTZGZFJO?=
 =?utf-8?Q?i+t0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c03b596-1264-4d3d-6937-08dbd573a400
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:01:25.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kdkCeFpyI/fVAwCayNOa+cYXVqlUhn2NgIY1mJ4SgHUJNMQLqtYldtJC2czIqun
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/24/23 18:43, Luck, Tony wrote:
>> Is this customer requirement ?
> 
> Any customer using the mba_MBps feedback mount option will need this
> on platforms that don't support local bandwidth measurement.
> 
>> What do you mean by " If local bandwidth measurement is not available" ?
>> Is the hardware supports only total bandwidth and not local?
> 
> There's going to be an Intel CPU that will only provide "total" bandwidth.

ok.

Why dont you use get_mbm_state which is already available instead of
writing another function(get_mbm_data).

You can pass evtid, rmid, domain information. Decide the evtid based on
what is available. I think that will make code simpler.

> 
> The CPUID enumeration in (CPUID.(EAX=0FH, ECX=1H) ).EDX{2}
> will be "0" indicating that the local mbm monitor event is not supported.
> 
>> It can get real ugly if we try to handle one special case.
> 
> Hard to predict the future (I didn't see this coming, or I'd have had Vikas
> implement the fallback in the original mba_MBps code). But I don't believe
> this will be a one-off special case.
> 
> I'm also wondering why this feedback loop picked "local" rather than "total".
> I dug into the e-mail archives, and I don't see any discussion. There's just
> an RFC series, and then the v2 series was applied with a few small suggestions
> from Thomas to make things cleaner..

May be MSR write which feedback loop does only has local effect. This will
be interesting to know.
-- 
Thanks
Babu Moger
