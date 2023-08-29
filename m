Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4678CEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjH2VXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbjH2VXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:23:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E139D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:23:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a85b9deeb3so3397427b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693344206; x=1693949006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Gfae9W6JZA4FOvTHXMCLsNEnzWLesf3rTGmyrWh/To=;
        b=RKYzvHiFBv/RgxSHQ53R/O48CF9a8NGZoTZWa0eOIyW3UhR7yeUJGKf1bhaRV3jpjR
         tDN5WNqXj2eR4myoTyYzYPd6h8/GGoXMjlfgJPdvn46qbqWpV4mNdmoOPE1jmCBAK/Xe
         fINWb6RHZIxHJ7Dka09p1yDgAeu81QBSWY8p2o7wu+tTAFeMosiJHgva1hDM7V5eDIcT
         q/edd6xSI5qFCeZjAvdfQ3hSClAf2LT3ZrrnpgXIe3caBV/C6WkqT8vPLKQ0GcA0dKTo
         /vRCmgxSRzizxq1aDInLfG5Uyo+XdR9P8ji9aIGlCsMDjFGSU12SDITZaRXyRhZug1Oj
         MMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693344206; x=1693949006;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Gfae9W6JZA4FOvTHXMCLsNEnzWLesf3rTGmyrWh/To=;
        b=abHsvETdT3xklXmY1zsKWzIFZ8Ig9in50nY4BsnVnB9GVs34wIglr0xEYBla2XMR10
         rziYuhO+uxOEWmOtoqWhnd9ocoIUwCOA91aYffJvS3JP2KLcOmFufcsIHm+rJzKQPSxz
         fpRzMYd1rz3RtScBXIyi37GNExaLCdz+qRR+pnrLJHexfwGhaCM//nsZjGoY8I7UNdDM
         9cR40fnjYWGIz16va+lsRAQQHP6bEm9ce8UvPL1KfkBlpo0fBKiyTXiaDfLYy5lCRC1y
         QXWh2H302yBDT0yAmye31G+ddJYjdK/XtSQyP1ENgw0ojADI/NTcJZFeQOfrEyBP2MH4
         RsAA==
X-Gm-Message-State: AOJu0YxicDG3605NDnl9+d63ocEjNqf6nXzm6uQnhA65HtDYuIWfi6Ne
        B3GwmcN/YKeKKPojJZ/BeQ==
X-Google-Smtp-Source: AGHT+IGBFDFUXZdwWcfVo+Xsi8rpiyeiRLdKvdNDTmmCT93WswqXtEy1obEfaGpWMo3BUJOyesfmdQ==
X-Received: by 2002:a05:6808:612:b0:3a7:b2a4:1f17 with SMTP id y18-20020a056808061200b003a7b2a41f17mr329675oih.3.1693344205296;
        Tue, 29 Aug 2023 14:23:25 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
        by smtp.gmail.com with ESMTPSA id bg20-20020a056808179400b003a7a34a4ed8sm4929931oib.33.2023.08.29.14.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:23:24 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:47c1:5b9e:6495:c84d])
        by serve.minyard.net (Postfix) with ESMTPSA id 14E281800BA;
        Tue, 29 Aug 2023 21:23:24 +0000 (UTC)
Date:   Tue, 29 Aug 2023 16:23:22 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.6
Message-ID: <ZO5hymZPCRLHMMz7@mail.minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff:

  Merge tag 'linux-kselftest-fixes-6.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2023-05-17 11:16:36 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.6-1

for you to fetch changes up to d40f09c1a23024f0e550d9423f4d389672e1dfaf:

  ipmi_si: fix -Wvoid-pointer-to-enum-cast warning (2023-08-15 15:46:06 -0500)

----------------------------------------------------------------
Minor fixes for IPMI

Lots of small unconnected things, memory leaks on error, a possible
(though unlikely) deadlock, changes for updates to other things
that have changed.  Nothing earth-shattering, but things that need
update.

----------------------------------------------------------------
Chengfeng Ye (1):
      ipmi: fix potential deadlock on &kcs_bmc->lock

Corey Minyard (3):
      ipmi_watchdog: Fix read syscall not responding to signals during sleep
      ipmi:ssif: Fix a memory leak when scanning for an adapter
      ipmi: Change request_module to request_module_nowait

Ivan Orlov (1):
      ipmi: make ipmi_class a static const structure

Jiasheng Jiang (1):
      ipmi:ssif: Add check for kstrdup

Justin Stitt (1):
      ipmi_si: fix -Wvoid-pointer-to-enum-cast warning

Krzysztof Kozlowski (1):
      dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: drop unneeded quotes

Uwe Kleine-König (1):
      ipmi: Switch i2c drivers back to use .probe()

Yi Yang (1):
      ipmi_si: fix a memleak in try_smi_init()

 .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml      |  8 ++++----
 drivers/char/ipmi/ipmb_dev_int.c                   |  2 +-
 drivers/char/ipmi/ipmi_devintf.c                   | 24 +++++++++++-----------
 drivers/char/ipmi/ipmi_ipmb.c                      |  2 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |  5 +++++
 drivers/char/ipmi/ipmi_si_platform.c               |  4 ++--
 drivers/char/ipmi/ipmi_ssif.c                      | 11 +++++++---
 drivers/char/ipmi/ipmi_watchdog.c                  |  2 +-
 drivers/char/ipmi/kcs_bmc.c                        |  5 +++--
 drivers/char/ipmi/ssif_bmc.c                       |  2 +-
 10 files changed, 38 insertions(+), 27 deletions(-)

