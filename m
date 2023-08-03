Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AD76EEC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbjHCP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbjHCP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:56:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465D3C28;
        Thu,  3 Aug 2023 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691078162; x=1722614162;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2f/4sdsnh3ve4v5VHXytdwoRd3Khg3eL3Y5kvvdVElw=;
  b=hwdSzlXyM/ggbKzYqYah/iSS+XDeXb1hlMwKJPjSowndb0dptCztNlzG
   FS6scPZkdmC9do+zIoK9cN3s24+jmtmYeQNM9/eVvJNavo3Myyt3si703
   kIPEVwR/axPZ/dfOCvDhHjSCvocc0brxgdZBzdB/xoRkYh//qClEr6MEx
   J5H8FXSuimDqmCFhDB/69QR4eoulybXvCM2qPCe1RXdWY7KQSU0F3UD9k
   Dl7R1L5YrSsoOPNhlUUcTmWRSEyHgasc7uZ5V1524QaoR+6z8ljZY8mcV
   BxF6UuB0dH5OFJdSiYImAZ+d/MVGVfumL47T3cJE9Ch5lEViSamqSAcsw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="400867534"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="400867534"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="843635519"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="843635519"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2023 08:55:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 08:55:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 08:55:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 08:55:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 08:55:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJWLdfbpfcVv2Q6bJbiBp/zW3FoIZYxeHGSWFkDyfUQYltGts2I9Q61EQ7xZqa6ccLWudyciaYTfHVK2NqYluB1CTAH1y4OMYWmbZ3Ou50hV12bolXCPw/uPqODpPbg9hyn0g4WkXhlrpUFu3LC/+xF1LBCyySHpPZstKLuknaPiL/AamcnAtfW6F1IlhBzSrO/1/Dg5GOeGjjZlYJS3jEhNnfCkuevEIOp3KiuL2U63KrKo5LOplT9qZsjcWTcB5qvrXhbyuSCOXYOTVoKoEwNu30UE7w3miRJh9kgcCIn69HTpFf2JI00wrSXoS33Ep5g3rQ3UrESnz5L83z4nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2M2lGosce78zmFcwqsAud0jYL71Puo/NE9jh3uU46o=;
 b=ftH1NRl+pRFpGG1PmbyxilnSYVgpEWjW54xf4GL+f4eLvA1/9Xl2OwXXPKEn59M9p4aYeAGtpzEX+G2liI9BsrpgWC1OsPfSHP+fL4amZNYk8XNtAbj8BL3ltgmq1AyDw1T5PCyCP6GSLf5QL93azBZq/O53croYqJyz/il38PX/avN64RZYwCLhchc5IYFglhqiEd62E9i/FtcnC4fTQ5XeCgqDT7fdF62tcEQEcOQRiKxrmZi1dOIbgdFvhZtiYda9X/aUs+P50qNt3trUTDFS16TUN6L4S6exDzGenbjGih/vOy8VCDZGaTvdjydN3jQK2twBJE5zKhhesFoXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Thu, 3 Aug
 2023 15:55:50 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:55:50 +0000
Message-ID: <a8466f4b-f773-4d0a-f22b-34c83a7aa942@intel.com>
Date:   Thu, 3 Aug 2023 17:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 0/3] virtchnl: fix fake 1-elem arrays
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>
CC:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, <netdev@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230728155207.10042-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM6PR11MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: c12ce2e9-785b-4edf-fcd5-08db943a1bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niJ2+lMd1z2wt/PEwqghPGGHwk9hPWMY7SBPOC5tNjeMw4Xqm3ym79fzZ7eRIJvbTdc/f9OZJEtiTAl932An2pUReciVzsLvyvrb3V0HH274kB22O0E2/x8YGVnboHl3wo/8CiBWbublpj6BgXpTmhzkwuK79HeL+N7FNGtv0p8x1IkaT+KMjoYc7v0h4Y6+FHgmeuh5VJnr60njAYj6z33m9iP/wLC09YJiFI439pIhUKBB+dmIFvG2TNwplVR0GIDra1QiZhXEKJ2GpzmlVkNRLg3y21hqcoCZd2JBCgkq7uZlm/2eBFJmBiPWdT3LXHVazCfssWgXpXumdVsENfFfkyVOr1IizHOA78i3BY0lQmeh5lJyeQLjAPGlaUYE2cCUCbB7c6v+FYyX9Imct/5F2gkZyYzvnLKLEp4VEm8MIHsir2sFKc16b5Kh1p82mZDMPyQv9ZsAjwDXhQlYyuck8kaI1f2CYlre71GbWr6rs7ieFA5EU5VnkijDLoJv474vw6Y0Ozn5CvoTf1JsVXWYuuer52v5PhXRFzQ3Tsih+nCmw/c5H2rvrxUK84U45a7mCA9Z6ov8PuZWJ1yATWBFP4iq3EGtpoI/9+D1hnjEWelB8KpXVMDf9pB4/AST731mw6VBpPGzGamNiebILw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(6916009)(66556008)(4326008)(66476007)(66946007)(38100700002)(186003)(2616005)(82960400001)(2906002)(6506007)(26005)(7416002)(83380400001)(54906003)(31696002)(478600001)(86362001)(36756003)(6512007)(6666004)(6486002)(4744005)(41300700001)(8676002)(8936002)(31686004)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09OMDA5YmdUc3E1V3dIMWd1eTAvVDlaM2FWN1hxQWRncnVvSjRuNjZUU2Zq?=
 =?utf-8?B?SmNlS1UvVVc0N3VmVEo0VjVKZFMxc0djeWkvLzM3VnNjdDNhdnJDRWdUSndo?=
 =?utf-8?B?Z3MvL1lDa1FNNjByR25nMHdOTFJwTTNFbERBNkdKK2FyNTcrdExTY3JPMGNv?=
 =?utf-8?B?V3diRk8zUUJVNGpCTi80TnVWSHg4bTF6T3BDK0d2UTJra0ZmUXZBV1BUZU02?=
 =?utf-8?B?NUoxaHlPZXIrbVpNK0xvMFZKOG1EWnFjZEN6bFlUditrR0dnaEJoRmVrbDdl?=
 =?utf-8?B?UnpnNzZKTVE5OGJMb2xzM2pyQjNPZ0JEMVkzT2d3UTZFaVNzeit0d3J6SlZL?=
 =?utf-8?B?MVl2VmNGVHBvWm02RU1YSWVDVHhKZFBrZlB6OUNKRmdzYnAvZG9rOUdsTjlZ?=
 =?utf-8?B?Zityb01kUkNMZFQ5YytIQXJ5Umg4RHAranQyZ0VOeWF5YlR3TjNUMVlKL2g5?=
 =?utf-8?B?M2EvVmhvNFpJSzdsMWFjV3JmUER0aWxIYkNJTDZSemtzWnA4bk9adEZMMEQz?=
 =?utf-8?B?dlFNdHZ0VTc1ZjFwcy9ackIyamFNZFpUcXBPVW83cTJqbEsvc0lBa1dBc3FM?=
 =?utf-8?B?akIwbDZPaXJjK2VJeWk0OU4xNHZvaFRmVXlCM2M0TDl2eEJTUG41WDRqS3Vz?=
 =?utf-8?B?RkxBajZ2MXdXUm84cnNzNkR3SDNPZmJRZnBkL1N0amQrVWJpUTVRdC9uQU9w?=
 =?utf-8?B?QlFDUFRhZzNXU1JWRWs0MnRGQWxBd1NhbStOK0hWdjNBb3V3WHFGZzBaaUNU?=
 =?utf-8?B?Kzg3MUEwY0VFNWVlVGRMRWUxdVlKQVVTSW1CMmU3RmN0OElGR0NqTktXZFRX?=
 =?utf-8?B?Rm56L2taNlBDbmRRTmhrY0tGRVdvMlBSbGZjNHYrT25IaVdWUGFWRnhqU0Mz?=
 =?utf-8?B?N2FLSEVEQWllNHFvV2RpMS9PNXVrcjZsa3I2SGlmcVlsQVhoUjZ6Q3Nxd3FK?=
 =?utf-8?B?V3UzRlIwVk1NU0U3T3FtRDdGSExJV0hGM1hvMFJMTGhFd1M4SzROSFRQLzNy?=
 =?utf-8?B?OEphTC85WGpsYXRjN3ArQ2hsWmFxQXd2MmhaVjRLODdFbzgxc2lIYVpHU3Yz?=
 =?utf-8?B?alp1eC8wLzVweDJvQWJUcmE2MjFUZ0hqblg0b3g2SHVlV2ZWUUJvOHdFemRM?=
 =?utf-8?B?WTlyT3JqNHU5ZHB5SlhtMldVL3l4V3lZMExxdmt2RTNvU00zREoxSDZDMXpX?=
 =?utf-8?B?Y04ra25qazlzZ043aXB4WHNYMU4vVTB1VWtaQjlZeDhQTlluMzB2bDdsajdw?=
 =?utf-8?B?dWs2VkJoUUVOTHpFbDk4dFQvTWZ3b0QyTDdKQmI1ZHZCdVFINGRrVzRKcWVN?=
 =?utf-8?B?TEMyL01xS2t0dlllVnlYRFMrM3ZSS1lHNnZDMlk2ak81eFJ5d05IRmp3bkl1?=
 =?utf-8?B?Y3RRaUduQlBGd0YwYWR5akxlbXV3SkNoSER3RDlzOUUrRHRJZ1YvVkNnT3Bk?=
 =?utf-8?B?ZUVaaTFDTjZlaU9rUThHWEhlMEJmOUk3b1BscVZvdThNZ1ZucndHMXJObUVW?=
 =?utf-8?B?OWtUZnJSK1FkZFJFRFNwWWluVEpCVDVwMHViNy9ldlBvMFNVWG9BQ21STTVK?=
 =?utf-8?B?dCtPOHZrSXJ5c0E3QkY4Z2ZpRWRycUhjVFZXT0lSM01uZVk5T0xUTm4rK09B?=
 =?utf-8?B?SXNYNDdiNWZRM3NnNG5FV3NDU2JneWQ3RHh3Mk5VNjMyK29SZVRVTDZFQzBs?=
 =?utf-8?B?d2VHajBkeEViNmFoMXZqL3I5aWp4T3R5VzhGTVVrd25XTFhhcjVFWkpoSTVX?=
 =?utf-8?B?UUI0Z3QrU0FBQUgvMktWVEV1SU5PQnVDVGFWZVN4Njkvekx4RWE4Z2xPdSs4?=
 =?utf-8?B?TkpGMUxraStxb25RT2FOTWxTbDNZWkFkTTFiV3RFNEdHUmJUSmFYTk1PNE9E?=
 =?utf-8?B?TU8xcDdRUVBhZmMzZDczYWxSdGl2SFBsOU9TZS9Wdm9XVU9QbGRoRkhUWnRr?=
 =?utf-8?B?bmx2NFBjL3hCK0FKZzZwYlFPQzBZY0dQWXBYQ3VtSHZkcWVIN0JuVy9FU2Zz?=
 =?utf-8?B?N2xmYUQrRVVFSncwa0Y5R1BUN1JkdzhmNGdvZnk1VUYzdXoxK2xhTU1zRjhD?=
 =?utf-8?B?U3ZIZlJuUmlIWlVEMzVoa2NteHUrWGZMbWU0WEdxVFFSY01sNjZKV0x5TkRF?=
 =?utf-8?B?QmhxSDBadW8xb3Q4MlVSZFdiS1pKOGJPaTZUS2pTWHRqYXVvdlB6VzlUNzZp?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c12ce2e9-785b-4edf-fcd5-08db943a1bf5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:55:50.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pR64vSqbKQgPxNbEK94aWOJwGlp2bgyh8Orgv/dLJILC3jOHQGhj0dd7j1yqKRN2MAZcX66h3kFVA2fSRd+H0Cergsd0RJYR4FEmUS/2/5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 28 Jul 2023 17:52:04 +0200

> 6.5-rc1 started spitting warning splats when composing virtchnl
> messages, precisely on virtchnl_rss_key and virtchnl_lut:
> 
> [   84.167709] memcpy: detected field-spanning write (size 52) of single
> field "vrk->key" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1095
> (size 1)
> [   84.169915] WARNING: CPU: 3 PID: 11 at drivers/net/ethernet/intel/
> iavf/iavf_virtchnl.c:1095 iavf_set_rss_key+0x123/0x140 [iavf]

(tender ping :D)

Thanks,
Olek
