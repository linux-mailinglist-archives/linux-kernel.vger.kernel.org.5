Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF07CED85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjJSBUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjJSBUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:20:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E1A113;
        Wed, 18 Oct 2023 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697678436; x=1729214436;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=wMT5ownbF9JppHYm3VZNxwDjWjtEPQ5tSvOQlZCwqcw=;
  b=O4lrCphMvOLpJRTzvtI1H9JsZFXMytR9yyfx/L5NFIsHwRDEDuHQqszz
   1KqpDphG2+Hftl5s7Iid08FM1lXfhxI3k0BWeqrNr5eaEqgBZYjc4xRvd
   17CEIHlIsBZTO2ybOe2IJxp68XdWpssqXGazf5NGI9me7QtDq14Bamm71
   hJ1OsGb9EzvWKJVQIe8JqfEWkkzEuYlxjAe6EUO+a3/toaywbLXBA5L05
   Jklh5bbRo8Zmx/y7lwNlv/E/wdOn+BDdwTOt9nw0QsWsqvdfrkYHI3KHX
   TJt8493+KdvGwkVycaxb9Iwro4doIs8cVCGiEyENO5k2RFW1/dworq+io
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417260182"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="417260182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 18:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="873260266"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="873260266"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 18:20:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 18:20:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 18:20:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 18:20:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 18:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae9+6CfdzRr4z1LzJwxUFdj31x1/1qAdhtsJ6Z9Tv2atymnbaV4HZgggda+RspIO2iJDXpWhsoPvh6WHHo/qViE3ARA23aknWsLszUlZR8u4AJA1OnsnqBeVTCcN2dUEM03ZkzVkmTGa9oNd1e2nOLycELSuNaZ+93ZyjyNS66XHRHzcaovnQof9fF+Hn2twRs1EQukikpyyK6p1zApZ8CMoCnbqqK39gp1UyKpAi1FEy5+oCKUNRGb3DJxK3eIeOXUeNppPQ/PMSvptr40t/YeENMtB2R/scIFEkKJZEKRoWS1svi4s6boR0zZoqiLpk+XKDeAhJVWi96DeIctfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aWt39g+CPCx074NevdXMPF9dU9mbvVNQw5BiteGvEA=;
 b=JVE/7389pJSjwbIlbX6DxXP8UqThsbWkorwXj/m6L32TGdCLJoK9G2Jmk0kPGE0UJR4cNBgxSiF1g8fTkRmOk/w4UyZwGw1qQn73KyOYhpaW8my1EJVJnVb60gWovOdJuWqmsWvvt+jdoZnMXCy1Edk+U6VNRQ2/AacRd+lWi1yLPwNbV1bG8ZgMi/oYMrpqQMNTmLe60mcKuAkpYQkwSoLZ2HcVebxe7jXnopi9dDyHUkoRy6dfbtMmxTYSp6XNBsj9O1NeUCxSeONkqxRlDHPcqya39oJhP2gc/Oqtmu7ZzmgfBm3kGxeYKGZDCMmIa0awBME+lzxW72VkU/B4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 01:20:13 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 01:20:13 +0000
Date:   Thu, 19 Oct 2023 09:15:20 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH v2 4/8] clk: qcom: apss-ipq6018: ipq5332: add safe source
 switch for a53pll
Message-ID: <202310181650.g8THtfsm-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <000c61a028814f08a9fc6d1d5c446e8dad11a650.1697101543.git.quic_varada@quicinc.com>
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: d48aa528-ad1a-4711-6b16-08dbd0418b6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIt47bzKyHgHH4WkVQme22P76hON1uNKe7v25JSulIniYCDWKI7jguN0adD5lTBuuRzmHiNDwvxoYAbgBEc6X9cXbtxC14bQImrGWix2tbE+mqRba6YjlKS6rTfCHuM/7F8o2OtZ5UEqNDULvTFH3ytjdXzPw+i7lFTjrTZCTh51ZThqmVyh7QWrcMB5vQEG1D5kA7rb7RGkyTvq/voFjcnr0EPITotXosuTGz8DTZ3SPmDxfzEi5fymtvIAXgMcUzbLFvpP2niEObuReQSS02Xy4nXF7DXbq4vbwNqitqMqzUwOJPTg3RM1DxgvCTvRp15Eo6qURWFNmNjQsRP6x3oKa76PNndfM8/Dd+qs49kSFDjnB33GEJuM+G45OkiF4IkZ6AQPeK1gOjIZHOPZL1ZSEi5ZCIFDMQlXB4SgEjSfwXi4pcV9p0K6bZI/MkaRJW22b7hdpAkYRTKFoemu5zXLuKGDtLKom4aVVaaGx2oHWIlaRHeFxxZk0gK/ntIWL6Z3AZOL68BK4OqkVwXidNWBIUlmvvCcOWHxTaB4i7CnIvp8yzcjK9dPu7Var7vc03OWNfPO3PbrS/2OHzgreYCd73whdk9ZntyV9aHhdxX3pRtPB6EmPIHSgAsMj5zL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(966005)(316002)(36756003)(921005)(1076003)(82960400001)(6666004)(38100700002)(83380400001)(6506007)(66476007)(2906002)(66556008)(66946007)(2616005)(478600001)(7416002)(26005)(86362001)(6512007)(41300700001)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqU2B8Mtxm3dFNKvcQTHh17vmsZYxG4Fbgwn/GMDiUBpRtCa2QcpBJpDNb60?=
 =?us-ascii?Q?de48MxxS7WUACaT7GbJ5qm1P2i09fpPQNEbbuzMN/YXIzZPWrks/Zku0OYu9?=
 =?us-ascii?Q?dcD06YuRYYkXPQmAWTzMED1W1WiJ72P5+2yifl3tyWF2mWrTjtX9feJjgW5W?=
 =?us-ascii?Q?JeQA9kEcAO8ZlS7DelE72lkCDmNJmFTHc2pk3fXIu4pvb+PoDybt1rs35HFV?=
 =?us-ascii?Q?POeKLtLM0hNzpgeFCtHHzZ3QO/+nki0Ps47/gj5G6NVBvCg4tuCWGzwMUfw3?=
 =?us-ascii?Q?nF/pp5g3MtG7bTRO5VAdRTD59Mj0FRrNMFK7hlYyeLqyRpxKkusARhWtW3Bl?=
 =?us-ascii?Q?aLszPIuYjoaWFSywCY+D8Ba62+6cWWHawG1yyJAQMCZK48AY8QN6GgLxXTXI?=
 =?us-ascii?Q?K4x9uNsSBQBfsHrsfFBOYrjf+PvBSE/+ZtS4h2X5gDB7SFoe/zY708IVOxAF?=
 =?us-ascii?Q?up1EW5dmjxhx+q0e9Mw7jR/QijnBybHO9kf4notkB9WfuQW94QP8/0TW8bz+?=
 =?us-ascii?Q?8nBmhy2c/t+ZLK8B0NeP4iB7N7hUEt3rgabm0G4M83lkMDLRvtkWD3ozSiXU?=
 =?us-ascii?Q?kdc8UkmjOkbgGOcYMXpMVOnkJoip+gSO8834D4vNuaBJoOWiIThVRdhcZ478?=
 =?us-ascii?Q?RZ0YUKELFx0H9zalXV0pwIStf/lI21UhRdMa2qD7ib7p6rKpZxDmLohGZcpx?=
 =?us-ascii?Q?q3XO+iAB0xVAlD9XZ3DUkZXDkKhchJXUVZg0xaV4p7xVZuGFC1AoPnJlzAIJ?=
 =?us-ascii?Q?5Pe63m96LsXDMI5ol5t/bJ6wHaa2Fh4xyKDaDNGqCtVKpYWBRMq++HavdpkX?=
 =?us-ascii?Q?Tnr7DHljj1nFrENYfZWg8Kq7nBgvBJ7BpT73Um0ERl0PalkpiF6TlzO92vVb?=
 =?us-ascii?Q?jZGquWL3ifo6rD0HqC2JbCUa9Guf5SeeHY9UERtJn2i4mb7wQw7sh5jQ6Peb?=
 =?us-ascii?Q?pPsfO1F6jRTwc67yzqVu9K9riTGgY+SL6p0py3PsLOOg3e0aa0zh8Ds2mfZ+?=
 =?us-ascii?Q?DpQXmdI/PP+fxKJJDzy7I/RMkrtGLS5dQNEHwrLogJYDEx+pj4MbBEDudEAL?=
 =?us-ascii?Q?/v6tUHcTJ4tV0VQm0sMbtXMVCiq9Nfw1er7qa/9cmFGMYKYaXeO3nE8wc+Ie?=
 =?us-ascii?Q?RHsYL49wE5oRvTkqSaVQDQRG1kbpxdDIAeY+7Vyf2EOAICXIqTynauWa/hbq?=
 =?us-ascii?Q?7MOw7TVX7upNVC6VEEnC9yKiyrYcbkw5rgCIIiQpPSICwryIlYLpgixqtZSx?=
 =?us-ascii?Q?XVdJTfi71gkcF4ydGaw69P6FJSBJQQlAGVsmu4Jk/j9BYKCDu3mdzIy0KTnK?=
 =?us-ascii?Q?/9uSojQ2w+Pbgzpi2gvMp3iVxXd1m1sjMREdX1zESn5ZM1pCNOqNsK9Ezeix?=
 =?us-ascii?Q?nqVnzWtn77W6CmFdcc2uvT/yzEsSYS+AV6jJMln3uZE+jnyxlFxqouF56w+z?=
 =?us-ascii?Q?WFrukr8Tm2ZfQzdXLUH003G6f2sGB2biE+mu+2pmcooh+LZKPVJUnrbBxu6x?=
 =?us-ascii?Q?VDKXPUFwnq7Qgeo//gunvhwDgupcB9esRDFW1je4a6ug40uH+sJwlePBtYlq?=
 =?us-ascii?Q?mLLiCECETEfdSLwTLjewdm5TvxfUC6RCOg1oGA8v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d48aa528-ad1a-4711-6b16-08dbd0418b6e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:20:13.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw2Zykd+ltqBr3zR/n70230qPy+LwWSgPzDFEqz1Jso9xTsE7CSnTXRXoXS9GcPm5WmX4lylNsnLhpZFsRybbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Varadarajan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Varadarajan-Narayanan/clk-qcom-clk-alpha-pll-introduce-stromer-plus-ops/20231017-104355
base:   linus/master
patch link:    https://lore.kernel.org/r/000c61a028814f08a9fc6d1d5c446e8dad11a650.1697101543.git.quic_varada%40quicinc.com
patch subject: [PATCH v2 4/8] clk: qcom: apss-ipq6018: ipq5332: add safe source switch for a53pll
config: loongarch-randconfig-001-20231018 (https://download.01.org/0day-ci/archive/20231018/202310181650.g8THtfsm-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181650.g8THtfsm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310181650.g8THtfsm-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/clk/qcom/apss-ipq6018.o: in function `apss_ipq6018_probe':
>> apss-ipq6018.c:(.text+0xd0): undefined reference to `qcom_smem_get_soc_id'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

