Return-Path: <linux-kernel+bounces-71126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F485A0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5321C21B16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EEA28DCA;
	Mon, 19 Feb 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0qMrdQn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9125635
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338503; cv=none; b=HP67kJy0zjcpYQQ0+OaHzop0Kmap2cngsVp3bL4K8LC/U5XXcR30luE8w6OGdbG2KyB6N4i1NLHQImQ51CKDi5WqsVPDYUbn6BWM23p8/m5GO0CB34BEAyzGPVf6GKag6AnwdQpQR5XT8rbavmEwLKq97OjcXfwjsT33XfooB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338503; c=relaxed/simple;
	bh=nrAOxfXXPEWEvtWtLVExSs6J/pgiKbFC6fD39ZPxJ3U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=LJOtIVYbv2tcoxtNdNPgaXdEQa0uw4i7xThPOPVlCHIiXB4IVF81IQKQYtDkdiz1Znky2hiTEVsUC1fhOshdtDu/MVp7VfBNXvztlkrCaF8kfuvLNMvHWOnExioN3t/yH7gRTOLQ0x5xOTEblTHOV6i3vs4EdddQXnWoUW27zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0qMrdQn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708338500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFH4uSAgZBDlHo8RZhDoV0Zwh8MUzvUtZvaQhQoOVk0=;
	b=b0qMrdQnJNlCI8WxAJ5XJ3TRB5bQJM6/OO3jC/vfuiKOHv+DCyg8xRUK4QxCAjnmuv1bG4
	nnWhuE7xYUvOhHhdhLkflNWHSY7d0ygNSC+BXe8H61F7ReHZupJEmVvN4rT5uPmzNA9vQt
	18CCRiMb4s9VzouxnBsYmq6Mnh9N0ro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-gExweLWqNiS8dUe1kSvbAQ-1; Mon, 19 Feb 2024 05:28:15 -0500
X-MC-Unique: gExweLWqNiS8dUe1kSvbAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7344583B9C9;
	Mon, 19 Feb 2024 10:28:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DCCB40CD14A;
	Mon, 19 Feb 2024 10:28:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240212083347.10742-1-d.dulov@aladdin.ru>
References: <20240212083347.10742-1-d.dulov@aladdin.ru>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: dhowells@redhat.com, Jeffrey E Altman <jaltman@auristor.com>,
    linux-afs@lists.infradead.org,
    Marc Dionne <marc.dionne@auristor.com>, linux-kernel@vger.kernel.org,
    lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] afs: Increase buffer size in afs_update_volume_status()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <123872.1708338493.1@warthog.procyon.org.uk>
Date: Mon, 19 Feb 2024 10:28:13 +0000
Message-ID: <123873.1708338493@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Daniil Dulov <d.dulov@aladdin.ru> wrote:

> The max length of volume->vid value is 20 characters.
> So increase idbuf[] size up to 20 to avoid overflow.

Is that 20 including the NUL?  If not, I'd increase it to 24 (it's likely to
get rounded up to a multiple of 4 or 8 by the compiler).

David


