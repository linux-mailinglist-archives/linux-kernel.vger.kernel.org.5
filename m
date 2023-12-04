Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52350803B51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjLDRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjLDRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:22:50 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2188109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:22:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca61d84dc3so62571257b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701710575; x=1702315375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eYIlLpg3I1S2/DCODhdXuDSdzzNMxHCkGt3W+wzu1dA=;
        b=icikd9uCz+CQdn/q1kJ8HmrgcZeu8w4F5BJfUq6km+1YOsZRTaBfvXFmJkf8o4NEv3
         rxXYqOa09Rg+SZSplEWPWW22ET4qK8t3QMdDuSDFBNHAOlbyhFuOq7BFWpH5Ri0jxlv3
         BaD9AeG3pt1dtilxLDl/vBTGGqQ/Zd2brQsVnRh/en1hjEE6yoXJh04+74Ct1pOUZTwb
         brkB3ywLKnpBsHNeUvQfXcn6W/0surWidQ3lDDzrbxaVjSJHB8HI0MbGL1R9TEsg+tIp
         8ZxWFz9S9dYWW/mbnynP58o4mBq6WptV4sBTEalP89xeyfOB+kbWwr70ombkrE+yOsix
         CMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710575; x=1702315375;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYIlLpg3I1S2/DCODhdXuDSdzzNMxHCkGt3W+wzu1dA=;
        b=U5nnKgykknZdzNAqpAxTJefDoM5L8xCXgdmDbX9zmszzwMvEhnTEEPsmU10Xno6k9Y
         ZP3j0pN/EuxU1I+w/hhezGH6pplrOV9qrTYitAwLHW5kTZtpGD6fjZhIv/Pj3t8jKUEx
         c8Zq3UVQIPuB0AetHwX032a3p1WzZ5XWvrB1W8tVucUk/XG0kBgbviQBW/3p95oDlzKA
         +U+P8+yH6vhzpHgaEbgyIHMIFK9yNYaEwqJBkAubzfIkffwDZFh2Gg5YJuYGMHDcRgNW
         hj/BP7YKwPjY3WMKIpknM/jH2lVYA50I3JFIW2ii2+PqNY+XU5Wwbylq760gL+kzO03z
         T16g==
X-Gm-Message-State: AOJu0YwI9sUJh+jz7FkTuOGpBD7qSJ4NeJSyk458OkoJ4TgAxJWruaSg
        qcvOyTvw5UopOj07vSDcBrYZKtz9qzM4
X-Google-Smtp-Source: AGHT+IEmjdCT006EwAVkuOdbjfLg0aBk7W1LnseA31cv0KUIXtIZL5jmNQ3ZhiLkWfsbqdpkQboG8ZXl8Tfc
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:ac51:a57:5e72:a957])
 (user=kyletso job=sendgmr) by 2002:a05:690c:300d:b0:5d3:a348:b0b7 with SMTP
 id ey13-20020a05690c300d00b005d3a348b0b7mr315708ywb.7.1701710575070; Mon, 04
 Dec 2023 09:22:55 -0800 (PST)
Date:   Tue,  5 Dec 2023 01:22:45 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204172247.1087152-1-kyletso@google.com>
Subject: [PATCH v4 0/2] mutiple selectable capabilities in tcpm
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

 .../bindings/connector/usb-connector.yaml     |  78 ++--
 drivers/usb/typec/tcpm/tcpm.c                 | 389 ++++++++++++++----
 2 files changed, 352 insertions(+), 115 deletions(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog

