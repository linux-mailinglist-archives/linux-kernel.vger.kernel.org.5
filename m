Return-Path: <linux-kernel+bounces-129437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDB896AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5931F2A7E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74291350D0;
	Wed,  3 Apr 2024 09:36:19 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0E6F085;
	Wed,  3 Apr 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136979; cv=none; b=DqGmaQh6c1dQyGPLGLtuHyQ8gPX39VtrVwKm5rUXCHlJKgApmVMecWFManJSALz3GP9Upa8zh2UERT1NB25b+AoJuP4tlfJv/40HyWWt7Fg/nk/PNm/yJVAEfwc0djJOH+3+kRYTdiVUf58PM65DJJHbHoE8cYA7TU98YUIn9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136979; c=relaxed/simple;
	bh=72yeARj0IOdQyuSCgecazU8IKrp+Hx1+NQJZD1evZ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWarLOTZN+0DZaIhCoFQCeImFSCzE12HDVnEAbgesmCc8CGaz26kjJf0qSXKeNCkV0SsMnS42renH1Ih/3SR22wyzhaG3pnXlT2ugCM6XVVFWOw2yMPoVDqy+QVvg/W4XLQDBUOQktXE5+mQ7rc2qwxLCqeIhGN4w4BCC4vblKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rrx2H-00EXf9-F1; Wed, 03 Apr 2024 17:36:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Apr 2024 17:36:18 +0800
Date: Wed, 3 Apr 2024 17:36:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: syzbot <syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH] padata: Disable BH when taking works lock on MT path
Message-ID: <Zg0jEu5OsZaUFzn0@gondor.apana.org.au>
References: <0000000000001963d306150986f9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001963d306150986f9@google.com>

On Mon, Apr 01, 2024 at 07:08:28AM -0700, syzbot wrote:
> 
> syzbot found the following issue on:
> 
> HEAD commit:    18737353cca0 Merge tag 'edac_urgent_for_v6.9_rc2' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d605e5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
> dashboard link: https://syzkaller.appspot.com/bug?extid=0cb5bb0f4bf9e79db3b3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Strictly speaking this can't happen because for the time being
padata_do_multithreaded cannot run at the same time as the old
padata which occurs in BH context.

But the simplest fix is to just disable BH:

---8<---
As the old padata code can execute in softirq context, disable
softirqs for the new padata_do_mutithreaded code too as otherwise
lockdep will get antsy.

Reported-by: syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/kernel/padata.c b/kernel/padata.c
index e3f639ff1670..53f4bc912712 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -106,7 +106,7 @@ static int __init padata_work_alloc_mt(int nworks, void *data,
 {
 	int i;
 
-	spin_lock(&padata_works_lock);
+	spin_lock_bh(&padata_works_lock);
 	/* Start at 1 because the current task participates in the job. */
 	for (i = 1; i < nworks; ++i) {
 		struct padata_work *pw = padata_work_alloc();
@@ -116,7 +116,7 @@ static int __init padata_work_alloc_mt(int nworks, void *data,
 		padata_work_init(pw, padata_mt_helper, data, 0);
 		list_add(&pw->pw_list, head);
 	}
-	spin_unlock(&padata_works_lock);
+	spin_unlock_bh(&padata_works_lock);
 
 	return i;
 }
@@ -134,12 +134,12 @@ static void __init padata_works_free(struct list_head *works)
 	if (list_empty(works))
 		return;
 
-	spin_lock(&padata_works_lock);
+	spin_lock_bh(&padata_works_lock);
 	list_for_each_entry_safe(cur, next, works, pw_list) {
 		list_del(&cur->pw_list);
 		padata_work_free(cur);
 	}
-	spin_unlock(&padata_works_lock);
+	spin_unlock_bh(&padata_works_lock);
 }
 
 static void padata_parallel_worker(struct work_struct *parallel_work)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

