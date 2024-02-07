Return-Path: <linux-kernel+bounces-56527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972184CB40
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168881F21A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BB76C88;
	Wed,  7 Feb 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQYOLSqU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B776C8E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311552; cv=none; b=pCK4n8500Lf8qy7ZN+2/BXYepRkTFldoIPDg13/VqWSLfr4bj6oeTCTGUVAvi+YCApnYwAlkHrCEtoXreXLBPfuVij/JSSo6lZ5Y5YltHxzw6fpVFTAcpYHY0Yz61Hj4Lro0LNzNo16V4tUP4EujP2JRsu/DEVB3KQzxwLifkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311552; c=relaxed/simple;
	bh=gAMRtlwIMizV7xaoFhPeVklB/rXaMNHkjdsTcVxZjBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ3fRJLDKkJsRnqkziK2pnCj8uxL4rKTkCac7fh56Dr3Xwz4JZrWKrvx+PVVrPtUBd3GBlE2zJLG/KlSbTYPoLrZwWMpD0X6aqJ4S2neao+zgtC98SJnq8j7dLDmaBDDWjP3VzQ0NPvx5OYtKkUeLlUT11Jh2eEPf9XYHoscEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQYOLSqU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707311546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQl+1OPBUOY108zNM8zP33G1TVH+klQDZcHPJb7jUZ0=;
	b=aQYOLSqUgZnbBDLpLr/Hb4eSTTJwKyirHxaMHTRnAxLTVf9N2L7vt3lJXMDIe+SrOpCWAy
	OwB+9dI+43Fm+RL2Vpnku59QBv616h48UAZaeEnmOxLTDxJC9Y3Ep7lLLGH254hegO8Sw3
	pUvFVin7ljPJrb/JQ5MUxTRUoRfxzxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-jIPqCiCFP6SwIxaswi5wGQ-1; Wed, 07 Feb 2024 08:12:25 -0500
X-MC-Unique: jIPqCiCFP6SwIxaswi5wGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64F0385A58A;
	Wed,  7 Feb 2024 13:12:24 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B2F91121313;
	Wed,  7 Feb 2024 13:12:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 7D7804023F55F; Wed,  7 Feb 2024 09:58:04 -0300 (-03)
Date: Wed, 7 Feb 2024 09:58:04 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 05/12] timekeeping_notify: use stop_machine_fail when
 appropriate
Message-ID: <ZcN+XM4223HS42LM@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.955049547@redhat.com>
 <87h6ikmqqo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6ikmqqo.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, Feb 07, 2024 at 12:57:19PM +0100, Thomas Gleixner wrote:
> On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> > Change timekeeping_notify to use stop_machine_fail when appropriate,
> > which will fail in case the target CPU is tagged as block interference
> > CPU.
> 
> You completely fail to explain 'appropriate'. There is zero reason for
> this churn, really.

The churn is so that we can return an error to
current_clocksource_store (sysfs handler for writes to
/sys/devices/system/clocksource/clocksource0/current_clocksource).

Yeah, should probably separate patches that prepare code for 
returning errors from the actual change between smp_call_function_single
and smp_call_function_single_fail (started that for the
rdmsr_on_cpu/wrmsr_on_cpu helpers).

OK, so i am assuming you are good with the general idea of the patch
(and have no better one) which is:

idx = block_interf_srcu_read_lock();
ret = smp_call_function_single_fail(cpu, remote_fn, ...);  (or stop_machine_fail)
block_interf_srcu_read_unlock(idx);





