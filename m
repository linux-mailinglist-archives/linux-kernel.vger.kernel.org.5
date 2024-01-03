Return-Path: <linux-kernel+bounces-15707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A08230A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B441F2486E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAD1B278;
	Wed,  3 Jan 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8sDSZ6r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FB1B263
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704296224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EjWs1Ykrjur5OxV9fp8a8/YADEc50jIQs9yga6wA9hw=;
	b=H8sDSZ6rokpsyUEXbHx1ZAfspLs1zUWYC8vg/A8s3o832+QuEgNJILwaMEG/87/hkGD2vE
	zqUQPrCWX85w2shbm4+ORzM3eDEKp5pg6FA2iEEj0RL9FJdA6XLMFs+p0aSdTcuE4tSkT4
	XLsbunLBNVqr9P7IjryCPDS8eR+D0vw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-w1JaHDsAN4Sv8ShNidtqXw-1; Wed, 03 Jan 2024 10:37:01 -0500
X-MC-Unique: w1JaHDsAN4Sv8ShNidtqXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA9BB88F2F1;
	Wed,  3 Jan 2024 15:37:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F8DCC15968;
	Wed,  3 Jan 2024 15:36:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZYUFs1MumRFf3mnv@gondor.apana.org.au>
References: <ZYUFs1MumRFf3mnv@gondor.apana.org.au> <20231211135949.689204-1-syoshida@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Shigeru Yoshida <syoshida@redhat.com>,
    davem@davemloft.net, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg/hash: Fix uninit-value access in af_alg_free_sg()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <386305.1704296211.1@warthog.procyon.org.uk>
Date: Wed, 03 Jan 2024 15:36:51 +0000
Message-ID: <386306.1704296211@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Anyway, I think we should fix it by adding a new goto label that
> does not free the SG list:
> 
> unlock_free:
> 	af_alg_free_sg(&ctx->sgl);
> <--- Add new label here
> 	hash_free_result(sk, ctx);
> 	ctx->more = false;
> 	goto unlock;

Hmmm...  Is that going to get you a potential memory leak?

ctx->sgl.sgt.sgl could (in theory) point to an allocated table.  I guess that
would be cleaned up by af_alg_free_areq_sgls(), so there's probably no leak
there.

OTOH, af_alg_free_areq_sgls() is going to call af_alg_free_sg(), so maybe we
want to initialise sgl->sgt.sgl to NULL as well.

Does it make sense just to clear *ctx entirely in hash_accept_parent_nokey()?

David


