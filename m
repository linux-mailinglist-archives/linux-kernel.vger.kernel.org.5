Return-Path: <linux-kernel+bounces-151995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14258AB721
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D291C20FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C10F13D287;
	Fri, 19 Apr 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WuqYFSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8t9/3N3O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E972BAE0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564928; cv=none; b=f1utjkSPHKXWspurHQWo/WDyqGl3IgDraPH1pSjBmgtb6WN1K3caMn/fB32+/yDUIzH+mm+13i8MVh0l/yIpiYh2HEaPhE9GVnNgAJZ+ELhxkKXkKksagxHR+Q0vu0rDkjLREFMZZawooR2LQfaVmqUP/SdM6SeQslMYrUFH2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564928; c=relaxed/simple;
	bh=ZXE6WJYs4EPCJ09joQHJIQH39glJHJwk77dckbq+RZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RcMa+QjUzrHxxEvzqaQqq7zVLbM9EOvuH1nYQpzsJGnP4nZ8FG3UrWPaQEYjhgHrbdKEYvGVgQSfs3KaX87GKbwdD/NrdPBMP3QZ8iFA948VEp8qqJQqWtW7dCSsXLakcN9vNG6PlFkorKQYcV20Vuwx2BYDdri8WnRbY6QBHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WuqYFSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8t9/3N3O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713564924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4W2D/JQ7v4em6hSEyb605p2cZa0myVJbUGYZmZujGY=;
	b=3WuqYFSnCeoDU81iMBGWr8jLraCz0LXKETrG6z7weEKWrMsVu937p4ijfI+qIykffdMkk1
	ZWJqyJFen88h+BzWgf6yauSAIuxPtsXufdkIFeymnBI/YklnHRcnLsTWzAs3lhdtUwmiQT
	ez4omFxamvD7xL8Akg/Jx/JP8ywQFH2lM/xVLfBMXiMXmqR3DE/gGrwtiNcXkDMQK1dkl/
	R/lV07AGDH6VZjvRT0lqPqgAKRF3WZm3JMedn9bjuvS8Kz2DV18cftelhX0DqUFvwXBzS+
	ne0EwmcoVnGX3tD59bgg3yD9Nu6pZ/eMQa06zt+OlVXccOq1pRoM8V1fcxmMBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713564924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4W2D/JQ7v4em6hSEyb605p2cZa0myVJbUGYZmZujGY=;
	b=8t9/3N3OIrwWPcAEr+hqCEpjL+5xRdtNzmwuHqkwx4N07yL2Vibj/N8gCAB+eiWPkJ4+KX
	jo/7mxS3yZBsmLCQ==
To: Lyude Paul <lyude@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
Date: Sat, 20 Apr 2024 00:15:21 +0200
Message-ID: <87le59vw1y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul!

On Fri, Apr 19 2024 at 13:38, Lyude Paul wrote:
> Awesome - can confirm the patch does indeed make the machine boot. Full
> dmesg from boot attached.

Thanks for providing the data.

[    0.089286] CPU topo: APIC ID 0 present 1
[    0.089294] CPU topo: APIC ID 0 present 0
[    0.089296] CPU topo: Hot-pluggable APIC ID 0 in present package.

ACPI is really a wonderland.

Can you please test the patch below?

Thanks,

        tglx
---
Subject: x86/topology: Deal with more broken ACPI tables
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 18 Apr 2024 21:02:39 +0200

Paul reported a regression which waas caused by the handling of non-present
CPUs in a present package. It's caused by the ACPI table on the system
which advertises APICs twice, present and non-present:

  CPU topo: APIC ID 0 present 1
  CPU topo: APIC ID 0 present 0
  CPU topo: Hot-pluggable APIC ID 0 in present package.                                                                                                                                                                         
Which causes the topology to get confused to the point that it fails to
bring the system up because the target APIC for the IOAPIC is not
available.

Prevent this by checking whether a non-present CPU has been already
registered as present before. If so emit a firmware warning and ignore the
registration request.

Fixes: f0551af0213 ("x86/topology: Ignore non-present APIC IDs in a present package")
Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -195,6 +195,12 @@ static __init void topo_register_apic(u3
 	} else {
 		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
 
+		if (test_bit(apic_id, phys_cpu_present_map)) {
+			pr_warn_once(FW_BUG "Already present APIC ID %x registered again as non-present\n",
+				     apic_id);
+			return;
+		}
+
 		/*
 		 * Check for present APICs in the same package when running
 		 * on bare metal. Allow the bogosity in a guest.

