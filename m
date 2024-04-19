Return-Path: <linux-kernel+bounces-151970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59C8AB65B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9E0B213E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD813D294;
	Fri, 19 Apr 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUNdSrUp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA313C91F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561461; cv=none; b=pzEcfKI7DpFTlVc/AF9yB8Dp6j/XZKsSoubk9agjqbPZSdHT0E0spx8ayF1gJ9dD6PoBAHFQlKtKt3QM6wIz9s5Z335ZTk/tAiEcPho/YbgspFrwPTXwJedXQI7DuI+sDP14daZLz/pOGdMyeVeqXJOTZT5Dd4bdRr8uUP+i3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561461; c=relaxed/simple;
	bh=fKUL0oJVWhyKPyuWrBggFRR7WK6liB65Z5EkXKyHftw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o77xe1RKTXjFQ4CTS/uLgKMwAi+TRqACgHH0TPhxQESr5Wl2phJVJQC5WnumFrv+rQaVowYv25giBlC1oJ6qxMyXENTTW8YZ9y3nYeIVMNgfSkqQCXmCHITf8RqYbmYciMwWMUuOjKv7LJ+X2X9lu1b9mcgsMEwlECMWLrHNw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUNdSrUp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so4113966276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713561459; x=1714166259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0xPvMdWQfhMydIZIXU8mYIUBlrWjYZf7B5Lw0rva50=;
        b=DUNdSrUpu+CxyiD3iIHfZ7mgXpFDpyJGvXy0bSwXyYLAnXZ79FWKVji+Tzdf+J/zLl
         a61PjEqt1HLuNQKr0Eo/0kFlcHEL73I+JcF7f6LxA1fPZbD1T5H5K0BTOzTSwHf/KcNw
         I9XmgMSAgxkinyiAJzRyFZtpBAL95xVciWvEBe7VBU20HBWkLkKikDjhXqFyG7gyc5bb
         0ggZX0Y4fPsJZWHHYzqOajT58iccyTZl0UEts5kT0BRjNX29dIo6zLKq3djBrzpD2AKs
         8b7vEvbm5qYpW28p43l6q8xzXYPIBJPCnO82gHxohLJoe0sZjdlldv8a0c8hFPrGokEY
         54zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561459; x=1714166259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0xPvMdWQfhMydIZIXU8mYIUBlrWjYZf7B5Lw0rva50=;
        b=sW58ho+QMY9dfrOMdJkstZS3PrKftaj39KXrkn5wINFMlUgzp28erGezZSdU4a3j7y
         3cZeo/fjFlqM0irgSifm7C4j7LLYR/7jHQN8EkWRq1ayz3UZy98xMGRLV3jubcXqjEsf
         +lT1ZL1Nn+4wpgj5xcUK6lkgRwlB4U6WCkM0iG4LCs9MvrkG7IqeM3FtZ14wIgmd571o
         CkU+0svJTUqPlwAT5a28/aAzyg3Xg+jiXugjVdGGF1AmZ2rNMhs1AYhrgoefD2fk0HIz
         RSiQBmVkhXzK4JYr48aC0j3GmN/ehY8WSH3tU1g42lEEBScU18imc7rpMAhGyPdrcPe6
         17OA==
X-Forwarded-Encrypted: i=1; AJvYcCXffwwKDnlv6fcs11DEvCgl3jejwwqoo1Xa0I7uwayDeyQCmpj3P4wo5iRfETLg+BC5GlvaT18GWMC7+RgDI98ew0kOicccnc9FmS6S
X-Gm-Message-State: AOJu0Yx0saD+ktfen/SZ+HOxeASAeDT1KDaHEIYwYAwZhurs8wzfmoeN
	Oxx0SRlz0G1jzN7GYHVVu2NZ5xNkj8CbG2HOw+fp/oDr8dLDPImXNZS+G9D+KXOgAMtwZLI0vWm
	WNA==
X-Google-Smtp-Source: AGHT+IEMwBE9YOgE81l22lVApUq3I32FekRt1YSUsjnTNhNb9RBOl882ihIkSmf8/uWelKVnIozwby1e6t4=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:120b:b0:de4:c681:ca96 with SMTP id
 s11-20020a056902120b00b00de4c681ca96mr249811ybu.2.1713561459255; Fri, 19 Apr
 2024 14:17:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 21:16:50 +0000
In-Reply-To: <20240419211650.2657096-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419211650.2657096-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419211650.2657096-5-jthies@google.com>
Subject: [PATCH v1 4/4] usb: typec: ucsi: Always set number of alternate modes
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Providing the number of known alternate modes allows user space to
determine when device registration has completed. Always register a
number of known alternate modes for the partner and cable plug, even
when the number of supported alternate modes is 0.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cd4c3b7a5d989..ea76d42fd1504 100644
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
2.44.0.769.g3c40516874-goog


