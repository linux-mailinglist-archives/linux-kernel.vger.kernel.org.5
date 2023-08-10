Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A425B77768C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjHJLN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjHJLNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:13:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACF2690;
        Thu, 10 Aug 2023 04:13:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD1821865;
        Thu, 10 Aug 2023 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691666002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rED1+lo1CKJ5LFxieE+v2KK5zpNWwJpOZuEn3HSuHHA=;
        b=Ppgj6l/IFCnycH8s5StteFd7ASPa6UPdtyp+8Kj4VbYnbYn+xrTpaqOdVRWrIlGxK5PML4
        Y+WAIxtfvCtgpnMjblpm5WjWV/v5UwpVfzTrXe+x5rx0dca5GAiuU41ZfQZYAH4H4zE4ha
        zHsHJnxhHiNayZDezAbEu92sfEy+eME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691666002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rED1+lo1CKJ5LFxieE+v2KK5zpNWwJpOZuEn3HSuHHA=;
        b=WDjrFZViFgdsr/hPTQWCHPVpz7OZLNCnp4bl1uvzXTzWJ6rWt1+X0hCj4sFAVayMxAMcN8
        +LaES6HkAuO1tXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40F2D138E2;
        Thu, 10 Aug 2023 11:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UzPDD1LG1GQwLwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:22 +0000
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
Subject: [PATCH blktests v2 00/12] Switch to allowed_host 
Date:   Thu, 10 Aug 2023 13:13:05 +0200
Message-ID: <20230810111317.25273-1-dwagner@suse.de>
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

I've updated the series accoring the feedback. Also added the mentioned
_nvmet_target_{setup|cleanup} helpers which reduced a lot of code.
Roughly 350 lines code less after the refactoring.

Maybe it's possible to refactor even more, e.g. this snippet


	local nvmedev
	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
	cat "/sys/block/${nvmedev}n1/uuid"
	cat "/sys/block/${nvmedev}n1/wwid"

could be moved into _nvme_connect_subsys(). Though there are quiet a few tests
which want the nvmedev later on for something like

	_run_fio_verify_io --size="${nvme_img_size}" \
		--filename="/dev/${nvmedev}n1"

So we could return the nvmedev from _nvme_connect_subsys() but I don't know if
this a good idea. FWIW, it would also fix the current problem we face with
nvme/047 which seems to lack the second _find_nvme_dev() call.


original cover letter:

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

changes:
v2:
 - updated commit messages
 - moved the removal of subsys_name to the right patch
 - added _nvmet_target_{setup|cleanup} helpers
   this addresses also the 'appears unused' warning by ShellCheck

v1:
 - initial version
   https://lore.kernel.org/linux-nvme/20230726124644.12619-1-dwagner@suse.de/

Daniel Wagner (12):
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
  nvme: Introduce nvmet_target_{setup/cleanup} common code

 tests/nvme/003 | 12 ++-----
 tests/nvme/004 | 23 ++++---------
 tests/nvme/005 | 22 +++---------
 tests/nvme/006 | 21 ++----------
 tests/nvme/007 | 19 ++---------
 tests/nvme/008 | 26 +++------------
 tests/nvme/009 | 21 +++---------
 tests/nvme/010 | 26 +++------------
 tests/nvme/011 | 22 +++---------
 tests/nvme/012 | 26 +++------------
 tests/nvme/013 | 22 +++---------
 tests/nvme/014 | 26 +++------------
 tests/nvme/015 | 21 +++---------
 tests/nvme/016 | 17 +++++-----
 tests/nvme/017 | 26 ++++++---------
 tests/nvme/018 | 21 +++---------
 tests/nvme/019 | 26 +++------------
 tests/nvme/020 | 21 +++---------
 tests/nvme/021 | 21 +++---------
 tests/nvme/022 | 21 +++---------
 tests/nvme/023 | 26 +++------------
 tests/nvme/024 | 21 +++---------
 tests/nvme/025 | 21 +++---------
 tests/nvme/026 | 21 +++---------
 tests/nvme/027 | 20 +++--------
 tests/nvme/028 | 20 +++--------
 tests/nvme/029 | 26 +++------------
 tests/nvme/030 | 19 ++++++-----
 tests/nvme/031 | 14 ++++----
 tests/nvme/033 |  9 ++---
 tests/nvme/034 |  9 ++---
 tests/nvme/035 |  9 ++---
 tests/nvme/036 |  9 ++---
 tests/nvme/037 |  8 ++---
 tests/nvme/038 |  6 ++--
 tests/nvme/039 |  4 +--
 tests/nvme/040 | 28 +++++-----------
 tests/nvme/041 | 49 +++++++++------------------
 tests/nvme/042 | 55 ++++++++++--------------------
 tests/nvme/043 | 52 ++++++++++-------------------
 tests/nvme/044 | 71 +++++++++++++++------------------------
 tests/nvme/045 | 62 ++++++++++++----------------------
 tests/nvme/046 |  1 +
 tests/nvme/047 | 30 ++++-------------
 tests/nvme/048 | 42 +++++++----------------
 tests/nvme/049 |  1 +
 tests/nvme/rc  | 90 +++++++++++++++++++++++++++++++++++++++++++++++---
 47 files changed, 398 insertions(+), 765 deletions(-)

-- 
2.41.0

