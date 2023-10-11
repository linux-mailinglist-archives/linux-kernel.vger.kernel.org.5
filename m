Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA82C7C4C12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbjJKHiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjJKHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:38:05 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B30C198E;
        Wed, 11 Oct 2023 00:29:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0F95D80E1;
        Wed, 11 Oct 2023 07:29:05 +0000 (UTC)
Date:   Wed, 11 Oct 2023 10:29:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix MODEM initialization failure
Message-ID: <20231011072903.GA34982@atomide.com>
References: <20231007214640.376709-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007214640.376709-1-jmkrzyszt@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [231008 00:47]:
> [    6.823917][    T1] serial8250 serial8250.1: incomplete constraints, dummy supplies not allowed
> [    6.874117][    T1] ------------[ cut here ]------------
> [    6.893918][    T1] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:2486 device_release+0x98/0xa8
> [    6.930626][    T1] Device 'serial8250.1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.

The patch looks OK to me, but can you please trim down the warning for
prettier git log output? At least the timestamps can go, and since
you fixed it, you could trim the message down to something like this:

serial8250 serial8250.1: incomplete constraints, dummy supplies not allowed
WARNING: CPU: 0 PID: 1 at drivers/base/core.c:2486 device_release+0x98/0xa8
Device 'serial8250.1' does not have a release() function, it is broken and
must be fixed. See Documentation/core-api/kobject.rst.
...
put_device from platform_device_put+0x1c/0x24
platform_device_put from ams_delta_init_late+0x4c/0x68
ams_delta_init_late from init_machine_late+0x1c/0x94
init_machine_late from do_one_initcall+0x60/0x1d4

This still allows folks seeing similar errors to find them when searching.
Also the ASoC warnings can be trimmed down a bit, formatting up to you
how you prefer them naturally :)

Thanks,

Tony
