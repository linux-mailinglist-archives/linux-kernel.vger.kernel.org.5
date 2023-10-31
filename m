Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE37DD7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjJaVso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 17:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJaVsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:48:42 -0400
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F1E4;
        Tue, 31 Oct 2023 14:48:40 -0700 (PDT)
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 0DFA91E135;
        Tue, 31 Oct 2023 17:48:40 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 2CCD7A8B05; Tue, 31 Oct 2023 17:48:39 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Message-ID: <25921.30263.150556.245226@quad.stoffel.home>
Date:   Tue, 31 Oct 2023 17:48:39 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs for v6.7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Using latest HEAD from linux git (commit
5a6a09e97199d6600d31383055f9d43fbbcbe86f (HEAD -> master,
origin/master, origin/HEAD), and the following config, I get this
failure when compiling on x86_64 Debian Bullseye (11):


     CC      fs/bcachefs/btree_io.o
   In file included from fs/bcachefs/btree_io.c:11:
   fs/bcachefs/btree_io.c: In function ‘bch2_btree_post_write_cleanup’:
   fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0 is outside the bounds of an interior zero-length array ‘struct bkey_packed[0]’ [-Werror=zero-length-bounds]
     274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
	 |                                    ^~~~~~~~~~~~~~~~~~~
   In file included from fs/bcachefs/bcachefs.h:206,
		    from fs/bcachefs/btree_io.c:3:
   fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing ‘start’
    2344 |  struct bkey_packed start[0];
	 |                     ^~~~~
   In file included from fs/bcachefs/btree_io.c:11:
   fs/bcachefs/btree_io.c: In function ‘bch2_btree_init_next’:
   fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0 is outside the bounds of an interior zero-length array ‘struct bkey_packed[0]’ [-Werror=zero-length-bounds]
     274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
	 |                                    ^~~~~~~~~~~~~~~~~~~
   In file included from fs/bcachefs/bcachefs.h:206,
		    from fs/bcachefs/btree_io.c:3:
   fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing ‘start’
    2344 |  struct bkey_packed start[0];
	 |                     ^~~~~
   cc1: all warnings being treated as errors
   make[4]: *** [scripts/Makefile.build:243: fs/bcachefs/btree_io.o] Error 1
   make[3]: *** [scripts/Makefile.build:480: fs/bcachefs] Error 2
   make[2]: *** [scripts/Makefile.build:480: fs] Error 2
   make[1]: *** [/local/src/kernel/git/linux/Makefile:1913: .] Error 2
   make: *** [Makefile:234: __sub-make] Error 2


My .config looks like this for BCACHEFS:

   $ grep BCACHEFS .config
   CONFIG_BCACHEFS_FS=y
   CONFIG_BCACHEFS_QUOTA=y
   CONFIG_BCACHEFS_POSIX_ACL=y
   CONFIG_BCACHEFS_DEBUG_TRANSACTIONS=y
   CONFIG_BCACHEFS_DEBUG=y
   CONFIG_BCACHEFS_TESTS=y
   # CONFIG_BCACHEFS_LOCK_TIME_STATS is not set
   # CONFIG_BCACHEFS_NO_LATENCY_ACCT is not set

