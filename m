Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95E76A1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGaUJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:09:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C2C10E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b30Zc/8Exv3rgip0bgmqeimxXTqzXNQm5tEyuI/V5vdq5tvr7NtBaTZLj4vCkpBUe1we122svBDRupeAevD4upyqBecOUxShw6VSx3wUvNH4n41KSOehC+JGhV2kiZnY5bSLYsvdxZZz4ESwocFut34JI2OVZO1WRPzXioCQ3GZdkjHBjrNYjQwcQ8fiZziRKp+udifXCoD71rjWQyTsyxSS/dZGnIOSv6hgYnRxN6BkfJW34jz+5zgGW62G6cyj0bylsSem+B6W+PwWFHBYYfTy/4bKnJveqovtolCKvewWjG3zvlKPp+nVEVWvQYyrJos2KyhRc/w8YTj1y36iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGZccDEnEtAeyjy1SN5jm4ZfLDxFPiSk35Ma6GCkwqo=;
 b=SVeSTrM/IO6DknvkzVjx1ItJoijQEMZ8sWzQKqMMwZt8/3R2D48+s8lSXLeotvWqJzPDEfbb1k+dQ1Buse/K/E8hL3y1smK8N6qicDaXt/3rkDb8Cq8629EEh1iANQVVbPVVGnzJXmC35GqGXE5Ibv92pct8x+vc4+ZeE9QE90etnj1sElGH4nZK+uzfTapWiUfc/ftdWpN/qrCt0D9j9Gz8hDnGLgcg5CifkAGyTExeJzcv0BHqPRzEB2h4ZcnKmV0vSijik45JO6v5/4rDpaccqNAItSu8eUraE31N2n6vzG+7xgNRcwEEm0WiFPlkrGtOBi+3TU5n4A5F4rhh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGZccDEnEtAeyjy1SN5jm4ZfLDxFPiSk35Ma6GCkwqo=;
 b=PsIKT/pctnh7giwEmBvE2TEnfgdrqObdWLZq7FqocrBKP2JcY6MOUcfbRT8y8br3d8GlXH/l0CP4MVSkAUOPI3OLkIsI7u1OdjJrQ4MDCj1KQnJJiHdRsWXFKRTf0yAyr2wdvX+Fqo2KtMhHho54bxj78TH1FoGF0t0Zq/wO3eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 20:09:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 20:09:12 +0000
Message-ID: <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
Date:   Mon, 31 Jul 2023 15:09:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
To:     August Wikerfors <git@augustwikerfors.se>,
        Keith Busch <kbusch@kernel.org>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nilskruse97@gmail.com, David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 419d67a5-ec6c-46dd-2ade-08db9202016a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZPJgRvPY7/Tuc5pb8E2bBD5ZbClz+YWNcwRUSk6lqLvsqMsULPrsV77GK/N6Q6AwZ8HSzXlPrgm0W+BQdpPvdwDT06SlUqdUX2+H0BgDp426YGFUPI2xLfGxB6drmQHVEvaz16qgKWKRX0vm/HmXakkS04Tp8ssFpGIyqI90fJd2wXklofQWYHuPx1LHRnmNV6Os01PBAcJZok1DxR6hQdESuCg4gG1q0kfNhptUZHxwYoVAD3ic8o0zsW2u7kpVXXSewRpSIi/eyTzkeE8BJgFNSefuRC/IUUY0f+DHU2h427owKpbu9EtcW762A/BTOLWk4ctjipnnuTctBANdxTAW4vjH74Zwe30fgi86wPmi2MwKRxOSO7vIyHbXZ2EYUI1LmO+eflHb3zfbepbNSynNXweof3lJqyeXjZ4D+Rv03lNKq8CinhvS3n9UDkwuTYNUiyeqbXv49Pegxkgh0C5q7WLdWfoEr1GYmFSccJnTZu2Uj5PMEDNx+SR0FbY6QzilB8NddM37aSJUwheMRyMz2feSAi0OS836rrXebexDlrXnX2S+smJDpTtRZPG0Q6BpIxAgnLFtoGt8a+1RKmVT9PMaqytVknnexm161a/lYbhQteXh4G2PmT/Q6b4YWgzUoG5GTNo7Ne8vinNBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(6512007)(6486002)(36756003)(2616005)(53546011)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(41300700001)(110136005)(38100700002)(31696002)(86362001)(66476007)(316002)(5660300002)(4326008)(8676002)(8936002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdvUnkwOVlKeGI5Rk4vMGJDUEgwcUFvaHZhdGJxLzA3T2s2c2NqVmxVRUJi?=
 =?utf-8?B?bDA2OXNGbTJRTEZxUFBTWUtvQXpOSDBhNHBDTDR5VzhaMlVnWGVUR0E2L00w?=
 =?utf-8?B?UHEwWXY2RExQWllPUjh3OS9Ud0h2MlFJQldJVzdlMCtxRmJ0VHQ2ZTVxSnFE?=
 =?utf-8?B?VHB3TEw4SmpNZ1hCczk4OXJsOXJ2enRUTVJ6ZzJEeHpDMUxVUUJoRjJsM0Ns?=
 =?utf-8?B?NytEZGxSZGdpOU5uTnp2cUdVbXhNTEFOSE42ek9naFlvQWZRdWlpVmhQNXdr?=
 =?utf-8?B?MktqRHBrNHZnL2xkL2hQemtBUWp0cXl5d3BDK2l4dDcwaHMwMU5IMFlUTnpM?=
 =?utf-8?B?emxWV3ZqVGl3bEJ1dTRLNjhnL3A5Y3I5SlBRWnNVVURDd05MTVl6Q3dDTWV1?=
 =?utf-8?B?Y0Z5eTBvdzFORE4rL0FzWGVEd3VGYk1XWWtCQ0V6eFo0UEdTd25GRW91RVFl?=
 =?utf-8?B?R004QWs5dUtYNkZpWUJ2aGhnUjR1NTE3blNMNXdZUGZOYXV4RDIwQ0dxOU1E?=
 =?utf-8?B?TmM1aCt2dUQzMVgwVHZCRmUwa25RRkdybnZWM01xY3lieFdxMmRVWXhrbk1X?=
 =?utf-8?B?MkRXMHFzY2UweWFxUDBvdklDbEhMQXBza2l3UkN1ZytMNmZmNVNjUVV0a0Vn?=
 =?utf-8?B?Y2g4clcvcFMwekZJTENBMjNHZEFuRjJ1Uzd2QkxMcU1naGc3MVFLY0s2akk5?=
 =?utf-8?B?THliQm5WSDRUWkdBYjd2TU1IZ084QXNhT1EvcFM3WmRTTmFSaUk1eXFlc243?=
 =?utf-8?B?Ny9iNFJTMG1RcC9tc2huaERScGxZbDNINHU3RlBad0lvRU9Lb3U4RkhjZDNU?=
 =?utf-8?B?Rk5odTQyWGt6d2FaVFN0OEN5MWtLWWZtOXB2WDVrVXJJSE5rSU53QnNqTVla?=
 =?utf-8?B?Um9VRWloeFk0WkIyUDgwNGo5R0FreUREMWtyNzJITXlDT2gxSDNmWnFoM1do?=
 =?utf-8?B?eXlQOEFxajBqSTYxdE9yZTZ1amhDUDkxeUgrNmhTRHZzdkZIYlNUckdEckxa?=
 =?utf-8?B?QzUrak5wKzVhY1JhTHYwL2RScVFzemVERFdNM2ZVTmxmUnRTVmp0bm9Dd1Nx?=
 =?utf-8?B?b1k3ZXJSQjhKVVNFNEhnMTJveFh6aUlLeFZEeStoVGkyQjU5Rk9Xd0xJdjRL?=
 =?utf-8?B?ZnJDSTdoOXpuOUZUMlppUkJObTFCWGdHRUs1TlVwTkpqd2trbUx6K3BITGlO?=
 =?utf-8?B?S1AvalpjOFh5emNCSnVqN3ZXQ0k4Vk5NbE82QWsvTzlxSjNVVU5FQkt3OVpK?=
 =?utf-8?B?bjY1Zks3WVk0Wk5ZeHF0VjdmWnYwRzRmZjU4NVFYZ0xKYmxiRzU5RUJud0hw?=
 =?utf-8?B?blF5WE1sQk43Z01aT25sdE8zOExpQjQ4dUhSNENzWUFoOXBiaVJYc3JVZnpp?=
 =?utf-8?B?U1JIRUdiMVJFYStDeVd1SkJKVEVZdnA4M3ArNzZzQVFucGNKKy9oUnQ3ZWxO?=
 =?utf-8?B?NE5iemx6eGhTTnhlcWsvOU1GK2tKTHdlRHkvZ0pMeW8vdFR1WTZHcTBNYjcw?=
 =?utf-8?B?UzZ0YUhhcmx0REYwNmtwa0xiTitHTzQ1WHRSYnF4cDRlSnlPMXJ6NnV3cjlH?=
 =?utf-8?B?QTdXN1c0ZFh6OFlPWW1obFpJODVnVWllNTA1MTdSRmQyc3ErVWxmYTc2LzhJ?=
 =?utf-8?B?R3NaWmJDc2JpbEg0ckx6L3JiTFB3a1hVQVRrdXZPdGI0aDJxM2VCalpuR2tr?=
 =?utf-8?B?MTZBVnFzVjZxMno5ckVqaXdlZDUzekpxLzBZaldyamx6djBwSHpPMEthYzcz?=
 =?utf-8?B?QW5Da3A4Snl4bkp3NmFQanN3UmxrTmNzZUtteDcwWmxoUUV0WFBVNmZTWlBL?=
 =?utf-8?B?dVozWTZid3JFZkRCZHhBaUo3SDVySFMyWVlNYTVJek9QVEE3QmVnaDdoS1pY?=
 =?utf-8?B?TE5NN053Y1lMZXh1RXhQdDdlbDI2bVhKYW5XZXVYMHFlUHZtUHlaUEszT3dD?=
 =?utf-8?B?Zi9UWjFVbUZINjBWSE5JM1lSdmZTTStFdGV2Ym54ZURNblVUZjVaWGlJWjFM?=
 =?utf-8?B?dGgwUjZhMyttUHVKRUpZb3BOdnBhZjdUZDVDcGp3cmhzMkg5dEp2YkpoWFpn?=
 =?utf-8?B?WjBEaWF0ajFBWS8wblZIdGVXUWVxa09GRGJqT2k1R3dJb1pkWVFpK1k1SGM4?=
 =?utf-8?Q?ldQ7ow/LkLo44MpCdNCTYHw9c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419d67a5-ec6c-46dd-2ade-08db9202016a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:09:12.0028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITuV8ttjlslVZPjSU6suLIRhFfERvC18zJFllNImjEfZhMOBiCJBnxvRYNcwJ6cHPEURbgTD8F7rwQdTJ/bl5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 2:54 PM, August Wikerfors wrote:
> On 2023-07-31 21:10, Keith Busch wrote:
>> On Mon, Jul 31, 2023 at 01:51:03PM -0500, Mario Limonciello wrote:
>>> Samsung PM9B1 has problems after resume because NSID has changed.
>>> This has been reported in the past on OEM varities of PM9B1 parts
>>> and fixed by firmware updates on 'some' of those parts.
>>>
>>> However this same issue also happens on 'retail' PM9B1 parts which
>>> Samsung has not released firmware updates for.
>>>
>>> As the check has been relaxed at startup for multiple disks with
>>> duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
>>> probe due to duplicate IDs for single-ported PCIe devices") also
>>> relax the check that runs on resume for NSIDs and mark them bogus
>>> if this occurs on resume.
>>
>> How could the driver tell the difference between the device needing a
>> quirk compared to a rapid delete-create-attach namespace sequence?
>> Proceeding with the namespace now may get dirty writes intended for the
>> previous namespace, corrupting the new one.
>>
>> The commit you mentioned tries to constrain allowing duplication where
>> we can reasonably assume the quirk is needed. If we need to do similiar
>> for this condition, one possible constraint might be that the device
>> doesn't report OACS bit 3 (Namespace Management).
> 
> It looks like that would work for the PM9B1:
>> $ sudo nvme id-ctrl -H /dev/nvme0
>> [...] > oacs      : 0x17
>>   [10:10] : 0   Lockdown Command and Feature Not Supported
>>   [9:9] : 0     Get LBA Status Capability Not Supported
>>   [8:8] : 0     Doorbell Buffer Config Not Supported
>>   [7:7] : 0     Virtualization Management Not Supported
>>   [6:6] : 0     NVMe-MI Send and Receive Not Supported
>>   [5:5] : 0     Directives Not Supported
>>   [4:4] : 0x1   Device Self-test Supported
>>   [3:3] : 0     NS Management and Attachment Not Supported
>>   [2:2] : 0x1   FW Commit and Download Supported
>>   [1:1] : 0x1   Format NVM Supported
>>   [0:0] : 0x1   Security Send and Receive Supported
> 
> Regards,
> August Wikerfors

So is it reasonable to just add a check for

ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP

In the same error handling path as this patch?
