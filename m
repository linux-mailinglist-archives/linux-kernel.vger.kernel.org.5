Return-Path: <linux-kernel+bounces-64236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B580853C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DDDB2455E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462B6166D;
	Tue, 13 Feb 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KCMcwyn9"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131861663;
	Tue, 13 Feb 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857817; cv=none; b=XUfF+MpMRCjeKjgtTmqN3yEqlO4wx31IMDSRDXeJnNFgb6aORHLL4HWWLPqISdf8JX/dQ7CfTxgradjZkZDeWMtJ2ghxfWGdCZCYrdCgMco7pB1Fck1Vkjn3f6GpOhX5qJ/H/E9Qa62iIbbYMTV2BYauU8MIq/6dyMUWbCZwPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857817; c=relaxed/simple;
	bh=s4dsyZ1XWIDQWZasD2OU3k15wJD0U+VB4hlf35/z0s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMsMEpNCW5fU9HNc4WJFXAXKpj85Q+KrF+kNaxae9YOIq8w9KxyThjHgK4v3rEf9Ven/OgemedA8J9gQjAhGqNdMSRxDwBvEpZpyx2U0TOJpsTvHcXrl4Ds5HY0F//diioxOoQupAILJvrgEivIh7LazAyaJcv2BswgXPeGdUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KCMcwyn9; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707857813;
	bh=s4dsyZ1XWIDQWZasD2OU3k15wJD0U+VB4hlf35/z0s0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KCMcwyn9tnID/uN9Cb3iLxUReMOTf6DWHx/J+6yd8cdH8futxZRWbENhIfuw0zJ+5
	 Pco0EmmCyd5hXetQMoHLjNsA7K8uNpzxphj8wCUMyYQB7moiRGiYGCaNM/GA8EZ+Ss
	 58nq0OSn/6nrLQsbYhdzOG5WkCG8Mn7EvI4zZNt07Dat68+FkISedQf42AQWcnK9Rk
	 Y5+zSFrt5HjS3s/0LX068gIYFEIRCrH23kl1VpHTmZWJ9jvZsSDjbTaAWxjquxJzZ2
	 N1ot4TFIl5FZhteLCD2ZKUuNGpgbG9NLmZOLL4OUp4jAUnNvIW3PRxPpwJrp5tqQ9a
	 qSxxAXLPZZDtw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TZDCT5BjdzYqK;
	Tue, 13 Feb 2024 15:56:53 -0500 (EST)
Message-ID: <f6067e3e-a2bc-483d-b214-6e3fe6691279@efficios.com>
Date: Tue, 13 Feb 2024 15:56:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPU data cache across reboot/kexec for pmem/dax devices
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <bc925b57-4814-4788-b369-cd2d135a7381@efficios.com>
 <65c687fd30cf2_afa4294bc@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65c687fd30cf2_afa4294bc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-09 15:15, Dan Williams wrote:
> Mathieu Desnoyers wrote:
>> Hi Dan,
>>
>> In the context of extracting user-space trace data when the kernel crashes,
>> the LTTng user-space tracer recommends using nvdimm/pmem to reserve an area
>> of physical (volatile) RAM at boot (memmap=nn[KMG]!ss[KMG]), and use the
>> resulting device to create/mount a dax-enabled fs (e.g. ext4).
>>
>> We then use this filesystem to mmap() the shared memory files for the tracer.
>>
>> I want to make sure that the very last events from the userspace tracer written
>> to the memory mapped buffers (mmap()) by userspace are present after a
>> warm-reboot (or kexec/kdump).
>>
>> Note that the LTTng user-space tracer (LTTng-UST) does *not* issue any clflush
>> (or equivalent pmem_persist() from libpmem) for performance reasons: ring buffer
>> data is usually overwritten many times before the system actually crashes, and
>> the only thing we really need to make sure is that the cache lines are not
>> invalidated without write back.
>>
>> So I understand that the main use-case for pmem is nvdimm, and that in order to
>> guarantee persistence of the data on power off an explicit pmem_persist() is
>> needed after each "transaction", but for the needs of tracing, is there some
>> kind of architectural guarantee that the data present in the cpu data cache
>> is not invalidated prior to write back in each of those scenarios ?
>>
>> - reboot with bios explicitly not clearing memory,
> 
> This one gives me pause, because a trip through the BIOS typically means
> lots of resets and other low level magic, so this would likely require
> pushing dirty data out of CPU caches prior to entering the BIOS code
> paths.
> 
> So this either needs explicit cache flushing or mapping the memory with
> write-through semantics. That latter one is not supported in the stack
> today.

I would favor the explicit cache flushing approach over write-through semantics
for performance reasons: typically the ring buffers are overwritten, so always
storing the data to memory would be wasteful.

But I would rather do the cache flushing only on crash (die oops/panic notifiers)
rather than require the tracer to flush cache lines immediately after each event
is produced, again for performance reasons.

I have done a crude attempt at registering die oops/panic notifiers from the pmem
driver, and flush all pmem areas to memory when die oops/panic notifiers are
called (see the untested patch below). I wonder if this is something that would be
generally useful ?

> 
>> - kexec/kdump.
> 
> This should maintain the state of CPU caches. As far as the CPU is
> concerned it is just long jumping into a new kernel in memory without
> resetting any CPU cache state.

Good to know that this scenario is expected to "Just Work".

Thanks,

Mathieu


diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index e9898457a7bd..b92f18607d39 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -26,12 +26,18 @@
  #include <linux/dax.h>
  #include <linux/nd.h>
  #include <linux/mm.h>
+#include <linux/panic_notifier.h>
  #include <asm/cacheflush.h>
  #include "pmem.h"
  #include "btt.h"
  #include "pfn.h"
  #include "nd.h"
  
+static int pmem_die_handler(struct notifier_block *self,
+		unsigned long ev, void *unused);
+static int pmem_panic_handler(struct notifier_block *self,
+		unsigned long ev, void *unused);
+
  static struct device *to_dev(struct pmem_device *pmem)
  {
  	/*
@@ -423,6 +429,9 @@ static void pmem_release_disk(void *__pmem)
  {
  	struct pmem_device *pmem = __pmem;
  
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+			&pmem->panic_notifier);
+	unregister_die_notifier(&pmem->die_notifier);
  	dax_remove_host(pmem->disk);
  	kill_dax(pmem->dax_dev);
  	put_dax(pmem->dax_dev);
@@ -573,9 +582,20 @@ static int pmem_attach_disk(struct device *dev,
  			goto out_cleanup_dax;
  		dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
  	}
-	rc = device_add_disk(dev, disk, pmem_attribute_groups);
+	pmem->die_notifier.notifier_call = pmem_die_handler;
+	pmem->die_notifier.priority = -INT_MAX;
+	rc = register_die_notifier(&pmem->die_notifier);
  	if (rc)
  		goto out_remove_host;
+	pmem->panic_notifier.notifier_call = pmem_panic_handler;
+	pmem->panic_notifier.priority = -INT_MAX;
+	rc = atomic_notifier_chain_register(&panic_notifier_list,
+			&pmem->panic_notifier);
+	if (rc)
+		goto out_unregister_die;
+	rc = device_add_disk(dev, disk, pmem_attribute_groups);
+	if (rc)
+		goto out_unregister_panic;
  	if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
  		return -ENOMEM;
  
@@ -587,6 +607,11 @@ static int pmem_attach_disk(struct device *dev,
  		dev_warn(dev, "'badblocks' notification disabled\n");
  	return 0;
  
+out_unregister_panic:
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+			&pmem->panic_notifier);
+out_unregister_die:
+	unregister_die_notifier(&pmem->die_notifier);
  out_remove_host:
  	dax_remove_host(pmem->disk);
  out_cleanup_dax:
@@ -749,6 +774,35 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
  	}
  }
  
+/*
+ * For volatile memory use-cases where explicit flushing of the data
+ * cache is not useful after stores, the pmem panic notifier is called
+ * on die/panic to make sure the content of the pmem memory area is
+ * flushed from data cache to memory, so it can be preserved across
+ * warm reboot. Use a low notifier priority to flush to memory stores
+ * that are performed from other die notifiers.
+ */
+static int pmem_die_handler(struct notifier_block *self,
+		unsigned long ev, void *unused)
+{
+	struct pmem_device *pmem = container_of(self, struct pmem_device, die_notifier);
+
+	/* Only trigger on DIE_OOPS for the die notifier. */
+	if (ev != DIE_OOPS)
+		return NOTIFY_DONE;
+	arch_wb_cache_pmem(pmem->virt_addr, pmem->size);
+	return NOTIFY_DONE;
+}
+
+static int pmem_panic_handler(struct notifier_block *self,
+		unsigned long ev, void *unused)
+{
+	struct pmem_device *pmem = container_of(self, struct pmem_device, panic_notifier);
+
+	arch_wb_cache_pmem(pmem->virt_addr, pmem->size);
+	return NOTIFY_DONE;
+}
+
  MODULE_ALIAS("pmem");
  MODULE_ALIAS_ND_DEVICE(ND_DEVICE_NAMESPACE_IO);
  MODULE_ALIAS_ND_DEVICE(ND_DEVICE_NAMESPACE_PMEM);
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 392b0b38acb9..6c5661a3d37b 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -4,6 +4,7 @@
  #include <linux/page-flags.h>
  #include <linux/badblocks.h>
  #include <linux/memremap.h>
+#include <linux/notifier.h>
  #include <linux/types.h>
  #include <linux/pfn_t.h>
  #include <linux/fs.h>
@@ -27,6 +28,8 @@ struct pmem_device {
  	struct dax_device	*dax_dev;
  	struct gendisk		*disk;
  	struct dev_pagemap	pgmap;
+	struct notifier_block	die_notifier;
+	struct notifier_block	panic_notifier;
  };
  
  long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


