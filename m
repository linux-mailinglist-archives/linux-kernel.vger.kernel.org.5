Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61907CC115
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbjJQKxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjJQKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:53:11 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53312A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:53:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 90771240029
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:53:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697539987; bh=MLzZUl/+BHQHydxEN9HgZzS0VH6NylU05183B2OuUXA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=eV44l1Vxi5z6Z7TNlLCHy0v74F8mtYkWDKBQm0hXL8vbaH6kQHGsB2ILpTU4GHIRu
         OsAAHLuzKAnJcW/YsjnuxmwLrJqBeZn0HruXVTKYXrNq4S15Mpza6bxkH+sSIANjmW
         PeKpDCWemL53SUCWZQWmZpwDF2kDy+/uo9IQ3tJheqdR1nuDWfCpVtz7SK7a74U+/U
         YGyL5NURq8y3xxzRqjgGBqtY4dbni/vLzF+7+nqlFu1S0fA6tJoY1OL8BA7w3Stp1K
         SUfW2vQwBBhwbXyUd5YcEpu1Sv+Il0OqNUEP9YP2hwK+GpuMqWOai5iJ7kbBHnVzhk
         dCPjJKfiq9bMA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S8rRh5V1hz6tv5;
        Tue, 17 Oct 2023 12:53:04 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v4 0/3] Remove secret-size restrictions for hashes
Date:   Tue, 17 Oct 2023 10:52:48 +0000
Message-Id: <20231017105251.3274652-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This relates to the hash functions used to transform the secret.
The kernel currently restricts us to using secrets equal in size
to the transformation hash function they use.
e.g. 32 byte secrets with the SHA-256(32 byte) hash function.

This restriction is not required by the spec and means
incompatibility with more permissive implementations.

With these patches the example secret from the spec should now
be permitted with any of the following:
DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:01:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:02:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:03:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:

Note: Secrets are still restricted to 32,48 or 64 bits.

v1:
- Initial submission

v2:
- Added transformed_len as member of struct nvme_dhchap_key

v3:
- Return a struct nvme_dhchap_key from nvme_auth_transform_key()

v4:
- added helper to caclulate key struct size using struct_size()
- Break up lines which were too long
- Replace ternary operator with if
- Add missing ERR_CAST()

Mark O'Donovan (3):
  nvme-auth: alloc nvme_dhchap_key as single buffer
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 66 ++++++++++++++++++++++----------------
 drivers/nvme/host/auth.c   | 30 ++++++++---------
 drivers/nvme/target/auth.c | 31 ++++++++++--------
 include/linux/nvme-auth.h  |  7 ++--
 4 files changed, 75 insertions(+), 59 deletions(-)

-- 
2.39.2

