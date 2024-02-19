Return-Path: <linux-kernel+bounces-71585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63185A75F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4261C216AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858773A1BA;
	Mon, 19 Feb 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4ytH23W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103E39FC1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356618; cv=none; b=c8e/Z9sNpBeES8/Uu8klbCdpDF2qwgIN0nnbSfLet8aC2yBFwFnfXbTwVkQWL7i1YXoqtp11zbtGIUqossUUtT0a4dXIKMKlm+7iy5NGMJq6GnHyxRd/nZyAI7Ws1HuYCrjeofrJSq8jipE4nrJsZ0KartZChCS42fSRJSmPOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356618; c=relaxed/simple;
	bh=hvcSZggNYwd1CYJgsripQwgsNNAg6Cy3z4QCGLatV4w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TzPkh6sCsj8xvJmM56ZeQQpbUqxn5pP61/dNlvdK4nd6tO5v+QMP6eKxOt+O60wuOUIXOW+K63WMVUQr42EaLhrKFkTNYnQnoHGaNRyjMm0x3j1izFKeVmUwFylb7nr1YxaSwL0dl3H773bek9+tgnaseXoPgzKTIF09B1iejU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4ytH23W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708356616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYaLkDingG/oVb75goCjWGn8ofJus/df9gihxIlJ4do=;
	b=Q4ytH23WknfXhuT68bnygAeMVi4Oib3FZ8Dg60BA5RsrAimuIFa4Vzj5XMWnuIgSV4u2ft
	cde2XxtZPtIszjMbkOjFdroweYQ7mO/9O+WymrfMBjb8lKjSIBgJH3/j3yJN/Y6lvwCMdS
	2lpLL2ZP7hnHmS8vHP80kTfIO9T+ZgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Te3Sd4D0PO62j8L3FVOFPQ-1; Mon, 19 Feb 2024 10:30:14 -0500
X-MC-Unique: Te3Sd4D0PO62j8L3FVOFPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A649A85A58C;
	Mon, 19 Feb 2024 15:30:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25202C08496;
	Mon, 19 Feb 2024 15:30:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mu0Dw7jVHFaz4cYCNjWj9RFa76pRTyQOEenDACHDgNfyg@mail.gmail.com>
References: <CAH2r5mu0Dw7jVHFaz4cYCNjWj9RFa76pRTyQOEenDACHDgNfyg@mail.gmail.com> <20240205225726.3104808-1-dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] netfs, cifs: Delegate high-level I/O to netfslib
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <187135.1708356611.1@warthog.procyon.org.uk>
Date: Mon, 19 Feb 2024 15:30:11 +0000
Message-ID: <187136.1708356611@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Steve French <smfrench@gmail.com> wrote:

> [  228.573783]  ? show_regs+0x6d/0x80
> [  228.573787]  ? die+0x37/0xa0
> [  228.573789]  ? do_trap+0xd4/0xf0
> [  228.573793]  ? do_error_trap+0x71/0xb0
> [  228.573795]  ? iov_iter_revert+0x114/0x120
> [  228.573798]  ? exc_invalid_op+0x52/0x80
> [  228.573801]  ? iov_iter_revert+0x114/0x120
> [  228.573803]  ? asm_exc_invalid_op+0x1b/0x20
> [  228.573808]  ? iov_iter_revert+0x114/0x120
> [  228.573813]  ? smb2_readv_callback+0x50f/0x5b0 [cifs]
> [  228.573874]  cifs_demultiplex_thread+0x46e/0xe40 [cifs]

I don't suppose you can tell me what line smb2_readv_callback+0x50f/0x5b0 is?

David


