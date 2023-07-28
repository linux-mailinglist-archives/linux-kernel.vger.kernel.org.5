Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8C7677E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjG1VsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjG1Vr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:47:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E9BF;
        Fri, 28 Jul 2023 14:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs2dNrKsv85RdYmWoI3ENtjO9KGLmBDxYVxDTL2cOvmO3yEzGRd85b8Q85UPbHIQ9916J1UDsS6omRRpJbuqSrfPqbv+Rv/xHKPJpc876VqZeIONPhCUoWSd2L/npLV/lIP3P98g2Qfd7T0CVv+eiRKEhkUS9RHqc3gE3VocaijU+CoRA7IQjBw5opArPRptgZKovvNA2qbtRKt/9lIaPo4hozZ5of9VzLHCpsjF7UlyunN0Q4eAAk1jRlai1d+Wr6CXQrVWYurzJpsR8Jfuy03f49f0A9Rc7wCKtcSF0RJf6r/Cu9Vg/e2ALDJz1y+RELOKVk6ZtZvBrGuZfvuh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnvGdKBp8/2zymQpfEA38rWxCe+790sjAUtQdbFvIe0=;
 b=JyF0t6NaG3YSyMyHBHRKdKAJZFwTBHHLEKbtJZmhDfP/tFWO8wd4uD6ZqbNHTyp0W+fohWwgs5t1WhPx7ipN4HJa03tMXL2zTTu06nFvNh67dSHlnPHc/WaSXEaDiapn1A5JcBglqaTRT08NQdlwSltSx6Jd76s0EH/IAxno1w8emZGtQbHDdjpXZzwmmYHnvlH7DIqR0WiUeqxnnPHSGuK0gszqopUQcEgsB0eRCgC8g7TTr7RhChFiJBgqKuMgpUPG4jthxXJEVbKYPKvD4AQdCkfPVzXUHBnXUUMFtp0uCVMVqzgV4JUhRIf6ZOdhOsiwu2QhUgTZSLd/SM8+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnvGdKBp8/2zymQpfEA38rWxCe+790sjAUtQdbFvIe0=;
 b=FncMEfa7Bf6E/DqX6nrgHaRGDtd7m0aV6jatTSZTgmXbbDOvTQzHWstkUJBy4nURLgOgFDeCTURiZHOlKMjnYEt+b+fm99D3b+5cPcK29BLt6/kocKEShr1/bGJvQPm3T54KQaZD+Aw//UBGWOE/PF5y+dDn6uo3QDHZfyNYVzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 21:47:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 21:47:55 +0000
Message-ID: <b157706f-b9e3-7c97-fd7c-594928d9a457@amd.com>
Date:   Fri, 28 Jul 2023 16:47:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com> <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <5235ab4c-a49b-0679-1bef-c3f02346168c@amd.com>
 <CAHk-=why=_Y60iHnsh8-SZjs8Ndm41cjAHw7KX3FOD-85=CKEQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHk-=why=_Y60iHnsh8-SZjs8Ndm41cjAHw7KX3FOD-85=CKEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5d3011-04f9-4d35-7fcd-08db8fb44ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 018LtsZzu3LNdISBOqYxEgkube547cs1WBq4iCs8ki6k5Nw4Q1td/9Rp6cueO+r7ye9fUZwd7HsjWqCnvrg4XnwM1CZUc7AgKo0fwZl+dD+HoFpmi5Z0FB89hJAQE+2A5kH1e6N1LFCF6tSAB54RNEhW9LJB+W43jlxtI9jeIpagMbbhb5PPj1daWSApnSLg6iqOw+8k2cP4IHclhSIQgSCojI8VZrW9bG0zc11wR88hznzymETm1EDiM69o3Ek4eemldZXiNeQSGEQpQO0BG9bLkyQUYsEu7Mf0Z9WDg5kmwzZ8Rt2tg6PNxWgXL+b54xFGWXL69avTtHmMEOuuZ5QnP+Q5MigQEVDk3qHQjjvxo4FKOQhM4iKCzWsqvbkZCx7MAuo2qlojvBvwcmVsep/x2ldjrQkUVFqtqiyHQyBGqLMuB1v9dH1HfIomXHFX6rlyeVV0fLQ6jzMTjoyRfRCfekPg5ZoydU7tBi44xS0106YaibuLa6WPyx2LflpmbNT4FzFY9v2oX0qT9epeU6ex3XU7jZdUNqNTJuPplAk2zmG0TSZZ8sMkzU/WprRZPtNdZX28pYTVXvxiBtc4SzkVEELezjOMjhHRr2vDoK9r/TiPB4/ShSGMLowi1t2QJlFkpBP/NP7HWEDuhrkARA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(26005)(6506007)(478600001)(53546011)(186003)(6512007)(6486002)(6666004)(66556008)(4326008)(66476007)(6916009)(2616005)(83380400001)(31686004)(38100700002)(66946007)(5660300002)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmwwQldMTTBsN0NDeSsyaWFCQXNQREFzakVWd0RnRWt6Tm11UlpPNWdpRW8w?=
 =?utf-8?B?ZlFRN1FWRithNEtDTGZGUWhBRFBPT3VPKzZ2aGh3elQvZUVqRTFuMk1BK2Zy?=
 =?utf-8?B?Nkt0OGQxMzN2WEtPUU1SZ1h0dWhiTlRZc3FnYzZMRzI1QlNyMkNTaitURDNw?=
 =?utf-8?B?MmFhZlhOYndxc2RIdUJiK3dMbUdkRXE3YkpvSWhwZThQQ0FJN1I5YVVmQmFy?=
 =?utf-8?B?ckpBTm8xeERsTStNVzRVUVlzKy9KN2xZUjRrSEYyWG0wWkwyek5NTmZ0czhJ?=
 =?utf-8?B?c3NteUlrYzBwSzJOaVNvTzZpRit4azdXWGZ4UE1vendPVm9GQ1ZaNUhqU1Ny?=
 =?utf-8?B?YXg1QmFJVUVpSGl0Q2trbUZCaGZjQnZDaVQ3dDFPdnErdityQmFQRW5pYXN4?=
 =?utf-8?B?WE04VEJSMXMvbmxVMk5qeXhwYW5jaVhDUWs1UENLOTBLdzVyMmcvWUlLblVI?=
 =?utf-8?B?VW1CNU1LN3RqaTdZZm1OemNJUkhSdXUxczllV1pYRnNRamt3UCtBVjBMK1lM?=
 =?utf-8?B?b2tYSWJuV2QzeStRVDB2THM5SFpzTzN6bnFpOFJvSFJvNWsyNWwyRHFDcnBn?=
 =?utf-8?B?bFc1ZXhVUko2WTNvdEdRV010djk0K1VLV2RWbzQxU2ZPbW9hTkFxWlBMMGJW?=
 =?utf-8?B?cEFkaEtrd3l4ejBRNitCNkg4bUsrajdNSktwUmMxdlhpZG50RlZVdFBTUDI1?=
 =?utf-8?B?U2svYkZjQlZjZ20xT2lrTHFMelBUNTFIUG16YU84MWMvZ1ZwdnFROXhpc1A0?=
 =?utf-8?B?WjdPZ1ZONjFmcVVRVkcxbzkySHFHL0xyVkVyeGN0Sk05YmxyaGpnbHZldElx?=
 =?utf-8?B?bGxhVXhqUVQvTXdpcDdPMjVsZnUzN0RDQjdYVHozeXRaeWFQTnlhWWN3YjBi?=
 =?utf-8?B?eWd6aEhGMnpHRmY4MG55OFlmblF3cmRkdlczeExVT3ZySVFGT2l2QTVCZWdH?=
 =?utf-8?B?OHVPUXdlZ2JEMjEwck5GYUhGcVdTbW1zWjNtUVNzbUdmUE5LUlBMMEIvdDVp?=
 =?utf-8?B?QitRcUk0MjFrRmRISGg4Vmo1MlR5K2NqOTFDOHZKa2xCVDVzbkdLV2RwWU8x?=
 =?utf-8?B?d2Q1Y2pOTVBSSnN2S3RubFN2SHdGczJkK0RqVGp4bVlrMkZhU3ZaYjBOeEdM?=
 =?utf-8?B?VzcxNHlxVlYySnJISG1IRlFiVmhYaVV4Wjk5QzJDOFJQZVg2cjJSbitoYlpQ?=
 =?utf-8?B?YVRTV2RGczFTanJHektLOW5jblBNdkg1K2VFSWVMRUgyZzdKQVdGRVIzUG1K?=
 =?utf-8?B?UWtMd0ZFcWJ0MlR4TlZpTUl4U082MWpNQks5TXhtQnVGODlsNUprTGJYdnZu?=
 =?utf-8?B?T1dnRVhLcCtkYjhIMUpPY3JhbHpzNGNFUUUwd2VQQ1ZTZWgranFMSFBvTURR?=
 =?utf-8?B?RFd0NFRZR2FMQnF2MURRREpqZVhCMndENDMyNnF2RGFsVTRKWUpNVUtBUE9O?=
 =?utf-8?B?eWdWWUMxamtSNFhMa25yZVdrc0NFOGZHRm1JY0pma2kvUFYrZVUvQkpKK0l3?=
 =?utf-8?B?OUFqWTczWGNDaVdRRHVOWjBkbjZGT3paYmhLd2F1MzFIRkE5S2xCbVY3dmVl?=
 =?utf-8?B?aHREVFZlckVWVlFaSzhSVXlGWmlsL0ZwZVR3ekVMZGdzdUlacTZqL2UwbTJ0?=
 =?utf-8?B?cTJ2aXA4WUdvclBRa0hPN1dCUi9QT1ZDNnBoWmN2Mk9GWGxqaUhvK2IwbW1n?=
 =?utf-8?B?Z1kyUFFmcE5lVnY1U2Mwc1FmOERRaEdxMzh4YUZRQTVJb2dqb2JmcGN3Q0M0?=
 =?utf-8?B?YXByMU5TQjU5aCtETHZZa2hBNUkzcUdzSVlWMGtiVjJOYXo3ellIOU1zUkdE?=
 =?utf-8?B?RWF5RHk3ZTFBaGtncEFZbGZyTExnWDVZWDJpOHMwSjgwVXBkSWxLYzNoaG53?=
 =?utf-8?B?WVNFU2phSXFWN25rU0xhUTZiMFllNWt5OW05eFpNbUt5TGY2S1ZhcjR3MWJk?=
 =?utf-8?B?TzFkNzg2T1Rid0tHeU1LRDYrakh5Sko4N2plMDE1NUlDTWhEcHY5UDhSMjVs?=
 =?utf-8?B?SDAwYXFPVDZCUTRSV3c3L2p2d3NFVDFuai9CaWZ0d0dWdkVrSG9VWWhkTWQz?=
 =?utf-8?B?by82RzdDN1FUN29ZbDd3ZU9GeFBJUXVKSXVVNENnM0RtWTAvbVdnbGlERHVV?=
 =?utf-8?Q?nd21x2dOKltKPiKHL+1F9jyfb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d3011-04f9-4d35-7fcd-08db8fb44ce8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 21:47:55.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK4r/SxbaTOpqsfRFq7qO6OhErmkbDXEIfuE1njP5ljj/Sl0NBW8lQjVgRAdkNIlEVc7dgYXiacgZocaDDk0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 4:38 PM, Linus Torvalds wrote:
> On Fri, 28 Jul 2023 at 14:01, Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> That's exactly why I was asking in the kernel bugzilla if something
>> similar gets tripped up by RDRAND.
> 
> So that would sound very unlikely, but who knows... Microcode can
> obviously do pretty much anything at all, but at least the original
> fTPM issues _seemed_ to be about BIOS doing truly crazy things like
> SPI flash accesses.
> 
> I can easily imagine a BIOS fTPM code using some absolutely horrid
> global "EFI synchronization" lock or whatever, which could then cause
> random problems just based on some entirely unrelated activity.
> 
> I would not be surprised, for example, if wasn't the fTPM hwrnd code
> itself that decided to read some random number from SPI, but that it
> simply got serialized with something else that the BIOS was involved
> with. It's not like BIOS people are famous for their scalable code
> that is entirely parallel...
> 
> And I'd be _very_ surprised if CPU microcode does anything even
> remotely like that. Not impossible - HP famously screwed with the time
> stamp counter with SMIs, and I could imagine them - or others - doing
> the same with rdrand.
> 
> But it does sound pretty damn unlikely, compared to "EFI BIOS uses a
> one big lock approach".
> 
> So rdrand (and rdseed in particular) can be rather slow, but I think
> we're talking hundreds of CPU cycles (maybe low thousands). Nothing
> like the stuttering reports we've seen from fTPM.
> 
>                              Linus

Your theory sounds totally plausible and it would explain why even 
though this system has the fixes from the original issue it's tripping a 
similar behavior.

Based on the argument of RDRAND being on the same SOC I think it's a 
pretty good argument to drop contributing to the hwrng entropy 
*anything* that's not a dTPM.
