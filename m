Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4CA7DA2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbjJ0VyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0VyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:54:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7470F1A1;
        Fri, 27 Oct 2023 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698443658; x=1729979658;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u8wS7pT0zKIiptR7T46/gR6VAt+40UPB3Hgh1vwwmg8=;
  b=dJ2UNVuPi7LJDZsmqUmxPUCbU81/kx0nkfwqe4i+NhFrltkd5qdGvTux
   yZKYpPz5n+PBJGknLxABvEf/tZ3VmlTB1lvI/gmLlZUwEOEHbaA17HJg1
   52ogXGR4CxpZlYk6145BXKstXU/y5bnD8DnUH6Q3y1eUgQnTXgtA32C0d
   NApJrwUqOslFYFWDMfUGaSe7K3Gp5jaQ0Vvsay6m+i/zD63VzFwKLAqzl
   YoVYEOac3wuTGik4B3gxsqxcTMo8gPdyTrz3eSHot+qoWoCrQjofZebt8
   kwBzTkiSYQu42fLTfnxyFjqj9VMCahCV7iRfXUC4O29JTzKM4+1okB+2t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="651353"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="651353"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="919249"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 14:53:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 14:54:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 14:54:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 14:54:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 14:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0nZgrpvkSSiSXKztTP+scrUmUMgayjuVNrjKGXvFPMnW60dGTaJdffiwvBie16FNB0FJXqWt4Q3SKJDYgl63HEoQnHLTm+bxTB+I8RvrOZPeK7yxAGj9fxHQlf6cHGFiv2R2Drdz8qCCUZwFDX1+5uw3rC4NN+KVJvCEZjj1Zp4N6AtVxveVfqofhpEuHL8cWnWohk6SrP/IRF6LMB/KK/Wapp/WC4+/eMY4qR5zNEAqWpNcUxCXHY/S8209t5D1njrNih4HyghpYeEWEv5qFYQFgNgICfoO0rKMLEqJPQsjkuNu2rbunhcXseb+WAsgFEi+LtnVUP0FGeK4tQcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N542SKp+E45FWDF88i3a/TloGeGWRgXvtILKOT2Mu4U=;
 b=jRWPZ3xJYqKx5/+iwq9OUDTR6fWa9vkEtUUdmUhf3oB7R9IlohymA9S36mpKNksGoRsvC2xHnrXaQ98s8jJ/30/rB+Pk4dArAg6JpUXTzHKWA53G0miwgOdqPdYUkiq0XB4Ahc7ltRSNOlHGKszpGhp6lUf5ezZoapJjlhke+v5dkwOq9XYNK4IssDGyOLwS437ko3GqvKj4h9Yp+fj5sju5FyBJGV6VMPoMWHbXvtR1J7FL4SUM5EZq3EB1Pg9ak/5iAYfzUNMNxZyAyT6MD+t6+hlLhB1i57JY7lULIMjA3/ieb2VF9AIP56oI8xOBrqWuWRpELW0wqDfdHzVkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 21:54:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 21:54:13 +0000
Date:   Fri, 27 Oct 2023 14:54:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 08/20] cxl/pci: Remove Component Register base
 address from struct cxl_dev_state
Message-ID: <653c3182d5351_244c8f2943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-9-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018171713.1883517-9-rrichter@amd.com>
X-ClientProxiedBy: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ade797-f479-4abf-5d9b-08dbd737421f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqqiH677t092agPXyz28YTTjDIZ7h5ce5AH2UqEd5Vl0wlSdLB0osCFDYerRPavuaWehaIud6fnSSgKl3g351dYj9DU9SPhmN2+vUB4nqVkYDP4FLr7kYsA3ySasr7AEM7UbZ4+dNIMtoimRAkAIZINUESI7Cqiplz6xbVjlMkrhbQTs+0QY7bAW1cKKwjan4J3c6/Oo2yk5ABCtf84GoUTzB2IJplvWqgLnHsZd7MT06Xfg12UQAZz07fxYFbQvCc5/V+5UDl8lAZXL1N/KIl+JcCZfMzhBt79vz5ruu/KABaX2/6dWPYntPGSMtsGP4SgKNOKGALR7Rw9LT3na5XJmQ94v2CX4zs6iUv2Ec4/pease+v7bbriVQnu3LrAI+xv+Lj1N+Ax3eYEPYuUP+UASpaOIt8DKgWHEKWy/Aa6CvfxeCnn+mGufUFgYybCcXHphdcIFg2EUynCVILzV7EOwsV74mQefzvPmgEQO90csPIdBPwkRPM3+Rj/F0s2vqkjR7lhUqthjb0+JIEYz49CjgY/k8IUwCHAWBLAUBCy0SwLsuPTy4y3cEaAmXAKm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4744005)(4326008)(8936002)(8676002)(66476007)(110136005)(41300700001)(54906003)(66556008)(66946007)(2906002)(6486002)(478600001)(5660300002)(316002)(6506007)(26005)(86362001)(9686003)(82960400001)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QaW3oBIE/qH8rbs7fDdzwpQT2Ll6aEDEgFZesrB1VYamgRtgaeDRBAdI6esB?=
 =?us-ascii?Q?CwJe+QNXdZIV7t7tofW6Vcc4X9pqDv4chNeu5tOCoXQMfXMAoDAZxTGbotLs?=
 =?us-ascii?Q?JwrgE5Y4t3mJa9H8+hBsbYt3lFqgXWam0k3dbNV49iRS2HQSEa02DI9UN33N?=
 =?us-ascii?Q?E56P+HDno7rSHAnPrUxiAf66QSB5M5zBIZWgM0/BpohR1Z79+aSK8s1sSBBs?=
 =?us-ascii?Q?1Iu8h4G6zDM5TBwG+ZDLjPoU4e+Kf4xYzXwisRTuM4MRMcqULOQoIzbHpWei?=
 =?us-ascii?Q?eh5ZFmfJALfgKqdxqzF0/D8IqQmvgQR7Q2MrpL4hYmoNDWT1r76bWYiBVuBo?=
 =?us-ascii?Q?cUInyLisSL6FbvIwkuOBoDmUfgtWbdiXwUwIdDqVehD+Voino7wA1H7w1lOo?=
 =?us-ascii?Q?vNeyeHvL/+W1kJSyf2t8u1kzgdX1iFjcUiZBBffb+wjvxnPR922KEKUZuG4/?=
 =?us-ascii?Q?8FvaQ0EKZr8X2yrKmVjdbirWTD0xh4QgbN0FLeX/CeD1IgAranaLZVavYc0X?=
 =?us-ascii?Q?tja1HrivqdLFWrraHcYHD7f2TC3YP98ENWCr+li4I0bGpcsNoEWVe7Az4mbp?=
 =?us-ascii?Q?j8nUKhiBL2FyH1txnjqWA0ybNO1UmlCeW5v9O+Dr+cKM58kdtNDq18NvA/BK?=
 =?us-ascii?Q?aI/ID8PQ7PfyvJI5ywHt74xggKj7vvabeqCuG8HHNpyn3l0U7Jy5HDJmP4jW?=
 =?us-ascii?Q?BS5qA9j4v7c37RogBmwF0LDvtCAVIlFrTdI3fTxKM3DoOYSiIU+kud1U6cyB?=
 =?us-ascii?Q?b2nhxJBb7DIfZk7iPROyajxeJ4A/GQLeX2jEKfDQG1VraxbVGSAazjRvmN7p?=
 =?us-ascii?Q?/maqT96urrkVh8/8BfD7aJhi7To8IyqimC+/so+J8/CJ0UJEtVHNzKHWH1ex?=
 =?us-ascii?Q?ke6oM16/jCo9xzqpKPcF1zKCzagBZlb4+pb05SPvyBM0KU6GCRbEl25wR6h8?=
 =?us-ascii?Q?7BRz6NGauZZYZEHqm+649swE0h5di/xfxJBE2T2K6czLzqaCQJ8dxdzrqE3g?=
 =?us-ascii?Q?w3Zvu8IJQLd/Rsc3lZ6CjoQ/XQ5XaafBMD+Ig0+hiaCe/PJkWjljjbCyoLbx?=
 =?us-ascii?Q?gCrZq939DnAv4JjawVqQYRpo8eUfKsCrfWAHQXYGbCrbz3lLVU/CJmGJtfog?=
 =?us-ascii?Q?sUB75ModsjjH69WWx8TrJOsGEiBoRrPvGKk3r4xVID4nAqdKjUAxuJEcA+rl?=
 =?us-ascii?Q?uid//E48wW5a18AwBrAYHLlq/vIKkIWJmTwqTFmuRMX7wweSixwGqefmSY2m?=
 =?us-ascii?Q?RBQhEIP0COlEK1pluCqCgo7syjHw+QIHaUjZO4GgskrjDuJBtU7Yt/nQbnjk?=
 =?us-ascii?Q?oqDbyzxwxx8xXplVJEG3g0zZ866O1LuYKBimqcgKnqKX+kvkIxWr4XxtAJDe?=
 =?us-ascii?Q?Agh/h/7sEOpyi31tTkbpAM6nm0/YJ7JzsOBRWJOOHdFbumRYKSaiktU2Jruj?=
 =?us-ascii?Q?ABHWxxLzklzNenOhSbs0Q3+/uaurqzw/bhouQ8vmoh1LL9uRMwHg8xaoe0UR?=
 =?us-ascii?Q?g45OUKZWPDYSoMt5kSToJkCZKejvsFGRRZ3FraALi/ONFAruOTWsl7SrGjmO?=
 =?us-ascii?Q?s5D+OJfRN9ubiM73CCLXyIzycq2S5yaIEZCfy8qif9r1Y3QCizSDnKSgg8gJ?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ade797-f479-4abf-5d9b-08dbd737421f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 21:54:13.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugHOPJg/kXM9Wg1OOk3o7LBbYjyLweQ6rSVGMAWWniC6OLD5Do56hGgMb/3is9dl7bV7qDB73nujtU8Pm4c7aphq6HvauR9+ib/Q5ixIbTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @reg_map instead. Remove the base address.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[..]
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 464fc39ed277..aa44d111fd28 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1423,7 +1423,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	cxlds->serial = pdev->id;
>  	if (is_rcd(pdev)) {
>  		cxlds->rcd = true;
> -		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
>  	}

I cleaned up those stray brackets after this second statement removed.
