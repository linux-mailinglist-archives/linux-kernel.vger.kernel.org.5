Return-Path: <linux-kernel+bounces-108847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F79E8810D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF2F1C21573
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D93BBE7;
	Wed, 20 Mar 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QOFFn/XR"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B211171D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933796; cv=none; b=sPog7PtDcDhs+lC+fR4n04ERdGVG5CLrC51Zs9wceUkPCB5eia3nvgvIEp4i5+XyT4MZMNh16ZBI/8kU3cR2xb8sIeZvp7I8VJmvFFlYMEaRmaFZ8qEEL+e3TwoSR+SRhP/w5cHGFC77jgSXvriFMjSLxHLJnRs8nyuqtfbV/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933796; c=relaxed/simple;
	bh=nusKVOAceUYCL9CnXyui/hszTDW4cvOOck0z5/kb4KA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tYGj9ZzIR8MnmfbEVQzM4OFM1KRxMO52M7mTxHro+fCAW/HGXpC9pFbnEXUHSZwWnHdU/1IXqxLgYMGEHDXIg/ifaYXn51AzpAkOTf8mNfMQQMWYLBolg75/flRnJaOHss41/gyBGpBks0Jxl2UgUmdg53xfBXw7syEiwyjY56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QOFFn/XR; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710933791; bh=V2AN3h8sZEyvNDd8KWZE3vxEDjCSIaOb4bVXmJqygsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOFFn/XR/iJ9G5TgGfeA54sx4L1NIcoyNDGiFF+ItZ3G3oLbDpMN9supWM9cOYw2d
	 gs5VlWv6o94aldjyMy66aUprcQ88ufLVY5rxSLbXabBKCYySTXs++GrcXmiXbxCyLI
	 KzRNeuXQa96Xsclyn29sqBK1MN76ZOzabnVeKglI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 43B23EAD; Wed, 20 Mar 2024 19:16:59 +0800
X-QQ-mid: xmsmtpt1710933419t68z7oox4
Message-ID: <tencent_7DD17367A377E97CA3B5A443F776776A8605@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6pb6ZN/T6VIT8DrPQBtsIeM42KX8VgYoP7huV0pssSV3w47+sDD
	 cz0lXOB1smSYy+d2D5iSubYYjIhnUaOTCow96wjqbUOmT45+bTVsI40M773wmDkPcas1EMKclcko
	 lBnkrXoXZrq8rLXzttIuXXemEWC4q4oT+s4ZwXnitrpf/CkT0idB/mFbWZpVX8v0CtvTq4OEJyYP
	 OjvrjqBdhV2lBl3ePb6bezWdKSE35GKSRg/XzXldEmw9r2kJMjE0mNXNk5Qa4tK7fr2z/YXZvZOB
	 O5BUufCYFUX21m/MuiTy9kjn6SSsOcNnjfv7R9LddoJTJglGlZ/6PZVac8oGneiL1zhe6SJV7HIh
	 N6Vykdiyvy0+QhqRn8lCqXxrUv0KwjYZcCyNZF1V0UqJYsfaUvHEpd9vg8oCjRQe/zomV4qFe5An
	 kFfWyHP7BCwcamy7QHBTXa+V7FteZS5W0ZYZjw/8K9RPJiOg556uroCNSqOPsPcipkT+qiAU1wev
	 7SDJ0q30i5eqQy6YCbZ6sqsvVLW796y1JpXVb6OlJQ6oymE0kw8FjAw5QHladLr7I3P+XAHHCpbn
	 5C0xzFw7+MyRuXy55HY0ZyCch1HvPJn7swp3a6QRKG8esk9bpYW2Tz0HoY5xEGlnbGa9n9UQqgJN
	 HEYtPg2BcXmZmtAS8qnW+lu+GqIrzry4o90+0UoJLCUL1tDPRLUZ9zX52kVNSSwUSQtgngnBL82o
	 taV68Y+uYBbR6MR4P9hwNsVV6BI2HN3EUUVCg9ywuv3+rDHcR+eTomIjCgYzvJJANWQqd0UgKCPW
	 aRJxFnMB+nQfdI3KEV+9/BX7f/DHuz5tt3uC4Q0R1AGvbALzcEoR3MOQp+SYEsY1dgISq1ZN6h1h
	 XKTWXJOCAk4bN5PBkFvWHXk+9VhTqe7xLqj6Qw6vVCBspvDs3evJt91/xoQiCvZ41x8Xn80wzNmL
	 mArJr6v7am1iODG/o03Q==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
Date: Wed, 20 Mar 2024 19:17:00 +0800
X-OQ-MSGID: <20240320111659.1320058-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003dc8e00614076ab6@google.com>
References: <0000000000003dc8e00614076ab6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in check_stack_range_initialized

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master


diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dd3b99d1bb9..6306925c5e47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7177,6 +7177,11 @@ static int check_stack_range_initialized(
 		return 0;
 	}
 
+	if (INT_MIN - access_size > max_off) {
+		verbose(env, "invalid access size\n");
+		return -EACCES;
+	}
+
 	for (i = min_off; i < max_off + access_size; i++) {
 		u8 *stype;
 
@@ -8589,6 +8594,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return 0;
 	}
 
+	printk("1meta:%p, maptr:%p, ks:%d, kv:%d,%s\n",
+		meta, meta->map_ptr, meta->map_ptr->key_size, meta->map_ptr->value_size, __func__);
 	if (type_is_pkt_pointer(type) &&
 	    !may_access_direct_pkt_data(env, meta, BPF_READ)) {
 		verbose(env, "helper access to the packet is not allowed\n");
@@ -8704,6 +8711,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
+		printk("meta:%p, maptr:%p, ks:%d, reg->map_ptr:%p, %s\n",
+			meta, meta->map_ptr, meta->map_ptr->key_size, reg->map_ptr, __func__);
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
 					      NULL);
@@ -8721,6 +8730,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
+		printk("meta:%p, maptr:%p, vs:%d, reg->map_ptr:%p, %s\n",
+			meta, meta->map_ptr, meta->map_ptr->value_size, reg->map_ptr, __func__);
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
@@ -10248,6 +10259,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	meta.func_id = func_id;
 	/* check args */
+	printk("meta:%p, maptr:%p, ks:%d, kv:%d,%s\n",
+		meta, meta->map_ptr, meta->map_ptr->key_size, meta->map_ptr->value_size, __func__);
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		err = check_func_arg(env, i, &meta, fn, insn_idx);
 		if (err)


