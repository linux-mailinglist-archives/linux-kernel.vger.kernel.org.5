Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213627CCF15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJQVUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:20:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBBCED;
        Tue, 17 Oct 2023 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697577601; x=1729113601;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wSJJFJPJTZEdMP7h1QmeXwlo5wkErIDqugAdEkCrHwY=;
  b=KRZNocBalp/E51B/rXdeOhryGZWLAtbRUnytzONj4I0G4SxKYmhGkQFI
   DqtXGG+qlHizE/3UMO/T+2K/IuB6fWR2QATwnPDbw9mFLSGNGGKbcHLKS
   Ja1DUD04sNIWXgdsxeoVc4lpzpAKDsGBkVWVFk3uL6wxK/Um/s/iD8VpG
   AMGHYqfx3iMhmSFjDoitR9tujhZTKo0wIjHU46Y9OC/keUloKNImeY9k9
   FRArMQkERBkNQ6Kdw0vB4JMWMNYKCCzvY1G+2QoTL+RwP4O1OfO7fA/ay
   owmBBzm6UkggCSxnv2WDt1L/d0XhRf5Nkx9eaDq2NDserb8gLIIxqbRXW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385717422"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="385717422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4247626"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 14:20:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 14:20:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 14:19:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 14:19:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 14:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhfy4EqUZQo8RWIEZCOGBU5jBUgAWFOqdKZ44PGOli6XIHnEU/rLtAJ9PHYA9aHh/RaONmq0SyDeZMYuupfUueTAPpWb4VPtW6ANzQSVdyQVXPUTZnp0R1aR+FL3EcBnC3oeCvrTvg5l9RuXuvmTK4lo3nsJJA9cTzQyVKzpuFqywr5aZSYe3cS9Ff4C9EwGhCVd1CFmnvwgvwzaJ2b8mP7eC9mBTTHX/7uHZlTyab83nopdFNf67cXWHE9h5qcGLOhRRrgt2NAxuOCdyUEiUD4PdEIhvEXCE3FeEqU5XheWkaEdsjhTMawlEaacASz53MsQgf5an+yv0hK8TA1FYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBzK1s+MAOEQnLAfj54wrctXy1STvCj1IHE71Wkvbpk=;
 b=DeppIGCbQvdM6xmSG+SUbVDcRbMGke8RH3BXznWsy7tauta3V2B+H6FZSk6Lwmp8+YDfCYAvAx3kL3rgyHe24H+md0G5KV4VmamtVRIDf2seMsARgjudnmDJDZhwRcU7FueT2ol+/lOVWIwvkyjqs/CN9prO3jwAiqtwYKrXfbgh3xiCulXKmoURe1wmAe2ZaWonJaAzEVq6CyWneZAVzRafzUv5IZ7FTQer4l9xNQDEq065LEIzw9gqhDBiW0EWYkpQUQBzxnatrjbT3somxOyjHf92XWkjBANj3EBkErJKDu/QAfK6Ehvi2hhe7MJZrWVQs7ybfDeVv/6EQHkoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by SN7PR11MB7491.namprd11.prod.outlook.com (2603:10b6:806:349::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 21:19:53 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 21:19:53 +0000
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cw00.choi@samsung.com>, <kyungmin.park@samsung.com>,
        <myungjoo.ham@samsung.com>, <digetx@gmail.com>,
        <viresh.kumar@linaro.org>
CC:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [RFC PATCH] PM / devfreq: introduce multiple devfreq devices per parent device
Date:   Tue, 17 Oct 2023 17:19:44 -0400
Message-ID: <20231017211944.192978-1-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|SN7PR11MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d918da3-bc38-40eb-6a09-08dbcf56cdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDtmn4m+KL6zuVSjY3wr5YSiCgxVgB3LspjDUw5pFjoZExPVLrCfzY2ZtfHitocmnbw9ZY9kWZMujjKlLyrb9NeuirVqxsbmTjutG+PjS9XYJ0PktWtdnLY1s5mVSSZ3X3qwSEjlAkE9Lgiaw4yzP/I0pvkXKqTq3RkGgag6X2OTBrrumkJkkvXGSfTwqKRWsBvZBD4LVGKk2Q/ZqJkakCt1QBUiMkj7pPa3rE2Hda1wMbeqwHIv78OsJkeBqo23dUqm+D1dtd3sSLHowQly0sTXGtndMLh1PvnE5QmhfBnlMVNONV5tl9oGyPLcgn1Z6qlwVsG24pQVUET3JiGAuggzgW7Jx01DfZNA4aXoWFAOgEGhQHAuZglFZW3abYMlhLhIXsoAoI/VjnebuuVFuX3OXHUHFc4oQ1+ccWAZDvMjRLckOP3NBENSodgh1MTOoFjjAAFg4/akM6cY1dCezaKKJlG+cmwuwnTWUBeRtp1KjcNjR1WFG7OuLdFwSnlHdud/pns8DA29iO5dLmyA7i0Pm6ac33FvYJ128e9jN/IRqRADGFH/eDQHsiiLiOKO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(41300700001)(66476007)(66556008)(6666004)(478600001)(66946007)(6486002)(6506007)(1076003)(107886003)(26005)(6512007)(316002)(2616005)(5660300002)(4326008)(8676002)(8936002)(2906002)(44832011)(36756003)(38100700002)(83380400001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LYJjWuQ4VP0ZPGJy7ryKkS2RPzFHZSdHTz+VZygT7tsPEXi331A7dRD93Zo?=
 =?us-ascii?Q?0LacpTxjEi9pArxM4pQXmIyKZa6ea8IpT1TwV0g+A9ynJgVI6Wk1xF4Zs/vK?=
 =?us-ascii?Q?sRAlKpyIBmKAggRerEoxhU2Oo5BxopJrlnBAwJpK4x61iswZSTbrubQoJku6?=
 =?us-ascii?Q?WMQE5oOAGNyhtIaCJ9YcKf9OwprIwbVDvNg9lI/7oKvNkSBUFpzm22q54xyB?=
 =?us-ascii?Q?0EECbgHr0bll3RsiJyRyA6bl9n9hYf3TqLIw1mgKRfHj3sJpXjgTZcd0ULAW?=
 =?us-ascii?Q?xnoh0yfQxZoOCs8JI3PzZdNweDrsfosVYqxuzyYwRjgOxbvernxMdzxmYvY9?=
 =?us-ascii?Q?qYMFpyhquFPx9cXh2zCA18D9sLkOoAJfmfu/7//M4eCbJiylHyLBvLId+1hw?=
 =?us-ascii?Q?MrP9t11xsNyFkoTSVqFLKKMrsOYH7jV/uVzV4fyT+cUDtP/RRy70P8+w7J6T?=
 =?us-ascii?Q?UmnJGHmeXdBh8W4YGNb5ZRAzX7g5sh/g/4d/N70bAg6xYZAcjnSD2q4ftLHj?=
 =?us-ascii?Q?nLFWCd8oVu7K5oHJd13fjM9mIzq4wOdm4uO22MLQiKbW7mHNaF4DdWdAfK0Q?=
 =?us-ascii?Q?/qdkwHSIBz4Uug5OZkmg2JRE38EZ10Nr8wCVnHV8S8tQVX5LgZJKq7t35c0Q?=
 =?us-ascii?Q?JpuNI0k+d/HO1H5AszTZk8tf5sRuWoGfcw9c1YcIXU1dbQyLKZs8fs8B/mhF?=
 =?us-ascii?Q?H+bygUhHQYWzbxoeVxD48NICXoa5zw8DfzMcmgG9KrDu0ZqQPcx9CnD9Esaf?=
 =?us-ascii?Q?M40Y0EyO51QHDXA/7ESb62zqdcM7EvsQF54u9EKFpnuQyqU8UeyHACpAb/nY?=
 =?us-ascii?Q?Wi8Jera1blbFpKpuljqzEyu9diZ2rb54+ue3j+4Cd13HDUvEqlJeHbnN4J7i?=
 =?us-ascii?Q?SKdLFzO9Qrwsdt3hwsKCJGu+Fs4yAeL7qfSXSWZA06njHQ455qSZeF0QKJm5?=
 =?us-ascii?Q?1soYNyvjPOE326nwUyzP1/xi28oeJ+6XR96pbwSiDgv/yPJB+TezBfXtrdzd?=
 =?us-ascii?Q?hQRHFudipf/o4iEUT8ShAuK6SLUwMTyEhgLmtyG7xO3c7gBDJNTuXa4X4Rky?=
 =?us-ascii?Q?bERX4ke7o4mi9c3ro91sa//nf5Wxew7EpVthd/2ekEwz6jk0bOBqGj5urBwq?=
 =?us-ascii?Q?8zr8BSApMJdiMWL7KiHuA46o1je/hcZ7vJ3V22dBsju/i3LxvvhRZYbq+VTR?=
 =?us-ascii?Q?WHa//ZOXrIuiecNRuhcHp6SrOLN0DXmh1wh+LMFCmgg36ztWnP3nhIeZmjVv?=
 =?us-ascii?Q?37urFrkFzRNMzoXfcWP+9ujAFAwskf9pSZ/S1GOxiWmljK/LdEApm9b9skK7?=
 =?us-ascii?Q?5xH5uxJ9Gq1yYdzW8SH9AaShcS5kZYtzGaU73pNwSfGgLAibRR2guJ5UYeWb?=
 =?us-ascii?Q?sQO9fIKvq6ofsnpxWuM8Cu4bUpPOYC6pH8PKpYG8OqFluItcriEVJOWHd394?=
 =?us-ascii?Q?EN+kBGsAG7vZSsLnuO3txNdrsQ66Vd6zLBUOqNl6Q3gjcPRfpwNDBFWJ13e4?=
 =?us-ascii?Q?gKKtlrL+OnwYvfqnncZk3JOqNkVMTpWH9Vqti9gmrvWLW0XNuM6sAPck1lFn?=
 =?us-ascii?Q?Fc+UQRa/iu6TFytaJEY2haOvk9HyJu5iWNzevjz2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d918da3-bc38-40eb-6a09-08dbcf56cdc8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 21:19:53.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3TA3dQ6zbGdSlNbZo5LhEGjPRI3b/LjxGPHaF5ClFjZw9XLvK7pg//iPzc6p3GnTdyg2E+AsojoQlb6vnYdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7491
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq provides a very good standard for frequency management of
a device. However it is limited to a single frequency control and
governor per device with a hardcoded 1-1 match since devfreq device
name inherits dev_name of the parent device.

Although it suits well most of PCI devices out there, it currently
limits its adoption on devices with multiple domain frequencies
that could be seen as sub-devices.

This patch introduces the optional string argument 'name'.

When a name is given, the device itself is named with a generic
'df<n>' where 'n' is the global devfreq's device counter.
The given name is only visible at /sys/class/devfreq/df<n>/name.

So, when a name is given, multiple devfreq devices can be created
for a single parent device that is willing to address multiple
frequencies domains or subdevices withing a PCI device for instance.

When no name is given both the device name and the name file uses
the the parent's device dev_name() and it is limited to a
single devfreq device per parent-device, in order to respect the
legacy usage and not break any backwards compatibility.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---

This is mostly a RFC where the main answer that I'm looking for
is to know if this would be acceptable by devfreq subsystem.

For Intel GPUs we have a concept of a multi-tile and multi-gt.
Each tile can be seen as a duplication of an entire gpu and
contain a GT inside each and each GT has its own independent
frequency management.

Also, some newer platforms, even with single tile, has an exclusive
GT for media, also with independent frequency management.

Currently our sysfs provides a full representation of the hardware
and we could even have something like:
/sys/class/drm/card0/device/tile0/gt0/freq/
/sys/class/drm/card0/device/tile0/gt1/freq/
/sys/class/drm/card0/device/tile1/gt0/freq/
/sys/class/drm/card0/device/tile1/gt1/freq/

We are implementing a new driver for the future platforms, so we
are looking for standardize our interfaces with other drivers
and devfreq seemed to have a bright future.

Unfortunately just this patch by itself wouldn't allow us to use
devfreq directly, because we have underlaying firmware governors.
Other local experiments that seemed to work for me was to convert
the current Tegra's exclusive governor to a generic governor_active.c

On top of that we would need some extra stuff like throttle_reasons,
and some custom arguments, however before taking any further step
toward this direction I'd like to get back to my original question

is this multiple device/domain acceptable here?

Thoughts?

Thanks in advance,
Rodrigo.

 drivers/devfreq/devfreq.c | 31 ++++++++++++++++++++++++++-----
 include/linux/devfreq.h   |  8 ++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 474d81831ad3..7b4355229d0f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/idr.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
@@ -57,6 +58,8 @@ static const char timer_name[][DEVFREQ_NAME_LEN] = {
 	[DEVFREQ_TIMER_DELAYED] = { "delayed" },
 };
 
+static DEFINE_IDA(devfreq_ida);
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -727,12 +730,15 @@ static int qos_max_notifier_call(struct notifier_block *nb,
 static void devfreq_dev_release(struct device *dev)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
-	int err;
+	int id, err;
 
 	mutex_lock(&devfreq_list_lock);
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
+	if (sscanf(dev_name(dev), "df%d", &id))
+		ida_free(&devfreq_ida, id);
+
 	err = dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
 					 DEV_PM_QOS_MAX_FREQUENCY);
 	if (err && err != -ENOENT)
@@ -788,17 +794,26 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
 	unsigned long min_freq, max_freq;
-	int err = 0;
+	int id, err = 0;
 
 	if (!dev || !profile || !governor_name) {
 		dev_err(dev, "%s: Invalid parameters.\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
+	id = ida_alloc(&devfreq_ida, GFP_KERNEL);
+	if (id < 0) {
+	        err = -ENOMEM;
+		goto err_ida;
+	}
+
 	mutex_lock(&devfreq_list_lock);
 	devfreq = find_device_devfreq(dev);
 	mutex_unlock(&devfreq_list_lock);
-	if (!IS_ERR(devfreq)) {
+	if (!IS_ERR(devfreq) &&
+	    (!profile->name ||
+	     (profile->name && devfreq->profile->name &&
+	      !strcmp(profile->name, devfreq->profile->name)))) {
 		dev_err(dev, "%s: devfreq device already exists!\n",
 			__func__);
 		err = -EINVAL;
@@ -864,7 +879,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	atomic_set(&devfreq->suspend_count, 0);
 
-	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
+	if (profile->name)
+		dev_set_name(&devfreq->dev, "df%d", id);
+	else
+		dev_set_name(&devfreq->dev, "%s", dev_name(dev));
 	err = device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
@@ -955,6 +973,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	return devfreq;
 
+err_ida:
+	ida_free(&devfreq_ida, id);
 err_init:
 	mutex_unlock(&devfreq_list_lock);
 err_devfreq:
@@ -1394,7 +1414,8 @@ static ssize_t name_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
-	return sprintf(buf, "%s\n", dev_name(df->dev.parent));
+	return sprintf(buf, "%s\n", df->profile->name ? :
+		       dev_name(df->dev.parent));
 }
 static DEVICE_ATTR_RO(name);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d312ffbac4dd..0ec43eac647d 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -100,6 +100,13 @@ struct devfreq_dev_status {
  * @freq_table:		Optional list of frequencies to support statistics
  *			and freq_table must be generated in ascending order.
  * @max_state:		The size of freq_table.
+ * @name:		Optional name string. When a name is given, the device
+ *			itself is named with a generic 'df<n>' where 'n' is the
+ *			global devfreq's device counter. The given name is only
+ *			visible at /sys/class/devfreq/df<n>/name. When no name
+ *			is given both the device name and the name file uses the
+ *			the parent's device dev_name() and it is limited to a
+ *			single devfreq device per parent-device.
  *
  * @is_cooling_device: A self-explanatory boolean giving the device a
  *                     cooling effect property.
@@ -117,6 +124,7 @@ struct devfreq_dev_profile {
 
 	unsigned long *freq_table;
 	unsigned int max_state;
+	char *name;
 
 	bool is_cooling_device;
 };
-- 
2.41.0

