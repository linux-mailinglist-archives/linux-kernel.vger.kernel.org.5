Return-Path: <linux-kernel+bounces-136930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C689DA06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C201F22E10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B312F583;
	Tue,  9 Apr 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bRNsxKJO"
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6C12F585
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668908; cv=none; b=uiC7yXh56AuuVXhov8pKYyhYfNgO9I6Sz+0klrAotiXBqq/Oa1PjYVoAc8ToS8L43nvR3W9MM/N6LugWf7U7mb24nZVtrKOgtN/jq2DOs7O4J0HiTUJy0n6AxMSA7KLjgZ+JwjPKKTpyV96kEb/Cxelk8/LPPEnfI4gqSMGBNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668908; c=relaxed/simple;
	bh=BIXtQbP9MP9nqx4vsOYb5xY/BLcCRo0aS7pkb/Oy9M4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nUt0QxcBvvyyOhdC+/uxKcBaRoCR4QalFmyB4EC5NnQj3C5AZB4VFqeyDH5afgM3OtsCzjuii4hNSiH49oJA9sQTkmiSExadZLYXiooopgdLFUfiXp40IwbHw9hO0zAtfZuLsd7IUIoPA5ekYmZ1Kb96RNCkjW5RbdJ8RlRaBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bRNsxKJO; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712668895; bh=YUtGez/XnDNg5xUU7tPR+7JYoTfIuuLZrutUQBX7E4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bRNsxKJOljO5gDXhx6JeJ7EgfIrKkNy1wlrEml8OwkdMFWtKpUXIyHPf5Xt56FLdu
	 Yh4CdBaXsOEmotMF9CW5zrSWv8agAviPGaa7gi8R8/Qza3a6u3R2HSizC51hGOEwpv
	 hVVa71o44xjd1eH5nofJx0bOjWh8EuWIZ/xJgr4k=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 356A180B; Tue, 09 Apr 2024 21:13:22 +0800
X-QQ-mid: xmsmtpt1712668402t5chgs1d7
Message-ID: <tencent_66764A0C74FD776567343C4D36D6971A3609@qq.com>
X-QQ-XMAILINFO: OXHA96V41vMDBwhYwn7+OjcGgzli3xXJ2XDxO3wfyTlv9jhUGCma8gVWdIuDuN
	 q8gbpT2OeHrZgo4KnPTxPoOXTrr+jLmUXj0dn/aqJHpzPeqeMTjHBAuN0Ppaas2adCVyxYG8CzzP
	 aShYl/WjyuH6yN1aND/6KraaC/HtUP6aeTos6AFQLq8581MSBKOMLifVxFwoo0dY5wb9+3wNgRZR
	 mWMTEqAHfhLji65ddxmzut9n3WMYXg6xtwqo2EhKBTJirEEM7gWwnufhWF+rqn1El5waws8qzkD3
	 v2iK2Uqx+7gDtlujVJsnZxgHj9CR2QIGXagyWTqYrQOab6SikTD0YFAqmRqGZIbggb8tdEA3XVYt
	 sEM38BH5O0DeCrmU2e/XAZi3TXVDp1DSopwHTFDH6453LvFAPr1yxp1+Hb8iVNflHkldj1TIGKWk
	 JBE/tFj+itxDdiMcNZdGAJyfW24sif6QqDgu9hhhUcULarS641sNTtVkNHaLrhS4P0QqG7JM+Dl0
	 1A7110ENLuwaAXUlw3v5kKQlOqyWSrLHVMxgNQBv37PiItIccuQOi3WlnpJgJG4sHge6V53Dv14Q
	 oRMWgwZzeBHOs4T90fZkUumAEvwqvXDhJGmtQ3vylWnYIc5q3q6/TS7DIQ+U1ouG0UjLLk2Yda+D
	 Ep1HJMpcBzjIrC11nLztBM1QPf3Ulj0x9Nymjk3UxP9iAkaDKQVYe1fpCSafoCQE62+oUJ1LkAyw
	 gqCMrpHc3xP3aPnFaYcOept/8i+vSNNpkbhG4z2eLam1B74/1EVRkRG/B29iKOfo2sTw/K/7iGTV
	 4+iHzcS8Cw7OTRiUIbJQ83l54qY+i+UsnOW4zCetBiHCXeP+tq3wY4zkFHrScqMpgM1jNG6HkcSd
	 rNT7gzJQcJDXWp0Zg4Ozbfls9tpNK2l2UVodLKdc2dDNZzLZXUQRU3edWQE2YB91oofgXma5d7oJ
	 fGCC6//qsNs39ZvJXBNUPWLsza0clge7u8p3J1b85BJQ5wD5bN5astSCfIYgB5RJR39hNQaEgYF2
	 i2EQItu4zNgv6BoCSO
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in strnchr
Date: Tue,  9 Apr 2024 21:13:23 +0800
X-OQ-MSGID: <20240409131322.4166944-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000009e2ff406130de279@google.com>
References: <0000000000009e2ff406130de279@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uini in strnchr

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 04b8076df253

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 449b9a5d3fe3..54abc67c48c7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -826,7 +826,8 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	u64 cur_arg;
 	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
 
-	fmt_end = strnchr(fmt, fmt_size, 0);
+	kmsan_unpoison_memory(fmt, fmt_size);
+	fmt_end = strnchrnul(fmt, fmt_size, 0);
 	if (!fmt_end)
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
-- 
2.43.0


