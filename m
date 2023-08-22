Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15372783BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjHVIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjHVIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:38:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFDE1AB;
        Tue, 22 Aug 2023 01:38:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6989D228D1;
        Tue, 22 Aug 2023 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692693480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c0QBHDdpxUVvzXDXhQjofZECGQHaEuLHUH/mzET1lU8=;
        b=WKDtQ0i5LGH7K4mitqBjyrV5oy7w1fkDCl0ngxo43/CcglKCHd1Sm3geH44JzAadf9Ym0N
        zMoG5IiN+KrY5gf3FZsh4zYavcbgdBBNn7Bi4PAw+mCrCoUeY7GlMDb6B2gY7p5vRFywqT
        nmlVvBt03uvFUZFh4s68cvwJ2IxHE7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692693480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c0QBHDdpxUVvzXDXhQjofZECGQHaEuLHUH/mzET1lU8=;
        b=mVh5ks7F1jYAi9+gi17sDQwqfqfytXBJPBtkK6cEMs/YhVBXLav1uJNfSef1ngraTlglGF
        YiF7Y8XzNmRnEsAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56BDB132B9;
        Tue, 22 Aug 2023 08:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RZDJFOhz5GQZcAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 22 Aug 2023 08:38:00 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 0/3] Introduce nvmet target setup/cleanup helpers
Date:   Tue, 22 Aug 2023 10:38:09 +0200
Message-ID: <20230822083812.24612-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed Sagi's feedback and dropped the explicit --blkdev=device argument from
the _nvmet_target_setup calls, as it is the default.



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

v3:
 - rebased/retested
 - use the default with _nvmet_target_setup 

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

 tests/nvme/003 | 14 ++-----
 tests/nvme/004 | 21 ++---------
 tests/nvme/005 | 20 +---------
 tests/nvme/006 | 19 +---------
 tests/nvme/007 | 14 +------
 tests/nvme/008 | 21 +----------
 tests/nvme/009 | 16 +-------
 tests/nvme/010 | 21 +----------
 tests/nvme/011 | 16 +-------
 tests/nvme/012 | 21 +----------
 tests/nvme/013 | 16 +-------
 tests/nvme/014 | 21 +----------
 tests/nvme/015 | 16 +-------
 tests/nvme/018 | 16 +-------
 tests/nvme/019 | 21 +----------
 tests/nvme/020 | 16 +-------
 tests/nvme/021 | 16 +-------
 tests/nvme/022 | 16 +-------
 tests/nvme/023 | 21 +----------
 tests/nvme/024 | 16 +-------
 tests/nvme/025 | 16 +-------
 tests/nvme/026 | 16 +-------
 tests/nvme/027 | 17 ++-------
 tests/nvme/028 | 17 ++-------
 tests/nvme/029 | 21 +----------
 tests/nvme/033 | 10 ++---
 tests/nvme/034 | 10 ++---
 tests/nvme/035 | 10 ++---
 tests/nvme/036 | 12 +++---
 tests/nvme/037 |  5 +--
 tests/nvme/040 | 19 +---------
 tests/nvme/041 | 18 +--------
 tests/nvme/042 | 17 +--------
 tests/nvme/043 | 17 +--------
 tests/nvme/044 | 19 ++--------
 tests/nvme/045 | 18 ++-------
 tests/nvme/047 | 21 +----------
 tests/nvme/048 | 17 +--------
 tests/nvme/rc  | 99 +++++++++++++++++++++++++++++++++++++++++++++++---
 39 files changed, 184 insertions(+), 553 deletions(-)

-- 
2.41.0

