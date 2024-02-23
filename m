Return-Path: <linux-kernel+bounces-78486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C987B861402
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6F91F23B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C40443D;
	Fri, 23 Feb 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL5Zb1Gb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797B4687
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698778; cv=none; b=gt82BR8ZZf+39G55nd0Lg7HIW2kbKRkY3SZeIVT/uNJFFvKuyE05BU4+JSnHvGxTv2dSL8iReYyFfa7Fh7NmDXHuJNlh7TpEKhBtmajOsWBKKDbmrtp+hqdJAjcQ+qU+W5jQg6OXI/vOj1t03zpiDxYhZoDfKuT0zVGwAUGOLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698778; c=relaxed/simple;
	bh=NpL+P1L+oOnKE5XgqX6Sj01kbse60LlSbZVt3Vk3hnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF6jqllLAkBIFNOep09WNOYdlebUj1iFy7FE+o+vEy6KSAJOnYMV4LKWTGuUziTrljCjdFSL/7ENPLIWBFaV7RTKImenqah+VO1ZC8qotiq4oHJofxB3RhzxUGhgpSn3Aq0lvBGngJey2xWYoNn53bm4NS8dCz9ldZSX9TgT+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RL5Zb1Gb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708698775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXimChZFYQZR/sMWqZ1etlf/rAL+dk4fPo4wWGRp+Sg=;
	b=RL5Zb1GbpPqUPMxhUoq4fmWwts/EUmmpHDFdukQ2gS+xPEK5azHsSUVDfxwR7WlwMYeu56
	gHbAaPrS7PHpAdIO4vZdPbKcMuUXSzPZPYKKYlt34kn5QNinTZmi4NmLl/Qr77ou5kZOT0
	O0u56XOKFfDL1cJD+vJ0B03jRZMcZFI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-Sf5Ek8fkOnSCI5XQlj9jiA-1; Fri,
 23 Feb 2024 09:32:52 -0500
X-MC-Unique: Sf5Ek8fkOnSCI5XQlj9jiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AD66280FEC2;
	Fri, 23 Feb 2024 14:32:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
	by smtp.corp.redhat.com (Postfix) with SMTP id C2414C185C0;
	Fri, 23 Feb 2024 14:32:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 23 Feb 2024 15:31:33 +0100 (CET)
Date: Fri, 23 Feb 2024 15:31:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_signal: simplify/cleanup the the usage of ksig->info
Message-ID: <20240223143131.GC8267@redhat.com>
References: <20240223105025.GA4542@redhat.com>
 <tencent_7C50F304C14CB2A5133317F8A13D1F544D0A@qq.com>
 <20240223141928.GB8267@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223141928.GB8267@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 02/23, Oleg Nesterov wrote:
>
> On 02/23, Wen Yang wrote:
> >
> >
> > On 2024/2/23 18:50, Oleg Nesterov wrote:
> > >+			/*
> > >+			 * implies do_group_exit(), no need to initialize
> > >+			 * ksig->info
> > >+			 */
> > >  			goto fatal;
> >
> > There is little question:
> > If the this conditions is met:
> >    current->flags & PF_USER_WORKER
> > It may execute “goto out“ instead of do_group_exit().
>
> Yes, but vhost/io workers do not use ksig at all.

Ah, wait...

I forgot about the ->sa_flags check before hide_si_addr_tag_bits().

OK, thanks... I'll send V2.

Oleg.


