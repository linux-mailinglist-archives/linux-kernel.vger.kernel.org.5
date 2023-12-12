Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C581080F788
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377188AbjLLUJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:09:28 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A235AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:09:32 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id D94JrCWy533VXD94JrOShy; Tue, 12 Dec 2023 21:09:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702411771;
        bh=TOqGi1ws2J2/YYsgiD/HwpONPM+0k7w0AaPx2uck5fE=;
        h=From:To:Cc:Subject:Date;
        b=YMxVs23knBY9ZnlWmH6ePcgxEIZbk2b6W/eGnh2ywnyt0fY+CbSnZ8aK7ZsUIp2u6
         MB01cuDRxlUS8Z/55Vbx7eVY7VB2V54SivYEoMO8mrTOzGWQL4YoiXUm3ZIS+jauuU
         3CtPoNDS/kmKyKv7Scp9lxnjK0mgTAkGLiTioCoJCpUWbll9YTPDhx/i1tjjGelDYI
         x8v0+ttV1Ggie5rb2oae18QaAV0W9B4lWmcAEX44teAhjnb1RsIdxe9rxd4AyGxuke
         A40mZXZDsAndWMI55axPNfK3KKDaokzcFjnGrm3Uj+jjTU/XUO7xZ37Jie+9WhG59I
         /x3VSArbhwxUw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Dec 2023 21:09:31 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hare@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     hare@suse.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] scsi: myrb: Fix a potential string truncation
Date:   Tue, 12 Dec 2023 21:09:09 +0100
Message-Id: <cover.1702411083.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/2 fixes a potential string truncation issue in rebuild_show(). It is
intended to be minimal in order to ease potential backport.

Patch 2/2 is a bigger patch that turns some snprintf() usage in _show functions
into preferred sysfs_emit() calls.
This patch overrides the changes made in 1/2.


There is another warning when building with W=1:
    1051 |                 "%u.%02u-%c-%02u",
         |                 ^~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:1050:9: note: ‘snprintf’ output between 10 and 14 bytes into a destination of size 12
but I think that it is a false positive because snprintf() in Linux does not
strickly folows the standard C behavior of snprintf(). If I understand correctly
Linux handles %02u when C ignores it.

Christophe JAILLET (2):
  scsi: myrb: Fix a potential string truncation in rebuild_show()
  scsi: myrb: Use sysfs_emit()

 drivers/scsi/myrb.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

-- 
2.34.1

