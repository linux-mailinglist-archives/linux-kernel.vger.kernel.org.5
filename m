Return-Path: <linux-kernel+bounces-151968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4E8AB657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29981C20DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DF13D246;
	Fri, 19 Apr 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naLiCgdH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055513C9D4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561450; cv=none; b=U9MES1EY0bt690yYjsBmaYybOIHPpHooJE4Lv2uwUnXY3Uwn0hOABq5bkatFu+y9t3052KJXZHGSce2A3r3zdfaEdrBqyCDYIa72Eu5CeVnoaiBDz07tvKudqM0xsfVVWFzQIU6bLEUf6LPgFs+YLRJ8OmPOMgv2/Ms7083E9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561450; c=relaxed/simple;
	bh=UxgWmlbHQ6FE6Tfsw0c5bRaypsK1JoE39PHU5jzon+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iZyW3YklvGE/bTj0R5suWV9m/bBohVpJvxtebgxezT6T18ALcDVeaMj7Mn/EVTsOudrd87cT2rJX49ztlt1DYnW3u7bJuiGJwwBevUqklIi12ZENtL67iGx2id1tDu4XkYds4xGQ1aoGzOfMFxQdBqYRiQxfPjDQZVVqlLxSsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naLiCgdH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b13ce3daaso56258157b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713561448; x=1714166248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pl1Tmr3OX/XqnrUzR2D4fjohE3sf1zx4jH0hAbozhaQ=;
        b=naLiCgdHTRkNVPBoI2K175Bep+tbwkcZDOYdEvzEt95tu7zCXwnXf9kWsdYPPMwEhp
         3YdMagFrPu2+XiEhNsviZAzwpdd1ymoOvOripxppKcTwS7dQvmE5nqiUUujGbVoLDCiB
         uj/UUz5GK/6sjmHlxSkdy1ehVezcp9jXdiGkopfdgAjVn3RyJ8/N3MD/vbUO00wZe7GK
         1KOSntnvev5KZb3ZIXURd6TIII/UY4WR3sTbRbHCo7KXC2c0WNj/Vc2lWZNf3fJvwvwz
         mx2pvx7m6NgNh/80rbPYWol+4zqgAjITLRKuATHgyKl5wZLjQrghWzRuqTFZLdCpP0SI
         u2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561448; x=1714166248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl1Tmr3OX/XqnrUzR2D4fjohE3sf1zx4jH0hAbozhaQ=;
        b=aRif4FEsWBc6KZmr2DyVSxCL1qHQpFx2Ur+A7pDNtCfr+adWD+PNHWTOp99yE1QKzm
         Xzm1SlrAGuJp5I/hKep++NbRegWGlNXqhuezsuwWLsSGRUUJCK34dFOpbgFuHdA6EbjV
         Z50sh8E9UJ07v4hVsBM4UphNbpD3jCouCGLhRQDBwyhEDCA2ztnXNzU+c6jon8W+BN/9
         6ZBT47N2JOcZ0bkvKf9EvX7xqegojii33fcMHKqd5lj5qgk1YzHRerd86JKKjQC+zNyk
         vef1MxTic5psFrtz2iVr9GCkoVvhzTVj052cXNSMTxDCfJ60sqrHu58FX65JAhDSkLEq
         KSKw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZD///5pYKBiopxKi3egmozL2p9Na+PKotI2o8rG1qNiztWINxpc3Dk64IthAXQcD8vy0CCyWwpl7oEg0eA3kWQKx6yV//IuQy+k7
X-Gm-Message-State: AOJu0YwqVCqkonsfhHSx6wBQfpbqPpw37NF2BspS3NVezi2x6H8OAllH
	JV7LsnzM9CAUiaa4GPc59G+neKQLMG9Oj7yutoEuzEQuRbPtnymbQgicZq7iLJ5f1tjS4/T4NeJ
	ENg==
X-Google-Smtp-Source: AGHT+IEQ+b9tI3DwmZkiOYMQVTS5x1KoXW9+8EbyfwH0+BAWFReOfrjeVwdV4P8KFrKDlAPmSCUWfx78JE8=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a81:4e04:0:b0:618:92c6:64b1 with SMTP id
 c4-20020a814e04000000b0061892c664b1mr764547ywb.3.1713561447800; Fri, 19 Apr
 2024 14:17:27 -0700 (PDT)
Date: Fri, 19 Apr 2024 21:16:48 +0000
In-Reply-To: <20240419211650.2657096-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419211650.2657096-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419211650.2657096-3-jthies@google.com>
Subject: [PATCH v1 2/4] usb: typec: Update sysfs when setting ops
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

When adding altmode ops, update the sysfs group so that visibility is
also recalculated.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
 drivers/usb/typec/altmodes/displayport.c |  2 +-
 drivers/usb/typec/class.c                | 18 +++++++++++++++++-
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 include/linux/usb/typec.h                |  3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 596cd4806018b..92cc1b1361208 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -746,7 +746,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	dp->alt = alt;
 
 	alt->desc = "DisplayPort";
-	alt->ops = &dp_altmode_ops;
+	typec_altmode_set_ops(alt, &dp_altmode_ops);
 
 	if (plug) {
 		plug->desc = "Displayport";
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9610e647a8d48..9262fcd4144f8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -467,6 +467,22 @@ static const struct attribute_group *typec_altmode_groups[] = {
 	NULL
 };
 
+/**
+ * typec_altmode_set_ops - Set ops for altmode
+ * @adev: Handle to the alternate mode
+ * @ops: Ops for the alternate mode
+ *
+ * After setting ops, attribute visiblity needs to be refreshed if the alternate
+ * mode can be activated.
+ */
+void typec_altmode_set_ops(struct typec_altmode *adev,
+			   const struct typec_altmode_ops *ops)
+{
+	adev->ops = ops;
+	sysfs_update_group(&adev->dev.kobj, &typec_altmode_group);
+}
+EXPORT_SYMBOL_GPL(typec_altmode_set_ops);
+
 static int altmode_id_get(struct device *dev)
 {
 	struct ida *ids;
@@ -2317,7 +2333,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 			continue;
 		}
 
-		alt->ops = ops;
+		typec_altmode_set_ops(alt, ops);
 		typec_altmode_set_drvdata(alt, drvdata);
 		altmodes[index] = alt;
 		index++;
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index d9d3c91125ca8..eb7b8d6e47d00 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -337,7 +337,7 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
 	dp->con = con;
 	dp->alt = alt;
 
-	alt->ops = &ucsi_displayport_ops;
+	typec_altmode_set_ops(alt, &ucsi_displayport_ops);
 	typec_altmode_set_drvdata(alt, dp);
 
 	return alt;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index b35b427561ab5..549275f8ac1b3 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -167,6 +167,9 @@ struct typec_port *typec_altmode2port(struct typec_altmode *alt);
 
 void typec_altmode_update_active(struct typec_altmode *alt, bool active);
 
+void typec_altmode_set_ops(struct typec_altmode *alt,
+			   const struct typec_altmode_ops *ops);
+
 enum typec_plug_index {
 	TYPEC_PLUG_SOP_P,
 	TYPEC_PLUG_SOP_PP,
-- 
2.44.0.769.g3c40516874-goog


