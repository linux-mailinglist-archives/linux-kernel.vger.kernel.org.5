Return-Path: <linux-kernel+bounces-55069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10C84B740
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9791C20F07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CFE133416;
	Tue,  6 Feb 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="TX/FEkNT"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2132.outbound.protection.outlook.com [40.107.13.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E9132C1E;
	Tue,  6 Feb 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227991; cv=fail; b=jrcAwxJgD7smQ6mcfoleFXtY0uTaUo6RHAdV7/7qtuvqhDkpif3MqYvaT21a34yMXUj4wo1VtWrYABmBirSzHHtmV3UF6hX5Cv7VihjPzcrDtZh+uwdGT+b4wSW+DFxHVNP35Vkvf+RQuJuAO/jNq6W46/HegbG/lGJZCo4WtGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227991; c=relaxed/simple;
	bh=uRH9mF07fR7cKqxIhkYp1u1KwaKObY9oS7zxcPA1GUQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MUOWeG09x6bgtjGx/oSGJO5chfZ0oqnvw2tXxGtL8aGNOl0sjcd+PaknQmZxYR/432HDz+wpShywrWMmegFGoeo2dk2FmBtRqTW5JKVodrSdhMX/TojxA1dWzmUiJ/32F+DO1cvGJZVXv5Z9uhwzJX8rwrbHoaMTmxm6NJLWUKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=TX/FEkNT; arc=fail smtp.client-ip=40.107.13.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeTu8jkCOCBf2L1h+Sm8r5mj/C4odEvd630tR+lF9pokLlZ7dwQeXQVTEIsvgooJH2ekhLDy8VZsQQg/dfrPV6tdUWECE+GIdR91OeOq72r5hKJnlSUeqxnM1pJitzRg5JNTmVQ6gxdUBEU6sytb3B49KlZ1AFXt+wKS/9eXZYSohwgES4tgO3AY7ibVpyFNUp5yW3ILiseN2MuBEpO8hYGk8teJ2m1EZA9ijDS/q28m/H1rEC0yl5lWjqT1SItbhU79E63faS+O4lOGPatoiMtblbAQhpBtx7t8X4smb4eyZZJ72Aww9ZbfbxGnJXeDZf+jtHFHqKgq0j4kpW81EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaQCMQpZrOb7Wy+oaUVBdI7L/JEFIEnDUqDFr2MiSvs=;
 b=VDJY2ZxbPAlj+ryMCW5qmKp89i2ajgAWOPyCRQh9l1TETUeCd05gWKN6Vkvv3d6uVJf+X3SVRAD8wH3CXk71HnFgI1zJktxC/O3ZqrW9h2F2Whc8fgCr2lEsZKPvJp6p/euAZ5344Nvv9ow1A7MCTFVhpEwqvHFBAsyM/y0hDlb+A11laXHpLZQZXZHVsKjae76h1tpLiDzmB7HlhOXOdJPlL1zWYurf/Q2Xbf+b9n+cJTyVxhINdgZyicT7PRr1QqG9v6TWZ0a2kLuBnwoU4t3BLW/D2mGlYHS2qiOdkGayYl+1NzxseIboQ5ntZn8bmOvog7b11DW/J9aEskzyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaQCMQpZrOb7Wy+oaUVBdI7L/JEFIEnDUqDFr2MiSvs=;
 b=TX/FEkNTwer2/yPfBXQNUKhMWBrIcm0KUXT6TWkHWXL+WHn2cgxGaW0jxEoNUry7qu+P6ppRUUMF6y5QaUXn/bXP/LhUW8cYjigLm5olLKnh9Ej3wofyrZQwmRWzTp9HpPyEWUsU8zKXiFSUmbOGCmK5xhf6blmUwKG+eO7ROc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:37 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:36 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 06 Feb 2024 14:59:29 +0100
Subject: [PATCH v3 1/7] usb: misc: onboard_hub: rename to onboard_dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-onboard_xvf3500-v3-1-f85b04116688@wolfvision.net>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
In-Reply-To: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Matthias Kaehlcke <matthias@kaehlcke.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=45547;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=uRH9mF07fR7cKqxIhkYp1u1KwaKObY9oS7zxcPA1GUQ=;
 b=Ez+wwKz8eCg0vqAhBtx21rn3fzYUy9ZjZgNXIempw11YGD6AlM1+B4sX/IzTHhM1OND05xw1V
 Q7fzGWJYTA4DuWMdCN+5D/dBrnEndusmUVMcDCmm0/5ItTwqZ1FxCRS
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 32522691-7bfe-4a3a-a6a3-08dc271bdabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QBFoUs3tt6o8hMt6Q6Vt+CWl+HXnm398AYnajjifB2/ZQSdf/vUFlpZVxKVwTgzvyK5TVHbYX0P20/5pubNthh3dmte07Qm/5vwU/dhq0HsiUUlGKxCx2e2eD/jHPlNL7q+NzmE5TKK6fWqFcNsp0iLt6wJyWCQ8ZzBCBnYCLRkY9HeD/BRbmGxx3X4xecacnPaTfPKpiMk3Lcczk3AgrqtOKWGw2lyGdMR7CIfY1yOcKyadlSdF6X/U40AOu82EXh1c8TxHIB/1G5MulCGvyWhVMlNFp9+fHgzeXkELoCSfKYIf9fDWs5nuTn1VlyxQ37qQ1OeWR95cEHoBe+2egBmGA5qOQwdr2CqdRkxdQjRYHp8mmjuwfazfcrYTRLZv8XSRLyZVMANiFNnooBJTqDasqlWo1d/lzfzc8nMeStV/KhjIwJpE2UF0qCOW9OcQsP+oxLPTK8VLwMQFRSWh1DQk8aCaMPfNOrJ5a3ZFisS9R9M9fe+/HcmT2RaTuoU/f0bAGQXKn9CNNOnYhAfhtDepoSLr7tqlJF1Za5Cx3c70eIfAm1JF8OTJorM7I1QO8VqbC0Ys8r4XGJlBnGpSyaBNd6gwI/Wc6FD//GmrJvclfmNVCd78ywuOpsVOCM2n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(83380400001)(26005)(2616005)(6486002)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(54906003)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002)(30864003)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0ZSSW0rVHZBNEo1YTYxU3FiTS9PTTcxUUQyRDI3eitqRDZaRmhpTlFGK2Nv?=
 =?utf-8?B?bEFGWndCeEZpN3JUN2pSd0w4bG9BZmgxU3M2NzkybjBsV056ZUtUczZybEQx?=
 =?utf-8?B?VWRnSi9jNHdJamp0R2hoTHJIVWtPUFVVQ25CZUhCVDdUTi9KRXVVSWhPRmFl?=
 =?utf-8?B?bGJNS3RiRkk3TVgvejVmNGNtV1BXdzNMRDRIQjcyVGQ5dlE5YUFNbHc2OFlo?=
 =?utf-8?B?dUJTTmdsTXZWOUwrZ05hYzgyb2xFUmM4SFpjVERZR20yTklHa1R5VXdVRWVF?=
 =?utf-8?B?ZlBrd2ljVkZGL3I3ZXYxSkM2Q1FJTFRGeHMxeHNzOVV4cy92L1Z3ZXUwa2s4?=
 =?utf-8?B?Y0ZJcHNvckc1R0VYQm5mUDQwdXVlK05nWFA4VWpyNU5sOTZLS1F1VndxWGRp?=
 =?utf-8?B?WG9EdmJGMXdNWEtwNnBhMjZ2Rm05RFp1RHp5OVkvSTBBZmVxekMxSlQ4T2hB?=
 =?utf-8?B?dXM1aml4WjB3bDJpV2FMbjQ0SmVJcVhVbHBCcUEvenBuSm03YTRDOGc0N3B0?=
 =?utf-8?B?S1FtQTR4b0cySkNlS0phNFNvellVcHJxb1ltUWc1TjluZ3preXhmc1VkVWFV?=
 =?utf-8?B?bXpPSUxwTW1lTm1POVkzU3RSQ2V4OVVvTDFkSE9yYUpiYytMTWxyTmdTZVR5?=
 =?utf-8?B?cThlVlUzUHBKSEZlWmQxSGkrSld3My9uWXphKzNucXdISDZEWXE0bi9ud0I3?=
 =?utf-8?B?S25HZTkxbUZLTXE1RUdxWEhhZXRLYU95KzFyV2xlVUxBZkZxVjdtVTJHbXVk?=
 =?utf-8?B?eFlMYTMxWmVJbitWNEdFcFhKUkZhb2V6b0ZpZHpOWGhWeGVDRkFVSEltaWJu?=
 =?utf-8?B?SkkwMGkxRjBjOXVTSlZuR2tSd2FTVHlad3d2K0lkMlk1UjdlMnJ2YTFlcDlS?=
 =?utf-8?B?QWxkR2dCbkVMUkk0Z1M3aTRWNVo4cEd1dCtna0I1K1FLaEp4bDNCSGVuM1pL?=
 =?utf-8?B?Z3hjcWtoU1BYOFVhRzhVbDN2dUo3WXJ5bUxxOFAzT1lhVEhpbFQzaGpQdTl0?=
 =?utf-8?B?TXJWd0N3MXBWSGxmY2ZVNUpOd2pEdmFvUHVNendlb0ZOQzVRNkZOV1BnRVdJ?=
 =?utf-8?B?YnpqV0x5TUNiaWRBc0lYdGhMcVZ5VmZqeEgyd2VhdkpPaElMa1hlTUVEWnlz?=
 =?utf-8?B?cTZwMkJCdFJITGNsaUM5WjZXQU5aM05DWENMemhpU05aMHpZa1FFbEhWQUNH?=
 =?utf-8?B?UUdZSVBkTEtES3lpOHc2QzhEMVMrdTN6bXF4WjAwV2lXMDdiV3duNEREcC94?=
 =?utf-8?B?L0tjalExOGc2NWhzRkhUTUZDTUpOc20rU2laVU9wWi9ERExnZTh4TWlaVzdH?=
 =?utf-8?B?MnpJZUNaSW9jZUl1N1BsY2lqSUZnd2NsRGc3TWpjeStyOGlBanMxRG1hSWtL?=
 =?utf-8?B?YXZycUtJLzA3WUtnMnJqRng3UTY2RDBLdzVPVjkrQkhQMEk2bWEvbHVYZDVM?=
 =?utf-8?B?cmdPY2MyaEQ5dFlpUnBDcUJWZU1aOWRRb2d1MnVITjc3NzBGYWRpdnkwYTRR?=
 =?utf-8?B?WHNBdTFzSWU0ZkNWUWVMc0d3REtRZ1dLbGI2T3A2aHMvOVY3NFU4S05NaFQ2?=
 =?utf-8?B?Q3dFVytkZHhMRlpOV0V5aGw3djlrMWRsd0o0NmRnYXZKSTRkbUdyMEh6QXhk?=
 =?utf-8?B?L2pNOFVJTGF5ZmZzU1BIUjU1a2cxYjc0WnNmNVFNMG1VWmdjdTlobzZRTUh6?=
 =?utf-8?B?Ly9pMnY2RW9PcHRnWmt5dkJ3V2Q0cjlQTDVVNldxTlE3Q0ZoTFpITGQ1WGlx?=
 =?utf-8?B?RWt2L21QY01RV2hsZGJidzE5L3NJWlNRQURFUFRja2l2NHhSanVVeWQvUXZ6?=
 =?utf-8?B?VlNEemhCYUxweWtWeXJYeUluZGVDd2FJT2hrR2JSaGJ3WUoxaitwYTdwMVg1?=
 =?utf-8?B?dGs0V2tVancvWm1qU1BldnVaWkJVSjhlaFFON0huVnNBMmVDSTdtOG12aVJ1?=
 =?utf-8?B?Y2svTEtkZWFwZmt1V1JOalZ3U0llSytNQllCTEZhcEYzR1FJWktab2FjMjBL?=
 =?utf-8?B?dDBueklNQWdJWjRicGtOdE1vMFR5U2FnMndFMk16QzJHSzRObzViU0FDYVRh?=
 =?utf-8?B?YXdjT096blkra1NnWm9lR1VwSjU2eVZZMzg0cEJmTTNPNEJLOUZYdjhQWDE0?=
 =?utf-8?B?MTl6bkplM0JoMGY0dkJZZ2t0dSswOUt2enU2dFF0VUJQYnJEVzRYdFR5VmNI?=
 =?utf-8?Q?LibVXCToDeaYarNDPt2OqRo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 32522691-7bfe-4a3a-a6a3-08dc271bdabb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:36.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sA6arNE5A+qnnlYs10SdSfGu3tz1AKP+DkAuEIHWiTs2G/Nj57ybmHvs1ZkN+tmLMirNrls8M0MX3FsRjJHP2FITANPXEma+MkGme2nQGEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

This patch prepares onboad_hub to support non-hub devices by renaming
the driver files and their content, the headers and their references.

The comments and descriptions have been slightly modified to keep
coherence and account for the specific cases that only affect onboard
hubs (e.g. peer-hub).

The "hub" variables in functions where "dev" (and similar names) variables
already exist have been renamed to onboard_dev for clarity, which adds a
few lines in cases where more than 80 characters are used.

No new functionality has been added.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 ...-usb-hub => sysfs-bus-platform-onboard-usb-dev} |   4 +-
 MAINTAINERS                                        |   4 +-
 drivers/usb/core/Makefile                          |   4 +-
 drivers/usb/core/hub.c                             |   8 +-
 drivers/usb/core/hub.h                             |   2 +-
 drivers/usb/misc/Kconfig                           |  16 +-
 drivers/usb/misc/Makefile                          |   2 +-
 drivers/usb/misc/onboard_usb_dev.c                 | 518 +++++++++++++++++++++
 .../misc/{onboard_usb_hub.h => onboard_usb_dev.h}  |  28 +-
 ...ard_usb_hub_pdevs.c => onboard_usb_dev_pdevs.c} |  47 +-
 drivers/usb/misc/onboard_usb_hub.c                 | 501 --------------------
 include/linux/usb/onboard_dev.h                    |  18 +
 include/linux/usb/onboard_hub.h                    |  18 -
 13 files changed, 594 insertions(+), 576 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
similarity index 67%
rename from Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
rename to Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
index 42deb0552065..cd31f76362e7 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
+++ b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
@@ -4,5 +4,5 @@ KernelVersion:	5.20
 Contact:	Matthias Kaehlcke <matthias@kaehlcke.net>
 		linux-usb@vger.kernel.org
 Description:
-		(RW) Controls whether the USB hub remains always powered
-		during system suspend or not.
\ No newline at end of file
+		(RW) Controls whether the USB device remains always powered
+		during system suspend or not.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..7ad556ecca40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16297,8 +16297,8 @@ ONBOARD USB HUB DRIVER
 M:	Matthias Kaehlcke <mka@chromium.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
-F:	drivers/usb/misc/onboard_usb_hub.c
+F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
+F:	drivers/usb/misc/onboard_usb_dev.c
 
 ONENAND FLASH DRIVER
 M:	Kyungmin Park <kyungmin.park@samsung.com>
diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 7d338e9c0657..ac006abd13b3 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -12,8 +12,8 @@ usbcore-$(CONFIG_OF)		+= of.o
 usbcore-$(CONFIG_USB_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
 
-ifdef CONFIG_USB_ONBOARD_HUB
-usbcore-y			+= ../misc/onboard_usb_hub_pdevs.o
+ifdef CONFIG_USB_ONBOARD_DEV
+usbcore-y			+= ../misc/onboard_usb_dev_pdevs.o
 endif
 
 obj-$(CONFIG_USB)		+= usbcore.o
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ffd7c99e24a3..f85b3e928a35 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -23,7 +23,7 @@
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/usb/hcd.h>
-#include <linux/usb/onboard_hub.h>
+#include <linux/usb/onboard_dev.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/quirks.h>
 #include <linux/workqueue.h>
@@ -1776,7 +1776,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	if (hub->quirk_disable_autosuspend)
 		usb_autopm_put_interface(intf);
 
-	onboard_hub_destroy_pdevs(&hub->onboard_hub_devs);
+	onboard_dev_destroy_pdevs(&hub->onboard_devs);
 
 	kref_put(&hub->kref, hub_release);
 }
@@ -1895,7 +1895,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
-	INIT_LIST_HEAD(&hub->onboard_hub_devs);
+	INIT_LIST_HEAD(&hub->onboard_devs);
 	spin_lock_init(&hub->irq_urb_lock);
 	timer_setup(&hub->irq_urb_retry, hub_retry_irq_urb, 0);
 	usb_get_intf(intf);
@@ -1925,7 +1925,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	}
 
 	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
-		onboard_hub_create_pdevs(hdev, &hub->onboard_hub_devs);
+		onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
 
 		return 0;
 	}
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 43ce21c96a51..3820703b11d8 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -74,7 +74,7 @@ struct usb_hub {
 	spinlock_t		irq_urb_lock;
 	struct timer_list	irq_urb_retry;
 	struct usb_port		**ports;
-	struct list_head        onboard_hub_devs;
+	struct list_head        onboard_devs;
 };
 
 /**
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index c510af7baa0d..50b86d531701 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -316,18 +316,18 @@ config BRCM_USB_PINMAP
 	  signals, which are typically on dedicated pins on the chip,
 	  to any gpio.
 
-config USB_ONBOARD_HUB
-	tristate "Onboard USB hub support"
+config USB_ONBOARD_DEV
+	tristate "Onboard USB device support"
 	depends on OF
 	help
-	  Say Y here if you want to support discrete onboard USB hubs that
-	  don't require an additional control bus for initialization, but
-	  need some non-trivial form of initialization, such as enabling a
-	  power regulator. An example for such a hub is the Realtek
-	  RTS5411.
+	  Say Y here if you want to support discrete onboard USB devices
+	  that don't require an additional control bus for initialization,
+	  but need some non-trivial form of initialization, such as
+	  enabling a power regulator. An example for such device is the
+	  Realtek RTS5411 hub.
 
 	  This driver can be used as a module but its state (module vs
 	  builtin) must match the state of the USB subsystem. Enabling
 	  this config will enable the driver and it will automatically
 	  match the state of the USB subsystem. If this driver is a
-	  module it will be called onboard_usb_hub.
+	  module it will be called onboard_usb_dev.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 0bc732bcb162..0cd5bc8f52fe 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -33,4 +33,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
 obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
-obj-$(CONFIG_USB_ONBOARD_HUB)		+= onboard_usb_hub.o
+obj-$(CONFIG_USB_ONBOARD_DEV)		+= onboard_usb_dev.o
diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
new file mode 100644
index 000000000000..e2e1e1e30c1e
--- /dev/null
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for onboard USB devices
+ *
+ * Copyright (c) 2022, Google LLC
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/onboard_dev.h>
+#include <linux/workqueue.h>
+
+#include "onboard_usb_dev.h"
+
+/*
+ * Use generic names, as the actual names might differ between cevices. If a new
+ * device requires more than the currently supported supplies, add a new one
+ * here.
+ */
+static const char * const supply_names[] = {
+	"vdd",
+	"vdd2",
+};
+
+#define MAX_SUPPLIES ARRAY_SIZE(supply_names)
+
+static void onboard_dev_attach_usb_driver(struct work_struct *work);
+
+static struct usb_device_driver onboard_dev_usbdev_driver;
+static DECLARE_WORK(attach_usb_driver_work, onboard_dev_attach_usb_driver);
+
+/************************** Platform driver **************************/
+
+struct usbdev_node {
+	struct usb_device *udev;
+	struct list_head list;
+};
+
+struct onboard_dev {
+	struct regulator_bulk_data supplies[MAX_SUPPLIES];
+	struct device *dev;
+	const struct onboard_dev_pdata *pdata;
+	struct gpio_desc *reset_gpio;
+	bool always_powered_in_suspend;
+	bool is_powered_on;
+	bool going_away;
+	struct list_head udev_list;
+	struct mutex lock;
+	struct clk *clk;
+};
+
+static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
+{
+	int err;
+
+	err = clk_prepare_enable(onboard_dev->clk);
+	if (err) {
+		dev_err(onboard_dev->dev, "failed to enable clock: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
+	err = regulator_bulk_enable(onboard_dev->pdata->num_supplies,
+				    onboard_dev->supplies);
+	if (err) {
+		dev_err(onboard_dev->dev, "failed to enable supplies: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
+	fsleep(onboard_dev->pdata->reset_us);
+	gpiod_set_value_cansleep(onboard_dev->reset_gpio, 0);
+
+	onboard_dev->is_powered_on = true;
+
+	return 0;
+}
+
+static int onboard_dev_power_off(struct onboard_dev *onboard_dev)
+{
+	int err;
+
+	gpiod_set_value_cansleep(onboard_dev->reset_gpio, 1);
+
+	err = regulator_bulk_disable(onboard_dev->pdata->num_supplies,
+				     onboard_dev->supplies);
+	if (err) {
+		dev_err(onboard_dev->dev, "failed to disable supplies: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
+	clk_disable_unprepare(onboard_dev->clk);
+
+	onboard_dev->is_powered_on = false;
+
+	return 0;
+}
+
+static int __maybe_unused onboard_dev_suspend(struct device *dev)
+{
+	struct onboard_dev *onboard_dev = dev_get_drvdata(dev);
+	struct usbdev_node *node;
+	bool power_off = true;
+
+	if (onboard_dev->always_powered_in_suspend)
+		return 0;
+
+	mutex_lock(&onboard_dev->lock);
+
+	list_for_each_entry(node, &onboard_dev->udev_list, list) {
+		if (!device_may_wakeup(node->udev->bus->controller))
+			continue;
+
+		if (usb_wakeup_enabled_descendants(node->udev)) {
+			power_off = false;
+			break;
+		}
+	}
+
+	mutex_unlock(&onboard_dev->lock);
+
+	if (!power_off)
+		return 0;
+
+	return onboard_dev_power_off(onboard_dev);
+}
+
+static int __maybe_unused onboard_dev_resume(struct device *dev)
+{
+	struct onboard_dev *onboard_dev = dev_get_drvdata(dev);
+
+	if (onboard_dev->is_powered_on)
+		return 0;
+
+	return onboard_dev_power_on(onboard_dev);
+}
+
+static inline void get_udev_link_name(const struct usb_device *udev, char *buf,
+				      size_t size)
+{
+	snprintf(buf, size, "usb_dev.%s", dev_name(&udev->dev));
+}
+
+static int onboard_dev_add_usbdev(struct onboard_dev *onboard_dev,
+				  struct usb_device *udev)
+{
+	struct usbdev_node *node;
+	char link_name[64];
+	int err;
+
+	mutex_lock(&onboard_dev->lock);
+
+	if (onboard_dev->going_away) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	node->udev = udev;
+
+	list_add(&node->list, &onboard_dev->udev_list);
+
+	mutex_unlock(&onboard_dev->lock);
+
+	get_udev_link_name(udev, link_name, sizeof(link_name));
+	WARN_ON(sysfs_create_link(&onboard_dev->dev->kobj, &udev->dev.kobj,
+				  link_name));
+
+	return 0;
+
+error:
+	mutex_unlock(&onboard_dev->lock);
+
+	return err;
+}
+
+static void onboard_dev_remove_usbdev(struct onboard_dev *onboard_dev,
+				      const struct usb_device *udev)
+{
+	struct usbdev_node *node;
+	char link_name[64];
+
+	get_udev_link_name(udev, link_name, sizeof(link_name));
+	sysfs_remove_link(&onboard_dev->dev->kobj, link_name);
+
+	mutex_lock(&onboard_dev->lock);
+
+	list_for_each_entry(node, &onboard_dev->udev_list, list) {
+		if (node->udev == udev) {
+			list_del(&node->list);
+			kfree(node);
+			break;
+		}
+	}
+
+	mutex_unlock(&onboard_dev->lock);
+}
+
+static ssize_t always_powered_in_suspend_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	const struct onboard_dev *onboard_dev = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", onboard_dev->always_powered_in_suspend);
+}
+
+static ssize_t always_powered_in_suspend_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct onboard_dev *onboard_dev = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+
+	onboard_dev->always_powered_in_suspend = val;
+
+	return count;
+}
+static DEVICE_ATTR_RW(always_powered_in_suspend);
+
+static struct attribute *onboard_dev_attrs[] = {
+	&dev_attr_always_powered_in_suspend.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(onboard_dev);
+
+static void onboard_dev_attach_usb_driver(struct work_struct *work)
+{
+	int err;
+
+	err = driver_attach(&onboard_dev_usbdev_driver.driver);
+	if (err)
+		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
+}
+
+static int onboard_dev_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct onboard_dev *onboard_dev;
+	unsigned int i;
+	int err;
+
+	onboard_dev = devm_kzalloc(dev, sizeof(*onboard_dev), GFP_KERNEL);
+	if (!onboard_dev)
+		return -ENOMEM;
+
+	onboard_dev->pdata = device_get_match_data(&pdev->dev);
+	if (!onboard_dev->pdata)
+		return -EINVAL;
+
+	if (onboard_dev->pdata->num_supplies > MAX_SUPPLIES)
+		return dev_err_probe(dev, -EINVAL, "max %zu supplies supported!\n",
+				     MAX_SUPPLIES);
+
+	for (i = 0; i < onboard_dev->pdata->num_supplies; i++)
+		onboard_dev->supplies[i].supply = supply_names[i];
+
+	err = devm_regulator_bulk_get(dev, onboard_dev->pdata->num_supplies,
+				      onboard_dev->supplies);
+	if (err) {
+		dev_err(dev, "Failed to get regulator supplies: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	onboard_dev->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(onboard_dev->clk))
+		return dev_err_probe(dev, PTR_ERR(onboard_dev->clk),
+				     "failed to get clock\n");
+
+	onboard_dev->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+							  GPIOD_OUT_HIGH);
+	if (IS_ERR(onboard_dev->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(onboard_dev->reset_gpio),
+				     "failed to get reset GPIO\n");
+
+	onboard_dev->dev = dev;
+	mutex_init(&onboard_dev->lock);
+	INIT_LIST_HEAD(&onboard_dev->udev_list);
+
+	dev_set_drvdata(dev, onboard_dev);
+
+	err = onboard_dev_power_on(onboard_dev);
+	if (err)
+		return err;
+
+	/*
+	 * The USB driver might have been detached from the USB devices by
+	 * onboard_dev_remove() (e.g. through an 'unbind' by userspace),
+	 * make sure to re-attach it if needed.
+	 *
+	 * This needs to be done deferred to avoid self-deadlocks on systems
+	 * with nested onboard hubs.
+	 */
+	schedule_work(&attach_usb_driver_work);
+
+	return 0;
+}
+
+static void onboard_dev_remove(struct platform_device *pdev)
+{
+	struct onboard_dev *onboard_dev = dev_get_drvdata(&pdev->dev);
+	struct usbdev_node *node;
+	struct usb_device *udev;
+
+	onboard_dev->going_away = true;
+
+	mutex_lock(&onboard_dev->lock);
+
+	/* unbind the USB devices to avoid dangling references to this device */
+	while (!list_empty(&onboard_dev->udev_list)) {
+		node = list_first_entry(&onboard_dev->udev_list,
+					struct usbdev_node, list);
+		udev = node->udev;
+
+		/*
+		 * Unbinding the driver will call onboard_dev_remove_usbdev(),
+		 * which acquires onboard_dev->lock. We must release the lock
+		 * first.
+		 */
+		get_device(&udev->dev);
+		mutex_unlock(&onboard_dev->lock);
+		device_release_driver(&udev->dev);
+		put_device(&udev->dev);
+		mutex_lock(&onboard_dev->lock);
+	}
+
+	mutex_unlock(&onboard_dev->lock);
+
+	onboard_dev_power_off(onboard_dev);
+}
+
+MODULE_DEVICE_TABLE(of, onboard_dev_match);
+
+static const struct dev_pm_ops __maybe_unused onboard_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(onboard_dev_suspend, onboard_dev_resume)
+};
+
+static struct platform_driver onboard_dev_driver = {
+	.probe = onboard_dev_probe,
+	.remove_new = onboard_dev_remove,
+
+	.driver = {
+		.name = "onboard-usb-dev",
+		.of_match_table = onboard_dev_match,
+		.pm = pm_ptr(&onboard_dev_pm_ops),
+		.dev_groups = onboard_dev_groups,
+	},
+};
+
+/************************** USB driver **************************/
+
+#define VENDOR_ID_CYPRESS	0x04b4
+#define VENDOR_ID_GENESYS	0x05e3
+#define VENDOR_ID_MICROCHIP	0x0424
+#define VENDOR_ID_REALTEK	0x0bda
+#define VENDOR_ID_TI		0x0451
+#define VENDOR_ID_VIA		0x2109
+
+/*
+ * Returns the onboard_dev platform device that is associated with the USB
+ * device passed as parameter.
+ */
+static struct onboard_dev *_find_onboard_dev(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct onboard_dev *onboard_dev;
+
+	pdev = of_find_device_by_node(dev->of_node);
+	if (!pdev) {
+		np = of_parse_phandle(dev->of_node, "peer-hub", 0);
+		if (!np) {
+			dev_err(dev, "failed to find device node for peer hub\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+
+		if (!pdev)
+			return ERR_PTR(-ENODEV);
+	}
+
+	onboard_dev = dev_get_drvdata(&pdev->dev);
+	put_device(&pdev->dev);
+
+	/*
+	 * The presence of drvdata ('hub') indicates that the platform driver
+	 * finished probing. This handles the case where (conceivably) we could
+	 * be running at the exact same time as the platform driver's probe. If
+	 * we detect the race we request probe deferral and we'll come back and
+	 * try again.
+	 */
+	if (!onboard_dev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return onboard_dev;
+}
+
+static int onboard_dev_usbdev_probe(struct usb_device *udev)
+{
+	struct device *dev = &udev->dev;
+	struct onboard_dev *onboard_dev;
+	int err;
+
+	/* ignore supported devices without device tree node */
+	if (!dev->of_node)
+		return -ENODEV;
+
+	onboard_dev = _find_onboard_dev(dev);
+	if (IS_ERR(onboard_dev))
+		return PTR_ERR(onboard_dev);
+
+	dev_set_drvdata(dev, onboard_dev);
+
+	err = onboard_dev_add_usbdev(onboard_dev, udev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void onboard_dev_usbdev_disconnect(struct usb_device *udev)
+{
+	struct onboard_dev *onboard_dev = dev_get_drvdata(&udev->dev);
+
+	onboard_dev_remove_usbdev(onboard_dev, udev);
+}
+
+static const struct usb_device_id onboard_dev_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6570) }, /* CY7C6563x 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523 USB 3.1 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2744) }, /* USB5744 USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x5744) }, /* USB5744 USB 3.0 */
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
+	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
+	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
+	{}
+};
+MODULE_DEVICE_TABLE(usb, onboard_dev_id_table);
+
+static struct usb_device_driver onboard_dev_usbdev_driver = {
+	.name = "onboard-usb-dev",
+	.probe = onboard_dev_usbdev_probe,
+	.disconnect = onboard_dev_usbdev_disconnect,
+	.generic_subclass = 1,
+	.supports_autosuspend =	1,
+	.id_table = onboard_dev_id_table,
+};
+
+static int __init onboard_dev_init(void)
+{
+	int ret;
+
+	ret = usb_register_device_driver(&onboard_dev_usbdev_driver, THIS_MODULE);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&onboard_dev_driver);
+	if (ret)
+		usb_deregister_device_driver(&onboard_dev_usbdev_driver);
+
+	return ret;
+}
+module_init(onboard_dev_init);
+
+static void __exit onboard_dev_exit(void)
+{
+	usb_deregister_device_driver(&onboard_dev_usbdev_driver);
+	platform_driver_unregister(&onboard_dev_driver);
+
+	cancel_work_sync(&attach_usb_driver_work);
+}
+module_exit(onboard_dev_exit);
+
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("Driver for discrete onboard USB devices");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_dev.h
similarity index 71%
rename from drivers/usb/misc/onboard_usb_hub.h
rename to drivers/usb/misc/onboard_usb_dev.h
index f360d5cf8d8a..f13d11a84371 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -3,60 +3,60 @@
  * Copyright (c) 2022, Google LLC
  */
 
-#ifndef _USB_MISC_ONBOARD_USB_HUB_H
-#define _USB_MISC_ONBOARD_USB_HUB_H
+#ifndef _USB_MISC_ONBOARD_USB_DEV_H
+#define _USB_MISC_ONBOARD_USB_DEV_H
 
-struct onboard_hub_pdata {
+struct onboard_dev_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
 	unsigned int num_supplies;	/* number of supplies */
 };
 
-static const struct onboard_hub_pdata microchip_usb424_data = {
+static const struct onboard_dev_pdata microchip_usb424_data = {
 	.reset_us = 1,
 	.num_supplies = 1,
 };
 
-static const struct onboard_hub_pdata microchip_usb5744_data = {
+static const struct onboard_dev_pdata microchip_usb5744_data = {
 	.reset_us = 0,
 	.num_supplies = 2,
 };
 
-static const struct onboard_hub_pdata realtek_rts5411_data = {
+static const struct onboard_dev_pdata realtek_rts5411_data = {
 	.reset_us = 0,
 	.num_supplies = 1,
 };
 
-static const struct onboard_hub_pdata ti_tusb8041_data = {
+static const struct onboard_dev_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 	.num_supplies = 1,
 };
 
-static const struct onboard_hub_pdata cypress_hx3_data = {
+static const struct onboard_dev_pdata cypress_hx3_data = {
 	.reset_us = 10000,
 	.num_supplies = 2,
 };
 
-static const struct onboard_hub_pdata cypress_hx2vl_data = {
+static const struct onboard_dev_pdata cypress_hx2vl_data = {
 	.reset_us = 1,
 	.num_supplies = 1,
 };
 
-static const struct onboard_hub_pdata genesys_gl850g_data = {
+static const struct onboard_dev_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 	.num_supplies = 1,
 };
 
-static const struct onboard_hub_pdata genesys_gl852g_data = {
+static const struct onboard_dev_pdata genesys_gl852g_data = {
 	.reset_us = 50,
 	.num_supplies = 1,
 };
 
-static const struct onboard_hub_pdata vialab_vl817_data = {
+static const struct onboard_dev_pdata vialab_vl817_data = {
 	.reset_us = 10,
 	.num_supplies = 1,
 };
 
-static const struct of_device_id onboard_hub_match[] = {
+static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
@@ -80,4 +80,4 @@ static const struct of_device_id onboard_hub_match[] = {
 	{}
 };
 
-#endif /* _USB_MISC_ONBOARD_USB_HUB_H */
+#endif /* _USB_MISC_ONBOARD_USB_DEV_H */
diff --git a/drivers/usb/misc/onboard_usb_hub_pdevs.c b/drivers/usb/misc/onboard_usb_dev_pdevs.c
similarity index 68%
rename from drivers/usb/misc/onboard_usb_hub_pdevs.c
rename to drivers/usb/misc/onboard_usb_dev_pdevs.c
index ed22a18f4ab7..fce860b65958 100644
--- a/drivers/usb/misc/onboard_usb_hub_pdevs.c
+++ b/drivers/usb/misc/onboard_usb_dev_pdevs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * API for creating and destroying USB onboard hub platform devices
+ * API for creating and destroying USB onboard platform devices
  *
  * Copyright (c) 2022, Google LLC
  */
@@ -15,29 +15,30 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/of.h>
-#include <linux/usb/onboard_hub.h>
+#include <linux/usb/onboard_dev.h>
 
-#include "onboard_usb_hub.h"
+#include "onboard_usb_dev.h"
 
 struct pdev_list_entry {
 	struct platform_device *pdev;
 	struct list_head node;
 };
 
-static bool of_is_onboard_usb_hub(const struct device_node *np)
+static bool of_is_onboard_usb_dev(struct device_node *np)
 {
-	return !!of_match_node(onboard_hub_match, np);
+	return !!of_match_node(onboard_dev_match, np);
 }
 
 /**
- * onboard_hub_create_pdevs -- create platform devices for onboard USB hubs
- * @parent_hub	: parent hub to scan for connected onboard hubs
- * @pdev_list	: list of onboard hub platform devices owned by the parent hub
+ * onboard_dev_create_pdevs -- create platform devices for onboard USB devices
+ * @parent_hub	: parent hub to scan for connected onboard devices
+ * @pdev_list	: list of onboard platform devices owned by the parent hub
  *
- * Creates a platform device for each supported onboard hub that is connected to
- * the given parent hub. The platform device is in charge of initializing the
- * hub (enable regulators, take the hub out of reset, ...) and can optionally
- * control whether the hub remains powered during system suspend or not.
+ * Creates a platform device for each supported onboard device that is connected
+ * to * the given parent hub. The platform device is in charge of initializing
+ * the * device (enable regulators, take the device out of reset, ...) and can
+ * optionally * control whether the device remains powered during system suspend
+ * or not.
  *
  * To keep track of the platform devices they are added to a list that is owned
  * by the parent hub.
@@ -50,9 +51,9 @@ static bool of_is_onboard_usb_hub(const struct device_node *np)
  * node. That means the root hubs of the primary and secondary HCD share the
  * same device tree node (the HCD node). As a result this function can be called
  * twice with the same DT node for root hubs. We only want to create a single
- * platform device for each physical onboard hub, hence for root hubs the loop
- * is only executed for the root hub of the primary HCD. Since the function
- * scans through all child nodes it still creates pdevs for onboard hubs
+ * platform device for each physical onboard device, hence for root hubs the
+ * loop is only executed for the root hub of the primary HCD. Since the function
+ * scans through all child nodes it still creates pdevs for onboard devices
  * connected to the root hub of the secondary HCD if needed.
  *
  * Further there must be only one platform device for onboard hubs with a peer
@@ -63,7 +64,7 @@ static bool of_is_onboard_usb_hub(const struct device_node *np)
  * the function processes the nodes of both peers. A platform device is only
  * created if the peer hub doesn't have one already.
  */
-void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
+void onboard_dev_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
 {
 	int i;
 	struct usb_hcd *hcd = bus_to_hcd(parent_hub->bus);
@@ -82,7 +83,7 @@ void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *p
 		if (!np)
 			continue;
 
-		if (!of_is_onboard_usb_hub(np))
+		if (!of_is_onboard_usb_dev(np))
 			goto node_put;
 
 		npc = of_parse_phandle(np, "peer-hub", 0);
@@ -104,7 +105,7 @@ void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *p
 		pdev = of_platform_device_create(np, NULL, &parent_hub->dev);
 		if (!pdev) {
 			dev_err(&parent_hub->dev,
-				"failed to create platform device for onboard hub '%pOF'\n", np);
+				"failed to create platform device for onboard dev '%pOF'\n", np);
 			goto node_put;
 		}
 
@@ -121,16 +122,16 @@ void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *p
 		of_node_put(np);
 	}
 }
-EXPORT_SYMBOL_GPL(onboard_hub_create_pdevs);
+EXPORT_SYMBOL_GPL(onboard_dev_create_pdevs);
 
 /**
- * onboard_hub_destroy_pdevs -- free resources of onboard hub platform devices
- * @pdev_list	: list of onboard hub platform devices
+ * onboard_dev_destroy_pdevs -- free resources of onboard platform devices
+ * @pdev_list	: list of onboard platform devices
  *
  * Destroys the platform devices in the given list and frees the memory associated
  * with the list entry.
  */
-void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
+void onboard_dev_destroy_pdevs(struct list_head *pdev_list)
 {
 	struct pdev_list_entry *pdle, *tmp;
 
@@ -140,4 +141,4 @@ void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
 		kfree(pdle);
 	}
 }
-EXPORT_SYMBOL_GPL(onboard_hub_destroy_pdevs);
+EXPORT_SYMBOL_GPL(onboard_dev_destroy_pdevs);
diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
deleted file mode 100644
index 0dd2b032c90b..000000000000
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ /dev/null
@@ -1,501 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Driver for onboard USB hubs
- *
- * Copyright (c) 2022, Google LLC
- */
-
-#include <linux/clk.h>
-#include <linux/device.h>
-#include <linux/export.h>
-#include <linux/err.h>
-#include <linux/gpio/consumer.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/consumer.h>
-#include <linux/slab.h>
-#include <linux/suspend.h>
-#include <linux/sysfs.h>
-#include <linux/usb.h>
-#include <linux/usb/hcd.h>
-#include <linux/usb/onboard_hub.h>
-#include <linux/workqueue.h>
-
-#include "onboard_usb_hub.h"
-
-/*
- * Use generic names, as the actual names might differ between hubs. If a new
- * hub requires more than the currently supported supplies, add a new one here.
- */
-static const char * const supply_names[] = {
-	"vdd",
-	"vdd2",
-};
-
-#define MAX_SUPPLIES ARRAY_SIZE(supply_names)
-
-static void onboard_hub_attach_usb_driver(struct work_struct *work);
-
-static struct usb_device_driver onboard_hub_usbdev_driver;
-static DECLARE_WORK(attach_usb_driver_work, onboard_hub_attach_usb_driver);
-
-/************************** Platform driver **************************/
-
-struct usbdev_node {
-	struct usb_device *udev;
-	struct list_head list;
-};
-
-struct onboard_hub {
-	struct regulator_bulk_data supplies[MAX_SUPPLIES];
-	struct device *dev;
-	const struct onboard_hub_pdata *pdata;
-	struct gpio_desc *reset_gpio;
-	bool always_powered_in_suspend;
-	bool is_powered_on;
-	bool going_away;
-	struct list_head udev_list;
-	struct mutex lock;
-	struct clk *clk;
-};
-
-static int onboard_hub_power_on(struct onboard_hub *hub)
-{
-	int err;
-
-	err = clk_prepare_enable(hub->clk);
-	if (err) {
-		dev_err(hub->dev, "failed to enable clock: %pe\n", ERR_PTR(err));
-		return err;
-	}
-
-	err = regulator_bulk_enable(hub->pdata->num_supplies, hub->supplies);
-	if (err) {
-		dev_err(hub->dev, "failed to enable supplies: %pe\n", ERR_PTR(err));
-		return err;
-	}
-
-	fsleep(hub->pdata->reset_us);
-	gpiod_set_value_cansleep(hub->reset_gpio, 0);
-
-	hub->is_powered_on = true;
-
-	return 0;
-}
-
-static int onboard_hub_power_off(struct onboard_hub *hub)
-{
-	int err;
-
-	gpiod_set_value_cansleep(hub->reset_gpio, 1);
-
-	err = regulator_bulk_disable(hub->pdata->num_supplies, hub->supplies);
-	if (err) {
-		dev_err(hub->dev, "failed to disable supplies: %pe\n", ERR_PTR(err));
-		return err;
-	}
-
-	clk_disable_unprepare(hub->clk);
-
-	hub->is_powered_on = false;
-
-	return 0;
-}
-
-static int __maybe_unused onboard_hub_suspend(struct device *dev)
-{
-	struct onboard_hub *hub = dev_get_drvdata(dev);
-	struct usbdev_node *node;
-	bool power_off = true;
-
-	if (hub->always_powered_in_suspend)
-		return 0;
-
-	mutex_lock(&hub->lock);
-
-	list_for_each_entry(node, &hub->udev_list, list) {
-		if (!device_may_wakeup(node->udev->bus->controller))
-			continue;
-
-		if (usb_wakeup_enabled_descendants(node->udev)) {
-			power_off = false;
-			break;
-		}
-	}
-
-	mutex_unlock(&hub->lock);
-
-	if (!power_off)
-		return 0;
-
-	return onboard_hub_power_off(hub);
-}
-
-static int __maybe_unused onboard_hub_resume(struct device *dev)
-{
-	struct onboard_hub *hub = dev_get_drvdata(dev);
-
-	if (hub->is_powered_on)
-		return 0;
-
-	return onboard_hub_power_on(hub);
-}
-
-static inline void get_udev_link_name(const struct usb_device *udev, char *buf, size_t size)
-{
-	snprintf(buf, size, "usb_dev.%s", dev_name(&udev->dev));
-}
-
-static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
-{
-	struct usbdev_node *node;
-	char link_name[64];
-	int err;
-
-	mutex_lock(&hub->lock);
-
-	if (hub->going_away) {
-		err = -EINVAL;
-		goto error;
-	}
-
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	node->udev = udev;
-
-	list_add(&node->list, &hub->udev_list);
-
-	mutex_unlock(&hub->lock);
-
-	get_udev_link_name(udev, link_name, sizeof(link_name));
-	WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));
-
-	return 0;
-
-error:
-	mutex_unlock(&hub->lock);
-
-	return err;
-}
-
-static void onboard_hub_remove_usbdev(struct onboard_hub *hub, const struct usb_device *udev)
-{
-	struct usbdev_node *node;
-	char link_name[64];
-
-	get_udev_link_name(udev, link_name, sizeof(link_name));
-	sysfs_remove_link(&hub->dev->kobj, link_name);
-
-	mutex_lock(&hub->lock);
-
-	list_for_each_entry(node, &hub->udev_list, list) {
-		if (node->udev == udev) {
-			list_del(&node->list);
-			kfree(node);
-			break;
-		}
-	}
-
-	mutex_unlock(&hub->lock);
-}
-
-static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
-			   char *buf)
-{
-	const struct onboard_hub *hub = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%d\n", hub->always_powered_in_suspend);
-}
-
-static ssize_t always_powered_in_suspend_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct onboard_hub *hub = dev_get_drvdata(dev);
-	bool val;
-	int ret;
-
-	ret = kstrtobool(buf, &val);
-	if (ret < 0)
-		return ret;
-
-	hub->always_powered_in_suspend = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(always_powered_in_suspend);
-
-static struct attribute *onboard_hub_attrs[] = {
-	&dev_attr_always_powered_in_suspend.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(onboard_hub);
-
-static void onboard_hub_attach_usb_driver(struct work_struct *work)
-{
-	int err;
-
-	err = driver_attach(&onboard_hub_usbdev_driver.driver);
-	if (err)
-		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
-}
-
-static int onboard_hub_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct onboard_hub *hub;
-	unsigned int i;
-	int err;
-
-	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
-	if (!hub)
-		return -ENOMEM;
-
-	hub->pdata = device_get_match_data(&pdev->dev);
-	if (!hub->pdata)
-		return -EINVAL;
-
-	if (hub->pdata->num_supplies > MAX_SUPPLIES)
-		return dev_err_probe(dev, -EINVAL, "max %zu supplies supported!\n",
-				     MAX_SUPPLIES);
-
-	for (i = 0; i < hub->pdata->num_supplies; i++)
-		hub->supplies[i].supply = supply_names[i];
-
-	err = devm_regulator_bulk_get(dev, hub->pdata->num_supplies, hub->supplies);
-	if (err) {
-		dev_err(dev, "Failed to get regulator supplies: %pe\n", ERR_PTR(err));
-		return err;
-	}
-
-	hub->clk = devm_clk_get_optional(dev, NULL);
-	if (IS_ERR(hub->clk))
-		return dev_err_probe(dev, PTR_ERR(hub->clk), "failed to get clock\n");
-
-	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						  GPIOD_OUT_HIGH);
-	if (IS_ERR(hub->reset_gpio))
-		return dev_err_probe(dev, PTR_ERR(hub->reset_gpio), "failed to get reset GPIO\n");
-
-	hub->dev = dev;
-	mutex_init(&hub->lock);
-	INIT_LIST_HEAD(&hub->udev_list);
-
-	dev_set_drvdata(dev, hub);
-
-	err = onboard_hub_power_on(hub);
-	if (err)
-		return err;
-
-	/*
-	 * The USB driver might have been detached from the USB devices by
-	 * onboard_hub_remove() (e.g. through an 'unbind' by userspace),
-	 * make sure to re-attach it if needed.
-	 *
-	 * This needs to be done deferred to avoid self-deadlocks on systems
-	 * with nested onboard hubs.
-	 */
-	schedule_work(&attach_usb_driver_work);
-
-	return 0;
-}
-
-static void onboard_hub_remove(struct platform_device *pdev)
-{
-	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
-	struct usbdev_node *node;
-	struct usb_device *udev;
-
-	hub->going_away = true;
-
-	mutex_lock(&hub->lock);
-
-	/* unbind the USB devices to avoid dangling references to this device */
-	while (!list_empty(&hub->udev_list)) {
-		node = list_first_entry(&hub->udev_list, struct usbdev_node, list);
-		udev = node->udev;
-
-		/*
-		 * Unbinding the driver will call onboard_hub_remove_usbdev(),
-		 * which acquires hub->lock.  We must release the lock first.
-		 */
-		get_device(&udev->dev);
-		mutex_unlock(&hub->lock);
-		device_release_driver(&udev->dev);
-		put_device(&udev->dev);
-		mutex_lock(&hub->lock);
-	}
-
-	mutex_unlock(&hub->lock);
-
-	onboard_hub_power_off(hub);
-}
-
-MODULE_DEVICE_TABLE(of, onboard_hub_match);
-
-static const struct dev_pm_ops __maybe_unused onboard_hub_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(onboard_hub_suspend, onboard_hub_resume)
-};
-
-static struct platform_driver onboard_hub_driver = {
-	.probe = onboard_hub_probe,
-	.remove_new = onboard_hub_remove,
-
-	.driver = {
-		.name = "onboard-usb-hub",
-		.of_match_table = onboard_hub_match,
-		.pm = pm_ptr(&onboard_hub_pm_ops),
-		.dev_groups = onboard_hub_groups,
-	},
-};
-
-/************************** USB driver **************************/
-
-#define VENDOR_ID_CYPRESS	0x04b4
-#define VENDOR_ID_GENESYS	0x05e3
-#define VENDOR_ID_MICROCHIP	0x0424
-#define VENDOR_ID_REALTEK	0x0bda
-#define VENDOR_ID_TI		0x0451
-#define VENDOR_ID_VIA		0x2109
-
-/*
- * Returns the onboard_hub platform device that is associated with the USB
- * device passed as parameter.
- */
-static struct onboard_hub *_find_onboard_hub(struct device *dev)
-{
-	struct platform_device *pdev;
-	struct device_node *np;
-	struct onboard_hub *hub;
-
-	pdev = of_find_device_by_node(dev->of_node);
-	if (!pdev) {
-		np = of_parse_phandle(dev->of_node, "peer-hub", 0);
-		if (!np) {
-			dev_err(dev, "failed to find device node for peer hub\n");
-			return ERR_PTR(-EINVAL);
-		}
-
-		pdev = of_find_device_by_node(np);
-		of_node_put(np);
-
-		if (!pdev)
-			return ERR_PTR(-ENODEV);
-	}
-
-	hub = dev_get_drvdata(&pdev->dev);
-	put_device(&pdev->dev);
-
-	/*
-	 * The presence of drvdata ('hub') indicates that the platform driver
-	 * finished probing. This handles the case where (conceivably) we could
-	 * be running at the exact same time as the platform driver's probe. If
-	 * we detect the race we request probe deferral and we'll come back and
-	 * try again.
-	 */
-	if (!hub)
-		return ERR_PTR(-EPROBE_DEFER);
-
-	return hub;
-}
-
-static int onboard_hub_usbdev_probe(struct usb_device *udev)
-{
-	struct device *dev = &udev->dev;
-	struct onboard_hub *hub;
-	int err;
-
-	/* ignore supported hubs without device tree node */
-	if (!dev->of_node)
-		return -ENODEV;
-
-	hub = _find_onboard_hub(dev);
-	if (IS_ERR(hub))
-		return PTR_ERR(hub);
-
-	dev_set_drvdata(dev, hub);
-
-	err = onboard_hub_add_usbdev(hub, udev);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
-{
-	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
-
-	onboard_hub_remove_usbdev(hub, udev);
-}
-
-static const struct usb_device_id onboard_hub_id_table[] = {
-	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 */
-	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 */
-	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6570) }, /* CY7C6563x 2.0 */
-	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523 USB 3.1 */
-	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2744) }, /* USB5744 USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x5744) }, /* USB5744 USB 3.0 */
-	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
-	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
-	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
-	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
-	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
-	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
-	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
-	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
-	{}
-};
-MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
-
-static struct usb_device_driver onboard_hub_usbdev_driver = {
-	.name = "onboard-usb-hub",
-	.probe = onboard_hub_usbdev_probe,
-	.disconnect = onboard_hub_usbdev_disconnect,
-	.generic_subclass = 1,
-	.supports_autosuspend =	1,
-	.id_table = onboard_hub_id_table,
-};
-
-static int __init onboard_hub_init(void)
-{
-	int ret;
-
-	ret = usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
-	if (ret)
-		return ret;
-
-	ret = platform_driver_register(&onboard_hub_driver);
-	if (ret)
-		usb_deregister_device_driver(&onboard_hub_usbdev_driver);
-
-	return ret;
-}
-module_init(onboard_hub_init);
-
-static void __exit onboard_hub_exit(void)
-{
-	usb_deregister_device_driver(&onboard_hub_usbdev_driver);
-	platform_driver_unregister(&onboard_hub_driver);
-
-	cancel_work_sync(&attach_usb_driver_work);
-}
-module_exit(onboard_hub_exit);
-
-MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
-MODULE_DESCRIPTION("Driver for discrete onboard USB hubs");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/usb/onboard_dev.h b/include/linux/usb/onboard_dev.h
new file mode 100644
index 000000000000..b79db6d193c8
--- /dev/null
+++ b/include/linux/usb/onboard_dev.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_USB_ONBOARD_DEV_H
+#define __LINUX_USB_ONBOARD_DEV_H
+
+struct usb_device;
+struct list_head;
+
+#if IS_ENABLED(CONFIG_USB_ONBOARD_DEV)
+void onboard_dev_create_pdevs(struct usb_device *parent_dev, struct list_head *pdev_list);
+void onboard_dev_destroy_pdevs(struct list_head *pdev_list);
+#else
+static inline void onboard_dev_create_pdevs(struct usb_device *parent_dev,
+					    struct list_head *pdev_list) {}
+static inline void onboard_dev_destroy_pdevs(struct list_head *pdev_list) {}
+#endif
+
+#endif /* __LINUX_USB_ONBOARD_DEV_H */
diff --git a/include/linux/usb/onboard_hub.h b/include/linux/usb/onboard_hub.h
deleted file mode 100644
index d9373230556e..000000000000
--- a/include/linux/usb/onboard_hub.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __LINUX_USB_ONBOARD_HUB_H
-#define __LINUX_USB_ONBOARD_HUB_H
-
-struct usb_device;
-struct list_head;
-
-#if IS_ENABLED(CONFIG_USB_ONBOARD_HUB)
-void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list);
-void onboard_hub_destroy_pdevs(struct list_head *pdev_list);
-#else
-static inline void onboard_hub_create_pdevs(struct usb_device *parent_hub,
-					    struct list_head *pdev_list) {}
-static inline void onboard_hub_destroy_pdevs(struct list_head *pdev_list) {}
-#endif
-
-#endif /* __LINUX_USB_ONBOARD_HUB_H */

-- 
2.40.1


