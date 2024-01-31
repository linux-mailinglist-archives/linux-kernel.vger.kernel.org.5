Return-Path: <linux-kernel+bounces-45588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089978432C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30C7283704
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67C4C65;
	Wed, 31 Jan 2024 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="QTDLVta5"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2119.outbound.protection.outlook.com [40.107.129.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFB1368;
	Wed, 31 Jan 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664661; cv=fail; b=E4bSpSFuQprpFtJvvZK1872tAw6GdNNZ59ofOK/bLE7zbAoJ9r9vec2Q8HNq5HpXf8xwTK6wWgU6nSADp0jzhOjPMRYPntTJjox3CzIKL2JBrSXMe3OZanESlLB3LG+Z6GDaD5kAjjprhjxGFpZTO4pA1NWtl08etA0GyacvLNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664661; c=relaxed/simple;
	bh=dvjlxHc+TLAFfBTU97E9XN48DmBxh0X2VNddnOx3ADE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FPKtJn/eTdBkAaWCqUc22diykNieHKWoYbv+WDZNf0KlQfgUCeWNKNipgMvyvpAX2gniSxlH5CtxiNGOratN5ogKB5WTQ/7DrlFDCvE9ErJlkS/nbkyfleI1wSbW3brGq+gjqM5wF8MvdSjPzKSjSEuvUL+o8wevf6BgSKohTB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=QTDLVta5; arc=fail smtp.client-ip=40.107.129.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKDTowDEk03AtrruW6Oa3SgK31m40zOaIuBOHPGu7tevkOD14OzdRCUwvVKpbv/4vjGxnUsCbupvFrhs6nf0aKCcLQHmORMgdY3iHfceNvasBr2zyS4Yrr3LCH3sSi+UcE3GCfLwrMcHjhcM6K5vpzitjyjRqjmMk3tgCKihO6H40dAX3foHEtlbFhDKaABnE/FYoV/kgX3RtHcaqMkzjXtADAdxmd3CkQMGL8r3t3CsJ9fkxiOZlCXQNYzR3ep7krDrDVird2GzSq39AwYyQ32rbn5x/NdepDCplzNVt9M5Gk6w2xT7HATOKE/e1mh1kvhrA7Rw4gDirLiNqxVDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQq1t6K1bEhEniYP01XdbZ48GmDO8XHdRZNYC7vi9p4=;
 b=icHem+mIi0kQ7X9urcIYrFYnjvv+m2TjsKbHMyyO/s9OlkXBzdOnUBvr36YvVx3vo393bQ5ZFrcsWUScFUv2pnfMtzYNxUC833PQzK82OXkLfbTf84tQr6kF+uLq+XM4CIdKq7Q7KBUZAHouywRui96Pi7zLNQNzoZ0odllQCGXGzotzWvYqIUE9rzn13vgMS7wEiw5hCdPq+PrXh7PnQhyplBB6ALUwSNicxlZEbLIdtGx7GqlitmThNsj4R5a6D6Js955Q+t2aIjNNZXoOtVs+iX3U2ks0PG6U/SFLO4oIfOBNcOS0D6l1Nbtdbc/hcpz+z/3gCU704LgfOrZ+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQq1t6K1bEhEniYP01XdbZ48GmDO8XHdRZNYC7vi9p4=;
 b=QTDLVta5yIV1yd2ModaATjMFgTgJDKyPm/7J10sLDqW4KHjcfHyvkHZOE2UV8TIK+Wm4RCsrKVoHuRqruIjG/YuB5ylLMliBozgMhiEGimmRnsX8egdAfeogAhv+ujdSFzoosbgGw+pusgOiCGNmXFsGaCKzA4twR9n49qj6Ttk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB2229.KORP216.PROD.OUTLOOK.COM (2603:1096:301:131::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 01:30:54 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 01:30:54 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nas.chung@chipsnmedia.com
Cc: jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com
Subject: [RESEND PATCH v0 0/5] wave5 codec driver
Date: Wed, 31 Jan 2024 10:30:41 +0900
Message-Id: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0224.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::12) To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|PU4P216MB2229:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b23bf3-045b-42a0-d4f8-08dc21fc4442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YFg93oYNGqKJZCGHsTsEoK37Wd38Qp785cLFAojFr7LTTg3rHyDVyz7qnQVjsogL3/AzFcRxqyHavmXnTTE8mRyehV94ItNaJX+0lnHDv7BenQUa5C7PPySqcIIneOLKxO5DZHGFuGmrGktoJxKFo4X+iAcNrfXIw56l5D54yB+Eg8fYVr34VJQos29+FZASUvnsobPXZ3sfxLxAD3rY7Bwsufkt3saJa98cEEsCD7Af5Y5rK5KuL7B4nX5G0ihOyXf36uPxIABUN1KV12/Bly2n8aBvnXLkjN7PW1DxZVxZ/gtyfStwK4tdROHOXq3owDB3z5R6LXvrN4pGqVoRMQefz+wc9bagSMThI+j7aslPKIOg3QySO1Q6HAZNSXWDjg7iP5A0ggLircFFIGXcvOexX902nw5XpfS3mjlgFXB+7N/SWmO5vVDYSlY8m0ETf2c+x/WMrT015BB8ld7uQpEtr06lKh2/QKEQ9wFDil2qwh9ztWDLAjRbpeG1pSA28x6thI5iOMIFoGcSrsKYSV7FmhiuYnbYSQ2AjwwJsCOkiky6AcVK5HUP17h5ZwkTSyIYcoefARwnLOAEnG4xnIlpFQDWJpvhkDfAc35UakSmUnWbk/2wUVY2jviVjO/M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(6666004)(52116002)(2616005)(6506007)(316002)(6486002)(478600001)(86362001)(6636002)(66946007)(66556008)(66476007)(41300700001)(26005)(6512007)(1076003)(5660300002)(8936002)(4326008)(8676002)(38100700002)(4744005)(2906002)(38350700005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mX2y62NVnzUSx6WKa6bkgivjVyh95igvDPTXPJqjnbiYiDuN7Ob4NATffItO?=
 =?us-ascii?Q?7ENK0KVUJIZoD7HfALfhVMya9URTZmOA4bb3xWlZiz5tOJataQZuHyJOEOd7?=
 =?us-ascii?Q?TpXGxPybcblEY1ydjJAldTRo2jTTLFlYTQitS1uRgkY+cmMWsv/Vs4qnS+7y?=
 =?us-ascii?Q?79mp8dx9iB7wap9lUZHSkqgI7wB3NKlSXCg7bG1sW6DE+TqIA1COaMg8D4I4?=
 =?us-ascii?Q?KdUNIcf84UAjjSKOcz5Y+apqvv7VwPFc+Tk4Xeo17VA1QVk7RN2ot63vueZW?=
 =?us-ascii?Q?Ore4yw09aLoGygZIzRZR4TJudp+CADzmVZcdTXU+j6vGYOXPLdZEF2f6sFCe?=
 =?us-ascii?Q?NDp2e3vu8gDgc/gcLO3GeIHVCuHF5xIq3FvRLbgKwKmyY6AahiIFTEsi0EQN?=
 =?us-ascii?Q?dPYorfvncXTL6/8MCIlgp8ic4DVDLKQikREVHGch6Q7zeyyU1nbjJJAsph4l?=
 =?us-ascii?Q?S2IwdmKK/UHVVj0+A3YXItAqEhHGiL061/XHpowykL/oIuesauF1NiHuSDwQ?=
 =?us-ascii?Q?AN5VLKF5l1J3XgqIhE2e3nmrG/5qzkP+vFhpanW5ZdEeCrVfDDRXoO02fI9s?=
 =?us-ascii?Q?ymyjoB50LjSYcqIvNRoSQhb+NwEWDymk7xg/x969OFctaRCIWve9Jf6eEs1H?=
 =?us-ascii?Q?sOGN/pIlNPvSXhRri7uXtrgUSdN/iQaGldkn335o5Z7LmSa4n0Mvf+j56K44?=
 =?us-ascii?Q?U5LRzW1WcQu/LncfAwL8RGg6wT0e5LOnA0jP/cfWEaFiyi0ooJnLeic8ZaAU?=
 =?us-ascii?Q?zKZgcj42EWfUMh9oO0kCk2bygvTj6pz7JnDXj3S4ulqWc0TTGETNoLBIGFiF?=
 =?us-ascii?Q?Tcr635f/1KiSEroOTm96Pof7iMctMLaGQ9xR8cVZPvl3NIt1t1PNdD+937QY?=
 =?us-ascii?Q?48Y+tIqktb5YrPqQ6fRDkLGQmBD+yvNGBWBadYie05XVCM1fdt4n6We81iO1?=
 =?us-ascii?Q?+VjDbriVmx9KPMdD7eVOlZRISxoXQK511Y/pqa6siV+UCp1D7qO6SSZNz7tg?=
 =?us-ascii?Q?BCrVZOYwTQlFC6RKRXW/PvLZRsVNmxtl9+Fhg2u5tuFVkdM184oNKM97bafl?=
 =?us-ascii?Q?d7rmduj4HgF65pA+P9bBOn7wiER15rW+u8tGkQYdDHkHBMKKU5r+qvd4YQyd?=
 =?us-ascii?Q?4D5V9u24e1zVPOAoZrXzhb+AWNjrHMUlMGeyJPflHLWtwz4Q8ZcR6iPRktQW?=
 =?us-ascii?Q?tJfjeHJslX8eCrHFet4VbRTdtQVEJoCCtXTsXfOXonFVTkuY6n5jcGlEYhhW?=
 =?us-ascii?Q?v6m9otiM7LdXjwqBqGGm4oHa/vx3JG0qrhnaPd4WXMO9jCky6J4RdCWm6xIR?=
 =?us-ascii?Q?VFh/xvEYItHBp+7dVMbBQV14xP8Ou5WPtbP5uS4EZxiK74xZq736bHVSe9WL?=
 =?us-ascii?Q?Xx8zBWlSQrTgQewifEkrXbni/X3difv4uFl4k3wbsFmufJvO7B2lgv9Ggdcy?=
 =?us-ascii?Q?Hn8BuL7aGwQN7ad8quS5xW253eH6NFOXxvFLaDBQwqHLRIrpugmOB202Ao7p?=
 =?us-ascii?Q?9cSFjcfDWSbi5I175mmfz1hYVb5gIa6SpW9wM2pbWmR450eGJo5T7K61kzyT?=
 =?us-ascii?Q?U9QBuffeU24243xN94HyQSiu5luwFCexsBmuQX4mpYki6ojLOKbn5iWeiMNs?=
 =?us-ascii?Q?fEd77y+8hNi9XSHCVBZtFPw=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b23bf3-045b-42a0-d4f8-08dc21fc4442
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:30:54.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BehKJTkECIWRwsY+ssC+DJBCbaX5QscmNX/7L1+tjSpaW9rNHN1bNYUalOBSzHn2548L9vw+xzdlcP3GIy011Bt+ljcUCu0PomQhlBDQxBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2229

The wave5 codec driver is a stateful encoder/decoder.
The following patches is for supporting yuv422 inpuy format, supporting
runtime suspend/resume feature and extra things.

jackson.lee (5):
  wave5 : Support yuv422 input format for encoder.
  wave5: Support to prepend sps/pps to IDR frame.
  wave5 : Support runtime suspend/resume.
  wave5: Use the bitstream buffer size from host.
  wave5 : Fixed the wrong buffer size formula.

 .../platform/chips-media/wave5/wave5-hw.c     |  11 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  86 ++++------
 .../chips-media/wave5/wave5-vpu-enc.c         | 159 +++++++++++++++---
 .../platform/chips-media/wave5/wave5-vpu.c    |  68 ++++++++
 .../platform/chips-media/wave5/wave5-vpuapi.c |   7 +
 .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
 .../media/platform/chips-media/wave5/wave5.h  |   3 +
 7 files changed, 255 insertions(+), 80 deletions(-)

-- 
2.43.0


