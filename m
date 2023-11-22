Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0917F4B64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbjKVPp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjKVPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:39 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5730DC;
        Wed, 22 Nov 2023 07:44:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT90D8BHI9CIg/0v0/m865m65CHfpxO//ch98k+NUR2h/b30P+WFBednnzgyAXoILbxvOgXznnKATFEheuXeps5jboImlT5p1r8fcYKMBgqmsyxY5C1K5S4QE/RrxXb+2g8iTrOcaP/v0Ijs+XzvKsOvL5leFLF/ss7+mgFqB+nzgKVRArPPtTQ+86Uf45IGPdBaU5nCfnM4QEZWPmOKiEpQ+v4eJ7JH4ipvx8eoUdMDCwKpQNCRKkBf7bBpwUtJscyLb443LI94DKKjYBphgn7SaICGciiko8qphX4EbtIczN+ORJwi/6itGEuE7vy2lE7gZ1LE8MONJeYmUZRbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6fYNaEvsQL/sHqMeyISgeCO5CK/jDWrsUZMAa083OI=;
 b=P+mSEqZEIlT+gSb/Nq8EaqpdgrO+nPLxpbT5N6dISeHWdgLneUAyT3EJHfP8IuTC+68/RgUhJxE3NIzawQ2i5GHEGRm9Z7pnP12mxmYiRKjs9SPsy/7vK3L0CHbGkrDPlhez9FbmYgk+WAShZJPmJlLUvm0h7lBGXdwBMjnF1mNhBQFxb/o2Aqy/OEyTfbTy5WSlUPw3xwH+80vc/nFcPmYi4piLlPd8glOSA2UimV3KqMo3jZNCxn0FhXNDSxknZ2BP0fcTgHEmfDvTxqCyVe3HB4CCeY3daDmlbfbQ9bfz1zXRdzeTEMZR+4FNjpid2LzeiH3ovuNT3DbLvMtKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6fYNaEvsQL/sHqMeyISgeCO5CK/jDWrsUZMAa083OI=;
 b=KxrxY4lXiW7IalSGEGm4CVjMqIJ+7vtQLlb1nw/vJ7nCQgK10Neqr2bY8hZx+FJH/nbRS9/PEA8p2XBw0Gxs/Qzw65TBNWT0C+xWc39eagyur2IsW9PvbkrTWbfvYyfdW8Iwaxjl+m9Rg/9g6JgIEurhx9F4YeV9op0CWJhvROw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 15:43:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 15:43:59 +0000
Message-ID: <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
Date:   Wed, 22 Nov 2023 09:43:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanath S <Sanath.S@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231122050639.19651-1-Sanath.S@amd.com>
 <20231122060316.GT1074920@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231122060316.GT1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 688c1d38-095e-4016-9a6d-08dbeb71d7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZo1bKpqv4WTmCXknUABnItUtIPEyODVxMszfRgtC+EQqvFRBvHJFs3FpWeQHJSlPNLWjvkWNvoWQ/JmvCmxeTJghRem4Kkso6fuEe9UqlyMwu5WPM5QMMG2E5w8TWLJGvdS+N8rPgX8aBPb4xYEGhUJ/imSPin6GBWA0vAf2G58ma3Uy/8Z5HcLRhSLivnJAZObNf14uGd65ZdpkVDGO9Xv7DnWKxpvqS9JMEX8f66V1lLo0FG2AzSmNL9KMAEA2aVv/wUAEx9xlH1aFT7SrQZ3F4oJYUNG9kZPSrYL1wypouaNRxdbv282NmXJ4eHM2ZOaDd2KM5251xLuxv9qJjN8QN/smba6BxhlbzV7dFrXKeyhgezlsqBvLHB5Og5vqJ+ZSMygF1ebcARzDlUlzytxPZ9UixtZmnMNS9CpwvN/vX0VzN/wQMBL74a5FHPiPQle+LNDVqWiiSoYWO24xau3Tin0XPwnqVvxXTXTmX4EjkGD/76MF5eGlXq9o7Ttyor4Km/u/5mMEO5k6q7xcxcojDIs9V8qEr5PEbdYAiU9mj/dF8Zdv6cS8dVV3pP1fZKusIkAFeBstlo3mfRrS91NXClgpOWgnhZafd3HtA6SqXtw/ye9nQ555pxUELzUFTK8mWS+9dghqzbzKtqFVvRjb+/4anx4LVQltyjAw868gCvwxDnLW+yTldI3ndYO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(41300700001)(31696002)(5660300002)(2906002)(86362001)(26005)(6666004)(478600001)(6506007)(6486002)(2616005)(6512007)(8936002)(8676002)(53546011)(83380400001)(44832011)(4326008)(6636002)(316002)(66946007)(66556008)(66476007)(110136005)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUQ4enZFYWJCd2RhZW9UWHNYMEJLRllVazFzelRvRHZjdWhaaWN2WWhVQUYz?=
 =?utf-8?B?enFJZzcrRndWbzVrYXV3YWtGOVU1OU9Cd20xWFdmVXl5bUhadG9oLzJnN29T?=
 =?utf-8?B?aHNaOC8yQkRsWFZLckw0WUVhWHVpalF4dnhVUHAyNzRxUHVYc2t1M0VGbFJP?=
 =?utf-8?B?VUVmcTFVUUx4a1ROcFRoRWdhdGF2Z29kM1VKTjJ2a2QyV21mZStvbzF3ak1p?=
 =?utf-8?B?NnVwS0hrT0NsU1pBck8rNVJzdFdPNUJqYm5oekhvb0o1SXZGWFkvMDVIRlh0?=
 =?utf-8?B?K2FOeDdTbVoycWIwSlNsU0pjdDhaVUFHMlcrOWZNWG9jK2sybnRnSVk5T2lO?=
 =?utf-8?B?RUV1UkVFNmVGaituWVFRTmlJK0VQOTVNVURueVpnTzJZYTRIbmNDOS9RVmhs?=
 =?utf-8?B?NUtvRXB6eHlKUTNWMlhQV0Q1UkRGL1dDaUFVMUxDMkptaWZ1UXkwbk14dXJH?=
 =?utf-8?B?eVFwVkZqaEZRRmhOcW84SFhKWTZNU2xHZksySGxGL0xVYVo5RjNOSURsZ1ZJ?=
 =?utf-8?B?Y3YwTWtsS0RHc25Dd2xDYjNubTQxMWJaVHU1WjByeEVtTWszWlg0Y25zbjkx?=
 =?utf-8?B?Zy8zU2R1ZVRaRFZWZStsSURaMnB1ZXJzdDhYNkJoRzNEWk1nMW5URmFpQ1JH?=
 =?utf-8?B?SkJtb0xUZWVSZTIxQTB4S3ZIUWFJN2h4SnVkM0VJZUJFVnpCTkxVdGpWeUJi?=
 =?utf-8?B?UDVvY3ZaSVFnZE9kRTRTbEo1eWJmRkplRzFuOGM3SS9mMm8zK1BBQ3JVYlNl?=
 =?utf-8?B?TlAvM0lCdzYwaTIrQXI5ajd2bHJUc05ZOTdIeHh6RE9MUXJzZHFKRUdPWFg5?=
 =?utf-8?B?c1N4Z2kzeGQ1dTNnd3ExS3dTc1k1YTB4WDVEc2hKWHNTY3VsQlArVkFNeXo5?=
 =?utf-8?B?UXM0YlRWSUxVeFVUdDRjcDhGWE40RFZxaHJHT3JHWWh0THdFTE1jWm9RUE1P?=
 =?utf-8?B?MTk1S3AxUUI0T3NNZWxGZk9UdnhYUWhqVXRGUjZQUHJMdnd6cy91cTFvZU5C?=
 =?utf-8?B?emFyNEFicjhMS25scjBWb0pXVGgvRmdLM1A2c3AzTEVFZlB2dXY0dzNZQ3BU?=
 =?utf-8?B?aVVvWGI0RWM0SU1OUitCVG12VmF5NXVrYkhsb3FXc2xlOW85dm96SDZ2U0lm?=
 =?utf-8?B?a0FPcnowZGhqZ001ZXJNMHJDUWh2Q09RVUYvcUQ2bzYzdnE2dHVqakZRcGxB?=
 =?utf-8?B?cVI4SFFpMFdqRXBKOHJCWEJQK09NUGFCV3c5MEJodXlkdHhLZzRDbjR4QnJj?=
 =?utf-8?B?S1FRZ0FxaFJmMG5PK2F6Rm8wNm9NRkw4dTJjQTVDZFg2NUF1OE0zajk2M01Q?=
 =?utf-8?B?VHFIZmVNM05lbGxjTStrWXNVcmk0eUlBNm5VUTM3WGVyQXdlcTVicUREY1Zm?=
 =?utf-8?B?TjVqb3grR1lkU1dYcmY4S0daelY4OGJBV08wWlV0NEpTOFk5WlNRaE1qY25o?=
 =?utf-8?B?RzFNZlVWb0FmaGF1UE1oWS9Hd2FyK3g4L3lvVWZmUTAyMEdiOFJDNVRoVWNV?=
 =?utf-8?B?a0wwUUVlejl4Q3Q3emFaU0xDdW1wZlY1MmNWN1dlaVJXK1NPUzVIZFlETWZW?=
 =?utf-8?B?T1F2Z3k4QVJTU1AwTzNrbGNuSWlDRFBQbEp0aU9Udy82eS9xZWhaYlFKZnV2?=
 =?utf-8?B?UExtYTliM0FYVmwwREt3KzJwQmsrSnlLT2hNRDlGYktmMUlYaktVNElKZGJy?=
 =?utf-8?B?WVQzNVoxd3hDNDNPTUx3Wk1SQjF4dTEwL0NqRE1ZUitlU0VDdkR0N2FuMVFK?=
 =?utf-8?B?b3kzd1lpdHJpQjkvMHZmckZON1JIbWtXUWpnZUlnNVpuZDNLTUlKVXRraFNp?=
 =?utf-8?B?Sm1QUllSSjNFSUNFSWF5SjBRWkQvTmNnR0N5dEdPUXBwRS9lbnEvU3Y2SzRl?=
 =?utf-8?B?akVwVzB0TkxCbVJNOXJHOGdEZzJLTkxWbzd4VGMrRG9GQkhFdEhOSytJdTVn?=
 =?utf-8?B?U08zdFhLS0E5RFN4WWttWlcxKzVWYlIxdDNqVUhsS3RrUEREQzVBWDNmclZa?=
 =?utf-8?B?WE9HSjdUVE4zd3lEQWh6UjNOOVJ1WjFOMnJvbnNNS284NjVBb0xnSnR4TXBI?=
 =?utf-8?B?b3c3VlhCbHo0RTR2WXFoTjlsSTF4Sll2UnVIclFKMGhHMW9YWU4rbFYxeVR4?=
 =?utf-8?Q?Cpl7BS7iRJavGXDWzYP6vMfd5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c1d38-095e-4016-9a6d-08dbeb71d7db
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:43:59.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxacIomp1oOp70xWw/j60tJK9blfKSONbNokqbvr0JICZ0KqGvndTo9uoqCHRUHQnIGuC9YzJZ1eAwjukoFFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2023 00:03, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Nov 22, 2023 at 10:36:39AM +0530, Sanath S wrote:
>> Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
>> very minimal buses for PCIe downstream ports. This results in
>> failure to extend the daisy chain.
>>
>> Add quirk to reset the downstream port to help reset the topology
>> created by boot firmware.
> 
> But this resets the USB4 side of ports, how does this help with the PCIe
> side? Or this also resets the PCIe side? Please add this information to
> the changelog too.

IIUC the PCIe side will be implicitly reset as well.

> 
> I suppose it is not possible to fix the boot firmware?

It's a really difficult case to make with firmware team.  Windows and 
Linux have a different behavior here.  The Windows CM doesn't take the 
existing tunnels from firmware and instead always resets them.
So Windows "isn't affected" by this problem.

Furthermore there are already lots of systems out "in the wild" as these 
are already both production silicon with shipping OEM products.

> 
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>> Fixes: e390909ac763 ("thunderbolt: Add vendor specific NHI quirk for auto-clearing interrupt status")
>> Cc: <stable@vger.kernel.org>
>> ---
>> Changes since v1:
>>   - Initialize ret variable to avoid compiler warning.
>>   - Add Fixes tag with commit id.
>> ---
>>
>>   drivers/thunderbolt/quirks.c  | 14 ++++++++++++++
>>   drivers/thunderbolt/switch.c  | 28 ++++++++++++++++++++++++++++
>>   drivers/thunderbolt/tb.h      |  2 ++
>>   drivers/thunderbolt/tb_regs.h |  1 +
>>   4 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
>> index e6bfa63b40ae..45e9d6c43e4a 100644
>> --- a/drivers/thunderbolt/quirks.c
>> +++ b/drivers/thunderbolt/quirks.c
>> @@ -27,6 +27,12 @@ static void quirk_clx_disable(struct tb_switch *sw)
>>   	tb_sw_dbg(sw, "disabling CL states\n");
>>   }
>>   
>> +static void quirk_amd_downstream_port_reset(struct tb_switch *sw)
>> +{
>> +	sw->quirks |= QUIRK_DPR;
>> +	tb_sw_dbg(sw, "Resetting Down Stream Port\n");
> 
> That's "resetting downstream ports\n"
> 
>> +}
>> +
>>   static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
>>   {
>>   	struct tb_port *port;
>> @@ -93,6 +99,14 @@ static const struct tb_quirk tb_quirks[] = {
>>   	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
>>   	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
>>   	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
>> +	/*
>> +	 * Reset Down Stream Ports on AMD USB4 Yellow Carp and
>> +	 * Pink Sardine platforms.
>> +	 */
>> +	{ 0x0438, 0x0208, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
>> +	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
>> +	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
>> +	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
>>   };
>>   
>>   /**
>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>> index 1e15ffa79295..1c4b1dd5f472 100644
>> --- a/drivers/thunderbolt/switch.c
>> +++ b/drivers/thunderbolt/switch.c
>> @@ -1547,6 +1547,23 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>>   	       regs->__unknown1, regs->__unknown4);
>>   }
>>   
>> +static int tb_switch_reset_downstream_port(struct tb_switch *sw)
>> +{
>> +	struct tb_port *port;
>> +	uint32_t val = 0;
> 
> u32
> 
>> +	int ret = -1;
> 
> What is -1? Please use proper error codes.
> 
>> +
>> +	tb_switch_for_each_port(sw, port) {
>> +		if (port->config.type == TB_TYPE_PORT) {
> 
> You mean
> 
> 	tb_port_is_null()
> 
> also please make it a separate function, tb_port_reset() following the
> similar tb_port_unlock() and friends. With the matching kernel-doc and
> everything.
> 
>> +			val = val | PORT_CS_19_DPR;
>> +			ret = tb_port_write(port, &val, TB_CFG_PORT,
>> +					port->cap_usb4 + PORT_CS_19, 1);
> 
> Since it is using cap_usb4 you probably need to make usb4_port_reset()
> as well that gets called from tb_port_reset() (try to make it as simple
> as possible though).
> 
>> +			break;
> 
> It is OK just to reset one port?
> 
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>>   /**
>>    * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
>>    * @sw: Switch to reset
>> @@ -3201,6 +3218,17 @@ int tb_switch_add(struct tb_switch *sw)
>>   			return ret;
>>   	}
>>   
>> +	/*
>> +	 * PCIe resource allocated by boot firmware is not utilizing all the
>> +	 * available buses, So perform reset of topology to avoid failure in
>> +	 * extending daisy chain.
>> +	 */
> 
> This comment should be inside the quirk, not here.
> 
>> +	if (sw->quirks & QUIRK_DPR) {
>> +		ret = tb_switch_reset_downstream_port(sw);
> 
> And the name of the function should be tb_switch_reset_ports() or so.
> 
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	ret = tb_switch_port_hotplug_enable(sw);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>> index e299e53473ae..7a9ff53be67a 100644
>> --- a/drivers/thunderbolt/tb.h
>> +++ b/drivers/thunderbolt/tb.h
>> @@ -23,6 +23,8 @@
>>   #define QUIRK_FORCE_POWER_LINK_CONTROLLER		BIT(0)
>>   /* Disable CLx if not supported */
>>   #define QUIRK_NO_CLX					BIT(1)
>> +/* Reset Down Stream Port */
>> +#define QUIRK_DPR					BIT(2)
>>   
>>   /**
>>    * struct tb_nvm - Structure holding NVM information
>> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
>> index 87e4795275fe..d49530bc0d53 100644
>> --- a/drivers/thunderbolt/tb_regs.h
>> +++ b/drivers/thunderbolt/tb_regs.h
>> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>>   #define PORT_CS_18_CSA				BIT(22)
>>   #define PORT_CS_18_TIP				BIT(24)
>>   #define PORT_CS_19				0x13
>> +#define PORT_CS_19_DPR				BIT(0)
>>   #define PORT_CS_19_PC				BIT(3)
>>   #define PORT_CS_19_PID				BIT(4)
>>   #define PORT_CS_19_WOC				BIT(16)
>> -- 
>> 2.34.1

