Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102EA7636B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjGZMrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjGZMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:47:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8819BE;
        Wed, 26 Jul 2023 05:46:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 184D11F85D;
        Wed, 26 Jul 2023 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690375612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EiMntcZNL9Bmmzjn0NGwCc0QnLuebbsVshrPJM/t5TE=;
        b=XeWhdRRh/c1oBzGA94U2MbTAqQ3lq1XXWVOCZFJ8QqFWdcx4lPSDPCjoM4sVWHpnZ6cA/M
        IpaTpqKudLV3Go8k2jCqSWU3o6B3Yf66VsfYBeF0h6W3czjm/NTLLdeNqPvtYMF31QyRWo
        bK/au2TkDqGpKpwKCgHzxiBo4YvNfU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690375612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EiMntcZNL9Bmmzjn0NGwCc0QnLuebbsVshrPJM/t5TE=;
        b=91S1RSdUqtTwR7+CDUjSgkAZzbSOl+9/gsfFOPMHbnelanUebSDBLTI2InkbRV/m8esg0H
        ohNISCoa7jCsCICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2B41139BD;
        Wed, 26 Jul 2023 12:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sMI2O7sVwWQdUAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 12:46:51 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 00/11] Switch to allowed_host 
Date:   Wed, 26 Jul 2023 14:46:33 +0200
Message-ID: <20230726124644.12619-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max asked me to replace replace the 'nvme/rc: Avoid triggering host nvme-cli
autoconnect' feature with using allowed_host on the target side [1]

So while looking into this new feature, I first started to refactor existing
code so that it looks a bit more consistent. I think there is even more
potential to make it smaller, by introducing something similiar to
_nvmet_passthru_target_setup() and _nvmet_passthru_target_cleanup() for non
passthru tests. A lot of duplicated setup/cleanup code in many tests.

Except the last two patches are just refactoring patches. So if we decide to use
common target setup/cleanup helpers, I think we could add them before the last
two patches, which would make the last patch way smaller.

Daniel

[1] https://lore.kernel.org/all/4b17be94-d068-f026-756f-59208075e254@nvidia.com/

Daniel Wagner (11):
  nvme/{003,004,005,013,046,049}: Group all variables declarations
  nvme: Reorganize test preamble code section
  nvme/rc: Add common subsystem nqn define
  nvme: Use def_subsysnqn variable instead local variable
  nvme/{041,042,043,044,045,048}: Remove local variable hostnqn and
    hostid
  nvme/rc: Add common file_path name define
  nvme: Use def_file_path variable instead local variable
  nvme/rc: Add common def_subsys_uuid define
  nvme: Use def_subsys_uuid variable
  nvme/rc: Add helper for adding/removing to allow list
  nvme: Add explicitly host to allow_host list

 tests/nvme/003 | 11 ++++----
 tests/nvme/004 | 27 +++++++++++---------
 tests/nvme/005 | 27 +++++++++++---------
 tests/nvme/006 | 21 ++++++++-------
 tests/nvme/007 | 20 ++++++---------
 tests/nvme/008 | 26 +++++++++----------
 tests/nvme/009 | 24 +++++++++---------
 tests/nvme/010 | 26 +++++++++----------
 tests/nvme/011 | 25 +++++++++---------
 tests/nvme/012 | 26 +++++++++----------
 tests/nvme/013 | 25 +++++++++---------
 tests/nvme/014 | 26 +++++++++----------
 tests/nvme/015 | 24 +++++++++---------
 tests/nvme/016 | 17 ++++++-------
 tests/nvme/017 | 26 ++++++++-----------
 tests/nvme/018 | 24 +++++++++---------
 tests/nvme/019 | 26 +++++++++----------
 tests/nvme/020 | 24 +++++++++---------
 tests/nvme/021 | 24 +++++++++---------
 tests/nvme/022 | 24 +++++++++---------
 tests/nvme/023 | 26 +++++++++----------
 tests/nvme/024 | 24 +++++++++---------
 tests/nvme/025 | 24 +++++++++---------
 tests/nvme/026 | 24 +++++++++---------
 tests/nvme/027 | 24 +++++++++---------
 tests/nvme/028 | 24 +++++++++---------
 tests/nvme/029 | 26 +++++++++----------
 tests/nvme/030 | 19 +++++++-------
 tests/nvme/031 | 14 +++++-----
 tests/nvme/033 |  9 ++++---
 tests/nvme/034 |  9 ++++---
 tests/nvme/035 |  9 ++++---
 tests/nvme/036 |  9 ++++---
 tests/nvme/037 |  8 +++---
 tests/nvme/038 |  6 ++---
 tests/nvme/039 |  4 +--
 tests/nvme/040 | 30 ++++++++++++----------
 tests/nvme/041 | 50 ++++++++++++++++--------------------
 tests/nvme/042 | 55 ++++++++++++++++++----------------------
 tests/nvme/043 | 52 +++++++++++++++++--------------------
 tests/nvme/044 | 69 +++++++++++++++++++++++---------------------------
 tests/nvme/045 | 61 ++++++++++++++++++++------------------------
 tests/nvme/046 |  1 +
 tests/nvme/047 | 30 +++++++++++-----------
 tests/nvme/048 | 46 +++++++++++++++------------------
 tests/nvme/049 |  1 +
 tests/nvme/rc  | 30 +++++++++++++++++++---
 47 files changed, 572 insertions(+), 585 deletions(-)

-- 
2.41.0

