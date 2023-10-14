Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F17C9276
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjJNDRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNDRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:17:17 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD2BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 20:17:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5856082f92dso1767027a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697253434; x=1697858234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cygcl9PmHTIW27CQufR8VhIxisSzXoKQWoi0Hf3IAWI=;
        b=1+NygvOfJg0W+zLTPqNITbFbaF0LwuY/no3E4jZrvj42scbKwP8v/wRlGsN8whgJhl
         YpvE+XaxV7oCRdj0bgW82bkeQo5Yj+c7q/l2kAw6ip8DaKVYq7Ji2urlfx7KFSiBX4KD
         z8/TGwvqSvCpSLegYmyOEWuVkrOLAojUg0bzC5T3sohfwgCttqQcZnfe09usLik2O/kV
         SZKi0oeRKLIs0XJFF8NtmvPrT2HZZ9ddbbsiLlYCPATumnHtV/FYc0D0ihjh3CvpDWtD
         Z594fVrNZzGu+EzIV8A9WpmXZQViyXOEDuTAmxkF9Zjz60Dve8GOG6EA/LxGZq/q7Lbm
         4C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697253434; x=1697858234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cygcl9PmHTIW27CQufR8VhIxisSzXoKQWoi0Hf3IAWI=;
        b=U8xTxzURalywcfZg/35DPjbArAn2Ue0Fbz0EVQcDNOAXBP5Q3E5FNvilAFuCAySczt
         fBzjjRY0SIryLrtf9FRrxWd08uDD3CjppGj97rjcrlSu4W7I5NnFs5Raf2fb3XvR1mkw
         An53m0pDTXHydUlqDWweUvrI00zDOq71E5yXlpGgk9T205uniyGLux6gQs77iyafSTKm
         NK3Q0BLVe6IuOQPUFM39dgpzmny57a2v7WyYTUKxyMI9O3ZGEplyYUtlMMPV/0FWSbtS
         3jBj3iV5azfKTCD7q5QgusiXbTPRjAOkIRrJ0eXnmoWWBthvt/yt6z2vvTP9l+X+CQEl
         Z8Wg==
X-Gm-Message-State: AOJu0YzlSP0VLm7U6lz1yt2GdXhLebc+AxW2PI66OfIBufeY7HM8ptak
        JXCrU2YchzLvP9EqVTLwFeFqZpl94b0=
X-Google-Smtp-Source: AGHT+IGr78g2jXoouBJder6syoTwtrbmWyiVJWo80raBkuAFBVoRCBxKZJB0snIcYs+zarooC8jRwRH9JCw=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a65:6697:0:b0:5ab:7d1d:3322 with SMTP id
 b23-20020a656697000000b005ab7d1d3322mr90269pgw.9.1697253433887; Fri, 13 Oct
 2023 20:17:13 -0700 (PDT)
Date:   Sat, 14 Oct 2023 03:17:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014031709.1900370-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Check for sink pdp op current only for pd
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        amitsd@google.com, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCPM checks for sink caps operational current even when PD is disabled.
This incorrectly sets tcpm_set_charge() when PD is disabled.
Check for sink caps only when PD is disabled.

[   97.572342] Start toggling
[   97.578949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[   99.571648] CC1: 0 -> 0, CC2: 0 -> 4 [state TOGGLING, polarity 0, connected]
[   99.571658] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[   99.571673] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[   99.741778] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[   99.789283] CC1: 0 -> 0, CC2: 4 -> 5 [state SNK_DEBOUNCED, polarity 0, connected]
[   99.789306] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[   99.903584] VBUS on
[   99.903591] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AMS]
[   99.903600] polarity 1
[   99.910155] enable vbus discharge ret:0
[   99.910160] Requesting mux state 1, usb-role 2, orientation 2
[   99.946791] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
[   99.946798] state change SNK_STARTUP -> SNK_DISCOVERY [rev3 NONE_AMS]
[   99.946800] Setting voltage/current limit 5000 mV 500 mA
[   99.946803] vbus=0 charge:=1
[  100.027139] state change SNK_DISCOVERY -> SNK_READY [rev3 NONE_AMS]
[  100.027145] Setting voltage/current limit 5000 mV 3000 mA
[  100.466830] VBUS on

Cc: stable@vger.kernel.org
Fixes: 34fde9ec08a3 ("FROMGIT: usb: typec: tcpm: not sink vbus if operational current is 0mA")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6e843c511b85..994493481c24 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4268,7 +4268,8 @@ static void run_state_machine(struct tcpm_port *port)
 				current_lim = PD_P_SNK_STDBY_MW / 5;
 			tcpm_set_current_limit(port, current_lim, 5000);
 			/* Not sink vbus if operational current is 0mA */
-			tcpm_set_charge(port, !!pdo_max_current(port->snk_pdo[0]));
+			tcpm_set_charge(port, port->pd_supported ?
+					!!pdo_max_current(port->snk_pdo[0]) : true);
 
 			if (!port->pd_supported)
 				tcpm_set_state(port, SNK_READY, 0);

base-commit: 1034cc423f1b4a7a9a56d310ca980fcd2753e11d
-- 
2.42.0.655.g421f12c284-goog

