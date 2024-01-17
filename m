Return-Path: <linux-kernel+bounces-29525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57131830FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726D11C2130C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E524D1E892;
	Wed, 17 Jan 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oJJimgGU"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E501E87F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532402; cv=none; b=nm6tlKIWKax/pTiCioSs9RY42e63u3AClEQlEHkwDKvusMg27vYnruX6yxHaDw1FPnkS+Y2dAaYk71RvAly02gkiWRkpXK/IkYvofF3wReARrDkysoU82pkBfXH6LrthJ0VOjH/1FH3zmxDL8uHg2MdDaysZtX8taUYwBzn7Fpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532402; c=relaxed/simple;
	bh=FObMEG9ssP6EVkQwfmb1Z7fmrdBytj7a1ZYfLZDnpfI=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=Ya/eNnPDXkijUKIgj06y4jmFMVC2aHLesuqWsQ69RUPCCLHPGC9hMV0juhz1xVoaWNV1xLCUn/D9D3zJJx37RmZJxQ1HXcRyGK7w37rPIzIJi6/HcVGMu9l476BkLELtNvQnfKr+O6MtBy/DoWR2xuTDECFdXPvF77Kkw1Z3CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oJJimgGU; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705532391; bh=Tx5/LMsBTm44kzFQz5r7HA6ynuPsj+cBA3RvPfiZMlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oJJimgGU5cs8o2UgNK6wzm4bv7X0iRZquEf7gknYyiKrqmCMXZ8XTdZSrHkwxRcwu
	 WZfzeyEdOr0LILL7zLTFbKP8sB8LafAQOzkl6gi0xYbxLgeceVmdYhD5RFij0KAEFc
	 zjRH5noztBQY96Y78QrsThcHO/NCupQdKYTt4ywM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id D6EAFE7F; Thu, 18 Jan 2024 06:53:46 +0800
X-QQ-mid: xmsmtpt1705532026t0bff7cu6
Message-ID: <tencent_7ED368C373A96E43A20445F772B77FC6CF05@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yne3NoY8aU/S8yiD/jSml9ERdkv00aE8veahf1GW9yISaT/ZTZH+8
	 Xi96g17tFUSjZIDz+P8DgsJYpq9uWoyfcR4bfVzB06HHRf3aAi6/GC3P+SktXz/DAtc1PX1T7N0f
	 CbR4YJfT94MC2qHpXia6PnGDb9C6z40rnjmNRGBH7yrcXsWGdgZlrjFPaztzTRUrlPYzbYw1liur
	 48JHG/VCR+GpvUd0KkY4J0VMpuLAX/X0lk24e+nAiXndfoDWyEoZdb9EYBCWyl6+45eFoZgFzER4
	 tk/6wOFDmHOSWI9FUsDr6OuxsAmO0cy/TBseQILKrLKNf1Z1cK41m9E3GTT4XKqDeN43b1OzVX8A
	 GHgos3MKhDa2tdtq+BS0YiTnz3zYkA1D58wUg3LgiQxWJF2/0Qqklbw8q9kvL9UO8Su76KkGOvcM
	 pLdTYBH6msMFnDqWFxXuQd0VSDCPCQvFli+1GOWZ/Fc3WrhAZUMxwDVmQvP/sdQJ4Z59WHdLp7hQ
	 +R//CDZ/+g2wAurAA4nSJQSJoYkpTYQ1vC49uyNjY5FgnP2zi97DulNrw1+v/tGCnvWDSFO2mtky
	 Nk0hYdHQZWedMfK2eNtRjL4M+vOuRIi8od9GXUn65+RCs9ViWibTI2hhPrDDI3Cf0cECK8pt3O9P
	 3o7andfUSB51+xz2b+6ACqK29NT2EJQwrqK6z+GMbLQm9yBv/oHHPXK4l+JhO/b82wPlin536nns
	 f1rr1YoJwH6TkUJx1w9KffT7/d5NmEGA8oBpO4N54N2FAEbCeui+2wzPCXVLHQLgBER2jP5CXZ+x
	 LQELSn6i34+Mk/LmvAMDfyhZfVF3capcN9vYZM7oiFrcCY+Be5X1HQsfxocEeRrco8zG9OtUV/Cp
	 9odzmuVmSPNeKVCBHDV2Z5sF2zsc3qNULPqQ5wuB1xpd5vIt7SQG4U59bQKsH/yfNhUwDeeUVo
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in btintel_read_version
Date: Thu, 18 Jan 2024 06:53:47 +0800
X-OQ-MSGID: <20240117225346.2504179-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000cde441060f230f4f@google.com>
References: <000000000000cde441060f230f4f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in btintel_read_version

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cdc5c08824a0..e5b043d96207 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -435,7 +435,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);


