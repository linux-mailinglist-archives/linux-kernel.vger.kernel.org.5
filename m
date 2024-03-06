Return-Path: <linux-kernel+bounces-93304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6E872DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089A928246E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9A14F7F;
	Wed,  6 Mar 2024 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6QP/SNX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17514280
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709697736; cv=none; b=cJ3ZDCYBoyEyX/cPWDuOOECyURhd05qwwfS0wIoGQfsoSOrNnxQxf8X2B5bxOKv4AugQj/D08qaOkpFFzTIddXdgtthXSgIH1r2zKE1b4N0eYPAOTvVOf7mf+Yb0whR1qSoNcF/m7jWv+AOB1Q1o2DBS6sMAGXTYzz20F75tHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709697736; c=relaxed/simple;
	bh=IkeS0qz8On//7zxjMJn8fjQS0QG+k84h+puwpBDgnws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzJ6Ie97Z/Y1Jp0uvC8tmXKa+9E5CRCjOiXXqy5FdM2vwoDNiUw3ti1kOaDFzqRdglUTeTFW/0VDnwJhDg7W2NqDbHU4WM/7sunkRaxBGeTBbdp5UBrO0NmZoRNF5l6a4GfU6LC/N/t8jwfcy6tUJQBofcvPHGHAnq5DuZcx7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6QP/SNX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709697733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a6DcM4R3G0ghwK0zbLjepuk2gThHtYRoJ4TK1508xg=;
	b=c6QP/SNXl6REcnhv+zmEqjEPJ7xgJ1T8svVLQZ/Q/mKFkLg3dACXjoHVQ34OrZnvYcyWvh
	/y9YfEr9R9xYGUWSgdfluO8FUaBorrWex55IRLG+Jz6c0oVAek24QOe3vTtC9++nv/3IMC
	CzeZxWPBgUxHlbT3yfy6lq//zqrecBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-F5wESZsBMOSfOQE5au4EAQ-1; Tue, 05 Mar 2024 23:02:11 -0500
X-MC-Unique: F5wESZsBMOSfOQE5au4EAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18DCE811E81;
	Wed,  6 Mar 2024 04:02:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0C4240C6CB5;
	Wed,  6 Mar 2024 04:02:09 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:02:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	dyoung@redhat.com
Subject: Re: [RFC PATCH 1/2] Revert "x86/kexec/64: Prevent kexec from 5-level
 paging to a 4-level only kernel"
Message-ID: <ZefquYIOFlCULYI/@MiWiFi-R3L-srv>
References: <20240301185618.19663-1-bp@alien8.de>
 <20240301185618.19663-2-bp@alien8.de>
 <ZeWnrhzU86pz7y5Z@MiWiFi-R3L-srv>
 <20240304111127.GAZeWsX3gBabiwrrVV@fat_crate.local>
 <ZeaUxXbZ3MB/pXm5@MiWiFi-R3L-srv>
 <20240305115533.GBZecINWGlb73W0nQS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305115533.GBZecINWGlb73W0nQS@fat_crate.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 03/05/24 at 12:55pm, Borislav Petkov wrote:
> On Tue, Mar 05, 2024 at 11:43:01AM +0800, Baoquan He wrote:
.....
> 
> > If we take off the checking, and people want to jump from the new kernel
> > to an old kernel where 5-level kernel code haven't been added or
> > CONFIG_X86_5LEVEL is unset on purpose, it won't fail and prompt message at
> > all until 2nd kernel booting silently failed. E.g, the coming RHEL10 anchor
> > a upstream kernel w/o the flag checking, people want to kexec/kdump jump
> > from rhel10 to an old rhel7 kernel. It could be an extreme case, while
> > revealing the scenario.
> 
> That is the only valid reason you've given until now. Yes, that makes
> sense - the removal of those flags should go together with the removal
> of CONFIG_X86_5LEVEL and making this feature unconditional.

Please forgive my awful expression.

> 
> Because, practically, that config item is enabled on every relevant
> x86 kernel config out there. It would be silly if not.

I agree. Thanks for looking into this.


