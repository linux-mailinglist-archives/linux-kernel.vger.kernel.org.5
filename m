Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5157CF4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbjJSKJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345115AbjJSKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:09:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD7E119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:09:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD16AC433C8;
        Thu, 19 Oct 2023 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697710142;
        bh=96LKDRMrRpLCVaVRlRGnvTj5m9adaIRHeaHEEEyRJ08=;
        h=From:To:Cc:Subject:Date:From;
        b=bw11o5+I3+JgbuMc86sGALFuZS98+e+bGbUS8JrPwOxU3Q0ubZK2zl+9zdkOTHPbl
         wKz5mENFYv86mcaut0k3L6WbS7H4zVjxWymnyj6zy8qP3oFTR6oe8QtNOhSMve7JFG
         fFyza1W6Fcl52wiOaKODHGfHqazlRitBwfKjJ26tMkLCmptavmALEHLgKofwXXDnlX
         z0UA0YxLh7k4znCV7/pV5Oq6cUMsjh5X2px2wx9W9gSFC385JS9rl1dcYLlzoaIQIi
         9F3szJfxBqg3TGb+C4XwjCgStcuppwk7GoJY++OY8nmbR8qWwMfCDNcLb/P8uzxyn7
         T+d8nJh9yI68Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Thu, 19 Oct 2023 12:07:08 +0200
Message-Id: <20231019-kampfsport-metapher-e5211d7be247@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=brauner@kernel.org; h=from:subject:message-id; bh=96LKDRMrRpLCVaVRlRGnvTj5m9adaIRHeaHEEEyRJ08=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQa/F/fd/vBj5BZmU0bllctWrzpRppozLYdMXIuN39+c513 8dqbaR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATeZfJ8N/lr4zrjkC5/WcirmQlHr ksNb204onEr+lb53Np3+cWFzjByPBol8mfCy/+Z2Zd/5vrzJmjxZd1a8O8uGfrzi7pOMh+bTY3AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
An openat() call from io_uring triggering an audit call can apparently
cause the refcount of struct filename to be incremented from multiple
threads concurrently during async execution, triggering a refcount
underflow and hitting a BUG_ON(). That bug has been lurking around since
at least v5.16 apparently.

Switch to an atomic counter to fix that. The underflow check is
downgraded from a BUG_ON() to a WARN_ON_ONCE() but we could easily
remove that check altogether tbh and not waste an additional atomic. So
if you feel that extra check isn't needed you could just remove in case
you're pulling.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.6-rc6 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc7.vfs.fixes

for you to fetch changes up to 03adc61edad49e1bbecfb53f7ea5d78f398fe368:

  audit,io_uring: io_uring openat triggers audit reference count underflow (2023-10-13 18:34:46 +0200)

Please consider pulling these changes from the signed v6.6-rc7.vfs.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-rc7.vfs.fixes

----------------------------------------------------------------
Dan Clash (1):
      audit,io_uring: io_uring openat triggers audit reference count underflow

 fs/namei.c         | 9 +++++----
 include/linux/fs.h | 2 +-
 kernel/auditsc.c   | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)
