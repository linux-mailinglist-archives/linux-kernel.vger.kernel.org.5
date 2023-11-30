Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F737FED59
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjK3KzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjK3KzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:55:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14B10E3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:55:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8010C433C7;
        Thu, 30 Nov 2023 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701341711;
        bh=t6ZounqBO6HxEEGhrx3bS0Kz+fsk66UnnVgdvGFbMgU=;
        h=From:To:Cc:Subject:Date:From;
        b=uIwEt2thI+cpFCjgvxCmTh0I+RHe1DAlDyR7sQIyySRC3eQ7seybZ9FDEU/WyLKV4
         RvvlsDbSGrStDvQrb9i10peqBWDwS/BR+Tup7t4nmlnN6kb8QLNzemtMlMXGQySyMC
         1MxL2tiEio3exkEMbjFJ+AdBNhc9h6dZvhDyqyss1EEG1PomDPGoyn6XBjA7FMJUwt
         6Ykoc7qr7dpEfTAs06/EaifOSK2bte/TkorWHD/Eiz1LzZkUstwBSHfItRXS92z4+T
         dm0uY7mGob973aulOk17zadWqJq3898Dq2J5i31TRZXu8eHfI+frDn9+YB3EydpHpU
         HuwawukDGhC9Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Damien Bergamini <damien.bergamini@free.fr>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Feng-Hsin Chiang <john453@faraday-tech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-usb@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Pawel Laszczak <pawell@cadence.com>,
        Po-Yu Chuang <ratbert.chuang@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Yuan-Hsin Chen <yhchen@faraday-tech.com>
Subject: [PATCH 0/5] usb: Replace {v}snprintf() variants with safer alternatives
Date:   Thu, 30 Nov 2023 10:54:34 +0000
Message-ID: <20231130105459.3208986-1-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is part of an effort to rid {v}snprintf() where possible.

For a far better description of the problem than I could author, see
Jon's write-up on LWN [1] and/or Alex's on the Kernel Self Protection
Project [1].

[0] https://lwn.net/Articles/69419/
[1] https://github.com/KSPP/linux/issues/105

Lee Jones (5):
  usb: atm: Remove snprintf() from sysfs call-backs and replace with
    sysfs_emit()
  usb: cdnsp: Replace snprintf() with the safer scnprintf() variant
  usb: fotg210-hcd: Replace snprintf() with the safer scnprintf()
    variant
  usb: gadget: Remove snprintf() from sysfs call-backs and replace with
    sysfs_emit()
  usb: gadget: f_tcm: Remove snprintf() from sysfs call-backs and
    replace with sysfs_emit()

 drivers/usb/atm/ueagle-atm.c        |  16 +-
 drivers/usb/cdns3/cdnsp-debug.h     | 354 ++++++++++++++--------------
 drivers/usb/fotg210/fotg210-hcd.c   |  12 +-
 drivers/usb/gadget/configfs.c       |   2 +-
 drivers/usb/gadget/function/f_tcm.c |   4 +-
 5 files changed, 192 insertions(+), 196 deletions(-)

Cc: Damien Bergamini <damien.bergamini@free.fr>
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-usb@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Po-Yu Chuang <ratbert.chuang@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Yuan-Hsin Chen <yhchen@faraday-tech.com>

-- 
2.43.0.rc1.413.gea7ed67945-goog

