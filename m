Return-Path: <linux-kernel+bounces-79235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95189861F54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A51D285822
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83C14CAD0;
	Fri, 23 Feb 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qlakDd5Z"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5C14CAB3;
	Fri, 23 Feb 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708725931; cv=fail; b=Tu+7R0kvqk86/t/hzcQ8hDyJ0geQyR0jaBd219JUTkjqMm80H/vI858RL946ON/k3CZDN+46lVbJAWxB3AjBUGUniTxRhX6IFL7daaeVs79hfJlmyKGYkZTg15eE8sSLxPJJzjiLW0wYWPtJSSDalJb3aCqxCXxymXQr3qCdZWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708725931; c=relaxed/simple;
	bh=GSZnvlyhRqvkJEpVrAyRi5pzQ7cXeZ2hmCnBan1qQpI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TpNY4lW8hKF4TzrAJ8cJFlMwJVXtCtbuecEuD5Y2cxeKRl9TM26v5KnLau+BBsZ6ObuMllgNGbKinzcnanqJuULHkcUcspq2jiNyD+/Zn0vZK4NuHfysFT/98OkMW4YbwwdQwyGq48oUnS1i37SlNLdR+l+P6YW24SDk79hma6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qlakDd5Z; arc=fail smtp.client-ip=40.107.237.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4rIr1dGNUPVg0mbDPjO+s5a5eEaM18TXARjHOQtfAU8oJZOvmayr0XBHTy55U04rcUqdRHljRqVPXj7ImyGUdOuutrQdNqhVlhlQ1obiYeCIp5bNH8V2GCtzhelQ3A73iI4ywbzrViuiTFXTuD6+BTeg871deQZegS25a4OLyB8uaLwLCPGf+wqCvJxvX6Ci7uj9Oub2UlmHR2zsBgXi431u+bkuB4QssUOBz9gAtp9icLptKo87eA+p/gO6QrTCOAQyFfCBmsKjgAYkMbwOfW7HVpieG5jeymuPefpPcQclhJK/qTCZnUM+JXiVM+2dsfeVZNWnSZn2pgNlsrX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYocEINSBT+cAXSdB6UQfPq6Kbe65EERiaNcdq4rwTY=;
 b=RmtjLISbVnkbcEb0ESVhVH6hf10Kxp/G6CG6NdU4qi9ERwDfeKCqM8DWu1EgHz/GhNxnK+qCZc5kI0B1FuGk6VIck3IfuCu9VFTR4UAOP3JRbm3tNVYGnTdk/G8J347Oa5IH9qb0jHqPzFNHwySmg6wEnDlpIC9BSwY1UEe7WCQDXtD/5Qpn43E745UKu+3jtFWG2Mhbodi+APCC0QeplWcvw/vysqnpwpRO4TEzaKmexr+YReW21Q5lquc4859yndxOyQ/ViyVJ5PxXUW/qEqpWk2YXaXojouHcJ58YzU5k6NZr1bo0e+TOJsnE2JoFH544UtXxEti3xCg8E7V+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYocEINSBT+cAXSdB6UQfPq6Kbe65EERiaNcdq4rwTY=;
 b=qlakDd5Z1QOE3jJw+VP2YDmnanIl45iToP49sJItO+WU//JbnsTfNNlPhNbY30NJ9IEt1jtyPzVgHXCc1BEbITtTLBJ4Jjxnggusia3s56RhaeyAWJLg6O8Ox9sQeidwYEfyRYIMnAMWU4Q5S73kXdaZB7joUTKI8mNEcHKTjms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8257.prod.exchangelabs.com (2603:10b6:a03:53d::8) by
 PH0PR01MB8022.prod.exchangelabs.com (2603:10b6:510:285::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 22:05:23 +0000
Received: from SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2]) by SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:05:22 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>
Cc: Evgeny Pistun <kotborealis@awooo.ru>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v4] perf data convert: Fix segfault when converting to json when cpu_desc isn't set
Date: Fri, 23 Feb 2024 14:04:58 -0800
Message-ID: <20240223220458.15282-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::24) To SJ2PR01MB8257.prod.exchangelabs.com
 (2603:10b6:a03:53d::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8257:EE_|PH0PR01MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: f63acb81-749e-421f-b520-08dc34bb881d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OS/RXwKGOblKdy3126vzXd/3V1kaIVsEm08+Nb89lZBTpgWHK0frq1xen4Ujqx88HfU5UDk2DGGr4pxRuTY34TcVmz1WCPYvaMEZBEE5fsbuMfPxxRXWJCj72AswnEkI0T8DNb1eXLxXbfwuODxgnHf8sPA7c1lMk+FCh4v0pobpJK1uwb1mYWDLzwnnPGp/ujJCx8alCncRUB8mqpfWEaG1XhDWClN5DHM2bY8D7vUPAk2QDuCrksS3g8GHcjIYBo33cU3lbIGAQn+EeAu6HY7f2NkzjThharMC3oobspXGGucjo+cJE9wezyv9hkJ35l6RX1Fbm+EDZGrGf5yBGbmponAewmdQ1HbRKmGV4WhNRdpUIP/TQ1TTqf4lvlL5MQPLOIRCNvXkaQY6FrTpbS1rdFasAI66gSV4DeZ4UwYtSfMB6QDmIsTzyzJxuxv2ZKyJhJSG/UAi6joSkRh5EQlBYqK6hFHWUY/xAXkHaf0i5qRLV6InNbM4V2guzZRwGHrvTOw+K/cT35rqgY+jLExQLJhnTVnAe5zsjlrGGcnmjtlGkT7blYRJNzxPp8Ff+bi6dHcLQTmEprqDVOoOSbuJslCuYmg2GrTpxciFOUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8257.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3izKFjqYMgqvJerVJpEat7Z54zdxQj9C3+ISk/8KRMWMse7uh1Gx9T4vbef9?=
 =?us-ascii?Q?whXUoc5bVRgh7fpX+K/E6365mKLz/waSZp2n30s/Uw0Es5rUvT6US7sFBQfI?=
 =?us-ascii?Q?YAX4ce3EbzgbMN1kFl23Z5RUEjoKv6dAC9VexDldgNNsEuH/9Q0l7mNafHxg?=
 =?us-ascii?Q?+slfUeYBUAJgW5ROXwlltwGfpO9c2MVVEtsnJdSJ1fc3UWnMn/70k0latE8d?=
 =?us-ascii?Q?3B6mJsfooiJ4rX3KaevtJiJWCxCGliZv+b2SFfBoKUuWAuXMw4X1IcDWsLxX?=
 =?us-ascii?Q?ZX4boL0o/ESyP0ldq7mFfEevRNZGP7bEG8F8CIYPqsXRDXbuorR3VJ3gpLA4?=
 =?us-ascii?Q?CJ8QEWrZI/0LwtU1mOuKA+WdSpE6v88U/xWx1gjhOHMf1oxEYo1/lqaBbjBy?=
 =?us-ascii?Q?wTxW+gjRE9KerH5X02QyY77R+LrKCBH7JnfnZ9lx/LL4rfRagbgMfgpSWh09?=
 =?us-ascii?Q?C30OCHuYX7T2C61WYXPZJC1yPjWayt7u8kMZSkLXnJKylfCS0WMVwK2THm5m?=
 =?us-ascii?Q?1297Be+pa91eZ2+NfdyM29rU8bME43RGd0b74mOadPZ/SoydAp+V7kjpHKX9?=
 =?us-ascii?Q?/vkEIodC7ZFWsrzPzC66yDruI2/DHbgRwrtMkWro/rHS+s7FJVYpK75cxHE5?=
 =?us-ascii?Q?utTjTlp/6NWO0MYpRWV52eIHiZyqrmk7mrQYHKGy+Wsdg2JKfKO8BRtcrl9s?=
 =?us-ascii?Q?TzR+fq6hyOpAx86Po5ruqXCpIhjJew9H6Djtj8/ThbcRh2En2Gco5VdxyBsf?=
 =?us-ascii?Q?wVZF++zdhziTG4p9so0TxKT+mhrX35wFUh88rn28oOZyIXaqHcDp1uk/3O/g?=
 =?us-ascii?Q?+7MYJjsQ7HxAxx2iufJJVGM/+EygQ1bylFvaHlQakd43c5OxjAFuRj4k32Pz?=
 =?us-ascii?Q?ejuY/atA6gdVwS3pP5Sc7t04amxB97IHIja/pcsztx3DBXhKQg8viXqtMIZr?=
 =?us-ascii?Q?RTX76FcxslEzuRya9GQH7PprMSpEnlJFttt3JNmhPSNmUvtq1kDF4wbeexYf?=
 =?us-ascii?Q?WolsJCCzkqc6ChzyQjaE/618z2Ok+9PSdGGHyC4TdCEciExHf+VWZLzgwvrH?=
 =?us-ascii?Q?Dw0luf0zqWa96GLD4vqpOKgQcfWSOI8lAELYIZQUG7V+ip/yBcX8t59WbWv0?=
 =?us-ascii?Q?Mn2Mz0xCBiDIz4fBVkENbBt1kOcQE82stRqVP23CswkQ5YlZVRcUB3x3g83o?=
 =?us-ascii?Q?JI3MlCsIen43RGOdwy+xyOTg7DYTKaXXY8MO303vtjuLpvJzGSQEemWHtnHz?=
 =?us-ascii?Q?Tfl9YipK5ma2IKiAW5o8Ohi3f58oWy8j8aSwaLoOc4rHlouukzqnYxtG83eC?=
 =?us-ascii?Q?te0itRIKFNOyUJncFFaTG5p5cxnNYRNf0LNyXccMW6PS36kPn9jW+ur5TUKg?=
 =?us-ascii?Q?S4QM5Jm6D9qEk+6aBZ4Uhm88bSFUiFvBKonEqKH950y9kO1lUSFzufI1vqjN?=
 =?us-ascii?Q?4rXZLx2MLh9s1X4zBSvahFN5zn0YDewHuRwUImyGN+HJPbtlseEQ2l4rHfL8?=
 =?us-ascii?Q?h8zgFFMesVeezBrfXxjXlKgnMETwOsD5xXHG8N2DFQvzIVWmjam7qegEY/w+?=
 =?us-ascii?Q?fe8a9FQmzPzQTRRUCsNm10iU1SbCPiTuC2IME+dNshlXDj4D0f2OdjXkFuEs?=
 =?us-ascii?Q?odX2kZyz6CV02mQj048oCnA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63acb81-749e-421f-b520-08dc34bb881d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8257.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:05:22.8397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3Ldda1HBnuJmruHKmDAN3un4DFItmnJd3aNgHJcN8Phy7HI87tPvRovqxXMrR4dAVnLXtGpQqENEXhZHwxrvDhCgwyvzbglTU812cPiTbz0/vWp07vhTju+T6PcnZ72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8022

Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
assigned.

Running
	$ perf data convert --to-json perf.data.json

ends up calling output_json_string() with NULL pointer, which causes a
segmentation fault.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---

v1:
    - https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperecomputing.com/
v2:
    - Changed the patch based on James's comments.
v3:
    - The architecture is checked from the actual data file to allow one to do
      conversion on another system. (thanks to James for the feedback)
    - https://lore.kernel.org/all/20240117215101.77713-1-ilkka@os.amperecomputing.com/
v4:
    - Made the fix more generic in case there are other architectures where cpu_desc
      isn't assigned as asked by Namhyung
    - Rephrased the subject line
---

tools/perf/util/data-convert-json.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 5bb3c2ba95ca..09d57efd2d9d 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -284,7 +284,9 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
 	output_json_key_string(out, true, 2, "arch", header->env.arch);
 
-	output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
+	if (header->env.cpu_desc)
+		output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
+
 	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
 	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
 	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
-- 
2.43.0


