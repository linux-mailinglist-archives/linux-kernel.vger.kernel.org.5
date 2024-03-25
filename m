Return-Path: <linux-kernel+bounces-118168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7ED88B560
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD871C3AEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2384D19;
	Mon, 25 Mar 2024 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyM0oNfO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01484A2B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409735; cv=none; b=T/i2dmtwcLtk7n/39dTqC7tG2aiDr0mD/H+dqJIUFmO8yA4s7vtdgffoRr268uFQRvrGGRnuWGzKcjBaBG+/tMR8OsQ6k06TLZXd0SSzjZXs4YB0jtK2VTnBbFLwXazZGUxO4cKvN/q+Xmsgz7qwEHZ2vJojQnrPaqmJ/9LbsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409735; c=relaxed/simple;
	bh=qZ/6tl0aBSu/LLJC+++VV+D9IA3CTJ9FB4a83c72k2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJI4J/deGZK3UCKS/BDiJxpvivqUFnythnw0Y0VoMTmdY4clNnpgTnsQHMZ2N/8crcSpByDI2WOp+XY2XQo6VVLTY//NF7EI5tZF4PSxBSl2RF7PueeF70+zMrVjQYrfPOxmq28/LPfAKOqdmQ2Ix0ptAxKIP/r6GKXFGzmS5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyM0oNfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711409732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsXpqf78rAM4i4+ZjUMsQiXhxVgsssODolYLYbs5cZ0=;
	b=eyM0oNfOnQ6AayG5E+Um15l4yrnAavsagt/gjVBbzxU/8qJPmZ5+ZsV9bGvTqBGBUmhPuI
	ZO1difrCS2Wn9RjDU2TjOkjUENL9btlypm0ub/JLUNzD8nsa5gfstcji5pnU2zbMSwNXkU
	S2gvpcvM/quEMy+tgIvgVGfbQi1TwyQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-wka9NgxKOCGU0mZ99BvNrQ-1; Mon,
 25 Mar 2024 19:35:25 -0400
X-MC-Unique: wka9NgxKOCGU0mZ99BvNrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ABED3C025B8;
	Mon, 25 Mar 2024 23:35:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D96FC3E620;
	Mon, 25 Mar 2024 23:35:22 +0000 (UTC)
Date: Tue, 26 Mar 2024 07:35:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	chenhuacai@loongson.cn, dyoung@redhat.com, jbohac@suse.cz,
	lihuafei1@huawei.com, chenhaixiang3@huawei.com
Subject: Re: [PATCH v2] crash: use macro to add crashk_res into iomem early
 for specific arch
Message-ID: <ZgIKNNZ8hc14FI8a@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv>
 <20240325132909.741ae47a8a05837c175a981e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325132909.741ae47a8a05837c175a981e@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 03/25/24 at 01:29pm, Andrew Morton wrote:
> On Mon, 25 Mar 2024 09:50:50 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > There are regression reports[1][2] that crashkernel region on x86_64 can't
> > be added into iomem tree sometime. This causes the later failure of kdump
> > loading.
> 
> So I think a cc:stable is needed.

Yeah, I forgot this.

> 
> > This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
> > crashkernel resources") was merged.
> > 
> > Even though, these reported issues are proved to be related to other
> > component, they are just exposed after above commmit applied, I still
> > would like to keep crashk_res and crashk_low_res being added into iomem
> > early as before because the early adding has been always there on x86_64
> > and working very well. For safety of kdump, Let's change it back.
> 
> I'll use 4a693ce65b18 as the Fixes: target, since there is no
> "Exposed-by-non-buggy-patch:" tag.  To tell the -stable tree
> maintainers how far back in history this should be backported.

Thanks a lot.


