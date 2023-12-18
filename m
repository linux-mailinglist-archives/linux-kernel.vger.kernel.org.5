Return-Path: <linux-kernel+bounces-3769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD38170BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92728345F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D01D122;
	Mon, 18 Dec 2023 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAiaqNnm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7911185
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702907133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ixXR3XKTH39hKKYBoKlldaXP+hnNl1nKybCK1Edi+M=;
	b=SAiaqNnmKlUCIdzeHzpnaEJlcETnsapzVS0/1eJrbelLEvmXr0pK5WbMklOS3zg3TN+rhc
	LfDRCI0LJSj/F5QbURo4ow2nzQcpTGXjNtxEVjZn9NkbCEblvYPunWg0Ht+6G2hk7DGLYP
	Qnpg/rvr+GM376vwX8KuahIW77n3w0s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-D2zy3ttpM2yrOdXBVjGhbg-1; Mon,
 18 Dec 2023 08:45:30 -0500
X-MC-Unique: D2zy3ttpM2yrOdXBVjGhbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAFDA1C3B641;
	Mon, 18 Dec 2023 13:45:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73714C159B0;
	Mon, 18 Dec 2023 13:45:27 +0000 (UTC)
Date: Mon, 18 Dec 2023 21:45:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 0/2] crash: fix potential cmem->ranges array overflow
Message-ID: <ZYBM9MG1rjCDPykI@MiWiFi-R3L-srv>
References: <20231218081915.24120-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218081915.24120-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Yuntao,

On 12/18/23 at 04:19pm, Yuntao Wang wrote:
> This series tries to fix the potential cmem->ranges array overflow.

This series looks good to me. While you'd better talk to fuqiang to ask
if he wants to post these or wants to give up. He posted patch to raise
the potention issue and I suggested him to do these during the
discussion. Without consulting him for opinion to take over a discussing
work, it's not suggested, I would say.

https://lore.kernel.org/all/ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv/T/#u

> 
> Yuntao Wang (2):
>   x86/crash: fix potential cmem->ranges array overflow
>   crash_core: fix out-of-bounds access check in
>     crash_exclude_mem_range()
> 
>  arch/x86/kernel/crash.c | 9 +++++----
>  kernel/crash_core.c     | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> -- 
> 2.43.0
> 


