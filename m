Return-Path: <linux-kernel+bounces-56528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5611284CB41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0F1C2656A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33C76C7F;
	Wed,  7 Feb 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFfXjnG1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B177763B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311554; cv=none; b=AANuwOrLh89Pzq8rz9qazW4PCngzvb+E4qsYPgNFW+dqxQOvqX39KWh0AuehopyNN7jBgYKv7s17VeGrVGj//WC9RbRyTq9/34NA8+cfupFDmpVeDLJ/cWCuteeDvIGVQBkELEXcTM+8NL54CzCOJKefuE9v2nODEo1s/ZCUWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311554; c=relaxed/simple;
	bh=mcgudmNsgGYlUWEso2KgZlxVIAjOAUJd8mkOJpdSHgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txJVH+hR2DBWCtjgaErA8fa3II5rHfTTp21SQv80ieUZyK2S3E2HzNJyEkNlfJTR+EngcVLBu88zx+//JeHZqZIgsgAWF8fFNwPSy+/q/SddD1NlYBqdg79wr7lk1dyPSyfc/loMG7aiaEtIq3jDWjChHhBcND75qIft4QFUU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFfXjnG1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707311547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eRyFxceGltGzr8JPr9dUfh3b9LMZCIpGvQjr0KChxI=;
	b=KFfXjnG1fltBG1fYqcfOpLiYer8A7Tl9/cNOIPZZbuZrmmeIScHC+LmuR8+jWClXiiQeZI
	DeSG+NlnsMq3awhHFeDa4xMyV5oZPzsHCMpTwdAqwFFpvWWgdipJvD4LNtazguXMJkwqO/
	elIbNqeBlJk6d8oDbdL5J7CWCzYJw8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-JL0pHH3iOpCClapp8WzwRA-1; Wed, 07 Feb 2024 08:12:24 -0500
X-MC-Unique: JL0pHH3iOpCClapp8WzwRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69CE285A58E;
	Wed,  7 Feb 2024 13:12:24 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E40AC08EF7;
	Wed,  7 Feb 2024 13:12:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 3E826401E12E5; Wed,  7 Feb 2024 10:10:41 -0300 (-03)
Date: Wed, 7 Feb 2024 10:10:41 -0300
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
Message-ID: <ZcOBUWlZMpIErtKu@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185710.142514323@redhat.com>
 <87eddomoov.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eddomoov.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Feb 07, 2024 at 01:41:36PM +0100, Thomas Gleixner wrote:
> On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> > @@ -396,6 +397,7 @@ static void amd_l3_disable_index(struct
> >  	 *  disable index in all 4 subcaches
> >  	 */
> >  	for (i = 0; i < 4; i++) {
> > +		int ret;
> >  		u32 reg = idx | (i << 20);
> >  
> >  		if (!nb->l3_cache.subcaches[i])
> > @@ -409,6 +411,7 @@ static void amd_l3_disable_index(struct
> >  		 * is not sufficient.
> >  		 */
> >  		ret = wbinvd_on_cpu(cpu);
> > +		WARN_ON(ret == -EPERM);
> 
> What? You create inconsistent state here.

That should not happen, since we checked for 

+   idx = block_interf_srcu_read_lock();
+
+   if (block_interf_cpu(cpu))
+           ret = -EPERM;

Earlier.

Thus the WARN_ON (hum, can change to BUG_ON...).

> > -	amd_l3_disable_index(nb, cpu, slot, index);
> > +	ret = 0;
> > +	idx = block_interf_srcu_read_lock();
> > +
> > +	if (block_interf_cpu(cpu))
> > +		ret = -EPERM;
> > +	else
> > +		amd_l3_disable_index(nb, cpu, slot, index);
> > +
> > +	block_interf_srcu_read_unlock(idx);
> 
> Again. This is a root only operation.
> 
> This whole patch series is just voodoo programming with zero
> justification for the mess it creates.
> 
> Thanks,
> 
>         tglx

Its not really voodoo programming: its simply returning errors to
userspace if a CPU is set in a particular cpumask.

Do you have a better idea? (i am in the process of converting more
users).
Can improve on the patchset quality.

Ok, the justification is as follows. Today, there is a reactive approach
to interruptions to isolated CPUs:

1) Run Linux+latency sensitive application on isolated CPU.

2) Wait for IPI or other interruption to happen on that isolated CPU,
which breaks the application.

3) Remove that interruption to the isolated CPU.

This is (for a class of IPIs), an active approach, where those IPIs are 
not permitted to interrupt the latency sensitive applications.

https://iot-analytics.com/soft-plc-industrial-innovators-dilemma/

"Hard PLCs (a market in which incumbent vendors dominate) have
historically addressed most of the needs of the existing / high end
market, such as high reliability, fast cycle times and, perhaps most
importantly, the ability of existing workforce to support and maintain
the systems. Soft PLCs, on the other hand, initially addressed the needs
of new / lower end customers by providing more flexible,
non-deterministic control solutions often at a fraction of the cost of
similar hard PLCs. Since entering the market in the 90’s, soft PLCs have
rapidly become more performant thanks to advances in virtualization
technologies, real-time Linux operating systems and more powerful edge
computing hardware, thus moving up the y-axis (product performance) in
the chart above."




