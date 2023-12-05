Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485B804565
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjLEDBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjLEDBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:01:14 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F14BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:01:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d988d69812so7731847b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 19:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701745280; x=1702350080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xlu9+t1DOTHoAK10hD5B5rkt19wvJuo0A6ryzFaunG0=;
        b=JPfe9bXc+oGpxL0G2OHXkTGaqYTvLGNwpMHxvWnnH3pJnVoBX4bfjhIxxeyY7mcC8i
         t4e2mvr4blH6qhnBKfzjwEomxOxNUo2KqcYRF9rsn0rEpxqVaKN3eBRDkex8qBNwcQ/B
         eris3MxEYWK4TcA7oSTaOiiFrgVdpaPRgwaJBXLsoruMLsSzmSvPudcbRjWXxOR+nL6Z
         0o8OCCen8K1HBeOIhpBPsyxCpR4bRyqqslCYoE4GBqv1HwLnvrWjlTczj3cv06nQ/MdW
         QQXCPpTs19u/o1krOTmDmSKaFEZZgC68QofUhQGOvqJjy7H7fVULmgAokoKIaA4CCDHc
         6vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701745280; x=1702350080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlu9+t1DOTHoAK10hD5B5rkt19wvJuo0A6ryzFaunG0=;
        b=w7R7C/6b1LXTcA4E7dVsxqSUNAWKB0DrQimQsCIq+wJOhWvWnlMSvPqi6CwV25Cntw
         6Gtyv+NsSz6/fwKjuVZiD2Te2YWM5c0W4ICYNjMCp02t1BErfSCyl2lsD+goFzv8/e6N
         ofOchEb3eh4pozDDJMMp32Nio8Mx2HbKRAyjt01LKINkV8mPZXAFu1lLmsmGcUFdn+WG
         7W/fwm2vADsZQDTwJ3nSw4smMeljylf6E3oZMl5kpd7AQHLUpuB4yBfKbLggKZHFLR93
         bG1HbuHiN4CJiyrEvguh/CoXQk4ovxTfYDGB57Zv0YPNL1FP5ONrYHhedVAAcnF0TtFb
         eOsQ==
X-Gm-Message-State: AOJu0YymCQSAqRQuyAJD+I/RxwdPW/meglXFstW8n7gSSmCBjWSwQZae
        /6qbedrJ/+YF/YSH4S6oyf+wjEfuNMc6
X-Google-Smtp-Source: AGHT+IFIaX5+NRoqRDR+X9oO3SfkvqsPc5su1wbudcbyofAFuYAu5FFuFg2nsfpjjnGJU/RNH+57gdAQ/snB
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:ac51:a57:5e72:a957])
 (user=kyletso job=sendgmr) by 2002:a25:fb07:0:b0:db4:5d35:c5a3 with SMTP id
 j7-20020a25fb07000000b00db45d35c5a3mr1059913ybe.0.1701745279879; Mon, 04 Dec
 2023 19:01:19 -0800 (PST)
Date:   Tue,  5 Dec 2023 11:01:12 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231205030114.1349089-1-kyletso@google.com>
Subject: [PATCH v5 0/2] mutiple selectable capabilities in tcpm
From:   Kyle Tso <kyletso@google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
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

updates in v5

dt-bindings: connector: Add child nodes for multiple PD capabilities
  - Fixed DT_CHECK errors

usb: typec: tcpm: Support multiple capabilities
  - no change

---
updates in v4

dt-bindings: connector: Add child nodes for multiple PD capabilities
  - Modified the structure as corrected in v2
  - Modified the commit message

usb: typec: tcpm: Support multiple capabilities
  - no change

---
updates in v3

dt-bindings: connector: Add child nodes for multiple PD capabilities
  - Updated the commit message
  - Remain unchanged for the comments about the property/node
    refactor

usb: typec: tcpm: Support multiple capabilities
  - Changed the error handling and the usage of the APIs
  - Updated the commit message

---
updates in v2

dt-bindings: connector: Add child nodes for multiple PD capabilities
  - revised the dt-bindings

usb: typec: tcpm: Support multiple capabilities
  - Added missing cleanups in the function tcpm_port_unregister_pd

---
Original cover letter:

In commit a7cff92f0635 ("usb: typec: USB Power Delivery helpers for
ports and partners"), typec_operations has two new ops .pd_get and
.pd_set providing selection of different PD capabilities. This commit
implements these two ops in tcpm.

To support multiple capabilities, new dt-binding properties need to be
defined to create a tree structure for the driver to get each set of
capabilities one by one. The first tier of the child node under
connector is called "capabilities". Under this child node lies several
2nd tier of child nodes whose names are in the pattern of ^caps[0-9]+$.
And the source and sink capabilities are placed in these nodes.

Kyle Tso (2):
  dt-bindings: connector: Add child nodes for multiple PD capabilities
  usb: typec: tcpm: Support multiple capabilities

 .../bindings/connector/usb-connector.yaml     |  88 ++--
 drivers/usb/typec/tcpm/tcpm.c                 | 389 ++++++++++++++----
 2 files changed, 362 insertions(+), 115 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

