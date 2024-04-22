Return-Path: <linux-kernel+bounces-153147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388FA8ACA35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB131C210C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B413D8BA;
	Mon, 22 Apr 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f6cJkofO"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7C13C3F4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780388; cv=fail; b=u6Y+MgrR5rO0TQ9XCde3X3LMU5XLR307Arzl3OmjyD2gN6LBPmSW/1orgjysAUkfij9jQc3uGsnkILKsjLa7kSnHn3/Tn+royv30V4F4NkLLRSnnUmPmEQ8oGIDazrzR4t80XqlfsytFEjUQ7j1E+fUtxE/wcYcoEYDT6qILE3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780388; c=relaxed/simple;
	bh=zh8sgmiVYwsPHPzQ5BzKy0mT2GO6/gUNpR7OrkEKXmc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bEx6yOAA9aaAI0e4B03NLO6lCthP9Y1dv83JGXJDfAPuaS0uyFP/6PRA7p291ahp9w/wuwWrFDJ8NvJzVuMu98264f7nvBFDaSFY8q6w0lhesP2bIYnpCOqfbVsO9nyIq5yEhBEr3eOKuDWuVkFej2jggxwFbftxj07nG0M2EZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f6cJkofO; arc=fail smtp.client-ip=40.107.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjaQyNAMu7YoIl0iM4/mXCfpz/3HIJOfBdyueqXH1qmBFgnywoQvIffxjqlWYrJJ3UjuFbm/u7ZAXtgeiLh5pcAkQzpDyu5LoG87lfNfJzJwLJNQ3wf/zvjHOxXgNKy+e3AiQlN5TserxDoELrDA0lbkKnRQBkBC6ESPJv4pjmJKtmzUEwZflNKGl9NF//HZ6Gz5FgpMUvdM6ba1xYqU7U/fTy7hUWEQrnjkWwgVJA1DFakh4lLcA3TEd/gfOb/9ox2VhWO7AFPn1dy9ib6fwBFQUhs2CqfiaEvZjm3/F6R/1K+T5jUX71NDSUdOJ+Y+rMnozbY65BXsn+AeP5n5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihY3yBrqrqDnBnJCg28J+tIaZKQhbxqHnzslFW/KQOI=;
 b=mt4J+FklPgf3LqewaOD8BqktbwMPsR2N4P47mm7q3Od3au5QZkpw2/u5fGSX9pIYL8htypMHkp5ZGYrf8uviX5xWTOo1YDrZjWSytkGBZP9202D66a9qlvCr54x25DBwSc+DNjGkcsRS3e0JJ95nY+UBpYqCfFhqKnfJNQcc0sT/JKbi+2DWDBIJ6eo0gEan+NyXfxPWUu0cfgulZlkpLIm4fZv4spHNoVuqV0z1nWxMaoAq0lTobKeDdZAL1OXD3xaIZEHWvoAbH1ndRN9o5CuJcaCRSP3+Af+EJ9D7poFs+JTT9JNlyw0VmQdzPe3MkxgGxueAGre5jb8kF1qEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihY3yBrqrqDnBnJCg28J+tIaZKQhbxqHnzslFW/KQOI=;
 b=f6cJkofOzw5dMaqV81XHmuaefyxrcvJM37LMUB7HK1mFwaD+GoMpFGZErWhrSubJPUn7CrzPXLqlWKZy77dkuPX5vqs6m7I7RSBa++DubS/fCc3FYVVtkuR0R8zGF16X705+ONAZjEOqRJh3mJpB6cZl5fTYsVfT8UU7LcjtVC2pMsFxOCFmOPKUAgJ1sH+kUsmwDfqoDPXVk2MThZqyalhTFm+dMy43aKNfz+xR/HC4eqa36SfILz0HNCm46U81nVbDwmAd+pCWYVZLHmVv6wlv16BcB7VHM5ha0Wtr/D+0ptpHDrzqkcoTqmTSFofHHpuLT5oA4gxqgsj1G60tBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com (2603:1096:400:42a::11)
 by SI2PR06MB5116.apcprd06.prod.outlook.com (2603:1096:4:1ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:06:19 +0000
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::af33:ff9c:cf31:45e9]) by TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::af33:ff9c:cf31:45e9%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 10:06:19 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [RFC PATCH] dm: Avoid sending redundant empty flush bios to the same block device
Date: Mon, 22 Apr 2024 18:05:40 +0800
Message-Id: <20240422100540.2213-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To TYSPR06MB6411.apcprd06.prod.outlook.com
 (2603:1096:400:42a::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6411:EE_|SI2PR06MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5b6b13-9915-4321-e6aa-08dc62b3daf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9OpQw4Nu1jjrsAa7K+EB1CLU5519GwlsyXEfSJpdJy3BQ0FWgCe4NImXwgZ?=
 =?us-ascii?Q?R0wRTQkU7cY0pGVnsc3SzpidNJZz/SAJWKSy75w1FL/O5lEZyGB+6DPQHHZ/?=
 =?us-ascii?Q?0+R8Y9+Av6rugebokzNR2xGLtbv8L+Gga2RZ8MuRMnUwloUXMhj53lFzFlrG?=
 =?us-ascii?Q?f1Ql3ltLp4gl+dda1timFABmBGUzoMhR83Cfg1zM56Z0JF7U/AJxSUhHn5iN?=
 =?us-ascii?Q?FibgjoXJpGi53E2am/E+rYCzqq80/VeF11PgyWhCGAQrT4QftGzWK+XK/V8s?=
 =?us-ascii?Q?RSp22vCgeVzQjnqpSBc27l870c8Paw9HPj6TJiPCF1DHkLnKj3V3DVBmNyKa?=
 =?us-ascii?Q?Y65QHntJ8kSLmZ90sg/P9ExeUWSpmI6pCKjet+H/ny/hxi8CBq9bptzuruhu?=
 =?us-ascii?Q?JdYloi7zc31gCOW6z3EigeVBpa+OYri3thaXA+SEitHOGudf14+VLdI6BQ9e?=
 =?us-ascii?Q?040/2oW0IJDiZUXyWYxm/yijugzf7ZqCOpZDBmiSpboaWL7dw/lzVoKZsTHI?=
 =?us-ascii?Q?8n6dmkL9RW4M8t5T+25VURS/rVkSa8wQasN1ncDWk6zdOkH/TcsodNMfJJSM?=
 =?us-ascii?Q?FKXEdxexmX88ksJva+qoTOLIfGiegyy8pACmSAGCT9zceOjJ/Et4S/Fz1GN7?=
 =?us-ascii?Q?iognsE9bGKzF4Z3jwik/nGf/vJTQgFynn4R9l19E2LLk6Qy+mqRurfHl/oII?=
 =?us-ascii?Q?EEittmmL2Q/vbQ+sH+Y7nf4P9AWtC6qK4ej0qenfT0s8tPRoIVYPtWDqOfV0?=
 =?us-ascii?Q?JEv7Her2KZhgJx40PCM8AsFq7tAX0pThlHhKCjMLJIFdm0fxYiaM0059Tw33?=
 =?us-ascii?Q?WFN9E2A6jSaOaYDotk6p2fqCjznyL7tcA9N4icmj61htU4XLmcPI3Sd6iZFE?=
 =?us-ascii?Q?uJC9L+v2hnJGx2gIWSy9sI5cQQF7XfnvE4iQkJdIndSRPXjCtR2DIFtu7ziK?=
 =?us-ascii?Q?OdBizwv3UMYl4+wm1+Tw3o/m2zeWGa+oCJuMuMfdEdKjgL87lx3MzrJo4JJ4?=
 =?us-ascii?Q?tj7hMU3r1XY1e0fNabZ02yxFIel4O5YCCSRocdorxgDFMxP8+bL8vX8XIuoo?=
 =?us-ascii?Q?3j57zX3vp4rAshIi/0eMhlTdnrwtcuQb6lMk7C9m+o4FBJgljtYxjgwZthVg?=
 =?us-ascii?Q?z+sFa4m88x7ro9dvIdVsjbwqdJ7lDC3ZVe6iyqxadBjeTypEn8R5vYwn5qM2?=
 =?us-ascii?Q?a0E1IrCQ8LHnHywGPJR8ayJOVLMAnEJxifgWPYsCSMZBHeLevAbjvvFlrpJT?=
 =?us-ascii?Q?FALRRwjYjSmlXbkAa/YeSUXXtvN0qMyFyuq47ZXQ8ATzpEm1UcFqgZBDcT+Y?=
 =?us-ascii?Q?RfgV9jjVOz5osEXTV2Xl4CEVlmJERVwPOYRUQ3CQbxgZ3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6411.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtCXRhi1svph1waMulrcjRAdVoqDiyFA27Gqmgi4DStVDRt9Olw3VPqrtDnl?=
 =?us-ascii?Q?fAfqsohPEDENlFF2WZj201lkK0vhlbGiWtUi/2feHYabDa700L2FfeuZLR7W?=
 =?us-ascii?Q?+Fl/i51MNss2tEQhRYZYtFgfa5hJeDvUIPt85UQ8zHSUQpf6vz3Xr9K9AfzF?=
 =?us-ascii?Q?dOk3lsXptlrGZ/5a6DFnpxxQSUjJDgYAzgfQW7BN7qwxUTyNm7tsprSQ5Zng?=
 =?us-ascii?Q?gkC682PzTKgb3BhwbReEvylBoeu0qCcSjgmJ1G8OABI6XJ+JfymHOqF0SJlb?=
 =?us-ascii?Q?1FlfnhsgT28OOxzpS2ibjUOUcsDXZY7orXeckyHuBNZ2OTlfBY/1RIae4yYt?=
 =?us-ascii?Q?bpFx6L8ghLo4EK4mFFJN5IDSlMJx0kpS/etgvoLRr8SPUgTvVg96rM28L9eY?=
 =?us-ascii?Q?j8mAgzPJhnD2A9kw9PTet8ds3tqurcFZ6l2WjeJEu+x9wxMfI60uCfW46g5D?=
 =?us-ascii?Q?IA3HEl7t3CXuHiSWxZM7tOkRkvgYc6auaqXyuWaPycYtQg4i2MCpVVriTQfa?=
 =?us-ascii?Q?xeMf33TbbmJKgGvJfodD+Ju0T9xvz9KbLUR+URuXKORVpz8jGthZtjW4mvLj?=
 =?us-ascii?Q?zn5pUN9D1FbzoonuNYoIDNs8D27fUkos6M905xlmgU92ptkDccECLszP8w8P?=
 =?us-ascii?Q?py3QDk37XAWRsM/crdiiwjusGhMUuu+tGb9RE1B8LhRkvzRwzCWwHAzalsl8?=
 =?us-ascii?Q?TgB3j7HREZwRCTaa4u4qCMGGM2y4jMq70e5Bmu+MjudSltp6hRUsXSweSMsT?=
 =?us-ascii?Q?DNuJRjLL7KqCAypiM41sYVw4NKJvRGUYWvvPVZHX1mKbKtYCniYlu3TaYDko?=
 =?us-ascii?Q?jO6XMyMEv46Ex6ZmM2xL0pnsKdhQeL9lX16REUY6osXfd7GeAlxliZuq29Gy?=
 =?us-ascii?Q?QTPnOVUxz2aqdQgyRGKACYQS4DF0Rzdt6HwBb+SS7/aSj5M6tr/HukXHF1e3?=
 =?us-ascii?Q?C38YcnsvcW0Xe7BKOHdsPB1XR3PV6NSAoqAyzvS7gxGrpO4kMStBKdDsW1Cs?=
 =?us-ascii?Q?7Hy9M24U63hNCRUFcEgfazUXdeCdy9HiaTlsi3I3J8wcGMwNF15Eu9bFURKy?=
 =?us-ascii?Q?k7djhUDWbMTW4e/r20EunILrYrV4Z4M9uJp1vOdK2QsCOqZdSbsD7rPJQTt5?=
 =?us-ascii?Q?Z7h4D4x7njDrEDBIgV3U567OeK0GL0JAX/1nM4unWBzhu5V4ocLNjr06GYgJ?=
 =?us-ascii?Q?Y7e3b2pG05xPyntClgGcThCGHy/cVr/+zKhRjtwk2dqN+fdWye8kXEt8PqvS?=
 =?us-ascii?Q?RMvtWNjP3dA6hOUk+G/aCxGQwlz7/7i2L1Q8ljQXaU4+rfSAQU/zd2VJXHDe?=
 =?us-ascii?Q?bvg9mqsDp5eBgsvlle1XRL/eR5t9PZLbWdtYBGmQe6NN6NgGvGDmrBhJ6Nk3?=
 =?us-ascii?Q?vJB9+XWwOiosGFiOxShQy/2kwNZhqdzB4fgftdetI2WNyadBZJoeggosXKiY?=
 =?us-ascii?Q?qV5AT+Mj4QonQDoyRZiliUuzW7kdQ0w1fPjURbm22qY6Kbb9BzQo7RA0e0UY?=
 =?us-ascii?Q?ePdzq2LAFr9UJS7LY7tfFSKxKvCmPFJUOV1ajl+xNpEOW8LS1u+XGLZNZ851?=
 =?us-ascii?Q?kxTXIw1Tn8WyHYfTXwItt8OvOCB4I98LgfWy3oxJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5b6b13-9915-4321-e6aa-08dc62b3daf1
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6411.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 10:06:19.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4rCr9U+c9Y65GdfysmbIH5kEyp39oHTW+s1GG8ocWxAvLUTtf8FfrpUsJVoLUL7yp/2883GHZ6K1vIe40bmBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5116

__send_empty_flush() sends empty flush bios to every target in the
dm_table. However, if the num_targets exceeds the number of block
devices in the dm_table's device list, it could lead to multiple
invocations of __send_duplicate_bios() for the same block device.
Typically, a single thread sending numerous empty flush bios to one
block device is redundant, as these bios are likely to be merged by the
flush state machine. In scenarios where num_targets significantly
outweighs the number of block devices, such behavior may result in a
noteworthy decrease in performance.

This issue can be reproduced using this command line:
  for i in {0..1023}; do
    echo $((8000*$i)) 8000 linear /dev/sda2 $((16384*$i))
  done | dmsetup create example

With this fix, a random write with fsync workload executed with the
following fio command:

  fio --group_reporting --name=benchmark --filename=/dev/mapper/example \
      --ioengine=sync --invalidate=1 --numjobs=16 --rw=randwrite \
      --blocksize=4k --size=2G --time_based --runtime=30 --fdatasync=1

results in an increase from 857 KB/s to 30.8 MB/s of the write
throughput (3580% increase).

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 drivers/md/dm-core.h          |  1 +
 drivers/md/dm-table.c         |  7 +++++
 drivers/md/dm.c               | 59 +++++++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  6 ++++
 4 files changed, 73 insertions(+)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index e6757a30dcca..7e3f2168289f 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -217,6 +217,7 @@ struct dm_table {
 	/* a list of devices used by this table */
 	struct list_head devices;
 	struct rw_semaphore devices_lock;
+	unsigned short num_devices;
 
 	/* events get handed up using this callback */
 	void (*event_fn)(void *data);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 41f1d731ae5a..ddc60e498afb 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -2133,6 +2133,8 @@ void dm_table_postsuspend_targets(struct dm_table *t)
 
 int dm_table_resume_targets(struct dm_table *t)
 {
+	struct list_head *devices = dm_table_get_devices(t);
+	struct dm_dev_internal *dd;
 	unsigned int i;
 	int r = 0;
 
@@ -2159,6 +2161,11 @@ int dm_table_resume_targets(struct dm_table *t)
 			ti->type->resume(ti);
 	}
 
+	t->num_devices = 0;
+
+	list_for_each_entry(dd, devices, list)
+		dd->dm_dev->index = ++(t->num_devices);
+
 	return 0;
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..7297235291f6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -48,6 +48,8 @@
  */
 #define REQ_DM_POLL_LIST	REQ_DRV
 
+#define DM_MAX_TABLE_DEVICES	1024
+
 static const char *_name = DM_NAME;
 
 static unsigned int major;
@@ -1543,10 +1545,38 @@ static unsigned int __send_duplicate_bios(struct clone_info *ci, struct dm_targe
 	return ret;
 }
 
+static inline bool has_redundant_flush(struct dm_table *t,
+		unsigned long **bitmap)
+{
+	if (t->num_devices < t->num_targets) {
+		/* Add a limit here to prevent excessive memory usage for bitmaps */
+		if (t->num_devices >= DM_MAX_TABLE_DEVICES)
+			return false;
+
+		/* dm_dev's index starts from 1, so need plus 1 here */
+		*bitmap = bitmap_zalloc(t->num_devices + 1, GFP_KERNEL);
+		if (*bitmap)
+			return true;
+	}
+
+	return false;
+}
+
+static int dm_get_dev_index(struct dm_target *ti, struct dm_dev *dev,
+				     sector_t start, sector_t len, void *data)
+{
+	unsigned short *index = data;
+	*index = dev->index;
+	return 0;
+}
+
 static void __send_empty_flush(struct clone_info *ci)
 {
 	struct dm_table *t = ci->map;
 	struct bio flush_bio;
+	unsigned long *handled_map;
+	unsigned int nr_handled = 0;
+	bool check = has_redundant_flush(t, &handled_map);
 
 	/*
 	 * Use an on-stack bio for this, it's safe since we don't
@@ -1562,17 +1592,46 @@ static void __send_empty_flush(struct clone_info *ci)
 
 	for (unsigned int i = 0; i < t->num_targets; i++) {
 		unsigned int bios;
+		unsigned short index = 0;
 		struct dm_target *ti = dm_table_get_target(t, i);
 
 		if (unlikely(ti->num_flush_bios == 0))
 			continue;
 
+		/*
+		 * If the num_targets is greater than the number of block devices
+		 * in the dm_table's devices list, __send_empty_flush() might
+		 * invoke __send_duplicate_bios() multiple times for the same
+		 * block device. This could lead to a substantial decrease in
+		 * performance when num_targets significantly exceeds the number
+		 * of block devices.
+		 * Ensure that __send_duplicate_bios() is only called once for
+		 * each block device.
+		 */
+		if (check) {
+			if (nr_handled == t->num_devices)
+				break;
+
+			if (ti->type->iterate_devices)
+				ti->type->iterate_devices(ti, dm_get_dev_index, &index);
+
+			if (index > 0) {
+				if (__test_and_set_bit(index, handled_map))
+					continue;
+				else
+					nr_handled++;
+			}
+		}
+
 		atomic_add(ti->num_flush_bios, &ci->io->io_count);
 		bios = __send_duplicate_bios(ci, ti, ti->num_flush_bios,
 					     NULL, GFP_NOWAIT);
 		atomic_sub(ti->num_flush_bios - bios, &ci->io->io_count);
 	}
 
+	if (check)
+		bitmap_free(handled_map);
+
 	/*
 	 * alloc_io() takes one extra reference for submission, so the
 	 * reference won't reach 0 without the following subtraction
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 82b2195efaca..4a54b4f0a609 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -169,6 +169,12 @@ struct dm_dev {
 	struct dax_device *dax_dev;
 	blk_mode_t mode;
 	char name[16];
+
+	/*
+	 * sequential number for each dm_dev in dm_table's devices list,
+	 * start from 1
+	 */
+	unsigned short index;
 };
 
 /*
-- 
2.34.1


