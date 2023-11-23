Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D217F5820
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbjKWGXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjKWGXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:23:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D71B2;
        Wed, 22 Nov 2023 22:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUYvyKUrgnBMbMka2uhk7aG3PsMqglcXwbAOs49Ap3/SREhn2XJt3yREu3RUAgfCZq9Yco5zRkhLklLnr7/lC1aSxq6T2PyBJ91uuPxJNa+L395CUXzzsxAaJTVR6cjJSVCeYRZaez36RFrd0AEPUCS9IlFQ17zhJ6kLyLA7trKSWzFukhm9YIJYSWK/nbuC6LJVyre032SscW8DilyFoCZJAlaCa9/gcEF1MLhZCTj+/xM18KdnHh7dTK6gNAwipj3edsNgJBYh3zMAu8NLcXiNS92nJXw3g8j4mgbX402glib0yLsZkbt9BJmtPc7qBR8RowSIQoDUrT+t2CZsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMtiebIOUg6G5GVfKtOBT2VrSTwE8zT+dxC/gda5/8Y=;
 b=BU0W9zOjg9nuzO2GzmbH0/lwhfWWA5g5ZiwT3xEiwYR4NJ6yYtSy0vldvQKt5AbZOi/xMtDAt2PrQRfBB/GRfjh8rpnOaOv3yAWmsOjWUoZYFCJ99YWaWC+1pIfNIgmuLHvWZn3SoIrGuT3Wi5uahyHzaAPsd68veFjCkGNJCJ5t81zI6VfSv6r/pQJrbnXH6bbNHzeH9ZcGFIwDjsGTY6SNpzhqTuZWVPEiJ94FKi2r68ZdfrKZBkCYgglgF9hv0AQLFKuCWf606IY9BiUYcR6NtLZCBblTa6t/bBm8Oi5IswVG4wpjcWSFxxz7HGHPui/HWwuPj8JGrrcmlDI1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMtiebIOUg6G5GVfKtOBT2VrSTwE8zT+dxC/gda5/8Y=;
 b=af6LoAGvLLzdAPXnf+AKM27zZjBY12PLcL6hA2lRfq5XtANY6utUnc+S6YM9mfFNYRNa55Fp+sB7oEuGqXtbsgI+QsG2Rdyv9+9pgGEt4k6cupXW06YZyy6J5au8nShBq12363apdY+qFG1+Lb6HcD0iFEeQdlE3hvSsjHWuhPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 06:23:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 06:23:40 +0000
Message-ID: <1687d5aa-3c79-4bbf-ae4f-891208edab9b@amd.com>
Date:   Thu, 23 Nov 2023 00:23:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanath S <sanaths2@amd.com>
Cc:     Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20231122050639.19651-1-Sanath.S@amd.com>
 <20231122060316.GT1074920@black.fi.intel.com>
 <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
 <efb152bc-fd17-a374-4303-20aa9bde698d@amd.com>
 <20231123060516.GB1074920@black.fi.intel.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231123060516.GB1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:806:122::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CO6PR12MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: a209ab72-93b2-4a3c-23e5-08dbebecbc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuHsfXB4Xa0fccTZhoZbz+/N9wPq4ZngBU4/fbtWkiDusS7NEIkRRsfLrU3/nLaECYAMwM+SAukLxg0aG+Sw5HXJQb1OqkU7rbzqxvgudY0wmNJhX+tCAe5DbiKHVfmKl7nTPyMKVwD8s9zRDg5RwEjgJdSTe7Mjj25j9eektAM8dTeYMONyhuLkcmFiC8hVzrfkS04oukIxqtfJedgV58Hu7XYMmcOHyf/nHMqYsaTnEsb2ydTwiDCFtap8+tGlC3Rd4ihK3Rq0OZjz2V4pwhnskP0YwPxDXLjrMyQ0bZu6Lh7+sS2KmgW3w6CuFrQoCA6lkkUkybQ4FKiAa8ULPg2rzUQt0YLvQwMVG5/M4LnhMQNmpdUZXRbuupPsudTkeodnfT1hmmmwkuvKAIKwRxcseu07VXKt2boyBizMZug8sVT1r9UvKJWGrSlVLTTYGacN9cHv7tvPd0Q+VXbOHexY0DN0iV0KfrVbt7d/tExuXmBcBOaykTtnc/JCHkWwrb0LyQF18iu9tzZWBneKC/yfe0JPyAw2u7ijAWjdO3hv5wE83hdLZg6YG03gq0PgmSk1RzPZnFCnACPhJZ/f9euw6gbnMKYDWTmhl0NmoL2Wd8sKIZz7ow1hKdg+0PHIR0BJPm78RNbty4cv/sapGu9NnlBPK0v0ujFbrxXHUr6JGcCEuRapvHJfzvG18ZNt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(110136005)(316002)(6636002)(66556008)(66476007)(66946007)(6512007)(53546011)(36756003)(6506007)(6666004)(26005)(2616005)(478600001)(31696002)(38100700002)(83380400001)(86362001)(6486002)(44832011)(2906002)(31686004)(5660300002)(8676002)(8936002)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmI3Ynd1SnduTzFkMFY3cVNRaldia0ZCZ2dkTm14dk4xUFNBbEhVQmt4Njlk?=
 =?utf-8?B?Nlk5SkhqNmhwOFRpQmJNMTM2VG0zMmR3WkF5Mm1ZWks0ZkdSdkg3V3JZbjdJ?=
 =?utf-8?B?eFk3L0orUnlTWkZKOFhVdDB5QWpIZGtjUmoxNFkzUVJUekwxOVpSb1lEYWdr?=
 =?utf-8?B?RFh3T2tHZFl4b1pkUHB0VHZJV3pJRTJMakc4bmtONklSUjJqVUZ6WS92Uk5j?=
 =?utf-8?B?R0ZxK0F5ckNmWTVZcFg5Zlo2TlQzTDR2WU54MHNBY3BNZ25Pdm5uM3FBb0k4?=
 =?utf-8?B?RU5Pa1RaSjU4K3RiQ3hRRGZ3THU5YjRXK0ZpZlllSHpnMCtqS0hySkdadDNi?=
 =?utf-8?B?Q1hwMDRFcVFDRUc0NnU4WHZreDBucWk0eDFJRTFTalZzZUc2dnI5Unp3Z2s5?=
 =?utf-8?B?QXF5dVE5MVZzT3NUTE1WQTF5KzdJUDlTRXNMbHhjeUs4eU9YWjhhb0JwMEV5?=
 =?utf-8?B?RHhkMmJuQXR3RVRvYU1QeDJiZVBPSTlpUlRMMjF6YWFwaEtsLzhJK0U4amVm?=
 =?utf-8?B?Q3VZWnZvazVzMGM5RG9ZUDFyMVdsbG4wTjJUemhqa1ZyaDZhT2F3ajBrbTA1?=
 =?utf-8?B?S0xJeEpCajZHK3RrWktCNlhTdW9WUWdSNzJPRjZ6STFtQytYYzFTVFY0Vi8y?=
 =?utf-8?B?aUlyVjZKWGsxRnQvUFJhbERSdG1uMUVNRk00ZUdEdGZxTkp5R3h0azRvQlBB?=
 =?utf-8?B?U0RPNDg1azBiR2NHczkreC9OdXNGakFOV2MwYmF5K0plaHZpQ0lpZDhleDR3?=
 =?utf-8?B?cUtTY1JBbGlldUswMnVSTGQzMG11NU1naFV2SG1IazQwVHRaK3YxbGRvaTJv?=
 =?utf-8?B?dDhCYnp3MHVpc2tQcW96T210VCt3eElWeitqNWZFQnI0QktzdjR1U2lvb082?=
 =?utf-8?B?ZzdxTU9qMVpFaTNvd2JKNmhhclBzKzBNRys2dkhJUjR6eGJFQmhmdm1vZXdJ?=
 =?utf-8?B?NFFIUU41Q0RTMTcrYk1SMzBIRGh1V0IrS2NqbGhyMnZ5anJuNUVWOThVRllp?=
 =?utf-8?B?NlFleC82bzVyTWI2N2NIOEVnNEZ2QjgxeGFqMDNpSUMvV3FzSm9oUDVtNGcx?=
 =?utf-8?B?am16V3B5U3ZHL2NsLzlVeEE1RjMrSzFyZGZCYllmcEFNZDYwSG1KdXJsK2FO?=
 =?utf-8?B?L0EwQXJMN1lxOEFHTkxJbWlyMDVYZlFBUFcvem4rcHhtQUFOV0NNQmY1WHFy?=
 =?utf-8?B?Z1plZ2t5ZVBObEJIS2Y1c0NNVkJFendRV2lsVUZ4NGRMRGpNYnhjU2FNdVlj?=
 =?utf-8?B?Q2g2dHE5TWlQczFSdFg2MURFdGNWRzJBM09CcTdiMnJTc2xjeDJKS0JEdVFr?=
 =?utf-8?B?TXV1bkVWYUcvbzB1NnQ5VDFCc0dRRkRSRmhSZDdKT0dKWkVSRk5tR3lKbHJD?=
 =?utf-8?B?MkNDVi9CWU5NQzlvUEJ5NE9pMXkwaVdjeUVVTkZBYXcrWUNVUTJFcWZUSHNq?=
 =?utf-8?B?Mkc5R0tQUGRNblhIZ2VCUWV4Vyt0UnJ4WHhkajF6Y1JHeHp1YVpFNGdCaWgr?=
 =?utf-8?B?WDJETzIxSmF3VEwyYUQ2a2p4MzRwZk1ZejlFTGVuNnd3OXhoVlRicENqU3lL?=
 =?utf-8?B?YjF3TW1mSU5wcVdlRUN1OEJWS0sxaHNlbDRHZWU0dml0U2ZPd0ttc3BTa01l?=
 =?utf-8?B?K3dMSkFVSHdoRVc3NzRxUDdPODNWUFFEd2pETEhhZmhlTDRmTS9IZXVUdWRU?=
 =?utf-8?B?WGRSTFNZb29uSnlRZlIrY1NDK0tsc1RxbDhGU3k4T2Zjdk14NnJoNk9sVGs3?=
 =?utf-8?B?MlN5NG1CQ0JlT2NySFlmY1VHUEtoakk3LzJ3ZEd6K3FHd2pLUDhDTE5VUnVm?=
 =?utf-8?B?Vks5bWJHb0ZSMUh4ZWtTV2NBZ2tYQXhiVWd0cVlWcHdoRDZVQ3ZQcmxlYXVs?=
 =?utf-8?B?QzhyLy8rdVZGd3JKN2VTMER3S0trVEFOS2thY3lTQWZNWVp2QVYyS1R4aFVS?=
 =?utf-8?B?MVcvcUVXcnhhZFdrUjZkaGdBQVJ1bzNCdCtTSW42bEhLYmoxTHdOdE9rWk0z?=
 =?utf-8?B?NS9Yb3p4RHcvcXpRM0JxYVlxaUw0SUpodU9qckJNaGMzcDlleDJod3VZUkRV?=
 =?utf-8?B?YS9OT3BjT2dPcjJiQVJ5ZE1OM3lBWHdrazQzQ3YrT3hhTEE0TEF5TGtycmlT?=
 =?utf-8?Q?O3SlprQI6G1hbHSd7dTtAZzhn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a209ab72-93b2-4a3c-23e5-08dbebecbc04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 06:23:40.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiGBy/zFmExtZ5FdLjUurklIKvkeS7czW6+K+sTA/pNnIYK8hms94Jc4be3j+BEzBLvElBCIBaxtoJIUExhVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2023 00:05, Mika Westerberg wrote:
> On Thu, Nov 23, 2023 at 10:46:27AM +0530, Sanath S wrote:
>>
>> On 11/22/2023 9:13 PM, Mario Limonciello wrote:
>>> On 11/22/2023 00:03, Mika Westerberg wrote:
>>>> Hi,
>>>>
>>>> On Wed, Nov 22, 2023 at 10:36:39AM +0530, Sanath S wrote:
>>>>> Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
>>>>> very minimal buses for PCIe downstream ports. This results in
>>>>> failure to extend the daisy chain.
>>>>>
>>>>> Add quirk to reset the downstream port to help reset the topology
>>>>> created by boot firmware.
>>>>
>>>> But this resets the USB4 side of ports, how does this help with the PCIe
>>>> side? Or this also resets the PCIe side? Please add this information to
>>>> the changelog too.
>>>
>> Sure, I'll add the PCIe side reset in changelog.
>>> IIUC the PCIe side will be implicitly reset as well.
>>>
>>>>
>>>> I suppose it is not possible to fix the boot firmware?
>>>
>>> It's a really difficult case to make with firmware team.  Windows and
>>> Linux have a different behavior here.  The Windows CM doesn't take the
>>> existing tunnels from firmware and instead always resets them.
>>> So Windows "isn't affected" by this problem.
>>>
>>> Furthermore there are already lots of systems out "in the wild" as these
>>> are already both production silicon with shipping OEM products.
>>>
>>>>
>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>>>> Fixes: e390909ac763 ("thunderbolt: Add vendor specific NHI quirk
>>>>> for auto-clearing interrupt status")
>>>>> Cc: <stable@vger.kernel.org>
>>>>> ---
>>>>> Changes since v1:
>>>>>    - Initialize ret variable to avoid compiler warning.
>>>>>    - Add Fixes tag with commit id.
>>>>> ---
>>>>>
>>>>>    drivers/thunderbolt/quirks.c  | 14 ++++++++++++++
>>>>>    drivers/thunderbolt/switch.c  | 28 ++++++++++++++++++++++++++++
>>>>>    drivers/thunderbolt/tb.h      |  2 ++
>>>>>    drivers/thunderbolt/tb_regs.h |  1 +
>>>>>    4 files changed, 45 insertions(+)
>>>>>
>>>>> diff --git a/drivers/thunderbolt/quirks.c
>>>>> b/drivers/thunderbolt/quirks.c
>>>>> index e6bfa63b40ae..45e9d6c43e4a 100644
>>>>> --- a/drivers/thunderbolt/quirks.c
>>>>> +++ b/drivers/thunderbolt/quirks.c
>>>>> @@ -27,6 +27,12 @@ static void quirk_clx_disable(struct tb_switch *sw)
>>>>>        tb_sw_dbg(sw, "disabling CL states\n");
>>>>>    }
>>>>>    +static void quirk_amd_downstream_port_reset(struct tb_switch *sw)
>>>>> +{
>>>>> +    sw->quirks |= QUIRK_DPR;
>>>>> +    tb_sw_dbg(sw, "Resetting Down Stream Port\n");
>>>>
>>>> That's "resetting downstream ports\n"
>>>>
>> Ack, Will take care in v3.
>>>>> +}
>>>>> +
>>>>>    static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
>>>>>    {
>>>>>        struct tb_port *port;
>>>>> @@ -93,6 +99,14 @@ static const struct tb_quirk tb_quirks[] = {
>>>>>        { 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
>>>>>        { 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
>>>>>        { 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
>>>>> +    /*
>>>>> +     * Reset Down Stream Ports on AMD USB4 Yellow Carp and
>>>>> +     * Pink Sardine platforms.
>>>>> +     */
>>>>> +    { 0x0438, 0x0208, 0x0000, 0x0000,
>>>>> quirk_amd_downstream_port_reset },
>>>>> +    { 0x0438, 0x0209, 0x0000, 0x0000,
>>>>> quirk_amd_downstream_port_reset },
>>>>> +    { 0x0438, 0x020a, 0x0000, 0x0000,
>>>>> quirk_amd_downstream_port_reset },
>>>>> +    { 0x0438, 0x020b, 0x0000, 0x0000,
>>>>> quirk_amd_downstream_port_reset },
>>>>>    };
>>>>>      /**
>>>>> diff --git a/drivers/thunderbolt/switch.c
>>>>> b/drivers/thunderbolt/switch.c
>>>>> index 1e15ffa79295..1c4b1dd5f472 100644
>>>>> --- a/drivers/thunderbolt/switch.c
>>>>> +++ b/drivers/thunderbolt/switch.c
>>>>> @@ -1547,6 +1547,23 @@ static void tb_dump_switch(const struct
>>>>> tb *tb, const struct tb_switch *sw)
>>>>>               regs->__unknown1, regs->__unknown4);
>>>>>    }
>>>>>    +static int tb_switch_reset_downstream_port(struct tb_switch *sw)
>>>>> +{
>>>>> +    struct tb_port *port;
>>>>> +    uint32_t val = 0;
>>>>
>>>> u32
>>>>
>> Ack.
>>>>> +    int ret = -1;
>>>>
>>>> What is -1? Please use proper error codes.
>>>>
>> Ack, It'll be ret = -ENODEV;
>>>>> +
>>>>> +    tb_switch_for_each_port(sw, port) {
>>>>> +        if (port->config.type == TB_TYPE_PORT) {
>>>>
>>>> You mean
>>>>
>>>>      tb_port_is_null()
>>>>
>>>> also please make it a separate function, tb_port_reset() following the
>>>> similar tb_port_unlock() and friends. With the matching kernel-doc and
>>>> everything.
>>>>
>> Sure, I'll handle this and send a v3.
>> Will also take case of 10ms delay as per spec.
>>>>> +            val = val | PORT_CS_19_DPR;
>>>>> +            ret = tb_port_write(port, &val, TB_CFG_PORT,
>>>>> +                    port->cap_usb4 + PORT_CS_19, 1);
>>>>
>>>> Since it is using cap_usb4 you probably need to make usb4_port_reset()
>>>> as well that gets called from tb_port_reset() (try to make it as simple
>>>> as possible though).
>>>>
>>>>> +            break;
>>>>
>>>> It is OK just to reset one port?
>>>>
>> As per spec, setting the DPR bit of downstream port would help us
>> reconfigure
>>
>> the USB4 link, So had a condition check only for downstream port.
> 
> It can be used to re-configure the link but also simple reset.
> 
> Actually can we instead of the quirk in quirks.c add this to nhi.c and
> "host_reset". So that on these AMD controllers trigger host reset in the
> same way Windows would?
> 
> That's DPR and probably host interface reset. In other words tie this to
> the host reset we are doing for USB4 v2 routers (this one adds it for
> USB4 v1 routers and enables it by default for AMD).

Assuming this "works" how would you feel about just "aligning the 
behavior" with Windows for all USB4 routers instead of just these AMD 
controllers and USB4v2?

