Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5D07C8E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJMU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjJMU3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:29:06 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC7BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:29:01 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 56BA6240029
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 22:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697228939; bh=FLYT+SprL3ZRgczhwxNKHQ8OrNt4PO3mwxSQn6FYQbQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=ITA6OledQbDyCnMqLfsAA0aT9iS6L1DU5tl5QEJHCFGUB5MTaE/9YBYioEfHWDtqY
         wzbdGHvjrX1lMo3S+iViQ3FltaKZFrNE52gizqA0mLdRgl7WHHVeF3kKEBCVzfCC7G
         Q8jtsmEiI2VrnD/bLiHqMaaXkhEKf/qN5xNMRR6/1iJbIpyjyxsDPaARsOLzp9nHBD
         RQTo6Pbgd8c9znabXOUEdtk45O99uRpZJNRgCY71zU1EZD+ntj/dm9lbVtSH6hLLcg
         sxJdDLZwRf7nMK/lLwcqtitkwAv1XJsBoG78vw5V3bBzbOzn4hu71Wr/N9eBtgWmL6
         aqC8BvhDXfKzQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S6dPz2MPJz9rxF;
        Fri, 13 Oct 2023 22:28:55 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 0/2] Remove secret-size restrictions for hashes
Date:   Fri, 13 Oct 2023 20:28:25 +0000
Message-Id: <20231013202827.2262708-1-shiftee@posteo.net>
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


Mark O'Donovan (2):
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c |  8 --------
 drivers/nvme/host/auth.c   | 11 ++++++++++-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.39.2

