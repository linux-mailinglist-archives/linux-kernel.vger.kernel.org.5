Return-Path: <linux-kernel+bounces-167113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7458BA4A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03459B23032
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF31C69D;
	Fri,  3 May 2024 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1xL6M+D"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19411BF24
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696796; cv=none; b=FoKjx61PSxAnRpIbwXGcZSa0FyBnSID8qfwo8nOp/4XMdLZLA4Y+4g2pkM9N8tPrCJnQgn3PAjZpq3KIcHg/7f/sSjEkehxWtBAp0dXN5V9gDEnFD2u6inYR24MK5lk+ayIN0eh1o328k6lJdTqek3WFbDKuZ1Uj/EEsO5DZDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696796; c=relaxed/simple;
	bh=qgu2ViOZOk6hT9QT2PkX/dUFnBm0XSHB9y0xx2sW4YM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FsL8Nl9hDIC93q6QFNCgmllBQjdD3TtISVRz9JQ+xDHBdz70dx3HLHdk6Kvy19jDcoWdHluTUqO74Hv3tE21bgIFWdImNC2iXtQRV1gpZu5ZjcmdCtyLfahttUTpfz7aGQ136FRbB8NCAG2i/c7P8hsef/h71XqJtoimWX8XKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1xL6M+D; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be530d024so79238927b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714696793; x=1715301593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHcklqlVkDgPCWtLjA6mJ8uUEpbeCPdZPZls8J1AN9k=;
        b=h1xL6M+DA8QIWugKiHHdt/J2FOJubjBSjEFNpwHZEbnvkxgnH9rnOrRBjQB3kYnhQU
         /KcfkNEBsehVD3Poug2wyH7L222UAKxUzKMQYntR2ho4ceCs5WeQHDSlxiqt/9c07pK4
         3tqh6299oDBm2dYAmE8rPdLcciUkAfO2J0EhjT0PSnGie6uLqhl0L9krye/8MtZOydQr
         3HJiz52Mi1b4L1t8vWY3HY7TKsqqS5AbJ2ouFWakgmNgCurfpX7Jz7nbdy5Peznstbok
         cwrO5GMHFX3vxOT/NAfJ5TlfVKnEIsmI5BYm+cOIo/QOCkqJVQ0gG204c3Y8h23/iT7N
         8fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714696793; x=1715301593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHcklqlVkDgPCWtLjA6mJ8uUEpbeCPdZPZls8J1AN9k=;
        b=C3YxSCWzQ4U+6RfrtpNGJ+Iv1WgFHuN7WZqSlcaT0z6ogj3SjR1sPtSPWSt8wJAW8k
         yFNVjoqlSYW2Jv2tGh7EMjNjq4gW0SyFK9PXR/34g/vDijA4hqce0w/Ge4tsEDHhOxy+
         tHnxtZSqzH52W5ovbUWzeXUK+Yi8apyTeSIUGWzhoEKCZSJBqfUmbeXowFnD0FbaMOO3
         mqMdD1OSzN7RQyl0uENkXwYJdocNQopjOiIU9L9Fun0XCW3K64NV6qoNXSsLToyEzASv
         VJ1I3F5qm0o4ChKSKtJJ2EHgoego69UatQvnxMGz9Pm73uNp8kS944BgFrTZYjf8t59V
         QmsA==
X-Forwarded-Encrypted: i=1; AJvYcCUy7QrTwUAZvvWwNoASD66MNkEJGr17hHeS+zNUeFVccDYIxCaXXE5jzsnpBqUCeYHb/QIXquQ0u6j38dRRl+f5SdzDRQGKqzwbdweD
X-Gm-Message-State: AOJu0Yw5Fd5hvm1+17g3JWZzthZzqtiYBEcOBrP/ngSSyplxbpWMSURy
	yqc40kisaT3VGzvEDeacEl0uq8IZdjGOlEVFk0V1aCWor+giap7arlLOs/sY+qd3Kvxwuekb/hq
	rKA==
X-Google-Smtp-Source: AGHT+IGyhxQqfnpdZfpT1wcZoFyJw5400zJ79x/mYwXvqDLeSrFZkOdCg3BGriKoPCxDjgmRotLTtkzJ8gw=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a25:c591:0:b0:de6:1646:58b2 with SMTP id
 v139-20020a25c591000000b00de6164658b2mr205344ybe.13.1714696792849; Thu, 02
 May 2024 17:39:52 -0700 (PDT)
Date: Fri,  3 May 2024 00:39:20 +0000
In-Reply-To: <20240503003920.1482447-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503003920.1482447-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503003920.1482447-5-jthies@google.com>
Subject: [PATCH v3 4/4] usb: typec: ucsi: Always set number of alternate modes
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Providing the number of known alternate modes allows user space to
determine when device registration has completed. Always register a
number of known alternate modes for the partner and cable plug, even
when the number of supported alternate modes is 0.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V3:
- None.

Changes in V2:
- None.

 drivers/usb/typec/ucsi/ucsi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bb6e57064513d..52a14bfe4107e 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -812,10 +812,11 @@ static int ucsi_check_altmodes(struct ucsi_connector *con)
 	/* Ignoring the errors in this case. */
 	if (con->partner_altmode[0]) {
 		num_partner_am = ucsi_get_num_altmode(con->partner_altmode);
-		if (num_partner_am > 0)
-			typec_partner_set_num_altmodes(con->partner, num_partner_am);
+		typec_partner_set_num_altmodes(con->partner, num_partner_am);
 		ucsi_altmode_update_active(con);
 		return 0;
+	} else {
+		typec_partner_set_num_altmodes(con->partner, 0);
 	}
 
 	return ret;
@@ -1138,7 +1139,7 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 static int ucsi_check_cable(struct ucsi_connector *con)
 {
 	u64 command;
-	int ret;
+	int ret, num_plug_am;
 
 	if (con->cable)
 		return 0;
@@ -1172,6 +1173,13 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 			return ret;
 	}
 
+	if (con->plug_altmode[0]) {
+		num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
+		typec_plug_set_num_altmodes(con->plug, num_plug_am);
+	} else {
+		typec_plug_set_num_altmodes(con->plug, 0);
+	}
+
 	return 0;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


