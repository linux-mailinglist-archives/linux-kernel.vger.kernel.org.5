Return-Path: <linux-kernel+bounces-56531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B884CB4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BEB1C20FA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156E76904;
	Wed,  7 Feb 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmhSTfRP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21859B74
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311818; cv=none; b=X3abqgCZhs1YZC+TQ2upC8MrK7fDqg7xX4RlNDxpzG4xm3KRoDHDwxsoa9phrBSAI27rZifo5Ju6RQLR9MykXApcAoDnEq1w1VjztgafP57k1UvA/c4yMxZTb2S1nt1mLTGHOWsfdlurv7mf1RP50hbeSoIHQAR8+MGxslLGWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311818; c=relaxed/simple;
	bh=cJGS2bQvjxJqJxJjCou5SYqZ2aSmKr2wJCslBxFzqJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfUvlSYjh3eD/Ak5S1SV9omxTFApqrrpUO/qQQLrjbY0LHTopPcI1/Wfpi5BWtl+ke0LrMOWsJjs/GvJ2CopSVlcw1vYacfKGsZ6N1/Ja4WUh68nhf05ixqyoLC+noTslWkEGDM/al04RVYQA55vsFkoZioOmE9V6KRkMKzmIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmhSTfRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707311816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOrG8Wo1NkJQqtbBCFGhK75fb50E8gGqiRQRJy/7bZs=;
	b=AmhSTfRPAiNYUnJa/cpNlZMbqy74JVxOIdEkH1IAyRNEDddDEKby7pRD2kap58DTZag9vw
	ZVtA9kHA/G5y+dCsgG3BxxZhJMQOTfmqoV6ysAJoe1Rv6eqZyxL0iX9orXcol6g0wumEFX
	k9KSbjArYTPXzNC3l/dukO4DDrgQQbM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-etdCjt-YPUSYdx21-qLuRw-1; Wed,
 07 Feb 2024 08:16:51 -0500
X-MC-Unique: etdCjt-YPUSYdx21-qLuRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F9703C11A05;
	Wed,  7 Feb 2024 13:16:51 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 33846C1596E;
	Wed,  7 Feb 2024 13:16:51 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 667D8401E1133; Wed,  7 Feb 2024 10:16:29 -0300 (-03)
Date: Wed, 7 Feb 2024 10:16:29 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 12/12] x86/cacheinfo.c: check for block interference CPUs
Message-ID: <ZcOCrearsKaZiBt/@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185710.142514323@redhat.com>
 <87eddomoov.ffs@tglx>
 <ZcOBUWlZMpIErtKu@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOBUWlZMpIErtKu@tpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Feb 07, 2024 at 10:10:41AM -0300, Marcelo Tosatti wrote:
> On Wed, Feb 07, 2024 at 01:41:36PM +0100, Thomas Gleixner wrote:
> > On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> > > @@ -396,6 +397,7 @@ static void amd_l3_disable_index(struct
> > >  	 *  disable index in all 4 subcaches
> > >  	 */
> > >  	for (i = 0; i < 4; i++) {
> > > +		int ret;
> > >  		u32 reg = idx | (i << 20);
> > >  
> > >  		if (!nb->l3_cache.subcaches[i])
> > > @@ -409,6 +411,7 @@ static void amd_l3_disable_index(struct
> > >  		 * is not sufficient.
> > >  		 */
> > >  		ret = wbinvd_on_cpu(cpu);
> > > +		WARN_ON(ret == -EPERM);
> > 
> > What? You create inconsistent state here.
> 
> That should not happen, since we checked for 
> 
> +   idx = block_interf_srcu_read_lock();
> +
> +   if (block_interf_cpu(cpu))
> +           ret = -EPERM;
> 
> Earlier.
> 
> Thus the WARN_ON (hum, can change to BUG_ON...).
> 
> > > -	amd_l3_disable_index(nb, cpu, slot, index);
> > > +	ret = 0;
> > > +	idx = block_interf_srcu_read_lock();
> > > +
> > > +	if (block_interf_cpu(cpu))
> > > +		ret = -EPERM;
> > > +	else
> > > +		amd_l3_disable_index(nb, cpu, slot, index);
> > > +
> > > +	block_interf_srcu_read_unlock(idx);
> > 
> > Again. This is a root only operation.
> > 
> > This whole patch series is just voodoo programming with zero
> > justification for the mess it creates.

BTW, this converted less than 17% callers, so this is why early
feedback is useful.

Thanks!


