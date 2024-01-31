Return-Path: <linux-kernel+bounces-45591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF3B8432C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE35D1F212DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D7DF66;
	Wed, 31 Jan 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="P5YAZhTi"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2119.outbound.protection.outlook.com [40.107.129.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FC63B8;
	Wed, 31 Jan 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664667; cv=fail; b=E5yRBSVH5Jv2rj8tqhELJg5n/pZ0llFU5s9MyvciabnNchs4YafK7Eqd/N0ykrOcCsRtafS9EwuzmzEhGRDGkhX8eno3qr7Y4pD2beX+Llm44nYSBEbowFZIDHIPojk4kNR4Ea9dGAbQqP26tn0K3pJlYhFdgAxxrQbgXKB+T50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664667; c=relaxed/simple;
	bh=HJBC+Ltj4JnvFVCRHeP4aH4x9ZCZTgbdL5Aabjx6BCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rz114BJmMBMu8RrtW28tg+glDwtjVd2SO6V8pWoyFanbcm5etcPOldNelsmzWagSbg4YeDIeH6eSBUITvZcGowEven5N85xOYnOpFmMkBhidjxBgUYvck2FfqDkSMbR85NxoATdJ6C+4HiWYDMxXuqazsUqzKh13EvAvSZ4PzcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=P5YAZhTi; arc=fail smtp.client-ip=40.107.129.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSQ98H4Q/3xyN8M/oOdWuEFMjhwlmsN+qWQU6nnir4fFhSgJU281TvvLm04M/5Gt71SqZ0HJDEEDxUnAjfN9dA/qc5tt6mU05v+bvEkgFwlBtlknZq9Gr0thJ2mb6GOT9glVjNIDJRvt2WVeY/2lZsRBmtZ0QqnT3+RDpCkDoMGIR4Zck0teaeSdwLyQnMYBFUc04S5p5EEm8YSxX6RKFr0+MiZ4ShnI7zh7xW8ZaMaOKFMluhmD58lEoqyJghX9r1wK1St6UJhcWGHFkR0L+/Mv2ZyNYN93skSIBaLRKadOorP2i2sivxN92CCFepG9O5JDLyyDaZ8f3F3jzZiSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBgH4qo5F6ppw6ZGJiII4H63BwbU2A3PKynOtX8yMs8=;
 b=AFFHZOqMbuAT4ZaFKtfrUDrdCHDtfNu1cR78z5TTHDATzp9njONx7IcJoBkidCQtq9Zf+e1JUuGl6q2/X4mAQ7vtilPzY0whIVOK7+D2effA/o78u8ZGwde0sUtWGIe2ciAxTHF/PqsMg8YU8quWJ6QxXcEjRX5U5/KO2sC6TNT6p4UQQu4rpzKXpnujEJGhPGKr6PVqjSdkgHtT7qZ/2noJPjvCKXG//59hJB661PgCu+01vOPPhWVU2LeK8WBUW03j0qZ/2RasIeOy/7R9OQ14KsWa1JExWCeNrtfEeuxeo0zQ216yxQcwUkN6QsDrYIJ3vqeJaPXOMK+DJ24vvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBgH4qo5F6ppw6ZGJiII4H63BwbU2A3PKynOtX8yMs8=;
 b=P5YAZhTiOG7shd78H5wIijrUIZU+CJsXdPRrr8Y572hiVTVWvJ7Ujmz+0LkoKYEWl3CvQd1qhPVk0SxYqIX3UivkSmO9ANkEKJPwQ2cRpltFJqw9NtXtlQJiZg0xGfW1XW/EJxJGoIrGi39Z0T1paOe+6+SWWOWTXd4fpFBmMac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB2229.KORP216.PROD.OUTLOOK.COM (2603:1096:301:131::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 01:30:55 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 01:30:55 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nas.chung@chipsnmedia.com
Cc: jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com
Subject: [RESEND PATCH v0 4/5] wave5: Use the bitstream buffer size from host.
Date: Wed, 31 Jan 2024 10:30:45 +0900
Message-Id: <20240131013046.15687-5-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: acb3e98b-dd5a-4930-9f44-08dc21fc4525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RCKP1tNggclQmwgxvQ9WkUCjnEjiV+GRvI9w00jzseR4FEwJjRyjZjNWRO6z2KRrYtEAdUp0/Lb/ct2k7Dok9769U1bsCZwam7ENP4QirkTEcA0A938qobyNJG/2+SmIGm9gc/mbcVU9ECdTk1NUPvBzjc7SP087DQbD1CmuaHKKcLkJZsNi2Zn0rHuadsydRN9Ml9kkriY7pJKa7eUK5k2r3la3VDdjL+2mhaDzhcagggcWPwnewV3smh44fghcUDQDk6OEsv6KDxmMKjwtYm1sxkOCL4FbELZ5dr0cbi8S0X2XgUQDrc6w51QML5Ua99ARW+A/09dYPhE2wIyoNCAW/3FrMCT21tKIeRgdPYdhnpQNbE/V8dMvroseOuls4+Lqi4D0sIpN91BPYlfLyaBUze0AXalmpcxuWqXfzq/F/gOtXJH7aFb0HBIMGERjvyIwNindygaTpt7Lh3a1p4txYyrUElO3+iqIdGS0ZitPDrobk5h7LxfPmXih3g/38zjtp99zQ4bRfaUE/XI/priwX1F+J4Llqp2Ql8hPJrUUExdDNSi7a3Aw93zC8VHeSWBjqddd39HEzELJdsyfuN1XPiqJUyu+DJ4Rx/tQY+jCx6f1Lb1XFD5z37i8/aEL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(6666004)(52116002)(2616005)(6506007)(316002)(6486002)(478600001)(86362001)(6636002)(66946007)(66556008)(66476007)(41300700001)(26005)(6512007)(1076003)(5660300002)(8936002)(4326008)(8676002)(38100700002)(2906002)(38350700005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZMYPJBc4n2Qb9ne1SyBbM9WSXNBZD1QO9C/gQtX7geueeN6qrUJHt6i5znF?=
 =?us-ascii?Q?OeH0H9ah6Wi7dfpgepXjROFYfVPgnz42xY4EkRagrzLAX5e5g70CXQNxMKPw?=
 =?us-ascii?Q?db1RNUtIzTtyBp4Yc+XDmGoO9ZybDasmyocDt7Eqa1hivLjQNXuT9E3k8efD?=
 =?us-ascii?Q?BYwvvge6kYbOMXHd27cns3qa2V8WUkbb252XWGjai7yfoRUdtWOIbHqjG3vu?=
 =?us-ascii?Q?HS2fQNlI5fGVWDt3H3/Y8T0xLY7pQvAxWG2E7R3pnmYVN3UxPL0rlkIybM5p?=
 =?us-ascii?Q?0LujllmMn8qeo1yq1Elb1mhkyBwvj90SmVk3W23F21Oy8xu74bpkrAh4aXAo?=
 =?us-ascii?Q?JIVb03RwZcO9t9u5+FRNPgOb+SuQ1AxjMqCqa5sFDU6XRdZgQh02UI9N/qEf?=
 =?us-ascii?Q?4K2sEB4DtCKv5ubVGTpiHQB9oYtPE2fL567pjbi3b8gQARhDDzOPWWgD/zZr?=
 =?us-ascii?Q?M5ORz3DhZc7rn4FJHIor4zQgA1JNjrHL48UhIISBXAxZxoN9sitdgQD19ayz?=
 =?us-ascii?Q?QHkUvxYBiazTJS8e5MSCO3xysPoJv6/eibphz+gGbgj4j0XyHKL02WFS15wz?=
 =?us-ascii?Q?lBihDi4yDiTDqePLIPMSVJyMcDOhHycOlFqeYt1aGae8U/o4o0zozcyadTw1?=
 =?us-ascii?Q?xikL/+FoQcnI9YhIgFoWIliesOPw83+yulvkRDH2yrai4FnXUZ3wLT3zutrs?=
 =?us-ascii?Q?NtgUYf5flHYv7LC3yLCxT9f3CH/6+sFpCkB7nMZlhNeYMYp4iwoRnrdjib4Y?=
 =?us-ascii?Q?aF52liOkwxjPN8qhzhN7EQLwphQrVO73eRXXN+TNsf6TaW3zZS+7X5pVUUpU?=
 =?us-ascii?Q?jf5q9k4rXmjB13KqXrsT04Y6bhtF75o2dPq1LDH5M6rZXnUHdc5RuroojDPw?=
 =?us-ascii?Q?Ji4L11n14EOVAs247xuSv2Kz1E7ECe7w1mbp6M1MGtGjhP6Ap7hhIqcDJH2Q?=
 =?us-ascii?Q?RT4CBzDObQHKwbjKWrmiTcIc7vDTDz7ZQDVPgWFDNyG7JYKnmSpO9NfEObTB?=
 =?us-ascii?Q?YgmF1zUcXXyyvP15GpyDS+79Uu5eUezM+vFhLCLslXx3BZK36zmI1/2jiTtm?=
 =?us-ascii?Q?bq3Ho+vUM5uguWsB++0CmjtXdg+blmXxlHdyohblHPQdt93xisvqcnm0jPzh?=
 =?us-ascii?Q?QaqRJHP9D0twL924G+wpZ9ECV1kQ0dJGqxeAeF7wY3QcQ7QR8khMCaNF3q1Y?=
 =?us-ascii?Q?Cnsl2mKCecKSbyAfMG+r0I+RU/P/f3lGsBWAxsABW0pmxVbBEvtBKoqBemiO?=
 =?us-ascii?Q?693HlCS4SHBxDy3BgqQ/XjDJhqeqWlMBoHQAIMMNuhHOWtesPawXOPdez3pH?=
 =?us-ascii?Q?BlPoOTuNoncjjOKyAZ7yHliAUyxZ5SeAJueDs0SXOr1i0u18pTH7/I1X9lJe?=
 =?us-ascii?Q?OlKT/suDbuKGZs2wvl3dkp3Qp0FK4Kb3Iva7YFkhTkxB0oivR+NOkPOnmDAW?=
 =?us-ascii?Q?gIxlTB/eXpfQXpestulGZCoCFtrPBiUPqJA+NZB427rM9DIQz2IGZlTSiguD?=
 =?us-ascii?Q?doBloOeB1PPPAAcpF/fXEDoTVQTUrJshv2935u8U66TMxx3SHYjNqdQx6MF+?=
 =?us-ascii?Q?lzHt+0HdFltS4p5K7k8xVRH3znEi6JKLGeNy+Z/BjBZ9kDpr+63ax5aJr6IP?=
 =?us-ascii?Q?5mgB+C2J9vPBsRXU9aQUOh0=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb3e98b-dd5a-4930-9f44-08dc21fc4525
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:30:55.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9u3HfPKk49vUif0kWieNz+/mv02SnHppYOLl3mlfxMmHXr+6hC6pbB4+2hQcr+i2+Eq4BF7N/EZF7oT9a73ROorEhhKCyBoyTvyRtutCmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2229

In V4L2 spec, Host can set the bitstream buffer size.
Allow the larger size between default size and input size.

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index ff73d69de41c..19018ace41b6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -11,6 +11,10 @@
 #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
 #define VPU_ENC_DRV_NAME "wave5-enc"
 
+#define DEFAULT_SRC_SIZE(width, height) ({			\
+	(width) * (height) / 8 * 3;					\
+})
+
 static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 	[VPU_FMT_TYPE_CODEC] = {
 		{
@@ -193,7 +197,8 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 		pix_mp->width = width;
 		pix_mp->height = height;
 		pix_mp->plane_fmt[0].bytesperline = 0;
-		pix_mp->plane_fmt[0].sizeimage = width * height / 8 * 3;
+		pix_mp->plane_fmt[0].sizeimage = max(DEFAULT_SRC_SIZE(width, height),
+						     pix_mp->plane_fmt[0].sizeimage);
 		break;
 	}
 }
-- 
2.43.0


