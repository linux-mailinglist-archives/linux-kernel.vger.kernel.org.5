Return-Path: <linux-kernel+bounces-13222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F41820156
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588B81C21847
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D56814009;
	Fri, 29 Dec 2023 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nzFmDpWG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256C13FEB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4392C433C7;
	Fri, 29 Dec 2023 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703880653;
	bh=ksTPppqdxWZLxFaIlmOFBvh791nfVHs/hnZ5LHsvKgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzFmDpWGBy32NNB5e6/szEtdk8t6tD67Aywe9CKdPd/I0aZcic+y0wv4CshY+sCth
	 NnR3VXemkhBFYeoMM9SurCyiA/RpP8WzE2GVWfZDnNqIi3DIltKX60wWEfJ26UdCXk
	 9S+vKwaTFvNjiw9ZUU7MAkXTtVoQDWGW11yJ4siw=
Date: Fri, 29 Dec 2023 12:10:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Yuntao Wang <ytcoode@gmail.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, dyoung@redhat.com, eric.devolder@oracle.com,
 hbathini@linux.ibm.com, hpa@zytor.com, kexec@lists.infradead.org,
 lijiang@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 seanjc@google.com, sourabhjain@linux.ibm.com, tglx@linutronix.de,
 tiwai@suse.de, vgoyal@redhat.com, x86@kernel.org
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of
 crash_exclude_mem_range()
Message-Id: <20231229121052.cac37914c7a051b829fcf933@linux-foundation.org>
In-Reply-To: <ZX0Z+IyaAX9lNSok@MiWiFi-R3L-srv>
References: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
	<20231216015410.188924-1-ytcoode@gmail.com>
	<ZX0Z+IyaAX9lNSok@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 11:31:04 +0800 Baoquan He <bhe@redhat.com> wrote:

> > > Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> > > Then after excluding the 256M from a region, it should stop. But now, this patch
> > > will make it continue scanning. Not sure if it's all in my mind.
> > 
> > Hi Baoquan,
> > 
> > Thank you for such a detailed reply. Now I finally understand why the code is
> > written this way.
> > 
> > However, if we can guarantee its correctness, wouldn't it be better to use the
> > generic region removing logic? At least it is more concise and clear, and other
> > people reading this code for the first time wouldn't get confused like me.
> > 
> > As for your concern about the while loop, I think it wouldn't affect performance
> > much because the total number of loops is small.
> 
> Well, see below kexec-tools commit, you wouldn't say that. And when you
> understand the code, you will feel a little uncomfortable about the
> sustaining useless scanning. At least, we should stop scanning after
> needed exluding is done.
> 
> Or, we may need add a generic region removing function so that it
> can be shared, e.g e820 memory region removing, memblock region removing.
> Otherwise, I can't see why a specific region excluding need a generic 
> region removing function.

So where do we now stand on this patchset?

Thanks.

