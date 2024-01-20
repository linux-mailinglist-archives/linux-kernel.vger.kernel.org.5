Return-Path: <linux-kernel+bounces-31693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25883328E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB49E1F2294B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409C10E1;
	Sat, 20 Jan 2024 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZ09yivC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B958EBC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719834; cv=none; b=dO90VzTweLtlhmtezuXQNiFOvuOF/qaBBo2S8GngLcML1QyJA3eCgXIs1Tb6d+9a4ovOJrAgYVLwHwC4PvaoRGl8+jJlKkI/gklcv9SXCX/iabr+QRDPS5K1NqKu/OhTiUuqJTC9NI9P8qnkKg/H1AvlO/SfgyRVNu70pNOBqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719834; c=relaxed/simple;
	bh=YIF0KoiBNvuYIVD9snwLfREDKSNSJzQ8k5c9fKM2oaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm9w/zwZuMKHMHqlDgPEFhgtr2x0CREgKEHgNmeE6amnF6kefVRghN+FeG6BTWhjEllfkp1oPXPKZa8bSOFXXMO7dz7CQUXmN5mey72lMeWTk+ciq0MCSad1RUGj9f+UI8VdgI5fzIh4WwQqJ12s3rV+88J0IbmeGC5Z2iH2iNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZ09yivC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705719832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIF0KoiBNvuYIVD9snwLfREDKSNSJzQ8k5c9fKM2oaQ=;
	b=XZ09yivCcxU1S9f2yhwiOb+BqwQKEgxKO4HdLf2fuJ+aTkH23aRYJjBQAUsxI7f+l1jgbu
	HmIS4KlMPn57uTmXL29CdTR8hM3r5Pzy1pJcaniMaqLcq/MBami+Qf+nVWuBzCi+V5w+f/
	xy8b/2lcKwURvNp9alJk4xnG0V7ITbI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-cIr3tsP0P_Cw3AQmS9TEVQ-1; Fri,
 19 Jan 2024 22:03:46 -0500
X-MC-Unique: cIr3tsP0P_Cw3AQmS9TEVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C36963C0C4BA;
	Sat, 20 Jan 2024 03:03:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3896F1C05E0E;
	Sat, 20 Jan 2024 03:03:40 +0000 (UTC)
Date: Sat, 20 Jan 2024 11:03:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 1/9] cpumask: introduce for_each_cpu_and_from()
Message-ID: <Zas4CeVG6mlfiUM9@fedora>
References: <20240120025053.684838-1-yury.norov@gmail.com>
 <20240120025053.684838-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120025053.684838-2-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Fri, Jan 19, 2024 at 06:50:45PM -0800, Yury Norov wrote:
> Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
> which is handy when it's needed to traverse 2 cpumasks or bitmaps,
> starting from a given position.

The new helper is useless, see

https://lore.kernel.org/lkml/ZZNgDb6bzOscrNmk@fedora/


Thanks,
Ming


