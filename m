Return-Path: <linux-kernel+bounces-71632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E185A80C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC8E1F24D01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA13A29A;
	Mon, 19 Feb 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6tXvI5J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9E3CF66
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358489; cv=none; b=IzgwCSu1gEGBRHoo1t9nIJD+Wv7wFlhpC4KBT4KCHQXl6xKYd9W1J5VDaeaXr0Mz2ug0cwEzZZYYEPCeK2CROyfQ6sB+6aEM4jEq4EFM3NnB7U1Yd8Ucl5hTANeBKopn+e5n18KHxtauR59Zxhkpp1PsQEjcrVSoG6AYtSwlmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358489; c=relaxed/simple;
	bh=gycZaBE7Cy24i7aMR1MwJXS9SdXAFZkBFApim+SPZRM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uSAL0dsQVFGF/HFH1w224nbmd3PZYKSTZC72dM4IbGH6K7+u6o5PzvXHDZPclD/DPQDdDA6S59SZAsOBfJY85iq1aD79o0AYt2/F9hJRrLG4yBwmqw0QSHBjkektGZLsYiT/NZjEu7R60N8gmLq771KnnBsh9Zx8YHTv2MUB75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6tXvI5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708358486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gycZaBE7Cy24i7aMR1MwJXS9SdXAFZkBFApim+SPZRM=;
	b=G6tXvI5JoSVfPl08lUgOEzhwWg6Y9Trct5tqlX+FDqCSgXTEadYfCothxY90Vc9ji9CmzF
	CYbdxr/hs//wmaMKfrL9D91MshOjRQRyFIQpfVR3g+IDM5YuKbFWbwipmKAwPzblmZ/dh/
	fw++4B5Jde0/jCC4OeSWH4IyvJiFsIQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-Sl4aI5GGPlOIOR_R_x3-Jw-1; Mon,
 19 Feb 2024 11:01:22 -0500
X-MC-Unique: Sl4aI5GGPlOIOR_R_x3-Jw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2AA51C05133;
	Mon, 19 Feb 2024 16:01:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCDB6492BE2;
	Mon, 19 Feb 2024 16:01:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <208066d6326a428499fa68c5984da62c@aladdin.ru>
References: <208066d6326a428499fa68c5984da62c@aladdin.ru> <20240212083347.10742-1-d.dulov@aladdin.ru> <125563.1708338814@warthog.procyon.org.uk>
To: Daniil Dulov <D.Dulov@aladdin.ru>
Cc: dhowells@redhat.com, Jeffrey E Altman <jaltman@auristor.com>,
    "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH v2] afs: Increase buffer size in afs_update_volume_status()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <214311.1708358480.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 16:01:20 +0000
Message-ID: <214312.1708358480@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Daniil Dulov <D.Dulov@aladdin.ru> wrote:

> Thank you for your feedback. I agree with the suggested improvement. I w=
ill send v3 a bit later today.

I posted an updated patch:

https://lore.kernel.org/linux-fsdevel/20240219143906.138346-3-dhowells@red=
hat.com/T/#u


