Return-Path: <linux-kernel+bounces-78522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A15861472
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D832858B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F371E224E6;
	Fri, 23 Feb 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO1UAniW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A5224CF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699587; cv=none; b=jACxfvtTx6QpfVOc2us45CPMn2YAnEvKtTTy7uDmB4xD+agMnFS6Fx2vMLtBSfe4/9DJWhca9x4FK6Nn1VIZScQfKWzDesJkcPvfHMG3nrwbPah2/hqtwRJFKy4i9e2iPgxExcZnU61ttxA+o/cr434EEQEy6TDdXLtMMMbvpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699587; c=relaxed/simple;
	bh=lPLN3MflurleOZnGSkG5LSHSQ+Bsp2As6DQup28ggnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAuo+MMhvlB8mUBppE4u7HO/bA5ZCrNKw3E0E85Osc7R7HTZ2y3eV+xnPS9bJoLMpImsSWfSdWP7hJFseBno6WHlnCFHs4WRhdTVIpmijb+jCTQJhvEbwHv/toU58e6E+FbnWAMyjKUXB/ymZ/JB0DYUaxRg4okRErpaa6ydKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bO1UAniW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708699584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1c6XaGPverFKE+fWn9zSNV/Y1JnQF5sISQgJ+fDFl4=;
	b=bO1UAniWUDSSSVzPQ1U9sz4r3iDHNXL1GvxAyR6Fp1t3d9v2IxEmXddcVErP+fz950NbX/
	ikHpd/fnxq0GLhZjXZ1i0YEY5rmIjxoWumqfJSRF9RxOWtAu5RDme17LwrPmg/AFgpB6fn
	IN35A5jhjMORA6GWuNePWmqQUcuO20k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-vPt1uc32Njy5NXUPQCFEGQ-1; Fri, 23 Feb 2024 09:46:21 -0500
X-MC-Unique: vPt1uc32Njy5NXUPQCFEGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B18641020200;
	Fri, 23 Feb 2024 14:46:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8153BC1D36C;
	Fri, 23 Feb 2024 14:46:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 23 Feb 2024 15:45:02 +0100 (CET)
Date: Fri, 23 Feb 2024 15:44:59 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_signal: simplify/cleanup the the usage of ksig->info
Message-ID: <20240223144458.GD8267@redhat.com>
References: <20240223105025.GA4542@redhat.com>
 <tencent_7C50F304C14CB2A5133317F8A13D1F544D0A@qq.com>
 <20240223141928.GB8267@redhat.com>
 <20240223143131.GC8267@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223143131.GC8267@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 02/23, Oleg Nesterov wrote:
>
> On 02/23, Oleg Nesterov wrote:
> >
> > On 02/23, Wen Yang wrote:
> > >
> > >
> > > On 2024/2/23 18:50, Oleg Nesterov wrote:
> > > >+			/*
> > > >+			 * implies do_group_exit(), no need to initialize
> > > >+			 * ksig->info
> > > >+			 */
> > > >  			goto fatal;
> > >
> > > There is little question:
> > > If the this conditions is met:
> > >    current->flags & PF_USER_WORKER
> > > It may execute “goto out“ instead of do_group_exit().
> >
> > Yes, but vhost/io workers do not use ksig at all.
>
> Ah, wait...
>
> I forgot about the ->sa_flags check before hide_si_addr_tag_bits().
>
> OK, thanks... I'll send V2.

Tomorrow.

I'll recheck, but I think we need the patch below as 1/2 regadless of
this change

Oleg.
---

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2897,13 +2897,13 @@ bool get_signal(struct ksignal *ksig)
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-out:
+
 	ksig->sig = signr;
 
 	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
 		hide_si_addr_tag_bits(ksig);
-
-	return ksig->sig > 0;
+out:
+	return signr > 0;
 }
 
 /**


