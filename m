Return-Path: <linux-kernel+bounces-164195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C28B7A84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D4D1C22C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A317770EF;
	Tue, 30 Apr 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4vmMJWm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A731527A4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488474; cv=none; b=IoEowdd+5sNiJ++pP8qiXNMfwYbYZHUdHtzRYhUpj9fX3NMshB+J153D8sDPE+BHX8+Potx2jTWxYLXJgRpC6EtDn3r9iGuXwYK43qcI02ETTY3kP/HsGBfHTPLoOKFH+rgHq6j6d5eY3crhrkR454LoBoceyqPTKKm4zUhwh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488474; c=relaxed/simple;
	bh=17/ige2G0/bT+taZDR8dyDbj8f4gwH5Ssbdw0+0wOUY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=q2wt89AtQlWESv8fTWKlDIKS5IVU1VfkRuvkC/FX3lvdnjsMn0mcqcljtiXkS2Y4HT76emhHjMq0cnJyb/iRr7AjdY3DDT9J8tEUAGScrdLqvFPTcDH7AJrUSLfWmCSm2w8Pc/Ih6Rl2JrtpRia+j6J0d9qKq5pWYIb2rXD7mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4vmMJWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714488472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17/ige2G0/bT+taZDR8dyDbj8f4gwH5Ssbdw0+0wOUY=;
	b=T4vmMJWmMrOUEb9MQ9WJT0vXRaDlQLa1nlm+MMh419fhu31IcLndIfL93ReQdx1SbEXQXF
	ZUv6pFL3/104lvA3r4nePku1YqktpUQ949MrH4ORoc+BKSjSmNC4AuR4GWaSS4/tmuc2vb
	sQtTUupEqEyPx/6L2TPSeGbt9h+7Ve8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-Yqhjr50rP_uciVJPbKQlhw-1; Tue,
 30 Apr 2024 10:47:46 -0400
X-MC-Unique: Yqhjr50rP_uciVJPbKQlhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7E0229AC014;
	Tue, 30 Apr 2024 14:47:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46C461121312;
	Tue, 30 Apr 2024 14:47:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240430140930.262762-1-dhowells@redhat.com>
References: <20240430140930.262762-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/16] netfs, cifs: Delegate high-level I/O to netfslib
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <264959.1714488463.1@warthog.procyon.org.uk>
Date: Tue, 30 Apr 2024 15:47:43 +0100
Message-ID: <264960.1714488463@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Christian,

With Steve's agreement, could you pick this set of patches up also?

Thanks,
David


