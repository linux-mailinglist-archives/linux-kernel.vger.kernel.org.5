Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B479774B99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjHHUuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjHHUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:50:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54934171AA;
        Tue,  8 Aug 2023 09:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27DD26243D;
        Tue,  8 Aug 2023 08:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A10C433C7;
        Tue,  8 Aug 2023 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691483312;
        bh=OtN5TC3lLhHvv2gUjXivG/p6EAIkEUCxlvCJ35J9k8E=;
        h=Date:From:To:Cc:Subject:From;
        b=KEH8U4jXIWmwb3yoglAO/RZVZZoCWyAExPW9mEpVRtvV1TYvMiwOndF/YG1ZAeFCk
         AEHLFM6LG8l4/ZekJB7LfC3Nv7kMKKE315Zjg0+IcLRbwImvD1jK6fzUYy4IcOx6sA
         o+5litlDPMscM7OI423XpOLsSKDcY0KXGMoH7qNH4MRI8y/W4UD2i61hONbie6lCF/
         EY0ijYy7b18+i/rPO7PY9iwyDzc3/9/X7RVFQbey9029kDL4Q2bEI3vRfErih6Q9aN
         PWkEU1I79GwaDselBoHBM+rQMal+lu6HH6yfH6SYgBpqRVBClKSDxNU964yV7l7GBL
         OUcCE18EgN8tA==
Date:   Tue, 8 Aug 2023 10:28:28 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: regression from commit b0ce9ce408b6 ("gpiolib: Do not unexport GPIO
 on freeing")
Message-ID: <20230808102828.4a9eac09@dellmb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the commit b0ce9ce408b6 ("gpiolib: Do not unexport GPIO on freeing")

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0ce9ce408b6

causes a regression on my mvebu arm board (haven't tested on other
systems), wherein if I export a GPIO to sysfs and then unexport it, it
does not disasppear from the /sys/class/gpio directory, and subsequent
writes to the export and unexport files for the gpio fail.

  $ cd /sys/class/gpio
  $ ls
  export       gpiochip0    gpiochip32   gpiochip512  unexport
  $ echo 43 >export
  $ ls
  export       gpio43       gpiochip0    gpiochip32   gpiochip512
  unexport
  $ cat gpio43/value
  1
  $ echo 43 >unexport
  $ ls
  export       gpio43       gpiochip0    gpiochip32   gpiochip512
  unexport
  $ echo 43 >unexport
  ash: write error: Invalid argument
  $ echo 43 >export
  ash: write error: Operation not permitted

Marek
