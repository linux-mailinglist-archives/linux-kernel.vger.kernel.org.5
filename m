Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B267B431D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjI3Ssa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjI3Ss3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:48:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C943BDD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 11:48:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-57cf261194aso16739971a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696099706; x=1696704506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKqACIemJ7xq8miKveFE694eSHgsnRyVWu3g5h4Gxp4=;
        b=3a4VBHeWdu0/zbAmE7je7DBZv+0KEc/xQMVeV+qdGK6Nr8LfehtgWbocwiY+dYlgLZ
         PAACuN7qj+NQTZTYVetASsQx8DYWkZfPrQMLvDAZhsCJnh2VqkpzBm5QJuOZI5l0TYbd
         ytUK3acBBgwxaufYyEunNxjsEqTnl8fX7f8RDIcUSmXu8umNAb0qqQtEm9vKHj/FgyjO
         hi+VVa00WP7deOyQ62HrgxmuBcGB1zwinhIq+/Tq4mACwE5ZRdEMCwF8O9vfacgT6s/J
         R7sDA70ZawaazXg6ttCdXpBFjiNL5rllXcIKbG9ejb5YX/gPVBCKk1sR2/bVwa8CqfmJ
         p3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696099706; x=1696704506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKqACIemJ7xq8miKveFE694eSHgsnRyVWu3g5h4Gxp4=;
        b=MjEl1b6Nh9nCe/p8qii79feniFOLcb3ZRzStbdYrvV31gPPN1L/bhtLMmZp10U+1uL
         HdBsh/i41/aLX+X8Re+Jqr3mrkBqWaNTeGk19i5ZuWO4W68e+ha8xbuPwOMO/1tjtW6d
         pGOJdq/kM9ZyzGjV/kPNU8xWrtHDMYxX5GX4B2Hx++T9KodZNXwT4caiJ0s4S1gHC9me
         tPHg0RZAn6Smpgqb7wp6lLzSdIxs4ughYmpBSve7fMaAyZAOucZF2l4o9gJQNYd+e8Y8
         4vvarJcJD+d8/Rh13oIUSKcrmVFo2XYcZ8esuSa5bM1hcxuPkYa/I4+zVSXOWYVyGgyl
         gYPQ==
X-Gm-Message-State: AOJu0YwQJ9PdHHk1MvJgrWZeE9toKuUEtOkaVUZOX1VHd6MOfiw4+H93
        MsAdUNlZbviF6BI598OYm59eZ9EXnUJk
X-Google-Smtp-Source: AGHT+IG9LKMHiCnD0PVucuSqHuzZlds0WM31PPnH9aY3/cS6xweL85gyTfLkJODb7y5rF0AgmHVDqDNkMnG5
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a63:6d48:0:b0:563:dddb:2016 with SMTP id
 i69-20020a636d48000000b00563dddb2016mr116191pgc.5.1696099706255; Sat, 30 Sep
 2023 11:48:26 -0700 (PDT)
Date:   Sat, 30 Sep 2023 11:48:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230930184821.310143-1-arakesh@google.com>
Subject: [PATCH v1 0/3] usb: gadget: uvc: stability fixes on STREAMOFF.
From:   Avichal Rakesh <arakesh@google.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     jchowdhary@google.com, etalvala@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avichal Rakesh <arakesh@google.com>
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

We have been seeing two main stability issues that uvc gadget driver
runs into when stopping streams:
 1. Attempting to queue usb_requests to a disabled usb_ep
 2. use-after-free issue for inflight usb_requests

The three patches below fix the two issues above. Patch 1/3 fixes the
first issue, and Patch 2/3 and 3/3 fix the second issue.

Avichal Rakesh (3):
  usb: gadget: uvc: prevent use of disabled endpoint
  usb: gadget: uvc: Allocate uvc_requests one at a time
  usb: gadget: uvc: Fix use-after-free for inflight usb_requests

 drivers/usb/gadget/function/f_uvc.c     |  11 +-
 drivers/usb/gadget/function/f_uvc.h     |   2 +-
 drivers/usb/gadget/function/uvc.h       |   6 +-
 drivers/usb/gadget/function/uvc_v4l2.c  |  21 ++-
 drivers/usb/gadget/function/uvc_video.c | 189 +++++++++++++++++-------
 5 files changed, 164 insertions(+), 65 deletions(-)

--
2.42.0.582.g8ccd20d70d-goog

