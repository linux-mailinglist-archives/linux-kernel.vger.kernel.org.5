Return-Path: <linux-kernel+bounces-146490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49D8A65FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8443285EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C69156240;
	Tue, 16 Apr 2024 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="ob5iQ5oj"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2048.outbound.protection.outlook.com [40.107.114.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE0629;
	Tue, 16 Apr 2024 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255733; cv=fail; b=nJsKFOG259k/g0jM5wXEmgzO5beBySeprcizLEShpDDv2FmktnuIFLmAfnX/o1BQoo8FOxtRX9OKidaBwdQ4NmKptXzd+W4WsKOQphlFMt5Lj6/QQznWwgbOk2pd3VWnyfIhAf55LcRQND6/JpjdKWhEY39Z9UtiUVKNd1xqDws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255733; c=relaxed/simple;
	bh=XkLUJsZGNJHV1FNJgXf6JW/yD/SixrPhinzHympwee4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qsg7NBDFjJ1YwdKX94xz3JdUFilP6/K+XrNCPhmXs78i5NSA6H7lEtjNnWafULvrCwQ8cURIVoT/hHaOqQeQxRQ0faPZBbmFvnBkaSdtmkfjoQW2Epbo54PxMNpjscGwYZ8hMn3lNpq4WVNuEbMsg/l2UVR/E+BjEmdmY1yWhl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=ob5iQ5oj; arc=fail smtp.client-ip=40.107.114.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiQPni9ZG5AZtw38IHHWaXzFp9riSMjHA3LGO7syxSfQDmzmGmWTGClb4M06yUTI4Pzrerk37mBguqSKvUQf94bKdPWTpr85PP2sMbNB9zKBAk9hRzk7o6UzAUMKAjMvOccBobUln80rvAB4qp1PPtERLdX0A7K9eAXjc8UyvHHaudNpgxz1A/GO37K/e8+CB1MDtVRlcO6zATYHBLMX13q0NEyN0yC00OjTX2EsNt0VtndrDYJypkL+h6eamE6V8/DtGIW9TNkT0ZXCdAtVF5rosEaGr79Jg/ehb8876AxuMCqHSZq0f2Y9NEm3VLksg93nDgfQapgLcg36aI7DSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lml8/NXqgiK2lC6l2iyDMy43Q8sS3AlfU2NEIsBIqVI=;
 b=bnPXaWH5jcKFH6JQK6PyAMc8B80kUfVz6QT0JCgc6ENlGoEaoqBYA3NWPgJpK2zufG/1Yjg+r/CK8qr6dXQ2+3wHDR6mWgITJNVOpxo3tnZrj3P4s9byDWlLq5SIdLe+/0nHtfli5N1taxZ8MvZX4QbjilwPcB+7mzaZSb6AhzBKYI0f2S1mVXIIqybzCThuY9cMFQxuoVJB+hMaUOG+oFJKc8Cp4A781+MXlTb83Ux8eH17rLIgJsqWHfgSSlSMUsoqywJOyAnD1u6bF4JdD00dWQ7tjwWFM7B78onJl5zTU7Hu07kU87H9rtykXZ7FeJq1ZnHGfHNnuY1afa5oPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lml8/NXqgiK2lC6l2iyDMy43Q8sS3AlfU2NEIsBIqVI=;
 b=ob5iQ5ojYcEBjSR+3CfFU1T4sAxcrqz/SeerZfoFayNr7WI+UFeKwk/JCKMPNce5owu6mBhhMyKAlgfno4rY2d2KXseQyHra/sX2+ua3sQtg6ERZWFM61ItYayVN0FwL87GylihVyKqzb2TtuAr1YNI2Q0vso1smM5pKya0+rwLEJv2o/0dYFMJaciwcXFy7pVjZ8riOLfOLMca9jvXfNqBtlcibvdhqItVtQf0GHIvEo42k87LaWW+Zw1lDhvDeV3ojhTHmHhz2BJPAwabBtRYpkh2Unpo2N558vqrFNXOMVnWqRBPuxet3hI+MMHPj8FHTP5hWIxwnMv5wkqn3Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYCPR01MB6753.jpnprd01.prod.outlook.com
 (2603:1096:400:b0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.48; Tue, 16 Apr
 2024 08:22:03 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 08:22:03 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: stern@rowland.harvard.edu,
	mdharm-usb@one-eyed-alien.net,
	gregkh@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Subject: [PATCH v3] usb-storage: Optimize scan delay more precisely
Date: Tue, 16 Apr 2024 17:28:21 +0900
Message-Id: <20240416082821.10164-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: OS7PR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:604:253::13) To TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10781:EE_|TYCPR01MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: b701d5b9-0bb1-4b49-bef2-08dc5dee4b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yKYEs556tCdLooJ0pPiiyJEDO+rD/22pNo4fXnR3gI1fq/A4Q6fzBBOZkrb1eTsFdzEClGwukSUb9AUeIo/7xFM4CxOLHmVGXlJhYsqpqsd/Iqd89q74SBIDCZG8he0nZhQE7VjHa5ca89Y1jG6QxyjGT+B5SW8ZByeJtm7LJ5/M9NfYsq6NNwB+HicJdbgxleH0BZvYeaSNn48HBa6o0VGpyS0fLnfQxncgqzaQvjRPmat3ksPm+u75hcpwhe6DT6gU4giqGXVg8Lg5cZkTBgIsx8Harif7fOAmTxDbF83fzk7hhO6WBy+0NWFwTlFgl1AYl/ghdTT8MyJ64Ic5cdxNA4iAYYlNhrRxo5ouvrD8JEBQP0xJSy9bcLc9dNCWwIid43DBT6HOvEZM5r6U3pHMmh2Ofx8AF5OVbkJ1gJFbJKblCkghSI8CwA2KEhYdv1EedMCbSEjoxBi7guNv+/HZBc8VdtZiEt01V02EZGgGaS8zHGfw8/UyTn8Sm25F62OALOo2BUHlJ8Z9j7J0yO/l8l1r50P05XtiKoO/HxXsCCqryzyG8fRnMXis0IB+fLivWtJWZNz1C5Tg9DLVO9cDQ9F1J4xmvZScYr+82TJwQyezjfgx7HoCsjNyysE2k6Mws1q6iNRzvG1o8JyAW+8/8641+xXyf2Dla0tv6L1iFM33M+kkjIyO3c7vXsNO20poBKs+BlM8/AzhJP9h2nbM2gMXQZbGmVk6FEA5cW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u1doW0Tr7H8gCttOqhJTgTWDYNTuOkisMWESJoTDHnZLUPdB1JR+Hf0wg/Xs?=
 =?us-ascii?Q?3Xn6e2eyW143lxeQCGqpnY3nlL5WGMRog0dYugdWmXPZOuqJf2Wz5lLf0ya2?=
 =?us-ascii?Q?FkBrGFbZxhRD3x0v13qOuR+XfS+IbQBO2aA1WFeeQeTX3n+duQpVrsXH7ze/?=
 =?us-ascii?Q?hUrB0fouWdsehGmXaim9RmXCC9OSCmPNxvjBoplK92nmfkylbxTGG2jOHw4z?=
 =?us-ascii?Q?T9sbXqvsyv3R2Op9AB58G4plZffMViaABVrxTI4XfMyKcixnQSYwdEqSqk9/?=
 =?us-ascii?Q?h3ZYBrjPrqd7z8/46nnXMoazreUrVDEXjqtWew3rh9i/ENDr1ML7BEcsTk7o?=
 =?us-ascii?Q?N6h1ndKbh+XZRM7o+IPHtm25kLksRldvsNKI38NRXKdQF0kJ3VFIStvwzir7?=
 =?us-ascii?Q?DMhsuWDg62IW4ymTyOLeNWoLAE4tqnwGLSPKj4Qch6ELfzAELksyv3mkz1W7?=
 =?us-ascii?Q?TcjU7WvB4uFSiTu/H0L7gjLYywYfEI0LD20VSvaa/UdiVfgRzbQFCpial5/B?=
 =?us-ascii?Q?3K+w48PH+nfWfMwCHM6UaWb3HpdkjWVom/JeHunYHFDxQE3FCyhfyDvATo5y?=
 =?us-ascii?Q?Rcd6OZnhFCrCi0ctTDwM5Z8fUEmHZ7reQBZQajyppV6YBijdF1GKPA8Hq7jk?=
 =?us-ascii?Q?NFEvxQC8fjDDRhVctnSVS4iY6k+M9B0G6kYnqolTpf/XX2cmR338wgcuaAnb?=
 =?us-ascii?Q?X2hjhLMRrhuclMTDc8LQ5x1c6kcRRK534Gq8XHnarPh7s+vxLbMDUDQmYkCK?=
 =?us-ascii?Q?5vvhGKbfUKwNjejaQqIZvMlzLfsqrWGuwmX4Ig/L9DgXD4oArYuGYMf4q21s?=
 =?us-ascii?Q?VqIeNTIFv3V45Ri3xVm0JTqSV+xAuTLy4oqwaDlL1daxcmGFxD26JQadWfFY?=
 =?us-ascii?Q?KKG87a5nfOReK+JZJSUkU8MM0J4ltZfN8a5YeM3htVIGS4Txmwj7/M2eEMFN?=
 =?us-ascii?Q?wUxUBPMZvHBTJRhD1U61SeYEfIY9CxoOlRLTkTcQ5agPfptVIhKGvVqNCL+s?=
 =?us-ascii?Q?wxZoricp78NvIHjcrlCsHCIK9FimJmYn3Ieui9dFJInvnPY/2JAQXvSKfATo?=
 =?us-ascii?Q?UFinsPsg+i7EfPDbxLKS6YjN9rc0TNKtGcEVcP9U+lEICZx5c+dHBh762usn?=
 =?us-ascii?Q?cfV989lLs8QwR/cyI6S+uJ08UoYi4uxQZ4oHsvtpCmNABfejFSsD4SeuzSrT?=
 =?us-ascii?Q?P7p1c99RUfRsHvApNAVj6D1i78Vps4YreaOnGXQkMoTdteKPQJMgOSKMbHPB?=
 =?us-ascii?Q?XQOX0CDhwB6Eu1UMql+tHn9cNNnfOgQm3RfW3OtxnE0MkgP6Hukd3VZttW++?=
 =?us-ascii?Q?rVaCEIUiIdvDT8ehMPAwvSoSSmklqZ3OGngPz3J/WWZBl9YGdyfMBI010B9S?=
 =?us-ascii?Q?MBmwh4PbMr5F5YCQ8lMrvgaqqUuNdyj/MvGQ81TRJCBbI195R/ko34olEl4w?=
 =?us-ascii?Q?CaOWWd2gbq38144f7laB5paIQMHHOy5DG0gONtoeztZduFTzSMm3gLz6eWgq?=
 =?us-ascii?Q?XX/SJWJbS+OQKlSrk1R5Qyi6U23u0vXJntNximl/jiH+XrCKaCtboHvlhi36?=
 =?us-ascii?Q?LEDG5DWguqvzQevVVXiCWbtYKbXtEW3tOdc0lrzW?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b701d5b9-0bb1-4b49-bef2-08dc5dee4b9b
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 08:22:03.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mitbWUcGLO7JMGVEfCU2Xf86MUyPQ3nC9kULGvpkV/WVsbAe2+fT11Fmkob5FeOri38y2TLhP+bmwOEkRKM2FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6753

Current storage scan delay is reduced by the following old commit.

a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")

It means that delay is at least 'one second', or zero with delay_use=0.
'one second' is still long delay especially for embedded system but
when delay_use is set to 0 (no delay), still error observed on some USB drives.

So delay_use should not be set to 0 but 'one second' is quite long.
Especially for embedded system, it's important for end user
how quickly access to USB drive when it's connected.
That's why we have a chance to minimize such a constant long delay.

This patch optimizes scan delay more precisely
to minimize delay time but not to have any problems on USB drives
by extending module parameter 'delay_use' in milliseconds internally.
The parameter 'delay_use' is changed to be parsed as 3 decimal point value
if it has digit values with '.'.
It makes the range of value to 1 / 1000 in internal 32-bit value
but it's still enough to set the delay time.
By default, delay time is 'one second' for backward compatibility.

For example, it seems to be good by changing delay_use=0.1,
that is 100 millisecond delay without issues for most USB pen drives.

Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++
 drivers/usb/storage/usb.c                     | 72 +++++++++++++++++--
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 561d0dd776c7..ae1eb5988706 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6190,6 +6190,16 @@
 	usb-storage.delay_use=
 			[UMS] The delay in seconds before a new device is
 			scanned for Logical Units (default 1).
+			To specify more precise delay, supports 3 decimal point.
+			The range of decimal point is in milliseconds,
+			hence the minimum value is "0.001".
+			Example:
+				delay_use=1
+					1 second delay
+				delay_use=0.1
+					0.1 second delay
+				delay_use=2.55
+					2.55 second elay
 
 	usb-storage.quirks=
 			[UMS] A list of quirks entries to supplement or
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..d5eb7dd8f3b1 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -67,9 +67,73 @@ MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");
 MODULE_DESCRIPTION("USB Mass Storage driver for Linux");
 MODULE_LICENSE("GPL");
 
-static unsigned int delay_use = 1;
-module_param(delay_use, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
+static unsigned int delay_use = 1 * MSEC_PER_SEC;
+
+static int delay_use_set(const char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms = 0;
+	int frac = 3, ret;
+	char *p = skip_spaces(s);
+	char buf[16];
+
+	if (strlen(p) >= sizeof(buf) - frac)
+		return -EINVAL;
+
+	strscpy_pad(buf, p, sizeof(buf));
+
+	p = strchr(buf, '.');
+	if (p) {
+		int i = 0;
+		char *tmp = p + 1;
+
+		while (tmp[i] && tmp[i] != '\n')
+			*p++ = tmp[i++];
+
+		if (i == 0 || i > frac)
+			return -EINVAL;
+		frac -= i;
+	} else {
+		p = buf + strlen(buf) - 1;
+		if (*p != '\n')
+			p++;
+	}
+	while (frac-- > 0)
+		*p++ = '0';
+	*p = '\0';
+
+	ret = kstrtouint(buf, 10, &delay_ms);
+	if (ret < 0)
+		return ret;
+
+	*((unsigned int *)kp->arg) = delay_ms;
+	return 0;
+}
+
+static int delay_use_get(char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms = *((unsigned int *)kp->arg);
+	unsigned int rem = do_div(delay_ms, MSEC_PER_SEC);
+	int len;
+	char buf[16];
+
+	len = scnprintf(buf, sizeof(buf), "%d", delay_ms);
+	if (rem) {
+		len += scnprintf(buf + len, sizeof(buf) - len, ".%03d", rem);
+		while (buf[len - 1] == '0') {
+			buf[len - 1] = '\0';
+			if (--len <= 1)
+				break;
+		}
+	}
+	return scnprintf(s, PAGE_SIZE, "%s\n", buf);
+}
+
+static const struct kernel_param_ops delay_use_ops = {
+	.set = delay_use_set,
+	.get = delay_use_get,
+};
+module_param_cb(delay_use, &delay_use_ops, &delay_use, 0644);
+MODULE_PARM_DESC(delay_use, "time to delay before using a new device");
 
 static char quirks[128];
 module_param_string(quirks, quirks, sizeof(quirks), S_IRUGO | S_IWUSR);
@@ -1066,7 +1130,7 @@ int usb_stor_probe2(struct us_data *us)
 	if (delay_use > 0)
 		dev_dbg(dev, "waiting for device to settle before scanning\n");
 	queue_delayed_work(system_freezable_wq, &us->scan_dwork,
-			delay_use * HZ);
+			msecs_to_jiffies(delay_use));
 	return 0;
 
 	/* We come here if there are any problems */
-- 
2.17.1


