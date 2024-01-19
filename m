Return-Path: <linux-kernel+bounces-31328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB656832C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032361C23956
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC854BE2;
	Fri, 19 Jan 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMqSVSvq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E35479F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679756; cv=none; b=uDQqcFX12sowfoETnfEHwR36adL+wEHxCrBs4ADqVK0CLeD96Z+cWFN8QDLNKoT80f7AZz2tL1j07zVnaFk3P0VANsSGqKfBmflvJutSHXYtcktguncBoylFx/G5GJQcd6auRfmRB0kcx3cKavzgfFXjEbX7TsUu2e6I6QxtlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679756; c=relaxed/simple;
	bh=TTwLpk+9WyqbjEGOZGuIU8l92E+nf3CARA/Oc1cdr5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q26qn6tYNQflL8q+s6SVOP1YJL66CIZxTAFC77SIMaR7xbyVr6xtR1N92AXsrIQ70ZyWGq0nxFVbw//VeQ9TjfpnYKKT6q2JVlAKKyjBJkrzNmZ1w+REqvVUGrYyerPaDHFbhQGwmPqAWLOCV/gIALL59XStvVQKs1OmEt2oUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMqSVSvq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705679754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tnzMEK1Gp8cYV4BR16ID72YGGPaqlCx174qqJsFmo8k=;
	b=SMqSVSvqTPYCoNPEya2yamhwJQYjGIB87uSEUJKieLgl+nCaTe1m06z3EQ1Tz4ga7xJ6Tc
	+0JW9nlvdB57XnG4a8HFcwFPQFMKxms6g/bML0Z3ZhZSbYQpOqNQde0ZhGlcnchTxDQ1/5
	n89L7dMiR8lk9VCbEwPLCp4OFD6xqO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-W3JnvKtKPrecbLyAftJkZw-1; Fri, 19 Jan 2024 10:55:49 -0500
X-MC-Unique: W3JnvKtKPrecbLyAftJkZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EB29867945;
	Fri, 19 Jan 2024 15:55:49 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 383B3492BE2;
	Fri, 19 Jan 2024 15:55:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id B7CB3401A1D88; Fri, 19 Jan 2024 12:54:39 -0300 (-03)
Date: Fri, 19 Jan 2024 12:54:39 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joe Mario <jmario@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mark power efficient workqueue as unbounded if nohz_full
 enabled
Message-ID: <ZaqbP0QmVPAQTbYA@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


A customer using nohz_full has experienced the following interruption:

oslat-1004510 [018] timer_cancel:         timer=0xffff90a7ca663cf8
oslat-1004510 [018] timer_expire_entry:   timer=0xffff90a7ca663cf8 function=delayed_work_timer_fn now=4709188240 baseclk=4709188240
oslat-1004510 [018] workqueue_queue_work: work struct=0xffff90a7ca663cd8 function=fb_flashcursor workqueue=events_power_efficient req_cpu=8192 cpu=18
oslat-1004510 [018] workqueue_activate_work: work struct 0xffff90a7ca663cd8
oslat-1004510 [018] sched_wakeup:         kworker/18:1:326 [120] CPU:018
oslat-1004510 [018] timer_expire_exit:    timer=0xffff90a7ca663cf8
oslat-1004510 [018] irq_work_entry:       vector=246
oslat-1004510 [018] irq_work_exit:        vector=246
oslat-1004510 [018] tick_stop:            success=0 dependency=SCHED
oslat-1004510 [018] hrtimer_start:        hrtimer=0xffff90a70009cb00 function=tick_sched_timer/0x0 ...
oslat-1004510 [018] softirq_exit:         vec=1 [action=TIMER]
oslat-1004510 [018] softirq_entry:        vec=7 [action=SCHED]
oslat-1004510 [018] softirq_exit:         vec=7 [action=SCHED]
oslat-1004510 [018] tick_stop:            success=0 dependency=SCHED
oslat-1004510 [018] sched_switch:         oslat:1004510 [120] R ==> kworker/18:1:326 [120]
kworker/18:1-326 [018] workqueue_execute_start: work struct 0xffff90a7ca663cd8: function fb_flashcursor
kworker/18:1-326 [018] workqueue_queue_work: work struct=0xffff9078f119eed0 function=drm_fb_helper_damage_work workqueue=events req_cpu=8192 cpu=18
kworker/18:1-326 [018] workqueue_activate_work: work struct 0xffff9078f119eed0
kworker/18:1-326 [018] timer_start:          timer=0xffff90a7ca663cf8 function=delayed_work_timer_fn ...

Set wq_power_efficient to true, in case nohz_full is enabled. 
This makes the power efficient workqueue be unbounded, which allows
workqueue items there to be moved to HK CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..45b3a63954a9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6630,6 +6630,13 @@ void __init workqueue_init_early(void)
 	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
 	BUG_ON(!wq_update_pod_attrs_buf);
 
+	/*
+	 * If nohz_full is enabled, set power efficient workqueue as unbound.
+	 * This allows workqueue items to be moved to HK CPUs.
+	 */
+	if (housekeeping_enabled(HK_TYPE_TICK))
+		wq_power_efficient = true;
+
 	/* initialize WQ_AFFN_SYSTEM pods */
 	pt->pod_cpus = kcalloc(1, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
 	pt->pod_node = kcalloc(1, sizeof(pt->pod_node[0]), GFP_KERNEL);


