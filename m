Return-Path: <linux-kernel+bounces-150853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503918AA5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D18B283936
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F58762DA;
	Thu, 18 Apr 2024 23:09:49 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C9441D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481789; cv=none; b=XYaeZ9zKFvYV1onRRpT5Pr3G/n7KxPK2JOA2EYV9UCm/0VKPU6RgSS1Nx81UAeNV9PSoGiLGPVBvx4G1eAdDfn52dhuteybGNqVB5FgpTlMD833zjCuDbTuXTOsxdvTDkb18AV6jz4PdCeXMG7yyLeAHCCfRXrUizyh/wk4S1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481789; c=relaxed/simple;
	bh=0szyOJ3wK8AKNng7qNwG1MUCph2ty0A+9BP2yTx++yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPEp8C1HaMPmKEqpuAE65RlfS4dcnaMPPjn4FA/z5/g0WqiXF+VqDTIMcRgOEr81QlaS8xcxUSKFNWUg/+G4hY33cAtV27FqLsEcZy0syvGkH1QeBW+Z71hw/9+XSxtby7yA+E8nY3EJ9+WvEL1epq/fIF1H9QMHJNdjmCiHSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.253])
	by sina.com (10.75.12.45) with ESMTP
	id 6621A82D0000034F; Thu, 19 Apr 2024 07:09:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 33399531457774
X-SMAIL-UIID: 043E8D5472B849C4A4847E8B615618C1-20240419-070935-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+dddd99ae26c656485d89@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in __stack_map_get
Date: Fri, 19 Apr 2024 07:09:32 +0800
Message-Id: <20240418230932.2689-1-hdanton@sina.com>
In-Reply-To: <0000000000003f81750616646cb8@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Apr 2024 13:00:28 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f1f7cb180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  f99c5f563c17

--- x/kernel/bpf/queue_stack_maps.c
+++ y/kernel/bpf/queue_stack_maps.c
@@ -124,7 +124,7 @@ out:
 	return err;
 }
 
-
+static DEFINE_PER_CPU(int, map_depth);
 static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
@@ -132,12 +132,22 @@ static long __stack_map_get(struct bpf_m
 	int err = 0;
 	void *ptr;
 	u32 index;
+	int dumy;
+	int *depth = &dumy;
 
 	if (in_nmi()) {
 		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
 			return -EBUSY;
 	} else {
+		preempt_disable_notrace();
+		depth = this_cpu_ptr(&map_depth);
+		if (*depth) {
+			preempt_enable_notrace();
+			return -EDEADLK;
+		}
 		raw_spin_lock_irqsave(&qs->lock, flags);
+		*depth += 1;
+		preempt_enable_notrace();
 	}
 
 	if (queue_stack_map_is_empty(qs)) {
@@ -157,6 +167,7 @@ static long __stack_map_get(struct bpf_m
 		qs->head = index;
 
 out:
+	*depth -= 1;
 	raw_spin_unlock_irqrestore(&qs->lock, flags);
 	return err;
 }
--

