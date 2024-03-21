Return-Path: <linux-kernel+bounces-110776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECED886383
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6517F282F81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A685244;
	Thu, 21 Mar 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vnERihvy"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823317CD;
	Thu, 21 Mar 2024 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061784; cv=fail; b=RbYvj6BUDO6Dw+fGJjTgA8wE9VU/BQfDdseEidnDEUrHFVZzDY/oBfokuCRG5TUijDSDYj+HK1w9q1dQniNcoieB8zCF42H9EYxsvBEiMJZvjlpjllhVPECNgIqwrHiurSYuV80qpr8A1exNqMlXmrVCKR1ax/63404Etgyu6S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061784; c=relaxed/simple;
	bh=Z/hbxkkpJ+T89wAEmJ1utsiY+tiCpUx32M8aMDcfNSA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=IWEv+RWLrKVy3JGfTs3f3DV9tzAPUeJXlaT/ltY1HyjbZx0oCSZrGdrjJFPkpJ56gHgjLzjqOl+nrOMjsephTWlU0eQJS6cqjqRrQhJv6QpXCGWb9voV4sjeYVc3P/23lmh1jV7Y81H8p3BJQhFyDFJrg9M2/7m2ML/H0fJmr34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vnERihvy; arc=fail smtp.client-ip=40.107.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgTtyr+Dr+xQQjbpTRAChVsNK1WY/nsgTlKM7LYXDert9tgmiBrwsMjywM6H5shElG8JTAZSpOacBsBsNy43KCPwkFBohmymym+DY7hDi8TnDTSFNnx2GNrzYpaOCUZxwHloo0ByjQFQPdtYFoTUi67xMFzGzfGhuToxLJqqvSp9Xe2bJQGD9UXt/nLg7uBT6+uWbHcMc5/VhNnOEYw+DvOxXJvqYhbqGq+IJCI4vLM6HiCiikR7jjbuEd5EYJ/bUbHD6WtkDX4xJD7nTD2HTWrC2IVHv1aabb4go9e9MvONVGYXl4dVQnQg/i0tysawAzHUXvDAhbf5nyEt8pCwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHgvBtz9kLZlF4Z4zdpS0O3AS11wkIO6BkpKV3zuXYw=;
 b=I1BdRf9JykwPgWWhDQhkPhfkiEIAnaoA2YoMSXt1GczdL1HszxhmS9mMBDslsfH+Cw74urWx9G+7/77FmWvgvUju29IjhjhPfcQVDrYm79DeghNxX+XF5u9WnD52WcrCfEHg6DH7EP4LbC/rZ1tFiYX971jPrbRXDwbyrTzz0KpQbnLn7MzuT21nfx6VoGRAnmoax5OV2KdjtN2L2SToWdK4Txvp6p8ktrcXSLLG98k98sp6FnNynQLizpXkhltCTnHckUAOLmc8u075eVZvWsOJVq0dU8TZcyi5uUoyiP1EiAdVh4AtX3pezJrko5mUsOhioy1lzJSwtuBxcWMMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHgvBtz9kLZlF4Z4zdpS0O3AS11wkIO6BkpKV3zuXYw=;
 b=vnERihvyb9IZDeXqKk+G3xtb81wfFQ63FHyF+vt0FByKuL8W55FhS1vxfZB043jMTuCxROV1gWXaOvkbjfnZSUHQIUoPw1Si0GjbnDnyfN4ECBMZ2w9ztWss4aVZu2zVbZ6nKz90NlJW4EQNi6ZfhjWYxVHC8GHeZUEN2SQN6eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 PH7PR01MB8668.prod.exchangelabs.com (2603:10b6:510:2fe::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.31; Thu, 21 Mar 2024 22:56:18 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 22:56:18 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: [PATCH v5 0/2] Adds additional information to ARM RAS errors
Date: Thu, 21 Mar 2024 15:55:52 -0700
Message-Id: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPi6/GUC/x2NwQrDIBAFfyXsuQvRKLT9ldKD0TXZQ7U8QQIh/
 17paZjLzElNoNLoOZ0E6dq0liH+NlHcQ9mENQ0nO1s3L9bw6jjgwwiNBajgLiUNaMmVu2fEhVe
 TorP37M0j0ih9IVmP/+X1vq4fo+vr1nUAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Jason Tian <jason@os.amperecomputing.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: CH0PR03CA0426.namprd03.prod.outlook.com
 (2603:10b6:610:10e::10) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|PH7PR01MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8548c9c5-ed00-4f35-2e1a-08dc49fa1e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uRxJ0tBmgvY+ASwAVorojc5W/4J3ZEFT5WFJoTcV/NqBoi2I47J2lLNWDwTsbQkzpxdlY2Bd90W6RGgntv+z5MJcC2cX1pdEEKWUopnAo1S1QWUJVABKVF2wlfw5JOiiKzvW4QFITGX8Ird2GqSNZ01s81NAnKrZDzDCqPfjI/F5R/VXJalp+8lP2ef3N8UzLy5gXjX32MKiLpIxeGjfgYduGuIHsMue3Ty8trag0bILriSn0VxGeBzSHEtMSWwik2YksdhmYBvur9rf1lTrzzeG3VxZ/JFBSEHLQ4NUOzElPxDbbWGFT3iNy4whSRm4bVt9AuDgk/KAQkPBDUIJe3cYDTBjQJ33DugQT1TGurPvOWTN99viRZF4DifUUKBxSNBxnHnqQd2A4XNlNVox9PS3aaWCtr2ePV8jG3IJP2dhiXzce4vJZavyZJ9kchTqBpT2mq8z3vRDRpEVQRd1XwFe1vHnWq76TK2vXsfxR/fOVzVR5nIh6MJnmVizlu8JpKlSobXjAXrRzeedpiutfLBetGFSJeaQnzylZ6vJw5M55GkPOketHh257o7BKD404GGEm7gfyPozDcEIk+izHceOuP2jAohcU1T/UlJ/13dWUkRRr5jAQP5VRTLXAOwamTDjnC786QmrnnnhI5/r7OXjIOKq3cQqj7AW7/y0KCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUs0V1dGK1VoaFkrQ1JQL3l3UjlpMERwYWVsQ3VsbVJKTExuV09na1FJVlM4?=
 =?utf-8?B?eXp4Z29OdnVSQWsrb3Q4VThINDFjVG0zTWlNZG1WNHI5QlZCVEhVYWNVOFpK?=
 =?utf-8?B?MjNDVjFqZnhIbTNQSzd2a0JPT25OelFIcEd3Y1BJSU4vNElCZit3TkhSR0Zl?=
 =?utf-8?B?RGFGMWNTczRpYTJHRzZCdTdiS01BOVVhNEdDTlkrWFBtMDJsZklqWGd5dUti?=
 =?utf-8?B?dVBZamttK0ZFZVZxQXg4ZkZONjcrL1RHN1JaSnlaVVpub3NzKy9LWVVPWDc2?=
 =?utf-8?B?UlpLczNuVE9DYU5lTWdEYkNHa284Z05aV1psenlKaW4vSVFPaDI3RjJ3TWZB?=
 =?utf-8?B?cmJOb1QyQzZMWEQrU1Uxb29TU3dmZVU2ZlptempvQ1RET1dqY09HTVVESVNy?=
 =?utf-8?B?MVdUYzFpZ29YbXgvSVVBVzZzVEJBb0swOXlJWkxYNVMvN25CVzhpcEMvdXpV?=
 =?utf-8?B?OTFrZFBsYUR6Y2Y5aytsWGVUeVptODl0MFFjdkl4dWpwejFuY0N4ZW14WVla?=
 =?utf-8?B?U3h5QWQwWXE2YVYxaWVCTzF0bmtwcE1xSUJrd2hSbU8zaTlSTVZyb21uU2tK?=
 =?utf-8?B?UEhvdE5Da3pqQXZYYTRmTld6d016WVV0ZUQ4QmJEYkxaOXZNdjhySTVjc3VQ?=
 =?utf-8?B?bDc1NWdFejBzem1ka2ZRV3lHT2k2ZlBiWEdZK1lxT3I2NmtCNVkvMUpMKzFy?=
 =?utf-8?B?aTV1Nk1KWEJWSVdCSVFpN0I1NFRuMG55K29DM2ZJbk1TQjFHb3luSzZXc2ox?=
 =?utf-8?B?dkRrazBpOStYWTFSM0JiQ04zTGVGUU1pbnk0ekdrZzdRZ3pNWGdlKzlBMUY5?=
 =?utf-8?B?WFIrSmhubkJxM0pqZm0rSkVtQTdKQmk0M0c4d1RJYm05K3ZVZmtqRzNFSHZj?=
 =?utf-8?B?Qy9XTXo1akhSOS9USE5XVUNJTWszWUtIbk5DbWVSMHJydC91TTBpK01OdEpR?=
 =?utf-8?B?R3lOdGdTOXdiUTlJQkEwRm1YTE5NOTdsN3BjNWR5N29lSDR1S2RVUDZNMnl4?=
 =?utf-8?B?VlRVdlZ1bVQ1RnprNlhtZHM5RHZNSmU5K0FTWmZ1L2VySTNCb3dMbExxOTB5?=
 =?utf-8?B?M2FlL1prZjYrWHJCdUY1dWpxaEExQVFWT1FOZVhKNkMxSmhwYmxURnRVbk5R?=
 =?utf-8?B?TXl0K2w3N3dybVNvQ3k1TWVneUFXR2ZBZzFjTFY1cTFPY3lGMnNlUzRXcmNp?=
 =?utf-8?B?cDc5OHhPKytUQVQ5SVZvUmsvY29Xc2J1eEV4dklOblF6QW9la2FBVXlxcGNW?=
 =?utf-8?B?a0p6b0hoanZKTDZqK0t1SWF2RVBMUnp6bnhqY05RSFRhbGR2UU5YM2N6ejVB?=
 =?utf-8?B?amIwT0YvbmtxMHluZS80YW1IMXBiMXlhOHppUDRtY3JnK1l4eUQvdTdtTjBM?=
 =?utf-8?B?N0NrS1k0OEVwK3A4STRJL0haZ2NSS0dDRm4xZ1Q5TmtYZEVTMW9KTTYwT3hZ?=
 =?utf-8?B?Z293Sys5UzkwaDF6SXJweVEvVm9wM2ZWZG9KL3VYcE44MUo2bHRTajc2aEdX?=
 =?utf-8?B?M2IwVFRGbWN0eXFuMis0VzdxWkFqOVVsK2huakpPVTZjYnNNL2VQemt0WTBI?=
 =?utf-8?B?TGIraEZUWHAySllWWncxaDdyc0ptWDBGMFNSWXpNV0JVM2d2ZTZyZE9TNkJS?=
 =?utf-8?B?dnlUcEJaamVVYlVKbWtuQnRHS0ZxSXlNaEJUNVIzMnRyR1ZzWGp3Y3NDTGEr?=
 =?utf-8?B?WGtnK3VSZlNYSDdVZlk1bEg0NGR3WFZ6MUoycTFZc1duN2FTcityM0hCZUxM?=
 =?utf-8?B?RGxuNlhMTGhXRXZ0ZThBU1hQOHRrbmtrNXNQYjJMUCtSY0M5VXVaZHdTcnRS?=
 =?utf-8?B?NDRackU2U1JYM1o3cGJWU2h3ZTBUVE5yQVZkYnhGNGNmNTZaSWpuQ1htREhv?=
 =?utf-8?B?ZmQzaE1xK3R1anBHK0xTYTZ4My9FNlFQbUZCUUhhV1hvTHRqYWFLbkNUdVNz?=
 =?utf-8?B?Y3lMc3V1bXVjeG9vaVR4TTZwV2JVSy9VdGM0UFdYbDQyelY3TmtRWUZzTUFq?=
 =?utf-8?B?KzJzYmNvL0MwNk5uVDNPVTRzSGNpNDYrREdUVWxvMENmaXVHb21WNFFGVWRB?=
 =?utf-8?B?aEpUYlBTUHkyMzVMeVM4d1FyeHNSQ3g5Zlk5UEhlZWVFczZZd1JVRkxMMW5F?=
 =?utf-8?B?dXZNTmVXanczS09qb1ZPaHo0bGJOcU1zQUZ0ZExnWW9vemRCSDgvcTJSa0V1?=
 =?utf-8?Q?YyRKk6ymHAk9Q8/YZmJM5Dk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8548c9c5-ed00-4f35-2e1a-08dc49fa1e4b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 22:56:18.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4u3hPPTiT+uVw7Z5t6q85NRryUcQ9+ps1pwjkjvPK92pyE4p9pF6y0pzBfffUz7rXtFfx6K+CXvJplp3sr2WA/YyKiS216tOXqoXB2Sy8AxAhqTc660wQfxqi3G0uRV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8668

The patch by Shengwei includes most of the justification for this series
in the commit message. The only thing i've done is add a few conditional compilation
directives based on feedback from a previous submission attempt. This series adds:

	1) Conditional compilation directives around ARM specific RAS error
           handling routines, so non-ARM platforms are not unnecessarily bloated.
        2) ARM Processor error section (As defined by UEFI 2.9 N2.4) to tracepoints for userspace
           consumption. This particular patch is a RESEND.

Originally:
	I did a RESEND of Shengwei's V3. I didn't make
        changes, and I didn't rev.
	The original patch: https://lore.kernel.org/lkml/20220214030813.135766-1-lostway@zju.edu.cn/
Changes since v3:
        Added conditional compilation directives
	previous submission(RESEND): https://lore.kernel.org/lkml/20231214232330.306526-1-danielf@os.amperecomputing.com/
Changes since v4:
        Rebased on latest linux master.
	No functional changes.
	previous submission: https://lore.kernel.org/linux-kernel/20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-0-08e0f168fec1@os.amperecomputing.com/

Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
---
Daniel Ferguson (1):
      RAS: ACPI: APEI: add conditional compilation to ARM specific error reporting routines.

Shengwei Luo (1):
      RAS: Report ARM processor information to userspace

 drivers/acpi/apei/ghes.c |  7 +++++--
 drivers/ras/ras.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 20 ++++++++++++++++----
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 110 insertions(+), 13 deletions(-)
---
base-commit: 2ac2b1665d3fbec6ca709dd6ef3ea05f4a51ee4c
change-id: 20240321-b4-arm-ras-error-vendor-info-v5-rc3-b1dc428f519c

Best regards,
-- 
Daniel Ferguson <danielf@os.amperecomputing.com>


