Return-Path: <linux-kernel+bounces-155265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9898AE7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F6828D88D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D313541B;
	Tue, 23 Apr 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aEd8+rWo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2F131181
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878277; cv=none; b=YAEmWxEdBnRLz3RfGW3/UxFFvnnac2Y85ubcVNjfBkmUa0CG/IHBtO974Y0z+ZhS7AC+FhmxGtdjxww2S7y6Mpl3pCLREq+FBvS7oPIvz6xseiGLyjGXNVmC/AZx8/lpsCv/iIaNok0xQjXaE6p+I6SQZP+aULi6QQ/ii4B+A2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878277; c=relaxed/simple;
	bh=vAtz/vyrLrp9HhPoiwe05xG1Si8bMFGcN2vusmFCvp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBMV6zFXXnyUkaZpgEuRn2V31zxjuP/FxwZwA1F2Ag/Vn+6Y0R0Ziih1rRLBkIIc4UPm0XcsLo05vGStl/+QUX+8pKjaF+ZqiENkfxIbJHyphXtR6yjS3Ts79htbHbt7AB1NXqHYufdzwSwlYIYTWo3ert1i/gjbSGFjjNbCFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aEd8+rWo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7476E40E0249;
	Tue, 23 Apr 2024 13:17:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZmmPyGl0kbM1; Tue, 23 Apr 2024 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713878268; bh=bGv9rvNJpD/Du1WCJOGw7wL73HyEy9ZaslIxxlYF+L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEd8+rWoBs1tm/jlNDLyHiPCgDXZIYMDCzd59OM6O9E3NsADxYrDxSXD7Gn98Dfcb
	 XqBNHMns7F0jCVwlNXPZSxs1W3h6CWNzEzdPitMGbLggU2c3kc/QoJBdKs4SIZOsw6
	 B1F6YlJuPEhgeqURMgzNaI25MnI0wrSn7U+3iIuIxKLAHeGBzHO2mNTfpxE3o/mBOQ
	 uNt0VodVP1wLaANb6Yhdeyh/JlibaJyagFJ/EH1w0zOJ8wyTZZiTBBivSb2ad0/upD
	 qvBbqZLI5tqGDo1+9gVhDhfG5q6jHa0GMye1l70kWqLkTbj5Lcw3Pa5VNlUi+UziQM
	 c4eHwxOFiX9GyIJ8AlbkjXCAkBuceg9fFFv75OPJEHNZtfbx7HuUTIRnQ8axRe03+Y
	 DmI5QzC/V6YTixrwTzDyK0twmRx+0xKZbXYK7BdLKi9qLqYcJ3Hj0DpIttttObKj1a
	 rhKl6s/LcVdujmQAKnlkfW2IlSm3AHBP6v/s/q1FnB06uPQKd9fwvLKHbWLqEfSfu3
	 hbdNvUEm5FHycGeSK6QBM+Z3glqFBCMxTA3H0kmTPT20WFEeceXQEcaA0wYHZtkpJy
	 9BFfWVol1wINcVUC7lRP7Wc88AEjkPSMizpHXgWcbJJnYD+cY9P+eep/SO1/MQ8Uwr
	 kxr+RwxTI/5xscJgUhKSi2JM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B8AA40E0177;
	Tue, 23 Apr 2024 13:17:27 +0000 (UTC)
Date: Tue, 23 Apr 2024 15:17:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 03/18] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Message-ID: <20240423131722.GIZie04oK5g5f8Jftr@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-4-kirill.shutemov@linux.intel.com>
 <20240418143709.GJZiEwFejGQY3jiwsp@fat_crate.local>
 <rju6u37prtr5nf4upcntcy4jcnul6atqmbh6impzqdn3dlo2pj@lqodxa7elohz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rju6u37prtr5nf4upcntcy4jcnul6atqmbh6impzqdn3dlo2pj@lqodxa7elohz>

On Fri, Apr 19, 2024 at 04:31:39PM +0300, Kirill A. Shutemov wrote:
> Yes, it is one-off. I guess we could use READ_ONCE()/WRITE_ONCE() to
> access the variable with the same result. I am not sure why it would be
> better.

Nah, and it is not even the first one-off:

cpu_hotplug_disable/_enable() uses the same locking to update
cpu_hotplug_disabled.

I guess we need to update the comment over cpu_maps_update_begin().

I guess this is fine wrt big picture of the CPU hotplug universe. Lemme
point tglx to it just in case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

