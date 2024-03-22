Return-Path: <linux-kernel+bounces-110815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E577886441
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDCCB2159B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C0B38B;
	Fri, 22 Mar 2024 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U8BQRKvZ"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3ED376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066280; cv=none; b=tIDxA+joJNmqXcfqXO2TSvTrl+7mZGBjf3EfOdh1fUsp+ooWFP9d5jZGBvjboDge94gT4JpELLv7KvO1ppWEyZK5KIh/tV1tggwHPOxdYPVbhE59i7kkI0ohbfvV0vOF+IuIii6KUQe+LMoOkB15grvH8vplNwurlZQ9/DsLXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066280; c=relaxed/simple;
	bh=DnlRg6NMAJyNYo7eW+xOpwpuPFHCZl1UT12dzhp3Ecs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uy7Fsr1m5EnLs+VVsjYE5X2R49putiB1FVInVxIRz9Dc8cDOlQ9+m4/7lsXNjYlBEowyd2BQ2jx73WiFiBHJsoAejHcR4y3QuZeLoyEQwsk/FuSSnZhz7FGrEZ8N/VLMK8F9aX5dLge8PpRKa7ZAvKVX7vD5SoRM/y/QrPzO/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U8BQRKvZ; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711066268; bh=1kLpxv5w2aqNm9nFSYOy9qoX2Mx+/atfdS6xkuD9YKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U8BQRKvZ4zekwFNGz8m4HL925VBPpZkzVNDYxgUsvTwqBnnjHBCLenEkwVHl29Pcv
	 IKRJIOkC7guxCczYYakhGbWGxJQHUqijGfEVR5oaxhV1lBhoo/8ZvTqfMTGvDznU7r
	 8sg46lXWOyyKt66dfl5pWF109qoz+UtFQywmtlAQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 2C61D054; Fri, 22 Mar 2024 08:11:06 +0800
X-QQ-mid: xmsmtpt1711066266tojlio1wa
Message-ID: <tencent_57A1EED82EC60C94E7EDC6DA12C306474906@qq.com>
X-QQ-XMAILINFO: MOpJcPT3Yy24tSkhymwTtnYGciWe4I5ewb+RKwfl+EJGgEJofpVrrTIo8XIqOs
	 0aUzDZW8PUAmFokA8j42UbKwpj1+TeClcYNBlFhwH58JQ2kmt9vIkPdYvCfi1aGGmvWj3CJeDk9C
	 jSku959e2Aj6xn0zYPIojbvThAGobpgVDv2HmVigBpy7NBgq6r9t+6gXBpqfUBgIdkySTz2djiXS
	 +TbjmrpWOiQiQ+HAirQdOEWUVA9Pk9kQSS12VeJKBKq/crc8xLZ/cyVOrnfrT+yVt6v8D8zFJz5V
	 r7dXnZ7GEHxdXMjTXk6aQH2aDyge8p/k232z4KN2AJdOQwQ5MtZlZsAbvAXbAX/rEc9t7ABY7d9c
	 UU7Def9IC4W+A4uNwaKnPdhomyFQnFsecmhedk3zCUYSCRalXVuT7KE3lgfqGbpCoPtvwdtaq396
	 6q4KIXXhl16FHX8IFGiXbm/vd72DBrsqRW8GwvJHW97IAryUxWxVtV0PDjED/b2QmWjo07EscYJa
	 tbEhmWJ7THpcb6n+Tt3enxZSpRk1DzK+Nh2k4uPRVrIHPlc0hmwazDmoKex0BsNWS7vEezNxr2aR
	 kqXV5zAg/if83qLbz7wV8yfSPfd7KPVJTx3HF1ymUGOVpcIIX+2UaNAIe9h3ySdtbyDhpbiUeabO
	 VMmKEK15yLWAGd42XOE0MOOOJ3kCeJcru7b8Au2FuDC9FXB6Q1u5VdvbndDvI4M/RULUYu+Cxmge
	 /4qV2VxS4OEVdjpP4K9zqFXDki0geXIbVb7WB3FItdPWaRgSYbcG9pkXdUhLQb8L+muMa1eZAknA
	 PwOuwnKlQIyw410OfhESSzuzdL03zcVOleWtWKW6JqxFjT14YzSHs2T46e9r1yeuV2Dw22PaRUsC
	 sAFjvy4cd5RLnR0qduGS0lTWpL/n7y5oBhDzzS0ld6pGwvjZ9ModyJS9iC7vcErA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
Date: Fri, 22 Mar 2024 08:11:05 +0800
X-OQ-MSGID: <20240322001105.2647321-2-eadavis@qq.com>
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
index 1dd3b99d1bb9..80b9ae2b90bb 100644
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
+	printk("meta:%p, maptr:%p, %s\n",
+		&meta, meta.map_ptr, __func__);
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		err = check_func_arg(env, i, &meta, fn, insn_idx);
 		if (err)


