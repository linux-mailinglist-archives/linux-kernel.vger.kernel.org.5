Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17387BE34D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjJIOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJIOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:44:26 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07AE0;
        Mon,  9 Oct 2023 07:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMLG2JuR54FuRKSKOUmOXcP9TTt+91K40SRYv/D5rwR6VzEV8jsXle3BTWvmR0JJG0n20pItJbsUFVqJCdYPdOXXuxJFSGe3D8sp+EF4Bg1j8Y/pfhNX4WOLt3ROghjhlstX5a74XegSKUU0PTco39PmENjvWtSKyeuS6pCzFeHma9OsFc0iMrv+hIu+urCp+5nDD7mKLDVKgyFSXgYGjzaTNrzuxfOj5/fhqvgvqkSfRwPcCx2Fq26pYsHxgV9s/WKmzp2VqyV2x6EsSlksiWnVmnUE5hPlkOUx7jgUhM/rAxc55BwAQwHKDDPh+AXYkghJStKhiPSw/+A9PBfG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY9JzkI3a+Nz/nK+chW5nnYxpasanJZ2lSbK8lYjzeM=;
 b=jGu05rsxhfJv1n8KGVVWwME8wyF0AdA0MIIQgkUHqC+uPKsaH2asBSnZLjyd1YWt5Ep+3WX3rl+ai5upt44BIFmbGasJXNz1fGHt648FZgR67CzAP96x4XH6jHdPplQ1AHMgQ5XN8x+Ai1R2pOfSU9mQen2if7p1frppCSNGAYUsB/Ga35sFh5Uu4OSYyFkFCzYZXuMXoqxl7B+PKXcXVyJC+o/PfPjnF4ug5Lx/C80LUomo/A3OjGkCBOuxFgz4rS/pBNN6/JHN5HC1b+0Z1fdccRDzLa40/jnEfEPanJeKGEdiLQU6ogUysYKe6EjGIlXLb/zHZjwU0RHs0mIfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY9JzkI3a+Nz/nK+chW5nnYxpasanJZ2lSbK8lYjzeM=;
 b=BsFtjCiHNMjlIS5LIbpTytewE0sbbY0m/o6X3IAWuRAW+WMqwogAjsuazfM2z7OO50B/10GJ0zoskFLT+JOxCZywhBGsxFUI15SmsprZSs7x+sBrbPYFoHW92WU6dp5w2HCyY3gWzpz32UldOOwQEHPxSjkDZQH5K9g5ttblWo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 14:44:21 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:44:21 +0000
Message-ID: <21fa3d41-3585-40b4-b919-d3b66557e9d8@amd.com>
Date:   Mon, 9 Oct 2023 09:44:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/20] cxl/pci: Introduce config option PCIEAER_CXL
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
 <20230927154339.1600738-11-rrichter@amd.com>
 <20231002154628.00004f9b@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20231002154628.00004f9b@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2714e8a0-459e-42ea-9222-08dbc8d63985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK3boeFQ36hXrJbSLpBegmCeYxizKXSxt7k0YI4LXtc3YYC9jSytljUftTiOS1n2ZT82GLn3/G7o3KseOkk92Ud9AEUznIOzz2fmCOQiqI8MYhbbzDRXSkk4OmwFnistKE9dupNWyTXFj9yUAFaZOpquoSudDhp7g0sZuGaFBNMXUc8dP+ZGd+FHNDMfoiImoShk4Xo8yBTmSm9Yqw530zZeGgx/fiG7FQQEu7IvE1QhFhPaGJiNJ1NQ6+IhN6PwAxitp1glDmPUUuT8SrQhmLzz7ByVvG4I2pVJvWwxqUItjjatAyl23VzHA0F3umpdY9LnYTFY+uP1uyVePzKncj8GohmOpA9+ojXp4aXROQCTu2y9NlQQ8wEoHtUZTMB2jQQxGZzSHa65s5FWKbLYxeXnlexngg/X4bdNXfq8+pEFjghozxwy38o/eF7Rv7vBrSo/k90KOUGlnNt7NizxThYMPgU1mFV3ROIe80dWpa2AtOs/diS5WNWhZm2uflGrfpyq9+hr/wfoQ8W6MbA6GP18+XqpQUzfXlxOBx479MYZqWqv7yVbrtY9PSN9z6QgvaHjASs0d5z+c9H0NIP6QnV8ZBHh+RfAA8dpYi4AO1RlAdMrYYsjbAwU+O75w8Pev60MWw/iwBwgHOf/BDOl+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6506007)(2616005)(6512007)(53546011)(86362001)(31696002)(38100700002)(36756003)(26005)(83380400001)(2906002)(7416002)(6486002)(41300700001)(478600001)(66476007)(8676002)(316002)(4326008)(8936002)(5660300002)(110136005)(66556008)(54906003)(6636002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZGb2ZQbUxmTXlqUEU5QUZ6V0ZmUUJZckF1SncrZ0dtaVEzOUErRUpQZEFL?=
 =?utf-8?B?MUFYN2dSUTNtWmNDeFFJTEp1bXpDNkIrTFk2UHJoL29jVG5PMjllMlZyWlhN?=
 =?utf-8?B?YkdUbVNDVDk0V1N3RWNNZ3FhdEk4S0ZVOERFYVY0YVNrQWRPS0JvR0pHSGkw?=
 =?utf-8?B?cTE4d0NQMW9yWVRhdVl0UXlWWXc1VkNhNUFoL1dpWFUzUHVrUHFMR0ZZcnNr?=
 =?utf-8?B?TjFEQXE2aXI0MjAxM2UzREx5dm14bFN6TUxtZkttOVFlSzZIeVkxZmR6RXZq?=
 =?utf-8?B?SHhCOFhnT0tETDJaa2VkbmtzTnhRK1R4b1lmd1NFdGN4R3hHak10bmRMTThk?=
 =?utf-8?B?Ym53N25yeUlnZXFUZ3V3Vkt4YmNuZnlKWURDbUhLYUZCUDlWWkRFODdUdkIz?=
 =?utf-8?B?TnpqZU05OHJlYlR1bUQxM2dlSjlBeENENWF3am5kODNMQjlVaGg5VTdRM2RJ?=
 =?utf-8?B?ampvcDRySHBzWXJ0RjJMME1RdWZjczNKak56cmgzeFhjSUlUaEFmbUIzam5X?=
 =?utf-8?B?NVE3Q0cvWkw4SlNrd2VReE91aHdrYnNabURWNGxKZGVJTXJMYTBFWE5wU2Va?=
 =?utf-8?B?MHlRd1FwL2lEcTE3Skp1YUEzZGo1Mmt6TGxjS2lmeWdvY1hjU09YRkR4RVNo?=
 =?utf-8?B?cGlINVlNUFdyS1ZWcFFTZzd1NzQ4RE5MY0ZwMCtRU2tXZjRCdlJYUWNoL0Ix?=
 =?utf-8?B?WHNZN0lNRVk0aWgvWS9YOHBTdDNZeVFEOEhVcXZZOUtsUW42SjVIRzdWU0ht?=
 =?utf-8?B?ZFZjQXlJMTJHOWY4YlRXVWY4TGZpelN3cjFKRlQ5TlZNVWNtdW5CU1RSS1BH?=
 =?utf-8?B?V1hCWmxDN3pDNlAzdFdUTisvOEkwb2NLQTJrY0UwOFN6Z3IwaEcrMTZUTlZR?=
 =?utf-8?B?T0QwK2tVckhMMklab25JNHRlS3ZaUUp0ZVhrV3NiTUhNS3NJN2VmejJNalJJ?=
 =?utf-8?B?UVJnMUFFTGlYMEppRFhySzZ3THdMOTc2WXZoSnBHM0F2LzhLd1kzSFN2a3dD?=
 =?utf-8?B?eVl3eFlXMmsvaW81Zk1xdTdOaXRyaUs1RUdrUUNCNzhrUkIxUFVxbmxLQm5K?=
 =?utf-8?B?d3Vpakh5N1prWnkzdkF4L1d6ckg2R1UxVkduL3BoUTg5RzVscUFtZnFWaDZm?=
 =?utf-8?B?a0FNeVgwSDhmK0hmMkhwMkJhTkhGK04zdjVqbDhtbnVjMEFSL05nQitMd1V6?=
 =?utf-8?B?blRLaEVpbVBnU2duODFtRFJRUGFwMDJjMGU5N3pLaERCQWRyRmZ1TDN1bDU5?=
 =?utf-8?B?Z2lWdnN5ZWRVYkV2QklyOWM0dnBSQmRBV1NDcXhUZ2IxMHBKckFiM1JGbU5q?=
 =?utf-8?B?YktQbFFOSGs1U0JQdjgrVmpOdnNQNnF4ckk3Ry9nc3orS0Erd1UyUE1aNEVy?=
 =?utf-8?B?a2RjeFM1cUVsWk83TkRqcDhETktpYVJrZW04V0g1UFRLVENSSkdLRmZxeTAz?=
 =?utf-8?B?NDdkallJU05nb3YvTmhhalBqVnl2TkYzUVhzRG5XRXlReHVLQ1d1Zk1yZTYw?=
 =?utf-8?B?K25sRDRRYVNOaUtoSytNcVVFN0MxWVllanRrYklRd0MzT2VUeUEwbmhjUURs?=
 =?utf-8?B?UzE5WU96dzZnRG9zR2NpNHp4dG9xYms1VEkvQnAzZlY4VFNQVW5jOFo3RjJM?=
 =?utf-8?B?UU5XMjI2NFN6K2wvMjZ2VUpPY21mZW8xc1pPQjM0UVlkR2x2YTRtOGF1dG5t?=
 =?utf-8?B?VnV4V21RS2lCY2xPVWcySXVOUCtpZmszRGVjR3VZYURvak5mc3ZMdy8rRDdC?=
 =?utf-8?B?aWJENWhGbzZSMTd2N1VIR2dSSVA4Z01GdEgyeHpmd3hCMk1wTHRHRnVHdWpZ?=
 =?utf-8?B?cFVuRCsxZTNGb2RJTVJTVVQrb08vU0lkVS8vdEYwb01BWDlWQmdLenk5cVVr?=
 =?utf-8?B?c25rdkl6cThtQWQ3SXh0cXNmMld2a09ZUWYzYnRoN1ErUVRyZ3Z2Ri9ZN1gr?=
 =?utf-8?B?UmdhaVhzL2lmOWlUN0tGcTZBN0VNVzBHb21YM1N0ZDR6N1J6cDFFWWpEQTRI?=
 =?utf-8?B?ZEh6NWV1VEpSYTMxVmh3M1BpRmNsQ05SSEIxdmZaKzk2R29Vd2tVSVA0aHJU?=
 =?utf-8?B?L1R4RXRiWmZZVENodkVnYWZ3bkwwNS93UUp6WkRSOGFtVmhNVTBPNk8xZGQ5?=
 =?utf-8?Q?FOxUmRc/kJUNcMzFDm3Y3gCjI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2714e8a0-459e-42ea-9222-08dbc8d63985
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:44:21.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uexzKOdHQFI6URt8Ow515/DVZkZEsCnECwK/OOu1STXKFNN4dlN4uDBAba2Dvsm/EH+y3o7m4od6unjWolwj5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

On 10/2/23 09:46, Jonathan Cameron wrote:
> On Wed, 27 Sep 2023 17:43:29 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
>> CXL error handling depends on AER.
>>
>> Introduce config option PCIEAER_CXL in preparation of the AER dport
>> error handling. Also, introduce the stub function
>> devm_cxl_setup_parent_dport() to setup dports.
>>
>> This is in preparation of follow on patches.
>>
>> Note the Kconfg part of the option is added in a later patch to enable
>> it once coding of the feature is complete.
>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Feels like it should just be combined with a later patch that fills
> some of this in as on it's own it's just a weird snippet of code :)
> 

We will look to merge with the following patch.

> Still, one comment inline anyway.
> 
> 
>> ---
>>  drivers/cxl/core/pci.c | 9 +++++++++
>>  drivers/cxl/cxl.h      | 7 +++++++
>>  drivers/cxl/mem.c      | 2 ++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index c7a7887ebdcf..6ba3b7370816 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -718,6 +718,15 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>>  	return true;
>>  }
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +
>> +void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>> +{
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
>> +
>> +#endif
>> +
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state)
>>  {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index c07064e0c136..cfa2f6bede41 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -704,6 +704,13 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  					 struct device *dport_dev, int port_id,
>>  					 resource_size_t rcrb);
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>> +#else
>> +static inline void devm_cxl_setup_parent_dport(struct device *host,
>> +					       struct cxl_dport *dport) { }
>> +#endif
>> +
>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 04107058739b..61ca21c020fa 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -157,6 +157,8 @@ static int cxl_mem_probe(struct device *dev)
>>  	else
>>  		endpoint_parent = &parent_port->dev;
>>  
>> +	devm_cxl_setup_parent_dport(dev, dport);
> 
> devm calls can always fail (because if nothing else you have to register
> some cleanup and that involves an allocation.  If you want to ignore
> that I'd expect a comment here.
> 

We will add error handling here.

Regards,
Terry

>> +
>>  	device_lock(endpoint_parent);
>>  	if (!endpoint_parent->driver) {
>>  		dev_err(dev, "CXL port topology %s not enabled\n",
> 
