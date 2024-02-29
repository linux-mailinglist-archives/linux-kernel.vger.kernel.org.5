Return-Path: <linux-kernel+bounces-86673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7486C8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281DB1C22117
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196C7CF2A;
	Thu, 29 Feb 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQyiAbXv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0517CF11
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208467; cv=none; b=lo4R2JgwTEeeZqOkFS2pfZs/adnX0X1g/w9sRlf0Q3VJsWchdkDy3wy9tYip5J8FlalFiWLkFPcrlYyFj5zeSW8ZztJ2dFDIbOFEnJLPmRzren/ht8bQiRfMimhVOHL4BWRc2n5KSFdJh4YPvbu9kia3LceEVGGc0tHsEImF80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208467; c=relaxed/simple;
	bh=HyuVlckc5Kl8c8OInENlmlezaCytk+CSvl2MIBYylYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF2anlzgWswXmNDGZ+05sExFJM7dyEaglJUZnnKR3eiZeXnqUKp47EjMXEpvqqKD3dNoy/Xumkqmqr8HIFw/21aFAiW4lJWA17jt2MQclotmfiRX0YlmY+SrRGwNvZwFYMPgn69nNqDGFkHX2qPrTllUcF5qB0CAsaVkPvqwTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQyiAbXv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709208464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+Xze/yxxajNWL1KhoG/Ul/vP6wDJGvmG9gREiC46JA=;
	b=SQyiAbXvva0MFOzZsGdFZ1+uPhZnynlnuY9YzU5NwJ/AF0fMTAAGXzxokm++voT1vzpTy2
	0r/Usc6A3+icabz9ifBSLRRev/K70pv/8lHKn9lhG1i54wp2xx6SPhFHUADbLs/2s0696l
	C9LrRG+Z0xlJk8HEhS8Jk6PbmvGDQhc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-N4lH7H4rMUC6jgPKjgmmBA-1; Thu,
 29 Feb 2024 07:07:40 -0500
X-MC-Unique: N4lH7H4rMUC6jgPKjgmmBA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 155863C100B0;
	Thu, 29 Feb 2024 12:07:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B63492BE2;
	Thu, 29 Feb 2024 12:07:38 +0000 (UTC)
Date: Thu, 29 Feb 2024 20:07:35 +0800
From: Baoquan He <bhe@redhat.com>
To: "Huang, Rulin" <rulin.huang@intel.com>
Cc: urezki@gmail.com, akpm@linux-foundation.org, colin.king@intel.com,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v6] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZeBzh/rVXwj0Yr8w@MiWiFi-R3L-srv>
References: <20240229082611.4104839-1-rulin.huang@intel.com>
 <aa8f0413-d055-4b49-bcd3-401e93e01c6d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8f0413-d055-4b49-bcd3-401e93e01c6d@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 02/29/24 at 04:31pm, Huang, Rulin wrote:
> Apologizes for the confusions the original format led to and thanks so
> much for your guidance which will surely enhance the efficiency when
> communicating with the kernel community.
> 
> We've submitted the v6 of the patch, which more rigorously checks
> va_flag with BUG_ON, and at the same time ensures the additional
> performance overhead is subtle. In this modification we also moved the
> position of the macros because the definition of VMAP_RAM should be
> placed before alloc_vmap_area().
> 
> Much appreciation from you and Uladzislau on the code refinement. And at
> the same time, we'd also respect the internal review comments and
> suggestions from Tim and Colin, without which this patch cannot be
> qualified to be sent out for your review. Although the current
> implementation has been much different from its first version, I'd still
> recommend properly recognizing their contributions with the "review-by"
> tag. Does it make sense?

Just checked Documentation/process/submitting-patches.rst, seems below
tags are more appropriate? Because the work you mentioned is your
internal cooperation and effort, may not be related to upstream patch
reviewing.

Co-developed-by: "Chen, Tim C" <tim.c.chen@intel.com>
Signed-off-by: "Chen, Tim C" <tim.c.chen@intel.com>
Co-developed-by: "King, Colin" <colin.king@intel.com>
Signed-off-by: "King, Colin" <colin.king@intel.com>


