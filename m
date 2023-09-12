Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA51979C98F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjILIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjILIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 080E9172C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694506467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hcMbpwJLdrccN4aSTuA2ONg98ojGxj+RElZ5lQn4fPk=;
        b=A1PmNJxtgKbcjho+1StVJNOlJZNCf83fSf7+f/rNyI3qqErwyBDzA0JOBoUPGMA3hudsMX
        HrEN8qpi0vksrNRoJKelViEOfm0iWgsetK+CTImqLQkp+pqq9lz8WBIGyxokUIW40JvnBv
        rsNmv4R+CU7U3y3M2bEc5RsTGLTkL4Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-Xw0Z7LZhPC2GeVbPFAEUeg-1; Tue, 12 Sep 2023 04:14:26 -0400
X-MC-Unique: Xw0Z7LZhPC2GeVbPFAEUeg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52a06f5f4e2so3536847a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506464; x=1695111264;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcMbpwJLdrccN4aSTuA2ONg98ojGxj+RElZ5lQn4fPk=;
        b=soctUSyvXLoCpkwT39AAmVODZkbXF+tuQp/AvKTPUgsKt/DznflvTanYqJs+zx1lYe
         HT0KvJ3MO1FmTliYGQ1MeR6Lcgi31zmLwyPF8j+b+UP5bvF4LAodkiYtFQLWD7JZG8/x
         NE6/tO52h47NDy2bJOASjyrb4Rz6d1E2EWzKLolUK/mOR9eT+DIcGz6Sq8KMp4C7dwnj
         PMk5uHIyPmtHM8tw5mXVP9gkz2jSAw4RS80K5yelNPnYa4tpGxfyRHYHMQVsk3e7dmWz
         b80M+ykuDL5DRMHY6IBM8gmOfjhMW/mqw01YUUGenN67+Y/JGSFlWRQMyC9ptP1KpPXj
         l2oA==
X-Gm-Message-State: AOJu0YxQJ9Y0hDBr4HVpmXaDFhyVETr9pAZ4CT0rA7jKkngGiWLkTmBh
        zNt55rcmpIqfZ9diVSelKCOsZqyBUXVsejuWBhyN7qCFFdu5hyirC/RR+N1SbxTlnfd4ck6gN4a
        yAHXer6fqOxrBxewQ9BUiCcIOKctdMp3g
X-Received: by 2002:aa7:d14e:0:b0:522:2ce0:d80a with SMTP id r14-20020aa7d14e000000b005222ce0d80amr9753604edo.35.1694506464516;
        Tue, 12 Sep 2023 01:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6W+v66hEhESSBzLOBmNHQuK1MPDzz7iUwjxGH1IfOdm1etCkRKy44fqNYFy7bCo1LOHPFLw==
X-Received: by 2002:aa7:d14e:0:b0:522:2ce0:d80a with SMTP id r14-20020aa7d14e000000b005222ce0d80amr9753596edo.35.1694506464206;
        Tue, 12 Sep 2023 01:14:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7dace000000b005257da6be23sm5602613eds.75.2023.09.12.01.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:14:23 -0700 (PDT)
Message-ID: <8474aa33-e3aa-1729-2a66-715c9f883c04@redhat.com>
Date:   Tue, 12 Sep 2023 10:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.6-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the first round of fixes for platform-drivers-x86 for 6.6.

Nothing special to report just a few platform/mellanox fixes and
1 new DMI quirk for asus-wmi.

Regards,

Hans


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-2

for you to fetch changes up to 4106a70ddad57ee6d8f98b81d6f036740c72762b:

  platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode (2023-09-11 13:26:13 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.6-2

Highlights
 -  Various platform/mellanox fixes
 -  1 new DMI quirk for asus-wmi

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Support 2023 ROG X16 tablet mode

platform/mellanox:
 -  NVSW_SN2201 should depend on ACPI
 -  mlxbf-bootctl: add NET dependency into Kconfig
 -  mlxbf-pmc: Fix reading of unprogrammed events
 -  mlxbf-pmc: Fix potential buffer overflows
 -  mlxbf-tmfifo: Drop jumbo frames
 -  mlxbf-tmfifo: Drop the Rx packet if no more descriptors

----------------------------------------------------------------
David Thompson (1):
      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Geert Uytterhoeven (1):
      platform/mellanox: NVSW_SN2201 should depend on ACPI

Liming Sun (2):
      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Luke D. Jones (1):
      platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode

Shravan Kumar Ramani (2):
      platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
      platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events

 drivers/platform/mellanox/Kconfig        |  5 +-
 drivers/platform/mellanox/mlxbf-pmc.c    | 41 +++++----------
 drivers/platform/mellanox/mlxbf-tmfifo.c | 90 +++++++++++++++++++++++---------
 drivers/platform/x86/asus-nb-wmi.c       |  9 ++++
 4 files changed, 92 insertions(+), 53 deletions(-)

