Return-Path: <linux-kernel+bounces-28360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9E82FD44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4045C1F2ADF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9041DA49;
	Tue, 16 Jan 2024 22:41:15 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C0F1D541;
	Tue, 16 Jan 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444875; cv=none; b=Kyxep0ZlzkAPjdVIY5huU1a7m11CpTFidVNmZVeyL8CTd7roLCqMiVeSKmi2Df4dsxH2Jt3MPjLhUgO4z/2FvG8AysLzYSE/0OyxrPdHeoAlX+gY1YRKZWUmmrOBBLTTbM3pHX7W9COklS4LsXK47jcqTcHzho3DrfJPKVWed7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444875; c=relaxed/simple;
	bh=Tqe00xuQRDUGt6EMrbVSvDOwN5ShfxIOykh2tsZQz/Q=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=KVWxZR16d/QA2OiROkXvNl0kzmUTXI1xPnA3jEvjeftdw0LLMi9TRIec7VSG00QTDV4TfYLmHn4Dy7sWmAR8+SKtvIQSEXHgjlVm9bH1Jmw7ax8JKq8ctzHVpSzjsaTbTYTSteLrpYt9KJDw/3CCGdIDYqu1PL7PmVaD4OwTI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id EDBD3140406; Tue, 16 Jan 2024 23:41:10 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: ucsi_acpi: Fix command completion handling
Date: Tue, 16 Jan 2024 23:40:40 +0100
Message-Id: <20240116224041.220740-3-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240116224041.220740-1-lk@c--e.de>
References: <20240116224041.220740-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of a spurious or otherwise delayed notification it is
possible that CCI still reports the previous completion. The
UCSI spec is aware of this and provides two completion bits in
CCI, one for normal commands and one for acks. As acks and commands
alternate the notification handler can determine if the completion
bit is from the current command.

The initial UCSI code correctly handled this but the distinction
between the two completion bits was lost with the introduction of
the new API.

To fix this revive the ACK_PENDING bit for ucsi_acpi and only complete
commands if the completion bit matches.

Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
NOTES:
- I've seen real issues as a result of this.
- UCSI implementations other than ACPI might need a similar fix.
  I can give relevant maintainers a heads up once this is properly
  reviewed and integrated.

 drivers/usb/typec/ucsi/ucsi_acpi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 6bbf490ac401..33dac67154d2 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -73,9 +73,13 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64*)val) == UCSI_ACK_CC_CI;
 	int ret;
 
-	set_bit(COMMAND_PENDING, &ua->flags);
+	if (ack)
+		set_bit(ACK_PENDING, &ua->flags);
+	else
+		set_bit(COMMAND_PENDING, &ua->flags);
 
 	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
 	if (ret)
@@ -85,7 +89,10 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-	clear_bit(COMMAND_PENDING, &ua->flags);
+	if (ack)
+		clear_bit(ACK_PENDING, &ua->flags);
+	else
+		clear_bit(COMMAND_PENDING, &ua->flags);
 
 	return ret;
 }
@@ -142,8 +149,10 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(COMMAND_PENDING, &ua->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
+		complete(&ua->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(COMMAND_PENDING, &ua->flags))
 		complete(&ua->complete);
 }
 
-- 
2.40.1


