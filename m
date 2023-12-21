Return-Path: <linux-kernel+bounces-7833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AE81ADEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ADD1C2200F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04879E0;
	Thu, 21 Dec 2023 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJyFJ2i5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415D7481
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703132682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhkevBRKRAIXA24fCJp1C71d7JyUUhFCr+p5mrM6R0s=;
	b=BJyFJ2i5vSMOm66FOLRDcRN9j8GAE6TpsNARwFnAreP3DB2vUy6WCk1ZHS7z4OmxNJc6q1
	6vXUMKRmrpQ5GOqzx7zpXw/+KWntLicPlM0kd5Vc+Yc51DN7cmKWPSB28M+i5u82NdikUQ
	AV4R0XJF79kiuCtq5I+gasu8q/naZ8Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-O5_yBCcsMgqWoLnAiNkmRg-1; Wed,
 20 Dec 2023 23:24:38 -0500
X-MC-Unique: O5_yBCcsMgqWoLnAiNkmRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 535C038562CA;
	Thu, 21 Dec 2023 04:24:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A42140C6EB9;
	Thu, 21 Dec 2023 04:24:36 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:24:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for
 opcode
Message-ID: <ZYO9/D0In7T/3mqj@MiWiFi-R3L-srv>
References: <202312182200.Ka7MzifQ-lkp@intel.com>
 <ZYJ/M1HZ9ITfs4qe@MiWiFi-R3L-srv>
 <20231220060030.GV1674809@ZenIV>
 <ZYLrxFyei79R5D8N@MiWiFi-R3L-srv>
 <20231220173710.GX1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220173710.GX1674809@ZenIV>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 12/20/23 at 05:37pm, Al Viro wrote:
> On Wed, Dec 20, 2023 at 09:27:32PM +0800, Baoquan He wrote:
> > Since the kexec_core code building depends on CONFIG_MMU=y, we may
> > need to add dependency on MMU for ARCH_SUPPORTS_CRASH_DUMP. I made below
> > change, do you think it's OK?
> > 
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index 7500521b2b98..fe1500871648 100644 > > --- a/arch/sh/Kconfig > > +++ b/arch/sh/Kconfig
> > @@ -548,6 +548,7 @@ config ARCH_SUPPORTS_KEXEC
> >  
> >  config ARCH_SUPPORTS_CRASH_DUMP
> >         def_bool BROKEN_ON_SMP
> > +       depends on MMU
> >  
> >  config ARCH_SUPPORTS_KEXEC_JUMP
> >         def_bool y
> > 
> 
> I'm *not* familiar with crashdump or kexec machinery, let alone the
> current changes in there, so take the following with a cartload of
> salt, but...  does sh crash dump support depend upon the code in
> question?  From quick grep it looks like we only want it in machine_kexec(),
> so the conditionals used in the commit in question might be wrong...

Hmm, I checked commit d70c27b728b8da1 ("sh, kexec: fix the incorrect
ifdeffery and dependency of CONFIG_KEXEC") again, those ifdeffery of
CONFIG_KEXEC_CORE should be changed to CONFIG_CRASH_CORE because those
embraced codes are crash_core related codes.

machine_kexec() is needed by kexec reboot and crash dumping. We either
enable CONFIG_KEXEC_CORE, CONFIG_KEXEC or CONFIG_KEXEC_FILE only for
kexec reboot, or enable CONFIG_KEXEC_CORE, CONFIG_KEXEC or CONFIG_KEXEC_FILE
and CONFIG_CRASH_CORE, CONFIG_CRASH_DUMP to support kexec reboot and
crash dumping. Seems KEXEC_CORE codes can be built not relying on
CRASH_CORE, while CRASH_CORE need be built relying on KEXEC_CORE,
otherwise it doesn't make sense.

Anyway, I will try to clean up the ifdeffery so that they looks clearer.


