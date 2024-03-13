Return-Path: <linux-kernel+bounces-101697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E1A87AAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A1B2837B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A671447F51;
	Wed, 13 Mar 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4dOlyXR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D24C85
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344934; cv=none; b=hL9FTidlV4nHtJsVEdf/nV5hZmbdNE4Ct1Xj/jMwVqqAdfra/AFcBD/FxIdesxa/ZFBZzhtJqyCicAZosPzz+A3r85AmALMnzAqzHImwr+b4ZlkrgM32b0KhNXYdSDdsR6Y5BfEud07YbduhGKuJP/USU4+/1NLWeR2KLHhDym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344934; c=relaxed/simple;
	bh=COid3ls/H1cesG2EvzJHTyesfJFy9SOIgs/GvDa4P2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6P0jq0RC+quK68b6siBWupqYfXc3bAfrMvZ8vy8AD5DLyTrbHdzKh+7bYpBdpDCOCLWj3WK5gIEMBTSOCin6bMSOVxAkk5PWIOQdungHBIf8f5aSLHfugbk7n8tUO2q29vBkBFJQa1qGjf4ItmKnTlWGu/K1RzCadVGU+ftIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4dOlyXR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710344931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JC1+HJbEXxxyJy+zyJokage5HbCPC99YdysgS1QcXZU=;
	b=U4dOlyXRGlo4Yae42UPojrgLdKuP5PWyyV34V3ekHuQpbvXyzWnwFkhbKG/P30eqz29NIn
	hnuBMKVcXgkQhBIbKo+mX62hhGt+0Vb1azCRw6+COgFAzbjZ0rn8yM1Nd5Kklrq/m5WRam
	xweSQSCWFUjPl+Om1xeV+LQTLOI7cX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-UZMDdUy_MgirT-qVdBpDWw-1; Wed, 13 Mar 2024 11:48:43 -0400
X-MC-Unique: UZMDdUy_MgirT-qVdBpDWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B27B18007AF;
	Wed, 13 Mar 2024 15:48:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.233])
	by smtp.corp.redhat.com (Postfix) with SMTP id 14BF840C6DB7;
	Wed, 13 Mar 2024 15:48:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 13 Mar 2024 16:47:19 +0100 (CET)
Date: Wed, 13 Mar 2024 16:47:16 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/3] uprobes: prepare uprobe args buffer lazily
Message-ID: <20240313154716.GB25452@redhat.com>
References: <20240312210233.1941599-1-andrii@kernel.org>
 <20240312210233.1941599-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312210233.1941599-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Again, looks good to me, but I have a minor nit. Feel free to ignore.

On 03/12, Andrii Nakryiko wrote:
>
>  static void __uprobe_trace_func(struct trace_uprobe *tu,
>  				unsigned long func, struct pt_regs *regs,
> -				struct uprobe_cpu_buffer *ucb,
> +				struct uprobe_cpu_buffer **ucbp,
>  				struct trace_event_file *trace_file)
>  {
>  	struct uprobe_trace_entry_head *entry;
>  	struct trace_event_buffer fbuffer;
> +	struct uprobe_cpu_buffer *ucb;
>  	void *data;
>  	int size, esize;
>  	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
>  
> +	ucb = *ucbp;
> +	if (!ucb) {
> +		ucb = prepare_uprobe_buffer(tu, regs);
> +		*ucbp = ucb;
> +	}

perhaps it would be more clean to pass ucbp to prepare_uprobe_buffer()
and change it to do

	if (*ucbp)
		return *ucbp;

at the start. Then __uprobe_trace_func() and __uprobe_perf_func() can
simply do

	ucb = prepare_uprobe_buffer(tu, regs, ucbp);

> -	uprobe_buffer_put(ucb);
> +	if (ucb)
> +		uprobe_buffer_put(ucb);

Similarly, I think the "ucb != NULL" check should be shifted into
uprobe_buffer_put().

Oleg.


