Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594C678A217
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjH0VvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjH0VvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:51:13 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29622119;
        Sun, 27 Aug 2023 14:51:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 003B8240002;
        Sun, 27 Aug 2023 21:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693173068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s4NU4mEiLOcNpjhjgGaWF5Pxr3yhVj98CN/hBa96su8=;
        b=hOadqpkNGP+GC2zIlf3X9ETzZ6xZvZpkIk17IxPeRZ96U3jxt02cdfOy+PgpwaQcJ+W5yE
        rIVro9gkdcVUQq2L4cfd7/wgkWxaJ3iJ+/Hedjr1x4x6nRhKzF57BqvRrBtzlLMZlygzvK
        rlgdaUM+4a5kLpkOQ3U39WduHHjxIGalETL0vUEF8WymgCStNrQwx+B6fGfG6zrdEkiJsP
        RubNuyqrLl6CCAPIH2zHVOUv2mN+7g4HtNWxoC018OXoqtYUP+HiD+KrKArSFKOeX160N5
        nYjlQEeXT3abdeGG3iESvuo/6MWlh8BVRsz271P21sMkTAlLKTUYl6J9i05iNw==
Date:   Sun, 27 Aug 2023 23:51:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: (subset) [PATCH v2 0/7] rtc: Add support for limited alarm timer
 offsets
Message-ID: <169317304139.537917.9009248179901069547.b4-ty@bootlin.com>
References: <20230817225537.4053865-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817225537.4053865-1-linux@roeck-us.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Aug 2023 15:55:30 -0700, Guenter Roeck wrote:
> Some alarm timers are based on time offsets, not on absolute times.
> In some situations, the amount of time that can be scheduled in the
> future is limited. This may result in a refusal to suspend the system,
> causing substantial battery drain.
> 
> This problem was previously observed on a Chromebook using the cros_ec
> rtc driver. EC variants on some older Chromebooks only support 24 hours
> of alarm time in the future. To work around the problem on affected
> Chromebooks, code to limit the maximum alarm time was added to the cros_ec
> rtc driver with commit f27efee66370 ("rtc: cros-ec: Limit RTC alarm range
> if needed"). The problem is now seen again on a system using the cmos
> RTC driver on hardware limited to 24 hours of alarm time, so a more
> generic solution is needed.
> 
> [...]

Applied, thanks!

[1/7] rtc: Add support for limited alarm timer offsets
      commit: 781589e40ac5f929f58824c15448e1ba49c3ac32
[3/7] rtc: cros-ec: Detect and report supported alarm window size
      commit: 00c3092d881bc9d63dc36eecd140cdb38962c7ec
[4/7] rtc: cmos: Report supported alarm limit to rtc infrastructure
      commit: 2546e7083f2ea96bdd6157961dc2748d65a9e487
[5/7] rtc: tps6586x: Report maximum alarm limit to rtc core
      commit: 3637bbdc8a446b8edb369383d2abc816c96ee864
[6/7] rtc: ds1305: Report maximum alarm limit to rtc core
      commit: 46b79ac0b463e155b098805ff66f1f22ff249b45
[7/7] rtc: rzn1: Report maximum alarm limit to rtc core
      commit: 2b0386d578836b9cd5d2e63cff38b7229c319e4a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
