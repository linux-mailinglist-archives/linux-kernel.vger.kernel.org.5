Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BFA811ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjLMT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:26:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB89C;
        Wed, 13 Dec 2023 11:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFyCgnyHH+c30cfBzDe+RIeWEdJNZ+ii5sVevn1iCnIzii//HgqpWDQTnf73KocxYj5lO5dxMvvZb3P3adJIhXtcW7k9qx+qH2QjydGLORGlI9b2b0qfsc/cy3RguwfEP6Gf2mrKss3NZ6xzmgcZTSj51jH95jnU0c/hzkPw59oNJfd4B2AYnFGDbuwGBytdm1HMAwE5hW6jWUa6JdLcfUpgZAqzPWoQBFJuzXIcxKzYXy03XPpBsf/bDKf20/DfFYsVl4duLOGJIfneGZt2voOd/8LojNoc4RZXut2FmJlQ4PMS3faSRGtVMNz4JxDETqHyhHjyEOZjnHmrUW5jRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EocYc08+4ppEJyZK3lHiaYVq1oZkq+6BNlP4QbPY1rw=;
 b=ALVJS6sqFCQCEO0h+asqWGY3U+9IUt8ABMX+R4cEX7ASlPRFluVUZIPYKCgBGAfnoBIUwqNU3I8EUmYB9poupQmAkMYrNZ9NU8MJYE6rrF+dNSgIpRquKyncc9Rw7kE59WXYPq9Nr+CXvSAVPTNXmkhzdT2qboZg2ac09oTq4uC1PNF1y6yupxvySm//Bo/XX6gjZq6xbTnOhNL3f95wNg7APYZdjiINLPS5accFAYQ27j9uteFyid81VdebC4BNC3CwyPam+yeqsp9NHh7/cA5Ux+LdJvn1V0oUNQWjy0US4IqECwoMOZAi4hZmQOpdv/ldtDcf1ZZGg3dDY7PoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EocYc08+4ppEJyZK3lHiaYVq1oZkq+6BNlP4QbPY1rw=;
 b=B9JNB1eK8q+UeeKbElWrX6Cf/ypS9var1UOw8oKwoMtpiFw0YSMGnv6wXdPNVl7yDy/uTZ1cUDFDCj6cr5G+A6IOSUQHpGvHufI3ar4+gqO7XO5dlhVjwfK6QzhFS/Ao34BakGWugRzBf7rq+J98IYlmZEJgUezs/18gaqI+s4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 19:26:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:26:26 +0000
Message-ID: <657c0ca3-244f-47ff-940a-105c0651eeac@amd.com>
Date:   Wed, 13 Dec 2023 13:26:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
 <874jgmnud8.fsf@kernel.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <874jgmnud8.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:8:55::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: f16260a9-99df-4959-981b-08dbfc11660a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjWzjW6LRLH0dtwImZ5ZSr6klvH39HtdX2gi3zp1w/FgIB/mIxgRfBXcUZ2q076ivUcIv6eoBl0mUyMQhAMq7e9Z+FgvfNNqZYm8TS5UBR3oJImiJMGy3qHxDDuwk6+99mob4FeZQIuIOX48gbL/KmjB71bYWwQn35RjSMgv5MsXU4qyXpyAgc2oGg6yzgUDsP3FHirtODkldpRriGEpoO4pLxBodLNw8LUzsL9JLDvTPmtGVZqRwEbkRyznDOxieUa6J5XVETHTH79IB/gXMALxVhjaMWHpxm3n6lENariHHXSBhOgw6mbL9YobWTNU+9Q+YITl5gW27quua9HNMfseby4PezBrOj8FM920rRs2cqAwK+YCf24AMtHGHX5L/cgG7lck/LAUbSvGp8HS3IaTZyMd+0SSX9tBj2gp4Gk9J5o9sT6y/gBpQytODxGvIniXpFBLSYyF2XcdrWRyR9B6E3o6fpjjOP3gGjvjkxHOMG6m9Ur/of1z8GZgWoEFPQiw+aL10mIR7fn3nPx5X0+xMDf54tR4LQ0V7KzE/l1vPH6FE9N0fWGqjVRXl4cePJd9+fOkFSXVM0XaZMS1R3t77Hc1hioLjHBu24GDbJmqQ8ZMPS4qtjUIWcm0MROJRlcMe3C6KzhKEno84FzfHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66899024)(26005)(66946007)(66476007)(54906003)(6916009)(66556008)(86362001)(31696002)(36756003)(83380400001)(6506007)(2616005)(6512007)(53546011)(316002)(6666004)(2906002)(478600001)(6486002)(7416002)(5660300002)(4326008)(8676002)(44832011)(38100700002)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VaRU5pVElzTG0weHFTTjlqUFRMSWY5OEt5eGhuQlpldHBnTGFQY0VCUWda?=
 =?utf-8?B?YlFONXIxVnRhcys5VllWVDM2UzlpVzhvT1AzeXl0ZDZqaS9HY1NyVlpiQ0pI?=
 =?utf-8?B?RmtrY2dSWitPWDV1S2RTMU9WRXRYKzh4UXFOZjZDeFFRcStnelZSd3g2SFN5?=
 =?utf-8?B?Y0Q2Z1pUakY0UjlqM2tBWHhHQ0lQWGhiTzZxdCtmUnNxeU1qaGQ5cFM1ZjNi?=
 =?utf-8?B?L3ZCaSs3VkR6SVpzUUduT0ZBQTVpY0daWlY3QUJUNlpETW0yRDlHNjNQYjhz?=
 =?utf-8?B?N2k5QkM2ZERhTlg4VXB2S0wvNEpOOTVVaGFweG02ZS8xajYwT01JMEZRSlcw?=
 =?utf-8?B?Szcyb0pUTGJkT3RRWTRuYWc5bVIrYkVhalJGb1UwQ3JpcE54TjBTR2htbWc0?=
 =?utf-8?B?WXF0dmhJTU5BMXRxYjdMVWpuM1Btd0tGRmRuRGg5VEViUGM2eDk5anloelFZ?=
 =?utf-8?B?eHdDc3VaZkRja1huRW9LNTRSTFY5WWlqZ0J0YzVhbnJrUnI5RXl6ZW1pclpD?=
 =?utf-8?B?bEk5TkROc2Z3QzY3MXpKd295KzZvd0g4UnlXQVRvVzhOcTZPY21va0pvOHhT?=
 =?utf-8?B?dm14NFk5eUVKb3RxNUpsczNpQUFObjVSRlVqbDNsVTVxek82MWZUZnExZFNF?=
 =?utf-8?B?RHdodlNPTmc0TVNETWNTRVpNSzUwTEJhS3FhS0FaUitRbG5tYXNTYy91a1JD?=
 =?utf-8?B?Z2IvZmYxNHJKMHd0MlZ2OFFjcU1yTGJxaXFSMk56QzFEUEh5MkFDK3cvQWNI?=
 =?utf-8?B?WTQvcTVTUjc3bHM4b0FDMnJYeE90MlExZzdhb1JKckZWOWN0dUQ3bFl3Q0NR?=
 =?utf-8?B?ZlBwK1FjaENSTFZKQTZyUmNEUFFiYlNMdUo4MExRSmNDQUVZZ1NGcmRBcG1H?=
 =?utf-8?B?enM2eGoyUytPZU9HbklPczNjVXdXSWM4czRKN3F4YnkrcmVkNE9IUVNzazdD?=
 =?utf-8?B?STIvSzFjdGM4VTI1dVVEVFdDQ05sUUFxMG9zSmMxY1ozaVVlMEdQVFRpd3lF?=
 =?utf-8?B?UUUwZ0hOMHpsNmVKL2ZsTlMwR2ZneVV1K1dPMnZGbldvbk9laHNJUlk4UU01?=
 =?utf-8?B?ODlBN1RRaTFqeDd0MUtDY2dCR2hkeTBNczRJZXNrbXhwUGZIVHZMMCtYNUlG?=
 =?utf-8?B?TTRuZlBWRWtadDhNZlFYSXBONDJJdkFYeUNVNHk1akhWamdrWnBYOFR5M3gz?=
 =?utf-8?B?VDk2VWdKZ21VRSt5dXhoQlUwVWlXYThUNEVXV1pWNkZJWS9IQ0ZzR1EyRnZP?=
 =?utf-8?B?WVkwT2VjYlVpZ3RTZlJxUkZHRG44eVY0cjZlRm82dHdWSVBzbXZ5UjBtU3lN?=
 =?utf-8?B?aHB3V2ZzaEl4OEpya0l4eEZ4UkozS2JEaXlBUXNUUng2MjIyeDVCdm5tTnBH?=
 =?utf-8?B?YXNKelp4T2ZTeHJlS2VPZkREdnA4OENYT0ZuSEVGQ1dRNm1RbWk4aGNYQkp2?=
 =?utf-8?B?U0VWaUsveGRUY0EyOUlvVzlXdk9PcEQ0REQ3Njl4aUk3d29qT0Nzd1RJZE5p?=
 =?utf-8?B?cUx4Y1FkZU5XVDNCRjg0VFZtSnZWVVd6dVYzdUVhZVBmTlduOVQ2eEd4SUht?=
 =?utf-8?B?cFRva2UvOVYrSEtCbXJGSUdDZzlWRWQzbkdlY1hwUUtudjV6N2VrdGJHdVBm?=
 =?utf-8?B?VkgyWU84NW9ud2E3YXEraHk0VENSa2lKSERoVDBNM0U5V1JYcHo3RjJlOEcw?=
 =?utf-8?B?TDBZYWltd05Da0FaMlJaMDJrVG80d1RHci96NjI2M3k3cVdNVFdJSTZrYlRy?=
 =?utf-8?B?RVAxelRzeHl4ay9ZZTZ3QU5wZHo1T01zcTVCdGhCNGFBOTZqY1RjODE3R2V0?=
 =?utf-8?B?amNVZ0NIT09vN3M4TjFtZ0JESFd1TDZZQ2Q5aWNYMVRoSHhwZWtjcHlHNm9D?=
 =?utf-8?B?L1ordmxxV0NkNGN2VEpzbnJNeWZhcmgyYlFjZDRpT0UzVGhycUlheExIZlRM?=
 =?utf-8?B?V2d1QXRSZ2IybkRWMndHR2VqYndKWU5MRUlTOFBPdCthd3FSZDJaS1pkQVhr?=
 =?utf-8?B?K0ZvOHFhTng5YUFXUzg0MFhCU2ZSTlBYVHgyYzc3ckxqMVdUSzR0TXltZkht?=
 =?utf-8?B?QlgyRWJrcmZyNEMveER6YzFZYjRqazZNOGZVYUFuOHJNSTdBTm8xcStaVFdK?=
 =?utf-8?Q?0bFyMvMjNvQAYiZ1xASIcifMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16260a9-99df-4959-981b-08dbfc11660a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:26:26.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgcW6o5YA04GeLCw2fimvee3fKT2zB+J5v9+vbDMGeuZw9DI1rKt+5am8ML4ggKb9ypcqe5XEfdcU98bh1dDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2023 06:45, Kalle Valo wrote:
> Mario Limonciello <mario.limonciello@amd.com> writes:
> 
>> Several users have reported awful latency when powersaving is enabled
>> with certain access point combinations.
> 
> What APs are these exactly? In the past 802.11 Power Save Mode was
> challenging due to badly behaving APs. But nowadays with so many mobile
> devices in the market I would assume that APs work a lot better. It
> would be best to investigate the issues in detail and try to fix them in
> mt76, assuming the bugs are in mt76 driver or firmware.

In my case I could reproduce the behavior on my Unifi access points. 
I've got a few that devices could roam between.

I also happen to have a laptop on my desk with a WCN6855 that behaves 
just fine with those same APs.

The other people with problems I've asked to come to this thread to 
share more about their devices.

> 
>> It's also reported that the powersaving feature doesn't provide an
>> ample enough savings to justify being enabled by default with these
>> issues.
> 
> Any numbers or how was this concluded?

It was just a data point in the original patch from Sultan (who is on 
CC).  I haven't corroborated it myself.  Once I saw that other kernel 
drivers like iwlwifi are also "defaulting" to off with a module 
parameter I figured it made sense to bring that for discussion.

> 
>> Introduce a module parameter that would control the power saving
>> behavior.  Set it to default as disabled. This mirrors what some other
>> WLAN drivers like iwlwifi do.
> 
> We have already several ways to control 802.11 power save mode:
> 
> * NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')

I'll experiment with an unpatched kernel just undoing this from here to 
see if it alone improves things.

> 
> * CONFIG_CFG80211_DEFAULT_PS (for kernel level default)
> 
> * WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the default setting)
> 
> Adding module parameters as a fourth method sounds confusing so not
> really a fan of this. And the bar is quite high for adding new module
> parameters anyway.
> 

Should we also discuss removing the iwlwifi one then too perhaps?
Seems incongruent to offer it for some drivers but not others.
