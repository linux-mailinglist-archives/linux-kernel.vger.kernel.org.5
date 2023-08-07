Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7697730A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjHGUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjHGUr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:47:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2DE72;
        Mon,  7 Aug 2023 13:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaqHVDv2fmvnj00/JJsnt73bHl2q2B4LNadZyI0Ds5L88hsWVQGIqTgGv+p/pcc2z4jQggTpsZXFSiBn7gdR/TxISm8YKLH43zH0gs3EkTlg6QZfkf9TKDtuSQ0EmzQcXCH0GK6jrv3aOqT22cMei+cA4/eCY/IPOJwMzieMzJfKyPfEfNTYZ1MHR67ApOXamWOhjnxJL4stYkXMxSE0uiD4OWq9khdBB+3nSOVFb/sI0bDCj5FCdLq2IeGEPim8JiqoxM0ooc/XWX9xtn+tqu/wT33YltLJMFE5DlMVvgodPSZ0tFUZsDbNjb+TAXmpMzXITDOb6+Ytr4jwcUCAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNnPycIDH+xJhlaiuZzHHp7Wn0LnhiPE4h0FhBXZD3Q=;
 b=iY34brI8Ch+q58uW674RIeBMC98X2+VtAUq6ZriB/G5CW72uKFLJ0PSksilds0s6ue468UUMw80/bRf+r11onzEzrAMX2WoSmW4S3G1VjYNMxi9fyscO0cRAlek8Y73zgUXPx8/+thPao+bC9nx+e8i+ArXGT8XwjPhWx1da/zRdjXnml//i5M7RTynrWPEAcCPwPKJsoTsa+WAIqkAO3WkgOnQZdDlqfJH6B+Wpfd+39u0dyBSyc/KByiaOH3o9uCWfbQcDfEUEBbrRQ+3OeStGaFhh045cIUkX6yFBMAwnnXp2vQHRNPbIm5ogRfYY/5GiA8Zr8MMxYuhiNBMoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNnPycIDH+xJhlaiuZzHHp7Wn0LnhiPE4h0FhBXZD3Q=;
 b=XhKmOGxFie6kRUOx21CmM4iBNQqX6ibPt662OUViOSXKIPHjiKVt6T4P9dRK1vfEsK59gCPvOU9h1iZfozEK9dmVVLXnfj1xftBohJjpj2Q+YTSRvww8+LgL4f2couF+yW2ntrGH+53q/sCTD8L6VHLG1K2RBgWBArJ4/7ua2Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 20:47:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 20:47:50 +0000
Message-ID: <70896b34-ea85-45be-8287-1f3858596837@amd.com>
Date:   Mon, 7 Aug 2023 15:47:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: amd: Don't show `Invalid config param` errors
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717201652.17168-1-mario.limonciello@amd.com>
 <CACRpkdYoxoZ0G7QzQ7XV2FPh9gUJG-CKfpFY1xNQdbBcJOQ=3w@mail.gmail.com>
 <87eada13-004a-4dd1-91fe-901cfdfd7992@amd.com>
 <CACRpkdY8cH3pAcQZCEOV=QN+iAE6hBoD+3ZJ2C4VGD0R5FP2Jg@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CACRpkdY8cH3pAcQZCEOV=QN+iAE6hBoD+3ZJ2C4VGD0R5FP2Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:806:122::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: e653f800-ca15-4400-15f9-08db97879077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQZQZ1mr274qQVXkILPk8us05do8EDNvtClTUTEbxecs6Oal7HL7USTFxgmF5SHmIXQ5WcqNU+aFsdtucvY08narndSDxUWWBjlSINnk8bg4q/QNz/jgZ++1l24lXz5rBDuoksv+QkQ9Sz1aKBqvwDKgbey55/23fTlmrLAutwZcKj6VMUwyMJwo9ansBIlPTKFwZ4ljcdBpVfmuy3eIVoDxK6DTTbJTxYhEagfcF8wpKPG4zg5RGI0NpXHJWt7++YZc0qMOK7qyxXn8aDX1YdU5R9BGC0qf5KzJ8LhSp4t7V/lWUcYpgcctkbwMXz5buMcZxVN8r2LciLJwQjg9jr7hKedNhdbIUTgOMkNFBnVt1PbrKLmPe6pwXvZhnl6TH1VHisgARjHvJi+CkAknu6pEWFr+E2M1T+MNGaDO545dVa4vDrQQFBzJQ4npV2Q9P0eic0MIMiILg+1BlvHBaT7+vfAfJ/jfLNyg73jEYeh2CXK9FF6yXy5Kq3Ey2fErldr1+PXhg3BBgf/tWgT8+mnvPj+8BxwsjhpLuCCw9ufd7TPGp39fOStD+seP51OBlJkoFfYaekLiP5rKpHxcrtusUSltpnOxyQbCwDLVVhJ4sXRzwDaeJg6Jl1atOgcGYsOSpAzZ/123O+wupuXOkTIv+bMLnoNrY3CnGpg7+xY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(53546011)(36756003)(38100700002)(44832011)(5660300002)(86362001)(31696002)(4326008)(2906002)(6916009)(66556008)(66476007)(41300700001)(66946007)(8676002)(316002)(8936002)(478600001)(2616005)(6486002)(31686004)(83380400001)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0pHTm43VE85Sk9HdEdQNDliSWRhb1lJRkR2bUEybzFDcXFNM1p1eFJvTTZG?=
 =?utf-8?B?eit1RGo0aVRTcGpzUFJ3RWl5S09WNnFFRkFza3REUFUxMW5tODFjaTZrNXk4?=
 =?utf-8?B?UzRHOUhXc1pxRmxZcTV2YTN2QzIwZlZ1VlUzTVdRVFJyZWhPSlF5dWpXa0Jw?=
 =?utf-8?B?cmw0c25HbUZGbVgzQmVTdW9QMVYwZ3RBczk0V015WWNpUFl0UjhmcGtuMTds?=
 =?utf-8?B?T0JSVjdaZ2JzS3RVWDdTQlFVWnlCRVh3VmZ1bi9nVkNwcTVSRjNSMjZZK2dL?=
 =?utf-8?B?d3dwRzRqeis0NEN1THQyT3Y3TGZUczhBOGhmcTI0cVk5ak5Rb2tyOHViWmI0?=
 =?utf-8?B?V3ZGdXl0TDkzUmhVVUlKMHRYelJDemFSYVNBbWpnTGU4RW0vY2pveGRVb3BM?=
 =?utf-8?B?czU0d2ltc0E5Q24zdjVVVEFmMUFWY0dzcTl1Z1VhQmRWdCt5UDlVaXZIbXBC?=
 =?utf-8?B?MDJBS1hRY0JMRnpuR3czZTdMaGNpSXBIWXNIMVVqaXZmaTJhaDczY0FSbDNr?=
 =?utf-8?B?M1p0c29GdTN0NUV2WGRyKzg5RkVSdk1yNnN3KzNXMmExNmVaNXVyWnYyWFd0?=
 =?utf-8?B?ZGx1MDR3NUtYeldkNEtNWnYzdEJGTzV4eWgycUUxWnk0ZUE5cU02OS9kODNT?=
 =?utf-8?B?a3JHYjdTSzNNU2xtZ1dwL2lDckNrVy9lWXMxWm1uVDVrdWFuTEhOOXJmaVRF?=
 =?utf-8?B?ODhpS1k2QUFGeU02RE8zdTEyZGlYYWJub3kwNytjM2dmRmM2RVhDWVB3SllB?=
 =?utf-8?B?Y3ZJWUZKVU9PblZKbmNCNlhZSUYxemVteVZnOUpIakNqanh3M2w5Z0FEVk9u?=
 =?utf-8?B?cXp5VlZNeWpRZlZuSzNWMUdHUTJsYjIxUGhaRTU0aC9JeFpFUndKZVlCRlM0?=
 =?utf-8?B?cVBoaTBqWFRkUjZSN1U1K2ZxYURDcUh6OHhzRjdMTXhXaWFTeldPRnE5Y1Qw?=
 =?utf-8?B?NHFoenB3dGxRa2hwYUtPVm4xZ09acnlGQXVyQzZZUGhYbUFCK0czRjBEajZF?=
 =?utf-8?B?MENvOHNlZDFsNThtUGY1dGtSSkdYMVIxazNlRVp4K1dacncvemtjQ2V6OGNC?=
 =?utf-8?B?Z080U2txeU5hOWFwTnNZWkl4OG5Tc2lBRnBGMTVKcTcvWS9PK3c1b3R3V2No?=
 =?utf-8?B?QVgrRXlYN3I3N1B3OTNKOFc3Mk9rR1hrMGp0cDYyWGFDZmV3U2ljMGJBTVp5?=
 =?utf-8?B?a0EwN0tJdTh0b3YySTVxN1BwRENlOURSTzRDUWl4ZmhnWnpmTldrOUdpdTkv?=
 =?utf-8?B?ZHZhRCt5UjExQ3hUdWJ6WW4yNml5UWJBRTJidWF4SXo2clp3Vlgzb1FWbkN2?=
 =?utf-8?B?Z2ovRzg1S1ZHOHRxUXZ6eFB0cWhRbXRzbTNFd3ZJTW1jQlVrS08xYkJ4OFg3?=
 =?utf-8?B?V2pHTklLN1U3dzJLelFBME9IdWhoQmNRNnNSZk94dGRWMFBsY2dvdWJpand6?=
 =?utf-8?B?cTFjSDFqNVJDdkNKUDZMcFFIQ005WHNoTFdSTzA2eE9lcytzeVJnam9tZURn?=
 =?utf-8?B?SzB4T3liWWNBYng0WUN4cHRET2gwSVVaVjZpZno1S25SMkN4L0oxWGZlT3FK?=
 =?utf-8?B?Sko0dGQ0WGxjNDd1ZUd2Sm90ZjlYQ2FzT2tkdm5HeERZUWt4cTUweFBraGZj?=
 =?utf-8?B?MWh3UnJvMkE3Ylc1UlJUSnRISlRkbUNxOEJSdFJxck9ITnlCMjF1RTQwcTlN?=
 =?utf-8?B?UVRzNTBFeC9tM3dFVjBwRDFYQ2ZBOGpsTFpncEx5SjdUN0JJRjFHdW55QXBq?=
 =?utf-8?B?ZGhSOXdxWlRCZWI1TWpoc3Z6ZzlwMTBVZmhMd0VEU3FWcDkvWEtaZjBCT0x4?=
 =?utf-8?B?MmhmRVhUbnRnWXJSTFRTTld1V3J2bDFwcmxKdVdPWGc0YW56Mm1ITk9nUkNa?=
 =?utf-8?B?ZGllSmNOMlJtNEg4Ti9BWlBJVkJPVWw4TkJHUXlxSEY1eFZ0cFlyZG5KR0Qr?=
 =?utf-8?B?RUxLKys1WFVadWhiWVJuSDdFQ3FsV3l0VExsZGhZYVRVSlF3SENERW1mb21F?=
 =?utf-8?B?TlZlU3UwUkxwcEdobmRzYUJYTnNOeDRpZUFubmdGSXVHN2xJS2x2UkpwUU00?=
 =?utf-8?B?T0Q1RHJCVGhIeGhaRmRvcFB2MFNBd3ZyRlRMN01MOWZtMmJGbUFxVFpSd04v?=
 =?utf-8?Q?yQkcwAIPy98Mnvp6vV1AazTbC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e653f800-ca15-4400-15f9-08db97879077
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 20:47:50.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Skd2fHnzM3hLJOqOdwIujEDBDEzYlC/L5RQEyZyAPIKtT4PGysNeGM9MzwKhsCzunhKH1BtHBeiS7AtrfIfxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2023 15:45, Linus Walleij wrote:
> On Mon, Aug 7, 2023 at 8:17 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> On 7/23/2023 14:41, Linus Walleij wrote:
>>> On Mon, Jul 17, 2023 at 10:17 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>
>>>> On some systems amd_pinconf_set() is called with parameters
>>>> 0x8 (PIN_CONFIG_DRIVE_PUSH_PULL) or 0x14 (PIN_CONFIG_PERSIST_STATE)
>>>> which are not supported by pinctrl-amd.
>>>>
>>>> Don't show an err message when called with an invalid parameter,
>>>> downgrade this to debug instead.
>>>>
>>>> Cc: stable@vger.kernel.org # 6.1
>>>> Fixes: 635a750d958e1 ("pinctrl: amd: Use amd_pinconf_set() for all config options")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Applied for nonurgent fixes.
>>>
>>
>> Just wanted to check if you'll be sending this out for -rc6.  It
>> backported to stable and a few bugs cropped up because it's noisy.
> 
> No, nonurgent means I queue it for v6.6. Fear of causing regressions
> on mainline is the reason to not send fixes unless they are urgent.
> 
> Yours,
> Linus Walleij

Understood, thanks.  I'll let reporters know to wait until 6.6 then for 
this particular fix.
