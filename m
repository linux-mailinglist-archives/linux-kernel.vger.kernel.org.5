Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09A7A34DD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjIQJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjIQJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 05:12:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E0188
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 02:12:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f7638be6eso3350160f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694941955; x=1695546755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIzkNF7FeuJCHsWmBBiFl7ckCgevreFCJP37qRY7qOE=;
        b=FlpXbKpNnSh3pcJE2SYWTQ4c8e4fSYth26+ZWthLMOqlCbIJ/OCZIDmHCZOicAN/QL
         wJKx2mvChib9ZzTjFkJ/uaFFKx8LqCWy7H07GyyCSgwaIfYSPsPVic+e9/gkBS35/XwI
         D7153ObsrTChalFzg6rjZzk34TdV8zJcEcgZE0KBzv4W1qvDj1gy0+6qr73RFkFZOjoq
         Mw0L/6ZB91AljXxIf8HwniXsqnOjz9Nel6JSaSzFv9i4a81UpPNRsUci8PzF8Zhc24ue
         lEKLu2qX7bam/tuHEiB4FEB6jl/AlFSY6kY+eCB+hHFRmp8b4WKFDdb8qoEqMhS2dBgx
         GK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694941955; x=1695546755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIzkNF7FeuJCHsWmBBiFl7ckCgevreFCJP37qRY7qOE=;
        b=mQno3Fi8BxrGnGZEPuKJ0KoqbrEgOgBIGQGK6PDrinUtfgXWb/vDu78KHsqRweqfyL
         Vuvl4Nm546AeQMSoZYZ6NR4erUNQLm+/5M8KrVfk0psTt59AtB8PrqzqZyfCWNnrOtpI
         +VuegIwQi9aofhubjjtPfFDsb8xHDEtaO+uABVqpyxCJpexhDEXHgRChCvusVpIRHCOw
         wBOJqhrl8wa9TL2t4W36NE+AXzdUYEGtjSyBi2fSqSF5QWOP8ACGpDeIRVMsxOz8t3jI
         dqkI3BPWa+5iu+U8kbg9D7nn4B4IyCaIZMz6io6P2tBVc7F/0zXh2XZOWMxXgdJAUF/v
         1Qtg==
X-Gm-Message-State: AOJu0YxhQkKWGc+U5VHSnbRnShr70S3i01QaOUUqEuAKA41t0HyeFgpX
        3BH+J7GGuw+owX9710grPRJBjg==
X-Google-Smtp-Source: AGHT+IHMt7kgs7ogFAY35Byv8+iZhOk3KvEHEwDynVxRIqZHEWQP5fSujdsR5FSz8PwRPgBs3OfEUw==
X-Received: by 2002:adf:eccc:0:b0:31a:ed75:75df with SMTP id s12-20020adfeccc000000b0031aed7575dfmr5417500wro.15.1694941954772;
        Sun, 17 Sep 2023 02:12:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4ea0:9945:6800:8739])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b0031ad2f9269dsm9099688wrt.40.2023.09.17.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 02:12:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/2] gpio: sim: improve the usage of __free()
Date:   Sun, 17 Sep 2023 11:12:23 +0200
Message-Id: <20230917091225.6350-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi Linus et al,

I'm sorry for the noise but v2 was incorrect, this is a fixed version.

As discussed here's an improved fix for the invalid usage of __free() in
gpio-sim. I based it on your "maybe-sane" suggestion but unfortunately it
missed a couple details that make it impossible to avoid a conditional
initialization of the managed pointer without repeating the call to
fwnode_create_software_node().

What we're doing here is: we're creating the string array for the standard
"gpio-line-names" device property. It can look like this:

    { "foo", "bar", "baz" }

In which case lines 0, 1 and 2 are named but it can also look like this:

    { "foo", NULL, NULL, "bar", NULL, "baz" }

Where only lines 0, 3 and 5 have assigned names.

So the `has_line_names` boolean set when encountering the first line with a
name is there for a reason, namely: it's possible that only the line at
offset 0 will have a name, leaving max_offset at 0 but we still need to
create an array of size 1 in this case.

If the array is created and filled, then it needs to live until a deep
copy is completed in fwnode_create_software_node() so it has to be defined
at the top of the function.

I think this still results in clearer code then if we called
`return fwnode_create_software_node();` twice with the same arguments.

I also changed the naming to reflect the purpose of the array: it can be
sparse so it's not really "number of lines", it's the "size of the array
holding the names". The array can be of size 10 but we can only have 3
named lines.

To atone for the above, I've added a second patch which changes the other
instance of __free() in this driver to be initialized in place.

If this is alright for you, please consider applying it directly to your
tree for v6.6-rc2.

Best regards,
Bartosz Golaszewski

v2 -> v3:
- restore the offset out-of-bounds checks

v1 -> v2:
- split the line name setting into two parts
- add a patch improving the second instance of using __free()

Bartosz Golaszewski (2):
  gpio: sim: fix an invalid __free() usage
  gpio: sim: initialize a managed pointer when declaring it

 drivers/gpio/gpio-sim.c | 68 +++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

-- 
2.39.2

