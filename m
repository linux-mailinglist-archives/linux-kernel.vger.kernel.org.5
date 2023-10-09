Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3727BE3A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbjJIOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbjJIOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:55:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E22AC;
        Mon,  9 Oct 2023 07:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUpgov4OYcKch7sjRCq5JcAgmnPGU1LEidjzB2gEF/6GWRJYtyvLMpZntWBDyxl6f7dR+cPfGUVNVCxNukQJy0ENwuD8s6sIyMUGjBZel5Ax49Y1iSes5MLWE2RSdIHAkIrGjqiOlHsvKl6K/J/t8Ej+zAJxXjJTVUugY77ruxGU2RZXZysGQYzCjGY0OPbiR+bcdmz07pgVBNGthB/seVm6LxyQlTxtQ3TTkrQRSxurEGlR+lgugv+L1+G41mlWwIICmssnlFu0plSpQ0Hp0VyQirDS95ZZw2ee7EYxmqu3WnH791y77fEHxS9CiiVtkgeBqKQ3m2AXhJdEeq0pBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9SYMNCHGVyvTv/hQKF4NY4DI7MFYzg3TIr5htAAIYI=;
 b=jzXjp+TEtlNq4W/lhWDS73ruDHI7N3pW/4iWsmg4vM4hPGpwGE2kIeSMWexFzfDrL/pXWT0m+qhaIGHasFShQhs8w2HNKHPkJmaew/uLIpE6U8S8YDvypDAUTFZqL8MhNTw4RIPigc9iqjsAVyXYDqQwgCZU5hc7tK5bVAFR6gPiJz8cMNM3dB/KaMOtLbA/CWiyqRW5jfdH6a5A4sRH6OurfwOXaIxmw6B04bNEhlGil6YOXOfkPg5J67pyMwWKUNqGL0KRxIJoVK2DldDocIo9XEz3K49Oe12IMZ5Mn5avxzcOp94V1ue8og4R6YiIJvHyDGEErGvOSwnZ0CRdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9SYMNCHGVyvTv/hQKF4NY4DI7MFYzg3TIr5htAAIYI=;
 b=ElWWX8pfxOL0/mzXIV/XFpXAmRhSAhQf+CsWYsEy9VRUEuCnDo7IpOBq8ZO6IeXzcDibP80LsqU9kTON81c++HD+8dryz9egdo+vFMCvmZVlMDgCCDKdIpjAeL0/1UR8b4uqmSHof17nsKRHHANjiLImHVT8wgaucxfentWwT7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 14:55:34 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:55:34 +0000
Message-ID: <57cd7a00-7d1a-4cdb-b287-df0c8a557be9@amd.com>
Date:   Mon, 9 Oct 2023 09:55:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/20] cxl/pci: Add RCH downstream port AER register
 discovery
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
 <20230927154339.1600738-12-rrichter@amd.com>
 <20231002155334.00004e58@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20231002155334.00004e58@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9801d5-0b78-4804-afcb-08dbc8d7ca50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPEqDzAiMoMyOCMB5C9KFHJQU2KxpUYebICJeeXy4I2bU+EBYfHKtT9BgPWt6y8pfwRz/sfZWKCr4Sk41yIbWAAMIhr5yPDNKGgQlfovgcdn2Q+jVklBPWFmkoEwq4kI1eV3NEcTxuA2Q0SrKVlRo5XJGu+WlFfdw7msOHibXAkJvaApTvDPRJGVTr7tQMHeFcWCkz4Sxo5ydlLvGIbOVGo6BtjfNrJckn3EsSmab/acx0ujP2XNFAbCaZhaGwU/vWL/0tGyBkuiFq6eOqIGr19f+DM/50Y8F68arnDBrqHFfmGemF1EoOk0o49s4gZrrtwm/oW0GchcO23hksmgxxKAEEeLbiqMwpuq70m0vjJuug5HRjhJPaDMmhBwAVxuayX2DmYEiNLGl/7Dwxwyzqz3LBu3hvDNZLNLqbpCWJtwLodC9XOCLuhwVoS9mYxVnt+GoF5XGppY3g9tkObQuXFJmpKqHeAfjpA7mylyiWgUyqLwu6vCbBS5waPPXb+HP6eKJ0xUjgwLdJSVZRpyGOPlPK5iW75r4CIs7k73mTtLMhVXigoY+vhZbXjfgnnTQYgyC5EdU2iPu8kgthtCyYOhYEOqlqSu4+yIik8B+FBKiKYUeEWvuuH7mrq4M+zH8Ha7jX+T7RNV99iLL4wLnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(53546011)(6512007)(2616005)(6506007)(41300700001)(316002)(478600001)(26005)(83380400001)(2906002)(7416002)(6486002)(66476007)(66556008)(110136005)(5660300002)(54906003)(6636002)(66946007)(4326008)(8676002)(8936002)(31696002)(38100700002)(36756003)(86362001)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNOcVhEY0ZIUFRLWDdHL0JRWXVGbzdzM0VQTnlidnRjWHBuTlFBNFh2YzdV?=
 =?utf-8?B?RVNzb0FoS3FlSjRTVE1DWTVDN2ZCZjFMNnJEQmdEbFRNclYxdVRmV2szc21s?=
 =?utf-8?B?TFJRMXBGcStRR3ZDeHFHaTRhaDBRZ0pHOXhQREJISUdkSmZNZGZXMmJxWHEr?=
 =?utf-8?B?aG9UbzBoc05ISDYwaXBQYUV6TkFOVkhXSVVRN0tvMTNvdktYMHhkZkJzaDlz?=
 =?utf-8?B?NzlheHFEcXRtZmZVQ3c1d2hVWjBmdnplOEhDd1cwZ0lHeCtmRGRQUzBUUWFI?=
 =?utf-8?B?RzFwZmplUlFybzZkUjd4dFdYUGtqeHNpK3dSdmUxcVo4TG1qWkJmQ0kzYmhB?=
 =?utf-8?B?ekhkR2MwaGI3MFB2K1F1ZGlHT3Rwa2dUcjI4ZzIrcjcxY2tTOFE2MW01TjFQ?=
 =?utf-8?B?ZXFSaUtzSVBua2NQMzM4RmNlVWJGTmtQUVIzOWNXQlNKRi9WaWJ0dmo2Vkgv?=
 =?utf-8?B?VnJrd0hYSW4yb2c5a2RvZjN3USt0VEgrRjNxNHMrM3FsNmtMbmF3VXVwVTUx?=
 =?utf-8?B?ZFJNbW55M2FLZUxDaFpyR0Z4VjUxMTRoa1ZITjVyR0J1bVV3cGRoVmljZ3BG?=
 =?utf-8?B?VHcyeWQ2bTliZ1c1SUVxbC9WTmtFRjNuMklRQmo1VHVMcDZ2SE1MME1hcVhw?=
 =?utf-8?B?YXJVR0NobFJpR1FESlc1RktOdXZFTnNEbW92Y1krOXkwWjdFaHZIMTFpc2Va?=
 =?utf-8?B?MmR4UlZPSjI5RnVkQkpkL1RCVEVVS25WWGE3QVYzbmowWDM3cFpTdHlGOVFW?=
 =?utf-8?B?a3dBK0t2Z2IwWmtvVytMZ0lJYXpJK3FqY2JFZ0R4enk3c2xENmJIWUw1NXR4?=
 =?utf-8?B?dEFzMWZaNS8xNGpnc1ZXckptcXZyT1BWNmRiNG15QXBkQ3VIcFkzOUIyMHUy?=
 =?utf-8?B?ZVNoYWFkbXJoUWt2WjhCMC9ZY3RZL2lCR0RaZzVxTGliYzg0eW9DRTY3b2tw?=
 =?utf-8?B?OFE1dkpid2NaY2VGOS92cmZJTHBObzFpZ2QrdysyZnUwVEhmR3pQaDdMVWNU?=
 =?utf-8?B?Y2xJV3hGUGtTd2VyL01CRnlCaWJWdElvNXhHblN3WU1uUU9CeUNLWE1DL05m?=
 =?utf-8?B?VjdJQnlMSi9mR2tsV2Jmc0I2aXJYajdYaXdGVGVWQXBxTVpTaisvZ250NzRR?=
 =?utf-8?B?RnNuM3c5QUxNWGlBVDE4UTZlSmlKSkxmVnZkNWNYYkh0bkFzNkljVFdZMzFD?=
 =?utf-8?B?NVNZMlcySlBEenZjTGZiM3BGbnJ1ZHdjMUsxSTBiZ0ttNWpIa2hoODhGQ09a?=
 =?utf-8?B?M1VnRmZGOHdONlU0R2o0cnJBQm9MUDFGSkl5TlVFUHRHckZ6VjF1dS9mZVZL?=
 =?utf-8?B?TitROWlONGVXVVRoV09VaWVINGJ4N3pmcWFyZHpweGRYOFFWdk1ydXJLUFF3?=
 =?utf-8?B?MmphTkFMNHd1YTdtWm1HTk1SSktyZmQxbjhsYkYzSDZaN1F3cU8xSWR6UGpi?=
 =?utf-8?B?SWhWT3N1NThhMTZOMExCUGhESmFyNkIzd1VpMVh3a3BENmZMUUlEZkpjU1lN?=
 =?utf-8?B?M3ViQVgvaEM3OEgzZVM1cmJZaUM5ejRCdFJkOXZjbHBQQ1hJVGUrdUxoVjhO?=
 =?utf-8?B?dU9PQkNRam1CV0NZengrUHhYVE1mSjYzK1ZKSVBPZXQ3NTJ5dDhhQnk1SCtB?=
 =?utf-8?B?SnkzZHJwTGFCSTZOVmFqWldUQXQ0TWhucFhTbCtBNXRTd296MTNqZmJrV1pK?=
 =?utf-8?B?QmxMa3hiaDVabnd6ZjVxL3RzRklidVdncm9WbkgyVmdWSWR6OFkycXhrUVZy?=
 =?utf-8?B?dHhWcXVqVEpwSWFGU0hJT1NWeDkyaVNMeWdhMi9WN3N0b0NzK1hlbmNkaXdG?=
 =?utf-8?B?Q1h1NVV3ak9PVVNDc2UzWThCL0p3V1BHQlNpWnltUkN6Mkp6U1c1eDZlNFdC?=
 =?utf-8?B?aUtSVWp3R1owV0h0NjhIQ0xQek9VUmUyQTkvMkZJYXBYTnMrZ1ZraE9FSEU4?=
 =?utf-8?B?QloxRmtOZ2N6dzJVckVNY0ZESnFjalZWVkxtQm05UTM1eHVvN3g1WC9iV010?=
 =?utf-8?B?d0NEYzZDRklIMnJwc3pYNkxmRElPK0xTRDFINGNzRURrSXIyUGdLVlhmR2gx?=
 =?utf-8?B?Vm9QRStJMGJoeThkeFRvUVZWZUVMeWVuenY5SUZhaUhVRE96Y1ROa1RqY0t0?=
 =?utf-8?Q?KVpkx3M1R/IBb9CV4EFDrIVPi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9801d5-0b78-4804-afcb-08dbc8d7ca50
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:55:34.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ENIn16SKwV4RfdM8SSbRL4Kp+jCx+P+2Lgnn5AxK9luTp347lKZiIg567H1KOY+olNvU8cvVpr6lE/h8U2OOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I added responses inline below.

On 10/2/23 09:53, Jonathan Cameron wrote:
> On Wed, 27 Sep 2023 17:43:30 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
>> From: Terry Bowman <terry.bowman@amd.com>
>>
>> Restricted CXL host (RCH) downstream port AER information is not currently
>> logged while in the error state. One problem preventing the error logging
>> is the AER and RAS registers are not accessible. The CXL driver requires
>> changes to find RCH downstream port AER and RAS registers for purpose of
>> error logging.
>>
>> RCH downstream ports are not enumerated during a PCI bus scan and are
>> instead discovered using system firmware, ACPI in this case.[1] The
>> downstream port is implemented as a Root Complex Register Block (RCRB).
>> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
>> root port.[2] The RCRB includes AER extended capability registers used for
>> reporting errors. Note, the RCH's AER Capability is located in the RCRB
>> memory space instead of PCI configuration space, thus its register access
>> is different. Existing kernel PCIe AER functions can not be used to manage
>> the downstream port AER capabilities and RAS registers because the port was
>> not enumerated during PCI scan and the registers are not PCI config
>> accessible.
>>
>> Discover RCH downstream port AER extended capability registers. Use MMIO
>> accesses to search for extended AER capability in RCRB register space.
>>
>> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
>> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> This doesn't look right. IIRC Co-dev tag should be just
> before the SoB.
> 

Yes, that needs to be swapped.

>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> New day, fresh questions....
> 
> 
>> ---
>>  drivers/cxl/core/core.h |  1 +
>>  drivers/cxl/core/pci.c  |  6 ++++++
>>  drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 45e7e044cf4a..f470ef5c0a6a 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -73,6 +73,7 @@ struct cxl_rcrb_info;
>>  resource_size_t __rcrb_to_component(struct device *dev,
>>  				    struct cxl_rcrb_info *ri,
>>  				    enum cxl_rcrb which);
>> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>>  
>>  extern struct rw_semaphore cxl_dpa_rwsem;
>>  
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 6ba3b7370816..4c6c5c7ba5a3 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -722,6 +722,12 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>>  
>>  void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>>  {
>> +	struct device *dport_dev = dport->dport_dev;
>> +	struct pci_host_bridge *host_bridge;
>> +
>> +	host_bridge = to_pci_host_bridge(dport_dev);
>> +	if (host_bridge->native_cxl_error)
>> +		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
>>  
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index e0fbe964f6f0..6e502f02899b 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -470,6 +470,41 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
>>  
>> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>> +{
>> +	void __iomem *addr;
>> +	u16 offset = 0;
>> +	u32 cap_hdr;
>> +
>> +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
>> +		return 0;
>> +
>> +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
>> +		return 0;
>> +
>> +	addr = ioremap(rcrb, SZ_4K);
>> +	if (!addr) {
> 
> Given this handling exists, below, perhaps a goto?
Yes, will make that change.

> Also, why isn't this an error?  A comment would be good for that.
> 
The intent is to avoid failing the driver probe in the case of missing RCH 
error handling.

>> +		release_mem_region(rcrb, SZ_4K);
>> +		return 0;
>> +	}
>> +
>> +	cap_hdr = readl(addr + offset);
>> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
>> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
>> +		if (!offset)
>> +			break;
>> +		cap_hdr = readl(addr + offset);
>> +	}
>> +
>> +	if (offset)
> 
> Add a comment / specification reference for why an offset of 0 is not valid.
> Of the top of my head I'm not sure though there may be a requirement for
> something else coming first...
> 

I can add spec documentation:

'For Extended Capabilities implemented in Configuration Space, this offset is 
relative to the beginning of PCI-compatible Configuration Space and thus must 
always be either 000h (for terminating list of Capabilities) or greater than 0FFh.' [1]

[1] - PCI 6.0 - 7.9.7.1 RCRB Header Extended Capability Header (Offset 00h)

Regards,
Terry

>> +		dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
>> +
>> +	iounmap(addr);
>> +	release_mem_region(rcrb, SZ_4K);
>> +
>> +	return offset;
>> +}
>> +
>>  resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>>  				    enum cxl_rcrb which)
>>  {
> 
