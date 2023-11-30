Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59E97FFE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377175AbjK3WZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbjK3WZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:25:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500710DF;
        Thu, 30 Nov 2023 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701383112; x=1732919112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KHys1lrvLSvVLmfkynxPY7O5+K9sxl8sZ418S7POmC4=;
  b=al/9HPqqkQDWdPGlsvLw496Z53ljB3neGebMQH/qguJdcJfVhRgV3fET
   yPCH4p7sACZZlNmzgQoRPpLeyjqPf04IIrM+t94o/Rl44aMxKSDp8M9A+
   P4BrZwi2DazIT/wxVfwLo8hZcixeDwO9J5R6T1r1yGbW5hqhGUFCYmPgK
   TIvQ1v/XhTwIJtVo6p8kCNjO/cC8dH35kHTECeClET3hlOUAi3DeTkfME
   /WnZ+BIS5+mCCYKt3wxSmXRYaUv9VMM/tshiT4mq4W1vNec2apLz73bkl
   LGy1bL3gfDFSvYDM2Wi/Vn9BWripb7j+d3MWU9KIKY0d0ouo204IM/XW8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="383794531"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="383794531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 14:25:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887394498"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="887394498"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 14:25:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 14:25:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 14:25:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 14:25:11 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 14:25:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsprzFzIa+W9BqGmU5QMg0NN4rbne1qtKclwZ5w7wQcCcRiNrNKH0CxPZ4X0k3oXlZnn898hjVEwFQt3sA+ZWjylAvrVAL+pRHvfZymbnJ7LkhSxycSHZvhqKANJwfkKE+DE2itJLdiHlu7vsYOLGhiDzFLuFj/yxTbVhjdik1EUJgSABD+7GQ9XlrHrStJc/nkhMKOAsA9VUpMNOwghxR0NgoGVf0Ej71RlViloxneDLSxwRda25ayxaFO+klVFKksV6urSZSI+NFbKVG1ZIoqTpx+tUEgzw2kKVkNo+cfeR87k9RPqvOtbjysikAtnlkfS12Ji+bxJl/wbOUx6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRXkzRif21J1ORhx4hua5hMS+qLyM2uQhiD3bAl2M60=;
 b=nZPyQximPbuxzthctKpkKcqfCBNcVPUlvW3gN+zcKddyM9XXeG3kafPCkpfz0YUE8dvAo/9KCv9sRl+DVRH8YTU0vyjvhGR24wqhTIgtyC4F7mgYgedpjS9VKrPpwGV5dfOGLtCKS/+XQ6J9blLQoFnjOsssN5HsbOhPLhaxEGTu/ULPlc7kRJpuNofQ3bcmBsQLCsTAJopx3ED8v2XztM6JasTxZIjmGuIaad0CNnYnTcu5qg6tjfcoOlzjLbAOtTpAluScwdZd45rRhx+Q972e3XujjKI6MUem5BYcRf7IXmzYTk1LlHWKY9h2e59YxsB4OKFA1XZmjqfOBhWzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 22:25:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 22:25:03 +0000
Message-ID: <f5df96db-ba15-485e-8494-6920b24aa45a@intel.com>
Date:   Thu, 30 Nov 2023 14:25:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when
 suspended
Content-Language: en-US
To:     Grant Grundler <grundler@chromium.org>
CC:     ChunHao Lin <hau@realtek.com>, <hkallweit1@gmail.com>,
        <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20231129155350.5843-1-hau@realtek.com>
 <4aeebf95-cf12-4462-80c7-dd1dafddb611@intel.com>
 <CANEJEGs9r0vq9QkGTcLryPnviMPgztJDsFjHqnRH65KbCqeF7g@mail.gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CANEJEGs9r0vq9QkGTcLryPnviMPgztJDsFjHqnRH65KbCqeF7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: c733467e-1856-46e2-318e-08dbf1f332e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDhRpx/AzXCDvC8kEabDR13pFJopkdWjLQX3PX/xuUvvC5k8GKHKN3DUJqjG/FK3J6SCbvnI3rh8UfdSQExqyDUUCtTHpTP9lI6tLhUNPXUFAHNDElTMd1Su4+RXCNhDjeyo3USta6cpy91Agm91XgoBdQPRCZsdInVX0da8Zd7QNR+oDnbGvfmN7xyI20g8ZJEcPyFUAK6T+URJ512wNGOZa6Nxlosln2Ed70kJZwMI26xghMqaU2Q26H33Tt/WMrW/NHjbKYhwdSbcm8SwixCNh7Ys+qgRXlYvTw5EkzQmHQCPee7zOS6NfjtYFXkYQITZ2nrbOG2jWRCJIPDtax9oVGgNNmidgBn60kuFU64R19Wtq4IIpaXMXSHO/+DhoS4rsU/gsm8x99m+i/Lr33HFuKK+WDvRHCqCwg8Lk+uVQARMrwlB0JwHBcf+u9ryFczcZljWFqfqYTnPUN4YtmgUNv6iAjgRyGzZPm0BKwr60lCGYRQNUMRp7hnf4/LI6L2xWDMc5OkG/twL3n3YFKyLOXx0pjwloIxwr+VTdSfw3RjEDFqFpgRNAeJJqUMEsoVynGe2OcL9ybQT1jQjbug7faNNl2HZQK28pOubyt2T1a+yJEfO2xcXdjvVOgPQf/CCvw0CzyFQdPcIFnGfJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6916009)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(7416002)(15650500001)(5660300002)(36756003)(41300700001)(2906002)(31696002)(4326008)(8936002)(8676002)(86362001)(82960400001)(83380400001)(2616005)(66574015)(38100700002)(26005)(31686004)(53546011)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmlhbnZvWmlYbHVmZWZabDhmRlFCRVRLZ2E1MTZKWHJRaUU1WXhoai9CM3Vr?=
 =?utf-8?B?NUNYR3BNcnNQUEllbk9PNjAzVU1PbFFpRmJ6dWczbHpLWHhPSTRYVk5Eait2?=
 =?utf-8?B?VlRyL0RhcGZjMXAyWTZCNWQ0V3l3ajNlUU9jZGZtd3E0TTdieFQ5cGtlV3hs?=
 =?utf-8?B?cUtjVGVtOVR1Y0ZVZlU3NXR5YXBsYkN4Q2pUTmRtM2pEMjhqaVpSQmk4cnBG?=
 =?utf-8?B?dG1VSFdWN0x2MGZFeW9rY2haekw4STZ3UHF5K0g1eW9jSWlSKzdCOVE3eXc2?=
 =?utf-8?B?RDFzZjFwK1NmNjlBSUxOb1lzV0M0TE9yOW9Ndy9SYzY1ZEZRbWVTd2RCUitF?=
 =?utf-8?B?TnRCMlJTaVIvR05EbFdtV01qL01ZZHA0bWVYUFVGcnV2bnA3SmpqemR1YXl2?=
 =?utf-8?B?SURKb0R3ZUROZ1Zjd2pWM0x6WlhMdXIxc0RuMUdOMUpreG9Ja2pMR2ZzQkdJ?=
 =?utf-8?B?aVoyckZCMGRGaG9ObE9NbVdDRXdQRFA4c1RHNkMrSnduaGNEMkxSd1o4U09j?=
 =?utf-8?B?TzFOR2wvUmZMVmllVzdqc29md1NxNDcvU3hIeWRSbmZxVzNBSHRSbWEycUpW?=
 =?utf-8?B?a1JiMlp0ckFNNStmNTF5aXQ4S213U0JLRU1wSVZnbXdlYVVJMlNWUnpaSHVI?=
 =?utf-8?B?Q2hmK0ZsVWNSTXg0K2t4NEMzK3R4Q2hHYUJLbHU2QXpGdy9sSE13OWU5a0Zk?=
 =?utf-8?B?ZDZrbHU3eWlrQUZQVnNVUmtZL3B1bnhKUXc3ZkM2ZDdDSm1PanE0Z3A3QUpK?=
 =?utf-8?B?S3pDempuVytjTWorUCtUTE5Ecm1sd2hnazFwVTZIaGMwanBQcWVMRndZY21a?=
 =?utf-8?B?VXp4ckxwSW56aWxTT1VXZ29BSDB4NFk4aVp6ZjBxaS9hV3MzNW9ScWtSOGRG?=
 =?utf-8?B?WlpiNThiVmpCdjYvZTcvaURUWU1Gc1NIdzE3bU5ZRDRzelc2N3F1SUNMbmpi?=
 =?utf-8?B?d3dLWVZSdDN1OC9PckllRW9uVTBWNnFscmVBTEtxaCs1bWtRejNvcnZiSWNX?=
 =?utf-8?B?V3RvRndmbm5KVCsxZEI3NXJZbS96UEFpbnExVXcwa1NuYXdKZzg3Y3c3YVlr?=
 =?utf-8?B?WncvWERjQlVkVVRRZW16Y2szQmkzaEd1YzBtbWhnNnVYZnBvMzN5ZzJIYzlD?=
 =?utf-8?B?ckNtdVpDeW9MOUc1ZllGbHMwb0hVMzlGek4yQTJDbzFHOTZVOXhqYmdNVVoy?=
 =?utf-8?B?TXJCb216SWhFM0JuMUMwOEoyNTZjTTdWcWRYNkRybGh4T3JUeGQ3RGw5Mi9F?=
 =?utf-8?B?bGUzUWZRY0JIZE5EZ1ZLOUV1VkI1U0R2NUU0U1hoZThnR1AxMXd0bmNvZzV6?=
 =?utf-8?B?ZCtHaFpwQUw0ZWpZRGgwV1hZY0RZUUZNNEV4VVdDcFdCVzBWTS8zUHBzZjRZ?=
 =?utf-8?B?WU50eVBGY0ZDUmpXSEhzbUpPREFLcVNKSDhKbWhKUzRXdWhwU3d4aG5YM3FW?=
 =?utf-8?B?aW9haXdPKzJ4RWJ3L3ZCMUVZaGNpYmlFSjFsMnRXakxVbkQ0aDRxeGdYWVJF?=
 =?utf-8?B?V3dKY0RXai9ibkQwd2FzcEkrTkFyYmJWSlI0Y1VaS2dUMGVaMVZGbHBEVzBh?=
 =?utf-8?B?K3pIRFVqZFFaemx3eW9reGUzWEhjWjZJa2NKejdqZCtBUWlseENNeWMyMUti?=
 =?utf-8?B?eElLMHUxSVA5dDZxd1g3NUY5aSs1WURmcmNIWGY2RDJOWENONFB0M0xNWTh2?=
 =?utf-8?B?bUhKcFJzKzM3cEttWk5qSTNGNXIwVWo4d3U2bUxsSkRndzBsTURuVWF4alZ6?=
 =?utf-8?B?M3g2OTRaVE5SemV6QlI4M3RreXU1dFpiZkI1am0wUGpiVDFRdjlpWlFreG9O?=
 =?utf-8?B?N2NNakxOVTF1YWNlUFp3YytZVnBDa0gwc2Zja2lDenI5Z1UrTnJ2RVJla3RO?=
 =?utf-8?B?eU1BMHhpMUZRbERlRThhN1gyOTZTNXBZdUlLZnVXQmF2Q1NNcDM3U2Z4U3JQ?=
 =?utf-8?B?YmpTRE1va2VMQ1lVMG91VUpoOHIvV1FWRVlqTGllZThib1ZJSTllQ00yVFFy?=
 =?utf-8?B?QnN4akNRcFlsdGZkQitpTmtJbzJWcHdrclg2NHdEaEZUTStuc3lXTklXbjRt?=
 =?utf-8?B?UDJpTFJnNWlLZVFIMi9vU2lrWThicFZ0ZEZoTXZEblpvc2tCRTZqTGpBcXZL?=
 =?utf-8?B?S1c5SzZBK3JjZEF2U0ZpTm5PcjE2OE56S2lodnZYQk94STBDU3JqNjVQRXZ1?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c733467e-1856-46e2-318e-08dbf1f332e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:25:03.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDIM9kXvJhNtaG9RFrmn2BKnTrnyEH7taVcgJDWgIp+Q9CxR8Uv7zsDIFPixQmvbdXWyg3s1vy0OzUb4B1pTOE/6A8GbHBw2m/uFs1jMcLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2023 3:40 PM, Grant Grundler wrote:
> On Wed, Nov 29, 2023 at 3:05 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> On 11/29/2023 7:53 AM, ChunHao Lin wrote:
>>> When FIFO reaches near full state, device will issue pause frame.
>>> If pause slot is enabled(set to 1), in this time, device will issue
>>> pause frame only once. But if pause slot is disabled(set to 0), device
>>> will keep sending pause frames until FIFO reaches near empty state.
>>>
>>> When pause slot is disabled, if there is no one to handle receive
>>> packets, device FIFO will reach near full state and keep sending
>>> pause frames. That will impact entire local area network.
>>>
>>> This issue can be reproduced in Chromebox (not Chromebook) in
>>> developer mode running a test image (and v5.10 kernel):
>>> 1) ping -f $CHROMEBOX (from workstation on same local network)
>>> 2) run "powerd_dbus_suspend" from command line on the $CHROMEBOX
>>> 3) ping $ROUTER (wait until ping fails from workstation)
>>>
>>> Takes about ~20-30 seconds after step 2 for the local network to
>>> stop working.
>>>
>>> Fix this issue by enabling pause slot to only send pause frame once
>>> when FIFO reaches near full state.
>>>
>>
>> Makes sense. Avoiding the spam is good.  The naming is a bit confusing
>> but I guess that comes from realtek datasheet?
> 
> I don't know. It doesn't matter to me what it's called since I don't
> have access to the data sheet anyway. :/
> 

The name is fine, i just found it a bit hard to parse since its
effectively "PAUSE_SLOT_ON" makes us *not* send pause frames forever.

I think its fine as-is, since this is referring to the use of the pause
slot in hardware.

>>> Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
>>> Reported-by: Grant Grundler <grundler@chromium.org>
>>> Tested-by: Grant Grundler <grundler@chromium.org>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: ChunHao Lin <hau@realtek.com>
>>> ---
>>> v2:
>>> - update comment and title.
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 62cabeeb842a..bb787a52bc75 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -196,6 +196,7 @@ enum rtl_registers {
>>>                                       /* No threshold before first PCI xfer */
>>>  #define      RX_FIFO_THRESH                  (7 << RXCFG_FIFO_SHIFT)
>>>  #define      RX_EARLY_OFF                    (1 << 11)
>>> +#define      RX_PAUSE_SLOT_ON                (1 << 11)       /* 8125b and later */
>>
>> This confuses me though: RX_EARLY_OFF is (1 << 11) as well.. Is that
>> from a different set of devices?
> 
> Yes, for a different HW version of the device.
> 

Great.

>> We're writing to the same register
>> RxConfig here I think in both cases?
> 
> Yes. But to different versions of the HW which use this bit
> differently. Ergo the comment about "8125b and later".
> 
>> Can you clarify if these are supposed to be the same bit?
> 
> Yes, they are the same bit - but different versions of HW use BIT(11)
> differently.

Thanks for the clarification!

> 
>>
>>>  #define      RXCFG_DMA_SHIFT                 8
>>>                                       /* Unlimited maximum PCI burst. */
>>>  #define      RX_DMA_BURST                    (7 << RXCFG_DMA_SHIFT)
>>> @@ -2306,9 +2307,13 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>>>       case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
>>>               RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
>>>               break;
>>> -     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
>>> +     case RTL_GIGA_MAC_VER_61:
>>>               RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
>>>               break;
>>
>> I assume there isn't a VER_62 between these?
> 
> Correct. My clue is this code near the top of this file:
> 
>  149         [RTL_GIGA_MAC_VER_61] = {"RTL8125A",            FIRMWARE_8125A_3},
>  150         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
>  151         [RTL_GIGA_MAC_VER_63] = {"RTL8125B",            FIRMWARE_8125B_2},
> 
>>
>>> +     case RTL_GIGA_MAC_VER_63:
>>> +             RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
>>> +                     RX_PAUSE_SLOT_ON);
>>
>> We add RX_PAUSE_SLOT_ON now for RTL_GIGA_MAC_VER_63 in addition. Makes
>> sense.
> 
> Exactly.
> 
> thanks for reviewing!
> 

Great.

For the record:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
