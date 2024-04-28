Return-Path: <linux-kernel+bounces-161438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9B8B4BFC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0049F1C20A99
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249466D1CE;
	Sun, 28 Apr 2024 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Zdc8RS37"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2014.outbound.protection.outlook.com [40.92.74.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584203A1DA;
	Sun, 28 Apr 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310996; cv=fail; b=guJ2O/KnvKkyXk0fgESCaSpZGASLgJIbQuXo1fFl21ZHwQ6n1p5DACNXH7eFqKacECYU69/xkiuwG17DWwKrcun5k4GYKR4/bnwqNwJHY45nYX4FcPv9v1Cx+Qh8g9lfunwX7Qb7RqnxxqsHQlIzUL//F/GFInI7lE9bkwZWP+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310996; c=relaxed/simple;
	bh=2GdtkHHfs3fQ7RyxlHn4MvnJa5Q3HyDRyxq83kBBU5c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yb+ayNmAU2Z1xZVB0eIUkHuuDjfxeAmrGzPtTZUP78v8z2z+1rjflryOlkeaRnj44YATVj4SDq6vrQTqnhHiYE/XcHrxZwiSCBqgzVHnSuvaDTZS6BThiOzMvVfCIQSthgzjplwDRYv5VGmWZ5L33F5XdBzBCrNCPJASGquJ90U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Zdc8RS37; arc=fail smtp.client-ip=40.92.74.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ5Jz9Cth8JdbWumcCHXW8igXf9zZwameAltdIduqCAInqU6UQmubHRzOQBba162SbBa4IBwzZT1JTqjPZElQefs1SdcF5fpDgyvEHslgdFLt2mVRUhI8r/9U45DcUtRlVNKqNC5n8cYQY8SiMIRrHM5qgsQbiLilequ4X+h4N348Aw7Dwad9YkIkhB84JHA6tgsuDOd5SqJ9Q30OA8zu+qwMJNvnB1DWsUKgUgVo2QpRQC2haEuMWLBBcKaaUeIzLKyg7ghioVkup0wC2J47YPWQawt+5Fk6e7Cj7jliMNmWfpiTJx4YkW/6Yeb/m6coSn4RfuoC0ABARzGprqIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9T3Nttw6v2pB7HfhuJuOBEYWpUI8RZlV2rDfkkEoJY=;
 b=R/g/E77YCT4uIxCSrQ2fL+n/bI96DB5xpP4saWtl0lhoa5iDysPbf0D3Ko6ixyjOL/W7aezE+LDh4u9igzwJLBuJ7J7IgWrAu00djBAhKF90B0RX/Nd26q8zUrpytJ8ei82lx5/qB8abo7NUid+yXRyj4f3s3u3vuGnO6Gc6oAWxcnu/3hLYUutZXBcQF/v41hXN5DEuAV6UR0IBisH3SMeKMY3SafQrb6+0pl40PTARVBJ64f6vCnmTjOpnBqTLBa6ZJYMrjdXoeryzl4/pRzZIv3p9SW83NqG+mqBztCCOuSgjiIgq3vDQxjU8jsQdMxOCRK4p84ng+6sYTDJzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9T3Nttw6v2pB7HfhuJuOBEYWpUI8RZlV2rDfkkEoJY=;
 b=Zdc8RS37hvQtGimxfyeB7fQUB8PTd19CCJNGYmukvt+tPggdMiSOghppiSwlacVaE+WGSNyZ3gqUSPX0BuqS5TAs6KcbxlEVSfs+zDfZANTYAhnNY6jKWiZ3+/NKzfEuu1z2+DYfgylGqR89nSms+gnxpSRAaFq9+Rha7BVEoq07l92zWWLUO34YxEY2CHZnWTWJHkCbRiWL3w6MKOlzZeAijPbx5gtcMGKj2CigKpBou0ToBpKem2oLhWlSDb+29UkwgtipdqO5INpRSKLdbok8jhWnl1JPGmgcEhJzpjTo3x90s18rUHnYD+pmVugdyY1kcBFEHjzxQiPUryo3Jg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5881.eurprd02.prod.outlook.com (2603:10a6:10:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 13:29:51 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 13:29:51 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erick Archer <erick.archer@outlook.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] tty: rfcomm: prefer struct_size over open coded arithmetic
Date: Sun, 28 Apr 2024 15:29:34 +0200
Message-ID:
 <AS8PR02MB723725E0069F7AE8F64E876E8B142@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8VR3A6dZ/Zsj5Bzsu8twxvGEjUH9I3wJ]
X-ClientProxiedBy: MA4P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::12) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240428132935.7030-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc2b8d6-612b-4473-bd15-08dc67874877
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	Y3foDXSVctMrVnFx0Y9YAcKO/4yvkGpf8dyhFBSYFdbyCRgaaI7mlkajAUNj2uvISKDn2bblkK82iJTqrCkHe+ypi/xoftUZztXA7k9Q5SpJimnkEvBtS8vRTN/5VPrvOPgeF/kjRVszsiKtihgMjZGu1rzgR2vk9lBcBNxk7LxNjrAagIhfHJidxfaUh+70hSMYbMw6k1AReL4bsu+y83uCHihj1Ew72k4PkDOHNSrUdfSuNhfz3yyX9prxr0B9Z3ttFVvpFbzKp0NvGgjbSfEjIFMOXE4PrqtxJIV5i7vWxAEO/0w0VLnyXc4F/nDXAv83Kl2TJJmbCd5sggOEoloPB7kjLLX4+JjxDkB40ohTR/LsVk+CelFXdXDjKvXXzAYHQYLxUpejBoTtEjJQq1G6ZyUINES6WP1Y3bli4QsK8BX6X6h7g9I3WIE1CHJE7yRQ5n75wJHZ72fhDQFIswQx+i1V4Io6RaFwhAz9RLjAHEpTfyXMdXwtWfnaY0rmEU5xpNF00kgatM4f/3GiKRVNgiOIjrLO9rZBeKsnF3C1ATlXKJwQFqordKukk3tgL70cPrjsGgprLlyi+etT9Vpxyt5BJ2kf28reShELtVPiCUQupxbf9nLvlRtJQx01gjkpPeZ3enQDIBQJK7Q7wxt4bZ5Bsd7M4arMuippwLsAZJXUyq/Uw1lSP2rdOJ52+ApYUJlw//0WOapM7zSEJA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IIyKyu0jI7GEp/QsFRaid2zvm2OcKj+h/1FO0JUExzI4gk3mAf49Hby3B649?=
 =?us-ascii?Q?cxxwCM0fBmdDJdoqXGrMjDRaHWGcgoU0+qV0wnJTszjStGGkFtcpU5GRqs2r?=
 =?us-ascii?Q?/qzXm710DLLUoJHI4ICWNKMdFD/UB47YFPdivO5ONGMrY1pwtFaf2zbOT67H?=
 =?us-ascii?Q?uaVA1WyuaNQqMOlQFMAFALWjIlcl0kWneFbxRKXOO3LSkFy5lwNlv581wFyQ?=
 =?us-ascii?Q?Js40HE0irWdVFywTi0chNZb8nUbFGdHjORUejXgE4/E5uhARU0jx/RAs6RL1?=
 =?us-ascii?Q?hhYsklvnoIITTUd6N5cp9nZWs7Qv50cEAfavM+xdLH7ItLmWDMMRQrDB0+rN?=
 =?us-ascii?Q?1rnXlg0fQLH2BQEXg9O1Gs+Ibq8L4n75/XDPka/C0BY6vwSUQH/JWX8/gWxr?=
 =?us-ascii?Q?EpO12/Uldbo5j9ZoCvGZnNo61SNmoeRBfDw+VZTdg+9vrXj690qBOf8LUFyO?=
 =?us-ascii?Q?iBcxpqGcXAArFyVLZm4/ZFl9PAzS+7744d0JvzG9gdawbiA2jlmG1nZSIzs8?=
 =?us-ascii?Q?PgeJvdaXIWYtkFag0/OwQcXpDbeB1kivAgQlRrfnQNFtrBvYXnNk8VWKTGSs?=
 =?us-ascii?Q?hpp0znjkI/GuHQcPtXJKSuMrs1fw1ty3m0IAJcaPOQCHj1Kw9afWfjfDcA/O?=
 =?us-ascii?Q?xA/MtplpiNAl1AXjatBH07bT8K6XhDQyrtQkH0/GcuQxf8Gs9e3CKIxuHi93?=
 =?us-ascii?Q?QJkqBcUXBU0PCPHCRCgwKJDMwbcuF8rk47oeJfUSPEyvJu0sKK3d0L4Uu54c?=
 =?us-ascii?Q?EEz1xV7ZVkzzHjea8noQM4XpDEiB5jH2G+egfa9WnT8CUojqrmxxvVdj8EoZ?=
 =?us-ascii?Q?zZDg3fdiPUOGK5n5dx+1pzKwj+aHCfORzHDyMlF/aRRXVpSA+hwyaZi/ATTu?=
 =?us-ascii?Q?xMcPNe1GBou3eHLOT+ycU1xvsJkJq6Fy5MX7Pfnv2CFT9mGDRKa0CiixYpEV?=
 =?us-ascii?Q?1ocaMdh/N0irs/rq2MHjgcCK/rVNtVfMBMuGkHMNEJyO5iAIosQRlOhcqiDY?=
 =?us-ascii?Q?agsue3Zsyz82ZNB024C2zGcdDOQCOE6hJsLU84HDHcwartLE+LRJr+cociNf?=
 =?us-ascii?Q?9Ghtir97Maz6i1kHFkyy6CG6GuEo8NoNzeLJb49fbBjhud6boLA1804pM4DO?=
 =?us-ascii?Q?u5pK6z1+xHzJf9werMsTDZyNsamH0YHhxysZxe6YXlpowVAv0Jm20KqxHE4N?=
 =?us-ascii?Q?X65ERSVkxCKog/BxpXVxjOD9ej4Mjz3p29dZpp0zjNCnGmoy22legTDWtOc7?=
 =?us-ascii?Q?uM55ksEOMFHBf7GZjXS7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc2b8d6-612b-4473-bd15-08dc67874877
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 13:29:51.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5881

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
this structure ends in a flexible array:

struct rfcomm_dev_list_req {
	[...]
	struct   rfcomm_dev_info dev_info[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc() and copy_to_user() functions.

At the same time remove the "size" variable as it is no longer needed.
This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Hi,

The Coccinelle script used to detect this code pattern is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1) + sizeof(t2) * i1;
..
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Regards,
Erick
---
 net/bluetooth/rfcomm/tty.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 69c75c041fe1..bdc64c8fb85b 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -504,7 +504,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	struct rfcomm_dev *dev;
 	struct rfcomm_dev_list_req *dl;
 	struct rfcomm_dev_info *di;
-	int n = 0, size, err;
+	int n = 0, err;
 	u16 dev_num;
 
 	BT_DBG("");
@@ -515,9 +515,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	if (!dev_num || dev_num > (PAGE_SIZE * 4) / sizeof(*di))
 		return -EINVAL;
 
-	size = sizeof(*dl) + dev_num * sizeof(*di);
-
-	dl = kzalloc(size, GFP_KERNEL);
+	dl = kzalloc(struct_size(dl, dev_info, dev_num), GFP_KERNEL);
 	if (!dl)
 		return -ENOMEM;
 
@@ -542,9 +540,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	mutex_unlock(&rfcomm_dev_lock);
 
 	dl->dev_num = n;
-	size = sizeof(*dl) + n * sizeof(*di);
-
-	err = copy_to_user(arg, dl, size);
+	err = copy_to_user(arg, dl, struct_size(dl, dev_info, n));
 	kfree(dl);
 
 	return err ? -EFAULT : 0;
-- 
2.25.1


