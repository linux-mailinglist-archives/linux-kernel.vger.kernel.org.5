Return-Path: <linux-kernel+bounces-40083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7283D9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303E028733C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA014AA8;
	Fri, 26 Jan 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b="RqOCDLfX"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2130.outbound.protection.outlook.com [40.107.128.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7A79DE;
	Fri, 26 Jan 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270605; cv=fail; b=OBWNFr0NkjDEhHE95qwkczq7msfG1k/WLtY8Ge9cqtAv9goRqql/fEqGxw7t8shNBasb/FrSvp2y/63pstfBF5CQe2CzTzOS3ZJNO8OTKUkya+HKe8/9VyvooMXaGMWGDx1T4sdI19hBwFafAc20QsMSipl3LoxJmWTeO5GrF0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270605; c=relaxed/simple;
	bh=t3fmPGtWTnmgNVyP7cY7pXcwm9tX73iLrPoNmVCAnps=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ib6f3iJho1hePUXbnx7BLuItHPbPx8k6hTUPFYctxakgQfBe6Hwz2FGNb9YhJ7Y/CwOXa1f13ag8I9bB/C0rRGbVcgGUansqX4WzjXqkF2GxI4ep/EzDvz1j9NRzxaIiPUYRiA5dvsv++I372AVf4OppXMq8Guv5XoG61KLMUas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr; spf=pass smtp.mailfrom=unist.ac.kr; dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b=RqOCDLfX; arc=fail smtp.client-ip=40.107.128.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unist.ac.kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3qDlNmGlRNEeFpmiTt2aOHE+PhtBUxgWkMZNorVgCGXvLLdHYvcrdAG6ebynUCOyxQ4JOQXiM04CT0QM/U7TmrKDV9Ng/bP5i6Tkq3a2irDn4z4S37wyEfi796eo/WC7du1wUYPEjF9UKoxZrDzIX55U1baYm/kmlThdGw81gClWvSMIK6SSf40gcl3UYP3XVZWQDzgLXJhp5ZB3vRhJ4jM1oOTMmG/JCRA/aH4Fa2qFnoG975RTUCi/2zNG2Xulwyl7X4agQhuqaagpz22lfNpRKwOjzzxg+BCujKR63gziwJXRVc5yX2cYU831F8QfYpDfKGtnHE0GMEdeyFzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w66NWRxF274nb4CJq2SA93RsARYD1gmUj5JJgv4W7c=;
 b=G0iWWSMBQC05DVgHTtyqr48IPIaziklDn53LYOyBWUbkPwoQjLTItWPpPXhDdd4jePoHqHpZxFsk0LAcrj6M0T8RzCctDapisPVwgEpW16apXFaH/JmSSXWPvM8GUmIpmYdd4U2iqAh69Wff7EAPRrsarNZNwpVaRfLkRLvW44hr4BRk3JUs080vJaUCIEhPWVBoiJbwBMK+frkRjcsjF+hDjzwyA8k1pGYXX6Ul6HGUdjJQK7zYl4jskEvhKp6NS79ZsQG4op494c20ENwcBUYk8iHcTt3qEHHepPyc0JJTen3K2VOHv3QWm6u9tqjAFDBmOaaybz5RDvdlDloZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unist.ac.kr; dmarc=pass action=none header.from=unist.ac.kr;
 dkim=pass header.d=unist.ac.kr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w66NWRxF274nb4CJq2SA93RsARYD1gmUj5JJgv4W7c=;
 b=RqOCDLfXzIYszpsol5Pcq/OHcBZaM2AGCaKdo8V/QWRIr0llFgiSz77EdqPXLSadQtbQWwn8ETKLIBPfmfm7stM7zQMzpW0lJlCf5z335i/7Ujcf6/BzH/4vj9rED4gFOC7h6mUZXoCfxosq5asecnsmAPSMBw1siBv4pzum+MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unist.ac.kr;
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15d::5)
 by SE1P216MB2406.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Fri, 26 Jan
 2024 12:03:20 +0000
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c]) by SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 12:03:20 +0000
From: Ingyu Jang <ingyujang25@unist.ac.kr>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ysjeon@unist.ac.kr
Subject: [PATCH] Remove redundant check for usb_generic_driver_probe()
Date: Fri, 26 Jan 2024 21:03:13 +0900
Message-Id: <20240126120313.1362573-1-ingyujang25@unist.ac.kr>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0055.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::12) To SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB2287:EE_|SE1P216MB2406:EE_
X-MS-Office365-Filtering-Correlation-Id: eeefe447-3093-4ca0-c249-08dc1e66c9c8
X-LD-Processed: e8715ec0-6179-432a-a864-54ea4008adc2,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C/CVan7/VurcuihdYG5xTdNF6SxGWpsylgz1+b/xzB0OnM6bMzB9EHgPhftsMysVzSZkroGu2KurlW6z5YMkDE5lOtPAvcyEOyYL9VgMwo7bH3diiIDFL9uGJXaj1d5dLMvULzPQvmzZtKIYUXwaL9E7Sld5smtUybLE2kNP/HJwadil95J/ooEiW/oV5K2XttB7GYpv2TkbsSWNR3XMPQoydS5uW78aAfVhTZutt8PuPAdCV5n+R3Ve3yfGvLWmW1ZxasUZLGvdZqKGAOyFmNNRMs6UlLBwTM+4fO5PvWPEPtNYE/J3kOL0fhyV2EgY27Xir/g4o+saPYulCWh+9aDKiIN1z13nVfNJElBbB1BN1wLfYb5OOprMi7J73KQjEWdpjwuaDh9/2brU3hPz04MPb+zvvsJj/5sgiAsmiwjC0qn5g58mJhLVRf4diQ2TiH0kCe1xvUHuqUJ0NmhzmQj04dzbLExCgiukfAEW79HEWhCf1lQR9syhs9slBny4b4aLGT5SyLVX5FtTj4t5Nt6OOG7W3Z+G5aT5szbYELdNyG/ylzXYMMDZ4ZZzGM4rJ6LEztsvWuxDchDdYKxUgMs7YCzUJsjaY2JJChd4E0kZr2AONQojWH2/8Y8xkrY4Wd/2RDzBPRG+ejqGrCQWBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2287.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(52116002)(6506007)(6666004)(2616005)(1076003)(6512007)(107886003)(86362001)(26005)(478600001)(6486002)(66476007)(66556008)(66946007)(316002)(786003)(6916009)(4326008)(8676002)(8936002)(83380400001)(41320700001)(36756003)(41300700001)(38350700005)(5660300002)(4744005)(2906002)(38100700002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3F/3PZLIAO8QDbY12Fw6DCW4f1TnpVSq8BZJsTKGv13yY84yma0ZAkGEGPaD?=
 =?us-ascii?Q?vW+rbOx8HH9ZUlMzfPrqX7qmH6g3as9zi4w6bW4YTwcW32jCCz/9fxfKCzdv?=
 =?us-ascii?Q?KMJIVQE5Z9a+5QmjvnRj5NG1wdWThgHinMKwLc2ltp+tWByhQH9wwyQiFkQ0?=
 =?us-ascii?Q?F/oGKR8zuIEjwXYvXHO4ZGqxjT4whS+3v5XiPwcCeAX8+IV5z94u8jj1rVcQ?=
 =?us-ascii?Q?LXqebcRh2PNc9SWeesIXxtyiEvJQgAjljKbTr0mMsK3eE/kBvEWEPahSqWao?=
 =?us-ascii?Q?79c8toscvp3hrPNf9zO3MX4NiGVk3HzkYYx6zvVjkJGUdHhCrIYWnAIO1SAD?=
 =?us-ascii?Q?BBvsrWyl86JjpUd3ihMOMnLWe4u01t6Whyq5WtP/TxadXjmxrCAahirprdNG?=
 =?us-ascii?Q?V/f7N2OueJ1owayj9lF8hkstpJITI8eEomwqGvWub4fDhTyg+dS/h861bXgO?=
 =?us-ascii?Q?sM3X4aZe0uYzdM+XGnejU0PbeTb0C7E+KLDKpnmYZJnzI3DbRRNV/s2hBQdk?=
 =?us-ascii?Q?/cJIchuxO8ZmVtEQVDq4MS0XUzxwHkfE3c0TsP3RBdYmiP6kOg7WrZl+f275?=
 =?us-ascii?Q?TORBFHdy0OOoWQDJDNw6oBmI1ND2Z9A8kHkeS1U6aucs9Q0irEZL1lwNNfL0?=
 =?us-ascii?Q?DoqgRwYIxTjKpUiKGWg16z8cPJMYgcpUcSXdFn+Es4ztHoEXY3fduPsjoAvt?=
 =?us-ascii?Q?xpSSk0UVfjgQAumCEyk6ED4bZSHOLbQj9mVyzYc4L37ykjHO9xAN5LfU2671?=
 =?us-ascii?Q?BW8+NxcV/Gc98SYcytrp//SGz9Q0VrJ6/pUyVFtewbSRZJASqeBQWD+ZsMVY?=
 =?us-ascii?Q?0fbY3m5up/sPbUMhAQF1u9P9qU4PxViN+OH+Kcnp9yN1WYmDsSzIx23zCkDK?=
 =?us-ascii?Q?b3hRUVJwJGq/12EFtutv9h153ruXBFsvsYFy4mUS3gaeoK1sJ+T5gDcPS0Ng?=
 =?us-ascii?Q?GYtCckYB1ArnoUIkMvhfRDCnXn+KMPseQKegYR/EBQE6HNcNLFdBHMiQI658?=
 =?us-ascii?Q?kVXdSbMdhNaR2NTkvvRp1xizjcCEGrSYGZka7g6RJp6yO9VeXnvA+kJJ3/M1?=
 =?us-ascii?Q?Dhx+pG5hYkOkphS97/eTyNBM3OG1JkftTvop7iJ1i97dgARxPB7rDWbIM6Ws?=
 =?us-ascii?Q?EB4KRNGEiOdVo4v21HWCeydi1qcdPcqxvKqqsaHJwlqZB9TEbNuL6Zf/asJc?=
 =?us-ascii?Q?gcUYzVPJ3FDFobN6BpMyJspHUt/xLGnjyE90kqn2E+QRQjiQsL4qxNoAFHNz?=
 =?us-ascii?Q?fD7ZYY9y8PXx+HpLrX/WiOZTN0zkVAzJvE5HpaH07fhhEOM3OzSRjdwbbp6Z?=
 =?us-ascii?Q?ByxDqE2gfpwKPpGu9ATMY5LrBUvv+m2spuOI+Mw2WboKJOaMNL8gOfjG90hU?=
 =?us-ascii?Q?Caxgq0B5/UXmfbFvdBGXh7EKdL0oEuelS+fGUOUuTjkvAZPjqt4FbMwkRSBg?=
 =?us-ascii?Q?8HOn3kuxNsW5OdzHV2i9PYIA4R4FS1h5dqM0T1BZnd8cofrdswBlXGL3wPVr?=
 =?us-ascii?Q?8mnQ8y1vnQhJTkTupw0x/xkpVhq+P0iOjGK9Ita5iWaudQOAfqlbDkM+pu1F?=
 =?us-ascii?Q?te7WObqfmGWBHTE1IgiVppWRCKu218n7pe1k+BSs?=
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-Network-Message-Id: eeefe447-3093-4ca0-c249-08dc1e66c9c8
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 12:03:20.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFmYTdAvhlwf1BvpuWaSLEME955GeaIRyOMmP0tmkUYq8K8I617/MPqiz7wVLmorZmWyDM4lTx7uQn4xNuYimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2406

usb_generic_driver_probe() only returns 0.
Inside this function, there are only errors that are marked as not fatal.
However, drivers/usb/core/driver.c:269 checks
if usb_generic_driver_probe() returns error.
No need to change usb_generic_driver_probe() to return error,
only remove redundant error check.

Signed-off-by: Ingyu Jang <ingyujang25@unist.ac.kr>
---
 drivers/usb/core/driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e01b1913d02b..b6274580b7ca 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -266,8 +266,6 @@ static int usb_probe_device(struct device *dev)
 
 	if (udriver->generic_subclass)
 		error = usb_generic_driver_probe(udev);
-	if (error)
-		return error;
 
 	/* Probe the USB device with the driver in hand, but only
 	 * defer to a generic driver in case the current USB
-- 
2.34.1


