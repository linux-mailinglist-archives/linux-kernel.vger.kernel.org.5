Return-Path: <linux-kernel+bounces-89948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D586F7E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99C81F2115D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B37AE78;
	Sun,  3 Mar 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjXrdn9h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F26CBEE
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709510332; cv=none; b=B+RZZk0kE4q/XFhw24EGmqtV6mvASwxGrIV2pibPsObkPxX0Vq36euu1wrQKud3b0pKslE/oZ5A5pD/Rm48IC5c8ol/FRfdryMuuVldWif+EvQ0GnqNH1C790bzFAv++sdLO966azRrenKs+SgXH5t24MTmsfbfHCOAzoZNxr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709510332; c=relaxed/simple;
	bh=cwctMdDhD+OxpkY3W3eOMu3a/HHSUXCkGV7ETxSV2Rk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=WxGvg7I88nKDk2zr0dvg5+khweiN5PVQoBAsEczNpWhghQS2Dj08/W3JV/nU58JQlaVz6z4APkFQ+n8rIYcDNxaJGK4C+XcUkJFikyy7Mlv6M2t7rF9Y6a2cPoIpcZtNfmZ2BgA5P9nTxItfXUZrmFCW29c3HbSCQ7bbEXNeIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjXrdn9h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709510329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwgUwvTK5RnZGZzgBHSNiIrA39adWZ0Q9OWuqtSLT0g=;
	b=CjXrdn9hRyv7jrpyK2SkK4lsRqXRMl6eBsSF9gqRD9ocNbXiX/mtqiYTGHJvZKx4DomIKy
	uIUUZwDSt8FXJOEcYotQbXYNdmIKj6TlqG1+011V6yYZTeBhs8x7JCXf8321kIycIDeUTC
	DmiQKUpnz+o5oNOMikm86lHQnDSfDLw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-rp5AFWSJO8OaHZWYVEpo-Q-1; Sun, 03 Mar 2024 18:58:48 -0500
X-MC-Unique: rp5AFWSJO8OaHZWYVEpo-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 887A7811E81;
	Sun,  3 Mar 2024 23:58:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 674EB40C6EBA;
	Sun,  3 Mar 2024 23:58:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240302212702.15b04552@kernel.org>
References: <20240302212702.15b04552@kernel.org> <20240301163807.385573-1-dhowells@redhat.com> <20240301163807.385573-19-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 18/21] rxrpc: Use ktimes for call timeout tracking and set the timer lazily
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <645801.1709510325.1@warthog.procyon.org.uk>
Date: Sun, 03 Mar 2024 23:58:45 +0000
Message-ID: <645802.1709510325@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Jakub Kicinski <kuba@kernel.org> wrote:

> > Track the call timeouts as ktimes rather than jiffies as the latter's
> > granularity is too high and only set the timer at the end of the event
> > handling function.
> 
> This one has a 64b div somewhere, breaks 32b builds.

Ah - in the trace functions to make the ns-level durations into ms-level ones.

I wonder if it's better to just divide by 1024 - so something close to
microseconds - or whether ktime_to_us() can be used there.

David


