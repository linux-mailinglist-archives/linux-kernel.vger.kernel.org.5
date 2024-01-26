Return-Path: <linux-kernel+bounces-40243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC3A83DD15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82477289327
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D71CD3D;
	Fri, 26 Jan 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTlo0KYS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7F1CD23
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281896; cv=fail; b=NHZxjHM6+mwCCci5OcaJoPw2VZgUK6jlhpac2XOfFhnnBvcT+GiDfNbbaDJQ3Dkw0fmyApROql5GdcEsnvQRCsmSXIhm8eiezbCtSIMJsN/0k2YGjPDEpOznncCCSR7SU12qZiV8WaXWNeD+88fQ+YC5Bhr4aYMNhNxE3Ta3+bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281896; c=relaxed/simple;
	bh=aUj9INmIw00igK9990ukIrGhCx4YcjA2HS9rlkHgnM0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GPgJv8LY5rQNIOOs0qtjSovmBQnIcc5feisTGek0OLhIONOCsnJTuK3ZGhwfa0F4ANrreREeozFoxyGLIYD3gcVZXapaqsw++XUY3WGy83Z/xmgxcLXdg973KqTCGqkkkhNuTJ32zJ5SKrafge4lU7G/dSMPGLRwDYOJ7F1XBok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTlo0KYS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706281891; x=1737817891;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=aUj9INmIw00igK9990ukIrGhCx4YcjA2HS9rlkHgnM0=;
  b=nTlo0KYSUwheGqOrp8Fqh9sial1Y27nQsdyBu2CUMZt3SSPZTB0+vlCl
   BvmOwktnrPuti9SlMGbshNj26QAwbpTb7YVWqe3s6QKdaKJnhOtInqFlS
   1iUUUTQM/MsDcDTIUxoRgRUtFMp8sPc/g+HlhyOn/UNcxFhER7ar2ytCV
   zMdWiC7YyiMlXQwsHgHdyxEQG5sHgKB7mHX1QMi1TZrlQ23pdpmCRWcFe
   5+EB6qhGyiA2Jjz+iXoAmmqk55jNnZ3HnY7ngog1IBXatiZnTbvC8sbMg
   jqtZqJKfYCvvKReLn582C8cwhUiyissXeBy8RnfjdrTIK3pFoL9WIYXpJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9243533"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9243533"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 07:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960227522"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960227522"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 07:11:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 07:11:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 07:11:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 07:11:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 07:11:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXbuTBiuMgM4b1Vw7uqhirCwHCWyhV0sAMrrsW2NYkBtz+Guaq+SrtFntI5zPjJI3jIh0uv3Cu0/KyT2kxmlM74z7YP7NWUdQaFmfA1Py8MiJymsgjwVYO+MUr8mbgaEzxi2wwPiKC9OcmF528sNYsh/k9P+kpu+F1jXQ/vTXUMIyXtDNY8GyJDxAy/8FT2C3fOgcaYYPb68qX9S5k4hPZnysJcetwZQVaVQsnpvSrovlT8I9tsYcVdyaAHQhEVfyxMLmP3S6S8b2N/2/xzwZ6e8f4qORmH4r8P5I/DoJPRdwxDONrL/d4LLgkfHDwNcmAExjXmMM7c8ic+MaCyp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SRUp1iS7XqTRLnnOzp0Nh4HPnbhpvCEFvCU5AAEHxI=;
 b=Sotz43zr+GZoF+OJW3yoYbQF2dmg5nmiFgWwnsJlMbJnPfLW78unKNSGgCBNLSWc6pMSKwPiRU6jsf0HNMTOtU8EiAIgKHyTnFeijtpQrYRCwjLf4C6tpH68aElGb0FXyOozve2hPovaO83zV/GDCW8ZdYfszNuBrlmLYE+IPR/kTQn6n77MyibU6jgG4kdy9lOPIhF22S8GlgSHtMrqRQG5eWDJXy1IvGhZqjKmL6ZxqR5yJya/gHSUJ+L+vyttEig6/xrsMJRdsc4uo7JBOGKwWrCs9qqAjZdi9mcrAg4xItTtaU9nbG9kOp+a4YzQJLzZ+VIXNv+ZuRE3sxOZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 15:11:26 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:11:26 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <linux-kernel@vger.kernel.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Jose Souza <jose.souza@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Johannes Berg
	<johannes@sipsolutions.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] devcoredump: Remove devcoredump device if failing device is gone
Date: Fri, 26 Jan 2024 10:11:19 -0500
Message-ID: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 480998c8-f282-4a7d-00a1-08dc1e81108b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gxzww8owPxiTVrqmsumf2G3XrP3/xSjhygla6pvqiUDuPCgvLFPm4KXgkFjWGhuLJdPP71CuOKnhi2QwGAT2BvMCJB3v6l5m/GrzB70ouHm7RElD99P+PysicI79lvTaAm0BkMlIoekoQmEyK3LoKz4Ma8B0wASriV7MKg8/xzMoIq0/bd4o0srdQaBNDvXda8NFjp2q3+X8vEr2w7KrZVxH+ZjyiR3KcIndEakOXvK0Vpfwomd+v6mbpVT4O4LW11F9LpxggV+dZJqq0ZpDcw9N5gOhPDB4xg08UAhEAkGmGEnDk4/CflUvevhL+4h+j4/d0zhHOETDZ9CqSXrjW9p6IXsjDBXXx072HpcdRq6TGy6tWAggYijS8/TcDPBDEm8fFk1gVGi3klR5ftX/HPmCoSXeP60AIofe88bxn80WDX3I+ASFah0TcW1yX3s4749iiiG16zVutC2+ddWC+83t7c1C0bsFvDcw0bsowI+HfOS+0j3eJr2ACa/T0EBl+e4/Yy+RPxyFpn1VYfj8OYIfK4YQQjHklWn9VfxNy1Qe3a2Zf4nNAA4yj6Iahby0QSjQ9Dg5KM1YjiTImtvbKYAVw5rJcEj6SVIkQMVqbUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(6506007)(6666004)(82960400001)(6512007)(83380400001)(2616005)(478600001)(26005)(38100700002)(36756003)(5660300002)(54906003)(8676002)(316002)(66476007)(66556008)(2906002)(66946007)(86362001)(6916009)(44832011)(1076003)(6486002)(8936002)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1A6pKNoecbTzhjdEkohxEgofuHzDaPbNBMQ+nkzlxTJhFY6LHzfONr3kPhIm?=
 =?us-ascii?Q?qR07t73L51WL+DAJk+tVgzZb185r9kvifACtrt9OvdWcA7HhVgHCBpFzAIQf?=
 =?us-ascii?Q?fTsu1eJpTawVbVgbwBfGL60zG4JW76jjV6jNo00EKk9Ma29vK2oAPX7fX+B/?=
 =?us-ascii?Q?S1ZQuaMajgYw0q9Yd5/qUesiMBuJ75Zj8bjoKzJNAF1DH5qWdY3JlJ7+SmJZ?=
 =?us-ascii?Q?TkVmi11XIBE3oyrHOoFDEzLgepaTvmrzEX0UDIrHq7DOdn6++uteyfi0Lcd6?=
 =?us-ascii?Q?COYUNDFlG+uBXbAV18q6aurSd7lYeRXKEnTUxEB0oY3dcj3ucw9kbTgjdiBm?=
 =?us-ascii?Q?qTIQ8JghI3M36k+ub6Gg6zh3kF3u858E4yzH3AdgXRPqKp+G293O2m4W4bK1?=
 =?us-ascii?Q?wdV9ooxEnj+KU4SkdA32NEe5SFDWYh+lwaTXRCIqpqlPpTyXOWXtpNM3VGi8?=
 =?us-ascii?Q?QKtESjEKslNG5QyQuJBWtEEXaGWISbpRmmFUhlkOZ3alny3bezLCQoXN0lzJ?=
 =?us-ascii?Q?oEzw+hAm8/vNsdsuEGIF0Ucg8JfSE+3+VwSm+EieSSV4kfgTI61bnl8tgP/p?=
 =?us-ascii?Q?bBD/cy9VGoW/QK3OsxRhDbKJhiBF1RdMvT8hDq/AGarTHuEjv29juTzk4rDH?=
 =?us-ascii?Q?jL3JdqU+xIvvIJ/ZAm908/jd82KB+rWuj69SVSz5Qu/Z2dxltbt8k+vVardU?=
 =?us-ascii?Q?sdH6V2aylMypcEKBNBFT0z6+QKecl+xi0Eq/xfBW2bnPSfrqs6wx3Zke44mp?=
 =?us-ascii?Q?Q/VgpwccwS/3mV1IMq4SnthgjTtTGr18v+n6plU/QbZr3w38/ebwcNVZfsIU?=
 =?us-ascii?Q?MOA3bwKIUcrt9BcCL1S+j7el3MSTsOiQsdPxAluISXTyJgsNCzPMWYDjAg1+?=
 =?us-ascii?Q?ekXEym8XIKt7n8329Hwkle1VaepTp6JE3rM4L2ohXEozKnjv+1OnMIAXc6KT?=
 =?us-ascii?Q?sEazxM7T5hROwqVRQ7gGA5L0BfG1ezs4zY4pxfPJncgllC/vrkrWi+brDcDP?=
 =?us-ascii?Q?Nt/HQwbUVVxx/QrP5CSQ1sjutZ518tBOA5MgXInThVKtXgvtYKRZ2kF+pgcR?=
 =?us-ascii?Q?230iMbruZD8voD9JoItazdQTvIPL40DkWCCs9Q1Ho081UZPsbAGIrbQzskC1?=
 =?us-ascii?Q?U4uNuYaEEyYgAhKmoE0odk6weYTtyjJA1TS8IItrEjCJ+36H5c8gyRgJazn6?=
 =?us-ascii?Q?X0Kdh5m/r/0S3J8b42hIqW6k9cPanFstskSR431fH9Nmvjh6/JDYKPKFGCBQ?=
 =?us-ascii?Q?9hNiUfWWx1LFTQNGwYgluO/PuI5ownHn3K7TsGkZFMWKMtwZupdFcxrK6pth?=
 =?us-ascii?Q?ysjzT6jbnvWhxQjljcuQIXPK/8rRc3/tXKbREWFeeeQuVfeJOqaGXLbkhJQb?=
 =?us-ascii?Q?qYD/idT4ROCcW5DM652jxjEweUr/OZZ0K34QUB7L3s+SqnQjeCqxMipGZEAt?=
 =?us-ascii?Q?qBigt+r/JMbxmq3Q1zkLvfOQDPzrCSfw1e03FyRDNt8NYCgFy/jE5fgv90+E?=
 =?us-ascii?Q?EUTWWVVj91IVYVR5IPymTIhq5HvxASAgi3T2hGUk+zl+V7d+lG1alt30hcZe?=
 =?us-ascii?Q?smiC/oukNQR2mgfv+YojJQrf2oxM1Y0yAVKF1qo7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 480998c8-f282-4a7d-00a1-08dc1e81108b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:11:25.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHWjAfsftISKqi40v9XbjYFBkzp/jJhEcrHAxNs4YVsAcNj2cOG06xlv6AdXnIoJq4wa2lpVC99/K++h4X2RvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
X-OriginatorOrg: intel.com

Make dev_coredumpm a real device managed helper, that not only
frees the device after a scheduled delay (DEVCD_TIMEOUT), but
also when the failing/crashed device is gone.

The module remove for the drivers using devcoredump are currently
broken if attempted between the crash and the DEVCD_TIMEOUT, since
the symbolic sysfs link won't be deleted.

On top of that, for PCI devices, the unbind of the device will
call the pci .remove void function, that cannot fail. At that
time, our device is pretty much gone, but the read and free
functions are alive trough the devcoredump device and they
can get some NULL dereferences or use after free.

So, if the failing-device is gone let's also request for the
devcoredump-device removal using the same mod_delayed_work
as when writing anything through data. The flush cannot be
used since it is synchronous and the devcd would be surely
gone right before the mutex_unlock on the next line.

Cc: Jose Souza <jose.souza@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/base/devcoredump.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a..678ecc2fa242 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -304,6 +304,19 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
 				  offset);
 }
 
+static void devcd_remove(void *data)
+{
+	struct devcd_entry *devcd = data;
+
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work) {
+		devcd->delete_work = true;
+		/* XXX: Cannot flush otherwise the mutex below will hit a UAF */
+		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	}
+	mutex_unlock(&devcd->mutex);
+}
+
 /**
  * dev_coredumpm - create device coredump with read/free methods
  * @dev: the struct device for the crashed device
@@ -381,6 +394,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
+	if (devm_add_action(dev, devcd_remove, devcd))
+		dev_warn(dev, "devcoredump managed auto-removal registration failed\n");
 	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
-- 
2.43.0


