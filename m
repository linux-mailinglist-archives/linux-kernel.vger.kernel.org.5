Return-Path: <linux-kernel+bounces-59172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D2684F287
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0DF28A018
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CC67C67;
	Fri,  9 Feb 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="QmMGxGzV"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB546679E2;
	Fri,  9 Feb 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472057; cv=fail; b=DuJbZI9vkR2Zm824L4R4e91cLxxEhv0hfHrXxY+Pd0kgZfHU5W4XUXgepUKfIr4IQXRaahWc1uuf/h3OodyYnN+RIJ/B795jO2/0IGN8CQdpymLWz3lAr5vmTpFxUY7XRsA4Peo7RvYW3zHvWTnZ/pkKAx+0UjzRc7BeY6Rw614=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472057; c=relaxed/simple;
	bh=Jrb+H65+LfHEjIP/QvJE79Sa3p3fFXsIYWZbP/LOtjM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h6/Fjo3w3BJNrchazzsXThiSIg2M7bhB1iBl+6/S1z8Aj9hbJra/hkZztXk6idl21gRNItH8vgZY5OIHV5Bwqzu4RL8Xm7GMlwhPh1KWl7i5L6/13Du1KGv6GizlmK2h7Gkct1dQKBtaw0T9SzEIv6puGDoRpwYh6zRw0jWFbtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=QmMGxGzV; arc=fail smtp.client-ip=40.107.20.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNb4fjUQBX10EJ7adQibWhMEzkR/+xlrTnTzv45N8HdtDkcbOeOtg1Z34dJpkbDIuG5E+6Y1lx4OWB+iICDcqEO1AgCaV6G6wDD/qiqOCjGmf6aOjuIWwC+Ij7FQzBIF2BifoEXPck00R8CeWMD6yqNxxTx8bMUIwQUMAT0v3oJzmY3kYwL0C+AJJGdsLcUivpqbp8Jb5KvKqkwqZ05rvYHGJyDEzXrUU1VMq01e+K6nGHXdFuH6WI6FiRdXwQD6JSEgemFVun+6S6lH0bwF50e+KP7A96q7rd961KyKy8SVXz+sgJHVXcAQ7ADKyY8NjeimzuwpOyA1XOcg/PtQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdMhVx5W4qmt1DoI9yagQDMLzbzAPKsTpLntPZZFH5I=;
 b=jQPDFeXcxPEa0BNOQHXZfLQxd556VwVv2O65zKVClARDF3dAxGD4Z7XfzkCel10i3GO7gAzJdJ9y2aRFQ7k9E4EUXrRAfNICt3Abbv1cGlcM3OwzPnJG8vhqVWmXcI21mu8Nlzh7HTbux1SntdNtCMx4y/0J36Zeguyu/ndv5BgNexKRF4evSgNqkZYmT/UC+PwuT4vvUnJNYROn3k7k6e34V3AEfJsZSUFM4KAOuG/PJcvNGW9xLq+0jDcvPpdlqNpur4WqAaKvDKg7WiQCBWGkU7NQwS1pI+H3Ar4JJUmWpQAgHsR4/KHT71s9b5PMG9/JMukTibzoHrPZmgT6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdMhVx5W4qmt1DoI9yagQDMLzbzAPKsTpLntPZZFH5I=;
 b=QmMGxGzVhGLfqm72vcZSOMamVOG24rUzE8GBl2BHbT3f2WWVLSIe0PQ5dn7FJTniFLTuiauGFZq29VpM2h5sdklB+lKhDQAdgBJwxNgIRD7ZJGafPXkYyQ+kGwHcs08HNWXTwcn/5Z0c86Tvxz2WsO8nWlPdtEUWsk82Su4YJ2C2Hc1y4iimqiv0O36TA9QSckyuEvONqKoOH3xX9nN43+nb6xlUmfNI7/PGUDPJFoDeMz1xBSlDQhD2NQJgcxw/kre6Cym6inGpfUyzmvPFOCO23Bhop/OpGRWeaAdiLMORGxqVb3UbSdbhS7/FhkgiiWyl19815SDRxMkqIkbuzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AM0PR06MB6578.eurprd06.prod.outlook.com (2603:10a6:208:199::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 09:47:30 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:47:29 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com,
	geert@linux-m68k.org,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v3 1/2] usb: core: Amend initial authorized_default value
Date: Fri,  9 Feb 2024 11:46:50 +0200
Message-Id: <20240209094651.5379-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7)
 To AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AM0PR06MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d74ac23-9766-4fce-fa7a-08dc295421a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B87nbPPLIwFdTkUNhZ793Zz89m7wHks8D+i5zKftr0OUQguELW0kDVn5tZt2Csril5cPUFlD6vxS1bSoVP2Q9fkvrmEiN1A9Z5kwhhr+5ZUuLJDdnY4wJVVVq7pJ/V4zv1J9fMunvEdd4Y6/3urg5DLOgyvg+hnbeLE2m0D248prb1SsD4IchlTSt77lZUi+YXS6JMT0rK2ABBh0SuMYQLkjvZN99ZkOFeFJxY/fE2K8K9OkF21IoqWcejS/9OI16bW9gHwnFdIIeKBGOBhP6sm5TWIeozzpdfzGs2BgliJdgNfwjPQJ418sN3kpmBm9Ap3Y4HZ6S/SXTwhclJTqZqGAfwEDcqTTxGHGyZFu2TKXAratdgTKhipqZfOtcJWZCPQfyaSpu33DTx1dF/SoYFOo4OL+5Si65s703BTIILGgr1MhUniryN6cf7w6+1Ky5QLFLwQ0Kozvs79+WTllHGsbeRATnm6jfY+6Yu6aTnIhLuNE2Vl0YPHhZumBj4N0vTlHuCN6+Lg7hMjyNW5uFvBSv2HdV+FVCdjaU/rHc4jvztMOmKI6t82BQLfVkl/mOnuQvOUSs0FkVe3QwM8GP74g3rFa8jY7CcmyMrKN0aUF7ClOjniTb6sg11h3zA9i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(66946007)(6916009)(4326008)(66556008)(8936002)(8676002)(66476007)(2906002)(83380400001)(107886003)(26005)(1076003)(36756003)(38100700002)(86362001)(38350700005)(6666004)(316002)(41300700001)(2616005)(478600001)(6512007)(6506007)(6486002)(52116002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9Dn83gXU+7jUw4yLtUTQxymhJPHwsZc0EW/sIvQ0xgSPlI3FzaMhEuMxN/l?=
 =?us-ascii?Q?pmtdZqskhXmandJSJPgrDItbLk/ZlgP/rTV59kgEqcEh2s+Bxn5HweFrtFWr?=
 =?us-ascii?Q?TljY86znvbfTyQWoZSWtzvBmjGy0Kxa7M2Muk8i1ZQ0f1ghMv/NNJlie2mJK?=
 =?us-ascii?Q?Zfy3D/Dvub5PiClvRQYbHEnBw+/QDQ34M84KW8HrTP78Ot4YSX94JENkbSe9?=
 =?us-ascii?Q?ISUX4SwZSf5G6bO8iK7TP803KoXXoEHQvNclRhofmhpuclHRpClajVYKQQ6Q?=
 =?us-ascii?Q?NyXInDC8kgjK2n1p02a4GJIlSNvWtQVTtm1DeLkYWI8xO4Q2cOcizXdOmKQU?=
 =?us-ascii?Q?pTGQX9YN66DUst+NYw0Zzq5KGQ5VDHUeQ7fvetn9UiHDADlWB0NLIkz2Tm8v?=
 =?us-ascii?Q?mgM/xs6KmhnwL+v39XTEZr+VD1RzAzM7NlEdQgjaFbwkBnH9PSlDLyCBEr8B?=
 =?us-ascii?Q?So0tat73ShDt8tDLEqJITGBydgYiDl5jzGDZkYD0d0d9rKSoqVOWytzbgHSN?=
 =?us-ascii?Q?tMLm/i7VMQwziQphtiX+UurfiC5HYo7iQgsD5E/D1X8/GtJ1G3jv2Pi8GTpK?=
 =?us-ascii?Q?/3cAKoUMN5aAL20oqQTY09VxKkspGu30h5XS+gKPPHMmAw7esP22zFE+wbgm?=
 =?us-ascii?Q?qo1rvqOTxJmdXwQ3hV9DISgDP9vk9BQg0fdh+AHknextX64YQlSwTEWA3kqN?=
 =?us-ascii?Q?aemTq5DmQM8DQnCxEpqGCXs+7Nlau/5k4UHSMlb84eNBIxbYhYfLAxRY4sjD?=
 =?us-ascii?Q?5VxdvN5XnXQp3tSMy2NlcGW52EEa3O42+rNyRfRT4jkVJcIuVk4YQ8MMHSDR?=
 =?us-ascii?Q?HcdqAXnfvS8k/WG77oe0gFJ58F1zsH4rptrB+h6istPCov4tr8tBfhcfGEt7?=
 =?us-ascii?Q?Uh3/C28iszB/9sOk+W5wDoou03nQjD/YBvqv1tz+Cv1odC8KvVIM/dd3lR9V?=
 =?us-ascii?Q?nzQywPNWsyx+molXTbo/A/M8xsXLqwaAJmZRTa5m4TT3vsNKebdp+KVHH9eH?=
 =?us-ascii?Q?GOWkAw/aBP+4WrK6mIP62lwmYmpCIkdPfacgOL+K7SW4NHbMlXXziVKsCiZ8?=
 =?us-ascii?Q?st4Ko/wB4SjIGj7xI+2X3IrxaHGo/FbovLZ9BDII2imBtPUlXB1AF7I3WRpH?=
 =?us-ascii?Q?ql2nJshms5QUS3+r9U/OlCMxtK/DnP8OSYHVK6pwscsKIkWBOaczXsToJ1Yq?=
 =?us-ascii?Q?lhpXpm794nsS6F/jA/f6LV3K0DDafRCwKl/TI1c9yzLgjrsWqt8nJMFR3BLE?=
 =?us-ascii?Q?yMOcjVPV7bwWjNO+gBuc+U6W3rgSmVDf5dhsCd1HKXc/DhOLofzLZf9CWJcD?=
 =?us-ascii?Q?PsCyn7ekfsR8v/JJjy1MM/J8VKsS6V+PELar1SGsxEbEsGa4frATkMMsNqiu?=
 =?us-ascii?Q?wq/lLW/yVLVLvJeqjDMKfwtRgwxoCJmK/P4JOuIERO39L3PxieJDYyrqK8er?=
 =?us-ascii?Q?x8wtoro5axiqtG16fdVbIzQX4H/7e0iO57idTkoZa6F8LCDxFqikPxOqW+aw?=
 =?us-ascii?Q?VGz9kEmBIIpq4Yi49dIczMC6i/Wm4QRvRRRSpdHEE5BdNnAbaVzDdKvwK5Vs?=
 =?us-ascii?Q?ig3/kUzdJ564j+pJ9lG9dM3gNx+Y8sYsFEKn9FFoEuXoftTplQqSHLc4A91A?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d74ac23-9766-4fce-fa7a-08dc295421a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 09:47:29.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJDAgq6GGHlQUyrNMc/Xv2YHTCVRRSm4CJROIuxtY9rrpVKSlbbrVf8XTGgBY2ZocOx1k1VONITrW3pHWhT0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6578

From: Niko Mauno <niko.mauno@vaisala.com>

Since the wireless USB implementation has been removed and since the
behavior with authorized_default values -1 and 1 is now effectively
same, change the initial value to latter in order to stop using the
leftover value. The former value can still be passed as a module
parameter to retain backwards compatibility.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/usb/core/hcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 12b6dfeaf658..9aa5e6bf9b9d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -357,12 +357,10 @@ static const u8 ss_rh_config_descriptor[] = {
 #define USB_AUTHORIZE_ALL	1
 #define USB_AUTHORIZE_INTERNAL	2
 
-static int authorized_default = USB_AUTHORIZE_WIRED;
+static int authorized_default = USB_AUTHORIZE_ALL;
 module_param(authorized_default, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(authorized_default,
-		"Default USB device authorization: 0 is not authorized, 1 is "
-		"authorized, 2 is authorized for internal devices, -1 is "
-		"authorized (default, same as 1)");
+		"Default USB device authorization: 0 is not authorized, 1 is authorized (default), 2 is authorized for internal devices, -1 is authorized (same as 1)");
 /*-------------------------------------------------------------------------*/
 
 /**
-- 
2.39.2


