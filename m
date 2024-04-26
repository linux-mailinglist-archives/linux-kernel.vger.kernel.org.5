Return-Path: <linux-kernel+bounces-159646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137BF8B318A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EA9288265
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4813C66D;
	Fri, 26 Apr 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+D/jY9/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD922338
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117263; cv=none; b=lcbxTclc9US33XeKpAuf7mY5/Y9NjOkCgC0amQc/PFAYmpieg4/jQVsrXglU8fFRQZovA2UJOskh0epCSjUcktuxIgy7mbC4zNVSpoeDJ2r6fmIEk10W55wV0b6lB86lmdAk2O2CwBSDCHAHgbw3z7w0pcXvJSC/5ZuNerHn0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117263; c=relaxed/simple;
	bh=a33sSvhsy7w8Kh3QHnL7F3iWxGtqcRtc9AZE85+hn7Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=iwlNk4vGyw1puzqhbhjZSPgQYG8JpXZhaHDhZDRVnF5pg9LZ3Zck1OQ8QRE3XhdR/03Hx01pH/Fy/ymBWO+WxFGy4K2X8oHIfA6rXnPcB3kcyDSVdWg1w6VLBAN+rkHzhsUHWLO0J0E7T5m+4fAnySJVX82qU2341ptbFYDwfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+D/jY9/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714117260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ckphtQtVPyzmtTEJZjcavjTJN2bI8fj5SZ69O4ugW4=;
	b=H+D/jY9/q8qJURomNwhM+GWgduOb3rLGILmdz9LBCHhfgO08opaP+LsFlvpwO7mj7gZWNb
	QT/aZu2o+8h8u9JwHHCmgAkWa3OTwoICHjz/pAb2Wjv2zwDPVeLoaJ1e00mhxKAMO0H5N8
	NKqGEr/mu4xFVJ4ShVgSkyElaIhQaC4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-Pdjurq_MNPGagr7Tk27mhQ-1; Fri,
 26 Apr 2024 03:40:55 -0400
X-MC-Unique: Pdjurq_MNPGagr7Tk27mhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 993BE3C025B3;
	Fri, 26 Apr 2024 07:40:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11903C26A4D;
	Fri, 26 Apr 2024 07:40:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240424191740.3088894-1-keescook@chromium.org>
References: <20240424191740.3088894-1-keescook@chromium.org> <20240424191225.work.780-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: dhowells@redhat.com, Mark Rutland <mark.rutland@arm.com>,
    Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
    Boqun Feng <boqun.feng@gmail.com>,
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
    Borislav Petkov <bp@alien8.de>,
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
    "H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
    Catalin Marinas <catalin.marinas@arm.com>,
    Arnd Bergmann <arnd@arndb.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    "David S. Miller" <davem@davemloft.net>,
    David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
    Paolo Abeni <pabeni@redhat.com>,
    "Paul E. McKenney" <paulmck@kernel.org>,
    Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
    linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
    netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping addition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2100616.1714117250.1@warthog.procyon.org.uk>
Date: Fri, 26 Apr 2024 08:40:50 +0100
Message-ID: <2100617.1714117250@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Kees Cook <keescook@chromium.org> wrote:

> -	return i + xadd(&v->counter, i);
> +	return wrapping_add(int, i, xadd(&v->counter, i));

Ewww.  Can't you just mark the variable as wrapping in some way, either by:

	unsigned int __cyclic counter;

or, to use rxrpc packet sequence numbers as an example:

	typedef unsigned int __cyclic rxrpc_seq_t;

	rxrpc_seq_t	tx_top;

Then you can get the compiler to spit out a warning if you use <, <=, > or >=
on the numbers as an added bonus.  (You should use before() and after()
instead).

David


