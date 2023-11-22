Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA27F476C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjKVNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbjKVMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:55:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31533D7A;
        Wed, 22 Nov 2023 04:55:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+R6KrFTsec6eYZBP87jvW6+8mrY/S6W8DNC8UutDE1ewXXmPxR7NMt1Fl3p+M224NYQerOtHUKbV6Z2M3/VICxrnFlOTuA16X9B+QoyBVC6opqsnhDpnHndnde1iEh4HRK3dOPsQOtbdH+lu9erkAPYT3S0/0Fm2dMcRgR5UvM4h5ehUVVO1W4JOM6GxsXlOMmpW08/XfVxJzbxynemKEN5UaonGOKKMd8QaaUoMWkKQthjE1XQos1tbkBzE3zwYQ1CD23+YW7bqDKeUjo2VBql7ymtkwWWP7Cp5iAVcNa3KW1+e6pxbl5Uy3XBnpGucQDza0AQcYLzz0hXxBtPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmO4T8d7DZEX8iTwukvKw6VvBoyloUQuRlLhBuYaWek=;
 b=XRSbExyt9ydV9tSqKClew/ua5p9c9yBMOYmHpbqDvdGG06dpKRb64F9aPy0rphGwGq+4VUfgwis6TKz3k6KhYmxlax0EnvIg33EqSINpFFEWF+aA2Tm54rEVkpMr+QXNa4ThSuh/oOIzx92hG42jzpM1lC74XKSsS1dhnZmelOhZep/UXEx/5XJqrv5U+po7LzztSzouj8lvHj0HUTiGqxzyeQoGVNyZ7kynfmZ32tbismlfVFF2D6UOa+W0hjNDb5yc7VSH3Mtct/WhJBdFX7pcFsDfBbhwBLPI7VTolTLqQ+HLUqF+XNTq6WA+xtEGA8hC7iIExRfG/6Km++Vpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmO4T8d7DZEX8iTwukvKw6VvBoyloUQuRlLhBuYaWek=;
 b=Cwc4M1iym/zi4zAWjc75z1cvRpXl9mIO01cBLOn3D36uprJ2Mvxvd0pzV0j/VcYFyeVzyqbs30lZIDC9XfFSDz8tDD+YtorHMIHY1ETmZ4Wf7sAbGuzTggFvYPP8/T6rpyS81Zy9nFuUjH/Qm1dDhSe+SmyfCfx+i4OOuyFzv8pS5mPkGkIvJx21JTnygJcNkznmGSZPq97d5/xw6GCHdOKWzIEu8mKbB81CCoawC1Q//5TbLLBXc/r/8kZU0plzRnI8g6iwUFFrxl8EdhluUHbEn+bCpbvVyUJcB9XHLB6WlFI7ml0m0I4jZ1jICnKYU+e0Anh4eKn5T9YwTWIjEQ==
Received: from BL0PR1501CA0027.namprd15.prod.outlook.com
 (2603:10b6:207:17::40) by MW4PR12MB6682.namprd12.prod.outlook.com
 (2603:10b6:303:1e3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 12:55:31 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::b7) by BL0PR1501CA0027.outlook.office365.com
 (2603:10b6:207:17::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.30 via Frontend
 Transport; Wed, 22 Nov 2023 12:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 12:55:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 04:55:17 -0800
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 04:55:13 -0800
Message-ID: <7b4f8911-90ef-8419-78dc-c2bffe9b9a3f@nvidia.com>
Date:   Wed, 22 Nov 2023 18:25:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v6 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>, <lpieralisi@kernel.org>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, "Sumit Gupta" <sumitg@nvidia.com>
References: <20231109183322.28039-1-sumitg@nvidia.com>
 <20231109183322.28039-2-sumitg@nvidia.com>
 <CAJZ5v0jEXYP-V93XJ02cZ8UbMwKei2E27Sc0He0WnKvNXpUECg@mail.gmail.com>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jEXYP-V93XJ02cZ8UbMwKei2E27Sc0He0WnKvNXpUECg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 1284d936-787c-4e02-9728-08dbeb5a4f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XndK1z4wpVWxhCVO50RS8J2dbL1dCQBU3W68mDm1KX0l7mIhr5QaXcmlrPDvdk6xjLKovb++lRDGwRNF8muQoDR4aMo0IkBLtEL/i795XHo3FdGDSoa8APnBwodGyrpvzpUE3V45dyAd3vLl0PsagjoJNZLrhr49srb3kaNIo7Hragzu9jluCjry/masf80bZONPClOQc1gM+ufmsMkSsU9ERty0KGr66SwFSpu+e11fIO7W1KurqQJwPtsRXd45US7PIDBApJYw2MyFaz7YvAmB53hEZudDvhP7zbyDcYhM2NWFq4oVUQmXRuD9DQmc+E6dPvi47CG71E6E8uAb4cs0UHuslmPEZwpNrrsSB2Fh5JYv8Iyg80Ge1HxhoRYSF3/aJLnIxGMago2zXzDt5J6GlALyqgUWkIJuRxwfUMHt6HlE/HpBalNDqVQf2GR2H4VrVF4S+vEGL4Fsg9ED8AFlwz+Ib4zLZrbAsw9H58zoRoBixsvCJCtDrPgFLQcBZ6N1HCCBkcQBNcj6goRyMTIMYSpfvoDxXbO0zWutSiRGsucz8w/Cst5Dmay2WnqAwP0feYNVdrLtpKF0LAdWdriQQHwBJOH8z5zrV6AmriMVYAZIbBUW5EiNhpxYO8y2ZiQMwzVrPKdWnW9Eem9JpBBIoUMIztnv9G8wuFYI2MEf4K/y4KZ6aiuCbfHqq/wIHOczki9PUSno9QKxxA3dcncktq3brKxJMeqAZ2ajIqltSF2p9b004QROYIN6mY0/4U7YrVMyzHnMLNgSqP45toSKaJR+eprzrklN+K3SI5SET6Vs5suDahJRa3F152Ac
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(40460700003)(7416002)(2906002)(31696002)(86362001)(2616005)(478600001)(8676002)(16526019)(26005)(107886003)(53546011)(54906003)(16576012)(6916009)(316002)(4326008)(36756003)(70586007)(8936002)(70206006)(36860700001)(47076005)(82740400003)(426003)(336012)(7636003)(83380400001)(356005)(5660300002)(41300700001)(31686004)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 12:55:31.4986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1284d936-787c-4e02-9728-08dbeb5a4f86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/23 01:29, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Nov 9, 2023 at 7:34 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> From: Jeff Brasen <jbrasen@nvidia.com>
>>
>> Add support of "Thermal fast Sampling Period (_TFP)" for Passive cooling.
>> As per [1], _TFP overrides the "Thermal Sampling Period (_TSP)" if both
>> are present in a Thermal zone.
>>
>> [1] ACPI Specification 6.4 - section 11.4.17. _TFP (Thermal fast Sampling
>>      Period)"
>>
>> Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
>> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/thermal.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index f74d81abdbfc..3b75eb2260d7 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -90,7 +90,7 @@ struct acpi_thermal_passive {
>>          struct acpi_thermal_trip trip;
>>          unsigned long tc1;
>>          unsigned long tc2;
>> -       unsigned long tsp;
>> +       unsigned long delay;
>>   };
>>
>>   struct acpi_thermal_active {
>> @@ -404,11 +404,17 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
>>
>>          tz->trips.passive.tc2 = tmp;
>>
>> +       status = acpi_evaluate_integer(tz->device->handle, "_TFP", NULL, &tmp);
>> +       if (ACPI_SUCCESS(status)) {
>> +               tz->trips.passive.delay = tmp;
>> +               return true;
>> +       }
>> +
>>          status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
>>          if (ACPI_FAILURE(status))
>>                  return false;
>>
>> -       tz->trips.passive.tsp = tmp;
>> +       tz->trips.passive.delay = tmp * 100;
>>
>>          return true;
>>   }
>> @@ -904,7 +910,7 @@ static int acpi_thermal_add(struct acpi_device *device)
>>
>>          acpi_trip = &tz->trips.passive.trip;
>>          if (acpi_thermal_trip_valid(acpi_trip)) {
>> -               passive_delay = tz->trips.passive.tsp * 100;
>> +               passive_delay = tz->trips.passive.delay;
>>
>>                  trip->type = THERMAL_TRIP_PASSIVE;
>>                  trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
>> --
> 
> So does the second patch in the series really depend on this one?
> 
> If not, I can apply it I think.

Yes, this patch can be applied independently. Thank you!

Best Regards,
Sumit Gupta
