Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEF77D6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjHOX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjHOX21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:28:27 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E193C98;
        Tue, 15 Aug 2023 16:28:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EBCC1BF205;
        Tue, 15 Aug 2023 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692142103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqoiUzPl/8iWAJ5m3KsWYUUQxGcs9hu5/Zmem3XAmgk=;
        b=nDvy8sqLas9We8g2a4pajsYbUzEELa5PVa+FViFrfQC6tLLYIw3Jn7C8Nu/cvyoo77h8Oq
        dcbvZdetBmqbo+CqcjfdiLqdOAACYqvmGPWZxVjao6pP82BF8gjvgykKGfqhvWsgEvLTTG
        FG14roPRnXmnjdz8Zk91sErFXhEsHBMNaFlr01YQaut4TZQ7atlWTpTGLBaooIG//6yYN5
        ilDlkxd4hjy/BUJfH5XCXFT9TXEBaSyf7XPs5IJ+57Mzit2VYvcL3hvU6TK+eyOEicHkux
        1c7Z8BV9qruAoUrTNb7XKWBgfYH/4sdtNf+oN6xM+EHQqhUstV2a8ENMs6ageQ==
Date:   Wed, 16 Aug 2023 01:28:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] rtc: isl12022: battery backup voltage and clock
 support
Message-ID: <169214205184.2051743.7107002461402510185.b4-ty@bootlin.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615105826.411953-1-linux@rasmusvillemoes.dk>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 12:58:18 +0200, Rasmus Villemoes wrote:
> The current handling of the low-battery bits in the status register is
> wrong. The first six patches fix that and implement proper support for
> RTC_VL_READ.
> 
> The last two patches allow describing the isl12022 as a clock
> provider, for now just as a fixed 32kHz clock. They are also
> tangentially related to the backup battery, in that when the isl12022
> is not used as a clock source, one can save some power consumption in
> battery mode by setting the FOx bits to 0.
> 
> [...]

Applied, thanks!

[1/8] rtc: isl12022: remove wrong warning for low battery level
      commit: 4d6af37cafad69ff93f62db80d5a3daa9ac3223f
[2/8] dt-bindings: rtc: Move isil,isl12022 from trivial-rtc.yaml into own schema file
      commit: ffc005280a47030d16cbbf3105c75d3562dba5a8
[3/8] dt-bindings: rtc: isl12022: add bindings for battery alarm trip levels
      commit: 69b569c124ffa698de25d039018fe86313c46c84
[4/8] rtc: isl12022: add support for trip level DT binding
      commit: 2caeb566baabb65add7d99ca6d8bfd566fe91582
[5/8] rtc: isl12022: implement RTC_VL_READ ioctl
      commit: eccebd813874b748ac4e79a9fe4c7290117ad3be
[6/8] rtc: isl12022: trigger battery level detection during probe
      commit: a11b6c460620f7fb5fae4c3aee5a5ba2e1e1129b
[7/8] dt-bindings: rtc: isl12022: add #clock-cells property
      commit: ab246c897be0bdf981f776399ca62b5ec4b8138f
[8/8] rtc: isl12022: implement support for the #clock-cells DT property
      commit: d57d12db774820819d0e591548a56b5cfc95f82a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
