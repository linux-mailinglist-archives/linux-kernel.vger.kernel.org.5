Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B727B5867
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbjJBQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjJBQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:52:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C87BD;
        Mon,  2 Oct 2023 09:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1nXuRaXsStH/9bvUmsULS8lLWt0032UEJ/K+x009SyrWxscEMrYUvJJD5jtwy6578V4ioswWYtPhH1ne/kruHeRUhCNYkzOs0LolLJDqCMHxmSDU+uLB/thsB1HGDtoPS+SlpIuey68pmUsBWL4h2LOadXq6PurJUQl7vs044uboaI0YjziwQEtY+4ca2hI9dvjNML4E6cAYuBtBODiWQm26/RalnPPvCaoSyWkjSeHXa9iwnDLF5lKbG3AXvkFgMadyv36Bcd6HQ2Vwz2xmaPUmwudkR0XQBLd1P1GxXzy4iNKrAwVMxkhBomuSmA/+U+eHjEwRyGtS2biSQHzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXol8mJ4dR82y+yoL5BNzlxvG0GJQ9iHpsvGyIj8I5M=;
 b=TSO6MtIAu7/tPpKAW1M5bn6s8avsxugSOAuPXNtCANLwvmyQiAfp1DkzIw7M388lp3GKZwVPzHGEHNhRqH0EmRcAgqcRunn8O6/EAzKlRmQbrnLdckXSd07VGW1D/ehZNi3CxqmYCtfWfz/f78nykWQ4yxjHkJAZpXdpr8qcjgrQIHHdY6UgMlxoa2X/2rQe1F449CsYFbRhQFU3KaucpGVh4rFcx8b0DMlgJWbawYQ/Vufnn9PYBpyXPph5RS8sZkcOr5n+QNsebakBaRdvc7+Zsopt1J6hpyxTy/t5km4RIhlomtfbG7U3t9BGvowiyNJwNUaZ+s+Qj578qoaUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXol8mJ4dR82y+yoL5BNzlxvG0GJQ9iHpsvGyIj8I5M=;
 b=mxHWRDQhF7i4VjWnVD/FBYO3QxaQn3j7lD3Xu1g49RJNtux1f8VVMylP0I6WIE3u8Nt2Lb+m6jbufvCbhJvqZ3X05vwgs+MNptKeyAVhKxgtqQzDdfTBzSJzmqNh4QEsQI00L/Sh1ZCtb5V6WrINsqHTxAsc3FRviiABclMxA0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 16:52:33 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::1a39:af64:ad41:f0cc]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::1a39:af64:ad41:f0cc%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 16:52:33 +0000
Message-ID: <44d3f6af-9a9a-c0d8-913b-ee6be6bd892c@amd.com>
Date:   Mon, 2 Oct 2023 11:52:30 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ACPI: APEI: Skip initialization of GHES_ASSIST structures for
 Machine Check Architecture
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Avadhut Naik <avadhut.naik@amd.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230928184204.1511111-1-avadhut.naik@amd.com>
 <b88e1f4f-1e85-46ca-b317-d8e10fe894a3@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <b88e1f4f-1e85-46ca-b317-d8e10fe894a3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:805:f2::16) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a553f4c-a1b2-4439-6f27-08dbc367f8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rh8S/lHk2cFNeagbaKg40+GA/NH6eG4UxSbDAN5rmVsQdqvwWutvK406p4oy36Idb5urc9EPwdAyWBXsBf1uNU1E0wjLP4odb7+ldQGukByEApOv0ustTc6/xaOXtKxWWg+1a9d164WJDisU4qFONsPJgqkAtD/GXSN0beNLT9xigBtJDykrDBrhKxrHR5S7s4LJcOirGNKtl3Cv8UXDWcVJvlYoGvAqP8Eg3Hd+D/i6Svdc2EAGL7ujgmHO7BRMwipVPnHwRn9E20QbTlOwIJ/x/RL7rN4U8FGDty4xQhznzTOXtYOSpoDyrZ4iWfMMcf+LSTA2xQw0XsLNvR152D0W2td7CIpr1axhNVmbKvrTIgtrwq/Z0YK7GcwJ+CRbqJ4ZaEitXSxyFJcFREE4XDZKkjRqTYDBbCZXYgwvcavM0tcBx3ME5ov2LcZ+7iCgzYBP/nI29ed5o/a5TxYh2GiVWx/VoltujHFijkTIJm+cBYv/GXndMXWmToUGvXSAA4lXo857lbsHTkcyuFuCmOnOlHF/qlaDAEx9kIeaKpwJXMrlKO0ifsbRzxIPsWKqPYCrvxOmVaS0mmH8BSAbB0QQ65oNCNW+fvDi8/HsEm5mK+G9VHL2YmeIS8GiOl4qc1Y+IKt2TZzmUQz8I2VqsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(66946007)(5660300002)(31686004)(316002)(6486002)(66556008)(478600001)(66476007)(53546011)(2906002)(6506007)(41300700001)(8936002)(8676002)(110136005)(4326008)(26005)(6512007)(38100700002)(83380400001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmtiZHhoRU0wb0tPTkVGd3ZYTFZiZUxNemljT0dVZ1pqV0Y2ZWQxVjBaVzg3?=
 =?utf-8?B?c0tNa0M2c0NOQlZZUHNweFpTcGdhRjdHcEg4Q0tmaHFQd1NWbHFqSXFzNlVp?=
 =?utf-8?B?UkhTcDhxTUJMNWc4UjVWQWxld0pPK1ZlNGVyNXRpeVRyendDbzgrTy80bThz?=
 =?utf-8?B?cm1wc0ZYelpzRVN4VUxLdk9OWW4xQUJucDZXbWdiNkh0T0o0SDlhTmp3TTRt?=
 =?utf-8?B?MldYK2JVN2EvZGwrZjZSN0RXaWIwd0tOTE9XVUk5Z1ZPbW4xUkJENHB5cFQ5?=
 =?utf-8?B?MUdxcUtIWDFyOXdQWU9PUzFnSkFHNUc1dDV3TTFtSnZRbkZQMWV1RnBkaFZp?=
 =?utf-8?B?cDJramVNUEwwWjcxU0hGWlNwandEOHM4UlBkbk1xNlIyQWZNMGdJd3V1aWtp?=
 =?utf-8?B?MGJMT0ZVVTk4bDV4V0lXK1RYZGNEMUNCRFdqV1lmVCtYckR3R05FZ0hEcnpR?=
 =?utf-8?B?Vmh3K0RUY044YVhId1Vub1NYbGRxQ2JhYVJ6VjNkWm1qb0VVbjFXc1FUcjht?=
 =?utf-8?B?d281NzdZeDhVTTVDTEpiNm9SZWxvcXF2Ylc2aHFJSjdCMDRCU0wwd1lFR0xD?=
 =?utf-8?B?YkZ0YWdnQ2Uxd05vaEFUbzNNMTBKNExJM3N4SDFVOHlMVzB6aTJReFhTOHRU?=
 =?utf-8?B?djE3c3FPUEgyUktaMU9RckFDODNua3ZFM0daT1NiS2tqdUVIWTBTVDRWWjlG?=
 =?utf-8?B?bXlXK0dFMnNkdHhQanM4VklhVkdWdFVhWHpJY3BjVkJCeUxwWUF3Z2o2L3FF?=
 =?utf-8?B?TlN3S1JQSlBJcTN6UEJGck9pWlBhd2xXUHQxcDR5Q0phUld6L2tmZDY5N3JM?=
 =?utf-8?B?TWI0cjdyYktCOWErSmVxY1M4a0ZmNVA2L2xLTTdybzh5c1hwQk14aEhuSUpW?=
 =?utf-8?B?Rm1QTGhmYkpOaUZUVVgrVForZUVVM3VZRkpZUDR1UE5YUE1Kb1hzWXZabUEy?=
 =?utf-8?B?MVJTL0xiNDdyallaVzYrd0pGUVR1QkpHUXlhUkZwU1VrVGM3VXY5RC9UZncz?=
 =?utf-8?B?blZEWWVaWlVPZXNjbjZEUXFLMzQxS2RZcjVmWk13aDR3ZlV3T2pyQkdGOVRq?=
 =?utf-8?B?ZHQvWFlpWmI1SWtFbTZGYWlzWHYvMm9ZQkRVZmNWNU52U0JUbE9ZZjE5cDNv?=
 =?utf-8?B?d0l4UkdZbzlxbERjdmIyd0U3bjJEVEhtV3Q4aTBkakRhVnFBTUxjQlMyU25n?=
 =?utf-8?B?ZTZpWHBJS0Z0TloxUW9OdDd2VWtwd2VWNkNxZzlFVUUxSStSZ1ZhNmladHEw?=
 =?utf-8?B?S1VLOWthTEpyK0FLRXpOT0MwRDZTNjJxV2xwVjB4TkplRGc1SkJTS0xCUThB?=
 =?utf-8?B?K3gxNG5VWHVIUGExRllObmRaNlRabUVqb2NqRVdOSTZBWDlmNzc2RVZmdWFp?=
 =?utf-8?B?eEZNS240TE9pd2JYN2lIMjQzRDJ3SytwRzRYT0s3NU5mc3pEYmxLVGJyMDR0?=
 =?utf-8?B?SmFzcVkwK3l1bWdCa0x5dXhTL0J5Z2ZRZWVVUEZ1eWJNZkR1RDdoSThTWFBx?=
 =?utf-8?B?MTJLUjFxMGUyZjlBZjVMcXZaREpMSDlnaFpDUzFyYWZnMjJkWjc2MUVBTkJo?=
 =?utf-8?B?ZlFOZGxHWC8xNlU2Y1g2YllJS21jRVlzeEZWaDZOeWlVb1dWb1ozakh1ajlo?=
 =?utf-8?B?ZUVXVlZ0clB5RmRZZUsyUk1qWFM2UWhKaFhzdDQrbWJvOWxXK1BCN2xid2kz?=
 =?utf-8?B?QklNRFdCYUtaMHFMWUYvQnhKQ01laVNFbHNIN3V1M2NQMGhyUTVrZzVmK3Ju?=
 =?utf-8?B?MUJTdHloT1MydHVKeENyREFwajJuUVVEQkpkZ0xwS0JBRVRZZUg3dlAwdlhO?=
 =?utf-8?B?bzBXNmxYSmV1Rnk0RXdhanlmaTRhUHhhMURwdDJ3ZVhZU0E0RE9QdnYwQnhH?=
 =?utf-8?B?LzhlMUU4K2ZJYkhrdnlpYm53OVQxalNINGRuenhhK1BxY1g2V3VYdWxsbVNn?=
 =?utf-8?B?SXptWlNJYTV0RmlvTXArTW1RK0QwWkZYcEJnQlpBeExNa2RXY2hOUTFQVFZt?=
 =?utf-8?B?NDdsKzBjT0FvYmtjeEdOTERHUm1aRllDUUVqTmw2YTRhV0gvMXZNT0FtOEVO?=
 =?utf-8?B?NTk0d2RTTmlTY1JVYjBwaUhqZUxleUxtcmhvcHZicTFhWGdCay9uRzVWR0dq?=
 =?utf-8?Q?4wzbLBTcIbRdBKYRtb3pidWGZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a553f4c-a1b2-4439-6f27-08dbc367f8d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:52:32.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvmrGguRP8MAWRCBSCaKqMwkEbImZwd+CZF+JkeDGrHJL9IaB7aiXPVN4ZrwwTpTUPyx90ss05CQBkffgtjDSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/2023 09:40, Yazen Ghannam wrote:
> On 9/28/23 2:42 PM, Avadhut Naik wrote:
>> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
>> a set of GHES structures is provided by the system firmware for each MCA
>> error source. Each of these sets consists of a GHES structure for each MCA
>> bank on each logical CPU, with all structures of a set sharing a common
>> Related Source ID, equal to the Source ID of one of the MCA error source
>> structures.[1] On SOCs with large core counts, this typically equates to
>> tens of thousands of GHES_ASSIST structures for MCA under
>> "/sys/bus/platform/drivers/GHES".
>>
>> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
>> such, the information provided through these structures is not consumed by
>> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
>> to provide supplemental information in context of an error reported by
>> hardware, are setup as independent error sources by the kernel during HEST
>> initialization.
>>
>> Additionally, if the Type field of the Notification structure, associated
>> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
>> sets up a timer for each individual structure. The duration of the timer
>> is derived from the Poll Interval field of the Notification structure. On
>> SOCs with high core counts, this will result in tens of thousands of
>> timers expiring periodically causing unnecessary preemptions and wastage
>> of CPU cycles. The problem will particularly intensify if Poll Interval
>> duration is not sufficiently high.
>>
>> Since GHES_ASSIST support is not present in kernel, skip initialization
>> of GHES_ASSIST structures for MCA to eliminate their performance impact.
>>
>> [1] ACPI specification 6.5, section 18.7
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  drivers/acpi/apei/hest.c | 49 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 6aef1ee5e1bd..03cb0ece4235 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>>  
>>  static struct acpi_table_hest *__read_mostly hest_tab;
>>  
>> +/*
>> + * Since GHES_ASSIST is not supported, skip initialization
>> + * of GHES_ASSIST structures for MCA.
>> + * During HEST parsing, detected MCA error sources are cached.
>> + * Flags and Source Id fields from these cached values are
>> + * then referred to determine if the encountered GHES_ASSIST
>> + * structure should be initialized.
>> + */
>> +static struct {
>> +	struct acpi_hest_ia_corrected *cmc;
>> +	struct acpi_hest_ia_machine_check *mc;
>> +	struct acpi_hest_ia_deferred_check *dmc;
>> +} mces;
>> +
>>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
>> @@ -70,22 +84,53 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>>  			sizeof(struct acpi_hest_ia_error_bank);
>> +		mces.cmc = cmc;
>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>>  		struct acpi_hest_ia_machine_check *mc;
>>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>  			sizeof(struct acpi_hest_ia_error_bank);
>> +		mces.mc = mc;
>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>>  		struct acpi_hest_ia_deferred_check *mc;
>>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>  			sizeof(struct acpi_hest_ia_error_bank);
>> +		mces.dmc = mc;
>>  	}
>>  	BUG_ON(len == -1);
>>  
>>  	return len;
>>  };
>>  
>> +/* GHES and GHESv2 structures share the same format, starting from
> 
> Please follow the general kernel multi-line comment style here.
>
Will do.
 
>> + * Source Id and ending in Error Status Block Length (inclusive).
>> + */
>> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
>> +{
>> +	struct acpi_hest_generic *ghes;
>> +	u16 related_source_id;
>> +
>> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
>> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
>> +		return false;
>> +
>> +	ghes = (struct acpi_hest_generic *)hest_hdr;
>> +	related_source_id = ghes->related_source_id;
>> +
>> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
>> +	    related_source_id == mces.cmc->header.source_id)
> 
> IMO, there should be parentheses around statements with multiple terms
> to improve clarity.
> 
Had tried that but reverted since checkpatch flags them as CHECK. Something
like below:

CHECK: Unnecessary parentheses around 'related_source_id == mces.cmc->header.source_id'
#107: FILE: drivers/acpi/apei/hest.c:122:
+       if (mces.cmc && (mces.cmc->flags & ACPI_HEST_GHES_ASSIST) &&
+           (related_source_id == mces.cmc->header.source_id))

> 	if (mces.cmc && (mces.cmc->flags & ACPI_HEST_GHES_ASSIST) &&
> 	    (related_source_id == mces.cmc->header.source_id))
> 
>> +		return true;
>> +	else if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
> 
> The "else" is not needed, because of the return.
> 
> IOW, use "else if" when you want to skip a check if the previous "if"
> was true. Here the check is already skipped if the previous "if" was
> true and did a return.
> 
> Also, the order of the types is "cmc, mc, dmc" in the struct definition
> and hest_esrc_len(). But here it is "cmc, dmc, mc". This is just a minor
> nit about consistency in ordering.
> 
Understood.
Initially, was using booleans to know which conditions are true and
return appropriately at the end of the function. Hence, the else ifs.
Missed remvoving them. Will do so.
Will also change the order to match struct definition and hest_esrc_len().
>> +		 related_source_id == mces.dmc->header.source_id)
>> +		return true;
>> +	else if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
>> +		 related_source_id == mces.mc->header.source_id)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>>  
>>  static int apei_hest_parse(apei_hest_func_t func, void *data)
>> @@ -113,6 +158,10 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>>  				hest_hdr->source_id);
>>  			return -EINVAL;
>>  		}
> 
> Newline here please.
> 
Will do.
>> +		if (is_ghes_assist_struct(hest_hdr)) {
>> +			hest_hdr = (void *)hest_hdr + len;
>> +			continue;
>> +		}
>>  
>>  		rc = func(hest_hdr, data);
>>  		if (rc)
> 
> Besides the minor formatting comments, this looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik
