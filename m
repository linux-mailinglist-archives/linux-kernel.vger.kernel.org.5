Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D707BE2F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjJIOfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJIOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:35:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D7A3;
        Mon,  9 Oct 2023 07:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIepu62zrT2IAG7N7ZrGt7sUVgnVH0TEGBLN8C3F3qrdj0fc2P13QMu8vGE6xbbKdUkiy6lqaXRVPiO+xSqp0aAamD9Yti0GT2M6AvHmRdnlL9Oyoj+47tsM7lMfta4+N8qDX+KMZP0tK7yuFhEgSWhmGms9KtIsYbojmgrj7RiNvaln6AThScxx8onKOjZvyCGfO1OB8jSqJOaJf1NNKVZqJ6wBhbZZoA9uG8sGZt8eyyiHAtnJdxgGmdK90Z0erWkoMSW5BDalZM9kJNmXV1iOK6m33ToPjcwK8RIh4H2J6vcZKQYhIevyNvV019ZRKax/nwkFR+foJPMlSLBYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8JS6hC2N9mCuJ2Bca/wLRyyjGUgs0/s2mE3Xi8eeQk=;
 b=j5yNZ42hFzQb4Mc2v6RJI3wbm6GCSk21P7XtdRd91lTLLc0oZrbhFrWAGqqoECoUtZn8+Fmv2U3LPuqoURABWbxY9IR0iycfozcScBCIVK8yQlpWM2kboXPVOEG/xSq5cPGOpACBJr0+LwwfdKHCmwB+41mFEo87HCRozIdB7ex1cKBXMNpoBSDC/XFWYxl2oThrXXCI70ggQKDGoS8X6YHj8LXuzovK/tPiV9Y+EDaVWN5GoZUCbTgjTDosB8CLOxSmWQFEB60iBlSKWf8btJwPt3INoR0vJk8q3Dsl3ORZJpXHulSWd1d7yICvCivGWfveI50jZkSHvZCSqHKRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8JS6hC2N9mCuJ2Bca/wLRyyjGUgs0/s2mE3Xi8eeQk=;
 b=1bt3a2tYfviLttom++ao1Hkd9PXv90KNLYRNwe5Ri4+L+AmgF/vNKUBUvoeHL9BM54sb+YrIbzSbvn0de8gkzwhPLSdnnMd/leTC6Qi+6idwRrYG6wDWccLewJNZQ1ON4LbT57syNJuKXpCeVGZqcnIIN9ayCVLlHWOhMe2ua8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 14:35:14 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:35:14 +0000
Message-ID: <fc3bfa6b-3635-4185-a28c-3e1ea76e5970@amd.com>
Date:   Mon, 9 Oct 2023 09:35:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/20] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
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
 <20230927154339.1600738-8-rrichter@amd.com>
 <20231002154351.0000136a@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20231002154351.0000136a@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:5:134::19) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd785b7-33fc-47a5-a77a-08dbc8d4f303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PMqLOAYvcXAbZaQkbJWgCq7X+L5y85Td+XFibZp6dsxH+DXjoe2NPlSLPuOXWB3N91uxV3VBDh+BeRGKlw9VaTbwcblJa5a50E5HsJF5lWK1xkH3qEsxs/pSPZZJZh6egag5JklUjDoX3JX+HHSnnN8mqbshflL+XZjYSxukWk2UUO8bnJ+bVoFS3RO/aC4xN09G34sY0Mft/iGeKcrM9owgR++bi8mWixLZuA3sg2SYYmnSoLrnpiuWpU3obL7VDu5MdWPpOKz/dUQA8+d8vOCV7Ssbi/2p+1cS1mVqie60gW5kU/fay6N7mIkIb9UorC7jZbXjllJYFQk05z5u+ALCpE0jmg9Szx/VksMEXErhm+j1FtIXyHr2ifjY85JroCWPmGssKAP5WGP0UFNigp6amsuC6IfKMZJa3UXi1rWIenFlfrvva22EZnTHH7cb92cfKaWFNcILEZTFJboK8DbcR8FflaPhcS0F6yr9sFTPSqUsHBF4JQYb3kl3qrjxO/90o8L8v8ABYREt2GJu8oTFIPoGMP5hBW5T6QtS+q2J14UE0Ubp8NTcVuXoRj7ho4WZ4nZyTlskcPK4gDfNXEossuAPKRwn7Rf8U+1azLZRLh+65ETMgCm6hvl4zY6yJIRzZ9MVVpHjT3iKdYHng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(6486002)(316002)(6636002)(41300700001)(83380400001)(4326008)(8676002)(8936002)(5660300002)(7416002)(110136005)(66556008)(66476007)(31686004)(6666004)(54906003)(66946007)(2906002)(6506007)(53546011)(6512007)(2616005)(36756003)(26005)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlnS3ZXYnRrZnZvazZEYkZRU21MdmZKZW5ESG90Mkt0SFlNRGpDeFp5RU9x?=
 =?utf-8?B?OHBqZ0hmN2hhRHB6VDZJck90aGs4WjI1UTROK0k1aTFzeVY2QWZYMWNIWkx0?=
 =?utf-8?B?NlJramxMWG9hOE52TzJYRGgyeGlKSUJrbXdxaUxWYkd4OEJZU01HMVE3eVBY?=
 =?utf-8?B?Y3BHL2U3WmhoWm5GNGR2RWV2UnJpSWZPc1hjMEVkRGxtNEtjeTFRRGlGdmxX?=
 =?utf-8?B?RGI4Z1FnWFRVV09DN2RwK2lDeGwrWmN4dEJ0VUZTSFpiL3RtSlJwOW1sVlRZ?=
 =?utf-8?B?TUVuK2hkUlk4a2YzdndzK3lPKzJSVFdxSUVBMVZLV1NBYVZYOEw2YzVaeTBz?=
 =?utf-8?B?Q3RCZ2p4YkNVSXBTMUhpeVBuUXZUTDNPOGdvRDlRa1IrRk5tZG1HZjBhWVNa?=
 =?utf-8?B?RGlUR1ZoU0xOM3hBd1lRejVJVUV1TjJlQzNEaWNOaERXcExZTk5HRDVpaFQ0?=
 =?utf-8?B?N1l4TTJIU2RWbVptYUR5T1BrUHVaNlBRNmM4ZGNBN3g2aG5kMGdtM01SdjF3?=
 =?utf-8?B?NmZYYS9iclJLTS9RZGFaUHRCeWJyaEEzVm5WYWkzR1NDWTBYWWh1UHNJcCt4?=
 =?utf-8?B?UUs3TmliektISUJXZGp2VHB0c2dhc2M2NnJmTTg0elJMTi9aTUdYcllZTm9H?=
 =?utf-8?B?OEtsaFZ1M1EyOVlKL09oTHBwdlVLaDRqN2FUdHFwNm1XWGRpUnZaU3JFY1pT?=
 =?utf-8?B?djNGSEwxa0RzVEIrZGxseklvRnN6blY1dTJqcjdkcHJBU3RQcXYxMW5hdVhW?=
 =?utf-8?B?dU5jb0pXYitvYjlwVFJMeGZGdWRTNDdNRGY4SHpJc3pQTHVRLy9IU0M1ZGRx?=
 =?utf-8?B?elhpZ0x5c29NcjZkcVh1dlBibHlsalBmMk1ERFRzZ3A5VFB1cjFSMHZET1Nu?=
 =?utf-8?B?MjM0aWd4WEh6TmNiVUIwd2NPR0hBK3dsTFVqcndFV3VnYTNGZzNsUUI5YytH?=
 =?utf-8?B?VGMzTG9rb1IyZSswbk9wcFQxMXhxOHFXQUlQeUJGVGlqZXU2KzdENjhaSktj?=
 =?utf-8?B?THA4N3drbDFFSk1CR3g0eCtOTjlLUjVpRVoycWRVcTBnK0hRV2w0VTR3VFl6?=
 =?utf-8?B?T1ZsQjhTWEhMRmVpN1RLZmhKWE4rNG1TR3RTaEEwdEwwVnhXUDhkUTlrdkJu?=
 =?utf-8?B?d2hNaU9XOEdKd1RxWTF2TnVVeWxhb1hwakw4UWNaMWJMQktyd2pDL1V2dk9D?=
 =?utf-8?B?UnhDKzhGK210U0ViN0ZqU3N2T0FBTXJrVnBPNHlRWDJ6bCtZc1YxUzkySGJZ?=
 =?utf-8?B?ZTJRTk1EeTIxMEp0cTJ0N3ZRanBJdWY0bDZLckNEWlkrTFJ3c1hrZWpHcHNl?=
 =?utf-8?B?Vi9lU2NyU2NLSDB4dlZKSTJYV1pFTjB2VXZ2MkdVd1Jya1JQejhFci8rUWFq?=
 =?utf-8?B?NFVVK05INzMrWVJweE1PZ3hVb0pWSzZzaEMyS29uWVVwaEN2Wmhyd3JFZHIz?=
 =?utf-8?B?OWpDUHBacFg5UlY0d0N3RkFaamRPMUJrRHQ4UHQwU0NWM245SWdEY2ZiWFJD?=
 =?utf-8?B?SDZGS252WnRwZW5qc2pkOTlrWDVFaHhSRUhFNWpvZU4rK25RNHdLNVU0b0FU?=
 =?utf-8?B?M1JjR0IrZTNHeTk3RWVPNmJqWWZ1TEpCUXZ3L2NHNnN3VE9MWC95d1BIZmlu?=
 =?utf-8?B?RTdqSi90NWYwdVRlUGZyYXE5cnhGTm9aVTdXczZKVGRxNHdHUlVlQlhVbUR6?=
 =?utf-8?B?aWtTWVdNd3F2TVl2WDRCVENCaytYSzlNdktXK09GY0lhV3FBQ3l3SEROcEto?=
 =?utf-8?B?T1BEWDNENHczZDE2aDJXN29la3B6VmhpblZ3SlBWK3JQS0VMUkJ0REJ6Y2k5?=
 =?utf-8?B?cm9mYTkybG92Z1dTdnU1L3IwUmZBZkh6N081NGtNaVBtblV3cDlCdnhROVY5?=
 =?utf-8?B?MzI1bWdOeUdmVVlvVFAvUFVMWkt5VnNXMEhCZG1QY2JBYzZGZk03c0ZBck9q?=
 =?utf-8?B?NTgrNEVmTTNvd3pvUjRwR3dLTjl1N1NmYWptWXVSbk9tSmJITlFDMURFZUt6?=
 =?utf-8?B?dTRqK1J6aEVsUmVEcHFlUWlKOGd0dnFtK3ltUGFPdlZuVllndDU5S3NHOTZt?=
 =?utf-8?B?SW5HWHFIeXVOak0yTWFFTGs2dEROOXZ2c3BtcUJzZGQvUVFZK2RVbUMybVBt?=
 =?utf-8?Q?t3njyi3pjuP7XayK2AGLmQeII?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd785b7-33fc-47a5-a77a-08dbc8d4f303
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:35:13.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0QwnEpXo7uqdL2Te93RilkqR05nM09+8HTs8eziGecyfn7mqLyKdaEcvoNpqN3KWfSC/XbyYMm3WOqFDtJW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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

I added responses below.

On 10/2/23 09:43, Jonathan Cameron wrote:
> On Wed, 27 Sep 2023 17:43:26 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
>> Now, that the Component Register mappings are stored, use them to
>> enable and map the HDM decoder capabilities. The Component Registers
>> do not need to be probed again for this, remove probing code.
>>
>> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
>> Endpoint's component register mappings are located in the cxlds and
>> else in the port's structure. Duplicate the cxlds->reg_map in
>> port->reg_map for endpoint ports.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> [rework to drop cxl_port_get_comp_map()]
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few comments inline.
> 
> Also, Dan's SoB doesn't make sense if you are the Author and he's not
> the one sending the email.  The fun of patches bounced back and forwards
> is sometimes you have to tweak this stuff on each posting... :(
> 
>> ---
>>  drivers/cxl/core/hdm.c  | 48 ++++++++++++++++-------------------------
>>  drivers/cxl/core/port.c | 29 +++++++++++++++++++------
>>  drivers/cxl/mem.c       |  5 ++---
>>  3 files changed, 43 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 11d9971f3e8c..14a0d0017df3 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>>  }
>>  
>> -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>> -				struct cxl_component_regs *regs)
>> -{
>> -	struct cxl_register_map map = {
>> -		.host = &port->dev,
>> -		.resource = port->component_reg_phys,
>> -		.base = crb,
>> -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
>> -	};
>> -
>> -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
>> -	if (!map.component_map.hdm_decoder.valid) {
>> -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
>> -		/* unique error code to indicate no HDM decoder capability */
>> -		return -ENODEV;
>> -	}
>> -
>> -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
>> -}
>> -
>>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>  {
>>  	struct cxl_hdm *cxlhdm;
>> @@ -155,7 +135,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>  {
>>  	struct device *dev = &port->dev;
>>  	struct cxl_hdm *cxlhdm;
>> -	void __iomem *crb;
>> +	struct cxl_register_map *reg_map;
>>  	int rc;
>>  
>>  	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
>> @@ -164,19 +144,29 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>  	cxlhdm->port = port;
>>  	dev_set_drvdata(dev, cxlhdm);
>>  
>> -	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
>> -	if (!crb && info && info->mem_enabled) {
>> -		cxlhdm->decoder_count = info->ranges;
>> -		return cxlhdm;
>> -	} else if (!crb) {
>> +	reg_map = &port->reg_map;
> 
> Could you set this where it's defined above?
> 

Yes.

>> +	if (reg_map->resource == CXL_RESOURCE_NONE) {
> 
> A reminder comment on why/when this happens might be a good addition.
>

Yes, we will add.
 
>> +		if (info && info->mem_enabled) {
>> +			cxlhdm->decoder_count = info->ranges;
>> +			return cxlhdm;
>> +		}
> 
> Trivial (and true before this patch) but I'd rather see the error path out of line
> 

Ok, we will change the conditional check to be for the error case and the default path 
for success.

> 
> 		if (!info || !info->mem_enabled) {
> 			WARN_ON(1);
> 			dev_err(dev, "No ...
> 			...
> 		}
> 
> 		cxlhdm->decoder_count = info->ranges;
> 		return cxlhdm;
> 	}
> 
> 
>> +		WARN_ON(1);
>>  		dev_err(dev, "No component registers mapped\n");
>>  		return ERR_PTR(-ENXIO);
>>  	}
>>  
>> -	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
>> -	iounmap(crb);
>> -	if (rc)
>> +	if (!reg_map->component_map.hdm_decoder.valid) {
>> +		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
>> +		/* unique error code to indicate no HDM decoder capability */
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	rc = cxl_map_component_regs(reg_map, &cxlhdm->regs,
>> +				    BIT(CXL_CM_CAP_CAP_ID_HDM));
>> +	if (rc) {
>> +		dev_dbg(dev, "Failed to map HDM capability.\n");
> dev_err() seems appropriate here.
> 

Yes, we will change dev_dbg() here to use dev_err().

Regards,
Terry

>>  		return ERR_PTR(rc);
>> +	}
>>  
>>  	parse_hdm_decoder_caps(cxlhdm);
>>  	if (cxlhdm->decoder_count == 0) {
> 
