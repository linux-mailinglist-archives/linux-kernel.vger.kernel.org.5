Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B82785BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjHWPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjHWPXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025410CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692804088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b9aQoG5wWYtUNwiG1wbJ/D0OR4T6nTWAl0MOhHXNNrY=;
        b=jC3M+d8jCC3nUIbTYQqhnrAKnfHE9ZGSFENJgbXt+uC+GUzLqDH5EpjlrnLxY6oZr6Y1Ei
        Bu277bQSyCt6iay3Szd9wwUR8iqL+dopXC0dnlkN8+ObA0aZROYuONJfOlgZVBGkxno6gA
        7RI9jGabysuscp+60ZpkeJrfMGrNScI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-88UbKJY6Mm61okzbbbZluA-1; Wed, 23 Aug 2023 11:21:26 -0400
X-MC-Unique: 88UbKJY6Mm61okzbbbZluA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99388334de6so401262766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804085; x=1693408885;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9aQoG5wWYtUNwiG1wbJ/D0OR4T6nTWAl0MOhHXNNrY=;
        b=MRhmNuLEfkqlvuOaRwl87lmwTIQPfDUl35jNRE1QIP8123BnSe8XYIoSv7zCuq+b8i
         dYzZWaH4ZIOGcckm0U1MGgcgoW41//4wjqBSSNIoTUZnaFb8VNjyCc3Sk2cw51+WwYlz
         KyaulW9IS0E0lRKEUQRExHG5lGy0Q1TLZYDLh7AbH/j/lCf6E7BWR+i6hr7kdVshPJYA
         96Ow7O7sR4ODpJEhdAOx4GKYt634wyvskm6+PKmBzzD1Eg1Y0pD19rpAG6yezkj2K2ZQ
         wxhf1qwD03oZ2wNCVWgAQatMW3asYPP4IaT9Z7oahseDiSX6Jl4VOo++0BIsj4NjzzVU
         B8wQ==
X-Gm-Message-State: AOJu0Yz4WFagUPCmQoZw5E5gbIzOuZOsQoXOe1hXGcrnZB4jDU6G9W5A
        kpdcOSBeh4/6v+u7rU7vlAlQqupgsavt2cVF+3P4A0chI17Rds1ZOFEvaZkPYiwovrgFVR41n1T
        ttSVOn5BCJDYItIdI9T0rDdhK
X-Received: by 2002:a17:907:784f:b0:99d:fc8f:5a34 with SMTP id lb15-20020a170907784f00b0099dfc8f5a34mr10205469ejc.36.1692804084908;
        Wed, 23 Aug 2023 08:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWSO2lRijfORc4RMAemUB1OnH+ySoDK7/sfLkj/ZRBS5w/mSp9VeB2uhbEgJw1pi5Z5zJm5g==
X-Received: by 2002:a17:907:784f:b0:99d:fc8f:5a34 with SMTP id lb15-20020a170907784f00b0099dfc8f5a34mr10205458ejc.36.1692804084661;
        Wed, 23 Aug 2023 08:21:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906269700b00992b50fbbe9sm9950205ejc.90.2023.08.23.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 08:21:24 -0700 (PDT)
Message-ID: <1526d93d-c4bb-579b-daea-f3581d8a6b71@redhat.com>
Date:   Wed, 23 Aug 2023 17:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.5-5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Here is one last pull-request for 6.5 with 3 small fixes.

Regards,

Hans


The following changes since commit 2b6aa6610dc9690f79d305ca938abfb799a4f766:

  platform/x86: lenovo-ymc: Only bind on machines with a convertible DMI chassis-type (2023-08-13 14:50:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-5

for you to fetch changes up to 0848cab765c634597636810bf76d0934003cce28:

  platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications (2023-08-23 17:13:36 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.5-5

Final set of pdx86 fixes for 6.5.

The following is an automated git shortlog grouped by driver:

ideapad-laptop:
 -  Add support for new hotkeys found on ThinkBook 14s Yoga ITL

lenovo-ymc:
 -  Add Lenovo Yoga 7 14ACN6 to ec_trigger_quirk_dmi_table

platform/mellanox:
 -  Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications

----------------------------------------------------------------
André Apitzsch (1):
      platform/x86: ideapad-laptop: Add support for new hotkeys found on ThinkBook 14s Yoga ITL

Shih-Yi Chen (1):
      platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications

Swapnil Devesh (1):
      platform/x86: lenovo-ymc: Add Lenovo Yoga 7 14ACN6 to ec_trigger_quirk_dmi_table

 drivers/platform/mellanox/mlxbf-tmfifo.c | 1 +
 drivers/platform/x86/ideapad-laptop.c    | 5 +++++
 drivers/platform/x86/lenovo-ymc.c        | 7 +++++++
 3 files changed, 13 insertions(+)

