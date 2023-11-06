Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA37E19C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjKFFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:55:51 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2233.outbound.protection.outlook.com [52.100.158.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC3112
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 21:55:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9khZm7jek4mfpCiPhtPfC/TXCbAgOUBUSZcDlVzLKujlSThar8IRqQIsQ0vw4iwArWxUh1PLO85n/+kVTA555LpbSnE/zTM+/26XEvd0wiQwSWXGFqTO32fcweoxOIf4eeqIWJUwjUvw07BdTJiZ8XLIFPP3FA1ZaeuzR/x6BUMrizDshvuRWQzQHs75UlW75ql/ECCNXneptcM4tz9Joc6Kk290yfZ+nBxDKqU0dzZlZzhEhwXaNeG2iyQ9KrdOKnpiH28DbJ3coHGbY9fpgOOKvS1b1Do3iu5clFTm66nUThgmn7uvI5oE3LX5Tcvwpwvaz/JIoEElrRrRH+aAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FOGvDM4UR9DUbGSdQMdlbaGmLC3mqq0fuq/ZKYtASw=;
 b=kBk1cCORcWuwci913yt4ebP99UAtmG2ZSnEOul8NyMs41cwBl36nwNQrHHNqIPXm1ZYm/cluYXe+/B3kz8ZfLIQ/ppOYY0wHBBBmBe1TRVDGD2RHpCNKYpm09Y9RPfPEeMfMwpc3nrbdEIDMg5zS+iUY7ozXev4t4lHgvOtXB8vs7x+c5ETU7PXkOtFrJlOlXhS+twOnV3sBlsGyLQhq54HWey/8rGtQSd6SSbEGQkb14DKluP9stwAHVSewUECJXk4VfqpPxGjwSvGcvbASX6xlP7R90YwQY7Nc4UbmBgRfM9+mAMvZij0qvU+xcIGK7+eduDnQypZ0k94emHBZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FOGvDM4UR9DUbGSdQMdlbaGmLC3mqq0fuq/ZKYtASw=;
 b=VU7qiGvXy3cTAjY7DC+cSYAZ40+aYpka4bKc7vgO6z2dLvcrXrFXlHO5sqYTHieF3Sa1nb/Qn1sA5APb78umiARAQdb38+/7id1MI5NGQA37SayS9OEgWelKU4cwTYiqHEUSwrKehCW6UBIrjZJr20PbR/5Ndy3tDitzpVib25M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB6621.prod.exchangelabs.com (2603:10b6:806:1a7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 05:55:43 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 05:55:42 +0000
Date:   Sun, 5 Nov 2023 21:55:31 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Marc Zyngier <maz@kernel.org>
cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit
 registers
In-Reply-To: <86jzqy1z1g.wl-maz@kernel.org>
Message-ID: <7da3bc32-416f-dc21-85c1-4bd3cc82b1@os.amperecomputing.com>
References: <20231102183012.1251410-1-ilkka@os.amperecomputing.com> <6281f889-d665-451b-a864-e2751fce8017@arm.com> <86jzqy1z1g.wl-maz@kernel.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CYXPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:930:d0::21) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a5d80a-3baa-4bb4-76da-08dbde8d02ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4GsF9xMdqIjdtqEjPU1xRNJkMFse6FRB3+zpvHkQGY0hTrpYCew7cj0zRzG9?=
 =?us-ascii?Q?LdZwJe+Sq4xIbveGuFRBuau0/yEv8oMxPaK9fq2Ga4G5bdGh81aaknqGD+A7?=
 =?us-ascii?Q?trM3YCZT3nJgJ3y5GwDJowyqACFQ1/uwIsebNi3u3oboUKHQUqMXefJca60U?=
 =?us-ascii?Q?mGibGPOb99Dr7DzJ4iIEVI0Aqu0D2ipe6KndlN2//fi1H1gLcgKASOlUNWv8?=
 =?us-ascii?Q?beUzHPyyJ3mzHOIXD5zudxLRrrk7Ndta+xJ1ecZLVwLuRq0DeCVPujs1+laW?=
 =?us-ascii?Q?1qQHtXXyuzuDRyXF2hccmU8KDi7VSL41iL2tJYflqjtQC1QWKSWGPOGGE9pK?=
 =?us-ascii?Q?l244a0GClaoznTOZf+QE9NVhlPNIWmPJCfPsuraJ3xOEZjkBYSduI2WTXcJT?=
 =?us-ascii?Q?dQwcIi6EaM6nLND2fZCKADEZlBTsZy6khaUb+kB/JkOGio0MDuShubRgc3li?=
 =?us-ascii?Q?/UK3hF7t/3Y7t33OzjTx51VedgWcIjMuUBAwGOBwFxSuqqR7Nyl4IK9tJCKo?=
 =?us-ascii?Q?m6kk2YnY7zPZCjrV5nBUMMCFLcyDUvAyLCzwpHIXNLEjlI0u4ry9ni5LP0/g?=
 =?us-ascii?Q?14QTiIkk9Mss3z3UZEgwOKH0DmarfbtVlK+TYhKoXwFLWjKQGQUfKB7Yhlrq?=
 =?us-ascii?Q?Y6Va4N52f1xQeX+yeZvTW+VvLdBGEyWrFQQ1DZwreijw91fuhF+J7SM9paEU?=
 =?us-ascii?Q?IWAiRPWA1kRvW8upFLxzaYuo7EX55OyW5KnB1OMiBOO2DxxWoOEi2mtcyNLf?=
 =?us-ascii?Q?TviQM3HX/r7rc7FjCkTElQqoBZighb50iXVUI5pTw66zazgLs3vkYX8xAoH6?=
 =?us-ascii?Q?yOMLWQMg8Ihc05d9hbgLHwDD5HKTAcadn972D1nxLR+IjZHPrDx62yqWp3KJ?=
 =?us-ascii?Q?jDJWo5HoiAsvFhHvVBZOOGXw70EgJAQh04ddocIpnSQiyeueex1xEn1a8dHz?=
 =?us-ascii?Q?OVfzmG1cCCJvoOo5SS7xHmHohcCtXSfBmpIYaSAg4Zg3G9OT2Esq80IzukbX?=
 =?us-ascii?Q?0f/VdLucxoKqjTPX6Uln3UvesM2Zypv8skST+kZUuSjM+6p40cKbVRv2UuWI?=
 =?us-ascii?Q?K15nBxUM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(39840400004)(136003)(376002)(346002)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799009)(451199024)(64100799003)(38350700005)(6486002)(66476007)(6506007)(6512007)(6666004)(66556008)(53546011)(52116002)(478600001)(966005)(66946007)(86362001)(26005)(2616005)(38100700002)(83380400001)(8676002)(7416002)(2906002)(6916009)(316002)(5660300002)(41300700001)(54906003)(4326008)(8936002)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xv088atAVxWnYVsKiqgHPkeuvBx1G26XBg83t8GJOLZnh6qO3nKZDieRoiGe?=
 =?us-ascii?Q?Ja3Rm8J4qmGbH/uaCNz0Nes0uB3dBaNSds8OR25jyeNceTO0blRZ9MNeAtMX?=
 =?us-ascii?Q?XxmrQk+9h7Y+/kEpIbjzWFpwuLhsM0QjIAk8dtXx4ZeZI1HecU4gm6nqnHjI?=
 =?us-ascii?Q?RlperCH5CQwyNL+cMR3P/hWLIjhPuOv6vgbKjDx8cXqNqEvJ7fnDDxXSzuZO?=
 =?us-ascii?Q?9Hr7SBwpdTD/BSIqvluO6p1rhYt3yEvVu+PbJW1oUUz8rMdQ9EO3cmtkkSa8?=
 =?us-ascii?Q?VGoyXz5vnGdNKVmKk3QISFPsQI3Vyg3Eoa5wdSM0tMdetZtYm4iuNETw8q4E?=
 =?us-ascii?Q?HMdKpi8aodcFntsT9sn6m+mznJONDNy6nxkFM5IQPLEHRNpdw/ZKeBPI6KHA?=
 =?us-ascii?Q?7I7k40WyP3UNE4gaTP8MnaHX1XmwvD665Mhg9KGPV74AX8aiISChTKB6mEdG?=
 =?us-ascii?Q?pKZKygnfyqzISH3aWAC/dVA3lNNS76TiT5xuj7XJJBBO8ps9uQ5etdwILirR?=
 =?us-ascii?Q?FXK0h6DWsGVIyTCPajG4TJ0h6FmsVJjwlJHIvdPtYtoDx4Bx88Cjh6F3ZZk/?=
 =?us-ascii?Q?r4pw7PG0e3tjv9xvyT1XQWkcm5YXZ+DX03ReX5uFvb56s4uWIa74aXEHGv4T?=
 =?us-ascii?Q?QgIte5EKBYuhGdSKMiKQxPEZpAgoDzu94YA/Df3Zzz2X2pGaoqUUF4a3PLU3?=
 =?us-ascii?Q?qlMl9JDJljPzFtSV2qdY1TrrduseDhIy0TewMa2SsddYZW+jtvdcLJXKAwCI?=
 =?us-ascii?Q?li3dlTtGgXvcl6+l6uyJ8QNd0vGy+JrEo3cyBrhXiZpWEnaYysSXZ7TIUQtk?=
 =?us-ascii?Q?kWKOp7SZiZCzqXi2t1DliN6Sl7zPqBpgXRDVqc8UFNPp9AtK+ZoiZSAdnU1/?=
 =?us-ascii?Q?wKCRAFoLKGEJB9IA40fiZw2SdenSpN36WK7wIJbtR3Ne0R2fPh0P8h7Gycrz?=
 =?us-ascii?Q?bK80125ZUennPXe1YOIaArsd0OhUIFu0aHumtlp6Xc6niqcJ5++wi+G+5kF2?=
 =?us-ascii?Q?Yl2IOpzi5mnlwH4hUUHuvfoNih6fIaXC6QwS/+CpfY+i+0F2Pr26igqzy8qH?=
 =?us-ascii?Q?dGtTJB1eMA3Eoz31TIvLbcS4pe+QlJjoEZBB2KBOEEXi11iOe90CvooPuPw3?=
 =?us-ascii?Q?4qFm7kaIMYi+5QUOIV9ZZ/clnMOLNeXo7A7Qh4BjjZ9Z8a1t5zEy+jQgTuaJ?=
 =?us-ascii?Q?xyCzYbdO1N6W0URqhOZv2aVjnNvHBhkILGRErUKkn9GkkcIWL+AW5FCFllc/?=
 =?us-ascii?Q?xAQRh7UI4LWw2gsbmK6Prxz+9NBK4EMNNQWIHHb5NqR5AcWLtSiJjPkkPCcc?=
 =?us-ascii?Q?9WBC1MhCvBX+lzyhoj1GxRFzOK7H1SGGu/HMuoOacnMhUSIq6KI+fkvcfnWe?=
 =?us-ascii?Q?NGIO5sI97gWddmCIXfh50UTu3fHEaYn8AChW+1OcS+F3zgQbax66XVburNy9?=
 =?us-ascii?Q?Zxun3sZ8W22nl+Go3nncBmiVpx/afPu0xBtjqBWCzaLsTyWTH5bdj4MFTGLJ?=
 =?us-ascii?Q?CKZBrg6Mu203xV7H4ORNwzz7U2gwDXueeedwDsJnnemr2lYSaFiBB5/TdzgV?=
 =?us-ascii?Q?3n6/BO977rhzk8uMboo2XBGiHDDdA9Y0lEM4iZw6GIBGxCXoEmFP3qN7jdNz?=
 =?us-ascii?Q?HzcsSo6EKETwX6VJG5ONdFU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a5d80a-3baa-4bb4-76da-08dbde8d02ea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 05:55:42.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwwNx8+/9byXIObwQXLKcsWCZkHj1CFKpq8zt0aqb6rWtyFwb/LUbRxiSyaG2842oiGj4Q/VIa6vkheGpnwyy4/er9dKI34CXMB88Xbw3IqRLD1XgHYFIf7ZLQHb0p5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6621
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Nov 2023, Marc Zyngier wrote:
> On Fri, 03 Nov 2023 06:09:36 +0000,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 11/3/23 00:00, Ilkka Koskinen wrote:
>>> The driver used to truncate several 64-bit registers such as PMCEID[n]
>>> registers used to describe whether architectural and microarchitectural
>>> events in range 0x4000-0x401f exist. Due to discarding the bits, the
>>> driver made the events invisible, even if they existed.
>>>
>>> Moreover, PMCCFILTR and PMCR registers have additional bits in the upper
>>> 32 bits. This patch makes them available although they aren't currently
>>> used. Finally, functions handling PMXEVCNTR and PMXEVTYPER registers are
>>> removed as they not being used at all.
>>>
>>> Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
>>> Reported-by: Carl Worth <carl@os.amperecomputing.com>
>>
>> This needs an URL for the original bug report in the following format.
>>
>>     Reported-by: Carl Worth <carl@os.amperecomputing.com>
>>     Closes: https://lore.kernel.org/..
>
> A report is not necessarily done in a public list. And yet there is *a
> lot* of value in recognising the reporter of the bug.

Thanks, Marc. That's exactly the case here. Carl reported the bug to me 
internally and, therefore, I can't provide an URL to the bug report.

Cheers, Ilkka

>
>>
>> Otherwise, the following checkpatch warning shows up.
>>
>> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
>> #17:
>> Reported-by: Carl Worth <carl@os.amperecomputing.com>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>
> Checkpatch can say what it wants, but that doesn't make it true.
>
> 	M.
>
> -- 
> Without deviation from the norm, progress is not possible.
>
