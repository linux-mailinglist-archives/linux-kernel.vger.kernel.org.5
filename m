Return-Path: <linux-kernel+bounces-165535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D99E8B8DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B68286094
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0412FF87;
	Wed,  1 May 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="XCUEXb6I"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2067.outbound.protection.outlook.com [40.92.18.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F04CE1F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579517; cv=fail; b=D7gapRdjFJ0kptmErqk+2ejd+v7jLlk31DU1UoqnkYHezVlo/brugHYb7oTr9WakCVRbJK1sGdTMThCuawemmo7Ej4TnRvBPbcGCr9OKm/ZwHjyA+efSlGF3a80Gw4eSjrB2UxrKuzwMWBxO2aERhZ05zYMNJjhe4vWUH1P3p78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579517; c=relaxed/simple;
	bh=POf6O9lhlbf7EFAREFLGpZzgKKGKEjZLPM0ZyEQKrV0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mUKTkdbJKrFxVi+O52ov4oCUcT7w8gn7Fcp83BOicHsN1cw8QzQ2abAvcrILWiOHnYD1lELg6m0CAiWPI2teP0qS0OE7hqpnGGDYOq2tMj/OvNFw30RLgT6s9dKzxxP3xPtARfVJ83RCZBQWXCewkzHc0eEslxUg9dujHqVBVg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=XCUEXb6I; arc=fail smtp.client-ip=40.92.18.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEGMrqCBWwdpzs6EYVO18YJW2SHVQryIH5jcJW1hMAllPcfDVC/QUku4C3Vpnw9aY3U8vsVLHB2c5AwNc9IOggeMvGqo8nqZIXjqWuoxG4Z4S3mN49/yFVu0At6TAxLNTE1h5ojweHIbgwIMFeYRkmJk+bK6RHl+4XUNxysKUoGxROnMrP5FZi0ThmY3oK+q1/cpx3ctbyGQ3WCJJoOSTJWipl8TXb8NjGp7SPYzQc4LkC4tKv4bLTTSqjfVMh3Qf90XyZ8oWc8wOu+pKGC8JR8QAGI4c94UjewzHGziR5Mk57zN9ddlgTBMwUls01UpRcRNPzlyzsWWrliqEs0bZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgxfsMGQG2FnTziuTl9Uy0JDar47L9rSnEk49NhvlbY=;
 b=nQ52KgPsFaHv0g9uWn9ZBHoeRsjfaOm67NaSdh7O29oqvKQa0P9mX+xE89Bc8usoS2DBFpIkMxZwjc8ocd1qWRVH0ryzJgp1aLXjo9syJeYGiUlz9ErIzolSJmT6Nxsm+pfAlWAD+qDw0H8w76x1exTGnuMMMu4VVO1xN+bNYQJ5jJcnvIETWVwjLMRRbmwWI3f7NVJA51iONDfxaXg8WyA08cFyzagYLMDbN/c8sliMWch5L3EegwwUcJ6ui6yW+wHMnrtgA/ykjKsIbG34mexNFOTtwwbitvGlB0sPe1bqVUbRgbY3dHyouf+D8oP0PTWKl5hzGwFjWQKxTxrCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgxfsMGQG2FnTziuTl9Uy0JDar47L9rSnEk49NhvlbY=;
 b=XCUEXb6I6wY/5dzt91ZiCs3v862Chq6mBzEAITxGAyPn699fvfMXMTjRT3Z/AHX7iS928v6Vj3NNfAw+K1PVljIa+jaA4n/AP6utuvEzT1IR18VeAOvQMqOsY6ed/ThP2nQiUS/uHir16PRazGO3mooMQ8ord2RMCDDb1+GM4+ZomF+3K3hadhtwEEmANSB4L9ITZ5AgUzSD6U3SmLmcXmJG/aUf2fMCBBpC+DZyDa4Hlo4x7G2EVCp5G1r4qJDcIAUDA6ibanoruy2a6GMkSPoVjz8bNIYqwUu4jn9S96Pq9xDynycjwsGByDasRXYB5xb1Y+h1IQ6RtzxsdtDr2A==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:05:15 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:05:15 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <lnimi@hotmail.com>
Subject: [PATCH mfd v1 0/2] mfd: rsmu: support SMBus and FemtoClock3
Date: Wed,  1 May 2024 12:04:56 -0400
Message-ID:
 <LV3P220MB1202A06AE7281C840395E462A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [J0ZQ5+vcDWbjJ2BQv8dGzTm9jSQFg8do]
X-ClientProxiedBy: MN2PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:208:fc::25) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160458.27588-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9148a861-a79c-42ae-620b-08dc69f87cd4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	hbnusCxmzxpt9v6KNLIeSMrYQM6AcbMNKI/F+Y+4CuqL/RGJMenoH8EXJupmN0BWw6O8kw951J4NgVlsmKtCmzovP5bYddnvRY6sU2ME5EAwvmhDBSI1WUAhTlZ8+Emc43omuLJE7NmZMG+EdavxHlMw8ljNHaqSF2yXVh0srzGO8FzJgzycSqa2A+M4pIvRtI8qEKqp+oF8aGpGqYJ0diGkmwMuUbkkL6N7grY54WwOr5o0v6QtWtTO5tERGk4izgjI9QZ34IXpjRopS/iJpuS47q9DZtFvCEI8Dj4SAYfUObJ35k/KHEj2aAlkp50YINNf9bhOaN2nIW4zTEnXdhHkKt/3WC2U2CrRr/lc7yFiKgk0Y4HAupmAJ0v/gLKoHiiMw+fnjhKle2ycQjmCO07FC+fnkEscIkSjQge64iXHpbbDXK0O0KD1NVZfRqCDIN0KEgK0M+Ab3//5C3wE07AwGcCmR43THDwYyR2JsWmOopMp4RPAV7ZZ6xlPY9I+NCZV9BHatzYfJSBR1LG/IToJDzEa1Gvzn9o9leD6vhQSUBf6zmCS+4/NOZsEaBRDpO67ZegT8m7Mhz1xfpMeiNcITMSXd6fWnBTfsdwki+o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H9rWG3cXEJ+5GysviadZ2nooqlDMv9anWa/t1ty35BupXboMcdF4jqo2yWGW?=
 =?us-ascii?Q?qkRk/2UI2zlZIH6oM7/D88QKDyWDZeRo9n3aMlu+gRKM8xGpZghNfZ42dlAb?=
 =?us-ascii?Q?1znfp3mMr9eU8uy/gFaWpGP0aM51ymh5jOQhFEoIB5dxXdOUtmd/sZJJ/dQo?=
 =?us-ascii?Q?a+c60J/bljiN+csc/ljqR8iCJmlyTyfLfUZIYf+ijCnWi1YunkgUzd5UGu1d?=
 =?us-ascii?Q?PseePmISrcq8CYPBeq4Kqo0nN6QVPh7P4khyIh7KfnU2uZDlIcAymhcEM2Ro?=
 =?us-ascii?Q?ZGWWy/z8UlMhfcOvQmIJHR3br/5Y4Hy0RP0Lmnai18Wn6ysMZcu/JDDMK7WA?=
 =?us-ascii?Q?UN+14WqtTijsIk/pv3lNmdlxCjxE5StkbJi/+qxL605+RJgLo4s1LrLjjU7V?=
 =?us-ascii?Q?fkdTqDL9M1oxHHJEroUwIEthxdkL7qi5wtfonEsmNZGaz1coORKPKXosXAe5?=
 =?us-ascii?Q?xoTFYUbzT2f6ggb2HFGpKUm/RncoEOo9GgJItkcBbB7dlzEQKR0NFJ/yqIPr?=
 =?us-ascii?Q?OBLfWCT3izi0Wml7dReM47+TcFjfs04uGpe0yOoEyCIDe9Dg/4VtNnMnalRp?=
 =?us-ascii?Q?raQq7l8O6qvNHCXcTcqu/SCQiX+9+5gWwnTscwxII+ABq2o4+YqpmmqmEoV3?=
 =?us-ascii?Q?7z5SpbLiNxzXISUm6hDfJm6XU0//ERRo0Di2LTdUNueU0jWuzzVYnQAy5HFK?=
 =?us-ascii?Q?DwxVN8msqs/iW/o6O4lNTJTaIe7YJ6Yfk1S7dr3lruRDmcaLfAZpQJuk7S/M?=
 =?us-ascii?Q?t/fUp7L2NPbO+YN67KyzZ/76zR2spH6OIwPJjZrDp98I7dLl6n9DgOTPEwed?=
 =?us-ascii?Q?nvsIyOkLqzMLbMIAh9J1nqhI4cs9gl8pJUi+Jmfzy4zUUnm5UVeSOX8TMtS5?=
 =?us-ascii?Q?/8nMzWQfWzI9ZidOM8+aSug7FxulikvzkAslQ9OAtAu/vPThMClcEcnEu6k1?=
 =?us-ascii?Q?1zfKwdNatTSpy/qRJU6Ifyx2dnmQFyiG5BIC/c40g6m7RJZPdqtmzh4h4+bu?=
 =?us-ascii?Q?N2wOsv5QO+xYHQrK+nyUEWkYxTFw4xJpQcgg+AI2dNMtGZXxXwES1RO7AafJ?=
 =?us-ascii?Q?svQLYe30zWbSoeieWAadJ7WTURDUW7jtGR6FLcjxIj3QLsnbUTy5jIl0fo8s?=
 =?us-ascii?Q?MpjVK87Jtp9HseO4wedBRyPcRLRhJ0WJxtqMVAwyx5hYcCmyt1ttPPqMOu1y?=
 =?us-ascii?Q?1CdlxKVMbqMqLHhLMFCgMi0ggUiPhVQp7vN4XqCheDiiax0oGY1Di3YLAeg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9148a861-a79c-42ae-620b-08dc69f87cd4
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:05:14.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

Min Li (2):
  mfd: rsmu: support I2C SMBus access
  mfd: rsmu: add FemtoClock3 support

 drivers/mfd/rsmu_core.c  |  10 ++--
 drivers/mfd/rsmu_i2c.c   | 123 ++++++++++++++++++++++++++++++++-------
 drivers/mfd/rsmu_spi.c   |   8 +--
 include/linux/mfd/rsmu.h |   4 +-
 4 files changed, 112 insertions(+), 33 deletions(-)

-- 
2.39.2


