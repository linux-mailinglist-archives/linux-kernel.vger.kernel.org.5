Return-Path: <linux-kernel+bounces-147684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0038A77AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7F71F23EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E884E1B;
	Tue, 16 Apr 2024 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="X47mKIRR"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2060.outbound.protection.outlook.com [40.92.64.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6907FBB2;
	Tue, 16 Apr 2024 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305920; cv=fail; b=IjoCspran5Gj7hWQ6E5AzhPa2H1ORooIapVJ4ZhrU9r/xOXnXOsXcwXaZfwKWDvUKEX6wwgsYEbKQlYYaQdTM3smCuH/MlVcF/PCwvJZZT/79tK44u/m41rxLh5gipC0AUMyrt1Fa+cT8smnVGj6CxFG7kM+/uyHTHq4IBj85Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305920; c=relaxed/simple;
	bh=u957a6LCwAD2/M0EcFuqornfr2q+F7TAfyjuhfQHOrU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jzWzJPncT9JogTYpo3dW2r5U7WAiKhBf1HKXJVDiaf8PhwyOAKpo8vryRI85ci58Oyffmx3SEsHCARjkzVTCR70bh45SheGHDU1KTIPuzPuZ1AjEQFNmjH9GCp/2UT+CB8X9yK3ZcrYbfMtTMRiSzi2De2lccmbVTuzRtqYAUw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=X47mKIRR; arc=fail smtp.client-ip=40.92.64.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jiltkx+P5Z7cCruKgq0nPTeoXv5inWN3KpoM0M0mZhzMNOWc0QXwVtAvIjLFHqfxeEv6rasp/TiMtYBAMlB3D85fh9nC41b42TrT4THtyplOC6AaCBGD4gKzJHcsa35Xip4CpCZZcaeMIQz/YfWJ0n0adhpbmK48toj6+YoH/sHGqLiBtlod7lRKZqzRSQs8P+/Ja0a0m40sgkLy9ecnfW0bW24DeQe1UmBYDn/DHCxwB8rDFOzWOmXmCAHXKq33p3/EUnXdyfpOiNWFVx4MYSo5/EVYjAS3Y5VFZI4apY7iN2RXwGwvnKXDU+I6gWnTUw61e9KOmrIPVl360jDK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTlTX/vvZIcrj+Yu/bocf31CSJSToK1l2b195eU/HnM=;
 b=bJ3fQOMIRjphjKPpiGgVTP6yQ3HJd43g6fvdQ154LU/FT/TCz2vL0T60BSWuX9gA5NTlLop4eTvFm+t9vwjHDj9knd40AkP0qBDnfxITUxX8E5mnlOiOzVK4anM77I1c7+dFRWIBKPpljdkNE6W+2Vg+Dd3eh5el2u2Uzm7j0D4mYLEsqNDs3uTThoI9w0POUE+kCyZTHi8xn088JG1bWAesThynXiUxEx4yJKGgRDcAOsOVMRDGhZYkDFPS4w7M8mp5iB17oQGzj4vfEDK/DrOcn80/DZvgbGZg9m6bin14uqazhpjvQrcAzRG0QbxicK6WSZnwTpWYuY4LdTZ9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTlTX/vvZIcrj+Yu/bocf31CSJSToK1l2b195eU/HnM=;
 b=X47mKIRR4JUewDwV7jrTvMtXf08dkZNYoWDTx5LhYrQ3vCcHRyyKQGJfPNQkH/UYBJxqaTsJCyIcTHPmhjWnfnFSF1Medkjl3bkD9bqwFk1F9HSj9kSycxPHEjinsfnwPOzpnf1sJBBk5kS6gS0wRYHY+5suzmQmbYD3HCCU1bg2PgzZq9PHSN2Qol5MWmEpozzpv/m/I25YDvVHlqGDP+lAsM3mN40cuCuwKcAw0Ini3UBvZCNEhRomlz2E/ZamnP2Gdjo391D3tXSZVuf5ALGYJnnMHtQjGtUmqnhBFYmpif6TWhVW+2uEl9ugSQ9pEXYwYTkUJ9nZcqwUIQb7Xw==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by DU2PR09MB5357.eurprd09.prod.outlook.com (2603:10a6:10:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 22:18:35 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 22:18:35 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: mgreer@animalcreek.com,
	krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH 0/2] trf7970a: Device tree option for RX gain reduction
Date: Wed, 17 Apr 2024 00:18:14 +0200
Message-ID:
 <AM0PR09MB26758A01161A1146EC4D46B295082@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [GLGhZnwEeKF6Xu1U1LS4/BZrlQz/uUT/NaUCm8rkdN0yOdjk8onjteufIgKKVtwE]
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <cover.1713305374.git.paul_geurts@live.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|DU2PR09MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfa34bc-e7f5-40e9-d21a-08dc5e63288b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m79ddl0QDsdGqXoYUFQN3xrT2Rt6A+HESRTZqL2MeWcosSWf5DNJw+yQIWXjNCxjSnFlSVbRy8gDVPUyBYg4nHGFcSXm1//9NnERBw+c1BgAKX2E2b0ZhB5z3TaIJpkQXS0mHGFj3hHJHGJZRw0W8UxgxB4/QKWt9pz4CCGgW4/jeOXbRrtb9LdR22fIcz4M52l1BubqCPVDKEzCzRtKu23ZjGWocGaOEiAGTtgIl6BcW8K1STyyqIUqJoQaqQoC5uOIXYcXvC67BQ6Zc/M7gjNMiIcLvzhg8urfCA+6f1VelfTOcBz5qJpbFVrH2MeNrWDyrhxojjcyJmctojLq/FlWeWWIfItWmPsbxLt/9bT5PnUxX+9hUW0qq7RUk8e2jidU3Tnc/JaLWJoMz5KWVM9rWw9JM7+Hww1jfO1jXrUK9ScOu3ib/V3ZNMHXwuq8uptZd8b8671ta0CZGa19ljXcvP75hYQ8oScqHCv71Ipq6EJ37h8VvlcZ/PTS5hW+jF2cCyvNKoSMj/NyorXe630h0MKTd5D1yrx8xiVSByuI9O8ErubFqgajcYN0yN5HvIz7pBOowKy1bLS0zZ2jt31488ptfBWJbJDa0/qTo1aAV3cqGeEkxubYEZCyaM2E
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CyBWYOr5gbzpZhCH3V3M1uyXzCzmVS+khNXPOSOy4MV/GXyu8ueICWr24rHU?=
 =?us-ascii?Q?F6uzXVK0Y9xzAo3HTciYYVndNtrdAy0ftwPR7xGZKm0AL5CdfDVcXp5/3Wf9?=
 =?us-ascii?Q?2/+tB5GDA9J23IGRjiQCa7Af3EG6GcHo/19+xpNgdKlqcGXPb6IDWHXLzk9/?=
 =?us-ascii?Q?AWScvVfsKIObsmtABf8gUnCJhktazVcK9yhCL1YQXkS/RJvDzBJtYB3aU8Oz?=
 =?us-ascii?Q?/ETU0df01yknvSaL7Qn1XMkHwrnl01sRac6E7PaY0MH+rhS0O1iZCkm5us1W?=
 =?us-ascii?Q?M0g5W+e+L/s882+wMcHhlqUl2L/xPUTalafGN2gcvRvqhb5lnWT0kTYdwOpc?=
 =?us-ascii?Q?wTcyS0WRJHOvm9WSkGmQd9iTgegyKMMQe3N8uZUZC6zLKaP87Xb1ON1cmbGk?=
 =?us-ascii?Q?8tAXe/xknC9UASmX1OMRfAnM5j8gLRhNWr/xeGJjy8RQ8+ZHIybbOJpBawjt?=
 =?us-ascii?Q?k02aSqurULHpt3zvrlJC4cz/BW956CGm5aYx/9EeKJ6KBxKJhJHmbwuWEyyo?=
 =?us-ascii?Q?GfXgOe+4kmqjN6vYoR9eMRmwsL4vJBOkLD3DeJXjtM5UApDjtAAEXJvz1oGR?=
 =?us-ascii?Q?A7eMYFBFMRfke+O13DcpdiFU7wzMuAQaVzJXYmfQVUMM+iA49tymS4QwhtvU?=
 =?us-ascii?Q?TkHJ/d4z4nZbX8jGj0bLvzdtq4+7p1YpzkHvpLZK3PLuFHFlzlpoKsV0ba3O?=
 =?us-ascii?Q?DlbTY2SD5TfiRQEqs3nuBc1DJIDBuNelBNYmUVBubkRVK0aUHbVHtI/Ld6lq?=
 =?us-ascii?Q?oI8iXzw77Q8zNzfw9M7Xy/eRDri4XoxTU48zzaiwZ6nbIdjnu/OnKm6z7f5P?=
 =?us-ascii?Q?BPOjOob+atOWP1KOQcz9TV9pOra88lQDQzwZR02DBIU0xcBYOS7gZjJKgIds?=
 =?us-ascii?Q?msCFgrf/GeUPzl2iGsmtJ4E5TZ6B30DjlLtRkmb7IRPi2J0cOnmMQS8ahhm2?=
 =?us-ascii?Q?k821crl3rFXcgZst0UXTC5vOk3XlhXan0WIwM9vCjCeeFtxFX0QozlU1b19h?=
 =?us-ascii?Q?3wQYcx5c3Fuu8I05lLJYl87PHxCfzv6B4MD8s54dT7WVvl+m4dYZlZmDxMFb?=
 =?us-ascii?Q?1oiwpylkeMbFmPh/wYUas34q9Aky4bKVR74McHyIyAhaTZBf2L010pNzu8UR?=
 =?us-ascii?Q?TYGsak5avz00rEHu0tPpFVwCVq3pq/VQ4doRHU6+MqfUJ0iTIicOAEyxCd8+?=
 =?us-ascii?Q?pWTM9No3DEZl88rLI8AuaS7PZvXOQRAj0i3RpHIfEDb5lZiPlkqNpiG6zZzu?=
 =?us-ascii?Q?SPoRBorjALSXUAz0f+emSaDXl8Zc8O4mxac8QODb5a5gC6+DiBYNzvGQdE2d?=
 =?us-ascii?Q?KHY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfa34bc-e7f5-40e9-d21a-08dc5e63288b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 22:18:35.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR09MB5357

Create a device-tree option to be able to reduce the RX antenna gain.
This reduces the sensitivity of the antenna, making it less susceptible
to disturbances.

Paul Geurts (2):
  dt-bindings: net/nfc: ti,trf7970a: Add rx-gain-reduction option
  NFC: trf7970a: Create device-tree parameter for RX gain reduction

 .../bindings/net/nfc/ti,trf7970a.yaml         |  6 ++
 drivers/nfc/trf7970a.c                        | 86 ++++++++++++++++---
 2 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.20.1


