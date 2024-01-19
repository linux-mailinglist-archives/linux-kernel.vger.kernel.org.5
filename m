Return-Path: <linux-kernel+bounces-30857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4483252B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A91B232AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80228E0E;
	Fri, 19 Jan 2024 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="deYpvKJJ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496B208A6;
	Fri, 19 Jan 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650229; cv=fail; b=gJosAECWaztu8tMa8G+qLU+DZE6aCuu73kLnOluyriXYhg+4LJrLBbetHKbdjqyL3P5IN/Nf4L81s+CnuHOnhxg/89Gtlck6mj/GpBrow+ryct+yu7rLsMjMDPmE2WZT+NZEQplLAUQNDA3OruGZPlrT4FSaCM8nP4s6y2WOulk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650229; c=relaxed/simple;
	bh=gW9/7WjGR6RQNmaB7YS/LcaoTQXfAVt/sC5oJPuQ9ho=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fq5w1DUlOMQ8qz8joK5P1aXDECNbJGSEPIAdDQ7X03pKJk+BIFfvPz0BCCwf1i7sMW99yMCxcSAod3tuTXX4AHM83FKbsyMs3JUQAytXdlND0aGHpRZAkBRhT9OcWX1BAJDNxfUXXWi6zahfeHMeOcLcWq1SfyX6QxBFBD9mzbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=deYpvKJJ; arc=fail smtp.client-ip=40.107.14.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6TTDNxi/7B4iWeMicit+ROPP4q2zjxAhvQJtPfFlY02Yg4bM47+wT8ZwbcBZEmUIcTpDZDuEdrf3jL8xOMg4C3ErrGnh0TOBgDJkbwOR2syV7XLC5oBlYCL230BJcPNwb8/2zQxGEBW/Fl62JADkH4roGSLaJhjvinTtm1ri0i0UFPvVxo1/HL9RR/GzR/uiGnuQGo8MQ04un2wO/KhM0BedP39TqSOrWJMugAlKNXajFbY41yMjTiQtR+CH53uLxvfX67EIF/HF35CFXnO+p5lQueuxpyyryEBkMM7Vy3aPwWjHhkx/dl/+y5sQm2okHW2oJTaprK4fRpmmjoNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ9rnxkotim70jMmadQsdu5KSnVSPKT148zA+J1UI3k=;
 b=j1UXxxiBBORMsTMJmcE7GoGo/7+o3gesfnwWrcjL092AOquVG+AK4dPSBx/Au3t7edtaM/DXLhiZxgXM4q1YjQ8Pligjkigj7OAXVgog7dnesHwMZcVozsY+KZzDVsxd8LyK5tOYszMN+Se3718orWaXAiKxoMnW0fcA9EtZv4dsNTiSQo9jzthcnQy5KxJXsHvIRBBadfKXWd2/y/kRjeKuXm1IPQuUKB+/wVkiKGrBqXyooLrLN9f8K4NisHruUPZpEXIk25/WYBdmd3NyI72Ji0LJJawdy1VCyiVlB9NrTjUgc074Cm2f/WWBnnq2RAkmHQu0Zl6K2+MXS429EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ9rnxkotim70jMmadQsdu5KSnVSPKT148zA+J1UI3k=;
 b=deYpvKJJC+dSHMvN5N23eY9ziVbe5eOcOt+xGyxXhWPY4Ek/9OrWoUpI9eNkoYP3al5h+MyUjI4NJ8WcgIfvO0+znglJyFIUAHDGkjQfK6YhZOB2/k6hCXsqh+rAhpqd19FlC+vMJuDe+tJrrymi8wngBTZ9sJuwj5N5CB12MgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM8PR08MB6578.eurprd08.prod.outlook.com (2603:10a6:20b:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:43:41 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:43:41 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Fri, 19 Jan 2024 08:43:34 +0100
Subject: [PATCH v7 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-feature-ts_virtobj_patch-v7-2-eda70985808f@wolfvision.net>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
In-Reply-To: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705650218; l=10472;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=gW9/7WjGR6RQNmaB7YS/LcaoTQXfAVt/sC5oJPuQ9ho=;
 b=tF/B+MumsS/cNYR363FV1Ae4Cf3VKbMolgiZ+9a1UUJ92eQg1gDG0nicCb3gdz+hTzitLMX81
 X+xaGq0RTqjAmj1x0szcUwTzEuvXKKEwax3VdNAknZwo69HvqDamGzs
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM8PR08MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7e05a9-2c47-444c-a171-08dc18c25b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8IWkuBPEmtVHj1KRNAreFsVOV+9GyrwVwlETNcvJGVH6+B2ELxLIfzlcI4nDj4GSMTphNRHIzbpMg66hWmhVzmT6r9ZAib7nqNtkWnmhmoikd7qOFFkSxLahRDv+1bt+fJhs5beXn2Xc14Wo6Ll8QNRm08yr0GOZpop+8U+0V0RKHkZl5rNNo15gZ2u2zOonjfcdIw9O6FSKi2rf80VeJowl+eCO7DkcWQm4V5wQud1usPQRcHE4W2qMdQZf0nM1JjZafIjLA6Qrq/mFMT//erWCcmqXaHjJcF8cuTVbQiinKNt1WMTFAl7hs+Q/fNQFAZq+4RwEZaoVrV1pK6NuGqJmKsS7GWCAFtI88iaKnktg/B7ezfVMUiANwJjpFNkr2d7knS6oOUryCz33bRvcqYZNI0IwmbO5YycMBTts+EYyhYHmU4hIsFBTBfZbzrFSHD+A2pCZyBNfw8l2+eT4AqT/hSIKFCxyTtfc4N/+P1j6lL0hPcQe3BolEA9HhR5mL8jOXYSOqnaxzAXNlSqb9foN25skNB55mZ8q1kLz1ZrZSYQdFMiaHAY9sxDYR2f0QbNSNxkmht9sCINQW8W0RWJGe5rytgZxsQmqYBzxqn8XQcEi7q5/d6QbLCq3f68k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(7416002)(4326008)(5660300002)(41300700001)(86362001)(38100700002)(478600001)(6486002)(36756003)(107886003)(83380400001)(2616005)(6666004)(6506007)(6512007)(26005)(52116002)(316002)(8936002)(8676002)(44832011)(38350700005)(110136005)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFI1OThoSE5IN0xEblBXRTZUR01TMnVqRlBlYTJFYXp6ZDE0c2RnR2MySEVx?=
 =?utf-8?B?ZU56UUlRYmJsWnZMUldHUkdOT2w2Sms1NTdBenpPOFZ2dUF0Y2lRc2wzeUdP?=
 =?utf-8?B?VGU3K1BWMzJ2U1phRCt3SzlsTmFiTklvRUlyRlB4aFVHa3c4OFdlY2d3REkx?=
 =?utf-8?B?cTdycGxmQ09Xc1pGdnlKNkViaDZJK1B3QUI4L3JDVHFjYktCVHA0YnZBRGpS?=
 =?utf-8?B?c2tXc2FyL2lSVUtiOERCVzZwOVVDN2FtREUwdTkrQlQzYUFkQnNIcWxFZWlU?=
 =?utf-8?B?VjZYc2lkcEZLeWNnQzJYNmJVOVRCNnpIbnJKVFZiWncxMEJ6bDdXM3ZzYzlM?=
 =?utf-8?B?NFl5MDFBNHl2R0w2b3BTL3NtZHNPMzh2L1VhL24vdUVWQUdEcHRJM0pYYUY5?=
 =?utf-8?B?UjVKUm8wOWFjMjNpQ1pOUldhcHUzQVFuK2cvU2Q1WkZ5YXpyQ2x4YnZweW9I?=
 =?utf-8?B?ZXRTalBQcXYwaURmc01nV2RGRnl2ZnB3Tk1yQVNuM0tYYkg2Rkt3MXFlRWt4?=
 =?utf-8?B?Y2xXODhjQ3lvQjNoZUNMUTVSOUh5T1RsTGl0NVcyRVJGT2ZHbG9CT2wzekNH?=
 =?utf-8?B?enFQK3VsSkFhUUVyVXpqUjI4UHBkcWNQRXdodytUUWtSU0FMOFMralNHM1ZW?=
 =?utf-8?B?VFViMmRBcGJNaXJ3MS9SSzVXanJqR2QwUTNGSi84aGJkeWhWTk9iL0xzQSsv?=
 =?utf-8?B?YVpPZlNNeTRsMENrSStaVmxNU0xEdXRUTThIWUIxaTF2NFp3MWNQZmJ3ejM0?=
 =?utf-8?B?UkR1YlJXMFh5aHFOa1VudTlVUm4vY0N2TEdRS1R3QkF3YlkxQjBCN3NYQkhB?=
 =?utf-8?B?VDgxNWZiUDlMaUZsSG9JaEx2SWlLallDbG5aOVZlNlNQeUdoc1JzVnprV2x1?=
 =?utf-8?B?UG1jeDhMWXdIQThWT0xFbk9UejEwdHJxSklTb0o2Y2JiNzJnZWsreVh6ZDBX?=
 =?utf-8?B?cTRJYmNuSlJic1Z2aTIxODhaKzZOeXB5SzJJSlJqWGl2T3VsQnViNTVGM0Vp?=
 =?utf-8?B?enhyYU9rTU1YSEliTXBBWUg5M2oyYkRqMlpKTGpiUG8wdEtTbDMzUldZb3p3?=
 =?utf-8?B?Y0lOTGt5T1ZnU3ZLcjE1bWJFNTNtNzBjVS9qV245RjVFbW1JZ3JPTTRiaGxI?=
 =?utf-8?B?MVdEb0R1SmM0bFZjNHRzRmxJWnExWW1mdG42dGpJZmZ5Und2UzN2VlBUakUw?=
 =?utf-8?B?M1Yxd3JYQW5RSFdCeTR3TTgvdDNyTDFyVExOU0JhMSs2T1JQbHp6d0RXaWQy?=
 =?utf-8?B?RkVaUVRSV3RXbXd5WjJpenBjaXpieVJKejdyT0hMTEhzTUFCUUE4NXFadFdy?=
 =?utf-8?B?S0JzZDBMdE9WeGU2VXNhdnFZeS81L2g5R2MzVy9qV2RNRzhXU080TVFoZW9F?=
 =?utf-8?B?ajdoT1FBZ3BpamRKUTUrRmdoSFpHZHFRK0t2by9uZ043K1JhQlFWMFFMQlFX?=
 =?utf-8?B?R2x4MHZPeU44YytBQnI3cVV0c3dKNzdqY0dKeHBsMTk5Z3IzcWZpVTVWZktH?=
 =?utf-8?B?Yys2a3MzWFBiWFVadU55MXVuR2h0VXZQbzFIRkNMK2k2VkxzNjRMMk5OUyto?=
 =?utf-8?B?Q0U4TG4vN1FmWWJMNDBxVHQ3TzFVK2lWT0tpbk1OcFN2eGRQYXJaTHVTcjV3?=
 =?utf-8?B?cXVNVkpqZGxiYlJtOE56b3hXellLYXVvN1Qva0hteFRPR2o1ODlnMFZZNlli?=
 =?utf-8?B?SjBZUEJJSXVTNHhqYUh5enI2ZGkvS0RPbGRwMnNvaWpnNUQyYkY3RXF6d0pv?=
 =?utf-8?B?UHVuVkY2TVNsVEhHclpVVk1qWVI4eDB2OWZPM3JHc3FSanRDL09WUzF4Tnc3?=
 =?utf-8?B?TGQ0YmhKNGJyKzg3L3dmVzR6ZHV5TDQ1UHJjYSs3M1ZPSU5lWEpoTXM1KzRO?=
 =?utf-8?B?WTJDYm1JT2ovbWVIdWI3dWVQQVZXNDFPdERhM0ZBMHkwWHdGNnVMYVdvZnJM?=
 =?utf-8?B?c2E4QUJreURtNDBnNnVlZERFYitFRmRpOFdUM1VmMEJlZUh4R2YyNFlZeDM5?=
 =?utf-8?B?Q2hPbncvWnNKaTNmMTdMQ2FhSC81SWRUS3lmTm85S09KWTdwYjJIS3pzeXg0?=
 =?utf-8?B?dFdOZHNDbngwbTdpUTR2MkFEKzh0eVUzYmVvVTFQRTdHZWdqcnF4bnhMWXRV?=
 =?utf-8?B?M05lUnQwUWlRUjhkSVFuQU96emJ6b0hWTTBaRVdHYWd5bTdEWlAvenZWQTl5?=
 =?utf-8?Q?5iQCvJ1IdJi4Lh97Wcox3cQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7e05a9-2c47-444c-a171-08dc18c25b18
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:43:41.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/uzbA6eWLclpL1Fw7+yy0O//C7v1Tgu4NNAnrWLN4d7kMYLq9YU0G4fxiD3odq3kEVvQaQZK/exT9QJyM5UvqYtRAmK74dhmQLuBKIjnDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6578

Some touch devices provide mechanical overlays with different objects
like buttons or clipped touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input subsystem to transform them into overlay objects via
device tree nodes.

These overlay objects consume the raw touch events and report the
expected input events depending on the object properties.

Note that the current implementation allows for multiple definitions
of touchscreen areas (regions that report touch events), but only the
first one will be used for the touchscreen device that the consumers
typically provide.
Should the need for multiple touchscreen areas arise, additional
touchscreen devices would be required at the consumer side.
There is no limitation in the number of touch areas defined as buttons.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                         |   7 +
 drivers/input/Makefile              |   2 +-
 drivers/input/touch-overlay.c       | 250 ++++++++++++++++++++++++++++++++++++
 include/linux/input/touch-overlay.h |  22 ++++
 4 files changed, 280 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..668687bf94df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21961,6 +21961,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/toshiba-wmi.c
 
+TOUCH OVERLAY
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touch-overlay.c
+F:	include/linux/input/touch-overlay.h
+
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index c78753274921..393e9f4d00dc 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
-input-core-y += touchscreen.o
+input-core-y += touchscreen.o touch-overlay.o
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
new file mode 100644
index 000000000000..42b6ad753a00
--- /dev/null
+++ b/drivers/input/touch-overlay.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Helper functions for overlay objects on touchscreens
+ *
+ *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touch-overlay.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+struct touch_overlay_segment {
+	struct list_head list;
+	u32 x_origin;
+	u32 y_origin;
+	u32 x_size;
+	u32 y_size;
+	u32 key;
+	bool pressed;
+	int slot;
+};
+
+static int touch_overlay_get_segment(struct fwnode_handle *segment_node,
+				     struct touch_overlay_segment *segment,
+				     struct input_dev *input)
+{
+	int error;
+
+	error = fwnode_property_read_u32(segment_node, "x-origin",
+					 &segment->x_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-origin",
+					 &segment->y_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "x-size",
+					 &segment->x_size);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-size",
+					 &segment->y_size);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "linux,code",
+					 &segment->key);
+	if (!error)
+		input_set_capability(input, EV_KEY, segment->key);
+	else if (error != -EINVAL)
+		return error;
+
+	return 0;
+}
+
+/**
+ * touch_overlay_map - map overlay objects from the device tree and set
+ * key capabilities if buttons are defined.
+ * @list: pointer to the list that will hold the segments
+ * @input: pointer to the already allocated input_dev
+ *
+ * Returns 0 on success and error number otherwise.
+ *
+ * If buttons are defined, key capabilities are set accordingly.
+ */
+int touch_overlay_map(struct list_head *list, struct input_dev *input)
+{
+	struct fwnode_handle *overlay, *fw_segment;
+	struct device *dev = input->dev.parent;
+	struct touch_overlay_segment *segment;
+	int error;
+
+	overlay = device_get_named_child_node(dev, "touch-overlay");
+	if (!overlay)
+		return 0;
+
+	fwnode_for_each_child_node(overlay, fw_segment) {
+		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
+		if (!segment) {
+			error = -ENOMEM;
+			fwnode_handle_put(overlay);
+			break;
+		}
+		error = touch_overlay_get_segment(fw_segment, segment, input);
+		if (error) {
+			fwnode_handle_put(overlay);
+			break;
+		}
+		list_add_tail(&segment->list, list);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(touch_overlay_map);
+
+/**
+ * touch_overlay_get_touchscreen_abs - get abs size from the touchscreen area.
+ * @list: pointer to the list that holds the segments
+ * @x: horizontal abs
+ * @y: vertical abs
+ */
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->key) {
+			*x = segment->x_size - 1;
+			*y = segment->y_size - 1;
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(touch_overlay_get_touchscreen_abs);
+
+static bool touch_overlay_segment_event(struct touch_overlay_segment *seg,
+					u32 x, u32 y)
+{
+	if (!seg)
+		return false;
+
+	if (x >= seg->x_origin && x < (seg->x_origin + seg->x_size) &&
+	    y >= seg->y_origin && y < (seg->y_origin + seg->y_size))
+		return true;
+
+	return false;
+}
+
+/**
+ * touch_overlay_mapped_touchscreen - check if a touchscreen area is mapped
+ * @list: pointer to the list that holds the segments
+ *
+ * Returns true if a touchscreen area is mapped or false otherwise.
+ */
+bool touch_overlay_mapped_touchscreen(struct list_head *list)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->key)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
+
+static bool touch_overlay_event_on_ts(struct list_head *list, u32 *x, u32 *y)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+	bool valid_touch = true;
+
+	if (!x || !y)
+		return false;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->key)
+			continue;
+
+		if (touch_overlay_segment_event(segment, *x, *y)) {
+			*x -= segment->x_origin;
+			*y -= segment->y_origin;
+			return true;
+		}
+		/* ignore touch events outside the defined area */
+		valid_touch = false;
+	}
+
+	return valid_touch;
+}
+
+static bool touch_overlay_button_event(struct input_dev *input,
+				       struct touch_overlay_segment *segment,
+				       const u32 *x, const u32 *y, u32 slot)
+{
+	bool contact = x && y;
+
+	if (!contact && segment->pressed && segment->slot == slot) {
+		segment->pressed = false;
+		input_report_key(input, segment->key, false);
+		input_sync(input);
+		return true;
+	} else if (contact && touch_overlay_segment_event(segment, *x, *y)) {
+		segment->pressed = true;
+		segment->slot = slot;
+		input_report_key(input, segment->key, true);
+		input_sync(input);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * touch_overlay_process_event - process input events according to the overlay
+ * mapping. This function acts as a filter to release the calling driver from
+ * the events that are either related to overlay buttons or out of the overlay
+ * touchscreen area, if defined.
+ * @list: pointer to the list that holds the segments
+ * @input: pointer to the input device associated to the event
+ * @x: pointer to the x coordinate (NULL if not available - no contact)
+ * @y: pointer to the y coordinate (NULL if not available - no contact)
+ * @slot: slot associated to the event
+ *
+ * Returns true if the event was processed (reported for valid key events
+ * and dropped for events outside the overlay touchscreen area) or false
+ * if the event must be processed by the caller. In that case this function
+ * shifts the (x,y) coordinates to the overlay touchscreen axis if required.
+ */
+bool touch_overlay_process_event(struct list_head *list,
+				 struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	/*
+	 * buttons must be prioritized over overlay touchscreens to account for
+	 * overlappings e.g. a button inside the touchscreen area.
+	 */
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->key &&
+		    touch_overlay_button_event(input, segment, x, y, slot)) {
+			return true;
+		}
+	}
+
+	/*
+	 * valid touch events on the overlay touchscreen are left for the client
+	 * to be processed/reported according to its (possibly) unique features.
+	 */
+	return !touch_overlay_event_on_ts(list, x, y);
+}
+EXPORT_SYMBOL(touch_overlay_process_event);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
new file mode 100644
index 000000000000..cef05c46000d
--- /dev/null
+++ b/include/linux/input/touch-overlay.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TOUCH_OVERLAY
+#define _TOUCH_OVERLAY
+
+#include <linux/types.h>
+
+struct input_dev;
+
+int touch_overlay_map(struct list_head *list, struct input_dev *input);
+
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y);
+
+bool touch_overlay_mapped_touchscreen(struct list_head *list);
+
+bool touch_overlay_process_event(struct list_head *list, struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot);
+
+#endif

-- 
2.39.2


