Return-Path: <linux-kernel+bounces-131054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528BD898275
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1D71F26A20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989895D724;
	Thu,  4 Apr 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chS54chS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328AE200AE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217017; cv=none; b=PIwhrMZpHB99HeosqxLiY8Ig4AC9vK4yPdeIflLvtgbYuf2u6Tt5k5ai7nYcvqVqUAkb1sIiW2XBvFDzSD+YVBHFJj3v0AYalRv97kijoL2PHNYtm+yW2P9ADgneHMtNq+ddViAAYeWYu3AIBGCfBn1FfzZZg4qqz3tJGwjrO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217017; c=relaxed/simple;
	bh=PDF8rAKtnoPQ5NeHKnC7IYfiaYEQ3BItds/rRYPd950=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=If23YoEh4iUGhkBW7S1cFiqJNevziaivziM22D8PQ0aKumfEeiXJFx7/IFf/wfGa/C3BaOqH9jc9QGCc0DwCMe014fNuRu5xjbK8Vd1bm3Lt+mtcrd7EwxDx5CSoSliF1XHhkHvgbkX39kPCsi0tQrTPWRZJQbPRi4aiEAN3etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chS54chS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712217014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvAHaZMN971uikkj/WIR5kxgCR1HxCvO96dpGZLwAzw=;
	b=chS54chSHWiMhjEaDJNY7E7FvGDUiv0+OYmcWIgBSD2lc5sB4e2TWc3KuqUdLS4UG5NHSq
	A3KNbIAiEFGVlWuiqbC2P2B0QN/qWCZuMTTQ/njZLzjcBiYKtY8yRJy7+efp20/adUj6RG
	pveeM9hAYOL1Y1wVTPq2jK104j8cwjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-ko-0_dPIO36rm-uMOucm5A-1; Thu, 04 Apr 2024 03:50:11 -0400
X-MC-Unique: ko-0_dPIO36rm-uMOucm5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5453A87984B;
	Thu,  4 Apr 2024 07:50:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A11C6200A386;
	Thu,  4 Apr 2024 07:50:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240404132456.579b8ae9@canb.auug.org.au>
References: <20240404132456.579b8ae9@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3655431.1712217006.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2024 08:50:06 +0100
Message-ID: <3655432.1712217006@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> diff --git a/net/9p/client.c b/net/9p/client.c
> index dada0033d71e..d4b88b7ff5ef 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1699,7 +1699,7 @@ p9_client_write_subreq(struct netfs_io_subrequest =
*subreq)
>  	}
>  =

>  	if (written > len) {
> -		pr_err("bogus RWRITE count (%d > %lu)\n", written, len);
> +		pr_err("bogus RWRITE count (%d > %zu)\n", written, len);
>  		written =3D len;
>  	}

Actually, that's the wrong fix.  'len' needs to be int not size_t because =
of
the varargs packet formatter.

David


