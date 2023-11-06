Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A87E29EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjKFQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjKFQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:37:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9BFD6A;
        Mon,  6 Nov 2023 08:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3lWmco1O+CfiI+t6MepimcroJHT8s/Rdhykx0isuoAI6afnbjw2IaupZRYJ9BN/7DBVM476KNygFlxuBNFDbC2KnMOZy7xDd+3qoHBEITbe6zswn7lt4Zmzk2Mptl7Felqf3jee/zmnDMwU7OsjuGzh0e0cOYZTEtIbT1up2wqT99gv6bi3xurn8qUPUMM4LNXFhJb9z5VNzzDmYEeemU2Mr0om5tGeHGgHsY/KqoRgHBEWW/l1dEeEzF4KMe5LrgWT8JiB2qFm2lv6OezzWLz7rRqNO5SoakLkVageivyc17dyXcky1v9InaaO6YtINx7JLI5383PPigye67mkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vLEUvAbNM1dFqC6tMCqz845gPFzVr1V0idMsDN2tqM=;
 b=S3MZrKClxAmbr71vIcj0JhDHOvJUP6NhW0HI/tLDiDhoaJQVknBynqNfSr6t5lq7q9gs0AjUc4jQGN8Wu54KCHehm8mrcyuCupw98Zc0KkUedjruP45JvntHIE/XMDNmMNbAYrf8/yaB5CTZXQNsExtQzNDM9c9wtBYYnbwfpxkMW4pzCyh6T8ZMHHYhcvnYL8DBA2VTLgg8sBG0AgCqymsqPsuixYYc15vmQgs79dHbHUkY+X4gEYrKrS2Fz+QVwxWYVlaboFauQTuTMei0FJzXW21ebzPUKqEjBa/vvQy4ytWBatx4yKqxQmCo64WUS+ynuXw6oCdvWX83Ke8uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vLEUvAbNM1dFqC6tMCqz845gPFzVr1V0idMsDN2tqM=;
 b=nPuA3uxmeZLufFUXewO4KkEPrvi6YuWPYie5MkHZ/9eZRLIH4h592zbvU1taxk5riyV5lG2z9mkwqkBx4Xabbwx6NR6smijbSW6gkJb/xci7+t1+cOLMJ7n9HwdlCDfnw/qiNDIzK2vkcFKck/s+dgCSvjj/f9bzcZ0rJqItYio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 16:37:31 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 16:37:30 +0000
Message-ID: <23f0b99b-9f14-4da8-954e-5d175aca1ab8@amd.com>
Date:   Mon, 6 Nov 2023 10:37:29 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
Content-Language: en-US
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
        Avadhut Naik <avadhut.naik@amd.com>
References: <20231002195932.2501674-1-avadhut.naik@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20231002195932.2501674-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:806:a7::14) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bc30ce-e79c-46f5-6242-08dbdee6ab95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rXOOo5WC+7Jb3uArZf8gzx4YbMQLeYai96D9lLStsohYVJWPtb0HgWIQmmuL+twkIJjKjyvqg1Y8bFLQ4Xq+/DkwAf3T/SBYgsllYthEuoydBeeq74PmUZvcmxggc9gXXkqa6H0U23YRsPTKuRxNamN2BytP6AOV0PSgGtIcrOdQ8DPCPwGhfEW39+z/I4EjhFvzAEAPgVvS2GFyRajp0mEl1tZXPyzlxOTE2MniTDy/066UGFH4Nv+fIvXM3Iklu34LYfqzOuZlLTqrHoQbRFu/MpYWkzawG1bm0pR/8G9plpNSvIwDGns2liObo2UMyMFe7+H4bbmMEr/YC92pQwwt+TeaE64HFqjeM5oQH/6MpAQgY/h51ms8LOITnSAGBz04H53wjJrOBtXxmBZi7fkQs8DpcsvfF+NAtZtTVnq9OLL3eLpLb18OplBXzBFd797vjFwFCE5QbrxOsYDGPANxp8l91jkhAkOpYk1+mv0VOKngQj5Icfld6gmt8HNesMTA96VX62enEUIU/pbg40yM0RLkT5xE6hBSwaMVC4BDo+qa/TyRr+IHjJWTIL4CMuIwTCC+K5WISGLAc+tW14/Tyjg3Q4haRM3QNahdGpR6e/vTGPhuBu4/wnqZFirVPznRvyatXolfrJEQTLa6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(53546011)(478600001)(6506007)(6512007)(2616005)(6486002)(83380400001)(26005)(2906002)(66556008)(316002)(41300700001)(66946007)(5660300002)(66476007)(8676002)(4326008)(8936002)(38100700002)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNOYlFZamhnS0hlR0QvTFRCNzllZmhwdXZjdHh3QXBCMzVnUitBNUluajhY?=
 =?utf-8?B?K0ErVC9jVVowRHFOaGxrQVIxSW8rTnhDVGNydTVMdUxSUlN4cmNPTHFtTG01?=
 =?utf-8?B?cDVvQzU0cGI5U3hkVnpwa1V6bEMraGVWK1VVTlM2dHNCWnR3ZndOVXdLK1V6?=
 =?utf-8?B?MUNOZ1ZZZ21RL0dHcld2cUtpTVZNTE02NjRXUWZybXErd3lTcFF3ZGJGWjNz?=
 =?utf-8?B?NUd1U1N0SjVhdlMzTUc5Z1FGaFc4N3ROS1VZTXhJTUk3ODlDbGVaSGVTMS9M?=
 =?utf-8?B?Tjd2YWxCS3pMcU5qb0kwaHFkZXBQc3RxOGVsaTJNT3RJWW1IcFk1YmVsY0xn?=
 =?utf-8?B?Z2Y5eUJXaWV5MDMxYkljZzdGK0NKK3p5VUJNaWhWaVVyRHkya0x0M3FBYUhE?=
 =?utf-8?B?YnhvRHhweU1ySitiZlkyRzdieTRteHA0ZDhRTSt4aHlVdU5LM1VoMkVQdms1?=
 =?utf-8?B?SUtuVjUxUHFHVVhoS1dSL0NLTndObCsrV09hN0VaMW9VUUpKVmhTaW1pdzFZ?=
 =?utf-8?B?ZmVFRU1oMVp2V3llekcrMUlseDhuRUJZRk5jZEk5bFVsOHEvaUtxZzZDNzBq?=
 =?utf-8?B?aVBqVDRDQUdTbHI2MnVJWjJMeHRPWXNhaVhET09kYUcxekEvYzZDVGY2b1dI?=
 =?utf-8?B?ZkttUE93RXo0bzV5c0JTNGZRaXNiTmZ5ZG9RSUF0SHBpK0xaRnl6UHdYdWxo?=
 =?utf-8?B?VGtmQ3JpY3BoWmNlNHhUdzhBeEJaMFJnOWsxR3VSQlQ3dFI3S1lDRTNKTzdj?=
 =?utf-8?B?amE5YTJnSEx3VmRCUFI0eThRdUFCTXVDbmhGUGN1NUR1T2c0dEl0MWxqbTdG?=
 =?utf-8?B?Rk5keUgrKzFSSXdweUhMOEsrL0hjM1o1dm5iQW80WmFlMVhzejI0cUhBaTZv?=
 =?utf-8?B?YmlMVmhwVFJDSStHV0p2Wkd2SzNQUzh1Y0Q2RTJzdjdXYkFXcUEvdDNOaSs5?=
 =?utf-8?B?em84VUVFejZMT1FROEJjclMwZDk3Q1BJYWtJYnkzNk9Ib2p4a2tSYlV6Wm9U?=
 =?utf-8?B?MEE5b2JZL2FkakF5OWRvNXlEQnAzSGp4MnhQak8wZmNienFGaXhkMVZGWHpi?=
 =?utf-8?B?V2tweitNbzZZczk3T1pkZVgydkRUNFpjS0cydFNHVUYrZWs2UTNHdDV3RVZV?=
 =?utf-8?B?VlJGRTQza0RDSDl5YXVQWTFEa1JKS1FnWVpsSGpudFNJMVg1dGp2QlhqVzVJ?=
 =?utf-8?B?TDQ5alVUYVlDZlgzcmlLM0w1UzgyZVV4cHJpeDE1elZsT2liVytEUHd4TzJh?=
 =?utf-8?B?ZFYvTjZXUmJJVTl6WC9JaXhXYW1hb2pJNCt5M0NETkFxZW5oZno3ZFhyaGJO?=
 =?utf-8?B?UEhqREhiN05uN1hpSmMrMTU0TkhwTm9HQUVYNmg1eDRPNUNsTVcyNmUzY3Yw?=
 =?utf-8?B?UWhEZXBaWlczZCthTEovT3FYd1RNUDNjNDljSE9VTzBIRW4yRjZnTVhBcitz?=
 =?utf-8?B?eTQ4a3NqQU5KSjVETGt2cTdrZkJWU3pyZ0Rrd0hUdGkwMjU0RWhVZVNZd1JO?=
 =?utf-8?B?cjF1RHJObVp1STZsZWhCY1VBS2xlRDhtUjFzb29uMGN3QTE1ZGU4ZEdBU2ZY?=
 =?utf-8?B?MWMyaEd3bXBQd1g0UEhtdUFaRjJSYS9EYk1YMDlRbkpXdjhmZi9lOG5jUDRu?=
 =?utf-8?B?Ris3R3l2ZzIzSUFJWHhmUnc1c0JhYmhJZThXeUU5Q3ZYd3d5bVVnQjFUQWhp?=
 =?utf-8?B?MXl6VzEvM0pkSEpNT0FnRGU0UjNEWWtJMC9hRlJGYVJaUTJXUG5PRUZDcnJz?=
 =?utf-8?B?dGJ4TlBwcXN5cDVQZ3NIQ0dnRXNoMUJ1N1h0Nk42czVham9RcHEyM040TEJp?=
 =?utf-8?B?SEIrOEFaM21FUkhXY0huTXNKWGJYdlpYUzJZOGpnczhQSkFyVkRhazdHOE1i?=
 =?utf-8?B?dnIxRkNUNUdGWHplVmh0VU1WSmpFVndKUFozbjZkT2lDUnc5eFlNa0RCODFV?=
 =?utf-8?B?UVZrZTZYekFlMUx3aTF2b2tNOENRZUZldFBnSmFkejBhOFMycWtMNnNHZnFD?=
 =?utf-8?B?MGEyNWhpLzBiMHpCK2thK0Q5bjF4WFFnb1BleW5kWFFCV2luby9nMmZEYzU4?=
 =?utf-8?B?OUIzamIwZWtOWHREM2FBUmVIQjlBTDQvSmsvTzAzUjlWR1NGU2dzRmVrRXcr?=
 =?utf-8?Q?pZ70SBuBLXLoDXQ0OgkYc0+er?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bc30ce-e79c-46f5-6242-08dbdee6ab95
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:37:30.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehwCR3sXcDA1xUqThztP2cUOPKIjFp9IvRH8IbkMC/D0Vcks4gpALQYNjtorifgDtTQ5IFLi1Oq8HsFE0TFYkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments on this patch?

On 10/2/2023 14:59, Avadhut Naik wrote:
> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> a set of GHES structures is provided by the system firmware for each MCA
> error source. Each of these sets consists of a GHES structure for each MCA
> bank on each logical CPU, with all structures of a set sharing a common
> Related Source ID, equal to the Source ID of one of the MCA error source
> structures.[1] On SOCs with large core counts, this typically equates to
> tens of thousands of GHES_ASSIST structures for MCA under
> "/sys/bus/platform/drivers/GHES".
> 
> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
> such, the information provided through these structures is not consumed by
> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
> to provide supplemental information in context of an error reported by
> hardware, are setup as independent error sources by the kernel during HEST
> initialization.
> 
> Additionally, if the Type field of the Notification structure, associated
> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
> sets up a timer for each individual structure. The duration of the timer
> is derived from the Poll Interval field of the Notification structure. On
> SOCs with high core counts, this will result in tens of thousands of
> timers expiring periodically causing unnecessary preemptions and wastage
> of CPU cycles. The problem will particularly intensify if Poll Interval
> duration is not sufficiently high.
> 
> Since GHES_ASSIST support is not present in kernel, skip initialization
> of GHES_ASSIST structures for MCA to eliminate their performance impact.
> 
> [1] ACPI specification 6.5, section 18.7
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Changes in v2:
> 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
> if-else-if chain is redundant. Replace it with just if statements.
> 2.	Fix formatting errors.
> 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..99db7621adb7 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>  
>  static struct acpi_table_hest *__read_mostly hest_tab;
>  
> +/*
> + * Since GHES_ASSIST is not supported, skip initialization
> + * of GHES_ASSIST structures for MCA.
> + * During HEST parsing, detected MCA error sources are cached.
> + * Flags and Source Id fields from these cached values are
> + * then referred to determine if the encountered GHES_ASSIST
> + * structure should be initialized.
> + */
> +static struct {
> +	struct acpi_hest_ia_corrected *cmc;
> +	struct acpi_hest_ia_machine_check *mc;
> +	struct acpi_hest_ia_deferred_check *dmc;
> +} mces;
> +
>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.cmc = cmc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>  		struct acpi_hest_ia_machine_check *mc;
>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.mc = mc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>  		struct acpi_hest_ia_deferred_check *mc;
>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.dmc = mc;
>  	}
>  	BUG_ON(len == -1);
>  
>  	return len;
>  };
>  
> +/*
> + * GHES and GHESv2 structures share the same format, starting from
> + * Source Id and ending in Error Status Block Length (inclusive).
> + */
> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
> +{
> +	struct acpi_hest_generic *ghes;
> +	u16 related_source_id;
> +
> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +		return false;
> +
> +	ghes = (struct acpi_hest_generic *)hest_hdr;
> +	related_source_id = ghes->related_source_id;
> +
> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.cmc->header.source_id)
> +		return true;
> +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.mc->header.source_id)
> +		return true;
> +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.dmc->header.source_id)
> +		return true;
> +
> +	return false;
> +}
> +
>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
>  static int apei_hest_parse(apei_hest_func_t func, void *data)
> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>  			return -EINVAL;
>  		}
>  
> +		if (is_ghes_assist_struct(hest_hdr)) {
> +			hest_hdr = (void *)hest_hdr + len;
> +			continue;
> +		}
> +
>  		rc = func(hest_hdr, data);
>  		if (rc)
>  			return rc;

-- 
Thanks,
Avadhut Naik
