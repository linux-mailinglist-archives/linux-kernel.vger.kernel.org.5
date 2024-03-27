Return-Path: <linux-kernel+bounces-120216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9088D48C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8BAB21FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F417021A19;
	Wed, 27 Mar 2024 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="b3KXxCs+"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F520334;
	Wed, 27 Mar 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506563; cv=fail; b=J78G+fJ4pp4AP4wsuBZs4TjF/gpcLuYVhzpeC86xDhxxPt4JJqyrd9ctamf5e3he0U1HlL34NIS7to/3ew78t30Tl/9nF/A8aXN3f4WjlCapQMQNzvL9tG1Uju11+YzbQNQc6nTv7kVM3DFE4egKVYAmZECae3J0U/9U1US5rXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506563; c=relaxed/simple;
	bh=bcSPt0o+R86DMAIyz/4fmPlJuaWr8Db+d/SKKEXBBME=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n9aDRQh58PybUBBFgNycgHapb1LOYP6eZ8sR3EvFGFQqogyUO/M4xZP1iMLUh3b++WlpPFWwT3Llw1/o6Uz5skf2keiBX5fMiRmuZemmUMpCyQQdX7Ry8ahqo4iZxPWT4gPxkB3HRP8Q+e2dRU769cfv3A5w+QGYmOMi+tXg5IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=b3KXxCs+; arc=fail smtp.client-ip=40.107.113.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbpyMUPJoEeyGFRhptpGLhCz+X1xMNyAjN0lzm9dXz3kOGvS5FGncYuNzsSDZ/Op4TuohzqrmRj8ukwKE+fMg4vjTqlcyxcKa2N7GmmLPrbNMZOjaRq5lAiA4EtyqVNqH9H9/buRdUlpvbZnc136UHbYy8vCbdnNW+FiYn+mwYCRh9DyixgQgFdF6eCl4ufP4h/bXzgEq2QsPs+39hYTknZLa7bVQsSGlkutbrJmjbJsuvzw3J1TrRkMBYSKASLBotgdB/8zFpiGi+Ct/ZxQeWrtb96QE4Oj7BnOg/glSr32sjb217zDd5cAwat25dLx6nJVvH6ZRu7VATEg+T+syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRAj2StyC12et08+jrHIp9lbg8RjAoGkr8bjdFiCeGo=;
 b=ikY7Gx4gBpRfesnpy9R9UKERhyPzWjai0TH8ByvZsbohKxGztr9h46N4pzvuUOfyAsJmRoK76zfIoioPm874HHNU9JRfGtKYW4MnAGYX9DcalFGbXxri+StzJD4OhpH80nmINE3+Fw9cFbvD/T+mH8Y8fC3Cow1QhrHc2LsOrYswHohJkUuj5UpMyUfl5klXWV8ARsk9VWB4vu9LIY0BJs+cZUrax8mplrRLpGfMpYeESLoxsmQjUgK6sExQpROng8De4xCc+ojYtFBClQHoi7wqMhQykibRdhTkv23AwXvs105guzZxMZqHcz2NgpIKKglon4ZB/oa5mbmLhRoZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRAj2StyC12et08+jrHIp9lbg8RjAoGkr8bjdFiCeGo=;
 b=b3KXxCs+DP8yHtv6YfeZexzdcchvM7zqZQMIV7IZD1N+Erk4aL8k6jqlTdWDWm3w7/k3ekJxVp9381sUEdtuO1aNQUH4lkNjOgKI7lh485GZ1pqRyAz1aFj52N24QUX9ApABIVvx0TQ0L63sv51edJclDU4CWd+9EzJkFbCQzYAoMlUNo3TRfzaTn2GVUadcSmpRjKcoyRut7dHKW0iqA7PASuAE4AezyA91/Xi7+F+4dLgsRh1sr2K0cGnSP39bKJrs6XBSLC++yO9eJlb/IYmnH0QOYrsSbpicPF+d7eEiWaUALh4WkJGjwQng9K/yav/40d0NIR3HrAqonFTb1g==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYWPR01MB10969.jpnprd01.prod.outlook.com
 (2603:1096:400:395::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 27 Mar
 2024 02:29:16 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 02:29:16 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: balbi@kernel.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Subject: [PATCH v2] usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error
Date: Wed, 27 Mar 2024 11:35:50 +0900
Message-Id: <20240327023550.51214-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: OS0P286CA0153.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:16a::10) To TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10781:EE_|TYWPR01MB10969:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EU7mViq5Bi2pcI3+xwNi35c2656rGI7s2VGLFFwx8K5NOYP//Xdcm/Pz3YSI7AZUMLrdPxZl1Y9QEKCjMGMlHUmKockKwDgVLT6fqg43/wyXgGyOHstDnhjUjkEhRD1u89mW1mXSzI8jy4lgT/hR+7ULGXtCS8ywDzwi7OSYuY4MTdTFtF/pkshLayqMA/Sar9OF5bkV/DV6wCvP+gp3osjRTyXE0hkXqT22TnsT7ycuIxzLAFO7TLP4WqA3m8BLGVSOB8jEHbixYsvBTKRt6ninPu2qd5558t7+3xwBLE4eOMFyHeczgEDP6sK3YxBKF8knBPpeVQZKGFlR0+8ZwwfxFwefWRpwdzsQsfrveVuw3W0OOJGkNhDv0w6az4fYXElQYN22uux60lIcZxcXg9g1Bvkq1h4Ti6nfNzJk1Pwx//0pF4YrJFKMd8gEzDToGM3+J3R/SK3WE4kJQ+o6h5AgDNz8717HtHyQL8VVFLhElnX87Atc70rpPU26dKMMXgZjGOtJw2+VFsGLlnmwRnEqZtb3Y1jLx7x6KzpB8jmGoUWiXrPUtp9hLP5iu/4iuVUujM1bEhjXcKGf1FWXqN5K/mIEw342PbgR67mhDtAMKlwT13yPMu1tNkJtaBHrNRKqWQUMbAalkALgoMggYzndHU1gePQk0s6MvgDerWy+o/3rA2I5VaUnx3DowKSKGEgyyOUg+CAjI8lOgl3dBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yiC2YxHko/cMDoCdsxfTABZokbbcoKnFZmA3YLA6bMTyAGswhL+6Nct7XT3N?=
 =?us-ascii?Q?ZmzXu89pw4KXzxg1WAPsVgH61ir9WoiiEc3u141rf4MwBn6egKaB1olPEfwQ?=
 =?us-ascii?Q?9m2mIsa4SfW1Wu9KlKzui35DwMx7tYx2nd/2n5L61SVdthA16RqIZMLnKaRi?=
 =?us-ascii?Q?FfX/CSdis+egIZtgeiEwyXo0OAjQW/aszmoKjRRl69u3FoZgT7NMRzOlaMOh?=
 =?us-ascii?Q?EtNWeNAGgzl4OBVN+tCDT7mn2U/7trgPZHbk+/U+E0CQNCsdgflJlkifsZHA?=
 =?us-ascii?Q?QALHOjlRDfj+/36sEs4luqa80yZ3WInMUPKt1MQ5vg5YDMLi81696DwJMrhj?=
 =?us-ascii?Q?YpZwu1qcui0XTmtdMzsvvjh+/iqZmVhR6H6m8LlXwGwDeyo8KW42B4zdeGvj?=
 =?us-ascii?Q?Vxr4GgvehpdzYDuTIsVwen7uyAbTgf54wCqAS5SXzH/JCaj40Qny0+okksFL?=
 =?us-ascii?Q?ACCTjAtOOcVaWf/bXuD9+rCjqYAtBMRk8FTPx0+ep6sncani59vn+N8pkSlm?=
 =?us-ascii?Q?dDu/9LKsdN9SCQPO+c9yHxPd3GhtLRrPmCrcDPczAlt3XfHsQFmIfm/Fzurt?=
 =?us-ascii?Q?zZABezssPhQfAwLLZirKGq1p/UMMdroLeESyDqbOWCNzlwjvbQIhIDKWVpUh?=
 =?us-ascii?Q?WEwqJUZmxalJozH1g7aA3/g7cANTNGZh5wIIivAuIwBi4R3XEku1Xa+oVihu?=
 =?us-ascii?Q?LVvabd8mofER1TiO4f8nJFgBfCfjEvDjVXnPHGSKYRAvwQWEGHgefnEJh0kA?=
 =?us-ascii?Q?v6I/Q+N40Dy1IcWZjFl8xofp/TdO8e9zRYXqzDDwrETKNpNpqeFpLYUaJAf/?=
 =?us-ascii?Q?zWUOGe+JlF4elUxbUa27hX6HemJOgYOTYqO6FwDQx8S7/CgYRoE0LnHClMd5?=
 =?us-ascii?Q?x0zpYxv+RQaxaKKozlg2w5gzQozgcJPdqVHXaNGnw6WjLgFoq+dflcN5Rp9s?=
 =?us-ascii?Q?Fgh5A1h20OvHtMBVCSiChgEFEx61gn3Stds07jMJ5GmUe+K8FNdLPFcF6MGa?=
 =?us-ascii?Q?DLxh+mmunWXF1uXKyk/7EgdDOJRPNO8eoUJSdQXKB39fKP+kAv+wNhweiC31?=
 =?us-ascii?Q?hMvY2YHPJdIf1mPEkNRX6JNjarvZkbGT7hdC3S6i7gGSOav+BnWiFKs1Xlj5?=
 =?us-ascii?Q?satuK5zfcAovd2ghhyq7n4kE0JLjBLif40YxVL0dBact9L88vKqTBF47FWxP?=
 =?us-ascii?Q?qVEMsvKJT3auhZJpJne+fabHo59H8eCI7yOBNGGZcjreDbFOmXdkQBAQQjYB?=
 =?us-ascii?Q?ziZgH4hn4o1ksEyHwv07Zt8kq9HtgZYhmBNAM/pgF5q+VsGouvUoq/3WDacZ?=
 =?us-ascii?Q?Chaqag5Ky7m3aQ8c94zMslQ7BGwWXWmPQCWLl1JH0ave5SL2j5EoxVlMazoA?=
 =?us-ascii?Q?gNQd/uB6jOOlSBVLNvK9fZOLGJ4mBCH6s+zlRwPf56c1T0eOUVfmxqCfKxPf?=
 =?us-ascii?Q?kxUoefV9TmyfflQzTIWjhB4Do9nYQz9w2D8nJTIMGcZx5MPV6tGEiy7yXc0h?=
 =?us-ascii?Q?IluEUM+RzXWx/marcBhf3KdDKk2u68SsfNaCjypMIevwT/XcUxRiYVyuMhJK?=
 =?us-ascii?Q?/IFjSYqkvJys1URt5zDJoViuau8AlvQmRsBFEAua?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0511cd-0944-4012-8a25-08dc4e05b297
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 02:29:15.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AYx2TnEREaKZsqsED2tNBIZG8PPXGt01Y0g9ylmjD5dNoM0zUXWfWWLx+wuNUxnBmrXaJi8DoZN2+aOEap7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10969

It seems to be potential issue for long time.

When ncm function is working and then stop usb0 interface for link down,
eth_stop() is called. At this piont, accidentally if usb transport error
should happen in usb_ep_enable(), 'in_ep' and/or 'out_ep' may not be enabled.

After that, ncm_disable() is called to disable for ncm unbind
but gether_disconnect() is never called since 'in_ep' is not enabled.

As the result, ncm object is released in ncm unbind
but 'dev->port_usb' associated to 'ncm->port' is not NULL.

And when ncm bind again to recover netdev, ncm object is reallocated
but usb0 interface is already associated to previous released ncm object.

Therefore, once usb0 interface is up and eth_start_xmit() is called,
released ncm object is dereferrenced and it might cause use-after-free memory.

[function unlink via configfs]
  usb0: eth_stop dev->port_usb=ffffff9b179c3200
  --> error happens in usb_ep_enable().
  NCM: ncm_disable: ncm=ffffff9b179c3200
  --> no gether_disconnect() since ncm->port.in_ep->enabled is false.
  NCM: ncm_unbind: ncm unbind ncm=ffffff9b179c3200
  NCM: ncm_free: ncm free ncm=ffffff9b179c3200   <-- released ncm

[function link via configfs]
  NCM: ncm_alloc: ncm alloc ncm=ffffff9ac4f8a000
  NCM: ncm_bind: ncm bind ncm=ffffff9ac4f8a000
  NCM: ncm_set_alt: ncm=ffffff9ac4f8a000 alt=0
  usb0: eth_open dev->port_usb=ffffff9b179c3200  <-- previous released ncm
  usb0: eth_start dev->port_usb=ffffff9b179c3200 <--
  eth_start_xmit()
  --> dev->wrap()
  Unable to handle kernel paging request at virtual address dead00000000014f

This patch addresses the issue by checking if 'ncm->netdev' is not NULL at
ncm_disable() to call gether_disconnect() to deassociate 'dev->port_usb'.
It's more reasonable to check 'ncm->netdev' to call gether_connect/disconnect
rather than check 'ncm->port.in_ep->enabled' since it might not be enabled
but the gether connection might be established.

Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
---
 drivers/usb/gadget/function/f_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index bd095ae569ed..23960cd16463 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -888,7 +888,7 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (alt > 1)
 			goto fail;
 
-		if (ncm->port.in_ep->enabled) {
+		if (ncm->netdev) {
 			DBG(cdev, "reset ncm\n");
 			ncm->netdev = NULL;
 			gether_disconnect(&ncm->port);
@@ -1365,7 +1365,7 @@ static void ncm_disable(struct usb_function *f)
 
 	DBG(cdev, "ncm deactivated\n");
 
-	if (ncm->port.in_ep->enabled) {
+	if (ncm->netdev) {
 		ncm->netdev = NULL;
 		gether_disconnect(&ncm->port);
 	}
-- 
2.17.1


