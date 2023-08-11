Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEA778A12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjHKJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjHKJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:36:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DC32709;
        Fri, 11 Aug 2023 02:36:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDF0D1F74A;
        Fri, 11 Aug 2023 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691746578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UDONgfwgA/FMspNb/GOALY2RYg7JltRc6Ev7K/UxWaw=;
        b=x1MHdMx26Ax67mKKIsE3NEmwz4NRYvnm77MrBSgt6WC3voD8gdp6D7HD8qsaPePhmHH7Gi
        gHgDZPdWY1u8PBhNH10ACf4SihXbHGZOagyVhXiusPkzV89qTvotwa4SputhfuoutpWPn/
        5e5AgJyy3Da4ZkZ6SWDeblTkT18O0TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691746578;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UDONgfwgA/FMspNb/GOALY2RYg7JltRc6Ev7K/UxWaw=;
        b=t8XJzg82wvsTCVOiJ9d4IqoZeOqHmLbYKaitH9wZDy6xbUl+3/egEKa9+o062aclW8kWym
        SHlN7BvnCQ+RGjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC013138E2;
        Fri, 11 Aug 2023 09:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YOsiFxEB1mSSHwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:17 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 00/13] Switch to allowed_host 
Date:   Fri, 11 Aug 2023 11:36:01 +0200
Message-ID: <20230811093614.28005-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed the comments from v2. I also added cleanup code to _nvmet_cleanup() to
make sure we do not leak resources when something goes wrong. I run into this
while testing and all tests after the first failure failed then.

changes:
v3:
 - added new patch: "nvme/043: Use hostnqn to generate DHCAP key"
 - removed unused variable in "nvme/rc: Add helper for adding/removing to allow list"
 - added cleanup code to _nvmet_cleanup().

v2:
 - updated commit messages
 - moved the removal of subsys_name to the right patch
 - added _nvmet_target_{setup|cleanup} helpers
   this addresses also the 'appears unused' warning by ShellCheck
 - https://lore.kernel.org/linux-nvme/20230810111317.25273-1-dwagner@suse.de/

v1:
 - initial version
   https://lore.kernel.org/linux-nvme/20230726124644.12619-1-dwagner@suse.de/


*** BLURB HERE ***

Daniel Wagner (13):
  nvme/{003,004,005,013,046,049}: Group all variables declarations
  nvme: Reorganize test preamble code section
  nvme/043: Use hostnqn to generate DHCAP key
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
  nvme: Introduce nvmet_target_{setup/cleanup} common code

 tests/nvme/003 | 12 ++-----
 tests/nvme/004 | 23 ++++--------
 tests/nvme/005 | 22 +++---------
 tests/nvme/006 | 21 ++---------
 tests/nvme/007 | 19 ++--------
 tests/nvme/008 | 26 +++-----------
 tests/nvme/009 | 21 +++--------
 tests/nvme/010 | 26 +++-----------
 tests/nvme/011 | 22 +++---------
 tests/nvme/012 | 26 +++-----------
 tests/nvme/013 | 22 +++---------
 tests/nvme/014 | 26 +++-----------
 tests/nvme/015 | 21 +++--------
 tests/nvme/016 | 17 +++++----
 tests/nvme/017 | 26 ++++++--------
 tests/nvme/018 | 21 +++--------
 tests/nvme/019 | 26 +++-----------
 tests/nvme/020 | 21 +++--------
 tests/nvme/021 | 21 +++--------
 tests/nvme/022 | 21 +++--------
 tests/nvme/023 | 26 +++-----------
 tests/nvme/024 | 21 +++--------
 tests/nvme/025 | 21 +++--------
 tests/nvme/026 | 21 +++--------
 tests/nvme/027 | 20 +++--------
 tests/nvme/028 | 20 +++--------
 tests/nvme/029 | 26 +++-----------
 tests/nvme/030 | 19 +++++-----
 tests/nvme/031 | 14 ++++----
 tests/nvme/033 |  9 ++---
 tests/nvme/034 |  9 ++---
 tests/nvme/035 |  9 ++---
 tests/nvme/036 |  9 ++---
 tests/nvme/037 |  8 ++---
 tests/nvme/038 |  6 ++--
 tests/nvme/039 |  4 +--
 tests/nvme/040 | 28 +++++----------
 tests/nvme/041 | 49 ++++++++-----------------
 tests/nvme/042 | 55 ++++++++++------------------
 tests/nvme/043 | 52 +++++++++------------------
 tests/nvme/044 | 71 ++++++++++++++----------------------
 tests/nvme/045 | 62 ++++++++++++--------------------
 tests/nvme/046 |  1 +
 tests/nvme/047 | 30 ++++------------
 tests/nvme/048 | 42 +++++++---------------
 tests/nvme/049 |  1 +
 tests/nvme/rc  | 97 +++++++++++++++++++++++++++++++++++++++++++++++---
 47 files changed, 404 insertions(+), 766 deletions(-)

-- 
2.41.0

