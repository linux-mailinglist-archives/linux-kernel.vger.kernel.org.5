Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AFD80F119
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376869AbjLLPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376659AbjLLPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:32:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA0D3;
        Tue, 12 Dec 2023 07:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiQitxJHv5N8Le102APORQc1XcNB2v+7LTykPWUxgYHuS62S5BiKoqxMcrYQ4v0+4e3wkRdN/6zgxg6hMt70kr7wgWVoNz0wqjFBvLGGTvWOQJqmiTzIgB1YhufRP2juPCAr4tssUyouPX4FBqTLgxZ1h7uR6Pe1R2OleqerW51HK9HGicdf1knE2y7JfqO6Vq/YJBA/3NpDLuqlmEXsmtj9dB7BbE9pHXzh3HmR5Ht3vbyjJajjXEsDHDp1Y7urrRrh1ICJPMotA8XmPCrq8oshrI7h9S39zbr2YosK+h+hJ7jL2TAg9WLKy3pBokyDC9dCFv7Q7z+8lvIcXVjoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r3/njLio/3ehCYee3Yasiu5WzkDcld211VAJPzS4ec=;
 b=Gbh/RpMPdWj4FjUmoWSXz/nWCTVZXoiEmmINt5Zkzj/YQ6YfA2aMp02cTe84R6RsONdymSj//yYwM6+NtCONmrnlr0og5OKCxWHA9LaqUl/BdmcvYJMzm5VFlZpJbnGByYs6l7RUs+ZyQdKw+eoIKFGYVcFqRh3ltf4A9s9P37EsDlQYf5Gkx/vkLTcyUT0dBvUd0PuOwiRKoKo+dYOcQOCfF+DEe+Gg/MVIAa04JDAEPiJDjwW8e8T798uB0FewJNvBvPTTRWcCsI3+CRAJ+hhZoAnJs9bKnlfl87gDnOcDCLdL0OvadcAdowgR66gra6NGGIHAMffIEq/DkcHC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r3/njLio/3ehCYee3Yasiu5WzkDcld211VAJPzS4ec=;
 b=BDK6vpTN+swowLbI5/9NYilFRAOp0q2eCTWmANF0aeANQy7whmeQ15fk5wVqf1fTyyLa3MeWhsMItWUx5OED8goMRYOo4Jp4EQVmvOnPebRIrHpnIs3ZaoGATePl62yhzLyqh7UqoRCiHNGmGKJTXgUBx9J5sV5m9LOpuTJSAuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 15:32:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 15:32:06 +0000
Message-ID: <c56a359b-d035-4557-84d2-6c8ddd600bff@amd.com>
Date:   Tue, 12 Dec 2023 09:32:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thunderbolt: Introduce tb_switch_reset_ports(),
 tb_port_reset() and usb4_port_reset()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanath S <Sanath.S@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212140047.2021496-1-Sanath.S@amd.com>
 <20231212140047.2021496-2-Sanath.S@amd.com>
 <20231212152706.GG1074920@black.fi.intel.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231212152706.GG1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0104.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7f22d9-cc3a-4086-cafe-08dbfb277f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eb70Do3zCKPEbTi51fec73pv//NUB/fPhGQ3hw2l7zTw/I0nzynssxGZ3HP8orQtgfyiTAywjoz8905P/E2vcA7MHQGoA1dHweLfUaicvcKJSSueiWRqe3mMXCfeVKpm76ewK3Rs5t2wxEl6SA0UCgbHU29zktwkrbKalp01oKt5b40yZ6TK6bBgYbZ48zIz+HWJM9wY77ltmqgHNVO7teo6f/MkubULTQAhiJo+xbUDSkUWhDByVXtNjqEi8F6TYvC5rayIt1jiH03h7gIFVOJ7joOnrZUk+BFsv7PnIb+mlLike+nFb7LMvrJLTnYe1DthN/vNLWfCRs0RQ6mm//yi6Vc/iu6SAq1yiTurRC2JbQoTC4sJkfZvkN2bgmiu1kmdPV4ue8I2HZt1SH3FKy/+SNia+rJ26JR1RJ6Ko5V3to6rUWyWmgmc3MpZYZfigu/P7AjcQpMQPhWtBEJnzJfFpw0f9nuJnWba7ocrum0TiC8cKC3IgZkb0lpfQ1hHNJuogzVAdf/y1FWExyddcFSCTgV7X8pmXd6TsYCaUhEfzF6JgiJtLCm+Ez+4aGeZKhldyd5a6OtgbPMFdtDDPuT3MU49VVVPH2tWnA+ikuI8M4FueMOcm2evdZ+JmW+xCgf19Vctf19LC03L4cIMXB5adJl5Vd9r5cgeSn2kYPmsx2jBKJvjFFuGfDBKOdm6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(6512007)(66574015)(26005)(2616005)(8676002)(4326008)(316002)(8936002)(44832011)(5660300002)(2906002)(6636002)(6486002)(53546011)(6666004)(66476007)(110136005)(66556008)(66946007)(6506007)(478600001)(41300700001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzcxT0xyNUxTUis0NGViYm40dEE4eDdmT3VYdU1YRHVJQksya212eGpxR3c4?=
 =?utf-8?B?YnZRMTRzZkxQL3FLZDIycFF2bEcwMlFrK052d0U3Skdubk82bk5XdE5CMTg4?=
 =?utf-8?B?cEl4SG5DZnovN1BTTHMybHd3RkUvdmlpSnJkTzJOMERkTGJGVzlCSzBEL3pt?=
 =?utf-8?B?TW5PNFJlb1lHNS82bzZFaGdDN2J1ajczK2JvT2k0U2syWEo5RGlwZ2w4Vk1P?=
 =?utf-8?B?V1A3eUo3N2t5TmY5cWpORDdoRmwrTU40bHprM2Nwb2U5Wk5PZVVRbnZlWU1R?=
 =?utf-8?B?VXNML2I5YThaR2d1dVhIQzF1UHdPTzF4VDZldmpoL3Y4L2RNaW9yZ0dFMDBN?=
 =?utf-8?B?dlBXbVgyenA3SytORENXS01IMzlsbVFKdkRYa2JaMEdIQlhLbjV0SHAwK0Iz?=
 =?utf-8?B?SnVURHc5d1ZJVzJRbHRRSStCMEJYdktydlZpYjVyQ3NuZFdXREJrWTNYUVU5?=
 =?utf-8?B?T201a01TL1JEQ1lYb1F6UzJsUnBlc2xRUkV1ZzF2Q2hRTnNLeTBUdE03YS9M?=
 =?utf-8?B?NU45NjZ6ODI4ZEFNYjhQMGhUWXZBUld1aE9uUGh6Z29GcWRZanpyYTE4TWZx?=
 =?utf-8?B?QUZuanBIbnByUTBvV1NnVkY2a3VINnBIWUpPS3drOG9PRmN2aW5XOGFUVkxi?=
 =?utf-8?B?Z043WUlXZldEQmloK1dQMWUwVzBtaFdIbUlmMStYTktoYTZXNE9BcTFSYnFw?=
 =?utf-8?B?eEd2azgwQ1czVWlZUll4dEZKUDNRVFMwcUV5OEJCVjBGODY1ZGdxcUVpclQw?=
 =?utf-8?B?SDFaWll3VWp1K2d3L3crUDkyMVVNZFoyYk51d2VRTjI5UktsZm5pdmJWbUhL?=
 =?utf-8?B?VlpxUEFrc2xpaC9MWFdMMERzTkVCZGpvRmJRc3JjQVlQM2RuSExoaTMwV29m?=
 =?utf-8?B?c05CZWhWdk1MVE5xZlZWRFFPMGhodkJYTUhBZEl0Zm03dnBuaTZZTGlvMk82?=
 =?utf-8?B?TmJhSVN6TGE1TzcvYmtvZmdWc0plemlVaVBXR2NuRTNGbmZSTWRSUTk0Y3Rw?=
 =?utf-8?B?WHdEclYzby9HSlNhSTgzTGlURGhrMnREa3FQRXlFdzg5TVJiRURJTWtybWNr?=
 =?utf-8?B?SzZCWFFRL0xIS1BQNk5xSFZZTDRpZnlMRnQ3YWFiQXV6Zys1eHhwYmZLT3VE?=
 =?utf-8?B?cDQyZmtGbXQwTGdwRUNxUVY2NG5TNURuYk12Ky96ZFJ0N1l6eFF5Z01Bc1Y2?=
 =?utf-8?B?NmJNeXd4Mm8zbVFSdFFmQmNZQmtmNDVjekMvVlkySDRQNnJwUkJjOVdaVjQv?=
 =?utf-8?B?QWRJNDRmcjBpOTVtWGpLV2lzbFQ1S3NKampsMEkwSkd3QWtpQkpJeEhMbW9J?=
 =?utf-8?B?L25Fd3U3U2J1K0hTa0J0eXk3WHRTS0ZoY0xJTDUwTFZOVDZPMzNMQnFLeTQr?=
 =?utf-8?B?NTNpR2RLUmNQRkJHZVZGQlBVU0lwM29JUmtjQXNwNktJQnNvRHVCTHJ4RGtB?=
 =?utf-8?B?eHp6SU8wYjZiMjBqR1dzUncwUEZwVzdKS3lMYkRCWnVlSmlicWp2OS9oajk1?=
 =?utf-8?B?cUxCTTNiUUFyeHZ6aXZML1E0SVd2MHlkNlF1cnoyc1FIT3dBUll2ckxjUG84?=
 =?utf-8?B?ZTZUKzRud0c0R0hkSlU2Z3ZPNyt5aVJaUXl1bThwalVHTks0ZUh0WnhkUnBs?=
 =?utf-8?B?RGV5NnhIRDlkQ3dWZzNSSk9RMUZ3SEV1enJudlE0bENDV1dyemhYR2RVUzAz?=
 =?utf-8?B?enRvek9VUWYwNGxWQndBOFBzbzlQbHBTeDlsSTd5MC9CTnlNQVh1eTMyY3hw?=
 =?utf-8?B?djNYai9Zd0dYTkw3UU5UWWVycmFMcEFrK2ZNc1J5aERCakF4UmtpQmQyeEJY?=
 =?utf-8?B?R2I5QlBQSmw5aEZaREswN2wwNHhndTVRUmV2Nmh0dVhEcGpuSVVnTjVKOHJ0?=
 =?utf-8?B?VFhmbDMvMWN1S0g2VmNVL1pqa1d5RWxOaEdRaUVxVytCRFBwakNlcHo2WkhQ?=
 =?utf-8?B?bWg4MEQ1N0FnR1ZpTEhxbFFpVXR5Sk1lYTRkMnFCWDEzcGlpejQrUGZOOG5q?=
 =?utf-8?B?azZRRFVPOU50OHlJcHIrOC9UZzg5b1VTK3dmcWZqa1RIYTBpallyczdOWGEz?=
 =?utf-8?B?UTMzZmQ5aWhLaUFSc0pYdDdtTkJtTDkvaVdxaUQva0E1TUNxVS9uem51SEhp?=
 =?utf-8?Q?8tnmguhyO0rGaydgRxlHWyck8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7f22d9-cc3a-4086-cafe-08dbfb277f76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:32:06.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYwWWNV59kfdU1TJhdvlDUI4Q98L0c4wm/zTVM2Obi/qsqnOOX+hKEHta0QaLEesTblfxWPS21RnobbkS1ym/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 09:27, Mika Westerberg wrote:
> On Tue, Dec 12, 2023 at 07:30:46PM +0530, Sanath S wrote:
>> Introduce the tb_switch_reset_ports() function that resets the
>> downstream ports of a given switch. This helps us reset the USB4
>> links created by boot firmware during the init sequence.
>>
>> Introduce the tb_port_reset() helper function that resets the
>> given port.
>>
>> Introduce the usb4_port_reset() function that performs the DPR
>> of a given port. This function follows the CM guide specification 7.3
>>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>> ---
>>   drivers/thunderbolt/switch.c  | 31 ++++++++++++++++++++++++++++
>>   drivers/thunderbolt/tb.h      |  2 ++
>>   drivers/thunderbolt/tb_regs.h |  1 +
>>   drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>> index 44e9b09de47a..26ad6cc1ee91 100644
>> --- a/drivers/thunderbolt/switch.c
>> +++ b/drivers/thunderbolt/switch.c
>> @@ -626,6 +626,19 @@ int tb_port_unlock(struct tb_port *port)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * tb_port_reset() - Reset downstream port
>> + * @port: Port to reset
>> + *
>> + * Helps to reconfigure the USB4 link by resetting the downstream port.
>> + *
>> + * Return: Returns 0 on success or an error code on failure.
>> + */
>> +static int tb_port_reset(struct tb_port *port)
>> +{
>> +	return usb4_port_reset(port);
>> +}
>> +
>>   static int __tb_port_enable(struct tb_port *port, bool enable)
>>   {
>>   	int ret;
>> @@ -1547,6 +1560,24 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>>   	       regs->__unknown1, regs->__unknown4);
>>   }
>>   
>> +/**
>> + * tb_switch_reset_ports() - Reset downstream ports of switch.
>> + * @sw: Switch whose ports need to be reset.
>> + *
>> + * Return: Returns 0 on success or an error code on failure.
>> + */
>> +int tb_switch_reset_ports(struct tb_switch *sw)
>> +{
>> +	struct tb_port *port;
>> +	int ret = -EINVAL;
> 
> Why it returns -EINVAL? What if this is run for non-USB4 router?

This is a good point, but in the non USB4 case (default return) maybe 
it's better to be -ENODEV and in patch 2 be careful about the caller.

> 
>> +
>> +	tb_switch_for_each_port(sw, port) {
>> +		if (tb_port_is_null(port) && port->cap_usb4)
>> +			ret = tb_port_reset(port);
> 
> Should it stop here and return ret?

+1

> 
>> +	}
>> +	return ret;
>> +}
>> +
>>   /**
>>    * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
>>    * @sw: Switch to reset
>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>> index e299e53473ae..f2687ec4ac53 100644
>> --- a/drivers/thunderbolt/tb.h
>> +++ b/drivers/thunderbolt/tb.h
>> @@ -797,6 +797,7 @@ void tb_switch_remove(struct tb_switch *sw);
>>   void tb_switch_suspend(struct tb_switch *sw, bool runtime);
>>   int tb_switch_resume(struct tb_switch *sw);
>>   int tb_switch_reset(struct tb_switch *sw);
>> +int tb_switch_reset_ports(struct tb_switch *sw);
>>   int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
>>   			   u32 value, int timeout_msec);
>>   void tb_sw_set_unplugged(struct tb_switch *sw);
>> @@ -1281,6 +1282,7 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
>>   int usb4_switch_add_ports(struct tb_switch *sw);
>>   void usb4_switch_remove_ports(struct tb_switch *sw);
>>   
>> +int usb4_port_reset(struct tb_port *port);
>>   int usb4_port_unlock(struct tb_port *port);
>>   int usb4_port_hotplug_enable(struct tb_port *port);
>>   int usb4_port_configure(struct tb_port *port);
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
>> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
>> index 4277733d0021..55f7c163bf84 100644
>> --- a/drivers/thunderbolt/usb4.c
>> +++ b/drivers/thunderbolt/usb4.c
>> @@ -1073,6 +1073,45 @@ void usb4_switch_remove_ports(struct tb_switch *sw)
>>   	}
>>   }
>>   
>> +/**
>> + * usb4_port_reset() - Reset USB4 downsteam port
>> + * @port: USB4 port to reset.
>> + *
>> + * Helps to reconfigure USB4 link by resetting downstream port.
>> + *
>> + * Return: Returns 0 on success or an error code on failure.
>> + */
>> +int usb4_port_reset(struct tb_port *port)
>> +{
>> +	int ret;
>> +	u32 val = 0;
> 
> Reverse christmas tree please:
> 
> u32 val = 0;
> int ret;
> 
>> +
>> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = val | PORT_CS_19_DPR;
>> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for 10ms after requesting downstream port reset */
>> +	msleep(10);
> 
> Probably good to add a couple of more ms just in case. Also
> usleep_range()? (or fsleep()).

Sanath had it at 20 but I had suggested to align to spec.
For the wiggle room maybe usleep_range(10000, 15000)?

> 
>> +
>> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val &= ~PORT_CS_19_DPR;
>> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +
>> +	return ret;
>> +}
>> +
>>   /**
>>    * usb4_port_unlock() - Unlock USB4 downstream port
>>    * @port: USB4 port to unlock
>> -- 
>> 2.34.1

