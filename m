Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0778EF84
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjHaOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjHaOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F0E5C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693491717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AM9HToOuwcJWUNXswHPalFrriqMxGeDNfwiMjtPtH0g=;
        b=SFSITmtqReY2HzXyLYFnH7CKEGQyjkzOK9of1/+TDwk9OpOnzeFmDzqxrU2sez5XjKWcK5
        Azi1C6p6aa9WW8VZif50rx2GwhQphxJ0h+hIXFCpyH7XoVPQcOWJ9brVA4xkDyUWgrzTt8
        d0U0z6gMkPW+xNqFcLJScgk9lZGouKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-85sYEr0DNcGSBFKGfRDM8Q-1; Thu, 31 Aug 2023 10:21:56 -0400
X-MC-Unique: 85sYEr0DNcGSBFKGfRDM8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9896857A84;
        Thu, 31 Aug 2023 14:21:55 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75D79140E950;
        Thu, 31 Aug 2023 14:21:55 +0000 (UTC)
Date:   Thu, 31 Aug 2023 09:21:53 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.6
Message-ID: <20230831142152.GA28483@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.6

Changes include:

- Allow blocking posix lock requests to be interrupted while waiting.
  This requires a cancel request to be sent to the userspace daemon
  where posix lock requests are processed across the cluster.

- Fix a posix lock patch from the previous cycle in which lock requests
  from different file systems could be mixed up.

- Fix some long standing problems with nfs posix lock cancelation.

- Add a new debugfs file for printing queued callbacks.

- Stop modifying buffers that have been used to receive a message.

- Misc cleanups and some refactoring.

Thanks,
Dave


Alexander Aring (17):
      fs: dlm: remove twice newline
      fs: dlm: allow to F_SETLKW getting interrupted
      fs: dlm: fix F_CANCELLK to cancel pending request
      fs: dlm: add missing spin_unlock
      fs: dlm: remove unused processed_nodes
      fs: dlm: debugfs for queued callbacks
      fs: dlm: check on plock ops when exit dlm
      fs: dlm: add plock dev tracepoints
      fs: dlm: remove clear_members_cb
      fs: dlm: cleanup lock order
      fs: dlm: get recovery sequence number as parameter
      fs: dlm: drop rxbuf manipulation in dlm_copy_master_names
      fs: dlm: drop rxbuf manipulation in dlm_recover_master_copy
      fs: dlm: constify receive buffer
      fs: dlm: create midcomms nodes when configure
      fs: dlm: don't use RCOM_NAMES for version detection
      dlm: fix plock lookup when using multiple lockspaces


 fs/dlm/config.c                |   2 +-
 fs/dlm/debug_fs.c              | 101 +++++++++++++-
 fs/dlm/dir.c                   |  14 +-
 fs/dlm/dir.h                   |   6 +-
 fs/dlm/dlm_internal.h          |   1 +
 fs/dlm/lock.c                  | 120 ++++++++--------
 fs/dlm/lock.h                  |  16 ++-
 fs/dlm/lowcomms.c              |   1 -
 fs/dlm/member.c                |  15 +-
 fs/dlm/member.h                |   2 +-
 fs/dlm/midcomms.c              | 304 ++++++++++++++++-------------------------
 fs/dlm/midcomms.h              |   1 +
 fs/dlm/plock.c                 | 176 +++++++++++++++++++-----
 fs/dlm/rcom.c                  | 102 ++++++++------
 fs/dlm/rcom.h                  |  15 +-
 fs/dlm/recover.c               |  60 ++++----
 fs/dlm/recover.h               |  14 +-
 fs/dlm/recoverd.c              |  16 +--
 fs/dlm/requestqueue.c          |   3 +-
 fs/dlm/requestqueue.h          |   3 +-
 fs/gfs2/file.c                 |   9 +-
 fs/ocfs2/stack_user.c          |  13 +-
 include/linux/dlm_plock.h      |   2 +
 include/trace/events/dlm.h     |  51 +++++++
 include/uapi/linux/dlm_plock.h |   1 +
 25 files changed, 628 insertions(+), 420 deletions(-)

