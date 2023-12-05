Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28F804B59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbjLEHrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:47:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7CCA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:47:53 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d7e7e10231so17538027b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701762473; x=1702367273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INmJtN8JS6E2KqYHMrd6XJhzfWKSoCLZVNWKsSG3lEY=;
        b=OWniOsrSMKVMYXAk8BCgzDxnombhAt6q8Mxh2L/xIrYRy4SXYzSCjZq7+dvhz8H/Su
         twZpePhjB6/JtlEZ3M1j98DsG6o1UJOAOINA0QiiHrLO79hJA3ozLTGD7qF2xExeiNG4
         UYBCG3+0KzBzAft4wJyl6yZz5DS2mMpFfcRKjC7ZgmKBOPxuM5tygr3eh7SQLWtFDUTP
         oekyFlyL5qZp1x1tJAHWbsHYsq55+uzuMxhNtXu9JaFXBm0/oycc2ZfZQiUY7VvY0G7N
         EJz+pjuFLNDm1IzpDeTcQgjNs3QNVvoX/lcOI9W7DDaXpAv+mbYe5vlVY3d8Dt156E3N
         t7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701762473; x=1702367273;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INmJtN8JS6E2KqYHMrd6XJhzfWKSoCLZVNWKsSG3lEY=;
        b=SRuLHlGerjrsTcyC3SuADktR7ShZqBTJ0qf7mol4Gm5jA0f01a/5dnnsmi23NN6x5a
         +dxJoXK/PPXMbHvFLKwFVcCWQBqQg+wmFDhC6rZ1tYl5KCHbW4L2+d2rNvmLlJcJogW2
         ym0WpvA+rZBnAZILd1coQNLaD6rkearJjYSFyMK/E2A+tb3KUn2R1h/BoV7Immx+XGUj
         GH/zEFiWqxgOGxbcGxTkfahTkbREYzmDNYw8sbSUH0c9Pyi+nKvBJgz6hCvO0o4B6gQY
         MiLFITIOA1NjgPb+dNtUWJJHG7MByihtYfkpqzprrJE9ISHwAcYFvsSsMwy9dnWBd1lQ
         ssbw==
X-Gm-Message-State: AOJu0YzDe9fSVIERxLGPezV3cvkFxRrCY7yUj3vWrIiMS/RD80Wv1sNK
        pcx+qbJIJRAgVO3Hr60Mt5MyL+wW4DQb
X-Google-Smtp-Source: AGHT+IHDsrM5qG/g3mwo20j/t3aM3nd+n7sqb+4JfPSK/lkd4YpfB95s9xXGLrPXQwyaAktUjLXY5Pvp3WQW
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:8ac9:92f2:1a10:4e1c])
 (user=kyletso job=sendgmr) by 2002:a05:690c:842:b0:5d3:e8b8:e1fd with SMTP id
 bz2-20020a05690c084200b005d3e8b8e1fdmr47271ywb.3.1701762472940; Mon, 04 Dec
 2023 23:47:52 -0800 (PST)
Date:   Tue,  5 Dec 2023 15:47:46 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231205074747.1821297-1-kyletso@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Query Source partner for FRS capability
 only if it is DRP
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Source-only port partner will always respond NOT_SUPPORTED to
GET_SINK_CAP. Avoid this redundant AMS by bailing out querying the FRS
capability if the Source port partner is not DRP.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 50cbc52386b3..192c103e0d10 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4401,7 +4401,8 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
-		mod_enable_frs_delayed_work(port, 0);
+		if (port->pd_capable && port->source_caps[0] & PDO_FIXED_DUAL_ROLE)
+			mod_enable_frs_delayed_work(port, 0);
 		tcpm_pps_complete(port, port->pps_status);
 
 		if (port->ams != NONE_AMS)
-- 
2.43.0.472.g3155946c3a-goog

