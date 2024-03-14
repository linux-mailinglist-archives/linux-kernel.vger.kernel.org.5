Return-Path: <linux-kernel+bounces-103054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6687BA74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5774B280A20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3D6CDDE;
	Thu, 14 Mar 2024 09:32:12 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679F6CDBC;
	Thu, 14 Mar 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408731; cv=none; b=VN2jTnD0fOEOtvYBPqEZp+eSToqvDiZOK370vDSoImLWIJ57rk3MUTduH+9lvlrhOKQPATyk/9AIFnzCGUpCumRi9YIkIYaFG0ZlQC5B/kT+LWg0IuvypSClxguOIyoSpf6lt6O8onXkpjRzG7PhkaN7K10R6Fvgqpqb16k3hJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408731; c=relaxed/simple;
	bh=4yJRZjKqPaTm31UQT+k6xPGX1PqZ0dzpVSE3l/nbGGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pgFtVKfx1Od9E8MTfaxNqf+c0s2GxNsGa4raGXKrbM83TK6Hl7zJiW2xA+haBRK+BkZOjEnsPHSIov/8IkR9cGoy6xm89JeB2onh5Ettj+ORr76qkvAKjEiw9QJC8pNuiAeqxDXIJBrvAF4dqFppq/d5GmvfjvODOgNphU9xVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (78.37.41.175) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 14 Mar
 2024 12:31:57 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, <linux-usb@vger.kernel.org>,
	<usb-storage@lists.one-eyed-alien.net>, <linux-kernel@vger.kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
Subject: [PATCH] usb: storage: isd200: fix error checks in  isd200_{read,write}_config()
Date: Thu, 14 Mar 2024 12:31:36 +0300
Message-ID: <20240314093136.16386-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/14/2024 09:10:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184157 [Mar 14 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 10 0.3.10
 53c821b925e16276b831986eabc71d60ab82ee60
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;78.37.41.175:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 78.37.41.175
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/14/2024 09:14:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/14/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The expression result >= 0 will be true even if usb_stor_ctrl_transfer()
returns an error code. It is necessary to compare result with
USB_STOR_XFER_GOOD.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Cc: stable@vger.kernel.org
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/usb/storage/isd200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
index 300aeef160e7..2a1531793820 100644
--- a/drivers/usb/storage/isd200.c
+++ b/drivers/usb/storage/isd200.c
@@ -774,7 +774,7 @@ static int isd200_write_config( struct us_data *us )
 		(void *) &info->ConfigData, 
 		sizeof(info->ConfigData));
 
-	if (result >= 0) {
+	if (result == USB_STOR_XFER_GOOD) {
 		usb_stor_dbg(us, "   ISD200 Config Data was written successfully\n");
 	} else {
 		usb_stor_dbg(us, "   Request to write ISD200 Config Data failed!\n");
@@ -816,7 +816,7 @@ static int isd200_read_config( struct us_data *us )
 		sizeof(info->ConfigData));
 
 
-	if (result >= 0) {
+	if (result == USB_STOR_XFER_GOOD) {
 		usb_stor_dbg(us, "   Retrieved the following ISD200 Config Data:\n");
 #ifdef CONFIG_USB_STORAGE_DEBUG
 		isd200_log_config(us, info);
-- 
2.34.1


