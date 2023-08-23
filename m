Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366087853A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjHWJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjHWJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:09:38 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1191421D;
        Wed, 23 Aug 2023 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1692781354; x=1724317354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbwE+Ic9l946zgKm/AQ+R0y+kw0Btu3iq0hfOsHfm5M=;
  b=Dq17aceB9+uto3+dyHWwOMFjavO8jgjUIRFYwN0wHlKD7YchomKFJmYT
   eaiqFxApc82ZHXsV2rsGdFGORPg5tqEoX8FgGw+7E3IUW5L6DHKM2w2Fb
   DkUhsyc7A/j0fgCIysxN74MPVgFKnlxrkXINaHamG6nQNxYHaq3lmWA05
   U=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="579376605"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:01:31 +0000
Received: from EX19D016EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id E4325A004C;
        Wed, 23 Aug 2023 09:01:28 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D016EUA002.ant.amazon.com (10.252.50.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 23 Aug 2023 09:01:26 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.9) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 23 Aug 2023 09:01:20 +0000
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
Subject: [RFC PATCH 1/2] random: emit reseed notifications for PRNGs
Date:   Wed, 23 Aug 2023 11:01:05 +0200
Message-ID: <20230823090107.65749-2-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230823090107.65749-1-bchalios@amazon.es>
References: <20230823090107.65749-1-bchalios@amazon.es>
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

Sometimes, PRNGs need to reseed. For example, on a regular timer
interval, to ensure nothing consumes a random value for longer than e.g.
5 minutes, or when VMs get cloned, to ensure seeds don't leak in to
clones.

The notification happens through a 32bit epoch value that changes every
time cached entropy is no longer valid, hence PRNGs need to reseed. User
space applications can get hold of a pointer to this value through
/dev/(u)random. We introduce a new ioctl() that returns an anonymous
file descriptor. From this file descriptor we can mmap() a single page
which includes the epoch at offset 0.

random.c maintains the epoch value in a global shared page. It exposes
a registration API for kernel subsystems that are able to notify when
reseeding is needed. Notifiers register with random.c and receive a
unique 8bit ID and a pointer to the epoch. When they need to report a
reseeding event they write a new epoch value which includes the
notifier ID in the first 8 bits and an increasing counter value in the
remaining 24 bits:

              RNG epoch
*-------------*---------------------*
| notifier id | epoch counter value |
*-------------*---------------------*
     8 bits           24 bits

Like this, different notifiers always write different values in the
epoch.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/char/random.c       | 147 ++++++++++++++++++++++++++++++++++++
 include/linux/random.h      |  28 +++++++
 include/uapi/linux/random.h |  11 +++
 3 files changed, 186 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cb37760dfec..72b524099b60 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -54,6 +54,8 @@
 #include <linux/suspend.h>
 #include <linux/siphash.h>
 #include <linux/sched/isolation.h>
+#include "linux/anon_inodes.h"
+#include "linux/bitmap.h"
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #include <asm/archrandom.h>
@@ -206,6 +208,7 @@ enum {
 static struct {
 	u8 key[CHACHA_KEY_SIZE] __aligned(__alignof__(long));
 	unsigned long generation;
+	u32 cached_epoch;
 	spinlock_t lock;
 } base_crng = {
 	.lock = __SPIN_LOCK_UNLOCKED(base_crng.lock)
@@ -242,6 +245,138 @@ static unsigned int crng_reseed_interval(void)
 	return CRNG_RESEED_INTERVAL;
 }
 
+/*
+ * Tracking moments in time that PRNGs (ours and user-space) need to reseed
+ * due to an "entropy leak".
+ *
+ * We call the time period between two "entropy leak" events an "epoch".
+ * Epoch is a 32-bit unsigned value that lives in a dedicated global page.
+ * Systems that want to report entropy leaks will get an 1-byte notifier id
+ * (up to 256 notifiers) and the address of the epoch.
+ *
+ * Each notifier will write epochs in the form:
+ *
+ *      1 byte                  3 bytes
+ * +---------------+-------------------------------+
+ * |  notifier id  |    next epoch counter value   |
+ * +---------------+-------------------------------+
+ *
+ * This way, epochs are namespaced per notifier, so no two different
+ * notifiers will ever write the same epoch value.
+ */
+
+static struct {
+	struct rand_epoch_data *epoch;
+	DECLARE_BITMAP(notifiers, RNG_EPOCH_NOTIFIER_NR_BITS);
+	spinlock_t lock;
+} epoch_data = {
+	.lock = __SPIN_LOCK_UNLOCKED(epoch_data.lock),
+};
+
+static int epoch_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	if (vma->vm_pgoff || vma_pages(vma) > 1)
+		return -EINVAL;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	/* Don't allow growing the region with mremap(). */
+	vm_flags_set(vma, VM_DONTEXPAND);
+	/* Don't allow mprotect() to make this writeable in the future */
+	vm_flags_clear(vma, VM_MAYWRITE);
+
+	return vm_insert_page(vma, vma->vm_start, virt_to_page(epoch_data.epoch));
+}
+
+static const struct file_operations rng_epoch_fops = {
+	.mmap = epoch_mmap,
+	.llseek = noop_llseek,
+};
+
+static int create_epoch_fd(void)
+{
+	unsigned long flags;
+	int ret = -ENOTTY;
+
+	spin_lock_irqsave(&epoch_data.lock, flags);
+	if (bitmap_empty(epoch_data.notifiers, RNG_EPOCH_NOTIFIER_NR_BITS))
+		goto out;
+	spin_unlock_irqrestore(&epoch_data.lock, flags);
+
+	return anon_inode_getfd("rand:epoch", &rng_epoch_fops, &epoch_data, O_RDONLY | O_CLOEXEC);
+out:
+	spin_unlock_irqrestore(&epoch_data.lock, flags);
+	return ret;
+}
+
+/*
+ * Get the current epoch. If nobody has subscribed, this will always return 0.
+ */
+static unsigned long get_epoch(void)
+{
+	u32 epoch = 0;
+
+	if (likely(epoch_data.epoch))
+		epoch = epoch_data.epoch->data;
+
+	return epoch;
+}
+
+/*
+ * Register an epoch notifier
+ *
+ * Allocate a notifier ID and provide the address to the epoch. If the address
+ * has not being allocated yet (this is the first call to register a notifier)
+ * this will allocate the page holding the epoch. If we have reached the limit
+ * of notifiers it will fail.
+ */
+int rng_register_epoch_notifier(struct rng_epoch_notifier *notifier)
+{
+	unsigned long flags;
+	u8 new_id;
+
+	if (!notifier)
+		return -EINVAL;
+
+	spin_lock_irqsave(&epoch_data.lock, flags);
+	new_id = bitmap_find_free_region(epoch_data.notifiers, RNG_EPOCH_NOTIFIER_NR_BITS, 0);
+	if (new_id < 0)
+		goto err_no_id;
+	spin_unlock_irqrestore(&epoch_data.lock, flags);
+
+	notifier->id = new_id;
+	notifier->epoch = epoch_data.epoch;
+	return 0;
+
+err_no_id:
+	spin_unlock_irqrestore(&epoch_data.lock, flags);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(rng_register_epoch_notifier);
+
+/*
+ * Unregister an epoch notifier
+ *
+ * This will release the notifier ID previously allocated through
+ * `rng_register_epoch_notifier`.
+ */
+int rng_unregister_epoch_notifier(struct rng_epoch_notifier *notifier)
+{
+	unsigned long flags;
+
+	if (!notifier)
+		return -EINVAL;
+
+	spin_lock_irqsave(&epoch_data.lock, flags);
+	bitmap_clear(epoch_data.notifiers, notifier->id, 1);
+	spin_unlock_irqrestore(&epoch_data.lock, flags);
+
+	notifier->epoch = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rng_unregister_epoch_notifier);
+
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
 static void extract_entropy(void *buf, size_t len);
 
@@ -344,6 +479,14 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 			return;
 	}
 
+	/*
+	 * If the epoch has changed we reseed.
+	 */
+	if (unlikely(READ_ONCE(base_crng.cached_epoch) != get_epoch())) {
+		WRITE_ONCE(base_crng.cached_epoch, get_epoch());
+		crng_reseed(NULL);
+	}
+
 	local_lock_irqsave(&crngs.lock, flags);
 	crng = raw_cpu_ptr(&crngs);
 
@@ -888,6 +1031,8 @@ void __init random_init(void)
 	_mix_pool_bytes(&entropy, sizeof(entropy));
 	add_latent_entropy();
 
+	epoch_data.epoch = (struct rand_epoch_data *)get_zeroed_page(GFP_KERNEL);
+
 	/*
 	 * If we were initialized by the cpu or bootloader before jump labels
 	 * are initialized, then we should enable the static branch here, where
@@ -1528,6 +1673,8 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -ENODATA;
 		crng_reseed(NULL);
 		return 0;
+	case RNDEPOCH:
+		return create_epoch_fd();
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..0fdacf4ee8aa 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -161,4 +161,32 @@ int random_online_cpu(unsigned int cpu);
 extern const struct file_operations random_fops, urandom_fops;
 #endif
 
+
+/*
+ * Constants that define the format of the epoch value.
+ *
+ * Currently we use a 8/24 split for epoch values. The lower 24 bits are used
+ * for the epoch counter and the 8 remaining are used for the notifier ID.
+ */
+#define RNG_EPOCH_NOTIFIER_NR_BITS 8
+#define RNG_EPOCH_COUNTER_SHIFT 0
+#define RNG_EPOCH_COUNTER_MASK GENMASK(23, 0)
+#define RNG_EPOCH_ID_SHIFT 24
+#define RNG_EPOCH_ID_MASK GENMASK(31, 24)
+
+/*
+ * An epoch notifier is a system that can report entropy leak events.
+ * Notifiers receive a unique identifier and the address where they will write
+ * a new epoch when an entropy leak happens.
+ */
+struct rng_epoch_notifier {
+	/* unique ID of the notifier */
+	u8 id;
+	/* pointer to epoch data */
+	struct rand_epoch_data *epoch;
+};
+
+int rng_register_epoch_notifier(struct rng_epoch_notifier *notifier);
+int rng_unregister_epoch_notifier(struct rng_epoch_notifier *notifier);
+
 #endif /* _LINUX_RANDOM_H */
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index e744c23582eb..f79d93820bdd 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -38,6 +38,9 @@
 /* Reseed CRNG.  (Superuser only.) */
 #define RNDRESEEDCRNG	_IO( 'R', 0x07 )
 
+/* Get a file descriptor for the RNG generation page. */
+#define RNDEPOCH	_IO('R', 0x08)
+
 struct rand_pool_info {
 	int	entropy_count;
 	int	buf_size;
@@ -55,4 +58,12 @@ struct rand_pool_info {
 #define GRND_RANDOM	0x0002
 #define GRND_INSECURE	0x0004
 
+/*
+ * The epoch type exposed through /dev/(u)random to notify user-space
+ * PRNGs that need to re-seed
+ */
+struct rand_epoch_data {
+	__u32 data;
+};
+
 #endif /* _UAPI_LINUX_RANDOM_H */
-- 
2.40.1

