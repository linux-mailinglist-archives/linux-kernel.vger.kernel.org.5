Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7427D2600
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 23:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjJVVAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 17:00:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3AE9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 14:00:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ufYFqwcwpG6boufYFqoC7e; Sun, 22 Oct 2023 23:00:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698008402;
        bh=73cQQIxO45qz3cOFWQdWJSGSNfMmo4mVxgrZWMonIWY=;
        h=From:To:Cc:Subject:Date;
        b=W0jDMP76iQYbOVkh8s0a7nAGBI9/PsvZpt5OmcjtevMyXpYOxcpRCJivVzH6a+8/b
         JHWcrTT2HHXpXLixt0PdiPc6KyDxglR4iVrjsHnHfa6aiz1fy0tPnAA7w2JWivP4pm
         u3CPtXZUYgbL9dzQ7ZSp64O5e5n50XKGz8K5UeNhlO1M2MUG1kKYgcXa4P0rVlfBfm
         rJTXzrq5Dt497JsQuAeJ3W4+SJEFRCk2C2D0q+A2/eZbnwocU0knlXpk7xjIiyGTHv
         3gM7JzerLUSCATt/C1dx0NNp+mCNhTerUQK1RbwiMQQmOMb25D4txUe+b8lFpbaANP
         XZfxbwnQZL+Wg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Oct 2023 23:00:02 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, veerasenareddy.burru@cavium.com
Cc:     felix.manlunas@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net 0/2] liquidio: Fix an off by one in octeon_download_firmware()
Date:   Sun, 22 Oct 2023 22:59:45 +0200
Message-Id: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie fixes an off by one related to the usage of strncat() in
octeon_download_firmware().

The first patch is a minimal fix.

The 2nd one is an attempt to remove strncat() which is used in a wrong way
most of the time.
It removes the need of an intermediate buffer but may need further discussions.
(i.e. is it a good idea to update h->bootcmd directly?)

Both patches are compile tested only.

Christophe JAILLET (2):
  liquidio: Fix an off by one in octeon_download_firmware()
  liquidio: Simplify octeon_download_firmware()

 .../net/ethernet/cavium/liquidio/octeon_console.c   | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.34.1

