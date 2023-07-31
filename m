Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AEE768F97
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGaIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGaIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01331723;
        Mon, 31 Jul 2023 01:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F2D560F88;
        Mon, 31 Jul 2023 08:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC12AC433CA;
        Mon, 31 Jul 2023 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790581;
        bh=C858cK3IVRNBXL+ZU9kIJwJE3Aayva8V0BpdDOTGA+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSfKM7Y/XKWiZVda4hE1vXwfE+9O+P0VIbGOboHfp4xgihTCSrGVI4zJe5XSnwP9l
         tEptjpG8SKH9dHic4SLTjn/T6KHZwyf3pyTkYOJ17uvlDioTO56Y5OvTNBp5ABR+Wj
         g/aEJi016EWFYE/3uZmMMMpMXEEm/nMocfVkpHwow8Gc0tDMMFhAIhifHh+MyjOAx2
         5MBUNM0hIEmYo1nk0kIhR3xfALs2MRtL/+NU19GOUirBuDCjEO87e+3wXSUFkZhmdF
         82cJxPIGL32qt7673QP27eE+NAEfG3LDayJNdOXWNiiG2h8yhomvqIp3RdjHIw/gx8
         kRCnoPP+BTAKg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org
Subject: [PATCH 07/10] speakup: switch to unsigned iterator in spk_ttyio_receive_buf2()
Date:   Mon, 31 Jul 2023 10:02:41 +0200
Message-ID: <20230731080244.2698-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that spk_ttyio_receive_buf2() receives an unsigned count, the
iterator can/should be unsigned too. Switch to that to be explicit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: speakup@linux-speakup.org
---
 drivers/accessibility/speakup/spk_ttyio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 07373b3debd1..5d4bafe118ec 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -79,7 +79,7 @@ static int spk_ttyio_receive_buf2(struct tty_struct *tty,
 	struct spk_synth *synth = ldisc_data->synth;
 
 	if (synth->read_buff_add) {
-		int i;
+		unsigned int i;
 
 		for (i = 0; i < count; i++)
 			synth->read_buff_add(cp[i]);
-- 
2.41.0

