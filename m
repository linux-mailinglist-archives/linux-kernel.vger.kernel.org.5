Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8897C942C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjJNKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:49:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1965B3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:49:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso4109253276.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697280594; x=1697885394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NAiku5347ZizUWkMfV4Tpm0aCJ6vyX6cDZT3shueHrI=;
        b=Xz/Ji1/iNeybrU3FIMIa2jzsgoOuhNVYCrUetsmuuq/f49zaoxvrKTtl+e4/x0xTbU
         +SaZqYnXMrJwt0Cy6RzdiiWRa6NWSXwGyyL8Z2eNH0lOVmXG8voWrSzCV8eh3cZY0+en
         11PbcBV4NJYX6RaqH6trXV9Z+UwhaIL3fEWtGce/41fopOlSlKp5xqyvCjr+wP8UW5d/
         hkIK5snyWt5QGlXCZeEWJH2znb6YomFR+TA45zoo5PFSg9VPyhWqs15j0uZZ3WdCwQHV
         C03X8YP661+pv7jKABFOG9znGqd9+ukq2+V7g4R2omioHMJxRyIpeVrA9L0znqRWDyn0
         yCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280594; x=1697885394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAiku5347ZizUWkMfV4Tpm0aCJ6vyX6cDZT3shueHrI=;
        b=S3u8s/ahXoAT1uI0Meyctx/HKZnt2UEZM4ZbcBSb5lw/WmqK8euxFUL40f9n/dja36
         gxTEFzzzF+DGwgO2U3YXeqf520QhxnjQynn1WgiAIkj9OdqD5kksh66O7FBfcmW+mLzh
         VOcc5bmN080BzJRH8k1ZJd2PyvmaoNdwnDGkEQIEqB358y0okYxx10pNXXXtX65VMhdD
         aHCXfd9/c18hsHOHumqxsU/RTJT5B6RM4LIEbA6Sqg3JFQevHFnveyvmSjVKdLNP44mr
         +gUqs3Oywv8J90YvfaidFnoMPxUdfVa8naE9VrBXENFxRkpfA7r1q5wqW3Ev1oy0kYMJ
         uHDQ==
X-Gm-Message-State: AOJu0Yw+KER4riL+bhU2TejfuMADNl9+MIj5kvj264kO+p6/EFkzYOPG
        GIhM49ggcFnZI/jgc/mg2LPLTSNTKY67lbDiDdmm
X-Google-Smtp-Source: AGHT+IEguB8GfzrgDTM/AZnMoQZhepnfKiL/nsCmojqUSiWwL9t49ZooKOjA5lE1I2C0hekExVSysk98/FneNiNmuqqf
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:cf48:0:b0:d9a:3ebc:3220 with
 SMTP id f69-20020a25cf48000000b00d9a3ebc3220mr358048ybg.11.1697280593824;
 Sat, 14 Oct 2023 03:49:53 -0700 (PDT)
Date:   Sat, 14 Oct 2023 16:19:39 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014104942.856152-1-vamshigajjela@google.com>
Subject: [PATCH 0/3] serial core type consistency and overflow checks
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        VAMSHI GAJJELA <vamshigajjela@google.com>
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

From: VAMSHI GAJJELA <vamshigajjela@google.com>

This patch series introduces a set of enhancements to the serial core,
primarily focusing on improving type consistency and ensuring proper
handling of timeout values. The changes aim to enhance the reliability
and maintainability of the serial core.

VAMSHI GAJJELA (3):
  serial: core: Potential overflow of frame_time
  serial: core: Make local variable size to u64
  serial: core: Update uart_poll_timeout function to return unsigned int

 drivers/tty/serial/serial_core.c | 4 ++--
 include/linux/serial_core.h      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

