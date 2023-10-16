Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017827CA9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjJPNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjJPNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:40:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C25FF;
        Mon, 16 Oct 2023 06:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIoFg4VAtAhJ3P7AOwJ0PZqhWgDJ7IDevr0sDwlfamBLQOeIXAHoAAfXhyfBvgWzR9ySGicDbEZ40jV60EthaAOwEoKZPXOZmbcn0IEsnWHkt7qgKL5m0FZu3XIxQlC/0Cx1agl/UdOjWMLbjTVAyHjJ/i4aqEgBeFxANc8GbzWiv1oUtKCmVzNkvukv2+HkBvyR/BQdwiNK7UH3MdD+xOGmy85hgyzzOsV9c3iHWyLe1+UevRh+8QDBu5bSllTvwCTLVXsDSPuT+0D+zNvihw8OvdIZKIcmYVyLTQJm+R2odrG9gWk08E9MjfF8rig9Qlp8VB9pGb7zpxtca3G8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7jZMHlxfxWGWDwRDcjQkn0ZXLVYfGXDEOESiAPos5g=;
 b=c+n++XDM/pt2hyqjQA+km7A88Z9KCQouiC0CqWffv19/al4WK8CCeDz5cg+Xf27RFQ7KCU8Z+PdvQi5Zy7nbYY4o5cKdTJJudn3vL9PBheP6FxYB4CeHJBULVzWJ2yKWJjDuypw4+u790lR3+gUhtgfJaO3Yv83xm75CJE3q9d1KhSQhCIhwzgS9hprmk2gEwfp/6QMcEGh6482KLxw1oW3wlTgdPxUgWB/7AKO081IpCbKAT4R9wtFixSVX9JIRsrmeC0suClLK1WgUHoUOrkAks66ELfXqyIDY5s9zzCHhW2Zz/L8CVvL7qfQeDh1cbwU2boE/7QCq5vYoSYWBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7jZMHlxfxWGWDwRDcjQkn0ZXLVYfGXDEOESiAPos5g=;
 b=ug3KsWz25YaqxhhWEj22itsJwjMTHPokr+6ieBrUcBLwGqPkvqd5GZm0DawN8hN5InVNSXZqttIf08dmu9/+7UxGXFGFg7keWQ5B5D8IHMm0XVOK+xQJa6u1tdvAC1bKqMPzB8PGPd33nGIfn/AlzQSHfZJWDPTB72/bOqKB9gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Mon, 16 Oct 2023 13:40:26 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 13:40:26 +0000
Message-ID: <da5bc564-76c4-4078-97ab-1d543933071e@amd.com>
Date:   Mon, 16 Oct 2023 08:40:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/20] cxl/pci: Introduce config option PCIEAER_CXL
From:   Terry Bowman <Terry.Bowman@amd.com>
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
 <21fa3d41-3585-40b4-b919-d3b66557e9d8@amd.com>
Content-Language: en-US
In-Reply-To: <21fa3d41-3585-40b4-b919-d3b66557e9d8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 8590af3a-fe0c-43ca-82fa-08dbce4d73f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB2UUPnYEj4sPd/0taRZC32XldAS7VPW38ZirZu3apBNHqCiXL6J8b4TLxVFZmsmaG2cD5Vk1Cbgc9bmqa9dUCUzNmv/ewWBsmVqc4cj1mJvYTnQ0gQctAOtcOZR3aJHCaPcFD1e+pZxYG8YpAq4tBZxm7Me6iZ3pTYxhLJ6i8FyDMnwGakpaOaQsUlSYMbow3xVQc9ad9z8/uIRXXVHg5uxTBOeM4XZRumOcajQ71RyA9nm0lA1XZ1xDErG7lV9ZAUXt546mChkms8GZw+3R8HevOjYHOA85anyonDn9yBBESApWX2zN8io2PcGZRN9ol3rMk8HZk3CRS2sXOl1+GFR4tux6B/z2/IJuirpgVaNy0jw/2F2xkbIrD6zmzjzFCxvckS16ejWl0msiDq5WPIBu0coaaiIhpEdFZNYmnacCPfRUqs7UBDCJvLCndWX8Dg/XZjAG+mJGR7q0r5vSCqvtN1P/XkXBoJBR9jYQ4iTo0439sMPphJou4Oku4IvVHtCibyEJl0vULa6uAd5exFGyHl/0XvpPvTfawYBfNb1p8ZhyRtA0U4o+fK3Jz3Z4rhP+ZchAiY4hjTjPAHei25oDZA4BuQDU2ojTt3D3InxtakHkg7AOe+cHotyigzL3WqBdKe29oCu35ie2xYShw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6486002)(478600001)(66476007)(6666004)(66556008)(66946007)(54906003)(110136005)(316002)(6636002)(83380400001)(31696002)(86362001)(38100700002)(6512007)(26005)(2616005)(53546011)(6506007)(36756003)(41300700001)(5660300002)(8676002)(8936002)(4326008)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBCMHhJbW9WN2xWWlNCYUFVZ2dZKzFFUEFTM1NPUndOcFc3K0VaNWw2ZE05?=
 =?utf-8?B?RC9TODNLTUJJMHFBd1Q5RFQ2SEtubDhPQnkwQW5ZSE13WGtIUXN2UG5MbnNx?=
 =?utf-8?B?U1pscHV0YWg1dkdCYWRvRmZNUFZ4RWFCeEpUc2ZaYmZoUkJmT1FoYmRKWkdC?=
 =?utf-8?B?eWpkVEpTQU4zUlRZNGI4eTUyeGFzY2ZEZUdUQnNFanZMbzBoem1ydTFQa2Fq?=
 =?utf-8?B?UDFsN1hMUlo4WkFPaFA3NWp2Q3pGZys0ZDl1TklLclpUSmhoTy9wekROcUEx?=
 =?utf-8?B?alp3dGFTWjVicWxIYk5oV2Vlb2hFTUJCNDZOTGhjSjJXZ1VnYWNXeXRRN0tL?=
 =?utf-8?B?VU1UaTFLTit2b2pMZ0pqa3ZUS1JWdXJ5NnYxc0Y0V052RW5kcVQ4QnpGZEdl?=
 =?utf-8?B?bzdmakVNQWw3em5GSU03SUpjbHUvUnZVQi9wWUd5QjVnOVU2MnVsS2ZGaGxQ?=
 =?utf-8?B?MlJobE9CK00wYlROVkFNak5zVlNmSXFOSnAxOEdkNlJrNTRsU1AwN0ZYRnJw?=
 =?utf-8?B?U2h1aWRMMTlPTWEyWjU0b216dGtUVU9MVjVyVTc3c1QrVHdjRzlKY3dWUk4x?=
 =?utf-8?B?ZFgwVTd4Y0IzNGhPTXFkVDg1ZjV1bFZIVGU4NW90MGdOWGk5L0xqVmwxUmky?=
 =?utf-8?B?c2hGbDVJS3YxREYvSkJ6Sm4yRTNYU08xWkg5c0lkQUVLUTZGMm5lSC9TSkRk?=
 =?utf-8?B?b09lY2hhVVJDZVMwWHBPYmxEaXZLZUVodXlmd0FnQU5XeHBiVCtFaDU1M2Za?=
 =?utf-8?B?QnZoVllyT21ZcEdiRE9UdXhNQmw4bXJIaWMvd3ExYXYvbnl0aURxbG1lK21q?=
 =?utf-8?B?N2NYemJBL3hpbzIyOVJsU0ZpYjU0SndRcjBlS3AwYlZFL2FqQWl2emd1anFs?=
 =?utf-8?B?bmgzM3g1WWh6UTVCWk1odDlPRFh1QVlwOWVJSE5KRFgzSGxhTjR4MG52VUZH?=
 =?utf-8?B?UER2RXlFbzdlYVJmSUZUUHNCL0NlSVQ2OU13Ty9qSTBNaFB0Uyt2bzNZMDNq?=
 =?utf-8?B?Mkt6Yk5VbE1ISHpxUHV0eWNUNncvRG9JYzJvOVNEajUyYWVGcjl4dlpGSUN1?=
 =?utf-8?B?RkgzTkI1Qm5VTTNydVMvUTBjS1hWQnYvMU81VGMrM0pia2VWSWV1QUVNZHNM?=
 =?utf-8?B?WWN5NUVTYVNpTythTVVoQmNYbWppaE5KV2lxcm5EK2lHY3VoU0pNZXRmTWVs?=
 =?utf-8?B?d2R4WVpyK2F4b1V5U0Q2ZDhVeVR5WE11VWNDQ0NCRnNpQkZDdkpwRHM5LzlN?=
 =?utf-8?B?VVRVOFlOYkdKOXp3WVhNZEF3bG9FeTV1SHo2SmtxZUN4K0Y4YkVhQzI0WWZS?=
 =?utf-8?B?eFc1Zm11RGxtMUtnVGFMRDhiZ3oxUXdHSDhQanJkQ3E0RlEvV2d4eFcyQUNN?=
 =?utf-8?B?TERrNzBpY2ZVWnFpUk9OR2lSRHVaUmNOWS9RNjQ4bm16TlZTVlQvMERCb3or?=
 =?utf-8?B?VlBJRDFQNFdyVnJSMlU5SVA4MTRvTVFTM1czNWlCNGQxR3pyT3I2cWdMTit3?=
 =?utf-8?B?bm85cTViZENnbkNTMmZSdmMzd1MvQTdCWkJnQjQ0Y2tCT0RrbnJhNFRGVHBK?=
 =?utf-8?B?T05qYTNjOVNVT24zMHh1WHJ1Yy9zcTNOc24zYWdsVXI4bGU5dlozMkk5YkJ0?=
 =?utf-8?B?N1BoNEJxSHRjbWlSWDlxY1FTWm1ubHQ4dUVRcUYyeEs1RU4yNEV4QjBxUFd1?=
 =?utf-8?B?VUU4SFU4RzEvbEJCMWhySDhEcHd1SjFQTGVNQzdNVXp6cmxURDhkQTZmdjhs?=
 =?utf-8?B?NVpjbEN5VE9uLzRNYmliSk5FUWhWRWxDejFCb25kR3BUZ0VMZHdsN21yLzlW?=
 =?utf-8?B?eDVLVG42cEdXbVIrTGgwZHFLdEN3dUNFVEFrQWFWek1id0k1d2hjZVdpRHpT?=
 =?utf-8?B?dFFIK1ppb0lwT2FiRXBXSERhWWJWUmUzRFdycmJsYjIwTHFjTVFxeWpscC9w?=
 =?utf-8?B?c0JCL1BhSVI2YXhZeVFkQTR5WGwyTHJkZVhxUUxHNk9QTzZhYWpvYkt2NThS?=
 =?utf-8?B?cW5uVjVSOXhnRzlaOEFUeTI4NVhXZzU4dTlyTWdYclpZU0JqRkZ4VWNxdlB6?=
 =?utf-8?B?UGwxZkhQSGdFYmdqVUVlc01TeG5TUEo4czlYcllNb0wzM2xvd0NOVlpGbWNB?=
 =?utf-8?Q?oXw1+DkdT1gPW+dKp97WxW1G7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8590af3a-fe0c-43ca-82fa-08dbce4d73f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:40:25.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17vKH4NM8NjGvchO7RJRxz97mU+MonCJWXoH0tyiA38rwL41pHVARk761QRV91J4vGOrDIYyDQqUESqpHG3IXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I added a response below.

On 10/9/23 09:44, Terry Bowman wrote:
> Hi Jonathan,
> 
> I added responses inline below.
> 
> On 10/2/23 09:46, Jonathan Cameron wrote:
>> On Wed, 27 Sep 2023 17:43:29 +0200
>> Robert Richter <rrichter@amd.com> wrote:
>>
>>> CXL error handling depends on AER.
>>>
>>> Introduce config option PCIEAER_CXL in preparation of the AER dport
>>> error handling. Also, introduce the stub function
>>> devm_cxl_setup_parent_dport() to setup dports.
>>>
>>> This is in preparation of follow on patches.
>>>
>>> Note the Kconfg part of the option is added in a later patch to enable
>>> it once coding of the feature is complete.
>>>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>
>> Feels like it should just be combined with a later patch that fills
>> some of this in as on it's own it's just a weird snippet of code :)
>>
> 
> We will look to merge with the following patch.
> 
>> Still, one comment inline anyway.
>>
>>
>>> ---
>>>  drivers/cxl/core/pci.c | 9 +++++++++
>>>  drivers/cxl/cxl.h      | 7 +++++++
>>>  drivers/cxl/mem.c      | 2 ++
>>>  3 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index c7a7887ebdcf..6ba3b7370816 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -718,6 +718,15 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>>>  	return true;
>>>  }
>>>  
>>> +#ifdef CONFIG_PCIEAER_CXL
>>> +
>>> +void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>>> +{
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
>>> +
>>> +#endif
>>> +
>>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>  				    pci_channel_state_t state)
>>>  {
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index c07064e0c136..cfa2f6bede41 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -704,6 +704,13 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>>  					 struct device *dport_dev, int port_id,
>>>  					 resource_size_t rcrb);
>>>  
>>> +#ifdef CONFIG_PCIEAER_CXL
>>> +void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>>> +#else
>>> +static inline void devm_cxl_setup_parent_dport(struct device *host,
>>> +					       struct cxl_dport *dport) { }
>>> +#endif
>>> +
>>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index 04107058739b..61ca21c020fa 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -157,6 +157,8 @@ static int cxl_mem_probe(struct device *dev)
>>>  	else
>>>  		endpoint_parent = &parent_port->dev;
>>>  
>>> +	devm_cxl_setup_parent_dport(dev, dport);
>>
>> devm calls can always fail (because if nothing else you have to register
>> some cleanup and that involves an allocation.  If you want to ignore
>> that I'd expect a comment here.
>>
> 
> We will add error handling here.
> 
> Regards,
> Terry
>

Found devm_cxl_setup_parent_dport() is a NULL function without return value.
 
Regards,
Terry
