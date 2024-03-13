Return-Path: <linux-kernel+bounces-101209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848987A405
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0391C215EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1F199C7;
	Wed, 13 Mar 2024 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POK08m+l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4318EAD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317842; cv=none; b=WyZpULKpbmY6cTQMoY899YsbI2QHIaRLGl3/3rSlJ/bHGyUKlGV4rkR1OKDC4qAU7DvYeG1EQ9fytz3zFcRpHwqv/e4ud32i+lTWUdqv6T9nOUHLgA8hQkT2LI6Q2cRYTK+zmCeekHHeQPp/q1j0FiL1wtbAUQCYxH3ZjHdIoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317842; c=relaxed/simple;
	bh=R7UrPyomiogXTOEePhUSBvSOHyrsJBsiTYmFkWgfznk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=acomUNzhGLoxf06WJjIPVq4Pc55Krf8JXnMzcAbMwJjOBE7zDGBc1QUyGo9dEecZDox19u1M2br41nLy7eRANXZT88mnU0oaHwQH9FYzv8I39488Hus3DW8PPh7Df2Co1HmTiPuS33nGnufho76d7VLtlL3xfpbJp4JJYA2x91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POK08m+l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710317839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7UrPyomiogXTOEePhUSBvSOHyrsJBsiTYmFkWgfznk=;
	b=POK08m+lkqHTEr+5eB8pNav3J/4OKhC5XiqLBU0ZmbDlsf3C2JO0Ak4LnkPcIVYKbgh45z
	iyTiiqH3WOXJ36UKKpHJ80GCycaVg4XRdf+3vZNCh0qltI2lyIw2KxJ+k3LiYGjlw5pD85
	f5c762JkBE66qQ5yky+XMWKG2LUttUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-sASfXibLP_KkMwtU8aFqsQ-1; Wed, 13 Mar 2024 04:17:14 -0400
X-MC-Unique: sASfXibLP_KkMwtU8aFqsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF9CE80026D;
	Wed, 13 Mar 2024 08:17:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 624AA1C060A4;
	Wed, 13 Mar 2024 08:17:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-1-dhowells@redhat.com>
References: <20240312233723.2984928-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] rxrpc: Fixes for AF_RXRPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3060407.1710317831.1@warthog.procyon.org.uk>
Date: Wed, 13 Mar 2024 08:17:11 +0000
Message-ID: <3060408.1710317831@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

David Howells <dhowells@redhat.com> wrote:

> Here are a couple of fixes for the AF_RXRPC changes[1] in net-next.

Actually, this should be aimed at net now that net-next got merged.

David


