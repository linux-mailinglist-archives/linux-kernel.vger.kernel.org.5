Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF1789BCE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjH0HmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjH0Hly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ABCF4;
        Sun, 27 Aug 2023 00:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E0760FC9;
        Sun, 27 Aug 2023 07:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23DC433C8;
        Sun, 27 Aug 2023 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122110;
        bh=rQjRda5il1Qih4x4Sgsv9VVP6IJayf08n2wAKIBPsjc=;
        h=From:To:Cc:Subject:Date:From;
        b=hDNolPdICOmYP3fAK64ajNUJXLjFQ6iDjD4WwgndlTy6HCL3n9Mm6yyPq6n4KTTux
         ODSDqzIZ0nS2Iv2tbgTfckOjK78IBDj73mqzY0xsF2MIqz0DvMg/s5j+rE0Z5NKkF/
         4IQB0RZfiyw/l7LB1ey42iB1B1/PVeVrHk45l+Iw+4fq8HIsQoHwhTwPSPDKQzg79l
         K8SU6yTJaKpJDBzoCjmI0lMHSh9LDj0MqLacvaoewx2dpn97ifWRMsCe/UHsaesxx3
         SydUsBhyPAmbaN9LjSTngrlo1uQg0bOJ+WZHtBjxIvwD1u/C6PWcx/baxGTjUfw09F
         W8+ej41E0zc/w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 00/14] tty: n_tty: cleanup
Date:   Sun, 27 Aug 2023 09:41:33 +0200
Message-ID: <20230827074147.2287-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another part (say part III.) of the previous type unification
across the tty layer[1]. This time, in n_tty line discipline. Apart from
type changes, this series contains a larger set of refactoring of the
code. Namely, separating hairy code into single functions for better
readability.

[1] https://lore.kernel.org/all/20230810091510.13006-1-jirislaby@kernel.org/

Note this is completely independent on "part II." (tty_buffer cleanup),
so those two can be applied in any order.

[v2]
 * resend as I intertwined the series with and older one
 * use better name for variable in 03/14

Jiri Slaby (SUSE) (14):
  tty: n_tty: make flow of n_tty_receive_buf_common() a bool
  tty: n_tty: use output character directly
  tty: n_tty: use 'num' for writes' counts
  tty: n_tty: use time_is_before_jiffies() in n_tty_receive_overrun()
  tty: n_tty: make n_tty_data::num_overrun unsigned
  tty: n_tty: use MASK() for masking out size bits
  tty: n_tty: move canon handling to a separate function
  tty: n_tty: move newline handling to a separate function
  tty: n_tty: remove unsigned char casts from character constants
  tty: n_tty: simplify chars_in_buffer()
  tty: n_tty: use u8 for chars and flags
  tty: n_tty: unify counts to size_t
  tty: n_tty: extract ECHO_OP processing to a separate function
  tty: n_tty: deduplicate copy code in n_tty_receive_buf_real_raw()

 drivers/tty/n_tty.c | 538 +++++++++++++++++++++++---------------------
 1 file changed, 278 insertions(+), 260 deletions(-)

-- 
2.42.0

