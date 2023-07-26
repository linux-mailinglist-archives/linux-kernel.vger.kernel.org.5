Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C260E7637FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjGZNra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjGZNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB310CB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690379202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rEG/U+TLlVv43HHlSY9pUTPTHc4HTbiADhfLN7VMotg=;
        b=glDRCdMDpraThvQ890b1rBMbvjJWUEPG5PzT11rhrhGJtAzZAh7OqGn4FhXRb9xCWljoC3
        ASpioYLbctxMEVVr1FPMjk+Ynb+nz9Af+EysbRLxbwof+ceyYWVPg2e4Y9DjmPvJbOSW1N
        nQockkgff0AqgkuDDVx090ECk26PQ6Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-uGEi0xwpPhWwVe-enRUzDQ-1; Wed, 26 Jul 2023 09:46:41 -0400
X-MC-Unique: uGEi0xwpPhWwVe-enRUzDQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98e1085308eso106320266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379200; x=1690984000;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEG/U+TLlVv43HHlSY9pUTPTHc4HTbiADhfLN7VMotg=;
        b=hRv1e+62uL3J6AkTkpJEDR7z1k98YpYVU9u4OW3NF8J+vUoqrDve4rc2+ZrJQk9koC
         YysQkWv3Q428NkAHf4e2OZH9yoNaotgy1lla5Y5/+218y0ByIAJeqHcCYwWnk6JKXX6V
         aLvu6qOOGj5YuH7lOM40m+AkudXX0zw3iB6M27xo1NxK1Kz2fmCgGKythbdgAl/oPnAy
         eZWRhqaLo3coIlQcJ1WTjriQXIBufiTfxERzr71LR3SiXJ0avwT/nGsvDUuwKESai1es
         QRT3bjZAp/jaoke3rD1rjrkAF916ZgK9tSGPWrVejI9HEhu8/zXv3VTBSK3zB9o2pgEn
         CGhw==
X-Gm-Message-State: ABy/qLZrw2R/SV+xcRGVeNfHuDJ8595TSDCZMTcXGSwhLofI/OGxSbVb
        ucPuSqQcL28smcTQe5tzZjkMrGtWyKi868fhNfK14RvlzBXUhoV2uqfuuQGTKe4kWFeXiOLnR8X
        ML9NhSTP9VPHW7ipN6qvr6p/3
X-Received: by 2002:aa7:d85a:0:b0:522:4cb6:d1e3 with SMTP id f26-20020aa7d85a000000b005224cb6d1e3mr2372969eds.10.1690379200170;
        Wed, 26 Jul 2023 06:46:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGR6I1o9aqOuAPNaqeSVQ2TapHUW0cgQIjLsHpYkuqyp+lE9EJQgW5n3bh7OSQfppmArvzh/w==
X-Received: by 2002:aa7:d85a:0:b0:522:4cb6:d1e3 with SMTP id f26-20020aa7d85a000000b005224cb6d1e3mr2372950eds.10.1690379199897;
        Wed, 26 Jul 2023 06:46:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7d3da000000b005222c160464sm4267251edr.72.2023.07.26.06.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:46:39 -0700 (PDT)
Message-ID: <ac0f0e92-ea4b-4d47-dfd5-cfe8e0b95f55@redhat.com>
Date:   Wed, 26 Jul 2023 15:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.5-3
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 6.5.

Nothing special to report just various small fixes + hw-id additions.

Regards,

Hans


The following changes since commit 6b293a8c91bca52726448d03216e65da509e9bb7:

  platform/x86: touchscreen_dmi: Add info for the Archos 101 Cesium Educ tablet (2023-07-11 12:15:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-3

for you to fetch changes up to c21733754cd6ecbca346f2adf9b17d4cfa50504f:

  platform/x86: huawei-wmi: Silence ambient light sensor (2023-07-25 16:38:03 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.5-3

Misc. small fixes and hw-id additions.

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Fix setting RGB mode on some TUF laptops

huawei-wmi:
 -  Silence ambient light sensor

intel:
 -  hid: Always call BTNL ACPI method

msi-laptop:
 -  Fix rfkill out-of-sync on MSI Wind U100

platform/x86/amd:
 -  pmc: Use release_mem_region() to undo request_mem_region_muxed()

platform/x86/amd/pmf:
 -  Notify OS power slider update
 -  reduce verbosity of apmf_get_system_params

platform/x86/intel/hid:
 -  Add HP Dragonfly G2 to VGBS DMI quirks

serial-multi-instantiate:
 -  Auto detect IRQ resource for CSC3551

think-lmi:
 -  Use kfree_sensitive instead of kfree

touchscreen_dmi.c:
 -  small changes for Archos 101 Cesium Educ tablet

----------------------------------------------------------------
David Xu (1):
      platform/x86: serial-multi-instantiate: Auto detect IRQ resource for CSC3551

Hans de Goede (2):
      platform/x86/amd: pmc: Use release_mem_region() to undo request_mem_region_muxed()
      platform/x86: intel: hid: Always call BTNL ACPI method

Konstantin Shelekhin (1):
      platform/x86: huawei-wmi: Silence ambient light sensor

Kristian Angelov (1):
      platform/x86: asus-wmi: Fix setting RGB mode on some TUF laptops

Maxim Mikityanskiy (2):
      platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS DMI quirks
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Shyam Sundar S K (2):
      platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params
      platform/x86/amd/pmf: Notify OS power slider update

Thomas GENTY (1):
      platform/x86: touchscreen_dmi.c: small changes for Archos 101 Cesium Educ tablet

Wang Ming (1):
      platform/x86: think-lmi: Use kfree_sensitive instead of kfree

 drivers/platform/x86/amd/pmc-quirks.c           |  8 +--
 drivers/platform/x86/amd/pmf/acpi.c             | 23 +++++++-
 drivers/platform/x86/amd/pmf/core.c             |  9 ++-
 drivers/platform/x86/amd/pmf/pmf.h              | 16 ++++++
 drivers/platform/x86/amd/pmf/sps.c              | 74 +++++++++++++++++++++++--
 drivers/platform/x86/asus-wmi.c                 | 14 ++++-
 drivers/platform/x86/huawei-wmi.c               |  2 +
 drivers/platform/x86/intel/hid.c                | 27 +++++----
 drivers/platform/x86/msi-laptop.c               |  8 +--
 drivers/platform/x86/serial-multi-instantiate.c | 21 +++++--
 drivers/platform/x86/think-lmi.c                |  4 +-
 drivers/platform/x86/touchscreen_dmi.c          |  7 ++-
 12 files changed, 173 insertions(+), 40 deletions(-)

