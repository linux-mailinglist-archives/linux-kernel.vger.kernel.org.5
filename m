Return-Path: <linux-kernel+bounces-89714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCC886F49B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82D0B2184D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E7BE48;
	Sun,  3 Mar 2024 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LPXw1Zqp"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE78B65C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709465980; cv=none; b=FTyNhwkdwblVfwhnNjcbphoASOQ+H2TgDOstpyaxB35P+NmoblfrPzU/iUpaz+1KzdAzHv9Oy0IqYwmt8qpvFDNTXg+fr8IjwL1mhKJlbI4DI6VdV9/4raszkwNO195/4+SI9qumc0j8XeIdMXs+WjbOPd7FlcvPYSzYJUCIBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709465980; c=relaxed/simple;
	bh=aRDLVKNyg5c5RAjyxoCgQAAytKgRgc2F056u1r0l9UQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GhUEtpMXsN54AU3s5lKHkMKwsO8pSSGJbppD0iydy4BPxCP6IrG3glWC7p8q4aLhI/3Zk62+vZ88+TAxy5vCa7+y7DVkXvOL2P1lBGZ/SPoKBKlTlQt4OWzCMruCzP1SnYIlAyz43nTTdcXjSB6eQ3yYmW0wD+rzgsEXSPMGW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LPXw1Zqp; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709465975; bh=fwU4jR1rbxcPJHGYHFkxDICLV6ZUujEKBvunqF0040I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPXw1ZqpmVVwS9tw9UIaoBpJvEOq9YoNCtupOPNAq4fStefuGZBvlB8PZBPZQNGGK
	 l62A6gg8iBfpg0Ix5ysgjxgOlFIWitC8BPAvHy1BlUK4Jhd2ApEHWMjIpYg+Ewh8RU
	 LIpyF62CS2n2Li/iPNSKRuIIuqRaqhwJ26pCSvjM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 85D13685; Sun, 03 Mar 2024 19:33:29 +0800
X-QQ-mid: xmsmtpt1709465609t8fex932q
Message-ID: <tencent_C34B7C1B032559BA38BB7F334C9E061BFB08@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtGi58Rev+B4phsPk5WmHkfBy55+9rb+Chi0iSWSPvAcKGh1RsCb
	 NeQV5JHajH3zsmp8mPzgnQf8zhHtG+0+XjlXqQ17k4+QLxyxZlDwzLCcHi/ASGyEwC9oeUqEQhVg
	 OU6pxepaAQQldI/jadpt0r0GTLS6AYUOEHtZIaMz6yLW/YqwNajmi14rtMlw8tcOQbX4jmqeMfpv
	 17UQYl5/CYrrfe6IrUQMtnqzpAfkSs2j2xkYL3uAm8ypr+ylzynMw3clniq7rmsFyXpcmWQPgYto
	 64FsfOpUbCewgXrXPauHAmH+NQCjwD+vJTn2fU3clCIwAGOZtD4CLTZkiG1Nq/rpzDCO+B22ELwa
	 Sk3bon5cBIsHAO6UTtoB7Gy/qOzpmKDdObLUN4JehKgUhQmGXCErjezH7D0+GL7Ubpf8R18d5wSo
	 vcxYCmJn8MqcwoY0sVlj+JoUPQmMTSNnaxjGnT1pR7pFGi/PLJI9XEXocrJKwfXzcME7gYBjghbq
	 ISXU4r0yHqllCs+jOCkIa77hJ77EI3nqOkUrbPfZQT2IXgXG9+vcw2f/HydGdWMoDWjkYky/Lwcw
	 mgfoQtp5oQj+ozd8vIvDPBk0pV93OFzHMljpaErIflLJ+auDVxwwer2lovYxk947emsDoKZlUo8t
	 1Sb5TkZoCLaDJMNQPMHWv2fHt240+Bpfu9FzUmmLKV6aQ5wol2LOruXJ/j7eduAOxKmG7VEdVZYp
	 rYt3AVyMaKFsIFzSZxGTnDO1NgNX4zzA4LOVE8xFemsodSFFMM/Lih4fSsSGopB4PqspQjLPdPjn
	 DVJbj9YGALlDReDMPuJe3de+t8zJcTISpL74KcZa03UWH92dKjXeIJX8PY09G5L6hUODgW7LTaEq
	 egfHZI6XGz6Av/w8ZP5bzfR4TTVIHGCTS04XaJEETX9QwsGgKmzK9ggSAwIIoSnTtPJ8uwmjDij6
	 oEccQXVrks8l43v0u3rw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
Date: Sun,  3 Mar 2024 19:33:29 +0800
X-OQ-MSGID: <20240303113328.533166-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006945730612bc9173@google.com>
References: <0000000000006945730612bc9173@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in sys_io_cancel

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


diff --git a/fs/aio.c b/fs/aio.c
index 28223f511931..38c556514198 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1762,6 +1762,8 @@ static void aio_poll_complete_work(struct work_struct *work)
 	} /* else, POLLFREE has freed the waitqueue, so we must complete */
 	list_del_init(&iocb->ki_list);
 	iocb->ki_res.res = mangle_poll(mask);
+	if (refcount_read(&iocb->ki_refcnt) == 1)
+		iocb->ki_res.obj = -EINVAL;
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	iocb_put(iocb);


