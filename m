Return-Path: <linux-kernel+bounces-156106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A58AFE06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355B91F234B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB581CD13;
	Wed, 24 Apr 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzYauc2c"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E814A84
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923345; cv=none; b=b3sv5pYwARu1Eq1ruA8DWYUGtjFFyiB2FVR9zCId2Wxldkp5svY3LvWfLTZsNeYMAsqSk3IGmYwwRIYwgPqFSMS6GjUB3Brv/rzj7xZRyJVSgzLSSYVHqhmEUtmv2phFwHWFs5LOHt6RqUmxCaFv+3vDwus2n3a1hGUnKtcGH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923345; c=relaxed/simple;
	bh=aOXxLPtNiFPouK8yihnuWDFAFsJNURmfJp1ITib6WMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkwkV2Ov8JrxBJ1XBiv8TH5D0sqMZD/MU7AilFlOVfQA0Nx6Cw22fQ6hDmJ5ypohU8y4JTly3twQq4JV9AGHcr6pQvgyee/bsT2+dzSrbx2Z3uTyILjPzBFYJITYr4yxcxtZn7g2Y6EYU+QzFWatkNb53yOR7QHsfDbblYgvC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzYauc2c; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so12658207276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713923341; x=1714528141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezOeRF6HXEObMPJXRNe8KMyl6QUSbmrUwM6rPAOdEII=;
        b=CzYauc2ci30VygHEG7Zvk9z9nUGzcOkrTBOd9QbmVrOlGyP2dwJHjvlmVyO8jr03Nn
         NmxLtAQmwb59bfT8adjI3Xd7BAQ1EYu17QyI8qjE5CJcmPIjsXjMgK3MkkJ2+bAGa3yK
         kbY/CLxydnJFWqerjuDWvZcjCXSqy0JQdNMe5XfveRayUbAoZko0nK4sn77xvZ3FH8pB
         bwHU1OorTf6tNTK0uCtj5Rk2ccB7Le4d3Fq2cD21Dvet/Z6l1sedAExLg7hFfyHWiq/M
         aJpNUL/+3JNflQdvkzcuV4Thvgh+m2xtKTC66RK3P1QXl0g06O8Jb9beAGrHEZoLznXY
         PgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713923341; x=1714528141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezOeRF6HXEObMPJXRNe8KMyl6QUSbmrUwM6rPAOdEII=;
        b=TCYTkPlSfVHm8Srk153zqS3Bd0+WBJ4FjzzFhX+VuEquZHoZbmI0VAEbShhfuaK/5/
         kG0UTfayKml12AaAXf3RWDNNw0WiuaPyqfqmy+/eJRwc0IPRW1NJ/0gp8JJiLWuJarP5
         DZLdLvWXg09iXDQpkNleIZTbkMuqFRoN/SbssGOSBGCw7d/ZFYimZaHsQ6GJBy5Ha8WT
         fEDKTZ3jhV+mEWgd1I+66axPf3hfny4TyxaE3SsmNx+5G/6AaNM1WdJRJHX2OD0z5eoa
         1gtgCcCQ0Aq2r15GywUyKXzwaqNG/ExX2GeANNLEGptA62GvtUkZ/t+NMCb4z0CixqSE
         o3GA==
X-Forwarded-Encrypted: i=1; AJvYcCV+8TqT7WGfJrg2BIxzrJspPgwhfyWcRPJEN+P51+sF6JczL3hn4O0pxHuDuoN5yx2xwlFyIFHcSEUw5jahOCpZeIlz19AL8AF1odqv
X-Gm-Message-State: AOJu0YwQEzigJE6Kpo3j1xoqK8DmCMt4hNccQwYIZf3mi1fvuzd+hOuV
	zBVQ0MS8D/NAQQqdHOqq5klGcSf0lEkpn2skS9hmMB41SJ1ZkNyXc7wpA8NdnvXdCW/gCpJpAIp
	g/w==
X-Google-Smtp-Source: AGHT+IGRd1L5GL95YL98E4tl3AqHl67Uo03kuUYoM5eqrwQBKhXNMZvglsOEK5fIZKjCXkdlxIkkFCTGD80=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:154b:b0:dc2:398d:a671 with SMTP id
 r11-20020a056902154b00b00dc2398da671mr358301ybu.10.1713923341480; Tue, 23 Apr
 2024 18:49:01 -0700 (PDT)
Date: Wed, 24 Apr 2024 01:48:20 +0000
In-Reply-To: <20240424014821.4154159-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424014821.4154159-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424014821.4154159-4-jthies@google.com>
Subject: [PATCH v2 3/4] usb: typec: ucsi: Delay alternate mode discovery
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Delay the ucsi_check_altmodes task to be inline with surrounding partner
tasks. This allows partner, cable and identity discovery to complete
before alternate mode registration. With that order, alternate mode
discovery can be used to indicate the ucsi driver has completed
discovery.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V2:
- None.

 drivers/usb/typec/ucsi/ucsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f3b413f94fd28..f167891e3f79d 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -966,7 +966,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 		con->rdo = con->status.request_data_obj;
 		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
 		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
-		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 30, HZ);
 		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
@@ -1250,7 +1250,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	}
 
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
-		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
 
 out_unlock:
 	mutex_unlock(&con->lock);
-- 
2.44.0.769.g3c40516874-goog


