Return-Path: <linux-kernel+bounces-142983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8948A32E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E9F283A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71595148825;
	Fri, 12 Apr 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=elkcl.ru header.i=@elkcl.ru header.b="uxD6ELAT"
Received: from smtp43.i.mail.ru (smtp43.i.mail.ru [95.163.41.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C51487F4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937305; cv=none; b=WRqF66DmVfaVXGP3/SHFDDbpXoiTLFA0yf2bsN5Jxtp+t8+WFQMJsHNwFB04QIKqkmAFBvHdIeh0jwFKxhNE1E8vQ+WrrYhCOXQqLlFSNdpfKLjEfReIfFQaTP0pZLBHHXA0L2V43rh/NzZvZhYf3Hz2Pi6xTyoHciGGle7ny+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937305; c=relaxed/simple;
	bh=9oTCvBGu9JzO7ONavS1zFKdYX8JxPtnMFI92mjnC84g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hPvgKdr2rs//OWXd65S6TPciD4ZiyW5kVMCAZoykqFYrwUI4K02WvpjZGfy9RFSzNbJNRFCIv+guifSkFdjkFuADaDmgaPHzA21jtzNCdH8s6Huhk9H6vQKe3/s6j70s+WGyGAG7U5uQr/LpeFEG/lE5FH44zDz7SfoLl3cZqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elkcl.ru; spf=pass smtp.mailfrom=elkcl.ru; dkim=pass (1024-bit key) header.d=elkcl.ru header.i=@elkcl.ru header.b=uxD6ELAT; arc=none smtp.client-ip=95.163.41.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elkcl.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elkcl.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=elkcl.ru;
	s=mailru; h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=QFS0D/M7dvwApK3A76KiviBzof0kZdBxTZ34NthdSy8=; t=1712937301; x=1713027301; 
	b=uxD6ELAT5CotYeU6q8qm/8Tqu6CQxWl3MQJqPwtdBnDh2k4fCxlrZSyd4lvKBzBBTmiQCVm2v7D
	u+yAFfl5AR9tr8r799Bc6oIl9oWYyMh1m5XqmvoKEZPgfcrOGPfNyhbnejSJM7w8JDM2T7IgbPuc7
	4eiB9h3k6R5bdb0hWBM=;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <pub@elkcl.ru>)
	id 1rvJEp-0000000BIcj-2x1T; Fri, 12 Apr 2024 18:54:52 +0300
From: Ilya Denisyev <dev@elkcl.ru>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ilya Denisyev <dev@elkcl.ru>,
	Richard Weinberger <richard@nod.at>,
	Christian Brauner <brauner@kernel.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Fabian Frederick <fabf@skynet.be>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	KaiGai Kohei <kaigai@ak.jp.nec.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] jffs2: prevent xattr node from overflowing the eraseblock
Date: Fri, 12 Apr 2024 18:53:54 +0300
Message-ID: <20240412155357.237803-1-dev@elkcl.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: pub@elkcl.ru
Authentication-Results: smtp43.i.mail.ru; auth=pass smtp.auth=pub@elkcl.ru smtp.mailfrom=pub@elkcl.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D3B5F9CEDACDA8A37625F0445A84289E9B182A05F538085040843BD67FAA79768F33594132A326AF8BCEAE490106F7B863C222E478C8B5E4506837A08AC964547F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78CB87876C5D626D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371D26D2A8652661258638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8147B5DEEC622027DEEA818C3B420E6A81562A0DB420D21BECC7F00164DA146DAFE8445B8C89999728AA50765F7900637BA2F0AEB80054583389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8AD74539164518AE5F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C17119E5299B287EEAD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C356E3D212986C9D9EBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3F6A27782D052760535872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A54E068876C7DE3C8E5002B1117B3ED696538D2A3C96BE7402484B8D70797403F6823CB91A9FED034534781492E4B8EEADDFC043C56F70D752C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF1D5D3BAAD1272071CBB8234144E1EBE2896135156D9F16CB998C73ECA2F75A71963129249CAA680A1E5F415AA55898CCA736FDAA89DE208D695903BF9C1DC331129538D5484F1A9442BF32D1DA1046D202C26D483E81D6BE8B4B3506CD0458C56E5349047F11E5783FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojj8Sl06kWf03Ngj57zzxREA==
X-Mailru-Sender: 7971DA0162A9842A75A8A63AE98D4FF4703F3DE0473E7D67D4570605F44DF537BF768613B42F11ECD8649DE294F77099CA0B8C118E355A7C54A42CAEBACFBF7EF55A8A299F926F354FD7C49A7833DCB4162D03413E14ADD05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add a check to make sure that the requested xattr node size is no larger
than the eraseblock minus the cleanmarker.

Unlike the usual inode nodes, the xattr nodes aren't split into parts
and spread across multiple eraseblocks, which means that a xattr node
must not occupy more than one eraseblock. If the requested xattr value is
too large, the xattr node can spill onto the next eraseblock, overwriting
the nodes and causing errors such as:

jffs2: argh. node added in wrong place at 0x0000b050(2)
jffs2: nextblock 0x0000a000, expected at 0000b00c
jffs2: error: (823) do_verify_xattr_datum: node CRC failed at 0x01e050, 
read=0xfc892c93, calc=0x000000
jffs2: notice: (823) jffs2_get_inode_nodes: Node header CRC failed 
at 0x01e00c. {848f,2fc4,0fef511f,59a3d171}
jffs2: Node at 0x0000000c with length 0x00001044 would run over the 
end of the erase block
jffs2: Perhaps the file system was created with the wrong erase size?
jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
at 0x00000010: 0x1044 instead

This breaks the filesystem and can lead to KASAN crashes such as:

BUG: KASAN: slab-out-of-bounds in jffs2_sum_add_kvec+0x125e/0x15d0
Read of size 4 at addr ffff88802c31e914 by task repro/830
CPU: 0 PID: 830 Comm: repro Not tainted 6.9.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS Arch Linux 1.16.3-1-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xc4/0x620
 ? __virt_addr_valid+0x308/0x5b0
 kasan_report+0xc1/0xf0
 ? jffs2_sum_add_kvec+0x125e/0x15d0
 ? jffs2_sum_add_kvec+0x125e/0x15d0
 jffs2_sum_add_kvec+0x125e/0x15d0
 jffs2_flash_direct_writev+0xa8/0xd0
 jffs2_flash_writev+0x9c9/0xef0
 ? __x64_sys_setxattr+0xc4/0x160
 ? do_syscall_64+0x69/0x140
 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
 [...]

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: aa98d7cf59b5 ("[JFFS2][XATTR] XATTR support on JFFS2 (version. 5)")
Signed-off-by: Ilya Denisyev <dev@elkcl.ru>
---
 fs/jffs2/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 00224f3a8d6e..9509b33f7675 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -1110,6 +1110,9 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		return rc;
 
 	request = PAD(sizeof(struct jffs2_raw_xattr) + strlen(xname) + 1 + size);
+	if (request > c->sector_size - c->cleanmarker_size)
+		return -ERANGE;
+
 	rc = jffs2_reserve_space(c, request, &length,
 				 ALLOC_NORMAL, JFFS2_SUMMARY_XATTR_SIZE);
 	if (rc) {
-- 
2.44.0


