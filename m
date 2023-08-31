Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657E778F2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbjHaSqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHaSqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:46:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA53E5D;
        Thu, 31 Aug 2023 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693507602; x=1725043602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kWuxPsskeObcQj9vp6iZpoCwBogyy1atYbu4Fxm44ps=;
  b=CTJLWfAqVEqPA2jCnrjQgsEk+fxp0gloV8MhbLvK/mlymMDRc6pEmc18
   zlFgbfJdbnk1rppHw5CFvv4BGYNyJFGo9NmLFiR6u8MID49rlnaVUBpDF
   jYXknbiFtyggaCSrptUM1rxq92khhDYAn2XdCw/HJEMYZt4exoiMIdB9B
   2swONhiBSwpZjdljmA8ypbjdqpN5DJooGlTQz3txzlCToLZQMXtubk443
   FDHXt9MArCiHG3f2y1nNMvDZLKVfXL7e3cSW3q9rB6BX5H4tn6oP6zSJe
   zDjngQ79JoDy6ZibTtdJqfOSzhi0BIKiBmOzqxMolZ0vTZa0F5eU6zkFY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462398068"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="462398068"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986357449"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="986357449"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 11:46:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:46:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:46:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 11:46:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 11:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwF8O3FwBfcO4LWtF+v7VXWAiV6xSpemQUu315mnATJr0pcmg0KXxvujJj5uZNzbC10WjLmCGCRdFW2YY7rFjaxOvFA9MyKpn9hcJtpTQ/qiQyptMbL7w+3NqvtYMQRRKcrm+5u+TMRH01fLxyjeQSx7CaveGSUI4zj57yqDEJHEfTtis5W20usXmJv5avmPNZW8kgdh5pNSZUtY1iY6YIgSG7ajOKy4CFYZxHEYzSCgdzSCWCdcnBfFw3CLjCZiXY45ShOln6MOagD82WLrC+rqePljm8k7+CTJApeBZwijv0bYXvjusGePG652vMgtmTipfba2jjx/HydVcItf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdjwlWLPZqU6n4zX2lykgnrcFohrNSVZfvvxkuTluHY=;
 b=jyOs6U0U9xdhGmguz+d8G04BxAVT594tpbSbgQElH1oKoeqWhjikXOJiGIgqJHGjC8pm+e6dph1icAiChkfY8svMzJP96avRT7575vXshRXkFExFHmzKSp/Iwxd1SLH167Vmfj4qZYC5zjOdYLK0PNNe+KBuy3GpMlSdT8zZHdX2r+caPd75ERpg71Oug/QbbgVOfpbLfub+F+2fKuP6xZg68jlFP8sogtSnRocvS3RIBkdGiNFGmjzoCgN744G2E4Qyw3q95eRHg/pwiNo62imznHpciWTNvLlH9FD2fz/RZSfvLTfCsoQfeGm243FRzGU6hGlJ6hOaLJeUMeLG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 18:46:38 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 18:46:38 +0000
Message-ID: <a18eda14-f2a9-f775-3dd3-14e8f06f8071@intel.com>
Date:   Thu, 31 Aug 2023 11:46:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [GIT PULL] non-MM updates for 6.6-rc1
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <mm-commits@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
References: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
 <CAHk-=wgsKp2ZPxQ_WvRGLJXtZG6Z2TrqC_jNppukfniCZB9doQ@mail.gmail.com>
 <20230830225335.kmdj5er253fr7rk4@treble>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230830225335.kmdj5er253fr7rk4@treble>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6c72d3-d1db-4900-4f40-08dbaa529bc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zh348I7ziZ2BZ05xdQ3rFFSC20DQZiHV+iHtuTCj4xNeebXZS0OnA1m9Wj1kSCzKtuQgEHjpeE8lynPOt1Yf5p8Ro59QQi6NsQTkazNGsTMp4roJN9VJsRdcB+tCJ8Zkkrsr/6ZG/HX4547ff9E7s/Py7V5JE5xGNz/t8gHy2eYL4sWEIikdt+ix+0GW4enGIpc2ExeBDEjcTuFJRqww2R7d5+/tKtzlXgWIyLj9Au9x/EbIQyrM850N+sALpgwdQzgq9s/59ZhtwT+Dk4OWGn717FfgDlsaZzMNcRhuyzPfO25vZsIziVhvHXyQa9LlBvs8GdfPY9t6q644RmOOnEhDyREk3rVecTIjGRCYDhu//+smt6MWSI2pbuL/PtO3ODNS+sbmOxtyUY82kRwRyi1ZXHQ1JS0HKF4oBsqr3AlW5DuDbZ0oe48BOAtXFm9v20vEfd5CSjD5o1icuWg9loogw1ZjTOi4saZWCyrn+EFj0vlOvgbxHarQUx0EVsD958ONvywvEgf79b2C7EDzKD5dh0pt0PaA5+CiJr9gyLSBPS7vBAz0yPsT2Cs9lGDfeFugx7oCa9F1o1Zmuq0PVTnhJuSIfz96vSTcwZPHQ9M69nImIk841ZrEnWzm4EG0U07i7iPka0VrVqlt2rEMOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(6486002)(6506007)(53546011)(478600001)(83380400001)(2906002)(2616005)(26005)(4744005)(316002)(66556008)(41300700001)(44832011)(110136005)(5660300002)(4326008)(8676002)(66476007)(8936002)(82960400001)(36756003)(31696002)(86362001)(38100700002)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhaTE4weGRSYll4Zzl1OGFVNTNuL3hMMkhpRjhkcVFGM3hvcGszUzN1K29K?=
 =?utf-8?B?NmZCUnR0YktRU0VIL3Q4U2hEM1huL3lta0Q2Qk5uNTV0YW9hTEV2czhPZFlD?=
 =?utf-8?B?RkhjcTkwbm9wYzZuWFh2dXg2QkRRakhhNDY2ZE40QWlyeWJrdktXL0xGN28y?=
 =?utf-8?B?WWJnRUUwNE0yVGRHRm12MnA1Nm9EREtVNlNaeFlPamh3ZzJhMW9HQndkVW5z?=
 =?utf-8?B?enZzeTZrNEFadEdkdW5PSHJpcS9Mek5tRGFLTFEzRUt2N3gyVkMrZi9IZXdo?=
 =?utf-8?B?blJxNlNLSWxnWENRQi9HUmJiZTFGbjBJRWF1b0tTa1pDRnYyMU5NeVBxTDNu?=
 =?utf-8?B?UlNYTVRYL01mUlpOTzFpYSt0MHFzY3lQZDdVOVJXSGZYUWZhUmNrd2RtUzYx?=
 =?utf-8?B?U0tFU2Y1TVRYNXdDOXVyYTlBcnpaZWVYcThDNENVLzBJM1FIL3RwN1AzeUl4?=
 =?utf-8?B?UFBNTS8vMmhzbTcvWG1rL3BvVk9Weko0QnRmelNoQlN2NHdNWGRMY2pOdnlT?=
 =?utf-8?B?NHhBdEhGb0ZTeGxvb2k1dzdncjJEUEk0aC9wRXAyZ1ZVMkNvcXRSUVV3dktQ?=
 =?utf-8?B?dFc1QllaNVB5UDZxeWFVT1FFVE5EZXo1c21jd0orQXI2NE9yTE1JSTN5V1hn?=
 =?utf-8?B?dkZkUTFwQUZtODdJd0NvZ05jUlpSdmRnNGlqZjNvdU43S2JYVC9aWTczOTM4?=
 =?utf-8?B?SWFmVnVRQ205RGlKZ2UrV0lFTnNUQWJUaUY3L0tndkxwbEswVzRYUXZBZUFn?=
 =?utf-8?B?dmlxdkdKNk00OS90NkNFUmQ1c04wbzVxMGNiV25GNkFaMDhrQTlsajIxR1Jx?=
 =?utf-8?B?S3Z1Q1ZjRjQ3OGU5QzlMalJFanU4U1F1WEVLZVZhdnNxYmRPbXl5YWdoZHNw?=
 =?utf-8?B?Q1JpcnY1S3U5Q3hzUi9ncGZQemlUWldEMW5DbmNwNTlzaGE0V0VrVVA4VW15?=
 =?utf-8?B?NXFkMVhiTlhNUWdnM0ZvNWo2VFNiL0taMzhXUS9jbTVXVWh6TGxVWkh1VU9u?=
 =?utf-8?B?ejNMbEFmUENFKzFqWVZsb2JMNWFHZkJ6RC9Bdy8vSVV4TzNqOVpPWkZpbWRt?=
 =?utf-8?B?ZzlTeFpkOGphVDl3ZnA2LzlTQytHc3VIN245bUpBSUZrUkVPN1h3RW1iN1Fs?=
 =?utf-8?B?NXNBK2VYbHF1Z0RtZmZDYlNhd2RRVWE0TFQzOXJPbGFnTVdhR3NOZndIc1Jx?=
 =?utf-8?B?S2NDYWtFZ2NqYWVWMTA2RXlVUk5sV25wSys1YkdVWnFlSTFMSVRKOVNrM3RD?=
 =?utf-8?B?NWczOTZYcFVBSHdVZmhVWGhOYTN3QVdEdUdrWWV1dGR4ZHgrSFIvakI4NTQ4?=
 =?utf-8?B?TlZHc05pNlJrZ3dWQ0dmMjV1TGtlQk9KZzZzNHV1V3duWmR0N05BeXB6cWVN?=
 =?utf-8?B?cTZ4dnlaTlVoeStyaEpSOHp3dXJ1REJIRTVQamxsdHVGVEFZaXNFRWNpdml3?=
 =?utf-8?B?UE1acXk5NGlqRU4rdWthYjZBSmt1Nzdnei9yTFkzYi9MaGNkSFlUTGh3ZGdQ?=
 =?utf-8?B?WmFCM3BWZDljVGVYMmM4eUxhV0NVMU95a09tbG9melVpdjh3ak9kN3prZUZW?=
 =?utf-8?B?ai9RcGxTaG9jR3RaRGpDd25qNlBTdHlFcG1HRjdhcFdYTFBjVVVXVlZobGIv?=
 =?utf-8?B?eW5lenZDVmV0OTdKWVlaQVdzN2VYdGljdUJZWm1GNWc0NDRDVkxJOXVEalR1?=
 =?utf-8?B?Z25lSzJqV0NRc1FqczJKcGczcDVSNkpSYTdmQ3Y5UEJCZVpqN05KZHIyYTda?=
 =?utf-8?B?cy93d1JCeXlWcGplZE1sN0NpQVZzaStLaDMzRWZEU0ZaUTE4V0J6Kysydzlz?=
 =?utf-8?B?K3NtcmJ6cjhOdWpnTUJtUTAzVmV2elJsbGhOeEM1NGVDT3VrRkRHUmxsTkU3?=
 =?utf-8?B?bTRSSC9ueWpOTit6dWQ2eGFOUHJDcVVPaSt4aEdhdnVNa1k1T3M0TU9rZm1p?=
 =?utf-8?B?UldtNE5QaFVwQ2RoMy9abjJCMjUxOS9aYk4rN0JRd2RNVENoaThLWkFmeEhr?=
 =?utf-8?B?RjhaT1hBREZXbm4zekpYdjl2UFZOMDQ0ekFCRXJiTVBPNllIdXhBVVFLL3FK?=
 =?utf-8?B?YlQydjZrSmFsUytUVTFQRlF2RUVWOUlra0pwbkU5eWV1WTFVUjNIOENTNTIz?=
 =?utf-8?Q?mM2zxMMVbb7ZhuEaEH5bmhLvC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6c72d3-d1db-4900-4f40-08dbaa529bc7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:46:38.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVGwr4Hx0TUrvrnNNG4qJVStacH3NsMXWrZfXJ7+Es1oE9rTenkv5/Mqq7wOLP1Cns22TZhL2x6GMK8foiyUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 3:53 PM, Josh Poimboeuf wrote:
> On Tue, Aug 29, 2023 at 03:20:37PM -0700, Linus Torvalds wrote:
>> Hmm. For some non-obvious (to me) reason this triggers
>>
>>   vmlinux.o: warning: objtool: ibt_selftest+0x18: sibling call from
>> callable instruction with modified stack frame
>>

...

>> At a guess it's related to the Kconfig changes, but I have nothing to
>> back that guess up with.
>>
>> Slightly annoying, but I guess I'll live with the warning for now.

This may be due to commit 0d345996e4cb ("x86/kernel: increase kcov
coverage under arch/x86/kernel folder")

Sohil
