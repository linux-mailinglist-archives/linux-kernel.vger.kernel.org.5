Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5558012C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379172AbjLASbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:31:23 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD6C1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:31:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cdd28aa7f8so2327913b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455489; x=1702060289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga3+iKjA62Fa6KbPgroTk3zWELzaacYSZ02Ed8CuNZM=;
        b=bxgEyueOZAnQphyhoXq+kHAIBv2uqcFALaBHS/qh6qysSt6be1qSPaD7prM/eJnSw7
         +Ikv09MrPqjYMD+N+zuij8PWmZW0fstyim34jalRP1o8OAc5eV0T0sdmZzHu5hAQw2Rm
         xHPF539GQrw49LYIdIlm9h49bc0lOHqBjAOs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455489; x=1702060289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ga3+iKjA62Fa6KbPgroTk3zWELzaacYSZ02Ed8CuNZM=;
        b=KyAJVDWX4HtVffE6Kvmy03VsBbr8lsJES2f48cDCb9L9BX/3kxxYtRUgLVoe9rmWGD
         NTDXpVxq2uudyQAgV23kCyIk09MHdhT7dxZX/PSbpa6pWp0xyd498Qhzm6IkewwHs5qV
         AxLZJJjOFCGSBn4/7sWLiEaPzvj0HbeH3myG/OAqBo+TOO3gWGy67bQEukS7kXeq5oeT
         qI8sqF0KjAiM/cCp5PkgY3MkVzT/GqJjuk1EgYlxOotenmgtwCxpTAI35tAWr461eOMt
         xlRTQYlDkv/qdcYSh2kfjl9xK1SLVqJP/NpSVTORoBc7iiMaBaGHgzE8pc6tD+/5H8+c
         7rvA==
X-Gm-Message-State: AOJu0YxImvUoNrJZSvPL773UEWpCBfr9hL43jO55WJ7KkowKofp/nj8b
        cHNyI67S4T0o5WtZJf8nBGdJsg==
X-Google-Smtp-Source: AGHT+IHbE+wbfalZufbhJj+tBtKr6YsDYezEXtezfVLD2wtXqSnvF5LqZTRKvLOu6DAzM7mOVEHhuw==
X-Received: by 2002:a05:6a00:1f0a:b0:6cb:63cb:83c0 with SMTP id be10-20020a056a001f0a00b006cb63cb83c0mr29667323pfb.29.1701455488688;
        Fri, 01 Dec 2023 10:31:28 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11eb:92ac:94e:c791])
        by smtp.gmail.com with ESMTPSA id g11-20020a056a00078b00b006cdda10bdafsm3306926pfu.183.2023.12.01.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:31:28 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] net: usb: r8152: Fix lost config across deauthorize+authorize
Date:   Fri,  1 Dec 2023 10:29:49 -0800
Message-ID: <20231201183113.343256-1-dianders@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series fixes problems introduced by commit ec51fbd1b8a2 ("r8152:
add USB device driver for config selection") where the r8152 device
would stop functioning if you deauthorized it (by writing 0 to the
"authorized" field in sysfs) and then reauthorized it (by writing a
1).

In v1 this was just a single patch [1], but it's now a 3-patch series
and solves the problem in a much cleaner way, as suggested by Alan
Stern.

Since these three patches straddle the USB subsystem and the
networking subsystem then maintainers will (obviously) need to work
out a way for them to land. I don't have any strong suggestions here
so I'm happy to let the maintainers propose what they think will work
best.

[1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid

Changes in v2:
- ("Don't force USB generic_subclass drivers to define ...") new for v2.
- ("Allow subclassed USB drivers to override ...") new for v2.
- ("Choose our USB config with choose_configuration()...) new for v2.

Douglas Anderson (3):
  usb: core: Don't force USB generic_subclass drivers to define probe()
  usb: core: Allow subclassed USB drivers to override
    usb_choose_configuration()
  r8152: Choose our USB config with choose_configuration() rather than
    probe()

 drivers/net/usb/r8152.c    | 16 +++++-----------
 drivers/usb/core/driver.c  |  5 ++++-
 drivers/usb/core/generic.c |  7 +++++++
 include/linux/usb.h        |  6 ++++++
 4 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog

