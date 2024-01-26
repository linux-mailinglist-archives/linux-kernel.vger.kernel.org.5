Return-Path: <linux-kernel+bounces-40244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C583DD16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19A82877AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D301CF90;
	Fri, 26 Jan 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkqtVcP3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD621CD24
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281896; cv=fail; b=fGj7Wk8e+DF8hInyvXLgrlXw1shiVVeeKSkIrw6vdFVwYTqiiDc6+Sdgv/mfa/TgAvkzwX1r66AG7/FOzCrsgXyicZFcvPORcCpkzdTZmhQYGfKJ/MfcdxnUlP34RUvT2OjGAAcEa+8fQCsaCOi34CZ+JwqQ0WgDQCFEEGtW7Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281896; c=relaxed/simple;
	bh=IXw9aAYvd1pk3nJSVqQRVD8C/SaI7uJGFzeoee8vmEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANWACmWN2EHW+8dk2P1v34ec6d/Z9xr+2yR9nTgf4Tuomk0iFmeYPN+xIwFtjjsscaVvC1vACDTtkmqpFxixa/+nqemBGqsSTNOyqmTR7N8crrnZ/J4dMfhEyBMyzN82cqZHQv3Zqpdz7v+h29WuqNK/52CtqR1zGSKt3YeLfPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkqtVcP3; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706281894; x=1737817894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IXw9aAYvd1pk3nJSVqQRVD8C/SaI7uJGFzeoee8vmEk=;
  b=EkqtVcP37ET31vc2zpfg/LDkJc3jF0LxC2R1JQFkm5FF4Gnsq3Qjt7D/
   rr7cO/v1eXN+1dvnkmBaCq0AOBvJZYpmvgAsj5SXisI1l7Sw1aKzh4oYZ
   cRTMy7h/FbzaWRFvQUuYNwcI6qywuBX6aXH1gK6L1RIBNKCDmazNgPNI+
   vLjFj1bt4mwTrK4PfSgljRMx1YY9czGcR6Y01oI+6o3GdbXnPXrCREl8v
   y9woomtJWX4GQ0dLownYGxE5+54mEXdbycMWdhIlR9Jvj7LuH+nphP01E
   vERZjQqA6v0RkvIBSAPFa3kcUf9IH8TYkenwWOnsOuaDL4/dr8uDmDs8V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9243560"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9243560"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 07:11:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960227549"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960227549"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 07:11:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 07:11:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 07:11:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 07:11:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 07:11:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izgdQgecEF/ucVxsjFUqinKYWzMIwCy3f9pXVZfkbT7UiXU/kqlaJI2VxkN7aCStb6jfPjyEfMWPIiyhvP5Sf9gA99AYN6kSQxoF0sym+7GIGUSpGT7FZY/lJAgVse/JduYXjmLsxyRt5YwZWE9EPXiVv/0NuOxb8uZNa/Y1S0LsOglLmWPR8ADb24k6nILAbW4/NNrhaRb7lKJzsc0OJFDU5Acspxd2OZXahm35AyuGnKP/fKDdYGQn0AzyFHyK/fYGRXahddvmRodOBhh8cX+kjoXbDZJUqmeo5mTXddRL0CRBSfuol9eFvMoGsefAHZSsCriKMxIyYbWelbAXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKKbFT6EKYq4vNLez7sFgKjDFagBa1E0cuk0P6bwHug=;
 b=c637PfFhqjIxBu/l6ClFfV+O2V5AbUPArMyn0wFc4EMYSfj9J79zLFGX2v/HXGz47kIi372NI5CVU2PGZkIL1SWSENATNlpRZav87NURYDc6mPmjvRgjmqJerxEGmHjjawaN2YqMYF7Qz3ofJxfPHsnfX1alfFaLOR3KH3iWUQyCdHGcBiw3vAWTm9oPOaYp3rxK272ZMUEYxH2B+z7Y8E/6m7DaL5YgZug2b/mKHLrwQ/IKcauvx4A/+CJoQDZXuY9bL0Xj7/f6/Vzb5Z/oqP71aZy7M389mQIiU8af8Az/WsenkDMIokGB1zl4YbMgtOhHln2JLDR4qmBVJsfpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 15:11:29 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:11:29 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <linux-kernel@vger.kernel.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Mukesh Ojha
	<quic_mojha@quicinc.com>, Johannes Berg <johannes@sipsolutions.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Jose Souza <jose.souza@intel.com>
Subject: [PATCH 2/2] devcoredump: Remove the mutex serialization
Date: Fri, 26 Jan 2024 10:11:20 -0500
Message-ID: <20240126151121.1076079-2-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21)
 To MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a04cd9b-0e80-4923-4e9e-08dc1e8112ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKhwEcNOxXRkCLjO3t81YnPOl0tE5Mj1oJjjguXOs2L4UocomSsP7/DzrZQeDcR/gP6EzRbDU/XscsqIU167XDzsTt1QX+zlbu1aiWd4tpBC/qhUIjL0VdslN2e1ialkhyrN/PlArfGUjteTbZIfgJwBdM3RjjyXgvMMAfXzUGp88hPFSnFs83Wfe0VzpVvw3SOqVGwN9qFLvyVjo8VhezjGeU7G4saoH2V71UJuoOOizPokWRrlDOrhZl7virj7EKz1cP31HggE9heDXjgM+3KD+w/pxvzDUjGWJWwzaYQPS/Ww+vzb7mRdil1ge3VXo10mBGf1bn9Q7oNr9oXw3nCiTR189duXYwYQUQ4nkHatNCw+cSfyMdXKwqkdjF7KF6KjlTe2HhDrNvm18LDRwFXkkdE9IGgt7IUTxxyaooFnhqv2Qxl/anoqk1kIucUd/zrEEk6jbKDfGIIp/me4yJ9RTBF9wAZ++kuhod2pcvyF6iuJWo0gkViFOr/OqyQNqlA4pvUSbFCiw0Vtd0gUb6MCRX+3R4SSjqiuL6+MOQrnY1QnMlgBz5HIcwgKeWfz/bpYtp5Nno2xAP6Jmx/PBXkHyBZRTvYSVI+7+cG5Jyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(107886003)(6506007)(6666004)(82960400001)(6512007)(83380400001)(2616005)(478600001)(26005)(38100700002)(36756003)(5660300002)(54906003)(8676002)(316002)(66476007)(66556008)(2906002)(66946007)(86362001)(6916009)(44832011)(1076003)(6486002)(8936002)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBNe1IHJYW4hKW8fp7Wu83u/Fs7B0Guv79p9XJcO2KYk37xvDIL1bBwvzSTQ?=
 =?us-ascii?Q?+llhPahmDN7ht60mP5QJLZm7uF8McE7wFZLCUytD2b4B4BaYh3ZDJXhfpX7V?=
 =?us-ascii?Q?mLLP5DHpKCCwdeFscwnn+v5ddxVLKq8okbOGwn8yc0x8tIZZuQP7qK0Fgfk8?=
 =?us-ascii?Q?3acJg6bnl0aQ1TEuEYzHJXrvbL42sbVzffWG+3hyDlXvQI8Flyn+qPF/UHg8?=
 =?us-ascii?Q?6Ksir8RetSQZwdrXlij1nz1Ew6RViT2i8mSbG6bJO3GU0CbIMptV90EvEo5B?=
 =?us-ascii?Q?2Qu7PS54jx9oumH2yCarWSec4Fi8XxOWabzIfQ01+IHNyOvtWwN0Lfd1wO7s?=
 =?us-ascii?Q?C76XfXzCtOfBvQm+o9nhESkrqPJMKNIQ8wZXWrd495MosMNPmAcJ67FQ9Ezc?=
 =?us-ascii?Q?wbTSuy45XJpozGzNRU4728qMklTNva/qLSPsCCf22WFr1XVxB5dckr3LFW5U?=
 =?us-ascii?Q?sYy0FH88Xxu2UyQkSrqpjeCSHT24WbMFSMnc1IwGc3Z72q2j7WkSoYPDtZG5?=
 =?us-ascii?Q?ro2L8yQlYI02ywEEZCKaqflVu+dOxrmR9Cm9l4qY52tAfjX+mG+Szx6R7ta8?=
 =?us-ascii?Q?G4JA+1WKbspm8mjYagtJhnYgDG30Wqq1tX51Ml2TSGMHVsh1xXQ+Rzj5z82K?=
 =?us-ascii?Q?51M8GPvS7YzuMIFlsHpAfV+WKCiOk8nqRWEGcsIwZ0cdkD0jAmEmcsCXhmeb?=
 =?us-ascii?Q?Fi61qPhRw4uJ48cKnmN3IADTN7i1rI1s5qjeJcjDA36FLiw1GjPZd8xPJju+?=
 =?us-ascii?Q?UdEiiDsMpcBTKhuBIHRqxexLKIed9LfHaPOrAH2pc+RF0I8BkJVGGTxzVJUb?=
 =?us-ascii?Q?hokEREjlFOoQfOqMy7CSj9nBahzhqs+Pof+Gba+swb0rD5HYpKAtUo8d1oPg?=
 =?us-ascii?Q?Rx5NaWJII4IRfsJpV+9AJLrVYdZY3fNY2ipJQVJ7GgHXxTiueKqI6MAdkMB+?=
 =?us-ascii?Q?zYrf6UmTLvhGMgeuDM9B0fHO8mW3oeitbtEOwaGiF4273kDn0oMmzHtONsGR?=
 =?us-ascii?Q?GM4nIO2fbMe8cXIdYhjNv7HlC6yHWojwoa5SwrSkrOiN50g/5NhcdD+BagcU?=
 =?us-ascii?Q?PkSup1faAEHt+01iV0AraIsks50UE17TqJAY3DgrLcgKb98llyjc4FoXEE9t?=
 =?us-ascii?Q?9zo5Hm7zSiDqFlLFI6KsXzHb8yO+cdsSDXl22WymHz5ROtRskyjDayW1o3K+?=
 =?us-ascii?Q?ztejagW7ocXOsJUBpM88BTT2aZ1XGH6TI9BDt1IJ2oSGfpmw5uTtJfmZCAE2?=
 =?us-ascii?Q?iv0lvOr8dhbTC5Zn6wskiHZol8fgEKUn3DP6gVwuv/grntThuTWSF5t7LEXR?=
 =?us-ascii?Q?n44zgyzFVJNHuEBAfQfZmA3KjtTkeUNLc6xd0AL/DivmwGJhF4DaDXRbt/Ic?=
 =?us-ascii?Q?+oH5rKGK+NIzukI6UHur8BFVR8wa6LJnCAhALAuLW/tUvKFpogDuRqxmGHFf?=
 =?us-ascii?Q?7k6nTAro8Bj0yZUNX5GBFseAG+/hHEl5Vv3Ha9bJ8phoXgl44EmDZJrKgoJ6?=
 =?us-ascii?Q?sqiQ9kYjriPgN7Fkr4oKYH6JOt8ozqDHbQv4gx7ibBzWq3fha8JxcA1Hvaqp?=
 =?us-ascii?Q?m9HxSJrb5nRLFms5Ejx3R3dKi5UG463ZJYYywv8w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a04cd9b-0e80-4923-4e9e-08dc1e8112ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:11:29.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf5ULGKfS6iyrAIwZw3GQyg0VUDJqgwnlYhM61vSMRlgMEf/Gw/iZ2AckwOeOFVmx99rAKktaOFl1Teoj7Dqnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
X-OriginatorOrg: intel.com

The commit 01daccf74832 ("devcoredump : Serialize devcd_del work")
introduced the mutex to protect the case where mod_delayed_work
could be called before the delayed work even existed.

Instead, we can simply initialize the delayed work before the device
is added, so the race condition doesn't exist at first place.

The mutex_unlock is very problematic here. Although mod_delayed_work
is async, we have no warranty that the work is not finished before
the mutex_unlock(devcd->mutex), and if that happen 'devcd' is used
after freed.

Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Jose Souza <jose.souza@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/base/devcoredump.c | 97 +++-----------------------------------
 1 file changed, 6 insertions(+), 91 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 678ecc2fa242..0e26b1273920 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -25,47 +25,6 @@ struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
 	size_t datalen;
-	/*
-	 * Here, mutex is required to serialize the calls to del_wk work between
-	 * user/kernel space which happens when devcd is added with device_add()
-	 * and that sends uevent to user space. User space reads the uevents,
-	 * and calls to devcd_data_write() which try to modify the work which is
-	 * not even initialized/queued from devcoredump.
-	 *
-	 *
-	 *
-	 *        cpu0(X)                                 cpu1(Y)
-	 *
-	 *        dev_coredump() uevent sent to user space
-	 *        device_add()  ======================> user space process Y reads the
-	 *                                              uevents writes to devcd fd
-	 *                                              which results into writes to
-	 *
-	 *                                             devcd_data_write()
-	 *                                               mod_delayed_work()
-	 *                                                 try_to_grab_pending()
-	 *                                                   del_timer()
-	 *                                                     debug_assert_init()
-	 *       INIT_DELAYED_WORK()
-	 *       schedule_delayed_work()
-	 *
-	 *
-	 * Also, mutex alone would not be enough to avoid scheduling of
-	 * del_wk work after it get flush from a call to devcd_free()
-	 * mentioned as below.
-	 *
-	 *	disabled_store()
-	 *        devcd_free()
-	 *          mutex_lock()             devcd_data_write()
-	 *          flush_delayed_work()
-	 *          mutex_unlock()
-	 *                                   mutex_lock()
-	 *                                   mod_delayed_work()
-	 *                                   mutex_unlock()
-	 * So, delete_work flag is required.
-	 */
-	struct mutex mutex;
-	bool delete_work;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
@@ -125,13 +84,8 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work) {
-		devcd->delete_work = true;
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
-	}
-	mutex_unlock(&devcd->mutex);
-
+	/* This file needs to be closed before devcd can be deleted */
+	mod_delayed_work(system_wq, &devcd->del_wk, 0);
 	return count;
 }
 
@@ -158,12 +112,7 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work)
-		devcd->delete_work = true;
-
 	flush_delayed_work(&devcd->del_wk);
-	mutex_unlock(&devcd->mutex);
 	return 0;
 }
 
@@ -173,30 +122,6 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
 	return sysfs_emit(buf, "%d\n", devcd_disabled);
 }
 
-/*
- *
- *	disabled_store()                                	worker()
- *	 class_for_each_device(&devcd_class,
- *		NULL, NULL, devcd_free)
- *         ...
- *         ...
- *	   while ((dev = class_dev_iter_next(&iter))
- *                                                             devcd_del()
- *                                                               device_del()
- *                                                                 put_device() <- last reference
- *             error = fn(dev, data)                           devcd_dev_release()
- *             devcd_free(dev, data)                           kfree(devcd)
- *             mutex_lock(&devcd->mutex);
- *
- *
- * In the above diagram, It looks like disabled_store() would be racing with parallely
- * running devcd_del() and result in memory abort while acquiring devcd->mutex which
- * is called after kfree of devcd memory  after dropping its last reference with
- * put_device(). However, this will not happens as fn(dev, data) runs
- * with its own reference to device via klist_node so it is not its last reference.
- * so, above situation would not occur.
- */
-
 static ssize_t disabled_store(const struct class *class, const struct class_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -308,13 +233,7 @@ static void devcd_remove(void *data)
 {
 	struct devcd_entry *devcd = data;
 
-	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work) {
-		devcd->delete_work = true;
-		/* XXX: Cannot flush otherwise the mutex below will hit a UAF */
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
-	}
-	mutex_unlock(&devcd->mutex);
+	flush_delayed_work(&devcd->del_wk);
 }
 
 /**
@@ -365,16 +284,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
-	devcd->delete_work = false;
 
-	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
-	mutex_lock(&devcd->mutex);
+	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
+	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
 	dev_set_uevent_suppress(&devcd->devcd_dev, true);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
@@ -392,15 +310,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 	dev_set_uevent_suppress(&devcd->devcd_dev, false);
 	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
-	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
-	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
 	if (devm_add_action(dev, devcd_remove, devcd))
 		dev_warn(dev, "devcoredump managed auto-removal registration failed\n");
-	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
+	cancel_delayed_work(&devcd->del_wk);
 	put_device(&devcd->devcd_dev);
-	mutex_unlock(&devcd->mutex);
  put_module:
 	module_put(owner);
  free:
-- 
2.43.0


