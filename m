Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50D7853A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjHWJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjHWJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:09:36 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2827423A;
        Wed, 23 Aug 2023 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1692781353; x=1724317353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AwpaYCib8MlS9D8QHLxoHGJ4Ok7wJP8PXV9mzZNz5cU=;
  b=t2e9wHgKsqWdnnWgWRUYiKc3pw7qzvqeaK6E6mrmgKWGIAbAYSKVa0yv
   gWbmoJtqjAYyq525f1KTXNaHxTQrQN3DzKnSOEiFXnjJAmmyLgCks5rdK
   X0eF1Gr9EKGr6ErfPRM/u1j8YE4bisGaNCp6N1/tKT/eHdQZxkVeS2tqv
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="1150066203"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:01:23 +0000
Received: from EX19D017EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id E9BB4A3D10;
        Wed, 23 Aug 2023 09:01:19 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D017EUA001.ant.amazon.com (10.252.50.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 23 Aug 2023 09:01:19 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.9) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 23 Aug 2023 09:01:13 +0000
From:   Babis Chalios <bchalios@amazon.es>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <bchalios@amazon.es>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <aams@amazon.de>, <dwmw@amazon.co.uk>, <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 0/2] Propagating reseed notifications to user space
Date:   Wed, 23 Aug 2023 11:01:04 +0200
Message-ID: <20230823090107.65749-1-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.212.9]
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space often implements PRNGs that use /dev/random as entropy
source. We can not expect that this randomness sources stay completely
unknown forever. For various reasons, the originating PRNG seed may
become known at which point the PRNG becomes insecure for further random
number generation. Events that can lead to that are for example fast
computers reversing the PRNG function using a number of inputs or
Virtual Machine clones which carry seed values into their clones.

During LPC 2022 Jason, Alex, Michael and me brainstormed on how to
atomically expose a notification to user space that it should reseed.
Atomicity is key for the VM clone case. This patchset implements a
potential path to do so.

This patchset introduces an epoch value as the means of communicating to
the guest the need to reseed. The epoch is a 32bit value with the
following form:

              RNG epoch
*-------------*---------------------*
| notifier id | epoch counter value |
*-------------*---------------------*
     8 bits           24 bits

Changes in this value signal moments in time that PRNGs need to be
re-seeded. As a result, the intended use of the epoch from user space
PRNGs is to cache the epoch value every time they reseed using kernel
entropy, then control that its value hasn't changed before giving out
random numbers. If the value has changed the PRNG needs to reseed before
producing any more random bits.

The API for getting hold of this value is offered through
/dev/(u)random. We introduce a new ioctl for these devices, which
creates an anonymous file descriptor. User processes can call the
ioctl() to get the anon fd and then mmap it to a single page. That page
contains the value of the epoch at offset 0.

Naturally, random.c is the component that maintains the RNG epoch.
During initialization it allocates a single global page which holds the
epoch value. Moreover, it exposes an API to kernel subsystems
(notifiers) which can report events that require PRNG reseeding.
Notifiers register with random.c and receive an 8-bit notifier id (up to
256 subscribers should be enough) and a pointer to the epoch. Notifying,
then, is equivalent to writing in the epoch address a new epoch value.

Notifiers write epoch values that include the notifier ID on the higher
8 bits and increasing counter values on the 24 remaining bits. This
guarantees that two notifiers cannot ever write the same epoch value,
since notificator IDs are unique.

The first patch of this series implements the epoch mechanism. It adds
the logic in the random.c to maintain the epoch page and expose the
user space facing API. It also adds the internal API that allows kernel
systems to register as notifiers.

Based on this API, we can implement notifiers. As example notifier, this
patch set only contains a virtio-rng backend. If we agree on this path
forward, the natural next notifier would be an in-kernel timer with a
user settable frequency that allows the kernel to notify all its user
space applications to reseed regularly.

Michael sent out a proposal for an extension to virtio-rng [1] which we
can use to turn virtio-rng devices to RNG epoch notifiers. Briefly, the
proposal defines the concept of "entropy leaks", i.e. events in time
that cause entropy to decrease, such as VM snapshots. A virtio-rng
driver can program the device to perform a number of operations on guest
memory when entropy leaks happen. The proposal defines two possible
operations:

* "fill-on-leak": Fill a buffer with random bytes
* "copy-on-leak": Copy a source buffer in a destination buffer

The second patch implements the entropy leak reporting feature of
virtio-rng and registers virtio-rng devices as epoch notifiers with
random.c. It ensures that one copy-on-leak operation is always in-flight
to increase the epoch value when a VM snapshot occurs. The intention is
that the VMM will perform these operations before resuming vCPUs, so
that user space processes will observe the changes in the epoch value
atomically. Additionally, it always keeps a fill-on-leak command in the
queue, so that we can get some fresh entropy when VM snapshots occur.

This is an RFC, so that we can discuss whether the proposed ABI works.
Also, I'd like to hear people's opinion on the internal registration
API, 8/24 split etc. If we decide that this approach works, I 'm happy
to add documentation for it, with examples on how user space can make
use of it. 

[1] https://lore.kernel.org/virtio-dev/20221121162756.350032-1-mst@redhat.com/

Babis Chalios (2):
  random: emit reseed notifications for PRNGs
  virtio-rng: implement entropy leak feature

 drivers/char/hw_random/virtio-rng.c | 189 +++++++++++++++++++++++++++-
 drivers/char/random.c               | 147 ++++++++++++++++++++++
 include/linux/random.h              |  28 +++++
 include/uapi/linux/random.h         |  11 ++
 include/uapi/linux/virtio_rng.h     |   3 +
 5 files changed, 373 insertions(+), 5 deletions(-)

-- 
2.40.1

