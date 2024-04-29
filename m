Return-Path: <linux-kernel+bounces-162379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1D8B5A38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7462854E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5E7BB07;
	Mon, 29 Apr 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="SqVmu+kX"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2103.outbound.protection.outlook.com [40.107.7.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD576402;
	Mon, 29 Apr 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397782; cv=fail; b=J3PBto5wcwFiJSmTy++QmGnLHiE4xH26ov2Ekig7e385Mi1/O5V+BsCcT+e1irFadqoCcbGuMuvS/nf+8xVHfuEMVW769i+dqbVtdLXHHEJfNnNyQRC3ukIAV3NYbWVxIlS4cGVvioB1e4QMVvlq5ANVYUFW7IsLpYomGQ4zirA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397782; c=relaxed/simple;
	bh=bgOHDWll20OXbxbVCnkRidPFr3wlVbZXxMT8U2i82b8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EuRhSygEGzAdvuCigcDyruyxu1p6O+wg6JkVGpoDoLULvX0cAIrNOWODamGIxEplNMpNrI3DgZcf0u++QWwagP06Im/b7fD780LoPJoR0iE4P2awrnae5lm65dfcqTH7kea4QsKfTzhVA47ktLBOUaYJWZNammNUNFY6dwNcYRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=SqVmu+kX; arc=fail smtp.client-ip=40.107.7.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK62in1NjPVzAp1XayJBhqpH1YRag3qwPCBXMD2RSaH2a01Q7Qgt1jlgGVxTIwRfE+VJwkIGzU1tXMxLFJCANauDlRO9Sr23YNfUDMz9qt8YE6iWR5obpSmnJmMKxhZPbVPV57w3aDXJmfPvylTTYF+GulNgGbRXFSvRbgtUxaMm9rivu1hfFJ0QBHoz6mkDATQQbHjs7rD62/p5ipN53QC+jZY7ohAemcOVTBX2qIPqmfdawtdsFYAzieR6IRxFobzAX7lNNvkX9XOGm73hXn5YCpV7x8Frn1kzRso0B2gNJJq0Uf+l7rTSX1KCqIyzZq73h0sdqKJ2NA++8r5HIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gASvPyVMsR2M8oPAZmb+jwmiIGkcsvi1O5hbrVZn3wY=;
 b=FqUcdbx+0YIxIo6k4wyk3pqgnTmq934EwpjDuKFrZ5mtsMPxZ24O9oqZWnY1B6PGwC0vbgoSFBX4RPaAf8kNDqfyJQGSdKhMVt15KJ98ObjFMIidzXIrXN3XbCqNhE2Sg9v4OznMrzvbbWgX+fKCR8Up/wS61jS3h9OhC+A6rVQwCNJxT90/QaG8yHARk8R9UWSxH4Cusm8qCd2mB7ghQcXupTxWaPGwwg/OxwwVXK3BDqhsNiOSaDh1wtxUkCKFjXIo0idl+gtxNQONv8Xx2gUWLQ3O04wkhz5MEffH6NwVHYk5zDy6O01xX3Zt15PS3uRl5+FmMUtPrjcIsnscsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gASvPyVMsR2M8oPAZmb+jwmiIGkcsvi1O5hbrVZn3wY=;
 b=SqVmu+kXC3HC6F/UUcGe/X5FG39Pt/GPORlCBP5I+xUx/edubgN24ng+3R16X0gT6zCn1wDhv24tqNgOrDZuEF8bWiYwy3Le9Q8ePV1DV+6XYpwyL53XimjUc4TMRMxZEuHviKLjWLDasXK3unw1366n8FqhjKlUsntv8M0w5Ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6087.eurprd08.prod.outlook.com (2603:10a6:20b:29c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:36:11 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%6]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 13:36:11 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 29 Apr 2024 15:35:58 +0200
Subject: [PATCH v3 2/3] usb: typec: tipd: fix event checking for tps6598x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-tps6598x_fix_event_handling-v3-2-4e8e58dce489@wolfvision.net>
References: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
In-Reply-To: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714397770; l=5423;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=bgOHDWll20OXbxbVCnkRidPFr3wlVbZXxMT8U2i82b8=;
 b=z3u4gdGc2Bv7xGUIeLJnRhDRcJ0D8jOUrRdSj8+UcsaXhAqgxXb42MF9KfqZlZz4aF4KT1Zec
 DDsqMzdgV9ABkZZNL9iBbO0uINbPIGMhL0aCZ+Zf4+zXyiqXGhIB+U1
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 35938dd5-6487-4789-53d1-08dc68515518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGtVZnZ6R08xWktkNXM3bCswaFBxaTI0NlRoUHhXanpBOEdsQzl6S3h3aG5s?=
 =?utf-8?B?Z0N5aHhYeEpCL2ZpeklzZFc3cGh0WUhZbW5MbGxQaUl5U25XRnNIYU50cG1w?=
 =?utf-8?B?K004QTlGZ0w5WnliYlRNelZMZVZIcUlUNENmbm41YjJtNDFicTE0NGMyUng2?=
 =?utf-8?B?RHN2aUxEZTJmdTZNYzJtdEFqVGlKMmdUWERQb21sQ2VuVU1lSHZlVjZod3M1?=
 =?utf-8?B?Q0djL0krVTZsd3NkWUpYWThDTGdCMXJjSzNabmJsOXNYc3JydE94cjJaUXZX?=
 =?utf-8?B?eDFLZHJnQ3UxZk1SSEk3ZkFvbnJlbDg2amxzMWdSc1JVTWtKU3V0RUxMbUZP?=
 =?utf-8?B?OUgxRy9aS2NaWDBuQ1A0c3JrTHFSb21MTEloaDllcTFtQjZTdC8ybFQwdFlh?=
 =?utf-8?B?WDNrL2dXYlJ0Nyt5Q1NvY21YZFc2T3lYdzJETnd1YnZmd09vMFVJMXRzeldt?=
 =?utf-8?B?eDF5cGp2Ry8xNUdyUGYzZXJ4dE5pci9ra1hRMnpOMGR1clR1dVhoQTBsaW11?=
 =?utf-8?B?QjQ0MW9hYjlXMW85cXJ2Yk5EUDVmREVFQjYxQ3FkZ1VUdnhIVEZXS0E0SGdS?=
 =?utf-8?B?dzVMd1JhanI5eWFqdmFmNzJuUW01RnJpbm5SdU9sS3kzK3MvN21hWmZvUjFN?=
 =?utf-8?B?bkY4NHNGSE5JY0lhVktJcjRXMjdUQ1Rsa1hRc0M1QllhODRmalJpL0dlMmhw?=
 =?utf-8?B?ejBDWGF4NFAyZ3N4R2k2MzJxSUswdmJuVFdqTk5sbEhJa21aYTUvamZQRW9C?=
 =?utf-8?B?TlJTZ0pUakx2Qmc1VlpDT2JXNGs2c0krYjRtMVhXT3N0ak5iUGc3aW9RUTVG?=
 =?utf-8?B?VTlBY3dacUxLWkp6VzA2d2orMDlxcmtGdmJzcEYwVUVDSVlrcmtjZnk3QjBm?=
 =?utf-8?B?dSs4VkUwWGVBVlBXSnhWZ2pyNWh0bGV1MUxkZWhSZ1lZb1RhdmNvSnFzeHlq?=
 =?utf-8?B?UnF2WUQyaWYzM0p5VEFRMThXTnVLUnZDTHF4STRVOUZQK1k0UFFlaG1yYitI?=
 =?utf-8?B?N25PU0E5cEhTNURhdmhldmRQMERCZDViRVlZL0VBN2N6UWpEZ2JOdXJiRHNW?=
 =?utf-8?B?dGRMNy9oU0ppaVZnN0E1M1NENkdsak1mN2RDakpDalNPcGd4aDJaVlZPNzdZ?=
 =?utf-8?B?dkswaVJUTFdTekE4aEZkR29lbDJaYkxJSDRTVG5GZ0lxK1RnRHJNN2dFd1cr?=
 =?utf-8?B?VGdyU2RPZ2s2MGVOOWoxUWlyZjdnQkF4cUtoRk1HK2dQWVltT1lBYWloODBj?=
 =?utf-8?B?ZFNkWU5NOFZQS3NGOTRyZjl3cVh5YjU1Qmd4WEZHK2pCc25yV0Z1N2VkZll1?=
 =?utf-8?B?alEzTHp4ZlZ0RzB4c1JCS1FFaU9TbFN6by94MU1lSkE3MUIrRUZMU1U5TVJu?=
 =?utf-8?B?YlZjM2wzakdYSzF4cERyU3ZwYmM0aEFKWXgxRnNJVGdhQk45cGl5Zk9YMTBJ?=
 =?utf-8?B?UjVwTVJSUWhTZE02aWtzUGdzMnNuSE5uaVY0clhTS0NRZG15Ulk5MldINzBS?=
 =?utf-8?B?Zkxvd3Yzc0wrWjZaaDBCT0kyMHVZUmRXWVU0OGNtNjl6cGl5QnMxTFlGVUJE?=
 =?utf-8?B?Uyt6dk5YZnZlQk1WZzBST2M3dHJOa0JYK1dqRHRmbUZpTzYvWENLOENiRGdk?=
 =?utf-8?B?Q1dadHZvSGQzd2xRYnVWbDAwZ2M5VlVudDV2OXcvQ1FTQ2RPVnZ4Q3NhZXdh?=
 =?utf-8?B?MU9hVjlvNnkvVEN0YmwwTUpZT09mQ1BXY3Q0djhyM1Q0Q0lGdCtjcXNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3VZWTBxSWdvYWh1OFJybUU4SzNpa2tLOFJUNTg1cDExZThRcnZXa3lOSFZm?=
 =?utf-8?B?OEp3SFppTEpDY3NyNklVT2VZbVRYalh1eVpvOWhrdlJTQ2U3TzBSNkVpQXcz?=
 =?utf-8?B?ckdCelY1d0s2U2JCNEs1NFRWZHVNeS9iMlM2V3pnT2dWdTdod2k5dnVNNldX?=
 =?utf-8?B?VjRIVWYyVXBIaldXeW5uYjROWkVKRHEzaW9KQkplQUpKbzRib2w3U3pUSXBq?=
 =?utf-8?B?MXBnSzloZkkzUit2aTY1MFdjNEtnaXdUd3RVbFdaTG9UaWNKU1NzRmlaZWx3?=
 =?utf-8?B?TzJjdEhMaE0yNTQ2SzViN2twME11TEVQTGNncXFVNTZKcCtTUUhLMXhVb2wx?=
 =?utf-8?B?ZmZYYVBMYnl0KzlSY2JqMzhnL0cxRitSUEVWRmtnOXlHa3dWaTNUUTNyQ3h5?=
 =?utf-8?B?QW1qR01EcjBUT2hPb2ZJNmx4alo1eDlvNjlQOGh0RGJWZ2pic3VMc0psdGVp?=
 =?utf-8?B?ZlBxZVc5bDdxVVE0dURPN2RnRnZCMUdEMWR5alZpVHFkQXhmQWYzMy9pUng2?=
 =?utf-8?B?YVYycXRtT3VKTUJLTnZmdnA0RWlndm8wRTUwTld4UVpMeTVMc1BkZUxRWE1h?=
 =?utf-8?B?U2FGRHJib2pYUk5LWUhDcUo2VXZETW5BOSt2WlFKdWMzeGdVM0hMeDdFTFcx?=
 =?utf-8?B?U2IxWjdXWTJpMTlXTlY3NDFNSCtVazFqdUhycm04eVFPWkNoVHJZRXo2VURI?=
 =?utf-8?B?dC95dEh0ZU83MTRTWkdmaGNlbUtHb3JINDBqUFJWUlJUR1pqNTh0SURGTFhN?=
 =?utf-8?B?SFpmenM0dHNYTjFGSzRocGx6SjgyWjgvUmtGOVZFYWNnTUxQWEVoeGJzMXk5?=
 =?utf-8?B?YTYzY2R3Zm4xZk1rTnJiRTNPb2JQTHpJUytLVUZGNjZTbExYSE1UUmxuYkNh?=
 =?utf-8?B?dXUzM3JBdVg2UTZoanBnRmJncW5wUVlMS1FTTGEwSWN4QkowU05Rd2UyUHBy?=
 =?utf-8?B?RVowWHVMVkNUbXk2SzRLVjhTUlBKQnZHUlR3WkRUeUNVejlib0xhN1B6TXJ2?=
 =?utf-8?B?S1B1MGgrWmpoVWJkQmxlOTNoOExBeUduOXdObHIzWTY0d1FwWExPd2FMbith?=
 =?utf-8?B?dE5DQ0tNOHlvQTZsTXYvUGYzdWFaRFcvRGsvZDgyekh5WWhxYmpNempaZHVk?=
 =?utf-8?B?RlpkVlpMOU1JdEVZZjhyTExjeFhLMm0wZUhicXZHOW5xVkx1Mm52ek1rOWIz?=
 =?utf-8?B?Um03a3o1Y0lpdmdxMjJVTnJ0SWhSSXZHMVRRWjhHRk93MTUzK1VuRC8vMEFZ?=
 =?utf-8?B?TlgvLzM4aDIrNEg1MzFodXltbnpLUHNVd1ErcFNFUGE2a1RXNG5IOS9EWFdy?=
 =?utf-8?B?RVNYeWJ5d1Q2T0NBYldmY2J6TzZ6a2QxVXZVNm5HdlBRUGFYMDR5N09zTVZy?=
 =?utf-8?B?MXAzaFUwbkRhTlh6OFU5bjM1L25aeVd0ODZpVFZPcE1Ra1VUNjdyUlFQa1Ix?=
 =?utf-8?B?TnBtL21vOXcvL2tSU29IRjhOdWU1NDM1Z3ZkVjVqT0xLOGRaSzkrRTJyZktW?=
 =?utf-8?B?cVozNzlmbzVScWpwaFNEbEdQY3M2Y2k2aHZVZzJiRWwxdUd0eTYwOEM1b3RQ?=
 =?utf-8?B?MDFHQ3phWEZQcVljRE9hRlpTc3FWZXhEd0FXUDdNWGs5M2xRbDlib2hYYUFI?=
 =?utf-8?B?QzVwSUZKZEpwOUxjeXlOVEI4Nmc5dkVWZmdpZDNEekVNN3o0MkMzSWdqdExZ?=
 =?utf-8?B?ZDBkYVJnTVBIQkJIc05DSzY2QUJ2dkxVQnRmUnVpZlFWL2JsOHc4dVZ6YXFx?=
 =?utf-8?B?T3FEZG9xbDFnMmhPV3dJczJHMjYvU0JXNVBSb29KL3V4ZURBbHA0dXJNVFJ6?=
 =?utf-8?B?Ti82Z2Jid0NJVEJkdlk0Rk9KUzVxNU1ZcmJjMFVCZmEwKzBwRlBOVjNFSWhU?=
 =?utf-8?B?Q3NzR1Ara1pTOTJxc0pQUjN4OTBoRXp6eHkrUGY5V1dhNUF1WkRBQ1BDa05l?=
 =?utf-8?B?ZXUrb3prOTB2ekNQaEZtS1RXNjlqMjQrWHUzOEpFc3ZJL0NJUGpUMGo2NEEw?=
 =?utf-8?B?ZzV1d2RpTGJYRnRyMjRjUDR0aGZGb3BGOVNKcEF1cHNDMXRHcmlvUXA1L3VD?=
 =?utf-8?B?MDI1d251RVo3SGFBZjRHTnE2UHRkaEZkNE1xY2hRVHUvMjJBM3VkR3pzMzBO?=
 =?utf-8?B?STdXSmZyL1lYUEdpRTRUd0VSeFR5NmdmQk81SVJWTWRiZ0VxelE1NlhWbUZo?=
 =?utf-8?Q?i2ZgVRG7Z2iWwkbPspg3Ehs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 35938dd5-6487-4789-53d1-08dc68515518
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:36:11.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j94+CeNgWGtxS7o2fYqW/fC2YP5o3acYRQgJ86r+JzNulWA6HGnGqddaCrp0/rYhOhbg7BMWmlCItujdZTkLvUt9jX2n3xtVS2bDzPcmsNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6087

The current interrupt service routine of the tps6598x only reads the
first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
that any event above that range will be ignored, leaving interrupts
unattended. Moreover, those events will not be cleared, and the device
will keep the interrupt enabled.

This issue has been observed while attempting to load patches, and the
'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.

Given that older versions of the tps6598x (1, 2 and 6) provide 8-byte
registers, a mechanism based on the upper byte of the version register
(0x0F) has been included. The manufacturer has confirmed [1] that this
byte is always 0 for older versions, and either 0xF7 (DH parts) or 0xF9
(DK parts) is returned in newer versions (7 and 8).

Read the complete INT_EVENT registers to handle all interrupts generated
by the device and account for the hardware version to select the
register size.

Link: https://e2e.ti.com/support/power-management-group/power-management/f/power-management-forum/1346521/tps65987d-register-command-to-distinguish-between-tps6591-2-6-and-tps65987-8 [1]
Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c     | 45 ++++++++++++++++++++++++++++-----------
 drivers/usb/typec/tipd/tps6598x.h | 11 ++++++++++
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7c2f01344860..191f86da283d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -28,6 +28,7 @@
 #define TPS_REG_MODE			0x03
 #define TPS_REG_CMD1			0x08
 #define TPS_REG_DATA1			0x09
+#define TPS_REG_VERSION			0x0F
 #define TPS_REG_INT_EVENT1		0x14
 #define TPS_REG_INT_EVENT2		0x15
 #define TPS_REG_INT_MASK1		0x16
@@ -636,49 +637,67 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
+	int intev_len = TPS_65981_2_6_INTEVENT_LEN;
 	struct tps6598x *tps = data;
-	u64 event1 = 0;
-	u64 event2 = 0;
+	u64 event1[2] = { };
+	u64 event2[2] = { };
+	u32 version;
 	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = tps6598x_read32(tps, TPS_REG_VERSION, &version);
+	if (ret)
+		dev_warn(tps->dev, "%s: failed to read version (%d)\n",
+			 __func__, ret);
+
+	if (TPS_VERSION_HW_VERSION(version) == TPS_VERSION_HW_65987_8_DH ||
+	    TPS_VERSION_HW_VERSION(version) == TPS_VERSION_HW_65987_8_DK)
+		intev_len = TPS_65987_8_INTEVENT_LEN;
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
 	if (ret) {
-		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, intev_len);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
+		goto err_unlock;
+	}
+	trace_tps6598x_irq(event1[0], event2[0]);
 
-	if (!(event1 | event2))
+	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
 		goto err_unlock;
 
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, intev_len);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, intev_len);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event1[0] | event1[1] | event2[0] | event2[1])
 		return IRQ_HANDLED;
+
 	return IRQ_NONE;
 }
 
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 89b24519463a..9b23e9017452 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -253,4 +253,15 @@
 #define TPS_PTCC_DEV				2
 #define TPS_PTCC_APP				3
 
+/* Version Register */
+#define TPS_VERSION_HW_VERSION_MASK            GENMASK(31, 24)
+#define TPS_VERSION_HW_VERSION(x)              TPS_FIELD_GET(TPS_VERSION_HW_VERSION_MASK, (x))
+#define TPS_VERSION_HW_65981_2_6               0x00
+#define TPS_VERSION_HW_65987_8_DH              0xF7
+#define TPS_VERSION_HW_65987_8_DK              0xF9
+
+/* Int Event Register length */
+#define TPS_65981_2_6_INTEVENT_LEN             8
+#define TPS_65987_8_INTEVENT_LEN               11
+
 #endif /* __TPS6598X_H__ */

-- 
2.40.1


