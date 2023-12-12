Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93AA80F6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjLLT0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:26:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3294;
        Tue, 12 Dec 2023 11:26:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6QkQfUgxln7YYDAFTinr25vkWOQOZ4tyT/dJJlexGZ1kTuXC+JOy0qrq4S7eH5CZ55jW55vpxAZLXlKQuHWJP6XbGFfr10UnbgvxzHR1vfD82Rmi5A1eVoNDrTNdwubThOM09fnG+1/eYSb/ClF8/9DRqQc5/8Q3qo4K6eQnPlopt5xhHgdv3kdqdL9kwwBWaNAUDQruPtGCf++HHrRNmuZNxjb4SowvI3b+t8nFLvrTSWin1Yt/01cThOg4dtjoA/+DxBn22sfFSx6AR4b5oEtNrxItrORjKXDYjSBSK8YM2Kkbtwuu52NQSkQWwJjj0YNk9Nm8MkDGFer9NVtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO3inGJSiDRL0d0zHkEuvxaMd1/OJaf0jWnSfLbhz3g=;
 b=dq2HJbvffTllbBbY/8hMCfbKU8+WPc08IOU2cU2J45kJYbVDDTm+k2bqu3VEoJrxQQ7ygQvyw71LwUlDNl96LMfx+0B0f4P4tmCJHyd1BaidxLr2OGEAmf7Dfgdv48nNCxEjbJdliPVDBXdaCf+UAxYw/bGDzjU/oOJ8YFfs5f9jzVStciF648dAeDQafjaITrCb+zmsiZfLOwCmFYqdRDjm9COul8tABpwrXbx/vbqBS+ieeORUEAYRZmrZwNl/eeDROaOCDKxb2yLmNrUa18J2/lPqCWjMnfFPYoAEN2+ZS88QRXEeofK2DzQfrP+ZaShfPsE30ISJVH1iNY7LKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO3inGJSiDRL0d0zHkEuvxaMd1/OJaf0jWnSfLbhz3g=;
 b=Ll2Oh7XXAR+l4Y1dKat6WlF3rab6TsX/zaL2kYMwtIQijQD7/ERTHdV8oNC/Pm03cdRA9qlX+09au2bPXmqfn5FVX9EHH6ftYZTXRs6dea/a7p5kBXMBuNEQa5dEefHs8tAOOrmcFz1riMlMX9O586XZ/pipAWipiqi1yuNDqOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 19:26:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:26:41 +0000
Message-ID: <41b0e30c-0dc8-4bfd-b1fc-b01d1421e60d@amd.com>
Date:   Tue, 12 Dec 2023 13:26:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] thunderbolt: Introduce tb_switch_reset_ports(),
 tb_port_reset() and usb4_port_reset()
Content-Language: en-US
To:     Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-2-Sanath.S@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231212191635.2022520-2-Sanath.S@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0059.namprd05.prod.outlook.com
 (2603:10b6:803:41::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cf291d-397f-43b6-5ba7-08dbfb4844bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBGPyyZXya/cWRauOuYdhj6Z4699wbW7HY6Jx+PtnEBxb7fJ36Q6JFbviV2eLNEb02iO0XeU4UhFaBRbyzGce2O+bvHmse2mr9Hhu1YPQa2QmthkrugRwSeHrL9B348yafmR0Nm8pLqcF3DotWiSkXiNMUHVc3gRvggbdocn79h5KRtAhW5VjM1Ahn/DBSwNZIoc3IJIaBqfWTpD6MJurl2S/pQSqGjbPHH3yd/W83w6r/hatYnGyBgHC9sj8NS2LU0YgRPSCn8riMvzVhtdbpcji+TVw2dw+KPE8t+W92GQVehFEgOVgxJX/jNMQIJcfXsDjlB7jpfkvZlxdMRztYcxkF05RnV3/5A0BiFyBni7XK4GaIyE1YLvU/MwHkvjVo9OjAamvmFHvyQC26X5fmcmSMLxht8XG4bcctB7v72AGfxb7TwYbPRfoNsmIDcTmj71iqVJJ076o6ZOhSWHvmOzatEahEsA9LaAyRrvKBHYR+OCklSKnIw38jr2mkX1rL6gbH8xfcuaT9vL7tk5Ibbg5mTGrvbGTPLUEGUWcqaITjBE6XlZlYPtF737TBM8OvRQEAsbd1f3QkDZqiKhA7Bm/AmAXHjh+b8NFgpfk1SG6RiiKHlzWIm7YHY4wXEDgy+DN1J8kC2Y8lVDYa/nlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(2616005)(26005)(83380400001)(31696002)(36756003)(38100700002)(5660300002)(8676002)(316002)(8936002)(2906002)(86362001)(6512007)(6506007)(53546011)(44832011)(66476007)(66556008)(66946007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZBTGRiYWhMN0o4S1pMaTFkcm1BZ01WYVVMcDg2TEw1V1l2SytqNjN0VjVo?=
 =?utf-8?B?K1V0N1RqK1VydHZRdDRHZDFMeFN5V0JBRFdldXVJWVBTL3h6cW5UWUpGOFBa?=
 =?utf-8?B?ZU11WDNLbDFxZWxScVNoK1l0dHNQTjUxQW14WFQ0ZEZMWVpXZmxMZWEwMGVo?=
 =?utf-8?B?OXp0N3IvVEtiS2l2aEt6MnRvcloySjhoU094MEFxM0hMUHlqYmE1bzBxaGQ5?=
 =?utf-8?B?Tk5JOWxlRkx6R0dGUXRPRVFZOW1aQjNwL3R1R1ZpcC9QSjdqWGlTTGdSc014?=
 =?utf-8?B?eERuUHZSaE9ZQ0RtVlhhdWphUXNiYjl3Y3JDSHhXZWNOdG5xOU9yZFA5K3Rl?=
 =?utf-8?B?TVdVNlE4T2w4bG1xUXRGZXFaVmtyVmxpcXM5M242REN6Tk5xZXZ3K1lFUU4r?=
 =?utf-8?B?ZXhRZlNWWFVpdlN0UnprYjVaZ00yeDRSOHlyV1IvOEZkN1ZMSWI2RVpkOHZ4?=
 =?utf-8?B?M291YVlxbnNybk1wM3NVYzUwNE03RHMvRXNMdFFSTlF6ZGVBZXpMYkw5R0tK?=
 =?utf-8?B?bXBLejJHbmhjU216U0ZvcjA4UUEreEhLT3pLK0NncUwrUmhudVhCazdnKzZ6?=
 =?utf-8?B?RGdEVHZ1NHFtaXQxV1IzcHBLeFV0MXFicll6ZGljUStxRDZOYWlSVjVGR1RT?=
 =?utf-8?B?UkpsMHlZcFVzVWo0QVM2RWI2bHhaa052a3hOZGhqTmRpSlFJZkpITGNINGZ6?=
 =?utf-8?B?UTlMQ2tOelh5K05nY1A3M0YxZkJLeWN1eVpTa3FkdE90M29KOVRtemt3UTd5?=
 =?utf-8?B?eGduQUxkeVV2RmZBelZyZmQ4cUFCYTgwNlNXL1hrQXhVaC9sYnFYTmQ5aFVO?=
 =?utf-8?B?SDNMZnp6cUhPN0Z1UnkwSGlZbzVyUXBEK3hKQ1loRGMxUnZSUjNGOG0xdFJ0?=
 =?utf-8?B?VUpLQmtyN1F3bmJZaTVRWlUxanFrYWhab2lzK053MDNVb0RZdFpicExEQlBX?=
 =?utf-8?B?QXNqT0paVGJwS1hYVXY3RWFJY216M3M3cWtMd3VtMTFaOEN5WlJEczZwU21m?=
 =?utf-8?B?V1hmVFp5ZWdhYi9Tays1VVV5VkZwekcwNGJZU2hVZlpzTUM4OERrTlIyTDdy?=
 =?utf-8?B?dHpQdkZ3blRFVUJ4UnVWTCswUHpNS3hDY25nZk5NUlZpczZ4VzdUbjd6NDZS?=
 =?utf-8?B?MkFBU0ZPWDB3TTNRVDNGVXUzaDNTaE9oaEc1cUk2bW5kZlFwVmk2NnUxTDNw?=
 =?utf-8?B?R3FGUllNNTZGTytBZmI3YVJsd25DdmtET2xKSGMwVXpOcytJRVlMQlhUN0Zo?=
 =?utf-8?B?cU0vUnIyNnlzdCtkWE9lbUIyRThWREUrVzIvVTk3b2V6SXlVa3NlQW5tMGds?=
 =?utf-8?B?YXpINE1zaVA4Z2c1YW9aWDBRVExuSHZxSHEzTUdPenErWFBPczg5RVdQTU44?=
 =?utf-8?B?YWtsckh0Q2oxbjhWTzQ2d2dJeVhlTlp3MEZWUVE5NUlVWnhVbkNLdjlnUWdU?=
 =?utf-8?B?TzZqNkdVUGRPMENNN1JqejlvSXJvUWZac09wMmdtWjZabUdpcmxNeG9CSVJu?=
 =?utf-8?B?VjJRQ0NkY2M3bWJ1dm5qZkVZeWdxOEdVZjNCajk0Tk1IQ1FxbENnSDJ5dFB4?=
 =?utf-8?B?MHNTMDJzZXU4Tk9EZGQ0WGNVbGVGaUJFdWtFR043QzNEWjhRVC9HQTF2dlh5?=
 =?utf-8?B?NmN4L2F6V0FFZHo4bE10RGordVdqenhhUlN1TjdtMUY0dWw2VUswZ1AxdFRX?=
 =?utf-8?B?azNWZ3hMS2FWY3dTV0xqcHdqYisrMUlMbWF2ckV2NG55WXF2MkR1WWVIZGoy?=
 =?utf-8?B?dEpqcUdSQ05PNXFWTkhPVmxPTGNmQzdUdzdjYkRhOUN4UitYek5IZGtLMGZQ?=
 =?utf-8?B?TllwQXY3aEp4RU9VcDg2NEJVVk8rK250QnhMbUdGMkJmRHFhLzdwQ1VQM2dE?=
 =?utf-8?B?WER5VWF2YlRZTVJLanpBQ3RDMC9reWlxK1J0OCtDMFpvcUJadlZzdVg0UDJ2?=
 =?utf-8?B?TEt4czRWVjhkb3YxNklBaWVMV2dsaXZwT0kxNXhBbTRUcmcwTDFzdDhaR3lS?=
 =?utf-8?B?NERQWVN0Kzg0aERRVXZCRUhNb3NXbEpCVUdTeUM2ZDJNZzRWL1lqWHlmN2FV?=
 =?utf-8?B?WW01MVMzYjRtUDUxdXhyZmJLODMvZ0lQUEc2eWRrVTl2VC96Ni9na2V2SkRj?=
 =?utf-8?Q?gQCTdD73K2lXi1HfRM99n41bC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cf291d-397f-43b6-5ba7-08dbfb4844bc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:26:41.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51dUodpXWDWl2kE+6uCkDr4HsmqzcFdT0btL8mx4rOilhs9qGvmqLcltjSQmoDHrEMOjEr+U5UERsvKhk+hM4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 13:16, Sanath S wrote:
> Introduce the tb_switch_reset_ports() function that resets the
> downstream ports of a given switch. This helps us reset the USB4
> links created by boot firmware during the init sequence.
> 
> Introduce the tb_port_reset() helper function that resets the
> given port.
> 
> Introduce the usb4_port_reset() function that performs the DPR
> of a given port. This function follows the CM guide specification 7.3
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/thunderbolt/switch.c  | 35 +++++++++++++++++++++++++++++++
>   drivers/thunderbolt/tb.h      |  2 ++
>   drivers/thunderbolt/tb_regs.h |  1 +
>   drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
>   4 files changed, 77 insertions(+)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 44e9b09de47a..ef7ed92fd48e 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -626,6 +626,19 @@ int tb_port_unlock(struct tb_port *port)
>   	return 0;
>   }
>   
> +/**
> + * tb_port_reset() - Reset downstream port
> + * @port: Port to reset
> + *
> + * Helps to reconfigure the USB4 link by resetting the downstream port.
> + *
> + * Return: Returns 0 on success or an error code on failure.
> + */
> +static int tb_port_reset(struct tb_port *port)
> +{
> +	return usb4_port_reset(port);
> +}
> +
>   static int __tb_port_enable(struct tb_port *port, bool enable)
>   {
>   	int ret;
> @@ -1547,6 +1560,28 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>   	       regs->__unknown1, regs->__unknown4);
>   }
>   
> +/**
> + * tb_switch_reset_ports() - Reset downstream ports of switch.
> + * @sw: Switch whose ports need to be reset.
> + *
> + * This is applicable only for USB4 routers.
> + * tb_switch_is_usb4() needs to be called before calling this
> + * function.
> + *
> + * Return: Returns 0 on success or an error code on failure.
> + */
> +int tb_switch_reset_ports(struct tb_switch *sw)
> +{
> +	struct tb_port *port;
> +	int ret = -EOPNOTSUPP;
> +
> +	tb_switch_for_each_port(sw, port) {
> +		if (tb_port_is_null(port) && port->cap_usb4)
> +			return tb_port_reset(port);
> +	}
> +	return ret;
> +}
> +
>   /**
>    * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
>    * @sw: Switch to reset
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e299e53473ae..f2687ec4ac53 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -797,6 +797,7 @@ void tb_switch_remove(struct tb_switch *sw);
>   void tb_switch_suspend(struct tb_switch *sw, bool runtime);
>   int tb_switch_resume(struct tb_switch *sw);
>   int tb_switch_reset(struct tb_switch *sw);
> +int tb_switch_reset_ports(struct tb_switch *sw);
>   int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
>   			   u32 value, int timeout_msec);
>   void tb_sw_set_unplugged(struct tb_switch *sw);
> @@ -1281,6 +1282,7 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
>   int usb4_switch_add_ports(struct tb_switch *sw);
>   void usb4_switch_remove_ports(struct tb_switch *sw);
>   
> +int usb4_port_reset(struct tb_port *port);
>   int usb4_port_unlock(struct tb_port *port);
>   int usb4_port_hotplug_enable(struct tb_port *port);
>   int usb4_port_configure(struct tb_port *port);
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 87e4795275fe..d49530bc0d53 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>   #define PORT_CS_18_CSA				BIT(22)
>   #define PORT_CS_18_TIP				BIT(24)
>   #define PORT_CS_19				0x13
> +#define PORT_CS_19_DPR				BIT(0)
>   #define PORT_CS_19_PC				BIT(3)
>   #define PORT_CS_19_PID				BIT(4)
>   #define PORT_CS_19_WOC				BIT(16)
> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> index 4277733d0021..c8a4bf33ed1c 100644
> --- a/drivers/thunderbolt/usb4.c
> +++ b/drivers/thunderbolt/usb4.c
> @@ -1073,6 +1073,45 @@ void usb4_switch_remove_ports(struct tb_switch *sw)
>   	}
>   }
>   
> +/**
> + * usb4_port_reset() - Reset USB4 downsteam port
> + * @port: USB4 port to reset.
> + *
> + * Helps to reconfigure USB4 link by resetting downstream port.
> + *
> + * Return: Returns 0 on success or an error code on failure.
> + */
> +int usb4_port_reset(struct tb_port *port)
> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = val | PORT_CS_19_DPR;
> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for 10ms after requesting downstream port reset */
> +	usleep_range(10000, 15000);
> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~PORT_CS_19_DPR;
> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +
> +	return ret;
> +}
> +
>   /**
>    * usb4_port_unlock() - Unlock USB4 downstream port
>    * @port: USB4 port to unlock

