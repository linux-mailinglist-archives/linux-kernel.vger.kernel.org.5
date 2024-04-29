Return-Path: <linux-kernel+bounces-162378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD068B5A35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080361F22105
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4B70CCC;
	Mon, 29 Apr 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="uuI0Y/gD"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2103.outbound.protection.outlook.com [40.107.7.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE4F74C09;
	Mon, 29 Apr 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397779; cv=fail; b=Nsfe7ettFa7ZdOrJHU670qInesU8v6r01K+ZZjbzV7+mRpQoa3t2/BIGk7XSXC0j9mK4zmfdWat+1FvX8MAj6gbmcyVWOL5XiYqlxK/s3ua2YTh8RM8LXGC8qaEakP6y8Ps/3BnlxEW5DfZU27YOjng0AhIGJ8xE1yDIeLWw5Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397779; c=relaxed/simple;
	bh=q4UvIumVFP5q+c4yFcY/2fIewoFcwcIboWMu/T5kPTM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ut4ubtDhF1g+Kbz8Thm5swEAF64SG5nwqj0TRuqUmzE10V490nICQ25YXxyfwL4DeuQQ2TUQmwt/rBJaiNBNuzIpvVNzlT8fBpuS+1Au1v8BtpIdetyKeBLtlaRbQSG34Ay90UHbMVjNtX5R+mEBRz2jRJkeQXHVYBxnT/7kcgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=uuI0Y/gD; arc=fail smtp.client-ip=40.107.7.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE9m1SZif8iFUztkUVkhLjRXzpPwv3fDs5lFaveBeEcPu3ZzryM1kqIu5YDucObZepNIQe035V5odEvrZPiZ6sAtvemCTAufarZ3AZHnwHSpVwOrA95DAzz8MS8shOZjpnmaNUAznhoITOYIqKaNFu6dnamI0tlIim1TsIi4lsLNw0ciqL1VGTyJ0Y+g1N3iIq+WyKxXXD5A7YPS4B5/4oR/Geh2eY1bAg1m3BYHL22C7IxQH2UmOl3h9z6mp/wSPndUePCkoR2yGP94lXJt/uVV90BUu61ZIH4uWvedpFgRskRvzSKT8bd+RNSgCcAwzhlwW2i/A+55WehmxmjSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utAkVU0RUYSHJMl20rCi1kQ8dNgRQicmHyxvIktcldY=;
 b=YgBvi3mcR1/HV2YmsaajUVqU+zG/hvmjjJ90O/rqmEX7k3VdYpmoKcVQ0gMlMZh0pdq0kZd6nh+RZ0aeIvAgHAzZpmJy40/izzSmXplQIDwrMOjxiPnQ9WuAdaawOMwTCzJnIa8PMXvHmzekqrrE0RhVRHT57c9PE9eKf7DU5Dkr6oMib5nApJg5WGSLZ19cSQZsDr7UNuYKfI8hjI9+8AGE1x/Y8rKSH1u+pNH2fHuGgKVilVA2ZCYvgtOxYSij+xdCkAWTWRawfzRqz9h1uuY85QJ5PZn7y+gqjYk6DA6P09Z5WsKij13dxdinoaLTOWpfIPCyY9LoV+ydRIuBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utAkVU0RUYSHJMl20rCi1kQ8dNgRQicmHyxvIktcldY=;
 b=uuI0Y/gDFFIMHL7wmNP5g6B9gixQYcd8q5sQk4bF4z5Q5kgd70Rn7769r4TyBUOjp70X9JU5+XMxx916UWn45EF1Ij1DE8fFBsg6ev2B5l3DqT+PA/Dt3VdZyTlo5w0+9KqZllWRINQvFhJbnslEeS3CAMdJeAHf3Nk0kB16KGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6087.eurprd08.prod.outlook.com (2603:10a6:20b:29c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:36:12 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%6]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 13:36:12 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 29 Apr 2024 15:35:59 +0200
Subject: [PATCH v3 3/3] usb: typec: tipd: rely on i2c_get_match_data()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-tps6598x_fix_event_handling-v3-3-4e8e58dce489@wolfvision.net>
References: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
In-Reply-To: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714397770; l=927;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=q4UvIumVFP5q+c4yFcY/2fIewoFcwcIboWMu/T5kPTM=;
 b=ZZNF2iqO+9kezb5j0O2E1knqIkvkmF8v5qxtxlvmbrj2ylHO9CMDZHlh234dDEVS9xct+6VhX
 pa5yLtH6+ikCP+0V12VtpGyWLG1CFlgu6zjxnRDQJBCtX1BD0x7dy4R
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
X-MS-Office365-Filtering-Correlation-Id: 111cd21e-6f02-49a1-d541-08dc68515552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUNubnRwY0xZL2xxVUdkbEU2SE9KOHJLekNqOVBHSkt6WVVRVThYakorQmVq?=
 =?utf-8?B?ak90OW1FTnRyUXU2TjRITHlPc21tN1hTZFRzcU8rRXEvVDZjNVRWbkk0UFZv?=
 =?utf-8?B?ZDRPZHM4VWlpeEFsVEthQUFJYmRCa2dTVWJ6WU1xU0hhSUVOeVZ1djEzVitj?=
 =?utf-8?B?Z0Zudm9zczV1aXdwMmtBMVdtN0RxSWpQUXFEcmFNUXJxQVM5eEFoL2UwV09Z?=
 =?utf-8?B?ajhDZDRmL1ZsSWtOMzg3b0ZvTXlvT1JaS1Bjd0tZUEVvNHRqQkNFZVBOQ3M4?=
 =?utf-8?B?cnQxKzhSY0hSTnJDUGxlemRmdTk4M0dtaWg0dmtjVUlJbFVsMktNQ2RHM1ZO?=
 =?utf-8?B?OGd6ZnpqdkZLK3l0c1lDbGNMTDQ1OWxYVnFDclkvZkZQMlREZm9XNnZ5ekR5?=
 =?utf-8?B?NVY5SmdaV1EyRzRhKzlzeElnTU9wRGJSRnZHN1JRS1o3b3BQa3RqN0Q0R2Uz?=
 =?utf-8?B?UTF2Y1E2UDFXRkhweldDRmo2TVRkbGIyQmZvS0RObGRBUWpIOGZKT1BFWmlR?=
 =?utf-8?B?Q2pYcGcxYjk4clRCNHErQlkzS2VGRkhobXdqSGpQZnBHaEI0L3c2TDE2bHlP?=
 =?utf-8?B?d1pFM2FldzBYZ1E1RFFJZ2ovVytGRnN4VXlsQVQ1dFZkTTVjSitrVlIxTndr?=
 =?utf-8?B?WDU2Z3I1dVF1MGlHVE85NEh5cG1wT0lsajI2TXVlUXN6ajBpT0FxdkU5VTMz?=
 =?utf-8?B?a3c3S3dnTmsvMEVKVTRHRmpwdVV1cFRmUHREUkhrTTBxa0V1SENQVXUwNk9y?=
 =?utf-8?B?ZDVXQWV5MGg0ZHczSkw3NklGRUZ1UXJ0cnNYME1PZUhLelRhajl3YTV1OFF1?=
 =?utf-8?B?QURWSFNnM1F2dTlrRGk2ZWRuRGVmNGVHcG9BeTBvd2VZS0ZRRzRvRW9IeE5l?=
 =?utf-8?B?RFhnRHZOYkZ4djVWTkZKSk1lNk9udWtlMGFDc2szUHcwZUVxRExmU3lya2xt?=
 =?utf-8?B?Z1FFVkxWUUExcGZ6Q1dWeVJlZUoyT0U0blF5U3BUU216Vmxmdkd0MlFheitB?=
 =?utf-8?B?bFpiVlpLcU5YcDgrcWNRMmtLWmpBTVIxUHJ0YmNCbm4zT1pqTEJvcmFSUzRx?=
 =?utf-8?B?bmhyWmJ3aXJVN2ZkVVZjVmFTOStsSGlqSnlSeXBrMlZSVFNwWjVUTXIyV29I?=
 =?utf-8?B?Wkx3VUl5eGc0UWhYUVFibytnbC9YTW92WlR3MHNvNHcyTDQ4TUNLN3FPbk5X?=
 =?utf-8?B?MWdEZWVGdXFOelJRQ3NUOXlyOUxJNmwrYjRzWTQ3V1drRXBOT09VVmVEQXpO?=
 =?utf-8?B?Q2U3cTI3NmFEcGo4d0kwMWk0TUIwdndHTG1UMEIvSG54TERqbHplOWlKdG44?=
 =?utf-8?B?Wm0rUDZTVUdidFYvcTh4WkZwUjJlcHJPY21KSk9JUm1XbkpkdE55a0ZmU2tY?=
 =?utf-8?B?aEE5OFlOY3RQRVBqQmZHd2pTdGRXeWp3UTFaWWVaUTZQRVRzMFpuNXh6TVRL?=
 =?utf-8?B?cWx0a3hFVDZ2QzRubkcrUUZ0TnFqdHJuRFY3OThHZmxtVktIQ3pXS1pzOU5O?=
 =?utf-8?B?YlRpVGJKUTFRb01VVkdZeStjUkRyMVF6YXZVMkoreGsxUEZvelFlVmhUdDRT?=
 =?utf-8?B?M3VreFVWb29FNHkvRks5cHorVitwVXFRZzVUMHMyTjJHWElYMHI0Z3BCay96?=
 =?utf-8?B?d0syc2lyNm9YVVZieHYzSWJtT0w5Y0NWOEEvZFk5UFFDN0VCRHkzL0xiejYw?=
 =?utf-8?B?djNubnc2R0JydlBhVmViemMvditLck9OczlPRmZpQWtHbUQ4eXlaRVMrR25u?=
 =?utf-8?B?eENCZU14UXdKOERJb1pSMjEzNWYzcDh1Um04SjR4L3cwMHU1Q2h4bW55aGJp?=
 =?utf-8?B?eksxc1krQVlnK3lOM1RQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTJjdG1CamZjTmpMd2ZucEtTSEZxeFZwQUpjNFdROWpBeDUzcVF2VVVSTzY1?=
 =?utf-8?B?SjBhM2lFNVdUa0Y5dlpOUUxoZGNlTlc5NkxyYndqQjR3WThJNFdkeWNxNGpC?=
 =?utf-8?B?YmY0SGxoVHpkVkpvUlByMGlKc3lzd3dST05ZeEpqRkJyaDF3RER6d2dGZDBs?=
 =?utf-8?B?L0d6R1hZSGRxbUxIS0lCQUthbE5XRy9OOWhUeUdKQ0I3Q3Nmb21SYjhBeVh0?=
 =?utf-8?B?RXYrbDVTNzlPRmRuSGRuS0JvZVVHVFhHTWxlNEhCVEJobVNPcTUweUFJWWkw?=
 =?utf-8?B?M1dRY0JlcWNkSTJMelQxRXd0MERROGc4UG9qa3QzaHFaeHF6WC84VkhrTXZB?=
 =?utf-8?B?OHZvYUFuMGpoM2F1L2t1eEFVTmNTaW0yQnZ4dDdiT056bFJvd3BEOXFkYXlO?=
 =?utf-8?B?RUJpbTlkWjUxS2Jqa293NytrR0ZLOWwvMCs5WHlRMVg1WHFJb1ViVy9hYzAx?=
 =?utf-8?B?Lzk0eGhabFJvaVV4bmhQU1MrKzVpVmYrVGpkeTc1Vzc0VzE4cTQ2SGpiZlUv?=
 =?utf-8?B?QWpGRXEvbWY3dU42RzhSL0k5b2xBMllvT09WR3MrQnFQT25uWHBBNld5bXZP?=
 =?utf-8?B?T1NGdExucmRRQ0JIQ1FlbGlxSXZLbEMwemFtQ0trOEZENTVTZmc4bElzSzE3?=
 =?utf-8?B?bkJEWkVVOFlGOXcyckVBWEJhcjZXdVFJMXhWTUU1SnFoUFR3dlVKN09XMnlQ?=
 =?utf-8?B?L1QrU21Qb1VKN1dBcS9sZ0JkaFUweE9ENk1MSHc4NzZwZ2Q0YldTZnlIS2ha?=
 =?utf-8?B?UUxQdDYrL0JmQ2ZDWkdneGYzTk9sNnhOazZtaEtrMnBSbFVzUWREZW81UXQ1?=
 =?utf-8?B?WXRjcy9KRGRNNVpVS2wyd0svL25LWjZPcjR4VDJNRklFbTF4OEpHY25sL3Ix?=
 =?utf-8?B?T0t0Y1RMOS80NWF2RFpsK0pFWWtKODBIa01nVnBZOWFscW5YSEJrVExyaUx2?=
 =?utf-8?B?Vi9lVFJUZFYxWTNKZi9UNW16ckxSTmYyalo3SzNhWjM2M0ZuV1hTM2JIVzdi?=
 =?utf-8?B?aXd5M3J3dnRNTFhIMElET2lOVGNCRGI5eFg3YWJ0aDZUdStxaHFVdWFwdXhl?=
 =?utf-8?B?MG5Oa2ZVZUZ3NU1JWkJSemplbXBrVDgveGF0L0JxNkN1MkVaNm0rTUpZTys2?=
 =?utf-8?B?MjZiSEk1eGFFWWpjaDR2S3lHTGZsb2crNkVOZ1cxM3RBcVZvNlJFYTFCeEtX?=
 =?utf-8?B?TnRVeW92MFBMU2xoNndUVVVvcENGQmZCRDg2SGRTM0dXWnc0dUVNZDYrQXZ0?=
 =?utf-8?B?ajBLTWxnL25BRGt5djZPblJDYk9sMUhzVGUzMG0zR25FU1c5eG56bU1QM29I?=
 =?utf-8?B?SnVRRmtOUEQ5VnJ6ZkZtdmgrbVQ1aVNiOHFqNEtuS2E3bGdmY2FkVW12QmNj?=
 =?utf-8?B?L2p6dEFEZ1Z2Y3YwVVkyRDZEMHl1Wjc3UXdzZjBJakNGa0pDdWx0bGF4aWtP?=
 =?utf-8?B?UnRacU55Tk1QcTIwOEsvc2tlQWRXWURwcWVieldqNFNNOUkxSHFjUE12cm5C?=
 =?utf-8?B?Q0NGZGdjaWVwM3pqd3NvdFFWc0Fham5SK2Vpb0tsMWdxbWhLdVc1dGhGUVZV?=
 =?utf-8?B?dTMvM1BVUjFrc0VKNW8yd3VzQytleU1GOVgrZlBxVmRrR05WejJpR2JBWjgz?=
 =?utf-8?B?S3RmK1dQd0g4ZkQ1aVZZR3VaSWtoOVpETDBnZ2VrTW1mSmVIaThyL093KzA4?=
 =?utf-8?B?WXliN3hQekU1Ymh3YTFqWjhYY1cyWmZra2k4dGRNa3M5RDdqT2xYdTUxQVNk?=
 =?utf-8?B?V1ErQ3RXVURyWDBoSk1MaVY0WnlYcWE1Mk9wWExiT1ZhdDEzckNSMkQ0clRq?=
 =?utf-8?B?aEV3WTFqN0tjUGdMV2wvcWNIVmJsWkFXOEVJTEVBM1V3WS8vSXVSSEJMYVFa?=
 =?utf-8?B?SUFvYzhhb0g3emFUZkU0eGZBVTZ1amg5aG5Hb1hpRFp3WjM5K3V4VEJIUnAy?=
 =?utf-8?B?eXRKNWU5VlFkYzBPcjU3MDRaci9seFZkMmlkYWVDVEhObFFNeUJMSlhuamUv?=
 =?utf-8?B?dHpkV2JVdllLZEZwL1NjaUFKbkJRRmtzTDhXUUVubFhYeTR4UDJzcUVMeGx5?=
 =?utf-8?B?U1ZwWkNFVzhkYXFrYjE2YWN3b1lSODVxVVFBTFNUQ0duUDlkSTFLV3dzSGFv?=
 =?utf-8?B?SFJnNWsxMy9Lb1h2bUx6QnorbmJ2UGNWaitLZnpxUlNPbnRsbHJsMHd5RWxD?=
 =?utf-8?Q?lOxJzDgTB6l4z5owUAnRb3A=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 111cd21e-6f02-49a1-d541-08dc68515552
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:36:11.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN2gDpkEJaPHEWGryp4Am9PHVgtP1P4bETuMaNbhBrSBVjgMQyG2Dvjxi3hRGJHCdVZcxmjCTnc7ln6LH9E8gUG0L62oj6JwIVbj71D065o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6087

The first thing i2c_get_match_data() does is calling
device_get_match_data(), which already checks if there is a fwnode.

Remove explicit usage of device_get_match_data() as it is already
included in i2c_get_match_data().

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 191f86da283d..ad76dbd20e65 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1365,10 +1365,7 @@ static int tps6598x_probe(struct i2c_client *client)
 			TPS_REG_INT_PLUG_EVENT;
 	}
 
-	if (dev_fwnode(tps->dev))
-		tps->data = device_get_match_data(tps->dev);
-	else
-		tps->data = i2c_get_match_data(client);
+	tps->data = i2c_get_match_data(client);
 	if (!tps->data)
 		return -EINVAL;
 

-- 
2.40.1


