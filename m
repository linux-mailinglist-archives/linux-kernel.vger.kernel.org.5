Return-Path: <linux-kernel+bounces-82003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C63867E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5CCB3393A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20511132491;
	Mon, 26 Feb 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVsVMq1Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F012C522
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966696; cv=none; b=JCCYjPjg8TVTsnanLbN/mTbju9CBCUg8m/I+8ikqCNEM2k+aZyak8LC3VODmvhfiG0/ea2N0D07ilQoDLBxMOKZEnNNLivIaW21tDkUxdYjl47phENRR1wKM4bi1AwwYFqiIZaB+USftyQvf0spFm8jYidQIAGH0mtyP4LqvJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966696; c=relaxed/simple;
	bh=rjMSd3WxYvgOWTwaE5VTCXZ7wiN0ODta7cZDebmA1QU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a+DzGcrw3UHMRKc0wk1+y7Vj5rw4Ig7kXBzBp8gbvFcfMWxZgkAyMxPKXYMxuuaTG2j6TcL7ZcCgjvOL/x8D9u2rAvyQeNxSEIM9UvuL+4KUufFR0QKahr1MGinFwWlLdUK6THv4TViZ7BmEFaUHR7ChxlqTVU8nZ7Gt+YRF9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVsVMq1Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708966693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=sSoBVhFfYf93x8huXQpUdUaaiwpj6qVsl4+myZwSTiY=;
	b=PVsVMq1Yi+IkP/b0qAKUs8D+J687Rmk2uzfmVwmBs1VqgY9g5kiFQWw18eBNr9r0Iw77bJ
	CIKERANdX5To2ww7MbMtClHGTaxFm2AwXW519E40qeFXFlr/QEuyk/NUmSYRNrk2TZy3nj
	7wdSiLj+qPko11cgNdVLg8i4KfD5uuI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-oTxWOuPWMYaohzELKozaAg-1; Mon,
 26 Feb 2024 11:58:09 -0500
X-MC-Unique: oTxWOuPWMYaohzELKozaAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 679BE1C04B54;
	Mon, 26 Feb 2024 16:58:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.85])
	by smtp.corp.redhat.com (Postfix) with SMTP id BB74EC01644;
	Mon, 26 Feb 2024 16:58:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Feb 2024 17:56:50 +0100 (CET)
Date: Mon, 26 Feb 2024 17:56:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Collingbourne <pcc@google.com>,
	Wen Yang <wenyang.linux@foxmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] get_signal: don't abuse ksig->info.si_signo and ksig->sig
Message-ID: <20240226165647.GA20826@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226165612.GA20787@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Cleanup and preparation for the next changes.

get_signal() uses signr or ksig->info.si_signo or ksig->sig in a chaotic
way, this looks confusing. Change it to always use signr.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c9c57d053ce4..09a6dd07cf6b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2842,7 +2842,7 @@ bool get_signal(struct ksignal *ksig)
 				spin_lock_irq(&sighand->siglock);
 			}
 
-			if (likely(do_signal_stop(ksig->info.si_signo))) {
+			if (likely(do_signal_stop(signr))) {
 				/* It released the siglock.  */
 				goto relock;
 			}
@@ -2866,7 +2866,7 @@ bool get_signal(struct ksignal *ksig)
 
 		if (sig_kernel_coredump(signr)) {
 			if (print_fatal_signals)
-				print_fatal_signal(ksig->info.si_signo);
+				print_fatal_signal(signr);
 			proc_coredump_connector(current);
 			/*
 			 * If it was able to dump core, this kills all
@@ -2890,7 +2890,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(ksig->info.si_signo);
+		do_group_exit(signr);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
@@ -2900,7 +2900,7 @@ bool get_signal(struct ksignal *ksig)
 	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
 		hide_si_addr_tag_bits(ksig);
 
-	return ksig->sig > 0;
+	return signr > 0;
 }
 
 /**
-- 
2.25.1.362.g51ebf55


