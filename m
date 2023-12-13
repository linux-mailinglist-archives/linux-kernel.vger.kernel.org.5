Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8548106EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378061AbjLMAs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjLMAs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:48:27 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F1F4;
        Tue, 12 Dec 2023 16:48:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh6T+KiA+VcZ5wyWgxl4GDGI2p0IFI7hB8j25HPn3HFBw95IH9r0gBIM8BMMkSYGStkq+G1M9DioDjbJgxIUxa/eDP3jhOyhGp5Hia+BMu4gFz+hSDT96tEmJR/zrwFrv6UQzPm8hT1QoRhue0WR6wBS6y4tnOWpiecXCTTriDzyDq1j5j8+twEtEkvT0mj9MEQ8wxRcApcat8ifJ1MM1CVwYZMS/qbpfXI5Yp/yRW9pLwTsRZrDf9BiJA6jZecSsXv356xa6slIgRhRnKYTBQszNgmR62SQqkc00XKSJO6DUtVzPCS2PKlGLuo/yGrOlu/mZ0ZURl3fUS+r5nDsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW1vTIPSxvBYyBJVEQTKTX4weWuKtkgplEeksV1EM/w=;
 b=nPZDI7jQAQ/yeZgkfnA559jb6oSSjWcCjlOZUXKBTr63+5XR3blcnppRrU1b8pkOfRx6aOaXo4lyy1hZRctI5ymhfTMeKN68uGt9nGETSYU6PVQfvk40hCsfw+YNmtFMnTLKYKv1N5bBC4JiPcnJyb3+K0v4fjv8dLRsWruFAizVoXyNJNf5OePLBRiQPfKF542kP8KimkkMjhJz/j33tKL2LGVriCccvs/WwDNiU18p+08UdLuCILFkPNUjMSChMEEbDak+nW0E1q97BhfIf4BTeByw5INhmDYBnkZrEuYKjwckQKSOGUEvZhUPMgsGBF+Ld0LZJXIJ0g2a3Btbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW1vTIPSxvBYyBJVEQTKTX4weWuKtkgplEeksV1EM/w=;
 b=XHccyqPlKvKYqQpsezVStuPVJVcO3dIDrHaLsbA2DVKa+UgnSDNwCY6KY01KOlHrvspV7xt3R9boLnC+tYL0OW0iV/zVyBCOxMFmchi+1sWl0PNtVSeDZjf77XX8igmm5/NvJZpiFMs80mHsKU7KPjtinyFvZctDdNlTpiYduxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 00:48:28 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 00:48:28 +0000
Message-ID: <333bf7dc-7a87-438f-a4dc-fc5e254ae049@amd.com>
Date:   Tue, 12 Dec 2023 18:48:25 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/1] parse_phat: Add support for ACPI PHAT Table parsing
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
        Avadhut Naik <avadhut.naik@amd.com>
References: <20231212195219.2348858-1-avadhut.naik@amd.com>
 <20231212195219.2348858-2-avadhut.naik@amd.com>
 <fd5e2d54-1309-48a9-8458-ee5f2ebb039e@infradead.org>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <fd5e2d54-1309-48a9-8458-ee5f2ebb039e@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:806:27::11) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|DM4PR12MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: fdad2992-c602-4ce5-7702-08dbfb753848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGZ7u90OOp3o5X8abpE11uoqgv5UxRVogNFy8Sdr5X7aaSup7kxsOKC+QgyKhE0iRer3vO0oyvIup+ULGDR4OkrDdlLaylZl3xjRz1whVEsi6m0ANCDku6t6UoHQaitmgCUsrK49B2D8zdDc5XqdSLc8jDbsp4Fbi6t/tod5dl/mp3XfwbVWEzHjKo5XlFE7nR23AhsZifKmRtpyVHT854Cnbd18Y1AEqvxyG2/npy7QWwRUrVKW7s9XhnSSYrDB0VXI4RlIHZrqVikXFHNACkFrJaXf9TQSHkFyMfvgqeLW7c6O/BPMo3seTcw7dcgO2XeSvas+ZifLy/uBF42ikn3dKtnTg8N0LcHi93TkJEbSUnrN4dXKbkBOBGOVkpnEwEYimG1BlGH3duFw9oY4j1G+LTseKlXki+oU6xeAHrjBRqHz/namNTnTj0/x9JoM3vxz63mfte7xjIrTczqajp5G6o+HlS2Ev9kALRn7J7tPCcAvPqpHF7SjctBfwBaGVIO8fRYJxKAXdKOspXOJGi/YuAQM9ddDn3RcjJ+lR2jEYdikz+E/3dDxSTA5wXWSNtJqp1o3+LVPA3DlwZNgxp5+DjvgG2rIZwLwKronLsxyhMzzUnE5xwjkqY1aezYtok6Vl7JM+al+L5YwTuyWxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(6506007)(6512007)(2616005)(6486002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(6666004)(2906002)(478600001)(26005)(38100700002)(316002)(66476007)(66556008)(66946007)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZ0R2RXSmtxOWk0VUh4SWl4MUVScGVwNWxyQjFmcDRaVGNKRk8rMGNIclQ1?=
 =?utf-8?B?K1JKSzgvbnUyVVhlY3VOUnI0OU5yU2JlMGJNQW8zOWFuWkJlUG0vQU5ETUlR?=
 =?utf-8?B?eTdZVjRjVkhLY0w5aWZvcENzdlJnRkVVQUloUzNTdVNlYWNzZHlBRmVRMVdH?=
 =?utf-8?B?M29VMlFPalF3VDJuUmNrZlU1eU5rUUV5ZHpjVjM4WHRiR09uZklUODdxOXl6?=
 =?utf-8?B?V2pUbEpabEdkYUtDNnRTVSsrSmtuNVRJK2JTMGQzdXI4SDQvSS96UTdSbGFH?=
 =?utf-8?B?bWlDNE9pQlBxVm52Yk9PREYxNXB6RGEvL1F1N1NwM3FZQ3ZwbjZlY2Q1alQz?=
 =?utf-8?B?aGc3WDV3RVRLM29KWGVDVWkvaWEyU3pQcVMxWEo2M0JuNXlzRll1VVd1U2o2?=
 =?utf-8?B?RENSUzZqV2JVVVY1UUVkTDBIbGo2YzZDTzRFNmlvQ1lja2RobUtOUkl0dWVh?=
 =?utf-8?B?ekVPNHpnMXJLYWJVWDgzTysrUUU2bHgydWRUdjhpSjBpTE1Ga1A5ZWFnWjJ3?=
 =?utf-8?B?OFAzOE80TlJjMWJwWXgzMGp3Rjlyam1aRVFIL0QrWUZQZFhrdkd0Z2FVUHNC?=
 =?utf-8?B?MTNNWWcwckVkR1NVTXRqdHE2cy9xeUZkS0FGVCtGTlBFc2hHdVVycitlQ3pm?=
 =?utf-8?B?UitzWE4zNlZob0dSeXI5Z0t0UW9NdUpRSnpEbndhbGY2MXN2TWVwSTIydUla?=
 =?utf-8?B?UnFTdm9tUUpWalAydlREM0NPTGozaG5YQTBPQmFvT1ljY05MQTF0YlcvcWlN?=
 =?utf-8?B?cS8vVkh4V21mY1MrWVdoQkMvaW5GTXJyVzJXWU81NHNHMkN1UHZBYm5yV0F4?=
 =?utf-8?B?b0xrZTFhY05uaWVXbGtqcG5WSk94S0FOanVSSkgrUlJ4ZkdubVJoaGNlY1hh?=
 =?utf-8?B?RkpURGVLM2VtWE5udUs0RnZSdUFKU3ZHeUQvMUE3WFU0RFgySkl0a0UyemJa?=
 =?utf-8?B?a0grbDl4eFdXbzZsekQxbk1pWStOeXBTQktIM1RVVWxGTnRUNDR5TktWc1k4?=
 =?utf-8?B?aFE0cXhuT3R1dkpad21DRDd5RkZTYlE2WU9XUFVodTdtQlVzNHZLUDZZdmE1?=
 =?utf-8?B?QnUwbkx6bDVreGZsSm9jYTZPekx3UXpKcld1dHJ4VnpYd29TQkdXR0pTKzV5?=
 =?utf-8?B?K2xMMnY1WDRITEFycGliWndBbGt6RGlCN2hUK0swdngySGlPc0tha0dSMFJ5?=
 =?utf-8?B?TXBtR3U3TThUSlF1cmRQR2VpQTdhdUt3RFhDK05XT0xkTnJtSE93dmNlODVT?=
 =?utf-8?B?Vm1MakhNMTFDT09YM3BtU1JXdHJycWlRTXp0bnJiTkJGZU52TjNOOWZEVXBJ?=
 =?utf-8?B?Q1J4dUNvQ1FkT1pRMGhkQnJwTGdFZzRmYjZDWXJkN3hMY0pyRGplR3ByTW56?=
 =?utf-8?B?NVNpR2djZFNzSjJJM09YRG45bElVWTJTTEp0OUJOUVpleG1Oc0w5SmJUM1ZK?=
 =?utf-8?B?TDY0Ujc0NkZWN2JveXhvVTFOQTBXdEFKWWRkR080aGp0ZUdDOW1sVk1YWmdm?=
 =?utf-8?B?MUFYejQwMXdxU1hHcVRLWlUvSWxFZlRzUEhaVitTcmszZ0VhT3h3alhVYXhX?=
 =?utf-8?B?OS9JTmwxdU5jcDRsNG91SURvVFZSNlh0clhrRmkrMzFVMHFORWZleW1nOTBC?=
 =?utf-8?B?aHc1Q21ORjNERmt3a2F2TEphc09rR05kZ2IxaGp2YnZvNjZnRzhUVUgxNDNp?=
 =?utf-8?B?bnJCQm1NL3krTjl6K0dwZGs2THA0UkRaQmtlbGJWUFQzL2dITFBiRkhBblFV?=
 =?utf-8?B?YjQyZkVOdXZ6NjR4OTVUdGppU2l4aU5sb1pGUzJTUFJUY0doLzJPRTlJL05G?=
 =?utf-8?B?M2wrekxYa0o3ZytLUUU4Z3YzSWFrcVNpYjdZSDVnSnhBK1hwdURiOG15aDJJ?=
 =?utf-8?B?Tmc5dC9PK0YrQVpKYnRUYUJKRS8xR09NRG9FUmJSMHNQcmVUaEZMK1NlYXpp?=
 =?utf-8?B?V2tzUFBPRDZndWF5OVBGdnlKSG5UWkZRTEQyMm5RUmVVc29zTFJqR2RMOVlo?=
 =?utf-8?B?L0NzTkZ5WTFlTkxDOXFjNVc4OWY1VVlQc1FJZ1BPT0hBYWxPck9OcTU4RVE0?=
 =?utf-8?B?V21iSnBHazJZSElEUnZIS3NQb2x1MndLb2NISjdIMElJR2hmbWRKaTJmbTd5?=
 =?utf-8?Q?HalXraVk/Jd0lgY0K4y5dbONa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdad2992-c602-4ce5-7702-08dbfb753848
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 00:48:27.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tykn0l1TapuyqI7mBsPvIRa0PtqgP9wmp+IZQixx3vIiVgvuw9ucASZwzdg1B9dCSdEFAGV6fgshANxr2MAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
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

On 12/12/2023 17:55, Randy Dunlap wrote:
> Hi--
> 
> On 12/12/23 11:52, Avadhut Naik wrote:
>> ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
>> an extensible set of platform health-related telemetry. The telemetry is
>> exposed through Firmware Version and Firmware Health Data Records which
>> provide version data and health-related information of their associated
>> components respectively.
>>
>> Additionally, the platform also provides Reset Reason Health Record
>> in the table highlighting the cause of the last system reset in case
>> of expected and unexpected events. Vendor-specific data capturing the
>> underlying state of the system during reset can also be optionally
>> provided through the record.[1]
>>
>> Introduce support for parsing, decoding, and logging the PHAT table, if
>> supported by the system. By default, the table will be logged to stdout.
>> The same, however, can be changed through the "-o" command line parameter.
>> Additionally, the tool also provides a hexdump of the entire table, if
>> needed, through the "-x" parameter.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  Makefile     |  12 ++
>>  parse_phat.c | 516 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 528 insertions(+)
>>  create mode 100644 Makefile
>>  create mode 100644 parse_phat.c
>>
> 
> Does acpidump not parse the PHAT table?
> Could it?  Should it?
> 
IIUC, acpidump will only provide a raw hex dump of the entire PHAT table, if present,
much like it does for other ACPI tables. The onus is on the user for deciphering the
hex dump.

I'd think that the parsing functionality can be incorporated in acpidump but not
sure if it should be. Would love to head from its maintainers, if possible.
> 
> thanks.

-- 
Thanks,
Avadhut Naik
