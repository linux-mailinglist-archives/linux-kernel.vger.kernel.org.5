Return-Path: <linux-kernel+bounces-148682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8868A8620
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEE1C210BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783013D24A;
	Wed, 17 Apr 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceoNagQB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D51420C6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364705; cv=none; b=l1JmYuVtouI55O6CSNYWYjLObi7YLhYGPnBpM51uAcThbIf/4zOb0URR0pZ28ymFArFDv0un/evs4n1zHSmKGnKr85wBGLSR1Tb8h43hRiWcEpl0nD7sKuWrnX85Bhx5Nurz5WEpAb2ZhL9XiVn4cmhiTT8Qb2JWUu4r9Zfn+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364705; c=relaxed/simple;
	bh=KoYtxC55Ohj6Lf9NvLZyrFVpFV90+1Yse/ygPWxNqOY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BESL2SFd/KQEFbs6vfsNOe6YGn9Qdfes2lVV3iGw7jRq1D79zn/iIHpX7Nt1swQ4Q6QFjGS9YrKUW2HcZg4kUbixDVO7PvSswpI0nlrbkO9ewR+1HA3so6xrR8XP6D0Gi2OLNyl/yMq2bLmJi3WQ4HwZEJuEr+w+oxyErbrtwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ceoNagQB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713364702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDU7e9X4ZusOLu7T2w8qLW/ur2IZiAOdvpcSe/vwEi0=;
	b=ceoNagQBsDOwex4u56ysNMjjueFGwhigpWw/3EIALxg4Fyan0rvE3n89SKuyh4RIexjw3m
	eIcR7x/+qRUKKCGkcqDduXJ1WjkzOwK95EG/q2OF4fpGNpGjkG/ge8V24JNKkwyriBVD5T
	8Mh7phYkKAiADQVhwl6Skix3fEAo9XQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-UL2Iqt2XMpycvVM7LVyaIA-1; Wed,
 17 Apr 2024 10:38:19 -0400
X-MC-Unique: UL2Iqt2XMpycvVM7LVyaIA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E2EC3C025A1;
	Wed, 17 Apr 2024 14:38:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC07492BD4;
	Wed, 17 Apr 2024 14:38:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com>
References: <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com> <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com> <3756406.1712244064@warthog.procyon.org.uk> <2713340.1713286722@warthog.procyon.org.uk>
To: Paulo Alcantara <pc@manguebit.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live connection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <277919.1713364693.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 15:38:13 +0100
Message-ID: <277920.1713364693@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Paulo Alcantara <pc@manguebit.com> wrote:

> Consider the following example where a tcon is reused from different
> CIFS superblocks:
> 
>   mount.cifs //srv/share /mnt/1 -o ${opts} # new super, new tcon
>   mount.cifs //srv/share/dir /mnt/2 -o ${opts} # new super, reused tcon
> 
> So, /mnt/1/dir/foo and /mnt/2/foo will lead to different inodes.
> 
> The two mounts are accessing the same tcon (\\srv\share) but the new
> superblock was created because the prefix path "\dir" didn't match in
> cifs_match_super().  Trust me, that's a very common scenario.

Why does it need to lead to a different superblock, assuming ${opts} is the
same in both cases?  Can we not do as NFS does and share the superblock,
walking during the mount process through the directory prefix to the root
object?

In other words, why does:

    mount.cifs //srv/share /mnt/1 -o ${opts}
    mount.cifs //srv/share/dir /mnt/2 -o ${opts}

give you a different result to:

    mount.cifs //srv/share /mnt/1 -o ${opts}
    mount --bind /mnt/1/dir /mnt/2

David


