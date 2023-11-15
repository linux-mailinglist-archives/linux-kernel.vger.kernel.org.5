Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D157EC131
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbjKOLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343579AbjKOLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:20:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62889F5;
        Wed, 15 Nov 2023 03:20:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW5AwpzwbMi1K4kdKvX4t/JMkPRkljv+eF2rhB/Iw7wklhRr/wRURle9pZ3sYOL7xN4Gk12qvh57IpOrUjkkpR1O8W94WPq2X5cBo9A7NgLE9c6m19Kis7yR1SptAiCT2bvVd+a5hp6A3tDarkHtfqASK+RNICacKO+aJkh0wpzLXWjqJteNalTk3LKt2O2+xooCGTkQB+G4WJQX1kvN1+JO1vNmp1LhrNclK6Q0Wn2rDCoaFKR5+QtYW4kMPSmOSjNfR0qqMCextFOjl2lTlkf18iWHFwgKPffOJBxKWfT02d1ohbkvvDZ/gezYpRjSZpfHXD0Rsgy0bxWgaefVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLTHiGeEFxEwAMCvbwFF9C8+lG6HTFka5B7xGY01LuQ=;
 b=ZAyFos2wvCkco9Tk72RJ7fOwu65ohZnzNbSzHVjuI2rthsI694HxPlnFroClCp1Qvkp9UPoh8vG+JlLZbFaYfwFtjSU8ngNYzdripW7/j8zwEsKyn3O7aXz7VDDhEknabOqlBLZLdniFr4Hselt16/VKg85uOWe84Cf2vgTL7Snge5LjlXnCARsx1zjjgPNe2MvBcW5Tfp8QfOR9woMzHhv+7A1zArDji/ztoX7S8KFPCe6l3tMI/eacsLmzokrtOHvp0nT9VKZhMTQLExjHHFtZROgJ0a3NTT6cfiZV0UJN22c1sfwnP4EOA8DDPiQbZgQMMvEs1bJ6uE4Aw/wL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLTHiGeEFxEwAMCvbwFF9C8+lG6HTFka5B7xGY01LuQ=;
 b=lKIihRZ4kJlM4izM9aHTp1iQtLLdABau0YDZTcy4330RV05JyHVD8QjjQtc2+dC/lH/WqNuhJ2np1zKz8evfHDn1u3XmW6pK7Buog8vsmz1Wdiz+EgSCRk8/SdIkuSIBP0KFpYelDkVKARGXYUu1m5zQULP1U/rG1EsQq8i/2IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 11:20:50 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 11:20:49 +0000
Message-ID: <c8e52587-5ad2-46ac-a5a8-71738b9f5ac7@amd.com>
Date:   Wed, 15 Nov 2023 12:20:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] usb: misc: onboard-hub: add support for Microchip
 USB5744
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20231113145921.30104-1-francesco@dolcini.it>
 <20231113145921.30104-3-francesco@dolcini.it>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231113145921.30104-3-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0119.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::48) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: af396b7d-eee5-4326-9fc7-08dbe5cceb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ev69C5N3At+Q0eXZKgEJVOHJ1OKfFoiDTlnPq4Gy8q3JRlNAuLa28XLWQSouFuAoYOJUpv0u/HtaZ7347Iqcj0wSRUGaxYE0skwz8HaQ2ifoznMUvSfOJrH5HKQYKofwRsJVNAQQLOSukatDFDUj2PWKisY/MB/LwG+ynIFYmf3Nl0uFDMHEj62orEArLNMkFBRk3KwvdWJjjib/YfK/c6Winey3mfgpBa5hKxme+hgWEfODPi4umx3+Tj9rMWKa4/9vydb36Tu9Y1xR8InScwh2n3M4NddowiOYrnHT9NFQUkHiDC2J2HjHglrr3vpECj4WHdU/6t65PHP00tdC8R+zBzt1vqLE5J7dlFQ6xtPFM91+Ooc+QbmhJ3tLZaWbhLTdJ2FY48BjaTh/t7qiArHQYPycVIJ/uNJLQeoR5QsinPzvwuyVdls4dmqcgRKdrc+GrkkQO8BAxDYz/EfucFQxdVmQdvSe9S8hHd9hhmAVr0EJf923hX77qjDCoG4u+0roZOj6pbkzfO1+x+88kTMmLkGkQ3+u0c0GMbQGFozeOGlkzZSTeDigrTxa1iPGS/SByuaGSvXWcP09f07l/IUDDssE6xqgJ9V2qv+bLZU4nqDXJfgm+kogoKbz8sKaoAzOwtduOpdjLJANtpYVPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(8936002)(54906003)(66946007)(316002)(4326008)(8676002)(66476007)(66556008)(110136005)(41300700001)(44832011)(4744005)(86362001)(5660300002)(2616005)(26005)(38100700002)(478600001)(31696002)(6486002)(36756003)(6666004)(6512007)(6506007)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG9NZDhGaUFqa1RDMjhYd2htdnpEODFybE01c2xLZzF0dHpYSkhhYU92Mmto?=
 =?utf-8?B?RERnRzVCWW1WSm15aVFmWDBCdUJNeFRSdWkwR2U4SUJYRzlJZUJMM0RETERz?=
 =?utf-8?B?eUhHa1Q3bG81cmFXN3NOOXpnTFpHOEJOY2FiQ3I3QWZxUVg0ZkRHQWxrZVhZ?=
 =?utf-8?B?b0g4dlBxQ3E4aW45OUlzSllLQll6WXhVOVVHdFRtUVJrSkVtcFN3Y1lVSVF4?=
 =?utf-8?B?UFR6N09DQ0NSdklLKzRQbkNwcWYvTHFMVHZyN1pQNmZIWHJ5NXordjdwdEFM?=
 =?utf-8?B?bzE5QURmS0laZDc2aC8wRnIvMzBQZ2dXUGJ6WVZhbFRYOW9Sd3BiNDkvNDZ3?=
 =?utf-8?B?MlFkSEQ2TkZTUExwaTh3U0xiQnE5SElOaGxIaEJBWUx2RDQ4U0dhMEQrdmpn?=
 =?utf-8?B?VmFPNk1sSDlxMFl2RldHd3BvNGJ0Wi9wZy90cExDQUFkZVQ2eXNRbk8xTGRo?=
 =?utf-8?B?QlpNVmlHK3lCWFJDRHZFc1JJWjBPSVpvbmhuVExWZzFkODdDY3JzQy9TY0tO?=
 =?utf-8?B?S1pYcGVCR3FGUW01MDlUSkxmR1BFVE8rZW1JQ0hva0s0UzNOZi83MkZIT0NW?=
 =?utf-8?B?YjRabWZTNDhXZXdSbmhDYWhGRlllNDlBWHlEb2kraHhpRlJmMklSTFNVdXdW?=
 =?utf-8?B?YjNWYWV1cnJZeEtOczhQVHZSa1g5MmFyRVQ1VnBUbytIZklwbW50ZlYrWCs3?=
 =?utf-8?B?OTVabnF1WWhIYU5Yb2JUNmhkZWVlRVhFc0M0YzhTUVFpY3FBRTBJemppR2kv?=
 =?utf-8?B?VUZrYzM3SFRBS1gzTm1KUUs5K3hLa3NjbTV3aEtFc1BGVTliKy9EN0JmaE5T?=
 =?utf-8?B?ajdXWTdQcm5HZ2w0L253UnNWRlBwdFB0ZXZUdERzdDlyVFYrNFh5VEFIKzFF?=
 =?utf-8?B?VTBpeTI4Tjk0RVhYWWkyWmhvbitrcG5HNlBvYjZEbzE3dENMakFRZ1VIZU9j?=
 =?utf-8?B?ZDgvMzc5aEVlZWZ4T0o3d0h2TGdlZnBDbG5va0FkeFQ2NFJtd2llRVlrbEJZ?=
 =?utf-8?B?Ykwvc0tLZWxCU2h3ZElMRE9OZmd2dTVvV0ZJU1lVSlhZTFZlYjIzNWN1S25B?=
 =?utf-8?B?cVlJdWE0emRPcWpadW4yVm9wNW1sN3VUYTFWMkN0VStFdkZiYlRIc0hQSU45?=
 =?utf-8?B?dW1JdVU1TEt3Z0ZEb0xqUnRHVS9qVkNvUC93d212aUZmNmRDckY5MENKZUlh?=
 =?utf-8?B?UXo1bGEzY3hCc1RDUUhSTXAwN0RRM1BSWU1wcGIvV0xGc3h2WDQxWTg5emk1?=
 =?utf-8?B?QVg0MUU2U290Ymk4M3J3RytKTTB3anpNWDZaTGpRYzFjYk5oK2dIMHpRYVBt?=
 =?utf-8?B?MExLc2QzUmxnbmY2NnFNU0QyaFE3L0hQb09wWUpMblE3dEJNUnpyNzc1NWsw?=
 =?utf-8?B?UlJOeVBDQjVZVVcrS2hFRUdXbWgrcXBuTjhxU2tKNWkzc1hnZkxYM2E1YnFk?=
 =?utf-8?B?ZE1tRnY2WmpKdjVLMzVDbUEzb0Z3RGRLdWpZOVcxcEJ6VHM1UERVVVFGZ3dZ?=
 =?utf-8?B?aklDU3UwZFF2N1N6TFI1SkxHOFlUSnN4RCtQVmpKek8wdGVZYkE4L0RkOWFm?=
 =?utf-8?B?THVXSE15SFpXS0VEcTBGUWFGRVVqOG9TdFpkVXJwb1hwZ3VsOUtIazAwNHdK?=
 =?utf-8?B?VExZWnk2eUtlYlUzWTNuQktIdUdXR3RyUVZVbEhYdUJjQy9uUGs3VHJZQmFv?=
 =?utf-8?B?V2NnZjlZYmVGWTNGY2FIcHgxUDBDUElXeEVrd1Z5YmY1THl1UExqTkN5bDBv?=
 =?utf-8?B?alI3ZFNqWGdpQXFWdDY5NE94bmIrTkY3L2hxRXJRYWRVYXdLSkYzaFpPeDVK?=
 =?utf-8?B?K25XRjhFZFpLR0d2dThTVkFGSHpoVnN6dzloaGIxcG5GTjFqQzVxcVdJeFdT?=
 =?utf-8?B?YnhOcUowT251T3RRQzZlbldpdmRINFNUVlJBalNNRXhTSjZBTGI5MFRKem12?=
 =?utf-8?B?VG41NXBMZVlhTUVWYnFoc1prRFFhbm9FSmFwYWk1Q29GcG1xZFZOaGFjWGsz?=
 =?utf-8?B?d2NscUhSUFRNS2Q0eE42S2dJc3VLeVRqUTNVRFBvYXBZenl1YSsyOE5uN1hz?=
 =?utf-8?B?TlJNK1BPUi93dWtKck01Sm14WVVaTUpIYmV6cXNWNmxXa0VDVml3MWw3QXJz?=
 =?utf-8?Q?PYKAQocxhE7em4ayjJ7rmlvRu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af396b7d-eee5-4326-9fc7-08dbe5cceb6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 11:20:49.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16pCNGPXcMPyyo6/zkTJrT15UP/SMHaO0Q0CkPlNjsdF//o4gQ6tVKuaEtu3u0tX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 15:59, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> 
> The Microchip USB5744 supports two power supplies, one for 1V2 and one
> for 3V3. According to the datasheet there is no need for a delay between
> power on and reset, so this value is set to 0.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

The patch is correct based on functionality you want to add. Would be good to 
also add support for initialization over i2c which will change couple of things.

Thanks,
Michal
