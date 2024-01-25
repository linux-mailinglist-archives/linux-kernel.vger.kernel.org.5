Return-Path: <linux-kernel+bounces-39179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A083CC1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A185B230D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F21350E6;
	Thu, 25 Jan 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoaoKBG4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164C1353F5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210942; cv=none; b=d2mtHs4Xt0TVjGD6/I5xjecuwx4Yl8dXeD7OYf6Dz1FxCycUUsn0Sfzs9fdeVbyFC5FSa35hlUwcYPfWL5TRQLnbEbefkh3jK/oGCEdN+hGvbsCJd6JbZQdstOC7NCt+i/ypmr0df8z8VAn86sNsW1vSUG/4uJSYeEBqtWLVGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210942; c=relaxed/simple;
	bh=Klf1n72HKz+7NLRCuzAOesPmv7RwpZWk37FL3U1M6Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WntRAPqZCN8GudYLa2fS1B5kf72DFimT5DBCtY0cd0KwB44eDazi0X01V+BTrC631GS+St4mwnnzDXPvDBJOhEzXoOe10PHq76CGigGWxkDqmwnavrEDtwk1+f0Tdjz+Qhu7emLyqW1AcjMcuz2JqS+Ge5ktCWJVcD6aoIp2wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JoaoKBG4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706210937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orENYTchG91SsGUpfMPnTLKwMM3GW/2swFPCPjquPdc=;
	b=JoaoKBG49vOwdRiy2LEQJXxNLve3wTbm5GKZ5aUul27WLfAfDz9AjwtfNVxf1shYB4mYJj
	n6RLS1dALxcU6AqgbnUmYbhWWNMuKcVYIg+d50WF7KxHHkbVZiEeem1Q/Kln5HZ2+GCgAo
	2/Wqn8nXHE9fmAlbwqwsXluEBZ80Vlc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-p7iKSKg_ObCnrrZaKzoIWA-1; Thu, 25 Jan 2024 14:28:51 -0500
X-MC-Unique: p7iKSKg_ObCnrrZaKzoIWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C23185A58C;
	Thu, 25 Jan 2024 19:28:50 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F4C40CD14B;
	Thu, 25 Jan 2024 19:28:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Date: Thu, 25 Jan 2024 14:28:46 -0500
Message-ID: <EB613778-D963-438B-AA20-66D5E5E0DD90@redhat.com>
In-Reply-To: <524118.1706195224@warthog.procyon.org.uk>
References: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com>
 <520668.1706191347@warthog.procyon.org.uk>
 <524118.1706195224@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 25 Jan 2024, at 10:07, David Howells wrote:

> Benjamin Coddington <bcodding@redhat.com> wrote:
>
>>> NFS.  NFS at the very least needs to be altered to give up the use of
>>> PG_private_2.
>>
>> Forgive what may be a naive question, but where is NFS using PG_private_2?
>
> aka PG_fscache.
>
> See nfs_fscache_release_folio() for example where it uses folio_test_fscache()
> and folio_wait_fscache().

Ah, thanks!  At the end of the netfslib work, will NFS still be able to
utilize fscache and still manage its own folios, or are you looking at
making fscache be an all-or-nothing depending on the use of netfslib?

I think NFS might easily stop using PG_fscache by carrying that information on
folio->private (since we're currently stuck with it).

Ben


