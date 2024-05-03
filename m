Return-Path: <linux-kernel+bounces-167112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B338BA4A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527531C225A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6918B14;
	Fri,  3 May 2024 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWU1ogX7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782E17547
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696792; cv=none; b=u/kjWwDaw8y5JctbZVbnmVqXCqmMHXzIWfrR/+s4UIukLkDWAgw/Jl4QOoQNbfeuxt2r4Frl9/DaHvP0k4jPv6u3NUsl30KTmivTo0yzY2aNlzPWCYGOS5zFxjYj+Qp3Q863m1h9wfemAlNcEO4r2zS2hBHN+AlRlic4mh0141E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696792; c=relaxed/simple;
	bh=lPHkPZBn4jDkynyngXHEQSInVHBG5XHwELGRCRAANtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHgMgZZfZqrDXCbwpaK1SIQtQWqvjyqFCXh6Br8bj3yRr2Z8RBYir9okafapjos00uq8+M2fMVJku/t2DsPeee8dW9xCctZ5BMFlBV8292e2+SfDAuQpp8j5svzDPSW3aP5XdqRk5/TYm24O67hfCzutLDjc43rmbsmpPdHTfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWU1ogX7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be23bb01aso93832087b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714696790; x=1715301590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSyCNdHT07TNdA8h5B3w30HbKKc0j314DRlrHa4lbZ8=;
        b=tWU1ogX7s8djMPuEmSXOsGt6v9cox/ILjl6ekn0FX6yO3RLDGzmiq31L90E3DR9GCO
         E/nBiMIpkZWEx5P0csOFQCxRr+Ch8R39monu7nSmNBO8L0Wx5MAtlJpcEwucrkhBLXH8
         W4oXrGacNA0jV4hlmz2U6DstAbsOUM3kZnTrL27kRhZw9WjKFuFRiEK+nzTTQrfHRMCi
         7rgUQSeDmENkLVPasem1dwwn9hYC6oMhS72BqvsOv8ytoVHR+g/puqBFFN0mlraa2BPA
         SsLgwJdQnP5QMR9057iRu1/mQ9ihBmFfzrjGzvXqa4B6z0kuSAZWYqrmwgRpk4/3Dbgw
         KPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714696790; x=1715301590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSyCNdHT07TNdA8h5B3w30HbKKc0j314DRlrHa4lbZ8=;
        b=jwe9eTYEsR4wMhWPMS0B7QDrF+uwmJM6/WdKKpSwSHkn8TDopjywM52MkMgrK4iPfu
         z/5gO3GONE4w/88wCBi0j7u9hTDRnFe+iw8gk44Mk6lViWfOtAZquVTFN/PDnM9TahSk
         LwgZys1Km4g9JYqxHxSAHUmWwnpnJR3E7lNlA2mLjaFB5VfVP9QlBmEqVDiLObpE9SIJ
         OC82Lsr1EcAp1vXjjA5QBpxYFLGtXa3OkrwuFeRhz2LYH6icZYtHqYrW2UhrYaLOpj2n
         umdwXGZOI7knlSRO+37NVt9HO3hfEutyKiHvu1+0xbTwl5VChZDeZBUZ3+d4fTUCj+s1
         fbEg==
X-Forwarded-Encrypted: i=1; AJvYcCWolZ93riV81RzWWdhYJfJ6OMVSBB7KjYJCydJnQ/u+qNk3lJrde2tsfYe4PL3W/sZAu4spSpC6XScGeg9jRNWVCVF8ZPJDim+PNXPo
X-Gm-Message-State: AOJu0YyFkn1dS2OPQszRaaliBmNx3TLTdu3MkACuisY82Cd+XBnxLuxv
	WsSCo4FMiKesVzAqbKDr/1RTkU7mFyIW7yvAjDV/vxGkGeRFr3RNET4zyXEX3G2TEDXwtWBXYbj
	gxg==
X-Google-Smtp-Source: AGHT+IFfQyw8c1TCZjy0mlb3PosEM5hsNooK3RZWKtqyZZTyYTJsB2KvxZTCCk6ZVze/j05u/Xw1etchBYU=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:1146:b0:de4:77ab:5fea with SMTP id
 p6-20020a056902114600b00de477ab5feamr380431ybu.2.1714696789778; Thu, 02 May
 2024 17:39:49 -0700 (PDT)
Date: Fri,  3 May 2024 00:39:19 +0000
In-Reply-To: <20240503003920.1482447-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503003920.1482447-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503003920.1482447-4-jthies@google.com>
Subject: [PATCH v3 3/4] usb: typec: ucsi: Delay alternate mode discovery
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
Changes in V3:
- None.

Changes in V2:
- None.

 drivers/usb/typec/ucsi/ucsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5c..bb6e57064513d 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -963,7 +963,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 		con->rdo = con->status.request_data_obj;
 		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
 		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
-		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 30, HZ);
 		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
@@ -1247,7 +1247,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	}
 
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
-		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
 
 out_unlock:
 	mutex_unlock(&con->lock);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


