Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E086F7D018A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjJSSbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJSSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:31:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297A1AB;
        Thu, 19 Oct 2023 11:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvBtYRx8ZbjD2nlCbDce1jJAMGd9/B5B+8FGeSGxHiOEg5uzgv/kuLxZFjxA1WEG73HtVCrCOL4XHQe7IsaxPGIXfOXRjgzWp5unaOeZ1EH/3A1csloFzHzzI1noP81HdQFsJ6/x9XGuWkQxId+7SynDTFsAQTiwvPaB2fdvac8JdqrVQWfGbBu5p7yaP1NOeUlq+gupcjB3yAhyyOyAI+iQKFpOt8AMKabC9JOXAQoF/gq9tmZzgEU9IV36MuUTg4I13digZAeCzj2i3MCzwxnAWUlncLrzkvbNnusPR5djvgHkANFCxzQYR4OtH94rHIPassApLV/SrVM82vVjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjUmGYF4AFdbLDpqnqS6W4KIjWI780KEo44GHTB6U+g=;
 b=BRW9pROszoDvyPiM4vtiX1NDMHcFjUzJcrbboObsgxoyKk09Fnn7CDsB0CiZYLjQOSTF5fYFrrLGd/KC1OqhB32pQgeOs8Y4m8bMvVuqeTxsza5IrQB6QgvoW6YAuB9okGX0sFRXXTOvVLSXq5Yv4yZiKr8QoT+on4j1MWDfteh4xafn7NI34T7/E2K0cSegN51J1cFpTqY/9BdTFsvnfRCouudB1kztRTk92arXlb2IskJsu0blicQh13qGGZIRzl7rVy0ijKSbkxLLCoHs/uqION57l9ALdSTLj191JTUmxQipW3x/TiXzhTmzqCRZ242c4Kt5E5bad39e5ybMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjUmGYF4AFdbLDpqnqS6W4KIjWI780KEo44GHTB6U+g=;
 b=Vk2+EYiLY5IPQwApuqClLcbb7MhGTwh+X/PbQzfPBBB90fJw2ksa1zHENzChY8CO46PaQRJevxO2gVnAP1/1xTY2ljRvkIXX8QMsPq2XNoKWBHPEgvq9I6ZkW77wPUik6JIl4gBpa1sHix02dJYoSlvf2vTZ39tf/7f/OI7KlWjo2QSZGzRxgjOmvW7QshU3eZL3uKDcAUYzN0i7oRN2jBSNCQGE2SqsGjCNTMJ7FHiXOlYWun+X/42bjO0boO1+MW4PfSMmsfNlwmtyKsx5W+j67vXWuCCtPsn2dVsxygM3zwcxSfVcKSG/SoI59ulsPCIyubSDQdm+uprt1N+oKA==
Received: from CYZPR05CA0032.namprd05.prod.outlook.com (2603:10b6:930:a3::14)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 18:31:13 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::4d) by CYZPR05CA0032.outlook.office365.com
 (2603:10b6:930:a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Thu, 19 Oct 2023 18:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 18:31:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 11:30:59 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 11:30:55 -0700
Message-ID: <4be60668-09dc-d86a-ec22-d5e06381deb8@nvidia.com>
Date:   Fri, 20 Oct 2023 00:00:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v5 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20231014105426.26389-1-sumitg@nvidia.com>
 <20231014105426.26389-2-sumitg@nvidia.com>
 <CAJZ5v0jm5h9qeZdnLDp9qUMT-31FOWMBERMzhFzgFsmt9QX78g@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jm5h9qeZdnLDp9qUMT-31FOWMBERMzhFzgFsmt9QX78g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c9bb04-1f6b-4683-1b4d-08dbd0d192f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXeghd0BtnuRrUL3NPzdBMZCr/CE461vgjeJnC+8WMKYhxaLV7//wcYsTVPNlssqU/xFpwbRBCMlIebWNI0s9OewEceJLC+F4gEY7DyqWFwB+Et31BJ/wkJfTbJblMknZwrsf/F7ZKmflKQGH4zlOYi3g8yDmbC6TagcaU8r0kVWLissc4MR8n8qT9hzBI0x6WwDOs5gDAMjZn8XhyvQbDB08EAwB9KS3orBqNSKdQvnXZeqA4rL1CQrMYFVFdyq4/K016ACQn+8hP+A/sb9ETrWQ4uD8Ri3q1/bN4OwXx+jctHolr4sTlB2ylARiw59AMdoYwIO3y8zPD5+tzUKR3snjSm3JMF0r+YO3fR7zly1bm+Lh3g7OU71n4eGzdlpGOMiHdmrjsuTTSXp5HGtBm6DZiLaqmXNWtLpIH0R4+ivd/RK+ZWlDcc+iY3gbyRD/9RPc2Pi5FV8tKCsmM58H9hYLjHt21flWpKhJhAZ3g+xiDx+dUku7NwmNdTIIs9m0MppnO1pJxMb31OBRGxWH474e66jmOueP9Y56viERBrZDh3GwF61R9xKZl3ktMkcPy8rknr12YvRwSWhvfbVwdORyPvF31NvrKpdmb3oHYTRUU0fl9jnBw0C4gcKUafKyUZ8TvrJv87oQOivYDoLXOUZYyP1O8pzKCE1clVFmZTDIkZGWmU83kwgFhQiOEsJajm+iT0+kl90UOWYfZ6ZqC7+ylxqMbxZdEfGHthPmK8gPZYOZlZFQ+dNzJPH/0oG7ZlI1hNwCChogW6ohL/seg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(26005)(16526019)(53546011)(426003)(83380400001)(2616005)(336012)(107886003)(31686004)(40460700003)(47076005)(36860700001)(40480700001)(478600001)(82740400003)(36756003)(41300700001)(5660300002)(4326008)(86362001)(356005)(8936002)(8676002)(70586007)(31696002)(54906003)(6916009)(7636003)(316002)(2906002)(16576012)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 18:31:13.3083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c9bb04-1f6b-4683-1b4d-08dbd0d192f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/23 17:18, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, Oct 14, 2023 at 12:54 PM Sumit Gupta <sumitg@nvidia.com> wrote:
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
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/thermal.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index d98ff69303b3..a91e3d566858 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -90,7 +90,7 @@ struct acpi_thermal_passive {
>>          struct acpi_thermal_trip trip;
>>          unsigned long tc1;
>>          unsigned long tc2;
>> -       unsigned long tsp;
>> +       unsigned long passive_delay;
> 
> This is a passive trip structure anyway, so the "passive_" prefix is
> redundant here.  "delay" alone would be fine.
> 
will change in v6.

>>   };
>>
>>   struct acpi_thermal_active {
>> @@ -404,11 +404,16 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
>>
>>          tz->trips.passive.tc2 = tmp;
>>
>> -       status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
>> -       if (ACPI_FAILURE(status))
>> -               return false;
>> +       status = acpi_evaluate_integer(tz->device->handle, "_TFP", NULL, &tmp);
>> +       if (ACPI_FAILURE(status)) {
>> +               status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
>> +               if (ACPI_FAILURE(status))
>> +                       return false;
>>
>> -       tz->trips.passive.tsp = tmp;
>> +               tz->trips.passive.passive_delay = tmp * 100;
>> +       } else {
>> +               tz->trips.passive.passive_delay = tmp;
>> +       }
> 
> I would prefer the if () statement above to be structured the other
> way around, that is
> 
>   status = ...
>   if (ACPI_SUCCESS(status)) {
>          tz->trips.passive.delay = tmp;
>          return true;
> }
> 
> status = ...
> if (ACPI_FAILURE(status))
>           return false;
> 
> etc.
> 

Ok. will change in v6.

>>
>>          return true;
>>   }
>> @@ -904,7 +909,7 @@ static int acpi_thermal_add(struct acpi_device *device)
>>
>>          acpi_trip = &tz->trips.passive.trip;
>>          if (acpi_thermal_trip_valid(acpi_trip)) {
>> -               passive_delay = tz->trips.passive.tsp * 100;
>> +               passive_delay = tz->trips.passive.passive_delay;
>>
>>                  trip->type = THERMAL_TRIP_PASSIVE;
>>                  trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
>> --
>> 2.17.1
>>
