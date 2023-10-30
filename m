Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0D7DBE94
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjJ3ROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjJ3ROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:14:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F5FBD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:13:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso3698126276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698686036; x=1699290836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/14nE/fQrv7yXeUiJ0T0oqRncNS6lZV+I39ngsgxFM=;
        b=u2it7ZraGVU/6AnVqJrlWSr4t+dPy1Z64bAnK6Wg7nmQcZBcEZtqU/+L4b+zK3rvL8
         QcXnhZjWNBNDwC7P1ekWKt8hyKlZF2aiF8bD0JJO7xDQ4aXRZbRzM45bKZfq5p535Dot
         8pt2kLTzvKyjaFPKomQ7jaefYVgw9gqmZorp/paNRi7DSUmBavhSwnFXEQawmykENW5z
         M9CVk6f0AkEId4AvnsIHN+AHzn3UelF168Pc8u4x6ZwIWKe42t7UI0O9Pk+BkUJJjtYl
         eGn1XwM/k00qqYBZ/2ZCaFG6YsMXbPipYWTXwlDUKtJgnWjsb1oF2INEbCJFgGQzZIA8
         vgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686036; x=1699290836;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/14nE/fQrv7yXeUiJ0T0oqRncNS6lZV+I39ngsgxFM=;
        b=HM7UqoZwQoxSA33hNCjdhY2B1O4hltEDC5CTJsaIL/CYKXd1GVHZ7vsWFM0V09yFfu
         WXVD8Pf6XWWTrWykUaC7Bs7UKFdiAeDrAjHz572DeqFVF0AwxRVv5RfFADf+CowcEnDd
         fo6/0JmoCggdPpDoDOQF5V4IRZgkagE2HqyNCrbl4yxI7YhXi48s+OzQ39qCW8J0y9CY
         fJKpL4kg1zodsK9q+aFQECj8NryCdIdLCkwrBHzt0NQC37ovuO3MclsYC/2Gi8Gj+zou
         DIOuwAPwCJqgiwJWP3Mwp/MhX4fHJIvVXVqSPObfeOh8UG4n044niwrj4fHf2Tg6BOOp
         E0Mw==
X-Gm-Message-State: AOJu0Yw7t6V2TlZ/SyCwMNIX8v+j06frpll36uMQIqxQpr9OHKcOgCrF
        bmEzjwZa27L7K/aBvhuB/0igZX/91fIp
X-Google-Smtp-Source: AGHT+IGsuHQjHdqpdleuPu5UpGMdtR3K+bQ/gAXqTzzWJ4LG9rljjOJgS9dyOlVqTf0oET/QMyj65QGvk/oS
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:99ae:e3b5:518:c5b4])
 (user=kyletso job=sendgmr) by 2002:a25:d7d5:0:b0:d9a:58e1:bb52 with SMTP id
 o204-20020a25d7d5000000b00d9a58e1bb52mr180684ybg.6.1698686035950; Mon, 30 Oct
 2023 10:13:55 -0700 (PDT)
Date:   Tue, 31 Oct 2023 01:13:46 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030171348.600621-1-kyletso@google.com>
Subject: [PATCH v3 0/2] mutiple selectable capabilities in tcpm
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../bindings/connector/usb-connector.yaml     |  80 ++--
 drivers/usb/typec/tcpm/tcpm.c                 | 389 ++++++++++++++----
 2 files changed, 360 insertions(+), 109 deletions(-)

-- 
2.42.0.820.g83a721a137-goog

