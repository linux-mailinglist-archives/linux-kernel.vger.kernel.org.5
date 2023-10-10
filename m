Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C938D7C014D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjJJQMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjJJQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:12:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702A97
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAKvN2Tt4hwxl7K3FijUMukcVxEc8n9k44Go1OaqQDpUygiPaF4Ahb9Xf1zS5FzF59S7KNbObHlTLH9DzRTwKZ10gmdRyaHxH6nSBkSOLJwyVuBiMmrXcC7ogAeZ5s+QwUyRTOffxhgWVHAiaMgU5QOPrSXSeAZ0cTMC9iSO6vMYkEEUCt3oPOrukV+Rk+vBkGWqQC03wioVNGgpG++c82vyNug9YddMYNJUWUZOaWlSZ1Xw+5AMQhWL1rbTnUzALWQxp4NbbGyJFxRMlNP3eDj1vHoF4uG4J7sXOcaKW1CCNe6gCnbEGbaxT/7fYCHZnadgf6Cu4Atnp+QV3hatcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uulNyNynxxpxbMUSW6+37kbiJpg2PhHk/TSdre8niJ8=;
 b=cG4qJRN+Gk/Wi42I9VIRD3YCtUpu7bGe9D5i9YSaiPC873Ba74hHABWnN+0OpijCiQBRl2HVn7ta9ozHkbImdsGQxcnEoxX5cX89fmwcGUAnsjQEiHx/+ClwJnxekc5XxRnEBOJFtK1rth+T0OioSwZZoB2C2fVYUhHeA96EOb44Wxl63ilfvVTzv951/slcMRJlNx0nzWZTwr8YjeoyD6X6wAeBpJJRbIaEcElpaoCwdnM0AwORWbRhbaLJfQ+vO/iaTCPzSvkeT08WOIB6k8+y7jrTehnHzgtU0AFeGHiZGcH8gNh9mIdUEz+36uUzMM42zlTu84cqnM91T9IJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uulNyNynxxpxbMUSW6+37kbiJpg2PhHk/TSdre8niJ8=;
 b=PCc7yT0ZPAbmgOWzpyiLxvQ2xmWT8dwd644qRYG0WtF/WdtQYEL4gwdOmyKufPciV7x0Ce41hddxh61WXbi67p2XA5UQMn6pa0vmcnuvxJldaHK0N9ZIbA5+kW074oSYBkQV9JEeEWBU43IkhKqf1mzMoKBEhHgMI6AmUsFX5B4CuYeJp35K4xRlbMUc+AJ6vFOFBFB2xe9j3lw1GQONZG2SGnISQm+Our/uA9eccT4RbgZsMVFSZieX0JcdlPrS223Tq1rWZ9OLB6RjjRryMLJbeHYZyBn8DhEbOXKCA7ihfqSVRaTs2B/eFo3OMIT4v3Beh/OVnyKuJU57JFeGuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 16:12:13 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:12:13 +0000
Message-ID: <59939570-3779-ef90-2a72-7be32a30e368@nvidia.com>
Date:   Tue, 10 Oct 2023 09:12:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] hte: Use kasprintf() instead of fixed buffer
 formatting
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        timestamp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231010141123.3909596-1-andriy.shevchenko@linux.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20231010141123.3909596-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: c31876ca-072f-4b83-af93-08dbc9aba9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozBySbNvJj5+LzS1t1HnomTqNGT1rRm+0mLQp01cRPGKKsgYJ7PrcDXaa68Ww6o07v+UdVqhOzVGTRDstoEpGQ9AKUD0lgq/fgV5r11h0L2pzSdyvjIz2CF7NdmCX2OO0IsNhmTeC68hRyJYaiLfouCKMQ73UmOo0T4sBQEkY86WLj/2W1PlmUBSnQZPDZFpkgkYAI1OwYpfEoucdH4tXvGi6QlQGWcZQyyxH7/cpPK0+NJKuQZwws12VTgyvPzWYZUD7238KlGchLleeAkHmkpN7awVmAox2ptyV5/fFUfKA2pjRwvXHhaWb7fHuN/kr9JTnsQOlNvkqqkHBfQ3hXuT8Z4wtnBXSnwMqsV2udp1k+OK84t4sJ/Ij/+W65T48UJKdDNNFSxMOV9UOQHKBoJDSF2JRsC5mUeUrJK1o89GasCln13iKekA83wXIhgiLOX/nABjwApZNkhc1PGCAJAqGydZKf1HfoPF2rfdmhcCz2rhBVr2jXvxqIsH1MvgaQjUMsU+mxsnp2452c9CKJQSSR9w5+gr5pbttfew497GKokqoUMM03yu00goxkgJ43l7qvmJJawKAgN4bYJCIyhWTovqsrcVL/CfA3zi/nQAAl0F86sVv607XPTxPd4MVm8YlFMT5F2QzpGTNl6dyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(2616005)(83380400001)(26005)(66556008)(66476007)(66946007)(8676002)(6666004)(5660300002)(6506007)(8936002)(53546011)(6512007)(41300700001)(478600001)(6486002)(316002)(36756003)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRwUElLTkxuOFJyeFpKQm13dEVORzBua1RWS2xwN1V4U3ZiK1RWemhGSUps?=
 =?utf-8?B?cXloM0VwMmZXMEkvaUFjVGVjMytJNCtQOU1aWlhYUVVUR2VNM0lwUStpUXhr?=
 =?utf-8?B?bk10V254SUptaDZDUUFZQWpSbncydWNDeEpDQlJCR29TOXZiMlEvMXZ2dW96?=
 =?utf-8?B?U1BUU1BPYWdST0JWUG51WXZ6TE9oeEtBT1RpQUVhMU83U1hPTk80Mmsyejc0?=
 =?utf-8?B?cUw0L2J6KzBLUlZXZ3ZrdGFqOVFqeGtZbEdzWUZmWHI3bEJUdHhNVG5IS2FD?=
 =?utf-8?B?WllNcnpldXhhaFpZbndJN0UxeWFwZmxmSyticCtMWXUrcFpKc29BbFFZck9F?=
 =?utf-8?B?Z0JmMDdYUW1vbWNxcnRUeCtVMkFKVUlhWlE0dFY0NURIZ21PVXAveEwvcWpO?=
 =?utf-8?B?ZjBmUGFIeDJId09SVzc0SUROaVJBaGJreHluWjhmbEhVZ21ONjcvRDAxeTB5?=
 =?utf-8?B?dHRwT2l0RVlrL1g2SmM4M1JOYUl6RW9aVVV1QlFTeEp1MTNwR0wrVnM2WWxT?=
 =?utf-8?B?TjVoemV1ZTlTOE1Rck04clhtTS8rZ2JIcXpNM2dITzZpeDJUcnE5VWtCWFVE?=
 =?utf-8?B?TktYUHdHTnU0UE9zWVdrcTg4UFpnMUg0U252TlM0cWhIeDVzeDJzbWtvSXBL?=
 =?utf-8?B?d2xzWXNnN2xTMlNyeTM0SFJXUVErQUR1d21yQzY3ZUZBQVNSdm5DN3V4SHpO?=
 =?utf-8?B?allCdWV6b2xpMXpCRFlJTUE4Z0s1NVNWbkJYK0hPZnRFeEkxSFlHMEd3UHA3?=
 =?utf-8?B?dmtyUzRNRDhZbGsxRmh5MFBseWd2RHoxU1JWMllJNVl5UGNJb0E1aHgzWlY3?=
 =?utf-8?B?b2prYWJBSG9RaTJWL2toaENCZElIMk5BODZYbFZ3aFFiVlYxQjkvdSs2NUdD?=
 =?utf-8?B?T1hPN0laZmtnRkVMckJ1bEQremIzajRNRHVFbE5BbldHMVAvb243bUhVMHd0?=
 =?utf-8?B?RTg5WlgvYVlTVGFhaXM2KzlZUnBFRmZxbVBIa0xqZExQaDdYYkpjU2NaSXQ1?=
 =?utf-8?B?Ly9BWEFzeHdKeWgwcDRJMUJRQWNuM3hCQ0lVaVpBTEJaREFMZmRSZmczZVQr?=
 =?utf-8?B?Ny9GTlBxMTBDdjRxdlN1VmR6Q3NwQ0djUnlGSWw3M3dIUWdLdHV1eHFlL0RY?=
 =?utf-8?B?dkNHTmFocVNGMUxvd1A2dnYrVHZuUSs4eUJLV0xGT0FiUmF4YVlyWHZVZ0Ji?=
 =?utf-8?B?NjhlcWNnM3VLd0dWbklaT1BUU1kxM1F3SUd1MUEwc0dlQllVTmQ1dHUxSlpQ?=
 =?utf-8?B?VFVCdEI3T1pRSTBOSkVaL08zcitiSlNjbms4ZGhQczk1eWJZREQ4Qy8rczRk?=
 =?utf-8?B?c2gwMVRiVzJqNVowTWRtRnJKWkt5T2lrR3JOdmNQdDdHL3dwQU1JcHBLcjUr?=
 =?utf-8?B?SXZuQTZsakFmbGluNkdaeHAwQ0R6RC92Y2ppZlQxMk1jZm9MQzFOOFN5ci8x?=
 =?utf-8?B?WmVTdTB2NGxYQmI2V1A1RzhEcW1Rck1YcTdEQmw2ZUt2enpOcC9udksvbUR1?=
 =?utf-8?B?clFPT3BvS2hoa01SUG9sbkw5MEFWN3FDaHd4M3JHM2xhMU9xVjkvaWc3cnVr?=
 =?utf-8?B?WEV0S2FNcUEwaUw2MURSZDhIcU1jRFhPVW1JMHRvM1djU1ZKemI1ZjRod01W?=
 =?utf-8?B?b3ZlOExZVUh2SnlLVmg2b0VZanNJUytXM3lYYmtFMGJTenZIWi93OUkxb2xG?=
 =?utf-8?B?Snl6dVUyOFJPeVd5MlllbjJqVUIrN3BNSXN5Y0NpSGtaYnl6RTlhYzZhanNn?=
 =?utf-8?B?R1Y2ZXJFNHpGTzM3NG5QSjRvdUpnVEZqTk5oLzFscE5WVGxWR0djZU5kWGhX?=
 =?utf-8?B?bU80NDVMc0dVY2ZaMWoyVWJkSkxUOXJRVjJoSHRFQW9IbFUyMUxUTmlWOW01?=
 =?utf-8?B?NDJ3VHhpc2JTYXdvUW9QSkdzZjF1cWFoUFV5SkVYOWh1ZmdnS0dTMGdLcUR3?=
 =?utf-8?B?eG9Falo0L0VOdTM3bVVSeXdVbHdCTXkvYUZSUm1CRHYvWm9NRExENXFFc2pQ?=
 =?utf-8?B?UXQ0cnFiYWthUHA4MDRrTjU0ZXpKK1BzNkZhZmYvVFBBUDZlVHhWamhjSmVa?=
 =?utf-8?B?eWV4MTlKd28ya3htVzUvTkN1SWk3amhwK0NvUXJhT2dNam5FQm96Tmdzc1p6?=
 =?utf-8?Q?tb362PeuorvZQ8QI6mT7a5Cfe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31876ca-072f-4b83-af93-08dbc9aba9c3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:12:12.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSOcJHsPXvRsDSyhsZE5Ylq/xs+i/CDfBV77U//9hjIlMY6SSDaI67DfcumpBtC037C1P3TeycPzjma8cYl5XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 7:11 AM, Andy Shevchenko wrote:
> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the kasprintf() helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hte/hte.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index 1fd8d2d4528b..23a6eeb8c506 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -17,8 +17,6 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  
> -#define HTE_TS_NAME_LEN		10
> -
>  /* Global list of the HTE devices */
>  static DEFINE_SPINLOCK(hte_lock);
>  static LIST_HEAD(hte_devices);
> @@ -389,13 +387,10 @@ static int __hte_req_ts(struct hte_ts_desc *desc, hte_ts_cb_t cb,
>  
>  	atomic_inc(&gdev->ts_req);
>  
> -	ei->line_name = NULL;
> -	if (!desc->attr.name) {
> -		ei->line_name = kzalloc(HTE_TS_NAME_LEN, GFP_KERNEL);
> -		if (ei->line_name)
> -			scnprintf(ei->line_name, HTE_TS_NAME_LEN, "ts_%u",
> -				  desc->attr.line_id);
> -	}
> +	if (desc->attr.name)
> +		ei->line_name = NULL;
> +	else
> +		ei->line_name = kasprintf(GFP_KERNEL, "ts_%u", desc->attr.line_id);
>  
>  	hte_ts_dbgfs_init(desc->attr.name == NULL ?
>  			  ei->line_name : desc->attr.name, ei);
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
