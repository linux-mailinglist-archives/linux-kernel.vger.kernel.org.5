Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1291E77DFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbjHPK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbjHPK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D12D68;
        Wed, 16 Aug 2023 03:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 398E16655C;
        Wed, 16 Aug 2023 10:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8A2C433C8;
        Wed, 16 Aug 2023 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183505;
        bh=C+x2iRfn8GLwjrgWqWWRBUNt/4FRA0NEuWds6mhNJgc=;
        h=From:To:Cc:Subject:Date:From;
        b=ej27P6s3ZzQCJcsxfhORGRtt60q3skegAMLO/9yJCPU7jrvk30BxAifZbDvI3tp3s
         OyKTEKimtbweLkYobwHNiUNzvwdrGsW9Z1zR3pH5hTY9HQDVhEPPCc87hIKqRi4GHJ
         TaRZYk4gQRtY3PHfJJLo79GT1rla6eG6GWTJWZ5sGVRDfTq34SAaxG09hHSiQ/N5vC
         aQzPrYA+2YtKn1BQquevVuZ8E83ugHotWRclHosJim5kNZ4pxhKNGTMFeJHYKyXHHb
         Nbb8jPCFNp+pElueFwo0Z3zjwjUCTWOHP/nKYWbIsFcJbK7IeRy9iFnm7nxvyx3TU3
         N3J5qsZSpqUaA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/14] tty: n_tty: cleanup
Date:   Wed, 16 Aug 2023 12:58:04 +0200
Message-ID: <20230816105822.3685-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
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

Jiri Slaby (SUSE) (14):
  tty: n_tty: make flow of n_tty_receive_buf_common() a bool
  tty: n_tty: use output character directly
  tty: n_tty: use 'retval' for writes' retvals
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

 drivers/tty/n_tty.c | 551 +++++++++++++++++++++++---------------------
 1 file changed, 284 insertions(+), 267 deletions(-)

-- 
2.41.0

