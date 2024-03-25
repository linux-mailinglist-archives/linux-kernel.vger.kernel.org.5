Return-Path: <linux-kernel+bounces-116758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B029188A379
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B10F1F3D641
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD62487B0;
	Mon, 25 Mar 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="IU7E83Qo"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11011008.outbound.protection.outlook.com [52.101.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EE159908;
	Mon, 25 Mar 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359592; cv=fail; b=S6Epe7J50Q9Lxah6r8kT6eB7iM8/PfRnNYBa/U0xj4fBecWjdg0hpHs6HkXAUoJ5iNQfUUzwb/meHww/aUdGvHFVYfOcw4y1ui+Np/ZiaEkzkpjZM67NBEwvpAoT5ZZCSICtX+bb20MWhk2pnaUtPtnwsXBd3qoaU0VPncN2WzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359592; c=relaxed/simple;
	bh=NKoCewhFDb9p1kzJZvNGH48/nT40iUtHwijbMM5HHUU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nX5vWh8ye2nZi5c1gTzJYnEpYJXIpKmzv2K5BuIp8HjscG+GDE9udYR6P7vnDz3W2IFY8O5lxEPFIx6UCda2F543+1/ouMce2lkhQ9k9EfXN9UUZKhD5AgAdTnh6R8G7MpY3QkQw1IlMdLiEH+uS07C1RdvfGeoLTsDjlow27bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=IU7E83Qo; arc=fail smtp.client-ip=52.101.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGWbUQV8avbX6ZLiY3VvmsU4wlI1/w+1VCj/3s6nPXzXsAN26aaZjA6gjcZQhL07Bl67h4/YDJNW/UDm87Jys+Y8GmgUB7gVE+H68TAr0WDSMqtxbo0nS3Umx+o/21smCErwJ8A2OM+n2PDQmAxK1VWuc0nYZXyoIvDEC+TMA2Vzaf6WWXtDONIw/RSbVCCSwDerQHrwK+SLJVW8HPRM6RCz7PIkH5l6RguKDDVE+RK++UMjPDf9SwvDrZn/gchQq8LMZDPUSum6UtgPpz6nuGaQWj1ecsbKT81n6khJk8uqc6uS1Sg3RSEB7SElu1CewjHNOUZHLQhuhuRtUX708g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CgqwnR4FMrQhyKZFpU5rMlvVotSXk9FY3BG6sbl8Gs=;
 b=N53Jd7jLocW+m7RPuubLB71amtmgnrkBSfdwSebhSjlbgfSQ0BYNt7KB7BiFAVXsE9cx/TdIrGAAYgfXDzpWDSJV9Vnx6tb6Zpeo/DPf+PPjdvaTiCqx398AI6papmKBtgmVgH0D+yaM0JgXohWpoc2MCp8cYAmCu2U+EEr132h/oPFVPeHEs2ndAfg+Ng6BhznSiogCTSsB3cQsAM1dDhlb7ynwOaC2vc3LdSjSGaiE+BzjueD86G1pR9udpkB4yt9C/xG9LSNuJ99U3Sb30B9cH8fKSryvkPLzz3GkbobLT0mQlsV+cZTWaGWfpyTkfGHvK6Hi6AooOx5tNxuRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CgqwnR4FMrQhyKZFpU5rMlvVotSXk9FY3BG6sbl8Gs=;
 b=IU7E83QoDY98aQ98sJCU7b7iU5Ln1n94pbJfDQ87oXxfq2ojk/K2nWPaYXKAm34mo3ULpeO0xRSebABB3O0Bhqkiyl3weTE7uL/5fTfRLxGUj7z5FkwTTSov9UhMnC9O5bs8xlucUuOmDa3zID69YFkDXJoAmYfnjKo0kOHrz/UWAabB+JaR1wTPFcPuHIUVUtiOGUaDbIhvTKYv4UhSqBUJwOg2gGgOAD/hG/1XkDos12ofsw7yD9MAz2h7uShOmHdZ15RZc3ZsJsoN3LTCHU4jkj2FJcIhPWBayXsLH0GbY/CdFmCDPxBCobkf8z9dfNCz9+c/nos8+xkbpo0Wfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
Received: from TYCPR01MB10778.jpnprd01.prod.outlook.com
 (2603:1096:400:296::14) by TYAPR01MB5449.jpnprd01.prod.outlook.com
 (2603:1096:404:8038::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:39:47 +0000
Received: from TYCPR01MB10778.jpnprd01.prod.outlook.com
 ([fe80::e9e3:6314:b225:94ce]) by TYCPR01MB10778.jpnprd01.prod.outlook.com
 ([fe80::e9e3:6314:b225:94ce%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:39:47 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: balbi@kernel.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Norihiko.Hama@alpsalpine.com
Subject: [PATCH] usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error
Date: Mon, 25 Mar 2024 18:45:43 +0900
Message-Id: <20240325094543.5362-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:404:28::30) To TYCPR01MB10778.jpnprd01.prod.outlook.com
 (2603:1096:400:296::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10778:EE_|TYAPR01MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfd038c-729f-42c3-b9a0-08dc4caf8295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJ2y3g18ze4MNWBlKrm3xw1WXAbnIDRdC6dTnI4JR9wEicZ9Rvx+9IEVK+s3uot14C5MuyNhUEwLwdzxHxnP2iW/N2W57Wmm2n/A61JyxnAaXwcysYN3mE6sKS2MUQ0HnrOi1tGKV75gJiBZ0y8iay8dMrCgp61bqvGu4bMx2eRthSUV2v9j9/3YpGW9L7OPXtRrP/lv6npAg4FI0lkn8W2wmW94bsR8XPWRlUBWcCIP+E+dQCF3jK3yjcfgy4Ma3uDSH/yPNN+DOiPfg2xWIMQvmpXxQOxKRhVG9ugFcKymHlXJmbPn0mPUI5TqbYi4WI/zOisvBFO6i6zX9twSI4FyeF1iR0g4t8HGSksQjKagqNGsUAT7/0cjSw6iuoDIwZ7tjpKNkbT4KVEUmrHMksYUsVarq+9hegz/4yj5aCFkDzckkjNghGBfrrKO+ANuacuvUK+Mm44YYolf3iKFX9pHrJcpK66JJ1Po/LgdKIjAdbYs1fhDSWkGxcIcslLOP/BMqo8A0nh5sB11VU5PfOk3qsELp3Tmz57dNcK5LS0xJ0181n/mRfDIG+uqh0Ob1/kG+li1MHSZrYdNYu2zAOfE4yN2v6tgy2wuQBmdGtrpMbs2USiG3KkAjCqcDA1yDGQAavFpm9G96nRHTHyIZ+L8RA4bB1SlamhjV6AXTZoViXiHUCJFu1GiyvJFCos/ww+uDIB4ecxjGWjUH1nedg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10778.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+iSX7+d9sLN19CWRF05QkS5qRKqQjxDxTNC/eUsjYkXrqECeuVWvrJGiaDB?=
 =?us-ascii?Q?0k2hUBRc6SCnHvgaaa6LC6TuW2i5NPQiX6TwRyPNkLKTu1aY68/3VTWwZgUx?=
 =?us-ascii?Q?P5lxvS+Vqf0qGPmo+HtZ2KOS+ndMAP84jvHdXAsW01ZwHnV/qaEIUn32z6Jd?=
 =?us-ascii?Q?5OHsIERbBX0Li1lkpLiNY43YvaezPIQLOeJMsbwgh+YD6uo5jS4PhJJhbGLu?=
 =?us-ascii?Q?lkEfb91wvactPqgzIbvYYNfo6jOllvNVnAB3/tQ/hCujK+QogRqZ+JqOvhuW?=
 =?us-ascii?Q?L5t8e0T94nPihw6M9KWS5armNGDijQGCqAGuWmz00CDJ8dpoPrIeASezuJGW?=
 =?us-ascii?Q?/4FBBBIzCJKbeG8aGM74KAHsj4JKsHhOHtO+SJ8/NAA9Q/VbNABcEzbc4DsJ?=
 =?us-ascii?Q?2oE+WPa4liRT4njZpbt/x0TlUDsvzhR3b05duVSMS+qy9Hj1UU5BdZ9WtSm1?=
 =?us-ascii?Q?8Xi7HRsHaySsxQLStk9SCXdkPZci6r12Hzzkhs51DvIDME+rGZpEMPmPHFq8?=
 =?us-ascii?Q?6osdNFTvMSLGxFY09EnFQUykJLyxCQm4b7n507yZQbC6cXzzzI+AS9ag5yd7?=
 =?us-ascii?Q?wJjLsyiRaVR3rWBxSl+RiHsGRdmiPQpbqkfK8r2jbm6WQ9EJZATMMglp4dba?=
 =?us-ascii?Q?aDFjNzDtt2+pLL6FX0/Uq1w8WTkDlVl0das+l/KySgOiA4tpLKCMJNjw5jCe?=
 =?us-ascii?Q?WZg8Kbo1YzL+CIUr1mAgcKcCJZTwNwzBLPSwFmDwEABTcn9xJBigjlMEZaSE?=
 =?us-ascii?Q?Ds6O92XdSMF1AUDQSqFm7GvedGQTaM/0RWvMCyEu2G0Zpozxv3IrUn7j++Rq?=
 =?us-ascii?Q?Ui8KyBKZlL5EqZEVKtfh1aNdt34XK2hyPyvniYIVMKTANgwV/W/1g6MyHJ5a?=
 =?us-ascii?Q?xx0CuSE7G2gWyr8Yz48i2BfQSfmeKvdp7pl2+7UslPULJ0sjqBFFCdO/cACu?=
 =?us-ascii?Q?ZuU+rARBMndFf77MEb5nvScmFT2nq4AMmoiX72iSYnwMUyTnZyh3cARMa0tB?=
 =?us-ascii?Q?EnzLTeHm4aOTh7TFzhlx+kIVOdAkqdqhu1BOzqukl7cCl9AM9mloKa1lK/q1?=
 =?us-ascii?Q?CjH7DRsrhbY69OE83fIZvh0cImN75w0+zAmsfDAy/vfbw4M0hrYHXVv9MGUr?=
 =?us-ascii?Q?HEZ3/rAlqrVLpj83L4MDvp6obgLlbDkDzDDZBISktpd9JvaFiqCq0CcOUuMN?=
 =?us-ascii?Q?WcqOt8vHM9DtahK0Uw3TsjTmQjGf6zT01Hpbvz4Gz39cYJjDkgX7rTBxEuMA?=
 =?us-ascii?Q?cfFrDUzE575UEQt1vVElauIIaWbUQxwwrfHIxVYN5ayxzhSY4z7bnZXP4Ngx?=
 =?us-ascii?Q?9Lk9AZg+nP/JUc33ezoDp127Xwt8obNI4VyoJnH8oHJ8AdfO48a4L4KYE+ud?=
 =?us-ascii?Q?SdMfRNowYlol3Iv/uRuObrPm5ehxwNdUUCJYuMOVCb8dhPKMt0b2mFLW3eZv?=
 =?us-ascii?Q?l+dlUDgfbEdFVIp/DvAA08ntCLoedwfJYuEuwfbSWViJLNimpbC+sKhPjCOe?=
 =?us-ascii?Q?EXFlDMnAfxTUrxeSE2bMtjk6O6JoPVtYS+lKj/vRkgzZvPnsCu/ciA552y6z?=
 =?us-ascii?Q?hEQQFcV605SlZvTJcw1wFHFqvbIzL1aPP+SH3y3v?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfd038c-729f-42c3-b9a0-08dc4caf8295
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10778.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:39:47.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyLIuWQNECadacJG5/TjjM9aXLP0S6vNZeSiNFFMo0LmMyGnujTDUmxCF3gXV7HucoX608CaG3qe1JMH352XGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5449

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


