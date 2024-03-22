Return-Path: <linux-kernel+bounces-111165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF588689D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16650287448
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490F1946B;
	Fri, 22 Mar 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Kao8wmiN"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazolkn19010001.outbound.protection.outlook.com [52.103.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20304F4FA;
	Fri, 22 Mar 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097801; cv=fail; b=NLiksZMTiHLTjLJ05pH1EfQBeW4ltSGMBrwajGgd4p5JafA87DK3ANiZxXKbeWpvC+Js9Z1Rz5R21t+THHZmqt+NjvyHYW3K6r/jpIeMtl/DE1GcmWGgRG/1wCQPjMG7DJ40d2VbXLvdPsjorQXoWgzXJZYP5/+sL+Rfm3cAiDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097801; c=relaxed/simple;
	bh=MXfk7JLwSNFt/BQuYPqWRq5qI6kfUbA6knDd+rFbIxA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tfjfwZNv90VqHcUKoaTpaVxN9fpLIIBxTJ49HKeVhytn0lNOqCZPFORYQxpqu6Sp4GJLXhxk95uWZZInDTt4lDYJKnfsGfJjDJ1cgk7CsZyW8a2uydycPMvLJMg6+/TlhXgDuVTO426qrt8prCYKIw8gav58/rD+yQ6+ZJBz+VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Kao8wmiN; arc=fail smtp.client-ip=52.103.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND9J/wzOLUALVDeSib7QiaQyKIgxcFG9pAlF2SPDpV4i8vUcxYuUeFVCnsvMtIa+cA5Vkzod1txJYHVfNWREQvbVWbS/IMWxjnYxKWF+bf5m6Fo3xZp8RTbqlGCw/xwaPNojfQwhJKF5aCuT5knVaAuN2uLx7Aglq9J8F1vpwiMSCVw1VfXEZZoSMaVdGjwikirhODTZC8FxSXz9NtHWZewJ5HOfSzCPjhwHiczLer1C21YvJLU9fsApF0wSOsmVxL6cIooiyVI84brYgqTJ+rSapUhc/ab4XfsIkTU1avVv4wFXdDQWMsPK4rXMeN5em56y+C5N9zPLaeENdYzwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts0oUIcbq8Leri2BR9mWeUZI4RFyB/n8hjU4pGnhkgc=;
 b=TWn3Pz+co1H2mOKu4wucVY3Mq3yiVc5KIGZbyp5teBbY4uRSaEPxVUdkrOXS0brddDRBuCe6dBKENBbSmii/XO5jS/ItImBnw9lm++TekEviu+J4iQEOSV6o7NOMAagnDDYTGWsUVxzwIXHZtQcqhtGkZftXVTqWjAtn74LLW+PO5svyegHBrUUNWDBhxoT1uCg8sd6F+NmsdYrXJ2YpDHjx6uHcBYeuV9YbsBVVmV0j2HJgf+A9sWnBluXnShViVR6zeEvMGd3oI2SQrG5wevW8SvC8uONe77OduMhr+Xd3l5CRlQwK9Vwy4nvSqbOBmnT1axo3VRZsCDKbF+cYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts0oUIcbq8Leri2BR9mWeUZI4RFyB/n8hjU4pGnhkgc=;
 b=Kao8wmiNaqrh0mD8D0xfM5mTJ1GQh1nzqtkKUFNZtTt5vI04TNbRsgaoI7JIqdGU8s1bT8J9MGyFzNajzzVvTQmvMLuSfnZQk8QduWf/dyH+L6/vJRILCrtRXlhLjF2TVHG0/xxKspXzOYbWadsc0WdUuAOD3sCSpR2hfq/VrFBU76MtOJGeXAXX0+QsmQ8RNS2gc1XH+Z9qHJu6rqAJWVkY9010m9shQiNOCBH5Zy2t5ycBdVfob9TOBcG0ZoljjlNsChjBoF8GLkJlb979wb6buUsZjX6Bup02IN2wrASBBSzXVEkF28b6L+JQ7A3yweaZna9q5yYHfi7x8p2cMw==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEZPR06MB6870.apcprd06.prod.outlook.com (2603:1096:101:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Fri, 22 Mar
 2024 08:56:34 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 08:56:34 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v1 0/4] HID: Add support for Himax HX83102j touchscreen
Date: Fri, 22 Mar 2024 16:56:02 +0800
Message-ID:
 <TY0PR06MB561166BF14CF42BBC3C2B5BF9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [uAK9cOcRi0j3tWyU+Qw8CBVp2izYQxK9]
X-ClientProxiedBy: PS2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:300:59::28) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240322085606.993896-1-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEZPR06MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e24213-6745-4e4a-4046-08dc4a4df9a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6CJllTF9G5GyiVLBUDKK5f0eQRplPSl1IUMpPUZY4K2xSjyuiFfMQo1HtHgGh5kDqCumpNXcsMx+xb3tBlNsk0GcnKyyuWz24iqvrNc1Kw1Eg5E+/IyZ210qSgHP7NzSRTM47FoUgA0YQQcQ4bAnZaO/Oin1wU8qWuyuK8iYYU5cokGcRNzP1B1jO4/NQhHjaQHWwz9/1zHwhTv/tf/uBEaOp4PZ5/8dxX8POT7ZixmN1sJW4j8R3DYeGVox9BHWV8ksbXliQ2y1xKXm+9eV19cfvrwARhlQQ0mlcBwly9ChzDPNPy5BENvLe/yhok6+l02h2t/x6o3liJIAuYfgxCrSUjse4OwZajXQL6ljSprRujH285JY46GRWP4zubBR1O0BCQZaOaBxBhWMNIlm32oboXCIJSPgagNx7p6Lw90SLtkqajbkgfivoj5GrEAZeGsOo8dFzMczH0bWoceA2Az9KAhgDRm5oHnYmGJsrx3bFkzxeBO6jHi+yMNA9GyWP0YW99ETnlkaIYXvDmmpkB6KxA969PQiDcDaozG64yrGDEPajY6g4wq5T8e7l4DZU71fEeBEesugVlSVzBUjbICUCdUQjdk9vnvH+0avXkBox0tInyn4jqt8p4rXzoeX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5OtTBjJBs61hBNHR3dk7sBEIRYy6sFo/rn0eqzKpzD9WFnJ8CsqZkAElwzxk?=
 =?us-ascii?Q?xxVjDVMbOteb9FDcc/go1QRZtpR0IQp+zRrc33bGjFeb/W9Lryp+naGvJf8S?=
 =?us-ascii?Q?yNauNSfwod6xHxIas1xg/VNOwh7iWXWzPa/tY3n8779ERDUVUCOMj+63mjwK?=
 =?us-ascii?Q?IXLK/vUn2S5VKlY8D3boF7gj35wpZzkrkTYwK4/5j60qwtFqyHBM6qtWM0P8?=
 =?us-ascii?Q?milaUc+ggfn85oICrxAMQTQIOBsiw1wohQ5JchlmnGf84YSLEpShLpqXOXkJ?=
 =?us-ascii?Q?VgHM7MezPa5kQBimjtzFEs9K/dZdQPB5wmdhtxpx6AYgdah/Vx5LuMZRnUD+?=
 =?us-ascii?Q?e58/5MgF8ihUGd3PvhCy34IIu7GnWSUFU6w4tPujGU80wx3euWuHECJ8CfIc?=
 =?us-ascii?Q?9oTSU1MvFulpomnNOlDXW6XGp78mK3Yfzas5q69L5mJbX+Fh7+2FscOrm0Pb?=
 =?us-ascii?Q?eZAh2JMNwGLgF+1DaP+3G6AIa0J+9Vp9G9g79etCeemegZkS7eGwqTvZwzs6?=
 =?us-ascii?Q?NcGYIFBWjftnMQUhy+dKprhBCGFuXy0noXZTCJgYCcNwTz1lO5xqPKK/MSp/?=
 =?us-ascii?Q?TxSPLNjItx5UcIUXxo5l9z/MatXGBEnPVDf+H5d/ZWgF6x2FP4BNCLbBODs9?=
 =?us-ascii?Q?J2auSspdQvWcin2d181SkQ/MspzBV+JoqNk9eKi/73EeX6XyMnK/sqBY+8vR?=
 =?us-ascii?Q?/4GFtPOHlHbHw+YeZtftBECbHZ1tgAISU7UNmKCRmD8fF/tvGMyhkjs2K4v7?=
 =?us-ascii?Q?5qH0uZivS0hYB5nJsP8sIYZf6mORdQFBNObPyOh5wZm7WrJZexBXnM2QCjvl?=
 =?us-ascii?Q?WNSTYKDTTeDw4x7743uwrkxi2HQxJyCcJ74cw/uCyXjKHABap38lo2LLS0zy?=
 =?us-ascii?Q?ea+3ffZsafzVgkxQLIK2DLGIRmu+jXw3WjQWx/M4MSQjFtA0E77w/WzFnO9L?=
 =?us-ascii?Q?o/AHCvOYHKW33dEQkv8s5oSjpmi5qGdl49GM9CfO5ifnpsXNiO9DHIGjEwcL?=
 =?us-ascii?Q?itwOobCxwL8bWh6IaI4S+aihVLZzDvV5qqVdUpJ4KYkR7bPrcn7q9RgTLjdX?=
 =?us-ascii?Q?6931RUG2DU+AFXFkItMhS9yAGEb9zIzqALLxHDPuATbSI5WZG3jP3QiebFMQ?=
 =?us-ascii?Q?uiMbzZfYZG15pwLqgyPU3a0gP9JoeDn8iKgM/eaHyNi9EgcS0V5jIhUl51CO?=
 =?us-ascii?Q?6ywz+pZJmCWnNVl6sV2v5BdkOsT7dq14bpd++MbvK99dzvXrSHch4Ih6CE4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f764d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e24213-6745-4e4a-4046-08dc4a4df9a9
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:56:34.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6870

Hi,
This driver implements for Himax HID touchscreen HX83102J.

Using SPI interface to receive/send HID packets.

Allen_Lin (4):
  dt-bindings: input: Add Himax HX83102J touchscreen
  HID: Add Himax HX83102J touchscreen driver
  HID: Add DRM panel follower function
  HID: Load firmware directly from file to IC

 .../input/touchscreen/himax,hx83102j.yaml     |   73 +
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    7 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-himax-83102j.c                | 3071 +++++++++++++++++
 drivers/hid/hid-himax-83102j.h                |  460 +++
 6 files changed, 3620 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

-- 
2.34.1


