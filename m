Return-Path: <linux-kernel+bounces-46218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47862843C61
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD221C29B91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D1269DFD;
	Wed, 31 Jan 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OM3Mmp4q"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148980C06
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696455; cv=none; b=LkJzla1cWdFMqK0RYr4p92R9UIQ7OEnPwweB7CbI21Cd82X9vSgr6FHxgMszdtef9LUoa82W5rxQw7HR0lVZe7WQO2FtkSZ3HIJwk1ScNThc2TNbSvg2Zqo+cH6I4R0aCZU5uqtThlF8/E7404C+o5kUEZj6sYSTLW8OP8E31Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696455; c=relaxed/simple;
	bh=dcDG1086DpTi4ooba1zaKixLkEQvdDondlu1tu/Lsks=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=k8uan/VA6jZUuJ2LlbOI2g8BYx/t7h01NRKd2E4oVFQE6icF24WNTBTdigR0dts9Cms4Kwo5pmz5pcJWw+kFNeo5B/DwAYcSyc2kf0V4ou65FL68TW+qN9Er3hnLFMwTjMqxnlQEdz+SVgTlj4SgnDBJyNTHOaODPaODHeuGcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OM3Mmp4q; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706696146; bh=X0X8hqsNAwweBfd2Kcw3OnbFJfIAgX8kvyTzKulQO2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OM3Mmp4q+ajKEjA1w1b8aRfjsjuFdNkRowuLxqOMX7Dtcz6+KOqw5jqFjKdV/5lTe
	 cg0X9qnAyjGCUv2MzsUPj+JwH8ZBBAdlV/wbEJw2zv5R23jgACUIeQMsJsnzUpOuC4
	 MNknQGhmczW+Tnh9hGMZXl3ZK4Gg+UnGdcA27DmA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 39C3D00A; Wed, 31 Jan 2024 18:14:28 +0800
X-QQ-mid: xmsmtpt1706696068t8uk0czcx
Message-ID: <tencent_F29790365A4AF8744577D967B83C95361E09@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/dh8YUMWycYF6naj22IUnLzQSCPyswlVw2MsjAkyi7Z6RzaiD+E
	 23mpGewUZn+lu1DE0DMSzB+bTXZxY5+OJFEUi1VBVMJwhIHEFwExAqWEJ/c7EzhZbCM+8KnI8L7j
	 XUWjcfuERUMovYvP4htY1087U1zo2ysQKNzpVTMCUSBb+K2FAh7bQnRSpHQEir2tb8YlaCuPK7ax
	 zgptBs933hv+IfMGJ3lP//i5fOqopXci43JRTFQItaI+zF7rUAYZVRq/6M0KGTDlKdGg81cHST5J
	 d1O7unN0RzRil8BRVIRpiq3fU+ptY869oU0LyCFW8rgqaGp9ZVrTZkYKxT2GuKM5JiKjXBt7UX6R
	 WqQhiGZywYpdnEN/aEUEDYm2m/8/AGA870dDEdDKmtCEw1SIgWOJNmzweHWhJuKMFJjKqRZj1PN/
	 R7nwaIwQVS+nVBPOLY5UXGF5DWkKa8PPTzh3nSBjl/Lz6pEk5vTfjbBBR1Qo/A+Zn+CovbVLxKs7
	 RvP64iPs6bqr3aw7qs7hemMr2kFueXBNl4vPK2Y0XdO1V6CTmRXrOpG9rri81KyCtb8c+tmMk7I6
	 RfnqbjQGLtZzrtbJKE0KDKr2zrsC3Tjy63Iuh7766BxV4VhSG56VhgwyEeHWyjIh0fIH4C+FzICU
	 F4S7ASdE2/TLiObGKQB+rHFMs7HMYNugl9sMTVd1qQi5PHMssjHg0HG07SxESflREzH8AmvJ3en4
	 kyIxnU0X4OLN+bNNw1OF0onAmmR7vXcer2xYeM0fj2mnBVvKU6VNRaZge6Uzm4OEOUwoW5gPTSt+
	 aLFOuPaHW4AuplXiY7tDzD7uSEckUS2jfuh08Y3/lpiJP90Zo7RiZL2dytnVpNQs9grrEqy09YCn
	 Z+KJcGkA0lsSkyQZuit9vgjImQBMOGRwB6Nhr74O3SgA1mHE75MRmWQ0M1mi8ir0RJ3GjSY9zmXb
	 KEbYyh/TEN1Du+jA11ICNWwQncEbDL/RrBwWosUulT7k8C7011tnQqvG8lLRF+
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Wed, 31 Jan 2024 18:14:29 +0800
X-OQ-MSGID: <20240131101428.1112235-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
References: <0000000000002b1fc7060fca3adf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in blk_trace_remove

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..eede951d198a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -381,8 +381,10 @@ static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
 	synchronize_rcu();
+	mutex_unlock(&q->debugfs_mutex);
 	blk_trace_free(q, bt);
 	put_probe_ref();
+	mutex_lock(&q->debugfs_mutex);
 }
 
 static int __blk_trace_remove(struct request_queue *q)


