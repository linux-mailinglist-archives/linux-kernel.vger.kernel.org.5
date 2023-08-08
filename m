Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54C5774704
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjHHTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjHHTIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17DF12528;
        Tue,  8 Aug 2023 09:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j64GPF34tpTyZbNrTd33YTUBiwZeheFNikjtJ4YgAM5BUIat2ZSW1RjEwQBameneEkUJMtrA90ns8+Y+1PXg4LxUcx4//+3oVrQ6MtdSNfuRqgUiChPG5ZVzTHAOaopTDGv+kyGX2+E82gE3Ecr1wRb2YbwxZU7GgYNLPh2BU60zko1NTr91AXpvG4KCwj7oXFUbPiO6IB1o1L1l3DkMCxtEV9isU8FhodE3A3trQVzNjgjeW2P2Om8KfgJFeODUdMtko05HWlAx4r2Y6SrGHI3Z/V0MOOigk4x6F84u2Zqh5j39W2tpGpViGbo3WVEYxi1asU3Iw4Iur81BknS5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmqmPsBFD9vrRsdzJNl06/9cV3uhWM/5eD5lQMx1iv8=;
 b=ayPerEhteR+KVFh0OasC4Ll/NgJ5CQiCFPB2ADWRwu2gAx83XTy7fknjBzvXdlYee5iIBHsR30BAqQrzVIjeecjwgfJDzgrT6nJ+kZ/hpLzb5Wdtpmq23AWRcOPKcpfV2dzG3EAd6e8SwLTC3+MgnRwN/uK6NmXgXTpw0O1HSXPVkyAfFzXhkcuDo1v7ddjwkytuvWzuQ3xGYabIgXVxFUy2gocR1uFDu7HhFGa+xqAgpMABGSyaC9LWf8Ss1llBIBEviawoeCCDBUlv0J0rC4UBOQ1fu0kRt1SJbrT8VzHH0w2QqHmo/EzNm6slLcFsJKXg1ygXeT5z7biLMPOifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmqmPsBFD9vrRsdzJNl06/9cV3uhWM/5eD5lQMx1iv8=;
 b=U/U0nE9rKUHxrqArQUUOGemkrPrOX1Es5E6fi94G+CJ/2+qdO+C6kFSpREueLp5nwA5CP2IuhwLWD6jaNoX6kDE6QaXUCS+x4UiO6m9g5BPaMezIxXVnrXM74og5oL4oP7CjrB/Um5k13lT1MlzzfrF/nganJ1ltXZB+SmBN1Ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 16:24:14 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:24:14 +0000
Message-ID: <b6d14af5-9ed7-4080-82e6-0db6728ca5ff@amd.com>
Date:   Tue, 8 Aug 2023 12:24:11 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Content-Language: en-US
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
 <b5609e88-2bdb-44ad-8a3a-b61196ee540a@amd.com>
 <20230808155803.GFZNJmCx15MGlDPVkp@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230808155803.GFZNJmCx15MGlDPVkp@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0769.namprd03.prod.outlook.com
 (2603:10b6:408:13a::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: bacd8c43-777d-403f-ad59-08db982be7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+IMXSz5MGd+wRliPNjXkBO7f4ScglCfcFc5qYR7aOEAa5U/rYWunGOBLjjmaNFNGVuoHts3tiWjZ2DqCKxrkmk1bF24eSwg/59vEq1JvjHQWcv2dkyCWIiHyywc5//WauysgMtHzd3RL9Q/2I9o+GMd7+3hEuT22vZjRP0zAKpFWF6lIWD/p/zihRxYCyp/Ec7ySLsq7rSiYhS0cH+x1xNyEaPGO9+yTTfkG2CdGu+0dac59kWqt9o+JPY18cBySdSLoe4THP3y/jEzM5jlzPQG2nMgMaf8ylG3sJUkyPUXY8e9JDlTftWci5UBgaEJ57LecP2A5HBkgxBWlkntypSUK3BbvIjkH9ppAR56FF4WTDproRooyq9qcgAh5qhu14RM+cX6fgg1iBwJyovS7zQZ32ybKbabA9CTBsCL3ltl9+tQoQXa6z/J4OyR/WISNsZ8GB3lvLdTSvYmANaVFgm+pyputMXaCvfal2wgx1CmXNYmmYwPJiJEnoSIdOVuQNPxWvNoL67L/I9IRZOCIClm9cEmCIvIE+cWDFG3XSpgnK/TmHhjJGu9h0bi5ge0vgTeKNRVJ/Q5qoydMMoB9HqOaD4W0JTv8I+F2U/Yiey+m7XvDGeyI0/jTwfO6QGS6iuQQUVSgteJCj/CddtmnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(186006)(1800799003)(86362001)(31696002)(44832011)(41300700001)(53546011)(478600001)(6506007)(8676002)(26005)(8936002)(6486002)(6666004)(5660300002)(2616005)(6512007)(36756003)(83380400001)(2906002)(54906003)(31686004)(38100700002)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N284UjZjb3VtUFRCSlZpMHovNWwzR1FxY3VRZktyODIxanBuc1JRZU55dWJJ?=
 =?utf-8?B?YUV3TmVEeFhlam41STdTS1JlWisyVTVvNlpHYTVzSlVJQ3lEWnNDQkpYMXRN?=
 =?utf-8?B?WUtiWTZQWDhzd3lUNThFMTJJU3d2RWxacnNQV05TbWhhc1p5dUszV0REbnlD?=
 =?utf-8?B?UGZKdUtNSkVtVmhwRFg5aGNDUDNJbW1lSkRwYXFoOWJMSEtpVTNXZEJxNk5V?=
 =?utf-8?B?MGlRbitBRi9PZDVWK0dqaC9Tc2psMHVFNVg5Tm1xZHliS1NMVEF5WFhGZTkz?=
 =?utf-8?B?YWQ3UWJ2Sk5iMmxUZVI2ZEw2K2tZbVIrQUpEa2lGNXNiVEhrTXFYSkFTYkUw?=
 =?utf-8?B?UHBXUDR1T0FMaWEzVjdvdWpzZ1ZZVGdBSlMzY1VKZjVOVkVOTjhkRisyTEZw?=
 =?utf-8?B?MDVmTjVKc0NUdVQxYUZXdkRDSHBqMDY5cHRHYmFmREdqVlBIdW9Kd1ZjeXh2?=
 =?utf-8?B?ZmlDMVZpUlpaV0Z5UjAwS2F6NTd3MVpFNVdkQnRteWRuaDNHTEFUaGsrOXZn?=
 =?utf-8?B?WlZpd0VDRzQzQjBzVVNXVUdZdHcxV3ZIN2ZpZGJyNUttVldweFlNbkUxQ3BB?=
 =?utf-8?B?OXhVRWJLeWJ5QUtGVDFKSXkxdFcvVFFJRnhkZUh3eTFoMkVsWTRIaHo3a2tO?=
 =?utf-8?B?dEQ4UkhzWEVOaDlvUGdnYmdxU3VQYWxqT0hTT2ptL3lDcGc1Yy9PYU83Rmcr?=
 =?utf-8?B?MWNxOS96VnVqLzZpeVR4bHM1SGdXeXdtcHEra3JmaE1jdkk5ajZWR1pjQU9l?=
 =?utf-8?B?NGxySDNJc08xSmp0eHlIZzVYTUErWkN6eGJlWjFJSWJudkgxL3d2TmdWd0Fm?=
 =?utf-8?B?TEdRZElyWGhzZGVDQ2daazRYcXk2VDQ2K0NUS1lsTWNCOVplaGZMY2I3L2Mw?=
 =?utf-8?B?UXhMbnB4b1orTUNVTVpYdWpEYXRISk9nbFR5TitWZ3MxSFp3ajgvVlZML3Z5?=
 =?utf-8?B?a3VSR1k1QXBxdjBkeWtJSVBEbWJiemlqMUc5STFlc1hwc0dkSUM2RGFEbENs?=
 =?utf-8?B?RU41VEVBcWh2TUlBRzBEdEExSGEyWnpuMEZEbHVXNFBCUVRVUStpYkZHR2Zn?=
 =?utf-8?B?UWVjWmwwVGJzeENMOEVNcnNGS3RuUmozQzc3Njhyd1pWRGd4WE1yYmVaZ0p6?=
 =?utf-8?B?QWNRcjM1RkRONUdndzdKbVJyNndzKy9CZC9YbkIvVzJQVmcyVm1Nc1FGRlg4?=
 =?utf-8?B?UUZoZzRBckcyZmNEUUp3TlZRQklSNlN4UDZURTNEZWJidzcxbUNHUlZYVmpY?=
 =?utf-8?B?ekpHTXUyZUtBV2c3UU5MdExDdHNBUjQ3bnFnTkxiVzhXeit3SGlMNTIwRmZM?=
 =?utf-8?B?Qk0vdmJ0TmMwVHVDNHZvem9mNE5IVGkrUzZDNnB6SkFYQm5UbXNRWGJpOHg4?=
 =?utf-8?B?VzFudndmMmxjTUtTa1BZYU9VWFRkdDdWSVQvNVBIejNIVXlPVE5TSWRWS2VL?=
 =?utf-8?B?V2JJaGgxeE4za3g5ZlFSOWVRVmdLRERSVktxRDdWMjJkbGpJYzhzS2xEVVhh?=
 =?utf-8?B?djZZbTNVQXU3c3ZuOHhxckpuZFBraTRUcnFyN3BVdWhWcHc2MmlKdldoeVF5?=
 =?utf-8?B?RHVybDUrRUtIbXcyempyMDA1VVMvMmNxY01YVTdSbHZFd3Jkd1lKUmM0cGdp?=
 =?utf-8?B?Qnh0VHp1U1hzNmt3QkdtYmtFSi9obUQyTm9tOFFabjB1STdRMU4wQ0c3MkZY?=
 =?utf-8?B?bTdLUXU2OHpQMjNRK21FY2g4WVd1d2JOTGVPb2dUOHZDdjE1MzhxUWFiMnNF?=
 =?utf-8?B?ZTFhTGpHajhvUXBVUldGV1lhSkpnd3VtSTNTaFVJS2hnY3A0S2tpbk1aRU9k?=
 =?utf-8?B?WGJwdU5YRm1ycHNkNjNXV3l2dE1PTXhtK1pkRmZyb1FtYkw4d2dlS0ppQTVF?=
 =?utf-8?B?cnVtNElIQ1dRamN6VDZHNSszV1FXN09jaXlhQk5Bc1lEZDUyUEJQK1pwUm5I?=
 =?utf-8?B?Y2FaV0pvNFFjOGJ1UzRWWjIySXpzWHVRUUpOYXhWVkhJS1dSbE5xd05RRzBE?=
 =?utf-8?B?cmM2c0pDSUVuVFZNOVd0U090V3BuTEZqdzFRK3VjaHdxcFhGRmdXcW9oczJz?=
 =?utf-8?B?UEkrVTRHblBrNk1YNlZTWjhJTUhuMWFnSUY3bS9qYXBRYktLK3NxRzhFWFRM?=
 =?utf-8?Q?TdJT2LvNT7afa77BQfgAQSOzv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bacd8c43-777d-403f-ad59-08db982be7ad
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:24:14.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KmqxRxfpOcNbSwxx76AsihpzGynIQiTOOlScK/dmKNOIhsSJZMPmxCRHR3CgYSwiMy+tE3pIAZNYgn8v/lsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 11:58 AM, Borislav Petkov wrote:
> On Tue, Aug 08, 2023 at 11:18:07AM -0400, Yazen Ghannam wrote:
>> I think it would be better to avoid dependencies between independent things.
> 
> If they really are independent then I guess. Not that it all ends up in
> a twisty dependency where you wish you should've merged the two
> together. So think about all deps before you design this - it needs to
> handle all cases without hackery.
> 

I agree. My goal with this is to avoid the hackery. :)

I guess we'll see how it goes...

>> For example, amd_smn_read() is mostly used in amd64_edac. EDAC was the
>> original user of SMN accesses, and all the SMN stuff could have been
>> included in EDAC. However, SMN is not specifically for EDAC, so it was added
>> to amd_nb.c to be commonly available. Currently, SMN accesses are done in
>> other modules. I don't think it would have been a good idea to force other
>> modules or subsystems to require EDAC to be used.
> 
> What does that have to do with this? SMN access is generic and should be
> in amd_nb.c as it is needed by other stuff. EDAC, RAS, whatever are all
> users of that thing.
> 

Right, but that's my point. The translation is "generic" and tied to the 
Data Fabric which is the central "thing" in an modern AMD SoC. Anything 
that needs memory address translation for the fabric will use it.

>> This is my reasoning for a separate, independent module for the translation.
>> EDAC is the first user of this. But there will be future code that can
>> leverage this, like CXL, and even the MCE subsystem. And, yes, mce_amd may
>> be already loaded, but this isn't a given. A person may want MCE and CXL
>> support without wanting to use EDAC.
> 
> Is that a real use case or just a hypothetical thing?
> 

Real. There are actually two use cases for CXL. First is memory error 
reporting and page offline which is analogous to MCA. Second is general 
memory online/offline support which will be used for hot-plug/hot-swap 
cases.

In actuality, both CXL cases need the same functionality. Take an AMD 
Data Fabric "normalized" address and translate it to a system physical 
address for the OS to take action.

>> Furthermore, some things using the translation will be built-in, so the
>> translation module will need to be built-in.
> 
> This sounds weird.
> 

Yes, and this is my intention for using the "imply" Kconfig thing you 
see in the second patch. Any config options that need this code will 
"imply" it. And the default option for this code will take the strictest 
setting of all the options that "imply" it.

>> I agree. And I don't think much of the existing things in EDAC should be
>> moved out. But this is new code, so there's an opportunity to have it in a
>> more appropriate place.
>>
>> And, thinking on it more, this could be another example for future "common
>> RAS" functionality. Isn't that why the CEC is in drivers/ras?
> 
> It is there because it doesn't need EDAC at all. If your translation
> doesn't need EDAC and EDAC is going to be only a user of it, then good.
>

Yep, that's the intent.

> But if you're going to have to need the MCA error decoded by EDAC and
> then the error translation done by this thing, then you'd need to
> synchronize between the two. I'm not saying it is impossible - it should
> be well thought out first though before you go coding.
>

Yes, I agree. That's the reason for this code to take a raw struct mce, 
and do the translation independent of EDAC, etc. (for the MCA case).

The same will be the goal for CXL. This code will take a raw struct 
pci_dev, or whatever, and do the translation independent of other CXL code.

>> It seems like things go into EDAC because it's thought of as the de
>> facto RAS location.  But why have something in EDAC if it doesn't
>> provide EDAC functionality?  Other RAS things, like AER, APEI, etc.,
>> don't live in EDAC.
> 
> AER is part of PCI so we haven't considereed tying it into EDAC. And
> there wasn't any desire to do so.
> 
> As to APEI, there's ghes_edac...
> 

True. Though the intent for ghes_edac is for it to provide the EDAC 
functionality.

The other features that don't need EDAC functionality aren't in EDAC.


Going back to the dependency concerns... there are a lot of 
inter-dependencies between RAS code in various subsystems. Maybe some of 
these can be streamlined by moving common things to drivers/ras? But I 
guess this can be a discussion for a later time...

Thanks,
Yazen

