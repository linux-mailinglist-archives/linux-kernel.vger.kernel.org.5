Return-Path: <linux-kernel+bounces-89010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499386E96D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACD11F227E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D83A27E;
	Fri,  1 Mar 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lt5xGL4i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQe+ObDJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0DC4411;
	Fri,  1 Mar 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320978; cv=none; b=TynzYToiLEs3F7gwqM+I0Wvc4vQphf7Rg+g8iV0Of1Mnv8KVD1LbRBEbXWB9WalYSyB8++kdRn6WJkCKGpsru4FFEoikzGNXKiMsv4sSKvnsQ+8nINDt8/yOTDdesttAkDMIroK7LbtOx9Dfcmbz17+8u19hgSlo+nOoEfhE8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320978; c=relaxed/simple;
	bh=RnWq3/w3b5O1R4cAPn/Hl295cghGBKImtXIoeFUspHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1rmPTtm9YaPp8npyTYYmIZn1RaFMBjJtajHix1zQS5ubbEKz2qXYbc48uZeGelYzfTtG+i911uMgqNcKERyeTG8FmvLT0no0fL8nTA7h/2MJWYQhQvYvMUGSXRPCCC/brDlJxSinuYByCJaNezVrCNTyVCEkQRtZWNH5IKVBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lt5xGL4i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQe+ObDJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709320974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YMpY8/JpqyvoIt2gTWiMpRfebnk0Oqv1/khPRGpbCE=;
	b=lt5xGL4ikp2rMYJDfZ7HvTc51J0sK0wPz+5c8vFx1SuS27stYaJOWuKM8UWBr5+pgOT4Px
	/zf1ECIiqu/o9bDNXwd0OmwFvn3wr5s6TWTh22XQgJnd6zNcYHvNw3H+EjqkCRzzHyGlCK
	9c0McLTbOgJYwbxjj3ufVtBUaYTbp1OW9F0wWwGg67WLBjIW6BXQ6uACYMaX/U19dW7hVE
	7YFSbHNtjH9wi+H5aXUENJ0WYyrEuLnL22HQ9pNMUw1GoSzpgNifD5GbZh1qfFM9H40tVf
	8sahtMCI3rvRxY+czEM18S9Ga4W7B19CKnB0D8BHfOsg6bSvXKNzJzKLNOWfWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709320974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YMpY8/JpqyvoIt2gTWiMpRfebnk0Oqv1/khPRGpbCE=;
	b=GQe+ObDJ3PZr8qn2Ba8iOXvXOcVj7SM/gbg0My85H7/CKDbtY8JoxFhCmURN3Iwmiu2nfV
	rZD31bO4dKD6t8DQ==
To: Doug Anderson <dianders@chromium.org>, Bitao Hu <yaoma@linux.alibaba.com>
Cc: liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
 jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv11 2/4] genirq: Provide a snapshot mechanism for
 interrupt statistics
In-Reply-To: <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
References: <20240228072216.95130-1-yaoma@linux.alibaba.com>
 <20240228072216.95130-3-yaoma@linux.alibaba.com>
 <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
Date: Fri, 01 Mar 2024 20:22:54 +0100
Message-ID: <87plwdwycx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Doug!

On Wed, Feb 28 2024 at 14:44, Doug Anderson wrote:
> I won't insist on it, but I continue to worry about memory
> implications with large numbers of CPUs. With a 4-byte int, 8192 max
> CPUs, and 100 IRQs the extra "ref" value takes up over 3MB of memory
> (8192 * 4 bytes * 100).
>
> Technically, you could add a new symbol like "config
> NEED_IRQ_SNAPSHOTS". This wouldn't be a symbol selectable by the end
> user but would automatically be selected by "config
> SOFTLOCKUP_DETECTOR_INTR_STORM". If the config wasn't defined then the
> struct wouldn't contain "ref" and the snapshot routines would just be
> static inline stubs.
>
> Maybe Thomas has an opinion about whether this is something to worry
> about. Worst case it wouldn't be hard to do in a follow-up patch.

I'd say it makes sense to give people a choice to save memory especially
when the softlock detector code is not enabled.

It's rather straight forward to do.

Thanks,

        tglx
---
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -24,7 +24,9 @@ struct pt_regs;
  */
 struct irqstat {
 	unsigned int	cnt;
+#ifdef CONFIG_GENIRQ_STAT_SNAPSHOT
 	unsigned int	ref;
+#endif
 };
 
 /**
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -978,6 +978,7 @@ static unsigned int kstat_irqs(unsigned
 	return sum;
 }
 
+#ifdef CONFIG_GENIRQ_STAT_SNAPSHOT
 void kstat_snapshot_irqs(void)
 {
 	struct irq_desc *desc;
@@ -998,6 +999,7 @@ unsigned int kstat_get_irq_since_snapsho
 		return 0;
 	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irqs->ref);
 }
+#endif
 
 /**
  * kstat_irqs_usr - Get the statistics for an interrupt from thread context
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
 config GENERIC_IRQ_RESERVATION_MODE
 	bool
 
+# Snapshot for interrupt statistics
+config GENERIC_IRQ_STAT_SNAPSHOT
+	bool
+
 # Support forced irq threading
 config IRQ_FORCED_THREADING
        bool

