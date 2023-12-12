Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A729E80F6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376771AbjLLTZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjLLTZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:25:37 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA094;
        Tue, 12 Dec 2023 11:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aai4MW8O+KgKe1KtGAK2/KorsneWF0MLp1G0cMIfxm1J91kdcNt559E0IqBb2GCaXjv5ui4LmwfCNvPejySvpL8Fk2jsI/QFWYuE+pQsmqquMyo12oc0HGelrxwDFls2mUuRessqnjspdr18R+tTRISrnx5XrNWB7oDTUE207M7PpQmhaQcZ6yYkUicTF2dwh5Ws4Vb1NAOvTSSdOWQ5Tben/rYqNlEZgNq3Zt0utH+OiAYx2z+v0mtTed04ONf8BGmOCpk4ea+lgZXm1MShP6OHYK1PyQjhLpmtWzrPVLmdWF9/3dvJ0slZFam2eh0x2IhK5k92LhHheVlRNQYQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ0/hOT7q6+wZcWabDRe6MGkWyThgmjZXDxc1eCdct4=;
 b=ixHNrGhAGe63gIXD0qPaLOTOLOf0RLUjS/5roFyUQATruZvRxDqjihPrI0/PwT4Kd2z/Cx3nCNmAhR9TWImSqXkJXabTwcWgDhLKDjnw0JPP3zPrBl3q87YJj/ENeOWF8tnLE8p4S/WT7p3dxYkPG3sKixMUSPzvx767gVDE3oPlyhHJ9neC4uGfrxREjixNij2lCJ/l4Y34wKjBEznp0cs8ugCR2y7AkR3wPyGsPlY1MmT0KRs06d2HQUxJfSAT860OEhKLDwLFHgHRdnfMsYHToD2LnFieKOSxy/RSepoqk18COFCOXk+q5akKyYZC0zV73sq4cJw4mCsVG6Nf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ0/hOT7q6+wZcWabDRe6MGkWyThgmjZXDxc1eCdct4=;
 b=LOZNxOuRZKAW2AuRqWkrxAAES9H07T3ls3Cf9P1e9uofW7ognLScpkPglxp86ynuvsK37b2WkEmlbu79TIt+fajViiJdip5VLLCOdWEfwJaeP/MLEGpkvp98quKJhBf2FkgioucVgKOoyfkk+90kwCgwXiF2se3AEUpL6KBkF2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 19:25:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:25:39 +0000
Message-ID: <747bd38a-898f-4556-a0df-a83352cf9e10@amd.com>
Date:   Tue, 12 Dec 2023 13:25:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
 <ef5c74ce-d794-4b80-8d37-4a88de5db3f2@amd.com>
In-Reply-To: <ef5c74ce-d794-4b80-8d37-4a88de5db3f2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0059.namprd05.prod.outlook.com
 (2603:10b6:803:41::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f137473-bcc2-449a-246c-08dbfb481fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vufCkcxdmzf5ubB3olvRp/3ZjvZuwlkHPoZHrp8EKyOZsDoLj1tofIG3/m6tSUT2qjjVczeK1xrJV3CWMiZXtG7YBOxl5SKMRzgBvZj5hC/hovHqvqvFtavNKQAXY1MCfJGYusv8yEfB+BDIasiwNztH5aahZo9D6fpYnJr0oPsyVsGyGs9NwMf3vstO+P1me3Pjj52KB41RS35ZjyzL5FzLPAPpfQkarYy+3BsOj38OrsanNJLCuYHia9WpypWCcG4BXzJaTrDNo72Rwz1z1679GTv8957pob31aUQcYlVke3HnThBY9ayTpBK7+IZFL/2MBvylY99OLvzsUKNobQgaryuE4ZIZz1vSYDVPr8kpP3Lv/aWaPoBGr0GWOi8iYA57h1WkVtOQsoY9I5qQKG27HMrsxXZ6j6IcoNnPncrKbDkmm6YAFNbBxDeyIX6OYlBgAIsOdpr+g316j4N9e9Z5h5gW6PWm/LR76g9drXRqmAOqITnkMndWChwizmZbmeAskaRkrScxKLb9LrH52G7+1oc86/Tc0UAknuoCwiue53HBBHrhg13lEbYKiuS1IN9ndyNTmknYKvV2yNKqptnUJRd+Z5jaqIQH7gXXqnd/3xJW0hp5zpAvhD97sSiK9e6mx3fRzr+y4QO/wgykg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(41300700001)(478600001)(86362001)(31686004)(66946007)(66476007)(66556008)(6486002)(316002)(38100700002)(8676002)(8936002)(31696002)(53546011)(6512007)(36756003)(6506007)(44832011)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdYSG9WRlppNitNUGxRbWJ2RXd3NWlxWGxSRnJLWmkxU3Y2Vmg5VGY4ajBt?=
 =?utf-8?B?cHBCeU5PcFN6TFBqMUZ3QnpNOWtTcnVGKzJMV2FqWWJweWJUU3VPaVA2aWNQ?=
 =?utf-8?B?a0NZMmhkeHMwUURIa2dISHEwYkxoNXZ4YUdWRDcvU05haElHZHdSbGJDbDh2?=
 =?utf-8?B?b1J4S0E2cE1KSS91eXZqdlpCbEVldm90MmVrcEpPRWVZSVRvRlE5aGJmNkZO?=
 =?utf-8?B?VHFxeHlsTHpqQ2RWWGFzTXYxaURVWXRvL1RRWm41aFJmb3cyQzI0ZnZ2NWJO?=
 =?utf-8?B?WmRadDM3dWxwL0J1eTQrMUFpUXNlSGNsdUg2UnJCMGRZSUNsMnI0c2g3R1FN?=
 =?utf-8?B?NUNCWithc1VxRjdNSHQ4M1VGKzAvdnVzek9tTnM0MkZFKzh0Y1l4c0JVa01W?=
 =?utf-8?B?SERIUFRyUEdQY1RPcXUvNXd3dml2RzVtUG01UHRQRDR5ZGFwSmgxY2Y0VWVB?=
 =?utf-8?B?Z1JqTFpOMzFJcWFXV1A3cG5hQVpmTU41R2hrUzFXYUZXMDloRmpiUVV0NFJw?=
 =?utf-8?B?dzlGOUdjTENMYTV3emhHVGFJYWsvY2lRS1I0Z3pYejNJZUtsbmY0VVVORDJ5?=
 =?utf-8?B?U2R6ZTRYa00vVHhxb0ErQit2MU5RR2JZdlVBU0RET3JQMytncTVoNHNrL093?=
 =?utf-8?B?OGp5c2VETGx5bmJrTk4vUEFLM1ZHbERnTGpkcTJyOFFTcFdES2ZTMkZSeStk?=
 =?utf-8?B?aVZuN3hUVlJYdVlMVkRKRmpFenVmVnpjbVpZN21DZDRnQ3oxQTc4R0J4T1ht?=
 =?utf-8?B?Y0VBN3d4UDRNTjlSNXZRMVQ4RzZDeFk3TkR3MzlkQU5nUUNWTnVmUEZjci9U?=
 =?utf-8?B?N3oyNkcxVm1nOHBMRG9Rdjc5WmQ3VktyVVA3dmN2aU9LTURydmNIdWhtNXhq?=
 =?utf-8?B?RWNaSjRjTmtnMVRtR21ua29LMlpUNEgrdURtOXVvMGtDMzNBaWQreEFTSGxI?=
 =?utf-8?B?SzBpUlZwczZ6cktzTXRaQm9HRDlBd0dSTTN6T0J1d1FUbFlhY2p6eTJaVTZ0?=
 =?utf-8?B?QTZkb2JocjZMYnlTUDBWNUxiZ0xrV1dTbE9keE9nMGpEU1hubjJ4djlZWnRa?=
 =?utf-8?B?Sjl5NE1nQk01a2l4SE8waklvNkJvS2djYmxJaitnTGdGNjIrV3JnYS9vZFFT?=
 =?utf-8?B?SlJGQi9jeUhVNGJGQWpzVXZCSGtINSt0REtPOXh1VTkxenp6bWd4Q3FGNXR4?=
 =?utf-8?B?dWlsK1NCS0c1OERlQTNtOThyaXVqaWFWRUZkQjNhdzQ4U0V0cjFaem1aTmNs?=
 =?utf-8?B?RnBpaDFEYXlFVldvQ3E5clROZGN5ZjhrWlNWNTA5d1N4elY3aEp3cFFPOThu?=
 =?utf-8?B?bllacDAzOE1xZFJ4MlA2aDFoVmMycGN5WUovRER2cDFMRWdITmVNa3ZGRTJr?=
 =?utf-8?B?S0R4Y3hPZ3lHbStwT0pRMVNjK0hYc1ZZTU5tUzBHcUNBbkZlRWlvVVd5MUhT?=
 =?utf-8?B?Q3k0bnZEMVdaZDR2clpxZG9vd1M0by9XU3lHVnBKWDluNGdQejgrVjdrUmlw?=
 =?utf-8?B?dTBjRjZkb2psdnFrKzVFcmJuby80RXB0KzhjanZlL1FzUTlVNGczZ3ArWFlo?=
 =?utf-8?B?QVh5OFVDcDhjU0haNEVFU1BoQWk5SUZiWk00V0x5QU10TWJtM0xwR2pGbktB?=
 =?utf-8?B?QVhjUTBVUC9CcWxaZjV5UHRlbTF0VGZTY3M1NHdCMkdtc1JoSERtQXBsYzhE?=
 =?utf-8?B?WVVEZFpLSS9FdTV3L1FKcGFNamdmN1gyTzRWVHFqQkgrM09MSG1KWlZGTm5S?=
 =?utf-8?B?V2pDb0RpL3BKZVNMVnNJeklCVXpJeEFZNWxZRjh6THFxZGdKQ3dJMjVpcks5?=
 =?utf-8?B?RlBHK1A5TnZHT0p6SU1ubW9kYytwaHJFWmsyMzBrTUp5TWNPbG4xdi9rRkNQ?=
 =?utf-8?B?WjVkWDlydU9pa1cvNzU5T1QwQTVQcWhpVE5iVnJmcjdHNzBmY1luTHVoU3hr?=
 =?utf-8?B?WGc2R01QNHlWSS80TmFKdzRFdmw1Z2VjQm5aQzFWdXFzZkJyT0M1WUZNdHFm?=
 =?utf-8?B?eU9MRWJ5ODZaRDNvY2FzN0FkY2xkTEg3MEZnSExvQ3MzQ3ZSWHNyYjlrRTA1?=
 =?utf-8?B?THBuM1I2MWRwU3luY2JqNmhqY0xaR3JYMDhDeWV2TjRGMGpRTDZLR1dRajE0?=
 =?utf-8?Q?yv7KEGZ1/QypGla8ie6EFwJEd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f137473-bcc2-449a-246c-08dbfb481fab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:25:39.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fAXAgymMDiVvEVyM8HUJU8dE+kCCjS8AR21u2yCMyNeIYHHA/v3doDWlZjJ7hM4Kbe6DxCaKp9NSYqPtfp7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 13:24, Mario Limonciello wrote:
> On 12/12/2023 13:16, Sanath S wrote:
>> Boot firmware might have created tunnels of its own. Since we cannot
>> be sure they are usable for us. Tear them down and reset the ports
>> to handle it as a new hotplug for USB3 routers.
> s/3/4/
> 
>>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>> ---
>>   drivers/thunderbolt/tb.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>> index fd49f86e0353..febd0b6972e3 100644
>> --- a/drivers/thunderbolt/tb.c
>> +++ b/drivers/thunderbolt/tb.c
>> @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
>>       tb_switch_tmu_enable(tb->root_switch);
>>       /* Full scan to discover devices added before the driver was 
>> loaded. */
>>       tb_scan_switch(tb->root_switch);
>> +    /*
>> +     * Boot firmware might have created tunnels of its own. Since we 
>> cannot
>> +     * be sure they are usable for us, Tear them down and reset the 
>> ports
>> +     * to handle it as new hotplug for USB4 routers.
>> +     */
>> +    if (tb_switch_is_usb4(tb->root_switch)) {
>> +        tb_switch_discover_tunnels(tb->root_switch,
>> +                       &tcm->tunnel_list, false);
>> +        tcm->hotplug_active = true;
>> +        return tb_switch_reset_ports(tb->root_switch);
>> +    }
>>       /* Find out tunnels created by the boot firmware */
>>       tb_discover_tunnels(tb);
>>       /* Add DP resources from the DP tunnels created by the boot 
>> firmware */
> 
> Doesn't this cause the following to not run and thus break hotplug?
> 
> tcm->hotplug_active = true;
> 
> 
> I think it would be better to do this like this flow:
> 
>      if (tb_switch_is_usb4(tb->root_switch)) {
>          tb_switch_discover_tunnels(tb->root_switch,
>                         &tcm->tunnel_list, false);
>          tcm->hotplug_active = true;
>          ret = tb_switch_reset_ports(tb->root_switch);
>          if (ret)
>              return ret;
>      } else {
>          /* keep existing tunnel flow */
>      }
> 
>      tcm->hotplug_active = true;
> 
>      return 0;
> 
> That makes it crystal clear that hotplug isn't enabled until it's done 
> being setup, which means either getting the existing tunnels or doing 
> the reset.

My apologies I completely missed replacement call even though I pasted it.

Besides the s/3/4 this looks fine to me.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
