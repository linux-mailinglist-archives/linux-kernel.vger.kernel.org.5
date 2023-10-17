Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF67CC989
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbjJQRJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbjJQRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:09:40 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A3BB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:09:38 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 147BB240101
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697562576; bh=rlnHe0oU2ussQlwYxHpMoHyDbTunIDkyFCYAe1fYEf4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=amnelQWDhpzqm4QS6Cc0ixV2zH5qDtADR7lfBvwPcUUtHfohhw0OIXJ35dk9WtMlm
         NqIUI/cz7tnrTTAn/U7lnhKgCeTN08vVc+6KMkY+BLYWaUcV74ZuaZvV5RBESxV7a1
         mJ5K93oJc1pSaMVGToHuq0iKeFFiauJ+LGwiKbiFOkX101kmOrCZnsW62eAGnFo/ra
         TCNrMSVrYwbtpjYTUoovLFzgVtC/6ps1w+bV7vPcKk9iR+YOyI3z2CnkxXnG2itMDt
         9QWCFerkmN843m8F9rwu016tCK4rPU+mbxbxAXOSy1F5S3dctkcVDrIHUwhOQ7fBvR
         CmMM10vD5djig==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S90p52DsNz9rxS;
        Tue, 17 Oct 2023 19:09:33 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v5 0/3] Remove secret-size restrictions for hashes
Date:   Tue, 17 Oct 2023 17:09:16 +0000
Message-Id: <20231017170919.30358-1-shiftee@posteo.net>
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

v5:
- Removed newly redundant check found by kernel test robot

Mark O'Donovan (3):
  nvme-auth: alloc nvme_dhchap_key as single buffer
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 68 ++++++++++++++++++++++----------------
 drivers/nvme/host/auth.c   | 30 ++++++++---------
 drivers/nvme/target/auth.c | 31 +++++++++--------
 include/linux/nvme-auth.h  |  7 ++--
 4 files changed, 76 insertions(+), 60 deletions(-)

-- 
2.39.2

