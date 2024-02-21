Return-Path: <linux-kernel+bounces-74772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94485D992
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804FAB24D95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686697BB16;
	Wed, 21 Feb 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hCCoOpru"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0878B4A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521583; cv=none; b=a8LbYerbN0lq/biHV9uxI4c3Xn6xSnwrb3JlZCsnzz2Vjgn14B0j+UrPTT+RcIyk/IzwBpPw87ID4brnSAXfXbK2Lnz5Sa5tz7K0xudEfSXWDYq1mq96zTkzIhHszyfSKhN1bfPapMYCoLr2pG6SAMI1GqkkT6No77/YPzXkaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521583; c=relaxed/simple;
	bh=W/huyLMmbLXw0FAoupaeOC7xeeaDBp3wybruyuacf4g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Egynpk7ITGU1FdAXCMOzN7DbwZPX3F+qHZn1xYjWhBsu1Nb1nZrqkR0Imz8EW3ogTbh2hlOUoSsPWbH3Z7LtMRqxb9AmwBQo7Q8fCaqRofhBoIdZKYqS2x5EgHNZdWDW0sr1WpPpqDQUGPmgFZPZNDNCQ5ZrXCF/0uq/KPXMghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hCCoOpru; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708521571; bh=cJHuEnGILzAEASfvXycP4RV2Gte53Sks0wcTbJ2gR6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hCCoOpruZt++3WjpNvhqBNt2MfQOtW1kttIkBB38IjouUV7p66rvIjwIFt1h1/CmE
	 cbjT2J4BzT0Qi5slITrFMwPsZa0F/XOlmbgyonq7j+VvXlKFGZmiTNRZs5xEQxzKyZ
	 Ic8IXiql8IaraEfgDnM0Kt4R8AzGbJ810gvHVx48=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 3530F6D0; Wed, 21 Feb 2024 21:13:19 +0800
X-QQ-mid: xmsmtpt1708521199to2aoiwu5
Message-ID: <tencent_AF13764368E97383BA244FD768576566C205@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zF/zgUJiJLT3KahiZTQQc0RIcZLWfwl+jB271q+gNvYSlkhstBp
	 qfp+6+fDucSQq9nQcIjmAX8El4fM2HB71mN5I+RxuiFTaOAGiQnyeZdXGbxo1HWzeibdrp2qkrkR
	 H8qeV/c4ACmUJCKPqFl0H7VeH776Wb0sIHzRyhLDhc7HS64x2j6mgpgfDpuagMwlp/Hhdm1Bb+X9
	 0MM1APuYurUijUjvv831a8Auyl2D615yvQ7H/wGIBezloJHY+mMQnxlhZ6cIKKXWhIXTPo4UPXnT
	 g/qPuIK38owgu4nt+lh2BOe7uVVRUY8cqTJa1KG5jmX03fkxbcmUBobmkLsfZZj/w8myHjJbf7ys
	 FryM9w6+OX3DIvSNxgAlYIvByxoaMRX1Nhi7tRP6b0P3uHKYb9kqg/AdCcaEYOUicMs6HnPe11ir
	 18BNjKgSTL/XxEz9rjz1iPSFkEPPB723p6Mzpnz/MqcIhBF4sdHCnSUf3HJ6+v3Aobf1Wd9EGjd9
	 VaiPkVTeySla59XlN1tjej7ObATb+Lj4542VngkeHlZH6OtAqxwhYf1zem4kXp1QVcjv9nTQ4v2Z
	 O+WcDoHH4vGeukxCMlix5u9wziLL6Xp3WzLTayLUsFa/NogL1e//w6E6bcvIksJZqGbjbjv/NI83
	 biSHNra6n9wPc6ZK3DLJ2LxwnOmf4tBczds7Ve66TSWRkrbxKxek27ebZ1BiXTQGslPzLVBiB3LM
	 Wg+mYt6vOR0OaoSF3IaaljJL3XQovbSGp44RanyqjS+7D4qoeQfAOvMaAQCJ5DTz3Bp1TCAfQ55u
	 vipzaKNNIPOThZhIkLAoGAu8WaoYPiXgdbb209UQRSv3V7UTIB6sK1iv8h5zaOjH8DDSr3ondlCk
	 qj0AF7z0qr7UKQG1Vk0Wwc+oavrFIJuT1OyePV5FPfj95xeMfGJvw=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
Date: Wed, 21 Feb 2024 21:13:19 +0800
X-OQ-MSGID: <20240221131318.60729-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006d96200611de3986@google.com>
References: <0000000000006d96200611de3986@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test hung in cec_claim_log_addrs

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 5741adf09a2e..21b3ff504524 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1436,7 +1436,6 @@ static int cec_config_thread_func(void *arg)
 	int err;
 	int i, j;
 
-	mutex_lock(&adap->lock);
 	dprintk(1, "physical address: %x.%x.%x.%x, claim %d logical addresses\n",
 		cec_phys_addr_exp(adap->phys_addr), las->num_log_addrs);
 	las->log_addr_mask = 0;
@@ -1565,7 +1564,6 @@ static int cec_config_thread_func(void *arg)
 	}
 	adap->kthread_config = NULL;
 	complete(&adap->config_completion);
-	mutex_unlock(&adap->lock);
 	call_void_op(adap, configured);
 	return 0;
 
@@ -1577,7 +1575,6 @@ static int cec_config_thread_func(void *arg)
 	adap->must_reconfigure = false;
 	adap->kthread_config = NULL;
 	complete(&adap->config_completion);
-	mutex_unlock(&adap->lock);
 	return 0;
 }
 
@@ -1602,9 +1599,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 		adap->kthread_config = NULL;
 		adap->is_configuring = false;
 	} else if (block) {
-		mutex_unlock(&adap->lock);
 		wait_for_completion(&adap->config_completion);
-		mutex_lock(&adap->lock);
 	}
 }
 


