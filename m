Return-Path: <linux-kernel+bounces-52525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F60849942
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EE1B22513
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9031AAD3;
	Mon,  5 Feb 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RP1xQOgb"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64181AAB9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134089; cv=fail; b=DeTadKLJbr7KJoR98fhrktkxlQYvnfi2wbnR7yFiBWdc6VAcs4VYt2wc5Qc3BWOQvWBMNJ0TwsvNGmJLjBsA0e9QCAZWREDdDr4ZrQQK513GGqDBgbrGg9icQnH7HRu+gIhe04SS1RSOvzys1vuG2k2K4PTWcJ3z0i7IoEahm/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134089; c=relaxed/simple;
	bh=mcZ5wpwhcAfHdNyXJH4syTlac28qPOmNi2giVuhPN4c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CMLBKR6ZF1wFDQItq+QVG8Lif3+OQYZw0HFHI4U+aco4dQ7NJ/XXriykejo+GXKBz6OL/USjU8Ur6aWjRLnixLFhOlW3U41wazg3G1f1DtkZ2gnvVSneh/WFG9U7g6PjWP0r6RdcVVeC/ibxHdhuxx/VPa1975SBAZasTYRYYpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RP1xQOgb; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707134087; x=1738670087;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=mcZ5wpwhcAfHdNyXJH4syTlac28qPOmNi2giVuhPN4c=;
  b=RP1xQOgbmts695xRl3hCIm3NrUEMggeizFObJ7DfQu79BM7faXWgQEm6
   QxZYRxcuiliCiLatbW0Y70VNTYvYe5jZOZfkbDgLSv+5KstpgMWYnGfAH
   kkjMXp0h4INtov4JrwAc0iwaYwC9dxFttcYCn/pvb2HnmC4lOqlCLwS6w
   iLF52cNOSutCKKujUviFeZyduAcvUQ3oU7AMHwB03ZXqYYgj+5hgbDWrM
   NkKmVLvMVLn92BLpBaDsTuGe6a2Tx1L/HdGBJoqW+pjt/DCMt7ViFzGf7
   65/QeSfrLeWC/hqUg2hN5qf8yLXQtGjSDAR5Xiv9qWUJe1d5IRvVZf/oJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="394927921"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="394927921"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 03:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="697408"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 03:54:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 03:54:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 03:54:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 03:54:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl83nBhgV9y8LqpTVuXbqe33UG6O/rSom1pBwcm6Li+m+GjWuSD47gm41IShlyZLc0KXvkjQKWeSzqJfx8KgUf8g1UXxMdooSZ3MVjaSUhPzJmPCELqnF2wuyNxIQ/vmbrESZOc1i6cx5pfy5rLJzEMYp9vzwxbaoKLBtkGd+utyjRau5Xc2kj/+y1klQvzB1g2o0jfwIXS7bI3NjBzfHqRrCPRFkv8KAS5cffEmYgW6aiihdpUOf8oBsxlf05nAYGq5DcFYHBMpHGwCjUndOe/3qZRrRvOSrqkLgcwECuqSWFLx/1oJa8FSeGtZjM053kzTN9mLRUTrixAnlTt6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW485TgYJBY2OfZ8tmp7iwICYVu77Hie1AkvyNQa0kg=;
 b=eoFYuvTcRXAXbrNK/W7inzIrM5m4Tl1JCroVrv/4M/di4zWkiBRuY4rIxk8+jOCQLBwaFqbzlx3NEtZ27Ba3jAdROpXhiItlU+ujF3YP6u3i4CGXQ60/OdR7K16dsyJlaiYL6htcqtsQ8tHMtUOlqv+ClMXB/uT6MhRcR5yv7hm7wFrPjSsBqR6kFRZ8oFiF7DPUDXX2fg4YJgfblw7q9ue2ENXTJRwiS6/0bprSeV585nI5+4+psgwph9qnGVnNUBB7ccROHJOj/P6/DuyBQuCaJTABvy4N8p5bqMSGU76ticuPD5vVkQSMTbA5htOKCYhG2gRwVhXk8JRf35pPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 11:54:44 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 11:54:43 +0000
Date: Mon, 5 Feb 2024 19:54:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Francois
 Dugast" <francois.dugast@intel.com>
Subject: drivers/gpu/drm/i915/display/intel_display_debugfs.c:1091:6: error:
 redefinition of 'intel_display_debugfs_register'
Message-ID: <ZcDMe4sBDUIO+U1K@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SJ0PR11MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7829d6-06fa-4788-d4f4-08dc26413e06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mA18Vpr0DYYFkO9rgDitGFy/OqV5cvgRmWQ112euJ1/PbcL47xEtXWNPMDQIi5BGHEmX83DagiNqSG3k/51boOTI86pu/ncjdZsZ+Ov4qlOHsPlyH9zYeE1Yx48lR7OfBWMS1OI/QkAZMkxC5PxPygvNYvFYOf1I+3k/TZpa1xFjIRNsYK3Q/0BqECxk2tRi+LLLJ+r5KJyTMsoElG9EBIGfFSpHUaegUjWXwyigtOgGtz7T6bNXfwm3h1Et/UDEPaKZeZPcRgJDnDR5P1TplQJJQj1pqxqq7G6nsuRoUin/VXymVfXSkRSoXQC//cfjRfCOOCVG9UkmAnIL0rEcQBm1oKQEjGjxXFf83wFE1Sr6KkCScUWfCIBhLD0FYk5xXP2OjmZM4ZBcDlZgu0JRxr1vmqmxDzz5CpZjSOOu69kLxkATN5xYwSnRQ99/Xjacb22qBaak2NuFSHkatcpo79+V2kXfptpKcJDwaEesydY61qWGfjbvOoElgahkxRRj7CsU1BSoKYGASjYNiFsHQRhS3xBinnMUugXi0Q5NHtu+/dn6JsRNntKSdBRZ2NrTVRwgEX2qpHWm3PEzFsA7VMhmsA8A4pgGifxqrT57882jAzZavDdiEQQmIs/uJQunzIBLmnHVNaOdOMu0tBHcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(39860400002)(376002)(136003)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(33716001)(41300700001)(82960400001)(4001150100001)(2906002)(30864003)(83380400001)(6506007)(6666004)(66574015)(26005)(38100700002)(9686003)(6512007)(66946007)(66476007)(966005)(54906003)(316002)(66556008)(478600001)(6636002)(6486002)(86362001)(8676002)(4326008)(5660300002)(8936002)(6862004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ryfy1uULZR3SZjDRhIbBmpJRDJw8ftgDEDGBOxeyOOuMbP/H52SulsP3ug?=
 =?iso-8859-1?Q?zBdYKSL7tb2ayoRpKqV3hF/ek6Nwf1q0Q1et0fyT+mWx5pSsHRkNU17fU8?=
 =?iso-8859-1?Q?K6Cdu+QBdzPZI4uA6LqGxJcWahbyV5fPqEYjFSN6Ki+oNnoDKdp+gKoLoL?=
 =?iso-8859-1?Q?kd4sEg1DDztF/rSGX8iG0YHMh+tm/SiBj17+484ldVLRqiKVmdQB/jBFHq?=
 =?iso-8859-1?Q?JNkX+EmZhl1cV4ppjg2d39D49YpaEwkcoR1XjTniB3l+qsSE+e3CKLNAAj?=
 =?iso-8859-1?Q?/vVTdiYwHjPnqYHlbQ3UMix4yj+AqkAULkSBQZ31UhY5t1cmU8czSR5RiN?=
 =?iso-8859-1?Q?PIQ5UJxhC7hSVs2iyWpIhLYo62jisqVxjZaH+TVdi1sQeBXjHN3Ndm5omC?=
 =?iso-8859-1?Q?4hOq0/a98OR+isRsrlumZ52ex+lBUBIQ20SH+Zg5ikhQvs5DbdrO5lzvYM?=
 =?iso-8859-1?Q?dighsyXIRFU2aYIXYN8Wtxrc9PGPr+BCaM4C2eFG0Q6XSguTJQmy03jW61?=
 =?iso-8859-1?Q?hgcey0/UdhXE8oIzEF+Zj+W/1rmIc6A2fvQgHBBElljafTnk/Pk9mnk2gX?=
 =?iso-8859-1?Q?5rQiNbKie3l8A8ByRfiUhjYN4e+n3zV1SywYmbbJkgj7Spe6ISLv4Q9J8p?=
 =?iso-8859-1?Q?M75HO9O6/+yz7nw4JF6WCc4yZqyA0MN45LKzTiKbc9XuGUxv0Xf6LVg2Xn?=
 =?iso-8859-1?Q?VbFdPkX9ZjzoErpiAaSDqNE7iNOZlJG0YUaBugasE0N6zUou6a1O6JUkI/?=
 =?iso-8859-1?Q?+CwHbacyASQDLelkRDlRWrOkfVWilOBm7R+PtX9ROHZvdtgH6cmOzmXUkF?=
 =?iso-8859-1?Q?hr9d7J4d/CmxwOKlIDuYN/Dns4BRcQhMczQBplhTIDl/r7Q7VY31W5doCM?=
 =?iso-8859-1?Q?SwNS8tIpRMm+EnYJQ/jcr9IevDTIHUAdJoi1WwPPZDKuFl9D0/RN72Mi3N?=
 =?iso-8859-1?Q?CSeDuXgmlDOzy1rRWuYwq/09yTLwCni8STabf5zwPY5XB7m+Oe90wW6YLf?=
 =?iso-8859-1?Q?ApTu/n6mreXM/uEc7kgrtgp67ib0JO8mkNbX4O3hLMZFog3VY/ClAJLH2M?=
 =?iso-8859-1?Q?GTQ78ZdlhZdrKz15sg+7cm1g7j5mnQgDB+xNQV9caHbQ2meZsRuslhYJrX?=
 =?iso-8859-1?Q?HEm3Ei0NcfSu06md/X8m+VBgx6L+H8esIMyjQ+ObnbuPd3fVf9hNMtMt7f?=
 =?iso-8859-1?Q?RGLctQ0zqx4fYXDZghUuY7lkz0NZCjWgZcPwFNA81p7TAe+7dqgKIsJgwt?=
 =?iso-8859-1?Q?O9/rzO79t5/cVAfsEoE78xo/fJgnLEm9ArInz7zGBjdvJJiS2xut/OMsAN?=
 =?iso-8859-1?Q?q/Op1n4FleekZM2uFvTNegsbjjsFHSodgU1j8fmEXn/IbWwSVdiwbLVjtE?=
 =?iso-8859-1?Q?kKhe9IYNhXd+XVCaevZJhTB4aVP7MTLEtGYYqk/3OL3XWgj+EwKFup/DV0?=
 =?iso-8859-1?Q?gJIjlcvAMkS1rf9lGcHISbFP0PX8hE8upYTArPwjc2MYSuDcueFq9Gyx8A?=
 =?iso-8859-1?Q?b5j9XFToaJf3UW7ZlT18ZIwYWeJUlbAHwILtuvBNiF28iW/oM2tq0jjmWA?=
 =?iso-8859-1?Q?Xv4KrmX2VV218wP7AkGM2s9Kk8V3hggR7Y3/YKCOMLYXk8VPf9DGQ6I6c0?=
 =?iso-8859-1?Q?3mJ3cYkX1wWiOwrcKVClgb7CSa9pqhddT8f2WPK5QlPHaMTYPCfQc3OQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7829d6-06fa-4788-d4f4-08dc26413e06
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:54:43.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eV9w+8XO0AXVRw3YqcQwvtT/3YRtp3OFPHaEtRKcEW05kqNfiPjiB8G1tJJFN7gToAG0F2Ue71fAny+MsRct9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a6526c4f389bb741e511be11721b3d1cbf1034a
commit: bf3ff145df184698a8a80b33265064638572366f drm/xe: display support should not depend on EXPERT
date:   2 weeks ago
config: alpha-randconfig-r053-20240130 (https://download.01.org/0day-ci/archive/20240131/202401311018.P0Sq7A8X-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311018.P0Sq7A8X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202401311018.P0Sq7A8X-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_display_debugfs.c:1091:6: error: redefinition of 'intel_display_debugfs_register'
    1091 | void intel_display_debugfs_register(struct drm_i915_private *i915)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/i915/display/intel_display_debugfs.c:19:
   drivers/gpu/drm/i915/display/intel_display_debugfs.h:18:20: note: previous definition of 'intel_display_debugfs_register' with type 'void(struct xe_device *)'
      18 | static inline void intel_display_debugfs_register(struct drm_i915_private *i915) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_display_debugfs.c:1571:6: error: redefinition of 'intel_connector_debugfs_add'
    1571 | void intel_connector_debugfs_add(struct intel_connector *connector)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_debugfs.h:19:20: note: previous definition of 'intel_connector_debugfs_add' with type 'void(struct intel_connector *)'
      19 | static inline void intel_connector_debugfs_add(struct intel_connector *connector) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_display_debugfs.c:1626:6: error: redefinition of 'intel_crtc_debugfs_add'
    1626 | void intel_crtc_debugfs_add(struct intel_crtc *crtc)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_display_debugfs.h:20:20: note: previous definition of 'intel_crtc_debugfs_add' with type 'void(struct intel_crtc *)'
      20 | static inline void intel_crtc_debugfs_add(struct intel_crtc *crtc) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:437:6: error: redefinition of 'intel_crtc_crc_init'
     437 | void intel_crtc_crc_init(struct intel_crtc *crtc)
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/i915/display/intel_pipe_crc.c:36:
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:25:20: note: previous definition of 'intel_crtc_crc_init' with type 'void(struct intel_crtc *)'
      25 | static inline void intel_crtc_crc_init(struct intel_crtc *crtc) {}
         |                    ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c: In function 'intel_crtc_crc_init':
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:439:48: error: 'struct intel_crtc' has no member named 'pipe_crc'
     439 |         struct intel_pipe_crc *pipe_crc = &crtc->pipe_crc;
         |                                                ^~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/alpha/include/asm/rwonce.h:33,
                    from include/linux/compiler.h:251,
                    from include/linux/ctype.h:5,
                    from drivers/gpu/drm/i915/display/intel_pipe_crc.c:27:
   drivers/gpu/drm/i915/display/intel_pipe_crc.c: At top level:
   include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
       8 | #define NULL ((void *)0)
         |                ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:28:36: note: in expansion of macro 'NULL'
      28 | #define intel_crtc_get_crc_sources NULL
         |                                    ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:549:20: note: in expansion of macro 'intel_crtc_get_crc_sources'
     549 | const char *const *intel_crtc_get_crc_sources(struct drm_crtc *crtc,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:8:23: error: expected ')' before numeric constant
       8 | #define NULL ((void *)0)
         |                       ^
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:28:36: note: in expansion of macro 'NULL'
      28 | #define intel_crtc_get_crc_sources NULL
         |                                    ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:549:20: note: in expansion of macro 'intel_crtc_get_crc_sources'
     549 | const char *const *intel_crtc_get_crc_sources(struct drm_crtc *crtc,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
       8 | #define NULL ((void *)0)
         |                ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:27:38: note: in expansion of macro 'NULL'
      27 | #define intel_crtc_verify_crc_source NULL
         |                                      ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:556:5: note: in expansion of macro 'intel_crtc_verify_crc_source'
     556 | int intel_crtc_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:8:23: error: expected ')' before numeric constant
       8 | #define NULL ((void *)0)
         |                       ^
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:27:38: note: in expansion of macro 'NULL'
      27 | #define intel_crtc_verify_crc_source NULL
         |                                      ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:556:5: note: in expansion of macro 'intel_crtc_verify_crc_source'
     556 | int intel_crtc_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
       8 | #define NULL ((void *)0)
         |                ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:26:35: note: in expansion of macro 'NULL'
      26 | #define intel_crtc_set_crc_source NULL
         |                                   ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:576:5: note: in expansion of macro 'intel_crtc_set_crc_source'
     576 | int intel_crtc_set_crc_source(struct drm_crtc *_crtc, const char *source_name)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:8:23: error: expected ')' before numeric constant
       8 | #define NULL ((void *)0)
         |                       ^
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:26:35: note: in expansion of macro 'NULL'
      26 | #define intel_crtc_set_crc_source NULL
         |                                   ^~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:576:5: note: in expansion of macro 'intel_crtc_set_crc_source'
     576 | int intel_crtc_set_crc_source(struct drm_crtc *_crtc, const char *source_name)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:630:6: error: redefinition of 'intel_crtc_enable_pipe_crc'
     630 | void intel_crtc_enable_pipe_crc(struct intel_crtc *crtc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:33:20: note: previous definition of 'intel_crtc_enable_pipe_crc' with type 'void(struct intel_crtc *)'
      33 | static inline void intel_crtc_enable_pipe_crc(struct intel_crtc *crtc)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c: In function 'intel_crtc_enable_pipe_crc':
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:633:48: error: 'struct intel_crtc' has no member named 'pipe_crc'
     633 |         struct intel_pipe_crc *pipe_crc = &crtc->pipe_crc;
         |                                                ^~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c: At top level:
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:650:6: error: redefinition of 'intel_crtc_disable_pipe_crc'
     650 | void intel_crtc_disable_pipe_crc(struct intel_crtc *crtc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.h:29:20: note: previous definition of 'intel_crtc_disable_pipe_crc' with type 'void(struct intel_crtc *)'
      29 | static inline void intel_crtc_disable_pipe_crc(struct intel_crtc *crtc)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c: In function 'intel_crtc_disable_pipe_crc':
   drivers/gpu/drm/i915/display/intel_pipe_crc.c:653:48: error: 'struct intel_crtc' has no member named 'pipe_crc'
     653 |         struct intel_pipe_crc *pipe_crc = &crtc->pipe_crc;
         |                                                ^~
   drivers/gpu/drm/i915/display/intel_pipe_crc.c: At top level:
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:532:1: warning: 'intel_is_valid_crc_source' defined but not used [-Wunused-function]
     532 | intel_is_valid_crc_source(struct drm_i915_private *dev_priv,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:420:1: warning: 'display_crc_ctl_parse_source' defined but not used [-Wunused-function]
     420 | display_crc_ctl_parse_source(const char *buf, enum intel_pipe_crc_source *s)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:279:1: warning: 'intel_crtc_crc_setup_workarounds' defined but not used [-Wunused-function]
     279 | intel_crtc_crc_setup_workarounds(struct intel_crtc *crtc, bool enable)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:229:13: warning: 'vlv_undo_pipe_scramble_reset' defined but not used [-Wunused-function]
     229 | static void vlv_undo_pipe_scramble_reset(struct drm_i915_private *dev_priv,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
   Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
   Selected by [m]:
   - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM_XE [=m] && DRM_XE [=m]=m


vim +/intel_display_debugfs_register +1091 drivers/gpu/drm/i915/display/intel_display_debugfs.c

926b005cd8c4e3 Jani Nikula        2020-02-11  1090  
f06b2052f74d7b Wambui Karuga      2020-03-10 @1091  void intel_display_debugfs_register(struct drm_i915_private *i915)
926b005cd8c4e3 Jani Nikula        2020-02-11  1092  {
926b005cd8c4e3 Jani Nikula        2020-02-11  1093  	struct drm_minor *minor = i915->drm.primary;
926b005cd8c4e3 Jani Nikula        2020-02-11  1094  	int i;
926b005cd8c4e3 Jani Nikula        2020-02-11  1095  
926b005cd8c4e3 Jani Nikula        2020-02-11  1096  	for (i = 0; i < ARRAY_SIZE(intel_display_debugfs_files); i++) {
926b005cd8c4e3 Jani Nikula        2020-02-11  1097  		debugfs_create_file(intel_display_debugfs_files[i].name,
f270b7087dc836 Jani Nikula        2023-12-05  1098  				    0644,
926b005cd8c4e3 Jani Nikula        2020-02-11  1099  				    minor->debugfs_root,
926b005cd8c4e3 Jani Nikula        2020-02-11  1100  				    to_i915(minor->dev),
926b005cd8c4e3 Jani Nikula        2020-02-11  1101  				    intel_display_debugfs_files[i].fops);
926b005cd8c4e3 Jani Nikula        2020-02-11  1102  	}
926b005cd8c4e3 Jani Nikula        2020-02-11  1103  
f06b2052f74d7b Wambui Karuga      2020-03-10  1104  	drm_debugfs_create_files(intel_display_debugfs_list,
926b005cd8c4e3 Jani Nikula        2020-02-11  1105  				 ARRAY_SIZE(intel_display_debugfs_list),
926b005cd8c4e3 Jani Nikula        2020-02-11  1106  				 minor->debugfs_root, minor);
d2de8ccfb29909 Ville Syrjälä      2021-11-24  1107  
d7c281eecec069 Bhanuprakash Modem 2023-04-13  1108  	intel_cdclk_debugfs_register(i915);
f0147745f78685 Jani Nikula        2022-03-21  1109  	intel_dmc_debugfs_register(i915);
d2de8ccfb29909 Ville Syrjälä      2021-11-24  1110  	intel_fbc_debugfs_register(i915);
1bed8b07342069 Jani Nikula        2022-09-16  1111  	intel_hpd_debugfs_register(i915);
5cc0de45674971 Jani Nikula        2023-03-17  1112  	intel_psr_debugfs_register(i915);
f22c982ef4152f Jani Nikula        2023-02-15  1113  	intel_wm_debugfs_register(i915);
8015bee0bfec69 Jouni Högander     2023-10-24  1114  	intel_display_debugfs_params(i915);
926b005cd8c4e3 Jani Nikula        2020-02-11  1115  }
926b005cd8c4e3 Jani Nikula        2020-02-11  1116  

:::::: The code at line 1091 was first introduced by commit
:::::: f06b2052f74d7b42ff8cbfe1ac0b78be7668c37d drm/i915: have *_debugfs_init() functions return void.

:::::: TO: Wambui Karuga <wambui.karugax@gmail.com>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


