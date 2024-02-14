Return-Path: <linux-kernel+bounces-65859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 996958552E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B371F23751
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804913A26C;
	Wed, 14 Feb 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHJyqyec"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1760DE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937564; cv=none; b=AadA+kFpV03bJDqDs9VKL8s/vysRSP0hqxOhVip1A0Ue0+XElJhBiy/N3IlstrMqdBeb5YlAZ3j3o/rNCW+T+3rgxMF+FqF0MflHV0Ml3Dg0u3Xrdi54dsJSNVlfsBNgZWfkLH4KxrtDqDGYAw8xUNpW7HDItrwmsE961D1HGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937564; c=relaxed/simple;
	bh=xFMeZwcDHHVXswxCzpJihYdm2tRWpo2qchzwb+I7kKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSFT3GmcXaXYMLk2k4mWuMLgQ83P/JH41kGhMPyZluM+oIDfea1U0sNGMPsWM76Pxn9TkDHCg5/OpIpk8sXZt4QB0MEwPPjRJ1rKJm5kdneP6xs2Aevxgy5tPmkagNRjE2UrRJ3xXn5K7dNGNIMSbLJAsEOKdOzu+6XBG1Ba5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHJyqyec; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707937562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rrj06WBEVkGII72TIMpbKKvXYs1O1D5VjTMRDkQroAo=;
	b=YHJyqyecLY/RDx9opP+hcb8NQ5PIut1CAsJdobdB/NXenyXAarMSRmNDjzlSICA8K8XxYT
	BLMAfNtzCGwl8vdYN8UXGN+xTeZLov8YJGlCrvV305T07hwQO3MrdsUCDJApif/sskdCCz
	j0bYeiuGoVEErCUmyjGc47acEFBZvXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Px-Z8yAsN9m3hy992gZR6A-1; Wed, 14 Feb 2024 14:05:58 -0500
X-MC-Unique: Px-Z8yAsN9m3hy992gZR6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFC411005055;
	Wed, 14 Feb 2024 19:05:57 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC781200AE71;
	Wed, 14 Feb 2024 19:05:56 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 35EF440419F4D; Wed, 14 Feb 2024 15:59:36 -0300 (-03)
Date: Wed, 14 Feb 2024 15:59:36 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 11/12] x86/resctrl: use smp_call_function_single_fail
Message-ID: <Zc0NmOkQDW1AOSwz@tpad>
References: <20240206185710.116221062@redhat.com>
 <87zfw5k8w8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfw5k8w8.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Mon, Feb 12, 2024 at 04:19:19PM +0100, Thomas Gleixner wrote:
> On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> > Convert update_task_closid_rmid from smp_call_function_single
> > to smp_call_func_single_fail, which will fail in case
> > the target CPU is tagged as block interference CPU.
> 
> You fail again to provide a rationale for this change.
> 
> What's worse is that you fail to explain why you think that creating
> inconistent state is a valid approach.

Well, the patch is broken and needs fixing.


