Return-Path: <linux-kernel+bounces-38971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D083C934
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9EF1F23302
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49C6EB56;
	Thu, 25 Jan 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZv/7Dfs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47B14198C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201688; cv=none; b=ssDJouaKs0fLLtNnKlff7JEYaYue4EV2S3qHUN0uZRTFNn9soyJDKL7OTQs6+RoviQ2uQOw5OMUIkkjXTNylugA+xN/Y52G/neu5CvK1IFRn7bXqle5VdjV3jCSmeldIyPyYGsN3o6NdXb2CWew52pjP7k8JeRqavyECRjWUDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201688; c=relaxed/simple;
	bh=bTw3xnvdxWsNgprAzZ6pGEBMLXptMHG6Eh0DLlyGTQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAmWIf+aUGYzLdyygZ/c8a0uzH8RGbHOGcJN//cMIqbzyi49T5tYPjlP2KBPqEBPNdBn0yqVtKmXIDq9GmjHhp2oAYVEsxnAQxdpLr5eHpgpYMQViXP15TiJR4JmHgkTBEmnEsMR77zYhw/MOH/+ud27WWWBA3u2c7BAcSZUZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZv/7Dfs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706201681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bTw3xnvdxWsNgprAzZ6pGEBMLXptMHG6Eh0DLlyGTQ8=;
	b=EZv/7DfsiE9HzyU67ouQ+bmOw7i0GFYo6M8pkJyjFO1yn1fTr94UvnvrG1IEDqKOep6cec
	Gx0z2ia1U41BtVk72EHoTwWOi6DGMPOmneNMM22RFtwAGHymIOzxKA14n8hwmzZFRRSG6h
	2QbgFHKx9u9vQCGSDwpomz5KbAb+78o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-092Ua8X4PCWbceF3leTybA-1; Thu,
 25 Jan 2024 11:54:38 -0500
X-MC-Unique: 092Ua8X4PCWbceF3leTybA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7791C1C0F473;
	Thu, 25 Jan 2024 16:54:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id CAA791C060AF;
	Thu, 25 Jan 2024 16:54:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jan 2024 17:53:25 +0100 (CET)
Date: Thu, 25 Jan 2024 17:53:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pidfd: cleanup the usage of __pidfd_prepare's flags
Message-ID: <20240125165322.GB5513@redhat.com>
References: <20240125161734.GA778@redhat.com>
 <20240125-kilometer-erwischen-9077030e4326@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-kilometer-erwischen-9077030e4326@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 01/25, Christian Brauner wrote:
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.

OK, thanks.

This can also simplify the possible PIDFD_THREAD change we discuss.

Oleg.


