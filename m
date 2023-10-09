Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAFA7BE400
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376394AbjJIPKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376400AbjJIPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:10:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC9B9;
        Mon,  9 Oct 2023 08:10:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696864243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IIT5e387FjfUBxcrj9ow3NJK2NrhYCI/REalyWvrvU=;
        b=JU3tQGuQGNPH+u+QkYonsh0RE2l47ZVH2KZwsvViIveWdK1hXXUip+VLVFmTQQymRipLU7
        JcyuFWLI7jpwOEA+KCB0UJdwPKu0pCspdWZ44P/QGp7MDdUhBBvXU9uNqRYA+66FFD/z/Y
        jMLQwW7hbJQB1R72kd42EasOpQgLHYxW1p0oDWd/NX8hsELrnXiRfQi0d/t2nN4+RxqzrL
        E+SMhk5Wrr3K8PcqBzFHimSJM/ScwtTcxlSD99vDPGdj0JQDnP9gYY4LdF9DwzBk6HNN7T
        t1aZIihsx3N7OTrbAY4pSIcUHud35+QjnN0zlaXfbqNUCAhhoeLjDQlACSmdoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696864243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IIT5e387FjfUBxcrj9ow3NJK2NrhYCI/REalyWvrvU=;
        b=vB+2vuvfv6z4lWTnbvOgqapNbgiowWnM1SdEataFOKk80RFSog1XPjfoXQiPo3vT0XX4Nv
        wjCSxrWps0dOd1Bw==
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] alarmtimer: Fix rebind failure
In-Reply-To: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
Date:   Mon, 09 Oct 2023 17:10:42 +0200
Message-ID: <87il7fq1al.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22 2023 at 09:12, Biju Das wrote:
> +static void alarmtimer_rtc_remove_device(struct device *dev)
> +{
> +	struct rtc_device *rtc = to_rtc_device(dev);
> +
> +	if (rtcdev == rtc) {
> +		module_put(rtc->owner);
> +		if (device_may_wakeup(rtc->dev.parent))
> +			device_init_wakeup(&alarmtimer_pdev->dev, false);
> +
> +		platform_device_unregister(alarmtimer_pdev);
> +		put_device(dev);
> +		alarmtimer_pdev = NULL;
> +		rtcdev = NULL;
> +	}

That's broken versus alarmtimer_get_rtcdev() and any user of it.

Thanks,

        tglx




