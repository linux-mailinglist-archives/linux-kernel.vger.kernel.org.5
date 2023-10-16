Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E57CB6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjJPXAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjJPW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:59:59 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E305583
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:59:56 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 94CFE240101
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697497194; bh=ax3OYaNyzb/CAjT3t3j/wT9jnoQetJ33Pay44iGgCeE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=iZQez9/kHdocquhh+VWzKq4hdZhsG/hdSrJjWmQi/dMkECPQNjUa4OiztJ9p7ExXJ
         9Ky74IjH4yBdEKDoGX21yHPqHTX7vCrGzyC6hOR4aOkEjlrQcY3OyYyPZAxr1St7iA
         m7pFvRl4o+6keb0xszrwjzAj4ytZO7p7gCchA7pBd4NAgIBIfiOizV5si+iMLdga+I
         xkd7emQMJQ/lPFum2ArFhjq9vkRgLx/HQrScknw33hZ97bw+WvMAp4H5zRRZFC7d3D
         zjEdCVIzHNbV24xrIi1+mSvAyGgiRexqADcTwWnyGzRPB7u46pHTogmd4gKuATMnZK
         Hpugqn3m5hHiA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S8Xcl6Mlbz9rxK;
        Tue, 17 Oct 2023 00:59:51 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 0/3] Remove secret-size restrictions for hashes
Date:   Mon, 16 Oct 2023 22:58:54 +0000
Message-Id: <20231016225857.3085234-1-shiftee@posteo.net>
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

Mark O'Donovan (3):
  nvme-auth: alloc nvme_dhchap_key as single buffer
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 52 ++++++++++++++++++--------------------
 drivers/nvme/host/auth.c   | 30 +++++++++++-----------
 drivers/nvme/target/auth.c | 30 ++++++++++++----------
 include/linux/nvme-auth.h  |  5 ++--
 4 files changed, 59 insertions(+), 58 deletions(-)

-- 
2.39.2

