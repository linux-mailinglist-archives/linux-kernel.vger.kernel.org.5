Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE0B77A740
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHMPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjHMPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932CE54
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691939065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DCpg2e3PGOdkwIYvhQ7Tns6UjRGboWKA61omIDMjzw0=;
        b=KhhRPT27J4H74KCcSJUkh3Ti4OCcNWT2OKBZVKrOgMFx0JGwI8eekZvzrMt0e7R9j6LyjW
        Qe9BgnD+BD4L+MU5aZFFDQS+NppXInYdePshCfQJWuUME3cw38N7pbIbswz+5QagAqQk1j
        9eoaVAKqrUB7bMS6sd5AhjZa2LVm1WU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Ky0Xwl4-NFOVaREBqPpExw-1; Sun, 13 Aug 2023 11:04:23 -0400
X-MC-Unique: Ky0Xwl4-NFOVaREBqPpExw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-523282be1a5so2210005a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691939062; x=1692543862;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DCpg2e3PGOdkwIYvhQ7Tns6UjRGboWKA61omIDMjzw0=;
        b=SO5SRV7p/hiDTvZWbN01HnWPdIa4OLw287NYYHgKk9pmpOrkt7iOIbxRhV6Od74w+/
         GotuTlUz/cPYKLh+R1FZ0JZTc0D/QnBD3nA0eqtBGHUk3wjv/Sr6dIZtK9ZtI+fMPzjB
         lNs8Ew2uEe2c7FpyJssmM56lW3TgaPTk72f+1/VdBAOI+SvCnAikYckGS8bRXvzvB8Y7
         jpV+EXyg+GSOqT6ybhFCzE/9n4xZuNMHFDs32xtrlh3EMbXbC87+b0/aSvgR1dYk7pYB
         2p5l079eZ168tAy4D769g0gtB+xyG3wX/cdp7O67gRDUTwQy6kU2U8ne1ox4kVYsFcxm
         n48g==
X-Gm-Message-State: AOJu0YxOHGSxfMu0zR3Scx19FQZeyq83rNChxmyLJREu/zqaf/Xfkhfb
        e45wOLaEnjOe+0ebuhJc9eYEeUx1Y+krVinjaCxFyXrE7dBgwns1aD+tbgJ7xIPI7JhnD1xjtAQ
        Dl8yDjcfS96cOQQUQv8aBo/A7
X-Received: by 2002:aa7:d287:0:b0:523:d8be:e81f with SMTP id w7-20020aa7d287000000b00523d8bee81fmr3986262edq.30.1691939061967;
        Sun, 13 Aug 2023 08:04:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8rpiJv5HYyQl7e2TM42Rd+ac66yZHutmmReBziuoUIifsPpnJAT/UQn7PzTZ0XTghsRJrQA==
X-Received: by 2002:aa7:d287:0:b0:523:d8be:e81f with SMTP id w7-20020aa7d287000000b00523d8bee81fmr3986250edq.30.1691939061703;
        Sun, 13 Aug 2023 08:04:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k15-20020a05640212cf00b00521f4ee396fsm4480062edx.12.2023.08.13.08.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 08:04:21 -0700 (PDT)
Message-ID: <70d9417a-1b90-58ed-8810-fc617701d689@redhat.com>
Date:   Sun, 13 Aug 2023 17:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.5-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the third round of fixes for platform-drivers-x86 for 6.5.

Highlights:
 -  lenovo-ymc driver causes keyboard + touchpad to not work with >= 6.4
    on some Thinkbook models, fix this
 -  A set of small fixes for mlx-platform
 -  Other small fixes and hw-id additions

Regards,

Hans


The following changes since commit c21733754cd6ecbca346f2adf9b17d4cfa50504f:

  platform/x86: huawei-wmi: Silence ambient light sensor (2023-07-25 16:38:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-4

for you to fetch changes up to 2b6aa6610dc9690f79d305ca938abfb799a4f766:

  platform/x86: lenovo-ymc: Only bind on machines with a convertible DMI chassis-type (2023-08-13 14:50:25 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.5-4

Highlights:
 -  lenovo-ymc driver causes keyboard + touchpad to not work with >= 6.4
    on some Thinkbook models, fix this
 -  A set of small fixes for mlx-platform
 -  Other small fixes and hw-id additions

The following is an automated git shortlog grouped by driver:

ACPI:
 -  scan: Create platform device for CS35L56

ISST:
 -  Reduce noise for missing numa information in logs

lenovo-ymc:
 -  Only bind on machines with a convertible DMI chassis-type

msi-ec:
 -  Fix the build

platform:
 -  mellanox: Change register offset addresses
 -  mellanox: mlx-platform: Modify graceful shutdown callback and power down mask
 -  mellanox: mlx-platform: Fix signals polarity and latch mask
 -  mellanox: Fix order in exit flow

platform/x86/amd/pmf:
 -  Fix unsigned comparison with less than zero

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: lenovo-ymc: Only bind on machines with a convertible DMI chassis-type

Jean Delvare (1):
      platform/x86: msi-ec: Fix the build

Simon Trimmer (1):
      ACPI: scan: Create platform device for CS35L56

Srinivas Pandruvada (1):
      platform/x86: ISST: Reduce noise for missing numa information in logs

Vadim Pasternak (4):
      platform: mellanox: Fix order in exit flow
      platform: mellanox: mlx-platform: Fix signals polarity and latch mask
      platform: mellanox: mlx-platform: Modify graceful shutdown callback and power down mask
      platform: mellanox: Change register offset addresses

Yang Li (1):
      platform/x86/amd/pmf: Fix unsigned comparison with less than zero

 drivers/acpi/scan.c                                |  1 +
 drivers/platform/x86/amd/pmf/sps.c                 |  3 ++-
 .../x86/intel/speed_select_if/isst_if_common.c     |  4 ++--
 drivers/platform/x86/lenovo-ymc.c                  | 25 ++++++++++++++++++++++
 drivers/platform/x86/mlx-platform.c                | 23 ++++++++++----------
 drivers/platform/x86/msi-ec.c                      | 16 +++++++-------
 drivers/platform/x86/serial-multi-instantiate.c    | 14 ++++++++++++
 7 files changed, 63 insertions(+), 23 deletions(-)

