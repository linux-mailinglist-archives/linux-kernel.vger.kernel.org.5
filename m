Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240CC7D9B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346027AbjJ0Od6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346069AbjJ0Odw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:33:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA326C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:33:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65408C433C8;
        Fri, 27 Oct 2023 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698417229;
        bh=XtwBVpxwOzBBFzwktednvY+wvC5tqsoHYE/dsTsZi+A=;
        h=From:To:Cc:Subject:Date:From;
        b=W59Cui+silA+bkCqaB4LVXiUAULBbO1iAcfW8qlFqqhJGjHiAKo0GwhKzuN6p4M5k
         NDfN3LhTY3ujwji06lqQo7grfiKJpX2wWjT22ehh9Luvicuf/Smq65Vx7J+3gi61W2
         Q7cXHQcDQ3S5MR5vS3QkdFRKQsuiK4PmsBIYIRS6snhyO6diMEMQ0hI43tT3cRYocF
         I5yFInjExXNrVR4NKFEzpIVL9JRC7JtXEDE1L44mrqfMSHf7uXxud4oltGRqVWek/C
         Pynkt+EZ0kMq57jhntIVGFOoDG2mPTgZRxt4OYMbjt04cxMX0fq+mmbM/Fk8gPGHIP
         K0Uo+jLgcwVdA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.7] autofs updates
Date:   Fri, 27 Oct 2023 16:33:41 +0200
Message-Id: <20231027-vfs-autofs-018bbf11ed67@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388; i=brauner@kernel.org; h=from:subject:message-id; bh=XtwBVpxwOzBBFzwktednvY+wvC5tqsoHYE/dsTsZi+A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRan9Lufb7oz+pFD46+TH/VYntfbq/bzBO/bkrVRk+ccuYj z4q/TB2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT0brByPDo+tLomTkn7x/nV55R6c pw3vr8PamvOxs9zt3aunhnhJcTI8PVV4+EDiXoJFZaL45rq36yZ8aEt6vqai54Pv5z7eYja11eAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This ports autofs to the new mount api. The patchset has existed for
quite a while but never made it upstream. Ian picked it back up.

This also fixes a bug where fs_param_is_fd() was passed a garbage
param->dirfd but it expected it to be set to the fd that was used to set
param->file otherwise result->uint_32 contains nonsense. So make sure
it's set.

One less filesystem using the old mount api. We're getting there, albeit
rather slow. The last remaining major filesystem that hasn't converted
is btrfs. Patches exist - I even wrote them - but so far they haven't
made it upstream.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.autofs

for you to fetch changes up to d3c50061765d4b5616dc97f5804fc18122598a9b:

  autofs: fix add autofs_parse_fd() (2023-10-24 11:04:45 +0200)

Please consider pulling these changes from the signed vfs-6.7.autofs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.autofs

----------------------------------------------------------------
Christian Brauner (1):
      fsconfig: ensure that dirfd is set to aux

Ian Kent (9):
      autofs: refactor autofs_prepare_pipe()
      autofs: add autofs_parse_fd()
      autofs: refactor super block info init
      autofs: reformat 0pt enum declaration
      autofs: refactor parse_options()
      autofs: validate protocol version
      autofs: convert autofs to use the new mount api
      autofs: fix protocol sub version setting
      autofs: fix add autofs_parse_fd()

 fs/autofs/autofs_i.h |  20 ++-
 fs/autofs/init.c     |   9 +-
 fs/autofs/inode.c    | 435 +++++++++++++++++++++++++++++++--------------------
 fs/fsopen.c          |   1 +
 4 files changed, 283 insertions(+), 182 deletions(-)
