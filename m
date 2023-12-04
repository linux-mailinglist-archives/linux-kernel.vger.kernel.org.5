Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B404080317B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjLDL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjLDL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:26:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD31BF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4mEt3mpmjqfV7+QV5PSKqukqxrYdgf0DXGQr7kzfh0ELy7Ymb6b3j1wpEB6KcT13Rtbli9BpCfjWfYnIqgyG8uGgw91oMz3KC+OZALH6SiFhpms0mc9H09bYgyYdQZFkgXsvdNvzGCiImvXvmbD699zYn8w/NZqKPzq+rmAVWRGEoCrMrynTWsXW7e0raMWVVx/ZdjUrjaXKOYjzUojFtyRtm7oKfU3Nq8se8cSUbTsH4yUaWeUaz380514Z7dp2wdb3GqmRMte2TBaLBySY+Kb7yZ6h4C5crmK0zn3I+HcWnGd7oPcglDH+Wtkmrezt0Gnkrln87rNaWA1putxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agXBcYvi1+fM4ggr0XzncoriHtVFUWrPw4qAIVeJYjc=;
 b=b4PLmSVBu5cRiSoeSQWDuqhYWhpmLXGJ2sfBh05QfUmh5+De1+4vB/xvN/hcExuxnxzX5W6rb0Zh8i+HNOnf1vcFB8XtU7A52pOrt85pR72XWLj5lgMtmvkrevfqzHg86iPPBAllXELlB8fPi3z+usFAZtzGiabHSxHl2NKM5a8bsKzal701cAqQcKKpt5cdzusdqP0vy6/z40+gFW7QIZB1NpRAiiB0+jcNLWuzIuFspryLGESbVVC3rSeqIbnyGvWZAPNF6wZMV+LJL8Zamh/HiDYSF74UsBYMftJ4V8RQZaveakEWXHz7NHIrbSr0/wTVsXbgWlPml5mvdLKM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agXBcYvi1+fM4ggr0XzncoriHtVFUWrPw4qAIVeJYjc=;
 b=5N8l3NxO+NS1LE6F01PlT9myAOs7DprSf71pae7qvHbUkbg/WiGMN6vtNUWAeghphnrpWkRuf9y2zlcvKmJl3PY/YG2omlrubvNwERtHGLoqnBR83zNvcJ+4LuZvJHwa2EfqUH/hIHOu0hphsC5ANr7uvKNtKd8v/X+Dolk8nsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 11:25:26 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::4322:824f:2bdf:831e]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::4322:824f:2bdf:831e%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 11:25:26 +0000
Message-ID: <1f55ca18-a9b8-4d91-bea5-4ca690f52e07@amd.com>
Date:   Mon, 4 Dec 2023 16:55:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cdx: add MSI support for CDX bus
To:     gregkh@linuxfoundation.org, maz@kernel.org, tglx@linutronix.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc:     git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
References: <20231116125609.245206-1-nipun.gupta@amd.com>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20231116125609.245206-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::17) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec4d04a-9b1c-48e5-e0a1-08dbf4bbb688
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5nYIrYDeMQnsvmCrHYyxF0mT0xjlpGN8hqXv0LRiArjHpywmoZwQhU5ipdVrh5xpgODRLnDOITgJ5PBoK7+i3B69qDKlLS3p52fmZtTkDBfveZUPd8wHHj1+n4KH7TcBF5zmdwd3YQlRo5cCsPyHlDYPwWXejYSTRWI0Fy2K0t8V7oOEIE8o3Ku4aMPPKHsccVOBryk6QeeD8z5q5PcseoGL0J8fmR/Z37GAilIxJLYwyqDywcxZ1SFPGymkYrD1/HSZXAHgEDidfOecJ4/uEgyjoj0NVKc6U0FPMqH+/cpJGooaeKRJC8IUGB9As5bM5UM4vColXvvHxIO0wfChUCUJn3ANUqpOiLEzB2wqH0r+50Muzg4qbOCyrJf5e9E1OFfgYskhkU7lpN4ra5H1yB8LOpl7JpxmTnEvCQ0Fkn/J5B7JoaPyfg9eVoWUBHqPv9UympHVWuNQXTqBwxCSSfDa1ddGiifby0vacNo+0GcUcbBooH2F8IpQmva94hmxeVpTkyw+9pU+mdzwDocjRmhekvyXQ6sdWrVlqhRQo7NuFZrVWaIw3c6XQpxvdW3bKNujHxdSjRAQv6ID1/mJXqM6AnpYD1Jps2yZyzy+Cj6nfRpGkKlxQcYLYEZbKmT3EBoGLQz5HfCuXH4f/11Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(478600001)(6486002)(86362001)(6666004)(53546011)(6506007)(6512007)(316002)(66556008)(66946007)(66476007)(8936002)(8676002)(4326008)(31696002)(83380400001)(2906002)(41300700001)(38100700002)(36756003)(31686004)(2616005)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFqbEpTQ2ZlTGRBUUpWek8xZjE0Vy9MSnhubG0rbjFkMis3QnJPTUo1QXBU?=
 =?utf-8?B?ZUowQlgvMno2K1lielVsQWtOZHNic3FxSldRNlBYcW5pL25jL00zS290WElH?=
 =?utf-8?B?V0V3QzZzS2VXdU9PR3JiN21tRE45czZBNFphYWtyVFRrQWYwZXV1aUN0eGw0?=
 =?utf-8?B?dCtPTytEWGptaEJHK3lwVFFldmRiZ21pNGhPVEJaRFJaY3Y5Y0Y0RFZWR2FE?=
 =?utf-8?B?SldmTnk4eEsrWWh1UGpSc3A0TUYwOHViMUw1ZXY1eE9FTFRNSTl5NDdFc21D?=
 =?utf-8?B?a1N1U3p0US9EU0lnVDRCUDc5ZjdVYlkrSktsS3RVVHBweHZ2eVp1N0V3NGk5?=
 =?utf-8?B?UXFGbVNrRENsVTdjUUdob2tKcVhhTTA2SmdzWWNsaUw1UkdIdXNSTlp4dGpK?=
 =?utf-8?B?NE1RL3BpS0ZaM2V1RmxlN2NsdDllbVNjZ0lnRVo4Nm5sK2pTZ1hwVTZOUEpY?=
 =?utf-8?B?SE5vQWhQMTJBMHBTUDA5dTVNbW00N2dhcW15L1VFMmtyR0t2YThaYnIxa3Zq?=
 =?utf-8?B?anlpaEJhMWgvbTlSVFdPdWpFNkIySHZnNTFxZmR6NVNtSVpXcVI0OUlsaytY?=
 =?utf-8?B?MXg1cFhFWjNsOWFWQmlEdkxabng2RXpLTzl0OEU5NWV3U0YrcjMralF1MzN2?=
 =?utf-8?B?U3QwTTEzcURaY2hGSDd2a1Bxc3VvblB4Wk1WUUs0VjJ0VW1EaXJOeTY0UkNq?=
 =?utf-8?B?WE5vNnllQkpNU09ZMmI5UkJ5dng2VHpMbVd2MlVZTE5qOGdFL1oyUG5YcHRS?=
 =?utf-8?B?dWNwbmNDd3U2eWRYN2xhajh2aVU1SEcwbHU0Q2xlS0IwVnp0WXJjM29WeFFU?=
 =?utf-8?B?VEhjU2VmSlFkMmFCa1JJeHJ2WFArdDNBdkNVMlhDS3Zab3VvTms3bDRFdkZM?=
 =?utf-8?B?Q3ZGSWFuTDRabHdjOHYrbllkVmFoSlYwd0czVHBxSTRiY3AvVDkvS0M0d3cx?=
 =?utf-8?B?Q3RKR0I1Z2JjN04wVUFFdzBKdWNBS2xPMXpqemFZZ3ZIV2k3YThTSUNPdjZP?=
 =?utf-8?B?WHhRbzF4cEN0MFJseEJJRjV4dGNQbzlmT0F3OXM3OW9YdUwvZTVHU1JTc0dX?=
 =?utf-8?B?amhzVGRDSEZCcldCK2RMN3hPSElmTUlaSjlTamdWdUNiQjhqU0YxckRBblZD?=
 =?utf-8?B?MkM4eHJPVHFLeWRDTFhmUjZsWVZ6MTBaVnlvWkdSNUFGbzh4Y011aFJoTUY3?=
 =?utf-8?B?cHIwOVR0MDBHRlY2OHlnUHpMMEhnUTZoOXcxUDVRRzcxTjBScXo2RGphcmR4?=
 =?utf-8?B?c0ZqbzQzamk5L2t2MlRGLzI0SUgrdk1IMlZXVGN6MXhLMkFUVUhEd1FlbTR5?=
 =?utf-8?B?eW9sWEZWeXFtWmdjZWFneTFxVVRwN05XVnAyUkxYUmpYUVdLSFVaZU5IdE05?=
 =?utf-8?B?MnJtc1ZqcVFYMU9aZHVIUGh6dGlVbjdHWDZETjZFMjhJbUtkait3eGF1V1Bk?=
 =?utf-8?B?dHBzRU42UTlqT2JQZ0pORGZMejlzcm43aHRQQVJ5YkdTbmtZWDUwL0c1SGhY?=
 =?utf-8?B?djUyOS9BR1FRK1ZIc3JreThncGdCL2NEejF2M0NvRmJ1ei9Vd2FraVJuajZL?=
 =?utf-8?B?ekxBa2hDZFgvQmh5WFJrak9TbXE4b2VVbXJDSE1FZFI1Mm5YZHkzZTUyeEdB?=
 =?utf-8?B?ckVkUkpid3YwczkvMDNlbGVLMW82UTZ4QVdGWDFwbWNYYWd1YXhTMVFqQXZ3?=
 =?utf-8?B?VFk0M0R4dDVucDlIR1lPbDhPYjdSNmppRkdYbkVaNXV3V3VnY1ZCNlNWdGF1?=
 =?utf-8?B?aDJHUjQ1bC9RUWpUVzVaVzQxTExFb2YwMGVCZzZHaTJlbEhTMzdRY3kvN2l4?=
 =?utf-8?B?akZQcEFqWDdDcHVnMDg4VVBMMjE5WDREaWJnQUVqdVVuRS9EZTAyaWZlbUFS?=
 =?utf-8?B?cnc5NjNSQTVDeUM1VEFPbjZqRDJiTERLai8yNmswQmlKY200cURFSVBwNUxq?=
 =?utf-8?B?ZTNzY0psYnhYa2ZyeWJ1ZDR6d2xoNTZKcG91QkxVRjBtY1lhUGRUa3hQMlVU?=
 =?utf-8?B?Ym5qMFBZMHVScFlCVDYwenFRK1RyYjA0eis1V0JyVTZXQkVOZW52Yk9aV1Jo?=
 =?utf-8?B?bVBuM0VicW9hWk41SzRrNmIvR1h5NXN5aGk2WjRTVGpsUWFzWVNFZGtCajQ5?=
 =?utf-8?Q?Fz91+KmQFdbgfg2j9Or06cBKP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec4d04a-9b1c-48e5-e0a1-08dbf4bbb688
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:25:26.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEsXjdz62taDKwgZnQNNm67vWpNwKI4zndVuSW3DoQAXLXKlGe6Suro1FGi67nv8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 6:26 PM, Nipun Gupta wrote:
> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
> 
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
> 
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
> 
> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> 
> Changes v5->v6:
> - Rebased on Linux 6.7-rc1
> 
> Changes v4->v5:
> - Use GENERIC_MSI_IRQ instead of deprecated GENERIC_MSI_IRQ_DOMAIN config option.
> - Remove CDX bus dependency on MSI support (CDX can compile without MSI as well).
> - Remove un-necessary debug logs
> - Remove un-necessay initialization of dev_id in msi_prepare
> - Add required msi enable and disable APIs
> 
> Changes v3->v4:
> - Rebased on Linux 6.6-rc1
> 
> Changes v2->v3:
> - Rebased on Linux 6.5-rc1
> - Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.
> 
> Changes v1->v2:
> - fixed scenario where msi write was called asyncronously in
>    an atomic context, by using irq_chip_(un)lock, and using sync
>    MCDI API for write MSI message.
> - fixed broken Signed-off-by chain.
> 
>   drivers/cdx/Makefile                    |   4 +
>   drivers/cdx/cdx.c                       |   9 +
>   drivers/cdx/cdx.h                       |  14 +-
>   drivers/cdx/cdx_msi.c                   | 215 ++++++++++++++++++++++++
>   drivers/cdx/controller/Kconfig          |   1 +
>   drivers/cdx/controller/cdx_controller.c |  27 +++
>   drivers/cdx/controller/mc_cdx_pcol.h    |  64 +++++++
>   drivers/cdx/controller/mcdi_functions.c |  33 +++-
>   drivers/cdx/controller/mcdi_functions.h |  33 ++++
>   include/linux/cdx/cdx_bus.h             |  76 ++++++++-
>   kernel/irq/msi.c                        |   1 +
>   11 files changed, 473 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/cdx/cdx_msi.c

Hi Thomas,

Can you kindly review this patch further?
We have incorporated all the earlier comments provided by you and Greg.

Regards,
Nipun
