Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAD78DF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbjH3TYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbjH3JUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:20:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDA919A;
        Wed, 30 Aug 2023 02:20:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 578F41F45F;
        Wed, 30 Aug 2023 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693387201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A7pso9UwnZzwHHTkSP4qR+/6H0hJWXNiUE7cgLjrg+s=;
        b=oq3NKYx91a/1Q8qzFI+qPP0ISvqVa0PsVEjfvQd5aOtnUhqmYQ/bIRLVuRqpEU2IYYptIQ
        nnGvph7i54cRZCbFeXcz/DEumlgr9jN4wcgg0X9ySsDTCfMFXnmL9QwMP5bzgiv3uKOoYh
        Z24y4Rul6cckU+QXb2vM79AM7Ve2ECY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693387201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A7pso9UwnZzwHHTkSP4qR+/6H0hJWXNiUE7cgLjrg+s=;
        b=EzJgVoazKEo2xFcCJyH5yJjf17GHNWOJdLqBNQ13tJurEryw3GTgJgR8YQgZ5j97F7CHxC
        4wUXY7UTVyi8dcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 485CC13441;
        Wed, 30 Aug 2023 09:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s9ucEcEJ72RZGQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 30 Aug 2023 09:20:01 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 0/3] Introduce nvmet target setup/cleanup helpers
Date:   Wed, 30 Aug 2023 11:20:16 +0200
Message-ID: <20230830092019.9846-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the series according the last round of feedback and retested it. In
order to pass the 'make check' check this version depends on the upcoming revert
of 26664dff17b6 ("Do not suppress any shellcheck warnings") as discussed in the
v3 thread.

original cover letter:

Introduce helpers to setup nvmet targets. This is spin off from the refactoring
patches and the allowed_host patches [1].

Sagi suggested to record all resources allocated by nvmet_target_setup and then
later clean them up in nvmet_target_cleanup. I opted to figure out in
nvmet_target_cleanup what was allocated via the newly introdcuded _get_nvmet_ports
helper. The reason being, Hannes told me offline that he would like to add ANA
tests which will add some more ports to the subsystem. I hope with this
the code is more future proof.

BTW, while looking at this I saw that the passthru code is using the awkward
return value port when calling nvmet_passthru_target_setup. It seems some
more refactoring is in order...

[1] https://lore.kernel.org/linux-nvme/5h333eqhtw252sjw6axjewlb5bbb5ze7awekczxe3kie2lnhw6@manyer42khct/


changes

v4:
 - introduced _cleanup_blkdev helper
 - fixed --blkdev arguments passing
 - added unknown argument warning to _nvmet_target_setup argument parser
 - added rb tag

v3:
 - rebased/retested
 - use the default with _nvmet_target_setup
 - https://lore.kernel.org/linux-nvme/20230822083812.24612-1-dwagner@suse.de/

v2:
 - drop local subsys variable in passthru tests
 - do not use port as handle in passthru tests
 - free port after unregistering from subsys
 - https://lore.kernel.org/linux-nvme/20230818141537.22332-1-dwagner@suse.de/

v1:
 - https://lore.kernel.org/linux-nvme/20230818095744.24619-1-dwagner@suse.de/

Daniel Wagner (3):
  nvme/{033,034,035,036}: use default subsysnqn variable directly
  nvme/{033,034,035,036,37}: drop port handle between passthru target
    setup and cleanup
  nvme: introduce nvmet_target_{setup/cleanup} common code

 tests/nvme/003 |  14 ++-----
 tests/nvme/004 |  21 ++--------
 tests/nvme/005 |  20 +---------
 tests/nvme/006 |  19 +--------
 tests/nvme/007 |  14 +------
 tests/nvme/008 |  21 +---------
 tests/nvme/009 |  16 +-------
 tests/nvme/010 |  21 +---------
 tests/nvme/011 |  16 +-------
 tests/nvme/012 |  21 +---------
 tests/nvme/013 |  16 +-------
 tests/nvme/014 |  21 +---------
 tests/nvme/015 |  16 +-------
 tests/nvme/018 |  16 +-------
 tests/nvme/019 |  21 +---------
 tests/nvme/020 |  16 +-------
 tests/nvme/021 |  16 +-------
 tests/nvme/022 |  16 +-------
 tests/nvme/023 |  21 +---------
 tests/nvme/024 |  16 +-------
 tests/nvme/025 |  16 +-------
 tests/nvme/026 |  16 +-------
 tests/nvme/027 |  17 ++------
 tests/nvme/028 |  17 ++------
 tests/nvme/029 |  21 +---------
 tests/nvme/033 |  10 ++---
 tests/nvme/034 |  10 ++---
 tests/nvme/035 |  10 ++---
 tests/nvme/036 |  12 +++---
 tests/nvme/037 |   5 +--
 tests/nvme/040 |  19 +--------
 tests/nvme/041 |  18 +--------
 tests/nvme/042 |  17 +-------
 tests/nvme/043 |  17 +-------
 tests/nvme/044 |  19 ++-------
 tests/nvme/045 |  18 ++-------
 tests/nvme/047 |  21 +---------
 tests/nvme/048 |  17 +-------
 tests/nvme/rc  | 103 ++++++++++++++++++++++++++++++++++++++++++++++---
 39 files changed, 188 insertions(+), 553 deletions(-)

-- 
2.41.0

