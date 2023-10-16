Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499357CA2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjJPI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjJPI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:57:25 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E195
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:57:24 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A9983240107
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697446642; bh=VvG7lAdIJ52HfYW9RRUqb2VWt1HKenPkukM7Qd9aHuI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=fuXHi9TWnOVTasbiPlH2+mb9Ikb8rlg+ukZHvAtXwPbkIKZNIltoGysnuzuXjGVj1
         sX2IzQoh5Gcna+tWZ44R4k1HZqhMSCtRdmdISUXGRQDM2oCYlnRI1XDzyMbTOxDizJ
         fFHs7RtDSy44dnG/NGTcDXlOUJeD37IpQU3kzQ1J694f9t89Igq0RL+TATjAPoZkr3
         WkbVxDd3m1pAONr1k28nmW8FuvqetmVBXHzDY8TpyFtgb3SVE1dgZEuxlJud89OY/g
         71AZtiQa5TciPzPJj5OYhbWyvQkYxR1+pDQS+klyeZ32JzYuT8lWyMx8SdcOsAuvdo
         ZCSntEC+T1HNA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S89wc6Cx8z9rxR;
        Mon, 16 Oct 2023 10:57:20 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 0/2] Remove secret-size restrictions for hashes
Date:   Mon, 16 Oct 2023 08:57:13 +0000
Message-Id: <20231016085715.3068974-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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


Mark O'Donovan (2):
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 14 +++++---------
 drivers/nvme/host/auth.c   |  4 ++--
 drivers/nvme/target/auth.c |  4 ++--
 include/linux/nvme-auth.h  |  3 ++-
 4 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.39.2

