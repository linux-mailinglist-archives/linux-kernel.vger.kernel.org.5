Return-Path: <linux-kernel+bounces-13385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05CE82044A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4AA1F21757
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13CA23C4;
	Sat, 30 Dec 2023 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLbnTDNc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D5210A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703931405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ah+0r8YHHWoN4cbO1+eIvu2p9Fc5rhLuP9mStoN/2M=;
	b=hLbnTDNcSQolOZ7Ls+ZKd5vsbZrrVUXQVElr9ke6M/4mrgLaL22adPOFLMjhhDMMFgZsar
	Qq48Ml061BXDGiZPdZwxTbMr35+NGrFBkYDAL0vR0W3OUvLJu4hA6/6Zxs96wS0HO/HYoh
	smS7q4xeLOSO+wdRyqzFWrzV/rpnqnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-pItFQRRhNh-h7l-uP85TvQ-1; Sat, 30 Dec 2023 05:16:41 -0500
X-MC-Unique: pItFQRRhNh-h7l-uP85TvQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C169583F265;
	Sat, 30 Dec 2023 10:16:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.216])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 96676492BC8;
	Sat, 30 Dec 2023 10:16:39 +0000 (UTC)
Date: Sat, 30 Dec 2023 18:16:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yuntao Wang <ytcoode@gmail.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, dyoung@redhat.com,
	eric.devolder@oracle.com, hbathini@linux.ibm.com, hpa@zytor.com,
	kexec@lists.infradead.org, lijiang@redhat.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, seanjc@google.com,
	sourabhjain@linux.ibm.com, tglx@linutronix.de, tiwai@suse.de,
	vgoyal@redhat.com, x86@kernel.org
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of
 crash_exclude_mem_range()
Message-ID: <ZY/uBJmpG14Ogvet@MiWiFi-R3L-srv>
References: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
 <20231216015410.188924-1-ytcoode@gmail.com>
 <ZX0Z+IyaAX9lNSok@MiWiFi-R3L-srv>
 <20231229121052.cac37914c7a051b829fcf933@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229121052.cac37914c7a051b829fcf933@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 12/29/23 at 12:10pm, Andrew Morton wrote:
> On Sat, 16 Dec 2023 11:31:04 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > > > Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> > > > Then after excluding the 256M from a region, it should stop. But now, this patch
> > > > will make it continue scanning. Not sure if it's all in my mind.
> > > 
> > > Hi Baoquan,
> > > 
> > > Thank you for such a detailed reply. Now I finally understand why the code is
> > > written this way.
> > > 
> > > However, if we can guarantee its correctness, wouldn't it be better to use the
> > > generic region removing logic? At least it is more concise and clear, and other
> > > people reading this code for the first time wouldn't get confused like me.
> > > 
> > > As for your concern about the while loop, I think it wouldn't affect performance
> > > much because the total number of loops is small.
> > 
> > Well, see below kexec-tools commit, you wouldn't say that. And when you
> > understand the code, you will feel a little uncomfortable about the
> > sustaining useless scanning. At least, we should stop scanning after
> > needed exluding is done.
> > 
> > Or, we may need add a generic region removing function so that it
> > can be shared, e.g e820 memory region removing, memblock region removing.
> > Otherwise, I can't see why a specific region excluding need a generic 
> > region removing function.
> 
> So where do we now stand on this patchset?

The patch 1 and 2 are good clean up. The patch 3 plus below one, the
entire is a good code improvement patch.

[PATCH] crash_core: optimize crash_exclude_mem_range()
https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u


