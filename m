Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF426782838
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHULtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjHULtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:49:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC538F;
        Mon, 21 Aug 2023 04:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwy+dkImSDaK/yoTu0bQdc7w2hrIWQf+uIr03/5qsHXYob11f1ksTGpz9RU2c4QUIGJbsRk6a3Fb4Pa7+TpuffwSYPPeCj29GS6z5AR2UYIZclar8R534Ux5Jm7O3taL/ys3EaS7uW2EdY3b0Z15zuL2eeMO4smgljqCwfxUYM6wizc1mAv0m3eCY+qGVeG76NLLKV5JIPwO2jz9E2NASkMnd4MNojTq5ubbAmvhjbB06dFICVkknLNPtlJOeKhDeGhS+qkP8cUic4gS0QQ+GXvduMOszWUsgJEM7B8aEx5co6NLkAZ9apVKpwC19sU4Jkjqjc94hAnxu3fpYJquZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ykAsUC68Xk7mcBucf5SP3/ZIrF1zdTsanyH3uJh+1k=;
 b=Hp8PHsXA7pRGvAXax+nIGmHEGb2Z4Nh/MoKtkdKRg7kZOANevZuF3gA592ONHxrbhCfVmI9DUbb0g749uxFEPZ/z7/sVm2mQfhrHv93biaURT50am1aiRyatumikK6LJlJWX+CyjhPORIGg8KHCUfl/rkzGIEF06sK7AJHvvV/6CyFJPUIajrAPGBN5rFlwcE7Hv0VvPIuLwL58TkPQ6S7AdZn8n3O/HSOlRvulxXbws7kANop/Gnacto+lciqXTVclmkyPl6n6HYU6vSPIVsTsqt8aVRCjfEvFw2BM83z0C5I9E2nWzVGRbAtOD13k2cWb/N67f/44kodjzisjYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ykAsUC68Xk7mcBucf5SP3/ZIrF1zdTsanyH3uJh+1k=;
 b=G6fdd5sYW9g+UU3ICp0FKl9FplnlPKA3/q5xdh77yXqYlQD5PeRyJegqBlzg16TkXK4PAZOVdoXm+jRPuTHGQ4ALE6fh0Z7tYaLDpQaFMCR6nM/vI4dSreCoPEC1Ys8FGxy6/Kpx+hO//GShBUJCz+LN3XadOwzdauUiumrZfqf65ad6iI3gYn5qR+JHqANpKgJW3Plu26Ain5EN2UKS1n8yON/ePvme1/O2Bj00WfZW7qcodTHY7E+p9KRdG9pGD3dp4oOIvGouSuz34fbyc1LWaAUN7bRGBXN/t7g2WoiL0o3t8OMrywAHUoXILKl9uC/FT04m+wI5nVzveG2P/A==
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:49:08 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::a5) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 11:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 11:49:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 04:48:50 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 21 Aug
 2023 04:48:46 -0700
Message-ID: <bee0e12a-318e-d42c-9879-16c3e8084e68@nvidia.com>
Date:   Mon, 21 Aug 2023 17:18:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230817093011.1378-1-sumitg@nvidia.com>
 <20230817093011.1378-2-sumitg@nvidia.com>
 <CAJZ5v0gKtwgu=ysdROapfK-pnr3om8zXH_xsP3i=HVqQSs_d-g@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0gKtwgu=ysdROapfK-pnr3om8zXH_xsP3i=HVqQSs_d-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 70591ac8-2b29-4bc5-c1df-08dba23ca0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyBw3J8YeVrrL9tmrbmXnW8+TGmnSGurwB7B2x99510Mak+ceq1jwMNXp5TAXLFzSTfZfMHs5eHzPtBKcaiFD1NzzUXN4VSCokIAZPh4bhh582Ym7PUmdo1UD7uwpyJldhyImHvA0oLbTm5IYFfAj1U/I/ieRmX6tP0iZxCuOjLcFAhV6eKZJQpOUHYuFtaYsylnXDbQgKXwOGHVX7H2Grs2TfGtXabA2yDupQ73zre+Iq9PW1sOtHKdC5rpS4ReIO7wj0zl/aRlRuy2A5yvAVufaRy4Mie7f963T13OHUjcDmuyjH5/PQ9t5PZQvEKbQapds+8llEwxZXAqA109/9hTOEJpNZjPMG82rhFzSPm0D5OiVly6S6ytp2S6dJkqOLNOvYG+3wLIfuGeyaHBDp+rnnN0Db45lyGx+1S+xzxXOYWXG/E+bHIk5oNe4A5YfvJM01svucjH+zQJ2x3OQ2xmjnb5kAhM2vvIIuHxMzIrYuKhl0WEDYUbDIe6cmSrHNyk/CFNXdkE6tBt5y0IoX/Zu5iHqVBf30VroUQ5SUnY9gfijoGrg6dbp4dlcvow+w6YEcwkt6cEu83zm9eiMPfDVTE4wT+Bf+3gZXJL4BBLgHmVrzmj7b8KuDvcC5PyWKhIVzIiMkcZ2033Lqwvb03sdA46/jnSIMx6ESXJRdB7xwspojhjZPVIe4LneY6zxJvE3pzgAzne8gaoED3nRmNWzLUBNf9qyJp1ICtonuNzbwDI+pbqMCdXXutwavyYwFOiB0b11AfPjnjpK1Atig==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(36860700001)(53546011)(40480700001)(336012)(5660300002)(426003)(16526019)(26005)(86362001)(31686004)(31696002)(47076005)(8676002)(8936002)(2616005)(107886003)(4326008)(70206006)(316002)(16576012)(6916009)(54906003)(70586007)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(40460700003)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:49:08.1136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70591ac8-2b29-4bc5-c1df-08dba23ca0ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/23 00:03, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Aug 17, 2023 at 11:30 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> From: Jeff Brasen <jbrasen@nvidia.com>
>>
>> Add support for Thermal fast Sampling Period (_TFP) for Passive cooling.
>> As per UEFI spec,
> 
> You mean the ACPI spec I suppose?  It would be good to give the
> relevant section number and title.
> 

Yes, It's the ACPI Spec 6.4. Section and title are "11.4.17. _TFP 
(Thermal fast Sampling Period)". I will add it in description in v2.
Thank you for correcting.

>>   _TFP overrides the "Thermal Sampling Period (_TSP)"
>>   if both are present in a Thermal zone.
>>
>> Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/thermal.c | 21 ++++++++++++++-------
>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index f9f6ebb08fdb..5dee3722509c 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -111,7 +111,7 @@ struct acpi_thermal_passive {
>>          unsigned long temperature;
>>          unsigned long tc1;
>>          unsigned long tc2;
>> -       unsigned long tsp;
>> +       unsigned long sampling_period;
>>          bool valid;
>>   };
>>
>> @@ -289,11 +289,18 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>>                                          tz->trips.passive.tc2 = tmp;
>>
>>                                  status = acpi_evaluate_integer(tz->device->handle,
>> -                                                              "_TSP", NULL, &tmp);
>> -                               if (ACPI_FAILURE(status))
>> -                                       tz->trips.passive.valid = false;
>> -                               else
>> -                                       tz->trips.passive.tsp = tmp;
>> +                                                              "_TFP", NULL, &tmp);
>> +                               if (ACPI_FAILURE(status)) {
>> +                                       status = acpi_evaluate_integer(tz->device->handle,
>> +                                                                      "_TSP", NULL, &tmp);
>> +                                       if (ACPI_FAILURE(status))
>> +                                               tz->trips.passive.valid = false;
>> +                                       else
>> +                                               tz->trips.passive.sampling_period = tmp * 100;
>> +
>> +                               } else {
>> +                                       tz->trips.passive.sampling_period = tmp;
>> +                               }
>>                          }
>>                  }
>>          }
>> @@ -765,7 +772,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>>          if (tz->trips.passive.valid)
>>                  tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
>>                                                                  &acpi_thermal_zone_ops, NULL,
>> -                                                               tz->trips.passive.tsp * 100,
>> +                                                               tz->trips.passive.sampling_period,
>>                                                                  tz->polling_frequency * 100);
>>          else
>>                  tz->thermal_zone =
>> --
> 
> So this needs to be rebased on top of the current linux-next branch in
> linux-pm.git or on top of the acpi-thermal branch in there.

Will rebase and send v2.

Thank you,
Sumit Gupta

