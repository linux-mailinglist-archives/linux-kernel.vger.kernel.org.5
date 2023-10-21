Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2417B7D1C2B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjJUJjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC019E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697881138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TRE7vQcpC4wu7sntT/DBAdIhOafIt83BirCV8+0Y0dY=;
        b=MoEF01oVpungjQBysHwUtb91oHVVSll8Co8qZp2SpHzJdtoX3Py0pir7JBosFMBbT7wOQw
        7IkAsJoOkQFL9rQvnZw/Ce8YE/9vt7lTDzyKzE1REMWy/UZCQkyLTXcewEYQJy2ttm5+cT
        pWDjDWPWOmQaJPNZNHtk9sBzBH9/c0Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-MIvDN8hgOTaGBZH0KFfcXA-1; Sat, 21 Oct 2023 05:38:46 -0400
X-MC-Unique: MIvDN8hgOTaGBZH0KFfcXA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b274cc9636so104685166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697881125; x=1698485925;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TRE7vQcpC4wu7sntT/DBAdIhOafIt83BirCV8+0Y0dY=;
        b=hmFnEo4muvhOUEYqag7YAYCziF+F52zW/FvcnLopehgtTEjL7Se0k4VyqjDMfE++Q/
         W8L04mSD2mjx/65nou8nQ7KkoJc070v+RFka3CJ6SOCQjyFrqUemR5US8Q4bNginJugC
         ApiRy8VmwXT/PGuGkXlCPuOSXWzZ/NhxPbwAnG574SvHRuagGE8GyzjJqutnhEL0ENE6
         T4lOxgVFy2XVuUDv6flrwDcSKlPmL+DrrIgAyMLOC1j/EhH1lePugwP6jQq63Ses2Exx
         wGkbfJFSPUM8CAdWoBUgB/lEWfkI2jUNZ/ndBh+FpSPlAYRNiAkt6UAw+/fwUnYyIJB3
         KUaQ==
X-Gm-Message-State: AOJu0YxmSgnbDWdv8AVVpgZpRON3vq4OxQ42tYeLwAYtCjJT+pa/0trN
        edxYPhbRh22YX4ZdCDs6gHtKJ4S1/hHXqqjko5G/lw/7NwhtLDteuZpZqkBN3oAw4D1637f99JN
        nxUJhzrwKegpPArF9o9X9PL/gk7ngmGrh
X-Received: by 2002:a17:907:9282:b0:9ae:5120:5147 with SMTP id bw2-20020a170907928200b009ae51205147mr2967616ejc.38.1697881124846;
        Sat, 21 Oct 2023 02:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSifaMLiCDs//Z1pk8gGhUAjgwiZoCbi984YPlGrPkgKj4aoVZLST7+hJq8Vjbz6FRfTTAug==
X-Received: by 2002:a17:907:9282:b0:9ae:5120:5147 with SMTP id bw2-20020a170907928200b009ae51205147mr2967611ejc.38.1697881124570;
        Sat, 21 Oct 2023 02:38:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id xa17-20020a170907b9d100b009b913aa7cdasm3271539ejc.92.2023.10.21.02.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 02:38:43 -0700 (PDT)
Message-ID: <bc630929-8352-5548-07ec-1de7ccc150e8@redhat.com>
Date:   Sat, 21 Oct 2023 11:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.6-5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Armin Wolf <W_Armin@gmx.de>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is one last pull-request for 6.6, highlights:
 -  Fix spurious brightness down presses on newer Asus laptop models
 -  Fix backlight control not working on T2 Mac Pro all-in-ones
 -  Add Armin Wolf as new maintainer for the WMI bus driver and
    change its status from orphaned to maintained
 -  A few other small fixes

Regards,

Hans


The following changes since commit 5b44abbc39ca15df80d0da4756078c98c831090f:

  platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning (2023-10-06 15:09:40 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-5

for you to fetch changes up to 99c09c985e5973c8f0ad976ebae069548dd86f12:

  platform/mellanox: mlxbf-tmfifo: Fix a warning message (2023-10-18 15:38:09 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.6-5

Highlights:
 -  Fix spurious brightness down presses on newer Asus laptop models
 -  Fix backlight control not working on T2 Mac Pro all-in-ones
 -  Add Armin Wolf as new maintainer for the WMI bus driver and
    change its status from orphaned to maintained
 -  A few other small fixes

The following is an automated git shortlog grouped by driver:

Merge tag 'platform-drivers-x86-mellanox-init-v6.6' into fixes:
 -  Merge tag 'platform-drivers-x86-mellanox-init-v6.6' into fixes

apple-gmux:
 -  Hard Code max brightness for MMIO gmux

asus-wmi:
 -  Map 0x2a code, Ignore 0x2b and 0x2c events
 -  Only map brightness codes when using asus-wmi backlight control
 -  Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e

intel-uncore-freq:
 -  Conditionally create attribute for read frequency

msi-ec:
 -  Fix the 3rd config

platform:
 -  mellanox: Fix a resource leak in an error handling path in probing flow

platform/mellanox:
 -  mlxbf-tmfifo: Fix a warning message

platform/surface:
 -  platform_profile: Propagate error if profile registration fails

wmi:
 -  Update MAINTAINERS entry

----------------------------------------------------------------
Armin Wolf (2):
      platform/x86: wmi: Update MAINTAINERS entry
      platform/surface: platform_profile: Propagate error if profile registration fails

Hans de Goede (4):
      Merge tag 'platform-drivers-x86-mellanox-init-v6.6' into fixes
      platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e
      platform/x86: asus-wmi: Only map brightness codes when using asus-wmi backlight control
      platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Fix a warning message

Nikita Kravets (1):
      platform/x86: msi-ec: Fix the 3rd config

Orlando Chamberlain (1):
      apple-gmux: Hard Code max brightness for MMIO gmux

Srinivas Pandruvada (1):
      platform/x86: intel-uncore-freq: Conditionally create attribute for read frequency

Vadim Pasternak (1):
      platform: mellanox: Fix a resource leak in an error handling path in probing flow

 MAINTAINERS                                         |  3 ++-
 drivers/platform/mellanox/mlxbf-tmfifo.c            | 21 +++++++++++----------
 drivers/platform/surface/surface_platform_profile.c |  3 +--
 drivers/platform/x86/apple-gmux.c                   | 14 +++++++++++++-
 drivers/platform/x86/asus-nb-wmi.c                  |  3 +++
 drivers/platform/x86/asus-wmi.c                     | 15 ++++-----------
 drivers/platform/x86/asus-wmi.h                     |  2 +-
 .../uncore-frequency/uncore-frequency-common.c      |  8 ++++++--
 drivers/platform/x86/mlx-platform.c                 |  5 +++--
 drivers/platform/x86/msi-ec.c                       |  3 +--
 10 files changed, 45 insertions(+), 32 deletions(-)

