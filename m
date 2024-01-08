Return-Path: <linux-kernel+bounces-19655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4EF827068
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0311F22E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6E46531;
	Mon,  8 Jan 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayGPonu+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366A45BE9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704722155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIbiAoj2Z3CYeI3SIW7dD3XbJpcWqFJ6BlUheRPsgEg=;
	b=ayGPonu+/W6KP2m09nxEcHr3X7oa1lzNQ4u6ckSMfFOfofC4cvbhxQdt6YNo6YeMPRM9hu
	yGVgRBuiZIOLG3G4K7Y5aoDta/dmCt7V0AInVzy4pOf7vYxA2k+YwnFfZmkGDXXIacWhHk
	NFlsXRSBIm3a/ynCvB2Isshk8atbySA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-m1uR15DwN7WbwmdvBHyrcg-1; Mon, 08 Jan 2024 08:55:52 -0500
X-MC-Unique: m1uR15DwN7WbwmdvBHyrcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4C6A832D60;
	Mon,  8 Jan 2024 13:55:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 001B8C15E6A;
	Mon,  8 Jan 2024 13:55:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20240108112713.20533-1-duminjie@vivo.com>
References: <20240108112713.20533-1-duminjie@vivo.com>
To: Minjie Du <duminjie@vivo.com>
Cc: dhowells@redhat.com, linux-cachefs@redhat.com,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] netfs: use kfree_sensitive() instend of kfree() in fscache_free_cookie()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1521939.1704720813.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Mon, 08 Jan 2024 13:55:50 +0000
Message-ID: <1522748.1704722150@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Minjie Du <duminjie@vivo.com> wrote:

>  linux-cachefs@redhat.com (moderated
>  list:FILESYSTEMS [NETFS LIBRARY]), linux-fsdevel@vger.kernel.org (open
>  list:FILESYSTEMS [NETFS LIBRARY]), linux-kernel@vger.kernel.org (open list)

In future, could you edit the comments out of the email addresses, please?

> key might contain private information, so use kfree_sensitive to free it.
> In fscache_free_cookie() use kfree_sensitive().

There's no real point.  These are written as filenames (possibly base64-ish
encoded) on disk by cachefiles and represent the information given to the
server to indicate the file (in afs, for example, that's cell name, volume
name, vnode number).

David


