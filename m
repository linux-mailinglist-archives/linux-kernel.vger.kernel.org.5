Return-Path: <linux-kernel+bounces-123309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1389065E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD522B21D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA73BBF4;
	Thu, 28 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="YQea2o48"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D32BA53;
	Thu, 28 Mar 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644969; cv=fail; b=oqwYsd83E5zoMvVtPXzmEinS341WEzjjW3YbEyjC7cWxDGvCGdMljUT6MjBSA/2kMPTcR+EMKYiP4jHfY31cYXuF1VOtaxN3rdVFPoD+RxDXl8630he1In/hGypla5CGo9MQlv30cDWnfQL/8Py9JpZRzjVLbC0elAjt5KKMCGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644969; c=relaxed/simple;
	bh=Y+1nHQlsCqTF+e88UsG95bmHOye8o5TDSIbzubQbwIo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uiY9ec9aL6kHV4SgFoqlSXZShsAA0TjVwyQ2uSkGAoq0haAD/b8sOpvHU9j1n3NDpt5O2zUMt4r8ZmLqUMc1EMI2OKFv0ikH6ya43GXk2b2qmae+QpwYTVMNnYSxSJuSOHp8c9MqztbdjDI/ETt7qh7lHT/ivR3xlDo2n58mg+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=YQea2o48; arc=fail smtp.client-ip=40.107.20.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOMMya0b7zRAFnH1jqVx3bG/J9qz5NGE6ozq+RL14bx48Bczbqf0C8tkGm8fVVNcGjAPLm7tSGkmnn/xpcV+YplDrfmKh7IJ3AbjG8NyJotNYGol0+MfXV+AoUutkjEEQJWR8GBBV3QM1McErPxXyWC7+rTJDqs0SUObI2Wcw1shVodAnSbW9ShHptutmAOacs/SkbAHVrczhe7CDrjTjS0H2FPFbzpTu8Ok9xPNcMAgn0uq+6HuUwEsLxX+6Sh73mt7Q1AKkA23KXJ+ZdfVMGzm7Cp6tEfgefDBDxWLzAhGCRJjiBqHhvpsWsI1eCV51Vc4+S8p7HAlRH1msKEh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tg7I8tZRCyRWzwjNSEZnzQHbkHz9Y+LTHE0QbazzlU=;
 b=A3UHJZf7j6UPqzXHHvjUWnO/2Mqypq1QFJfctwLJnWrdAttF7c/T8R4jYBlCKUC8j+/N4Ldz9V5cf6IXUH8UyEi30PzDNgG5a6WVVdoiSLNPAdI/YDsl6/1w953rhrMaOay4+ibK/T1JBr6Mzgs2QbWNwYT7527UWmbNQCMbJWEhE9Yu9aS0yQP3VDK9a7h8+GjAGoBJ8W7eRcYLRG+f6dwvpM8pMDLpFQGGbny/xDg0BI//EMvsJIDPx6oc7G3215eEqUEhyylgbpgSVQzYkYtzgs5JdIFPppwknZ9QEaD+6AtpPVYQwBHZ7sE/zxBEwKEl8Vxn9KPt2CBRHDF4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tg7I8tZRCyRWzwjNSEZnzQHbkHz9Y+LTHE0QbazzlU=;
 b=YQea2o48YvbFEH6E+bYrsXPjJzJJK8UtSwAsYQPU0Kxie7uFyqXlBEjdlMXcmHe2SwuEvn5ZsHb0eRUmx5AGyNd4pPuShXkA605QElxHHRCCohR/Tkma21og1Mh5p4+gpyNatY3rd4eGrsaQTGcnHgVGC9eFaYV5pyf306q4ph4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB10147.eurprd08.prod.outlook.com (2603:10a6:800:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 16:56:03 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:56:03 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH RESEND 0/2] usb: typec: tipd: fix event checking in
 interrupt service routines
Date: Thu, 28 Mar 2024 17:55:50 +0100
Message-Id: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABahBWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyML3ZKCYjNTS4uK+LTMivjUstS8knigupSczLx0XWNjS4sU4xQLozQ
 LUyWgCQVFqUBVYNOjlYJcg139XJRia2sBEkR1P3UAAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711644963; l=1586;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=Y+1nHQlsCqTF+e88UsG95bmHOye8o5TDSIbzubQbwIo=;
 b=vynD2T6S3d2vSiqDJ9OvwB+jo0huZ7sL3CiG/kqzs7e5fQjGT6jgaul3nsCXJWRqMTRGeno12
 zT8EZ2/H+4BCx9pFEP+zZr34yhlxcKUGlkTwh0CKZvvWC6yhXKpMrRY
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:802:16::23) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB10147:EE_
X-MS-Office365-Filtering-Correlation-Id: 78943a57-7016-44b6-dfe3-08dc4f47f411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3fJI+b2yzidJ/iqi6jfYrWN/1RNF0nJt6isnlJ09+fleL2TMAy+YP6rO66GdPcaX1qolW4vOLdNNv1k+1hiB3iD1B0URIiDMkJ41VQk0Xk3iJrYl8xPw3yuPgdjk+wG/lyYmTKksTv+57QlZNvgh+FYywJBfF86f84lN5JB7JgO2Km9DKDuQWlUgrUmldU7HWYBi7gG8qlPx8BBNyD55iauPq8gxp+jXx6vuGVbkygWp4/eEXaw74hg112vkWusfdI1v/ddUi6o/NMIgkKmmP91rOKmabLhGw61uxxiFQk+XTZR5OU6Q0a2UPxn3eZ3tZCqofTPHM7tQuYm8DOlbiulDPb7/6d1+xUCAdHFJuVZZJ5tVUlOmu0FY6rT48CaPie9X66Q/aMRUymmDQuAaw3T7xtInHazUXPqH2MFHJTVitIsQbBr7DtTZ2OGLGYt/YnOewoJB5lCVA9UH+bpiZZiYnyfsDFLgzgs4npJ1n4z8sAWgZ/c5P/BInl69gOKr6JQ1N6YoJdQBZNlivw9oKLiFxiGZssuo7DJprjJr4poUvAxtxVNgarcBCG4Zj1c1iS8F1b7xcyfY8N4ZgVu0iUyaoljN6IaWDVbNNHnY+aMYdHEwl8q4anVwR5u044HpK6AgyQ94uwWi+EhUHcz5i0qoy/I4b+VFBrLlZnnbY3axOPOWc7+uarLalvLej9qBxbf15BfLnTI9bghPC1Mx8lSukPXohspWt5wzAL7n5BQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUgyRGRGalhIcjY5VnhKTFIvMU1QT1pPR2xRNGloTmJReVVzMzliTlhFTGZo?=
 =?utf-8?B?dENlYllnVStBYUdqUVRKbEphaituS0hmQlhrWFlWa0lNZ1A1RFFaVkZmdlI1?=
 =?utf-8?B?RzVNYUJMdnhtTXhQMmFSeWdXYjUwaFFiaTdqS2dueGtZUEZwb1RLUXNiVHgx?=
 =?utf-8?B?UnBZMTdORHhnNjNUSXg3VzliOHNRb2RoeGZ1cGQwQm1aQmcwSDZteTNOdks2?=
 =?utf-8?B?RjhNWTlqM3FESXdlNjJRZldUZlBWc0RwaDVBOVVvTzdSbVBEdDJHUkQrdzI3?=
 =?utf-8?B?Ym1SOEFkeFh3TGk3WFZvc2tPRDJiL09HcEY2aHZEWWZFNENTZlg4UGNEYkNW?=
 =?utf-8?B?K3gyUHZGbEtBQWl1U2F1YlFtT24vRkprUUhmZGoyOEo2N1R1WklkRUNycS9B?=
 =?utf-8?B?WFM1TzZMZ0VMTHFTSkMwbGtPaXdNeGhWWllXcmZaK1U4bkdYMkV1QlpLcmJF?=
 =?utf-8?B?bnUzOE9NbW9ITFUxbnJVdTBoUUgxRDNhVHVPUnRhaEU5czNEMXNkWElRb25M?=
 =?utf-8?B?c3ZyWlg0N25XSmx4bnM4d0JFRHd0ZzJMSlhsSFF2S0dYTEp5NFEwUDVSazEr?=
 =?utf-8?B?M3hZL1JMSlJNWUdjQ3J2b01NOFJSa2dudGI5TENEVUdsTDlCeUFhbjVPaW9N?=
 =?utf-8?B?VFJyeG11bVcyZlhoZjYwMEZLTDZGL1UvK283aXpOYVQ1eStjVENCeFR5N1l1?=
 =?utf-8?B?VTVWaEwxOTJ5STRmVW1aMWtDOUxyY2pXdkpsL2plQkdTNGw1eDZPUWFiS2JU?=
 =?utf-8?B?QVVvMjN3M2FQbDAreS84T21Qc1o5blhldWxSNTFtc0w2ai85RWF5TlU5Nitp?=
 =?utf-8?B?MkJubE5sZ1dWRXNVc0xObFc3OW5peE5qMWp3NjdtOWJTeHdUTEZQbVpXQ3lv?=
 =?utf-8?B?aFRoc1VJV3dYNVN5UzVEaUcxVTQ0L3Rqc3FrOGY1RGNnU2dJL2hPL3dYZWNL?=
 =?utf-8?B?TWxwT0VNL1hzY1loVTBBTGRubEtDU1pMeDNvMlBDdzVMV0wwblB4SE8vVXVw?=
 =?utf-8?B?d0dOcjB5UUgxcXhhbHdOZkRwdUx0VlREYy9RN2l2S2ZGdGhVQ2JSQWhJdStQ?=
 =?utf-8?B?USt1M1Q1WHIydTVwZkZoS0VEQ1NGK2lhZ0Jza25IWkRUb1VId0kzazJmYzhX?=
 =?utf-8?B?YUlIRDJBZXgxb3Y2Qk9nN2I3UUhnajNsN29rYVF3bjIvZ3YwR2d2WHY1SWZP?=
 =?utf-8?B?aHNob0FYaStaSXZjaTlkYWhDdityN0FzQzZHaUNKZHlkL0pVclZxbzgwQU4y?=
 =?utf-8?B?Y3l3RFNLOHpQMVREVjN0Q2lwTndSbVA1OGJrNytlV1NOM2ZWV1VLN2pSNzho?=
 =?utf-8?B?OEczSGtaTU1yZDVKa2pVaEFWYTJHNjlQMjduaUdpRkwydFBZZUl1TFlVc0Vm?=
 =?utf-8?B?RGY0UktHN0lCSXBuSTBlWDdnRHZPUTAwZW90TEhaZWJUTUNLV3pHRUJJNFBo?=
 =?utf-8?B?Mm9Fa3FOZVY1UURHcXBXRUR4M1cyWXp3ZlZxQ3VWcHZJY1k2dVd3ajdiOWtn?=
 =?utf-8?B?VjdqZmpBS2xyZXI2bHhONzVZU0xKZ1pYZEhOd3dQS0JmVUJYN2tCWStKZENs?=
 =?utf-8?B?QXFiMkpRdmNpanFUWUdFYUJqQkt3QUZIaG5RS1laU24xekllby9LTGFlRm45?=
 =?utf-8?B?c2hUZHhqSlBEaW5IWGJqenpQQWQxZExldXltU0kzaHlsQUttMU8zd3BnMDhG?=
 =?utf-8?B?S0pIMHlOazkySSt1WTdNSmk2QktKQ0J0S2hIRHBMc0dlQ25YWEszN2diejRv?=
 =?utf-8?B?d0ovSTR2Q0tDRnBWV1VvY3RBSC8ydzZHRGtNb3VsaURTVk5jaW5UanVpbFk2?=
 =?utf-8?B?T2xCd0xaa1k0Q3UxeWpZU2lmWkthUGluRzcreFFTSStNblVJbEc4aHdXTWdG?=
 =?utf-8?B?U3RNL2o4Q21pYW0xQVFKN1JBSSt3RkZzaForM0tSQzFZU2NNS3NKNVhxMjV3?=
 =?utf-8?B?OU1UZFVnb2xrVGdqNjVoT1FoMVE2UTliTkNlMEhEMmVkOUp0NkxqaU5lOVhW?=
 =?utf-8?B?anlqdDRDMTBNSGlTWEUyL3JLdWt0MVI1UHNKeDBqNG8zeWlKRjd5dDY1UGUz?=
 =?utf-8?B?cUZKVC9MME1zLzZjUVRiMVM0UFk4dzJIVnVyZklsdDhVNzBkZngzK1NBT0U3?=
 =?utf-8?B?SkxUMGFKNGNDcndJT2hMRnorZlZ4TjVkNzZKZ1c4UnVXd1paMk52RHBjN0Zi?=
 =?utf-8?Q?Vu1tqY6rMGf6F2jMQQ/WnRs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 78943a57-7016-44b6-dfe3-08dc4f47f411
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:56:03.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a430X1iRk3YMKjVGZHQGdpbMLKeI8BMfl/Qj1MBt+uhcrASKffpnTJBJotbMGQwD27WNGQmg90RF6dRDZLg/wcX0GAJ1vUe4aesmqxcp5XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10147

The ISRs of the tps25750 and tps6598x do not handle generated events
properly under all circumstances.

The tps6598x ISR does not read all bits of the INT_EVENTX registers,
leaving events signaled with bits above 64 unattended. Moreover, these
events are not cleared, leaving the interrupt enabled.

The tps25750 reads all bits of the INT_EVENT1 register, but the event
checking is not right because the same event is checked in two different
regions of the same register by means of an OR operation.

This series aims to fix both issues by reading all bits of the
INT_EVENTX registers, and limiting the event checking to the region
where the supported events are defined (currently they are limited to
the first 64 bits of the registers, as the are defined as BIT_ULL()).

If the need for events above the first 64 bits of the INT_EVENTX
registers arises, a different mechanism might be required. But for the
current needs, all definitions can be left as they are.

Note: resend to add the Cc tag for 'stable' (fixes in the series).

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (2):
      usb: typec: tipd: fix event checking for tps25750
      usb: typec: tipd: fix event checking for tps6598x

 drivers/usb/typec/tipd/core.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240328-tps6598x_fix_event_handling-3398d3d82f85

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


