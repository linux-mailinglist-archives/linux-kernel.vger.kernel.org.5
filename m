Return-Path: <linux-kernel+bounces-93209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B2872C64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EA628A0EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7FD531;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864F2CA7;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690294; cv=none; b=L8klqRwH3YyfGb8cpjxgxm5bTcRSPwXrBGwZoqWp6aZAKXW/s59Kt1tqMEcez9L1zCPhcNCbDbv6Q/dCR/AncESnKiK+McZvZJCNJYtf41zvy+L/kvehE2deSV7tQ00XOtSXaq3Tngr/yiyS5OGmY38HmpP/DUXFpncyMxdBkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690294; c=relaxed/simple;
	bh=TmFcu6VUmLrYChoYqs/XPYIPbEXoIAXhHqI8nZm4bNM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bY23ghmbZLCvRxBzdHHUBQFCSBPel/bdNwHcNGV2+LCJtdr0ZlDtpumuLAjoSn3BkKmjQbEhljf++sRSITFFcfXNVezesmlKdEDeTPfVMxl1N3j2pmOvH8Aa9NxhAgpfjsYnR2Hcxjrc0XFQQRGaIvKFfjT6CV4JbnykYELN3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ED9C433F1;
	Wed,  6 Mar 2024 01:58:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhgZh-00000000TAP-2WRD;
	Tue, 05 Mar 2024 21:00:05 -0500
Message-ID: <20240306020005.461538701@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Mar 2024 20:59:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH 1/8] ring-buffer: Allow mapped field to be set without mapping
References: <20240306015910.766510873@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation for having the ring buffer mapped to a dedicated location,
which will have the same restrictions as user space memory mapped buffers,
allow it to use the "mapped" field of the ring_buffer_per_cpu structure
without having the user space meta page mapping.

When this starts using the mapped field, it will need to handle adding a
user space mapping (and removing it) from a ring buffer that is using a
dedicated memory range.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d7d7a701867..524b2c185c88 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5171,6 +5171,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 
+	if (!meta)
+		return;
+
 	meta->reader.read = cpu_buffer->reader_page->read;
 	meta->reader.id = cpu_buffer->reader_page->id;
 	meta->reader.lost_events = cpu_buffer->lost_events;
@@ -6159,7 +6162,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (!cpu_buffer->mapped) {
+	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
 		mutex_unlock(&cpu_buffer->mapping_lock);
 		return ERR_PTR(-ENODEV);
 	}
@@ -6217,7 +6220,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (cpu_buffer->mapped) {
+	if (cpu_buffer->meta_page) {
 		err = __rb_inc_dec_mapped(buffer, cpu_buffer, true);
 		mutex_unlock(&cpu_buffer->mapping_lock);
 		return err;
@@ -6247,7 +6250,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu)
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
 	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
-	cpu_buffer->mapped = 1;
+	cpu_buffer->mapped++;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 unlock:
-- 
2.43.0



