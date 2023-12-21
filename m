Return-Path: <linux-kernel+bounces-8554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CE81B952
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0CD28218B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134C6D6C8;
	Thu, 21 Dec 2023 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOvhHpn1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C16D6C1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703167855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxkfOE9TRkgl5fLvj/IAktRXgSqIyb2OVdHrT5FumGw=;
	b=IOvhHpn1LbRQAAjRk7Bycs+lJ95F+xEnHErMg5VoGfjpDlQpT93QVLO9FsbkwfG7woawOE
	zGvYuuCAtubGS/Qm5jiHfnO0kW3Cfqkqv2TZBcbpx4oU4M30ln/isHDn1iHT1L+F92D8Vr
	lvfe5hjV+9uc5pU2eg0JIRE/OeoQZN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-ovpxtsK2Oia-sK79T5Mx-Q-1; Thu, 21 Dec 2023 09:10:51 -0500
X-MC-Unique: ovpxtsK2Oia-sK79T5Mx-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD8FC85A58C;
	Thu, 21 Dec 2023 14:10:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AAFD11121306;
	Thu, 21 Dec 2023 14:10:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231221085849.1463-1-abelova@astralinux.ru>
References: <20231221085849.1463-1-abelova@astralinux.ru>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    lvc-project@linuxtesting.org
Subject: Re: [PATCH] afs: remove redundant overwriting of ret
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1660753.1703167849.1@warthog.procyon.org.uk>
Date: Thu, 21 Dec 2023 14:10:49 +0000
Message-ID: <1660754.1703167849@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Anastasia Belova <abelova@astralinux.ru> wrote:

> @@ -409,7 +409,6 @@ static int afs_update_cell(struct afs_cell *cell)
>  		if (ret == -ENOMEM)
>  			goto out_wake;
>  
> -		ret = -ENOMEM;
>  		vllist = afs_alloc_vlserver_list(0);
>  		if (!vllist)
>  			goto out_wake;

This isn't a sufficient fix.

Yes, you're right, we need to keep ret - but we do need to set -ENOMEM if
!vllist if ret does not hold an error.

David


