Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F087D27E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjJWBQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJWBQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:16:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70B4F1;
        Sun, 22 Oct 2023 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698023813; x=1729559813;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=HJoq5IODeNhvMnN5uNO0J8oS9tuwZ9wbzhZ5e8b9MUA=;
  b=kB2rkyxbDuzIZAxZIG+z3bBHApVm8UxzDoie53VgWFOhJtSjxPZRoqyN
   bNAy54h30lmLkak6RBd/syu9zLi+q1Q+YEKRqlNxf4WRecW9bDcBs+80g
   iN7yjnCS26w/vjgDRNF7htYsDgC7oZPysJ36onGTmHPh1LP4GCwjUO4Oa
   jxd+pcnn1PT5xm0fHiTjgjkjoKSgjkZQwEVNsoavavH5pvU9yrghyk+ps
   W7DFn2/hnt0B5JL9QOK5PESEkaudw5UtD9mVbWBN37eEP5E5C0U4r5Kxo
   xB9n2G1dZFnl0HF+qlTeewL8yLh+FUK9+UgbJiODxsPKzZ3BqHIZPeYoM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="389592887"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="389592887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5906810"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 18:16:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:16:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:16:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 18:16:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 18:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxAnSwVJI5MaIIk1XkY2BTQFW223OyEaKVOLlTbkoVApLJjpQNnBJcKnMHzX4l8/Wzu3OHXMC4HtK5l6vEP2WDW6SPOyR2QsBAKFJENlzNrCnreqTPmLromf8ZtkUkv++UCIQt95D+tC4v0Ub5CA/LWFtBY2HFqWKFFqyau7doFc98Td6b5IJJ3WxN3W4sg4V9+cG1HyLRps/3HNLqdZ/6opF0+hDmkv8KTKm1yU0s3VF/2zHUtKSJ4qriZSuYfLcOMPOPUl9ul/MEIm/UnL3zbhE2XT5OEpH9RvFnknB7/TVRM9UA+rGWrhQwg8SjGzMzhiZ9MxH54Qok7fdi4haA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7bAj4P3PrUkJ6arQ+NjRvOd3ZNxbfXzs2Eveumiuck=;
 b=ZTW5Pp0zIV5uPePZlf1IctX4xxV55MR9h2NllpdE2uvsLXkXkKPGyJFz483HcezfH8a5NzfxKJdWXfq80baKsj5LWsrBDSVaRWChhOOZIrXIaSHuEHALddTtFj7G2zhwlSX575YP663PxygBd6v/Pdf+QJk+YnnYe/5tpcva9eUhm9LfHBTzsSFGeyJqu7GEnR/C1T1Gt11BDw3PRad2z5yQPx6+LhUO3/mVu54OGjDAhlha4eckbZS+tBpmc9RVFv0AnvL28tedmJ/zLgKl38iYkJOCZ/0mR4D4aoIMJS80WZb1j9s8uOwjUWCAWN31XcLljq4BU2iasImDmF3vIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 01:16:49 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 01:16:49 +0000
Date:   Mon, 23 Oct 2023 09:11:57 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, <miquel.raynal@bootlin.com>,
        <conor.culhane@silvaco.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <joe@perches.com>,
        <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <imx@lists.linux.dev>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/5] i3c: add slave mode support
Message-ID: <202310201829.Hgq2x9nm-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018215809.3477437-2-Frank.Li@nxp.com>
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d5a6cc-3f3c-483b-e8f3-08dbd365bb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye+jlXbgJgNJnh9nv67pVcEa99zsen6JAj49g/FTRIXrecwZqM4dEXFOY5Fbn6JkQq3DU3vGGXm3O2C646cklrapahwaVcAhI194Ivsq6IAxgLNZuRWRJTCrhS2FSCk7QoJK9qqoKQ0cmGydhPq4X3DC7KjEKDT9q20I8IKePzXMFsaMEcIi/pw4ShFaHo/5Q9UvlDcf6bLDz5xrMvS/EhW47rpQJJq+HDIsWzgVvJGBcB4nMUViyWAXeDhkbmUIhFANEb4wbnhNPUNvl+qjDd8plTHx+PCbrQPbsMOOWFROuS9f/qeLw9LghkycaMkSMiRNI7YRWxX6a3Q4GqY0QfMKlGDZmpQOGvTFVSu7jS5OCmca1+LOH7b5NrgHR8ZRarKuClyVfjJ+F0mtzIryJxUq1zf/AEUeAOLwFJIBhalxeS8xQ0yD3XYXUrLI5KoVn1frLA+PZUNtf3MJyLr60Ihnx+33Ns8/OLEvAopYK6t8yLmUFh6D7TVaIYWsinFYlLwz6GjItJS4ClWKuft0G98lCcGFJAi6PSK3U8DN26R9/6yyMGrfjtqQg+ei7JrJdsCKg7uM3lKV3W66RRU5Gvzdb8pS3e6rVM+LbOtrooOETqS/WY8ZRSC2KSLiHx8a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(6666004)(38100700002)(6506007)(6512007)(921008)(82960400001)(66946007)(66556008)(66476007)(6486002)(2616005)(966005)(26005)(1076003)(478600001)(316002)(8676002)(8936002)(5660300002)(2906002)(4326008)(41300700001)(36756003)(7416002)(4001150100001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlfBGlKSMXxWhhVQG3oqpxj8Z6Xo65dLld6Asoj8HxpesVDuh7HEBw+zMegy?=
 =?us-ascii?Q?8QTCrEzsHLPBN/QrW3W0rxy4zHQyS11+NhaklhmLDgkTr4cYIe1zQx/RXNh5?=
 =?us-ascii?Q?kBB4B93jV/cbtG6mUQ8SgdohCRSYqvCHWRQ9xGe3GIcEzDiC1qMf7tlzSVIE?=
 =?us-ascii?Q?T5zRu9d1q4ctGkQqgfemgj9nbPiWywuzZQN7IgkY41N5wbNXo2v0CqWb0Hd1?=
 =?us-ascii?Q?bXNp2kqmlcF3+H0M6Vy48awGQHKixCGU9dgBbUcOBQ3mQt4GmoL61OAQgKdS?=
 =?us-ascii?Q?biZPuDgRTjemfIh7OMd5S1bqOGISA7MkJBG/at5zoDd00qVwsBXmgMpmo5dz?=
 =?us-ascii?Q?UFRKrfq+qic6UZFFg9oDV2CpFygDYjyoLYe0rwk2Z7f704sw5O/Y8s26iNyr?=
 =?us-ascii?Q?HRzQP47lLovgsLtkPhM7Yb5wl0jx9+bQR1D7rr2D9V6MEBHwTOtuL1/yrHgq?=
 =?us-ascii?Q?kuztR5Qnsr+iLRkQX01Yxjaa7wwmcWxoNEVXSrvk4/YSeocH3B2fcsPErMYH?=
 =?us-ascii?Q?/DxYDvrX3kxgNphiM8AO0dPdEDaysGnLKWQ8HUdg+AIol+a18JtCO9Bcl9xV?=
 =?us-ascii?Q?E3B+/7cdoXoAabeZlKR7GwGDnNfcpOC4qTE9o5YL5eVKt52OyrbwjWM4A4k1?=
 =?us-ascii?Q?FP0pweWLdS6FzT2Y1sekFurP4OZanWevl1Ue94Kqmp/ayhqLiGUIH8vVMdQ+?=
 =?us-ascii?Q?UASRMJuHhQK1K0fpeAfoQiDGvkx0V9XosLABee7IxRSmFEfOzpaMSnpNf3iS?=
 =?us-ascii?Q?fsBQfAncR4TFBfBZcEF/GdHrFPj4x1o4W0SqWvNx8YVXhP81B4Js+UUDB+tz?=
 =?us-ascii?Q?kfZz4IW9qthpSW3jgSTSxXYR41p+dTMPVroU+nU+FZZgeTzrIW3xrPWwv3rz?=
 =?us-ascii?Q?oPYQuIbJ49tvUoBXnC2SCyE9exdiaIpi1vuQ9+EpA/vVqUGi0La87VCYrEMo?=
 =?us-ascii?Q?c7TAbaJtsxfmi4iUYYveTNurKHnxkutVMQ0Mu435BHqZpJbasIjCw2I8CIqy?=
 =?us-ascii?Q?/cHxl8XHNXgyCMyIGZ5gQkpubbnZkWgufVVSuUbe3vMGp+XlaykQi98CldZn?=
 =?us-ascii?Q?wYlSbtvnpbYhndJy3XKTLJUYnKo02+pp+Bp7U9FAtQcPeKG++cmYLBUwKSi9?=
 =?us-ascii?Q?otXtbIKHGKhslQXUhaWVvep8u2uwWR8T9qCVw79L4xLi6U5Nkmab2hXVp+2E?=
 =?us-ascii?Q?gZCeC/wUtULvNGc3ssuLl+m2nm51wHRiEZWl9v2gY0NqPrPaqRWqCWZAFJl7?=
 =?us-ascii?Q?VaGe+uh8W7uW59PPMA1/mBnkw1uDsuoep+vOT4I+pe+v9aSh5+6uPoFW6F+2?=
 =?us-ascii?Q?2IEG74xhiRcY0JLMVkyMHQo+QJdi8IYZPKnf+CuB8A1abaxHSF7KzTOsmWPz?=
 =?us-ascii?Q?gGcEs6zLbDmHfMH+oIq5yiEqPP0MDTQFidUaGJ1UqTcbJ6dqRIZmojKv/l1m?=
 =?us-ascii?Q?bmXhGTTvuadWdEnk9AD7Xc6Rc2wu+PzFZx45SVfyLu8Obm3GOkRZziew4wqO?=
 =?us-ascii?Q?wH29gz/X5j5U2u2HVs01Z/seEy2EIEZQXYbXo9TUk+lDGVMpBCOM8Kt+Nr90?=
 =?us-ascii?Q?JiZtzAPUKPoz+HBXF7pSijaIlmhdaOejT1PkZRlY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d5a6cc-3f3c-483b-e8f3-08dbd365bb0e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 01:16:49.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g19mlLlBRxjxD3QDJ681uNfTIVKVwaodYt1DH3ZlRSK+QUd3RfuEk/dEK9JvRt/wpijukXysTzQ+mv2ixBznSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-slave-mode-support/20231019-055940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231018215809.3477437-2-Frank.Li%40nxp.com
patch subject: [PATCH 1/5] i3c: add slave mode support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310201829.Hgq2x9nm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310201829.Hgq2x9nm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310201829.Hgq2x9nm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i3c/slave.c:166: warning: Function parameter or member 'ctrl' not described in 'devm_i3c_slave_ctrl_destroy'
>> drivers/i3c/slave.c:166: warning: Excess function parameter 'ops' description in 'devm_i3c_slave_ctrl_destroy'
>> drivers/i3c/slave.c:166: warning: Excess function parameter 'owner' description in 'devm_i3c_slave_ctrl_destroy'
>> drivers/i3c/slave.c:228: warning: expecting prototype for i3c_slave_ctrl(). Prototype was for i3c_slave_ctrl_get() instead
>> drivers/i3c/slave.c:420: warning: Function parameter or member 'fd' not described in 'i3c_slave_func_unregister_driver'
>> drivers/i3c/slave.c:420: warning: Excess function parameter 'driver' description in 'i3c_slave_func_unregister_driver'


vim +166 drivers/i3c/slave.c

a63b2858bd837d Frank Li 2023-10-18  154  
a63b2858bd837d Frank Li 2023-10-18  155  /**
a63b2858bd837d Frank Li 2023-10-18  156   * devm_i3c_slave_ctrl_destroy() - destroy the slave controller device
a63b2858bd837d Frank Li 2023-10-18  157   * @dev: device that is creating the new slave controller device
a63b2858bd837d Frank Li 2023-10-18  158   * @ops: function pointers for performing slave controller operations
a63b2858bd837d Frank Li 2023-10-18  159   * @owner: the owner of the module that creates the slave controller device
a63b2858bd837d Frank Li 2023-10-18  160   *
a63b2858bd837d Frank Li 2023-10-18  161   * Invoke to create a new slave controller device and add it to i3c_slave class. While at that, it
a63b2858bd837d Frank Li 2023-10-18  162   * also associates the device with the i3c_slave using devres. On driver detach, release function is
a63b2858bd837d Frank Li 2023-10-18  163   * invoked on the devres data, then devres data is freed.
a63b2858bd837d Frank Li 2023-10-18  164   */
a63b2858bd837d Frank Li 2023-10-18  165  void devm_i3c_slave_ctrl_destroy(struct device *dev, struct i3c_slave_ctrl *ctrl)
a63b2858bd837d Frank Li 2023-10-18 @166  {
a63b2858bd837d Frank Li 2023-10-18  167  	int r;
a63b2858bd837d Frank Li 2023-10-18  168  
a63b2858bd837d Frank Li 2023-10-18  169  	r = devres_destroy(dev, devm_i3c_slave_ctrl_release, devm_i3c_slave_ctrl_match,
a63b2858bd837d Frank Li 2023-10-18  170  			   ctrl);
a63b2858bd837d Frank Li 2023-10-18  171  	dev_WARN_ONCE(dev, r, "couldn't find I3C controller resource\n");
a63b2858bd837d Frank Li 2023-10-18  172  }
a63b2858bd837d Frank Li 2023-10-18  173  EXPORT_SYMBOL_GPL(devm_i3c_slave_ctrl_destroy);
a63b2858bd837d Frank Li 2023-10-18  174  
a63b2858bd837d Frank Li 2023-10-18  175  /**
a63b2858bd837d Frank Li 2023-10-18  176   * i3c_slave_ctrl_destroy() - destroy the slave controller device
a63b2858bd837d Frank Li 2023-10-18  177   * @ctrl: the slave controller device that has to be destroyed
a63b2858bd837d Frank Li 2023-10-18  178   *
a63b2858bd837d Frank Li 2023-10-18  179   * Invoke to destroy the I3C slave device
a63b2858bd837d Frank Li 2023-10-18  180   */
a63b2858bd837d Frank Li 2023-10-18  181  void i3c_slave_ctrl_destroy(struct i3c_slave_ctrl *ctrl)
a63b2858bd837d Frank Li 2023-10-18  182  {
a63b2858bd837d Frank Li 2023-10-18  183  	i3c_slave_cfs_remove_ctrl_group(ctrl->group);
a63b2858bd837d Frank Li 2023-10-18  184  	device_unregister(&ctrl->dev);
a63b2858bd837d Frank Li 2023-10-18  185  }
a63b2858bd837d Frank Li 2023-10-18  186  EXPORT_SYMBOL_GPL(i3c_slave_ctrl_destroy);
a63b2858bd837d Frank Li 2023-10-18  187  
a63b2858bd837d Frank Li 2023-10-18  188  /**
a63b2858bd837d Frank Li 2023-10-18  189   * i3c_slave_ctrl_add_func() - bind I3C slave function to an slave controller
a63b2858bd837d Frank Li 2023-10-18  190   * @ctrl: the controller device to which the slave function should be added
a63b2858bd837d Frank Li 2023-10-18  191   * @func: the slave function to be added
a63b2858bd837d Frank Li 2023-10-18  192   *
a63b2858bd837d Frank Li 2023-10-18  193   * An I3C slave device can have only one functions.
a63b2858bd837d Frank Li 2023-10-18  194   */
a63b2858bd837d Frank Li 2023-10-18  195  int i3c_slave_ctrl_add_func(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func)
a63b2858bd837d Frank Li 2023-10-18  196  {
a63b2858bd837d Frank Li 2023-10-18  197  	if (ctrl->func)
a63b2858bd837d Frank Li 2023-10-18  198  		return -EBUSY;
a63b2858bd837d Frank Li 2023-10-18  199  
a63b2858bd837d Frank Li 2023-10-18  200  	ctrl->func = func;
a63b2858bd837d Frank Li 2023-10-18  201  	func->ctrl = ctrl;
a63b2858bd837d Frank Li 2023-10-18  202  
a63b2858bd837d Frank Li 2023-10-18  203  	return 0;
a63b2858bd837d Frank Li 2023-10-18  204  }
a63b2858bd837d Frank Li 2023-10-18  205  EXPORT_SYMBOL_GPL(i3c_slave_ctrl_add_func);
a63b2858bd837d Frank Li 2023-10-18  206  
a63b2858bd837d Frank Li 2023-10-18  207  /**
a63b2858bd837d Frank Li 2023-10-18  208   * i3c_slave_ctrl_remove_func() - unbind I3C slave function to an slave controller
a63b2858bd837d Frank Li 2023-10-18  209   * @ctrl: the controller device to which the slave function should be removed
a63b2858bd837d Frank Li 2023-10-18  210   * @func: the slave function to be removed
a63b2858bd837d Frank Li 2023-10-18  211   *
a63b2858bd837d Frank Li 2023-10-18  212   * An I3C slave device can have only one functions.
a63b2858bd837d Frank Li 2023-10-18  213   */
a63b2858bd837d Frank Li 2023-10-18  214  void i3c_slave_ctrl_remove_func(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func)
a63b2858bd837d Frank Li 2023-10-18  215  {
a63b2858bd837d Frank Li 2023-10-18  216  	ctrl->func = NULL;
a63b2858bd837d Frank Li 2023-10-18  217  }
a63b2858bd837d Frank Li 2023-10-18  218  EXPORT_SYMBOL_GPL(i3c_slave_ctrl_remove_func);
a63b2858bd837d Frank Li 2023-10-18  219  
a63b2858bd837d Frank Li 2023-10-18  220  /**
a63b2858bd837d Frank Li 2023-10-18  221   * i3c_slave_ctrl() - get the I3C slave controller
a63b2858bd837d Frank Li 2023-10-18  222   * @name: device name of the slave controller
a63b2858bd837d Frank Li 2023-10-18  223   *
a63b2858bd837d Frank Li 2023-10-18  224   * Invoke to get struct i3c_slave_ctrl * corresponding to the device name of the
a63b2858bd837d Frank Li 2023-10-18  225   * slave controller
a63b2858bd837d Frank Li 2023-10-18  226   */
a63b2858bd837d Frank Li 2023-10-18  227  struct i3c_slave_ctrl *i3c_slave_ctrl_get(const char *name)
a63b2858bd837d Frank Li 2023-10-18 @228  {
a63b2858bd837d Frank Li 2023-10-18  229  	int ret = -EINVAL;
a63b2858bd837d Frank Li 2023-10-18  230  	struct i3c_slave_ctrl *ctrl;
a63b2858bd837d Frank Li 2023-10-18  231  	struct device *dev;
a63b2858bd837d Frank Li 2023-10-18  232  	struct class_dev_iter iter;
a63b2858bd837d Frank Li 2023-10-18  233  
a63b2858bd837d Frank Li 2023-10-18  234  	class_dev_iter_init(&iter, i3c_slave_ctrl_class, NULL, NULL);
a63b2858bd837d Frank Li 2023-10-18  235  	while ((dev = class_dev_iter_next(&iter))) {
a63b2858bd837d Frank Li 2023-10-18  236  		if (strcmp(name, dev_name(dev)))
a63b2858bd837d Frank Li 2023-10-18  237  			continue;
a63b2858bd837d Frank Li 2023-10-18  238  
a63b2858bd837d Frank Li 2023-10-18  239  		ctrl = to_i3c_slave_ctrl(dev);
a63b2858bd837d Frank Li 2023-10-18  240  		if (!try_module_get(ctrl->ops->owner)) {
a63b2858bd837d Frank Li 2023-10-18  241  			ret = -EINVAL;
a63b2858bd837d Frank Li 2023-10-18  242  			goto err;
a63b2858bd837d Frank Li 2023-10-18  243  		}
a63b2858bd837d Frank Li 2023-10-18  244  
a63b2858bd837d Frank Li 2023-10-18  245  		class_dev_iter_exit(&iter);
a63b2858bd837d Frank Li 2023-10-18  246  		get_device(&ctrl->dev);
a63b2858bd837d Frank Li 2023-10-18  247  		return ctrl;
a63b2858bd837d Frank Li 2023-10-18  248  	}
a63b2858bd837d Frank Li 2023-10-18  249  
a63b2858bd837d Frank Li 2023-10-18  250  err:
a63b2858bd837d Frank Li 2023-10-18  251  	class_dev_iter_exit(&iter);
a63b2858bd837d Frank Li 2023-10-18  252  	return ERR_PTR(ret);
a63b2858bd837d Frank Li 2023-10-18  253  }
a63b2858bd837d Frank Li 2023-10-18  254  EXPORT_SYMBOL_GPL(i3c_slave_ctrl_get);
a63b2858bd837d Frank Li 2023-10-18  255  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

