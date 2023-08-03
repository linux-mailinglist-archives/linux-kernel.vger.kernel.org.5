Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD4776F590
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjHCWTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHCWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:19:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F8469C;
        Thu,  3 Aug 2023 15:18:45 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79094ee23e0so52393739f.0;
        Thu, 03 Aug 2023 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691101124; x=1691705924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxCty9oc1mjAqHTw6+6YKzajdVIrcQkiZDg/YOH9YWE=;
        b=DkWgmc1Ffdq00Q6fJ8opmNiefTg0FORhoMBkYdD+HnM/rpp7aIDuxsXIxGtdDIQzWH
         XhgjoGuap2ineFA4lfUvpezem2i2KRiKgwrVMyBGn+3ywyAdrbqjchS24VgU1SszlCML
         kgdaEr5nVAt+Td1FyJA9DbuR+qywjXoN6wsSFwAelwKiKEr7frNIP/7XnBinyLMykvUU
         ZDwBpQ6L+LHLs7adQuapsqRuedYBt3W3kPM4RCN7PKePNMkJftPrYKvgPB8HwSTn8Ppi
         8pN0JCYWbaMMMjtneCYkawQOpFVoZIRw7m8a6NLsz7t9GoNqPF8d38t4QaH5q49HlaN0
         9Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691101124; x=1691705924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxCty9oc1mjAqHTw6+6YKzajdVIrcQkiZDg/YOH9YWE=;
        b=GSFODsb4qfYAGPPL+Ggmy5ctlX71p9Lcf898vjvy09Ux9suTlQsIIyiwXdhct/VAN3
         JzHBQqccK6xq8ARDFB2rQu6CmYJpa58xf6JvapSlKK022uTwff8Cw/fGKlL1w6VdyWAo
         5KBVAajwp8GDWxT1CFi5eQ1sqvLyvZwczE672496WBAop54v8dUk1tdsz7zgnNTMiA9X
         2QbWATToillnVA0MQqmRNuJ5R4s8Ig0sXyrTTxgu5kyGXZS7K2BCuvr1YE/cV3EeV9/R
         psY9T7Lm/CrQwF4f+pfIpGYkXcR08SEU8OqyU0Qw9F2J9vJZGUYgj2NFXTBc4ydI32UE
         FkTg==
X-Gm-Message-State: ABy/qLbw/vOuyVaodYqzYfxJA5+UYEQ+uSXTEJPwNMdrYWg2jvQNS/oH
        VMCcVnF2BA2pjNsabCmkKrM=
X-Google-Smtp-Source: APBJJlGQIttkqsIPxJTp9SwCtcoAgLB6T8BKrJVjKk9rgx0gL+wgB2mGMwoQX5NXUN7H3EYUlngNrg==
X-Received: by 2002:a5d:9e14:0:b0:790:a073:f122 with SMTP id h20-20020a5d9e14000000b00790a073f122mr16794925ioh.2.1691101124647;
        Thu, 03 Aug 2023 15:18:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z11-20020a6b0a0b000000b007791e286fdbsm225354ioi.21.2023.08.03.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:18:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Aug 2023 15:18:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <6423de18-637e-4ee6-858e-b74e701ff3e5@roeck-us.net>
References: <20230725054216.45696-1-tony@atomide.com>
 <20230725054216.45696-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725054216.45696-4-tony@atomide.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:42:12AM +0300, Tony Lindgren wrote:
> We are missing the serial core controller id for the serial core port
> name. Let's fix the issue for sane sysfs output, and to avoid issues
> addressing serial ports later on.
> 
> And as we're now showing the controller id, the "ctrl" and "port" prefix
> for the DEVNAME become useless, we can just drop them. Let's standardize on
> DEVNAME:0 for controller name, where 0 is the controller id. And
> DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.
> 
> This makes the sysfs output nicer, on qemu for example:
> 
> $ ls /sys/bus/serial-base/devices
> 00:04:0         serial8250:0    serial8250:0.2
> 00:04:0.0       serial8250:0.1  serial8250:0.3
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This patch causes about 50% of my boot tests to fail because the console
is no longer recognized. Reverting this patch fixes the problem.
Bisect log attached.

Guenter

---
# bad: [35245ef82c5b8206d97d0296017df658fd8ea3d2] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
# good: [5d0c230f1de8c7515b6567d9afba1f196fb4e2f4] Linux 6.5-rc4
git bisect start 'HEAD' 'v6.5-rc4'
# good: [ec0f64d0666ce02114b11efd3df3234f7a3497d8] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
git bisect good ec0f64d0666ce02114b11efd3df3234f7a3497d8
# bad: [8eb8b701a263abed01d3fd7e7f1984ef37b02149] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect bad 8eb8b701a263abed01d3fd7e7f1984ef37b02149
# good: [f29c3a80b329fbfbf92278c29fdcaafb736e3d01] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good f29c3a80b329fbfbf92278c29fdcaafb736e3d01
# bad: [eddb92c4c656a669c30e17ce934e5eba8c261392] Merge branch 'fixes-togreg' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect bad eddb92c4c656a669c30e17ce934e5eba8c261392
# good: [6811694eb2f6b7a4e97be2029edc7dd6a39460f8] iio: imu: lsm6dsx: Fix mount matrix retrieval
git bisect good 6811694eb2f6b7a4e97be2029edc7dd6a39460f8
# bad: [1ef2c2df11997b8135f34adcf2c200d3b4aacbe9] serial: core: Fix serial core controller port name to show controller id
git bisect bad 1ef2c2df11997b8135f34adcf2c200d3b4aacbe9
# good: [83c35180abfdfb22f3d7703b0c85ad2d442ed2c5] serial: core: Controller id cannot be negative
git bisect good 83c35180abfdfb22f3d7703b0c85ad2d442ed2c5
# good: [d962de6ae51f9b76ad736220077cda83084090b1] serial: core: Fix serial core port id to not use port->line
git bisect good d962de6ae51f9b76ad736220077cda83084090b1
# first bad commit: [1ef2c2df11997b8135f34adcf2c200d3b4aacbe9] serial: core: Fix serial core controller port name to show controller id
