Return-Path: <linux-kernel+bounces-164044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E408B77A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F0E2842A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF017279C;
	Tue, 30 Apr 2024 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa63shyu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BC171E4D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485301; cv=none; b=ews8p9m8stgt2Z4SXNHLhfS7jfEwMahxYp2DMzgPi5SnphjiLOnWIFWBaMWCbRtUSUHbhtY+NmBfycyy0ZjezFKuNaQyhqL771REXxVfWh/l8g7r3hZp2aIxA6LI34OhFR6nJLuTpef8QPChKalTgIZv1ZTPRw5qmkYTKMRkbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485301; c=relaxed/simple;
	bh=/nhvSoPlU3gbi4AJGgHtqm6XNGJevnMBIdpvHTnCxWE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bkCS4Ok+S96VacUG6cRFaPbpq8O7/pOk1pyrCxxJzFmKSfgyEU/V9JBHxE94zOE+fT5h7H98v0lfkhlQblkOVx6PVaAEHwY2XGsLIW05uoDBAt9qZgnW/YZ7qsWSnI3lzgx92+BLD8+dt88o/D+H9CUe5NKFLLuxPDOP2mHT248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aa63shyu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nhvSoPlU3gbi4AJGgHtqm6XNGJevnMBIdpvHTnCxWE=;
	b=aa63shyujqR9v7B1N565TPPzoTyWBLCiTr5nI8w5eCDyoLCJQXaxULvpyMNvCc6MG1BPRw
	KjsZmhqfqCwytotUnVg6gO1+ne3apqOhCoZG837CYNdvBHTfCGOLMUvkn8M7pQSJ3e/s3Y
	7EETTjEKFVvaMG9s/PlM2sRzb0ydkYU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-18FuFe9iP5Cq84ecOvC9wA-1; Tue,
 30 Apr 2024 09:54:54 -0400
X-MC-Unique: 18FuFe9iP5Cq84ecOvC9wA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1127A29AC012;
	Tue, 30 Apr 2024 13:54:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5223C2166B32;
	Tue, 30 Apr 2024 13:54:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <e273971a5219cc240c4e9dda1adbbdf7a5ee6812.camel@redhat.com>
References: <e273971a5219cc240c4e9dda1adbbdf7a5ee6812.camel@redhat.com> <20240428111640.27306-1-linyunsheng@huawei.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
    linux-afs@lists.infradead.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2] rxrpc: Fix using alignmask being zero for __page_frag_alloc_align()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <261632.1714485291.1@warthog.procyon.org.uk>
Date: Tue, 30 Apr 2024 14:54:51 +0100
Message-ID: <261633.1714485291@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Paolo Abeni <pabeni@redhat.com> wrote:

> @David: I assume from your ack you are fine with this patch being
> merged via the net tree, am I correct?

Yes, the net tree is fine.

David


