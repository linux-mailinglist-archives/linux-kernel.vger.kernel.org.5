Return-Path: <linux-kernel+bounces-52551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C926F849998
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A682812E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F91AAD2;
	Mon,  5 Feb 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYgnRr5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A91CAB3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134673; cv=none; b=dJUvMVHagl37xoiky8vuiz/aSNf1uQ7bYUdhpCewxjCiJTWKK8qqY1TxDUFuTaPfu4BNrcMXLGAeDPgJTWbHUgkqNlWsk1Kh6VOlkvezs/jDUjo3kLtFfcXMJ6GH+jXODCE5udaMVNfGrLGqgwsz9dGhaXVhLNp/5ognROnSZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134673; c=relaxed/simple;
	bh=LUanOL5KSU2Dum5VwLSUoi/RhpDIavAUwlID44IYy7g=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ib5rPQXAWuvyOqZ/0+2oishJqA0CTT0J0ZsbpaZlUuvPzZX+/ICc2Pzt5+zUfBwtvAi7oJIuj92Ntaj/yYpxO5GKkbQWfHhx2XI/ITpzcmIiqvd+NAiruL8V58xASyyHsiXoi7jP7+0D4MSmc1sIEnggLMFBFL4CNxIHfRsznMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYgnRr5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707134671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULa61A+OHUmLxIbxKjifqPcDz0usstWa8Wnc31QTDuE=;
	b=BYgnRr5HX2sE/EMcxSEMgQ6LRqBDZo/gjMV45Qyer68RslIu4UKvlSIJE5iNlcmgqANQn3
	FKIhON69AaWwCIRsUQ6RYfQf/QUeyVQWoV9T25WmNeF8+NUld64/EOcQn6/jp9HpM63ZuK
	g1furHI/8KvpsqqdGfcItyeeNSedb8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-kOJ9asw_OHGeD9M_kyA16w-1; Mon, 05 Feb 2024 07:04:26 -0500
X-MC-Unique: kOJ9asw_OHGeD9M_kyA16w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB1C084AE41;
	Mon,  5 Feb 2024 12:04:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 173A8492BF0;
	Mon,  5 Feb 2024 12:04:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240130101344.28936-1-lhenriques@suse.de>
References: <20240130101344.28936-1-lhenriques@suse.de>
To: Luis Henriques <lhenriques@suse.de>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
    Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] keys: update key quotas in key_put()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3007645.1707134664.1@warthog.procyon.org.uk>
Date: Mon, 05 Feb 2024 12:04:24 +0000
Message-ID: <3007646.1707134664@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Luis Henriques <lhenriques@suse.de> wrote:

> Delaying key quotas update when key's refcount reaches 0 in key_put() has
> been causing some issues in fscrypt testing, specifically in fstest
> generic/581.  This commit fixes this test flakiness by dealing with the
> quotas immediately, and leaving all the other clean-ups to the key garbage
> collector.

Okay, I'll accept this.

> This is done by moving the updates to the qnkeys and qnbytes fields in
> struct key_user from key_gc_unused_keys() into key_put().  Unfortunately,
> this also means that we need to switch to the irq-version of the spinlock
> that protects these fields and use spin_lock_{irqsave,irqrestore} in all the
> code that touches these fields.

.. Which shouldn't be that often.  It only happens when a key is created or
finally let go of.

> Signed-off-by: Luis Henriques <lhenriques@suse.de>

Acked-by: David Howells <dhowells@redhat.com>

Jarkko - could you pick this up?


