Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA907D0216
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbjJSSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbjJSSx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:53:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6C12A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:53:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so375447b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697741605; x=1698346405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyQHvM95HzGRCxeWunB7tnMEVIbhnA6GxZYPEGZ3s5U=;
        b=xkm6eTaNtsjs+HJXEUlElu5vhTymoSfxNT0absM0habw/xtAX1c3D5bSxyuin/7asr
         2AE4QyyFp2jnCVhX2o5I16I1ZOUvSs2aAeJdczNCPHLFj0VKfk3evfjuMiajB7j8C2T5
         0MzfYpxsmmV+nqQq4HXseRd47nlDPWVLHANr5SydXkEzruDYnDmDlEdnt5Mll8wkM0qq
         67e3abOc4hU+57LpQ7NkBS4HNfdKbAaFvIXH+Smxj7ohFplqUvtX4FNWI1IgtLgM0e55
         GH69dae+SMAsjo8TXSBrkVOqpF3QHdpqA97tgmDMUuMpEJhaJVFkX5BsvjO8HKjevlm3
         DPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741605; x=1698346405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyQHvM95HzGRCxeWunB7tnMEVIbhnA6GxZYPEGZ3s5U=;
        b=JvlJtm31UfHVjj5qmVQprzHXPE6sC6zxkjSFCjkCEnZ5BhOBtc0zn146wOhaJfifdi
         WAdv46v9j9Q/Lu/lA/CdIvRkCpFQ0ZEa5BujP3RUHnBCV7+wFYHDg0R/FBWNhCC1UhhY
         98nWXjh5+yklKYNJWomidcvCAIcZkaWdD+6nsVH5Md5jpUhyiVta3/wotdqCjcsE0/Bm
         9S4iR/lWbNur0IjGlpLMouHnbDV9O5yleTuVly77cdgw9tJJk5lReWOOdHnJ/d0yOo24
         9TjHTSr2ZJzC/Ko9XSarZGGt1HIZ7jzvTnk5WqQiPWv5G2fvoruPXRZ6nN4Mirj+q/Vl
         +lGA==
X-Gm-Message-State: AOJu0YyRnK50IHcDMHiE6+eEiT+2cwtmI/y+phGwq/bVkUfrNJWfjpT6
        aNgpqOx6TT+fmpcFEenqDtMZqjAQQxg+
X-Google-Smtp-Source: AGHT+IFclY7hMwdqtJ3ewebhsgfj//VgCG2RsctDrmCmuFeXerbKUgpKq+uTzS3kQUbdx0LNzm8ZIitW0NUQ
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a05:690c:a9b:b0:5a7:b95c:a58f with SMTP id
 ci27-20020a05690c0a9b00b005a7b95ca58fmr96863ywb.1.1697741604917; Thu, 19 Oct
 2023 11:53:24 -0700 (PDT)
Date:   Thu, 19 Oct 2023 11:53:15 -0700
In-Reply-To: <20230930184821.310143-1-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231019185319.2714000-1-arakesh@google.com>
Subject: [PATCH v6 0/4] usb: gadget: uvc: stability fixes on STREAMOFF.
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been seeing two main stability issues that uvc gadget driver
runs into when stopping streams:
 1. Attempting to queue usb_requests to a disabled usb_ep
 2. use-after-free issue for inflight usb_requests

The four patches below fix the two issues above. Patch 1/4 fixes the
first issue, and Patch 2/4 and 4/4 fix the second issue. Patch 3/4
is only there to make the diff in 4/4 cleaner.

Avichal Rakesh (4):
  usb: gadget: uvc: prevent use of disabled endpoint
  usb: gadget: uvc: Allocate uvc_requests one at a time
  usb: gadget: uvc: move video disable logic to its own function
  usb: gadget: uvc: Fix use-after-free for inflight usb_requests

 drivers/usb/gadget/function/f_uvc.c     |  11 +-
 drivers/usb/gadget/function/f_uvc.h     |   2 +-
 drivers/usb/gadget/function/uvc.h       |   6 +-
 drivers/usb/gadget/function/uvc_v4l2.c  |  12 +-
 drivers/usb/gadget/function/uvc_video.c | 231 +++++++++++++++++-------
 5 files changed, 189 insertions(+), 73 deletions(-)

--
2.42.0.758.gaed0368e0e-goog
