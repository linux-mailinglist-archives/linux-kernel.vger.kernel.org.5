Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8380275C3F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGUKB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGUKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:01:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D13B2D58
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689933706; x=1721469706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QaVZwz5XHSqcKeGym1qUE63N5ps7pz4p8nRkFtr4PR8=;
  b=FCPh2Lz6gEU+G86gZYjp38T7tSO1jCyFDMPyMWRCidtI3t3sfn2IIPuX
   iNFzsAsXvVEtG2SNORo2UJ2JFqHqNaludw3wlPq2iDywIOeu4TUw2KhO7
   CzAlI+Pf3o9uGmJhnmyx6rcLnndduhlM4U7siDNS+fhWe6MWe2UJFr8fx
   wndNTIGwPT/xv17wppeWoQXe1nLnWmHIbat6aa5VQGyd//dBb2lGTRMjA
   U8bIVVLGsN2HgxI7VFGSXrlYQuTB6JD26ebfkNCFr459K16DES0900w0W
   DvxykPFXFVvjAcKKrHN25PP06Vhwjn6zhYD+4dHFuutWbukap0OhNi50T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370586972"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370586972"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724816792"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724816792"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2023 03:01:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AF70442D; Fri, 21 Jul 2023 13:01:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 1/1] ALSA: korg1212: Re-use sockptr_t and respective APIs
Date:   Fri, 21 Jul 2023 13:01:46 +0300
Message-Id: <20230721100146.67293-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sockptr_t (despite the naming) is a generic type to hold kernel
or user pointer and there are respective APIs to copy data to or
from it. Replace open coded variants in the driver by them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/korg1212/korg1212.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 33b4f95d65b3..92c3eab4d12c 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/sockptr.h>
 #include <linux/wait.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1285,8 +1286,7 @@ static int snd_korg1212_silence(struct snd_korg1212 *korg1212, int pos, int coun
 }
 
 static int snd_korg1212_copy_to(struct snd_pcm_substream *substream,
-				void __user *dst, int pos, int count,
-				bool in_kernel)
+				sockptr_t dst, int pos, int count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
         struct snd_korg1212 *korg1212 = snd_pcm_substream_chip(substream);
@@ -1306,24 +1306,21 @@ static int snd_korg1212_copy_to(struct snd_pcm_substream *substream,
 #if K1212_DEBUG_LEVEL > 0
 		if ( (void *) src < (void *) korg1212->recordDataBufsPtr ||
 		     (void *) src > (void *) korg1212->recordDataBufsPtr[8].bufferData ) {
-			printk(KERN_DEBUG "K1212_DEBUG: snd_korg1212_copy_to KERNEL EFAULT, src=%p dst=%p iter=%d\n", src, dst, i);
+			printk(KERN_DEBUG "K1212_DEBUG: %s KERNEL EFAULT, src=%p dst=%p iter=%d\n",
+			       __func__, src, sockptr_is_kernel(dst) ? dst.kernel : dst.user, i);
 			return -EFAULT;
 		}
 #endif
-		if (in_kernel)
-			memcpy((__force void *)dst, src, size);
-		else if (copy_to_user(dst, src, size))
+		if (copy_to_sockptr_offset(dst, i * size, src, size))
 			return -EFAULT;
 		src++;
-		dst += size;
 	}
 
 	return 0;
 }
 
 static int snd_korg1212_copy_from(struct snd_pcm_substream *substream,
-				  void __user *src, int pos, int count,
-				  bool in_kernel)
+				  sockptr_t src, int pos, int count)
 {
         struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_korg1212 *korg1212 = snd_pcm_substream_chip(substream);
@@ -1345,16 +1342,14 @@ static int snd_korg1212_copy_from(struct snd_pcm_substream *substream,
 #if K1212_DEBUG_LEVEL > 0
 		if ( (void *) dst < (void *) korg1212->playDataBufsPtr ||
 		     (void *) dst > (void *) korg1212->playDataBufsPtr[8].bufferData ) {
-			printk(KERN_DEBUG "K1212_DEBUG: snd_korg1212_copy_from KERNEL EFAULT, src=%p dst=%p iter=%d\n", src, dst, i);
+			printk(KERN_DEBUG "K1212_DEBUG: %s KERNEL EFAULT, src=%p dst=%p iter=%d\n",
+			       __func__, sockptr_is_kernel(src) ? src.kernel : src.user, dst, i);
 			return -EFAULT;
 		}
 #endif
-		if (in_kernel)
-			memcpy(dst, (__force void *)src, size);
-		else if (copy_from_user(dst, src, size))
+		if (copy_from_sockptr_offset(dst, src, i * size, size))
 			return -EFAULT;
 		dst++;
-		src += size;
 	}
 
 	return 0;
@@ -1644,15 +1639,14 @@ static int snd_korg1212_playback_copy(struct snd_pcm_substream *substream,
 				      int channel, unsigned long pos,
 				      void __user *src, unsigned long count)
 {
-	return snd_korg1212_copy_from(substream, src, pos, count, false);
+	return snd_korg1212_copy_from(substream, USER_SOCKPTR(src), pos, count);
 }
 
 static int snd_korg1212_playback_copy_kernel(struct snd_pcm_substream *substream,
 				      int channel, unsigned long pos,
 				      void *src, unsigned long count)
 {
-	return snd_korg1212_copy_from(substream, (void __user *)src,
-				      pos, count, true);
+	return snd_korg1212_copy_from(substream, KERNEL_SOCKPTR(src), pos, count);
 }
 
 static int snd_korg1212_playback_silence(struct snd_pcm_substream *substream,
@@ -1672,15 +1666,14 @@ static int snd_korg1212_capture_copy(struct snd_pcm_substream *substream,
 				     int channel, unsigned long pos,
 				     void __user *dst, unsigned long count)
 {
-	return snd_korg1212_copy_to(substream, dst, pos, count, false);
+	return snd_korg1212_copy_to(substream, USER_SOCKPTR(dst), pos, count);
 }
 
 static int snd_korg1212_capture_copy_kernel(struct snd_pcm_substream *substream,
 				     int channel, unsigned long pos,
 				     void *dst, unsigned long count)
 {
-	return snd_korg1212_copy_to(substream, (void __user *)dst,
-				    pos, count, true);
+	return snd_korg1212_copy_to(substream, KERNEL_SOCKPTR(dst), pos, count);
 }
 
 static const struct snd_pcm_ops snd_korg1212_playback_ops = {
-- 
2.40.0.1.gaa8946217a0b

