Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E447AA4D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjIUWVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjIUWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5E83D1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Et32g+8HvIOExJc33zMYGqC3XM2pU+ZYA6hMXlIOOlQ=;
        b=gna9JrLFxeKp0iJIoO2EEGOCOui5FRd0xWufxtnJPih9V1or2PwcABAJWm0OhzpoKTzfjd
        VhA+Eu9nQibGSoWTufUBV+qNhB/M1SJoI1RA4na6iIBzKa7lrNBm1AdlpxRbxVFr3P5vfI
        v5FT1yKy+e+VZFEIeNnvCKBldGiHUOU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-fByegjCiOkGqxo3_WUOLtQ-1; Thu, 21 Sep 2023 12:26:34 -0400
X-MC-Unique: fByegjCiOkGqxo3_WUOLtQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so795246a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695313592; x=1695918392;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Et32g+8HvIOExJc33zMYGqC3XM2pU+ZYA6hMXlIOOlQ=;
        b=nvdhPsrNbo4hgCC0TQI7bNhw1i+VKFOSMYuYKBRC3vHpBV1zG7ZmiRXBVhMoh331ED
         LiVUQthrxSIrfa338ilJP7MGytIFoUX3oEvdnPgEnK638L+croZb4usbgCBdV9HCAyny
         t2B8ZRBdANYI3fwgTbaCaD48ENz+GKws9uEX6z6CayZYM2W1HghxF6sXufLv5K8hPh8w
         C+VlS/LTfOjEWyedhMbvG5QYi4c5I0nMTuVDe+8Ey7YZHGeiuhDblkoyJT1dvrqSUzF+
         ndMyOmkYSzWSqUoXYBl1N87pyek1EEAvjvHinZFWXYL/uN0lNXOaPgzX9WD6iMZ0/4+X
         SjqA==
X-Gm-Message-State: AOJu0YwSsJjz0v2xoBXOmIDJABxPjmqqDNI5R7OGJ7Td+4UWgOpIYcDu
        +CLK3axNL2EI+FJgt/B3ygHi8TT9AA789vkqADDo4zR7r3SVCBfPHqRdum/G2KCMK0NuJxpTGz6
        eM8vEb+RFwrpXxmYCiVPf7JKmI0E0J9C7
X-Received: by 2002:a17:906:20ce:b0:9ae:505d:310b with SMTP id c14-20020a17090620ce00b009ae505d310bmr4361724ejc.39.1695313592345;
        Thu, 21 Sep 2023 09:26:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0rucEDMA1Te6aRXpJF3deJOppkRTntaQLrHgtjyHI97WRXh4Z6ohjO6Q3PTrrVbX1xQaGlg==
X-Received: by 2002:a17:906:20ce:b0:9ae:505d:310b with SMTP id c14-20020a17090620ce00b009ae505d310bmr4361708ejc.39.1695313592044;
        Thu, 21 Sep 2023 09:26:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id rh27-20020a17090720fb00b009930c80b87csm1301892ejb.142.2023.09.21.09.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 09:26:31 -0700 (PDT)
Message-ID: <5ffaf4a2-4359-065a-240a-fcfde68c6180@redhat.com>
Date:   Thu, 21 Sep 2023 18:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.6-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 6.6.

The most noteworthy change in here is the addition of Ilpo Järvinen
as co-maintainer of platform-drivers-x86. Ilpo will be helping me
with platform-drivers-x86 maintenance going forward and you can
expect platform-drivers-x86 pull-requests from Ilpo in the future.

Other then that there is a set of Intel SCU IPC fixes and
a thinkpad_acpi locking fix.

Regards,

Hans


The following changes since commit 4106a70ddad57ee6d8f98b81d6f036740c72762b:

  platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode (2023-09-11 13:26:13 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-3

for you to fetch changes up to bc3b6f59463ba9f4367a80331213db491766b5a1:

  MAINTAINERS: Add x86 platform drivers patchwork (2023-09-21 18:03:03 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.6-3

Highlights:
 -  Add Ilpo Järvinen as platform-drivers-x86 co-maintainer
 -  Set of Intel SCU IPC fixes
 -  thinkpad_acpi locking fix

The following is an automated git shortlog grouped by driver:

MAINTAINERS:
 -  Add x86 platform drivers patchwork
 -  Add myself into x86 platform driver maintainers

intel_scu_ipc:
 -  Fail IPC send if still busy
 -  Don't override scu in intel_scu_ipc_dev_simple_command()
 -  Check status upon timeout in ipc_wait_for_interrupt()
 -  Check status after timeout in busy_loop()

thinkpad_acpi:
 -  Take mutex in hotkey_resume

----------------------------------------------------------------
Dennis Bonke (1):
      platform/x86: thinkpad_acpi: Take mutex in hotkey_resume

Ilpo Järvinen (2):
      MAINTAINERS: Add myself into x86 platform driver maintainers
      MAINTAINERS: Add x86 platform drivers patchwork

Stephen Boyd (4):
      platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
      platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_for_interrupt()
      platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()
      platform/x86: intel_scu_ipc: Fail IPC send if still busy

 MAINTAINERS                          |  4 +++
 drivers/platform/x86/intel_scu_ipc.c | 66 ++++++++++++++++++++++--------------
 drivers/platform/x86/thinkpad_acpi.c |  2 ++
 3 files changed, 46 insertions(+), 26 deletions(-)

