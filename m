Return-Path: <linux-kernel+bounces-66024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BA4855584
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAA828E18F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF91419A1;
	Wed, 14 Feb 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dSKwAtTO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D614198B;
	Wed, 14 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948317; cv=none; b=m5c+b39zk+xQPfD3ws3Cb88fhgwKiCDQV8hTqCeJ28jZmO1VUcCIJ9t9r3+lFAOlCHwSho1z/gxnIaeVtICOFM/dFJM+HcNhbxqbrf+Zolzj7ZJvjSKCNX5BSnU9806ElRuf/znBdqVkjrHAWJlysgwmbMUTqIVpnoiAru42uCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948317; c=relaxed/simple;
	bh=ZIl3wONdo0qB2PDX1x0SKAlCCbObW5oOqEZc1e26ByA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzSDZqRifHahQQoFON1X/LQh6Py+Ij8+1ynYRWL7XYNy87xkbkQ7KatSZjxwGMdpr/g6Pp8oTMhtKcsQVQA7rA749StvFVq18vj9pQia8tGzZA4bRTLTp5JfDwsisGbHJwFXnK4VN4S94zJSq7ABc8R0ImjqLqzmAnIMGXCeTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dSKwAtTO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qAKUDeW0LEVwbb4w3hOa+dlzg/8g1ktkJMoQSH9sovg=; b=dSKwAtTOV8p3D4tf9hr/kB/Hbm
	jhAg5W6UaCWEZHOOJcYwrRKHTYKMvJONuGNW+xG13My2ITjdnLc7eSg/sIVUYaH9R3QIWjXsIIbFl
	sXyWXfoGUIFwHHTMIgGcEY6GX1wWYeHZhOQyDG9Cgv+JECrFssEY0kq/atS39lbNb3F9Zp4Md3350
	rYlZC6xiN6YIMLjXK7BWoJNAQPJZJHwFrezKMdQ/W7IDH4q4CCmXb9ohgPypU041KMPF9zP5dIfjF
	a9HJa1T1Cp5ZbTwfzTRT6X0MZibTKhWFmMLqwp4lO6lE6fH/54EFNlW6H3B8RzEvsdf3y4HSEjL1A
	18yqPfog==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNNP-000000007cK-01wF;
	Wed, 14 Feb 2024 22:05:11 +0000
Date: Wed, 14 Feb 2024 22:05:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chandan Babu R <chandan.babu@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/3] Remove the XFS mrlock
Message-ID: <Zc05FiqYKgtNHUL7@casper.infradead.org>
References: <20240111212424.3572189-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111212424.3572189-1-willy@infradead.org>

On Thu, Jan 11, 2024 at 09:24:21PM +0000, Matthew Wilcox (Oracle) wrote:
> XFS has an mrlock wrapper around the rwsem which adds only the
> functionality of knowing whether the rwsem is currently held in read
> or write mode.  Both regular rwsems and rt-rwsems know this, they just
> don't expose it as an API.  By adding that, we can remove the XFS mrlock
> as well as improving the debug assertions for the mmap_lock when lockdep
> is disabled.
> 
> I have an ack on the first patch from Peter, so I would like to see this
> merged through the XFS tree since most of what it touches is XFS.

What needs to happen to get these picked up to not miss the next merge
window?

