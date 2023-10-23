Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538717D27C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjJWBF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjJWBF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:05:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7AF0;
        Sun, 22 Oct 2023 18:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698023124; x=1729559124;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=DrDKJmjobQ8VEeGaACsiWav5nEpI2VQAIq2IyvQORTA=;
  b=YIEqMrEZhbeQW7raQtlaHn6R6y9/12AQu7bR7lLq1vd8kA12leoqr71M
   K9DRGnfTazvJenaLKa0lKPRwTKDmCotiCv1o0e4VAt0yzdIR9nlhdoTWE
   r/BxPZVMbjuWWkE868ycmLstUbuCHj1D4mKq1H+474kGbv5IM7k9qG7Q3
   TBzhpYc+xvXCy8zW1r+byD+UN/wkHmyln0A2kTtL0Z+IqKi8fizfCJiQN
   Y0nsZRTwSb7XAKzxtnyvZs5c9GxeS/BsvJxmp9wBToRyfrunDuN5CISVs
   trB/T23r9HZ27gFzG1QIlQGMls0bdxmH4mTGn4fvjVWanlZXm7n7uAvx5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="366094018"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="366094018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="901646897"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="901646897"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 18:03:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:05:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:05:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 18:05:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 18:05:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+MpVU9K/uD2FzqorFtHE8CluUyhJ1dPH9WN1gzW0RS6zomvgMYON8h+tP9f95RYDn88kFE4rVxs7G+kOKwnuYh3DXgNzvwNBRIolvcAYPOVG1Mr/MmRIA42UQ2YTc3DF57bi/crBlLbU/JWVoBIEYqkWDOzM6jFn2o1tFb3CzTv8ASHaNxOqsKz+Z5usg6er43dEfA+KsRrHMI5jiav5rysSElCc9fIRAiKu70XA8OjcMHgGAWjCgkC/oUXG0JK1ueNWKuu0VLdEYOX2BjZ528FCU/yQA6ty5cIIRvDgzB4N0vhWulRhW7sr9dh4IdkkKEtiFqT2f5pOkldSkqgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EScyrwJUpgkq3ay9VsbXOc4PTk30lHz1boI9KIFsEYw=;
 b=gTL6pwefu7cp90ThCqTGE4+INt5tO4ntXdntAxHRuNw+CLm9c9Gbb+M5EFODZEjCXhwUvCx/z5Ex1ReFyiBezgGi88dKYxBPI4X6IIDLdXOh3OiaRA0Ynz5bjlTuOtyWZfXUexZnHkSqh7U7VVmRyChDyfpYZkHFS6WBriUkZ0mIZAYeX0tL7S7c/vtNHsoaKLObjK6kd3AsiDWuL5fJIlglQHXmBHBXPXi6kt0vFDkvit/YPlQtEIkTaZkZ5n0YUHOkAvWJD5nYdr0DHkU864t9YcQ4n0W4HHzvk5tzfF0MOzCwZ0wl9P6KddFZ3aygNl+l4E68J/rEYkwr+YF2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 01:05:20 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 01:05:20 +0000
Date:   Mon, 23 Oct 2023 09:00:30 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     <liuchang_125125@163.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <mark.tao@bayhubtech.com>,
        <shaper.liu@bayhubtech.com>, <thomas.hu@bayhubtech.com>,
        <chevron.li@bayhubtech.com>, <charl.liu@bayhubtech.com>,
        Charl Liu <liuchang_125125@163.com>
Subject: Re: [PATCH 3/9] scsi: bht: card: Add the source files related to
 card initialization
Message-ID: <202310220339.xnImSaRm-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231013083320.10279-1-liuchang_125125@163.com>
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c7232c-8aaa-42fd-1c0e-08dbd36420cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdhTvs8s/SKx3JhmPgqU5ou6shxIizyD3sWekPKmxiLC2VS6+zap7RekTB2spwkbl8tOA+urFmWw5CX+aqVkEc5n9icq6BeX1CF+Vit0HQ9FIRLDctJLz7MkQQAqhk48KV9oChsEdOvTQsEYkKzgIiQuT+WIRAa/cTyqzxArn4wUpmEvCmarcGhjdLGaJRkypaVOSWYu4ZSUXO2kazDEEG+1JrIwoTb7XDecnjKcga5gnGKw9hSwq4VFSRhCHi0PniVRyWEOks1DauNEKLFWij1RR5py+EYYAA/9q38JtaEB60NcRkfdIzc5uaOFA9Of27MIKB29xRYJD64MAm/HtnVDEjdnuaSUDCqm+jksGZYU0jEnuPnsNb+EC3exqXxL8VR8Oa2YjPsGDLnYrJtQemnSwsmMcC9by8riQP3zZwd6fspUFTx/fGA4fy98NfIlvB2zQI8VTE7YmeVSKfWmHyf9od4HDXcviUDjC6SjyTd/EFAl3DCmQHu6vJ3ovkBly/yHUXyrMb3FggI9Pz9rLAudiEaDeFs5p8oKvSNPOBuGua1RL1h+nrywqteFMRDMh41uuwVEopXXlHml5ArFmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(66556008)(66476007)(6486002)(966005)(316002)(66946007)(478600001)(82960400001)(86362001)(36756003)(2906002)(5660300002)(7416002)(8676002)(4326008)(8936002)(41300700001)(6506007)(6512007)(38100700002)(2616005)(6666004)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmCeKfqzzTIP2vgQAcEYmMS8I9VaGdM49tq3Uev/Tnay62F7WogwCrjVIelU?=
 =?us-ascii?Q?3g2goonglGywlFUUXGystfwiQ70oUyYRsy5g+BYVinbmlrgIki72IJS+9R5c?=
 =?us-ascii?Q?LYZ6IqEpXqS/VO6y0JlBQHTgx6dCrRlG4ZrmuoyJ95Tx22iM1MILlpPqSRG/?=
 =?us-ascii?Q?lc9ClncePTb0siv2PXeztlB+ARy+MzDv3Ut0AzcaS14F2ADbP5ahbNGOLefD?=
 =?us-ascii?Q?GW+2yEaGYjgrssCl+ve0t4JI+dl8R5jdgrdJeJ3M1wHfAzIG3j1SIHrXd7ww?=
 =?us-ascii?Q?lvrH3kGDOyemAvemDALfouKbXPpsYNrHBToAlCwnjdGqkvxRt1ip+4ldsIYi?=
 =?us-ascii?Q?jaOA9vXuKku4uJ7ME2u87Naspqsbf9KD5+b2Pnxm7u7XeBfqyqRXhXKUBJ4A?=
 =?us-ascii?Q?DFgOygJgwUNguoJMywIN5LbxSyZFoeafoK8vkDzW9uksjyH48YVVRlfceJ6n?=
 =?us-ascii?Q?yrPVWXnmeE2JC0vI/jKzDE0lNsJ3/iZZwHpV1vjOIUlsBmcrUn5J6FcTnLfY?=
 =?us-ascii?Q?7Exzh1+Gv3xybZcn6asxDIirtqSbKNM98VVAjrw5b+yW27NejFL28ViFG6MT?=
 =?us-ascii?Q?J5rPP3PAyDXYKhTY601xerfNEtabhi7N665fcIejowXavLlZHhH2QCKhPT86?=
 =?us-ascii?Q?RixiRu2uu5zOk4oFJcvXHlBS1D4c1ewB9Zf/JelRt6VTlHbv2+nFv1fItm81?=
 =?us-ascii?Q?KlYjWfnbCGUi2di4OGytqMzOKjlIxjJHLBxplRXFcKHL9lb6VTk0TihZqP52?=
 =?us-ascii?Q?Gru4eFWouX15LPu8sOo8fV7Esmr6xIRRQUvfHAzwZCnmIL7BW56Cz6lkIbmE?=
 =?us-ascii?Q?yrzQXmr/ZioRaT7PNN6jSgY98uUYwuGjg8usPj4XBP+KsOwaU7U7w+EUmQGf?=
 =?us-ascii?Q?VmBBdf4Gs13ipIjZAL7JO0oqaNZppXWTKK9P39aqn/EdVXXdIaxrvqdmLVUk?=
 =?us-ascii?Q?gdUg6ejJ+ld7LycSPqkUFR3p/787svT6vVHcs4XatFWk+aEOYGe+7W7Yd1I2?=
 =?us-ascii?Q?alQg3bDxI22GFoECdvmPjfAc334W7P0aQkQV2ctC72mWhoYDuH9j4Qn6F2O7?=
 =?us-ascii?Q?iVr7ui3A+jznf9yN+oqvCRZHKpYhmC626vjRgYqZwmG4rUjaJ7KuRox6QAIG?=
 =?us-ascii?Q?DEfYJ0cuww/wKWdlXnzXE2ag3Aqh9VfgJltlPlA85LmMG8w/rCjt9ZMUTuhR?=
 =?us-ascii?Q?LuvuG5nvo3QdaCfXyL3ufvn40Gja5sJFG31ZEUZVEKXFYybPq9eM7Y42yW5g?=
 =?us-ascii?Q?pgakFQWzHhWzUzJ0o6D7yq4k9xZKhQCOV7i0urkDHdZi/crJcr57MU7aQnBi?=
 =?us-ascii?Q?GhnS8QQeVzy/cv0nzRhXH2E3lifho+J9kQ0SkdptnLA55W3ZXz0vw+T6OoUT?=
 =?us-ascii?Q?cSUva8m518wPRhWCzlTaODgPzP52iA/MHFQbkCEDQzMDH4vQIf3MjVrTsJn/?=
 =?us-ascii?Q?Vb12iG0eGTuL+DEum8j6RtEV611MvIcLhh2bwcaDp/8dnwodzqHbFV7G5StT?=
 =?us-ascii?Q?gV7k/Vxp9qff1emLtr52VHsJYeuny6P+DRJNGJ/8oyuaj7l113vhhxJnGq6L?=
 =?us-ascii?Q?Gp9rt+vUjA4bzOQeVb6PMffGZ1q2tSk3HDRYhwUZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c7232c-8aaa-42fd-1c0e-08dbd36420cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 01:05:20.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwVvhnfLpc7WDgaFzVZ5bivu6nqf7nMfMcYHbf0nvz4dl/y6iJAyxREKU8HWv1eRQQyGklB/knzBKBouX9riHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 401644852d0b2a278811de38081be23f74b5bb04]

url:    https://github.com/intel-lab-lkp/linux/commits/liuchang_125125-163-com/scsi-Update-Kconfig-and-Makefile-for-supporting-Bayhub-s-SD-MMC-Card-interface-driver/20231017-123349
base:   401644852d0b2a278811de38081be23f74b5bb04
patch link:    https://lore.kernel.org/r/20231013083320.10279-1-liuchang_125125%40163.com
patch subject: [PATCH 3/9] scsi: bht: card: Add the source files related to card initialization
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310220339.xnImSaRm-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/scsi/bht/card/cardinterface.c: ../include/card.h is included more than once.
>> drivers/scsi/bht/card/cardinterface.c: ../include/cmdhandler.h is included more than once.
--
>> drivers/scsi/bht/card/output_tuning.c: ../include/card.h is included more than once.

vim +23 drivers/scsi/bht/card/cardinterface.c

  > 23	#include "../include/card.h"
    24	#include "../include/cardapi.h"
    25	#include "../include/hostapi.h"
    26	#include "../include/transhapi.h"
    27	#include "../include/hostvenapi.h"
    28	#include "../include/util.h"
    29	#include "../include/debug.h"
  > 30	#include "../include/cmdhandler.h"
    31	#include "../host/hostven.h"
  > 32	#include "../include/card.h"
    33	#include "../host/hostreg.h"
    34	#include "../include/funcapi.h"
    35	#include "../tagqueue/tq_trans_api.h"
  > 36	#include "../include/cmdhandler.h"
    37	#include "cardcommon.h"
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

