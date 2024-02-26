Return-Path: <linux-kernel+bounces-81869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE002867B31
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A83F29085A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444312C7F7;
	Mon, 26 Feb 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="McuDsixA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDD12C7EA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963764; cv=none; b=m5+WYpUntCUEvH2DmPgnWpXdSW5LIDsfVFO2kuRt/mwTGx2A4ir2WW3cXKyCCcbMeZhXTuAKx5/BtpCa5frk0tt0GKLXRJslfv1NUEui5o1Us4Vz1tA5SESCtxrKqD9ZQdp9P9dh3aHROdEL8TcxU+CvW2kjRWQoCrGOXU5M6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963764; c=relaxed/simple;
	bh=xt1WOjl6sMkRsTxQTY3z1gRDMOivhj//q1lTEWujby0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxyTiUyfe5iT3+BMAO7gr/OskxOBvi1wdIegfS0ckt3wB5Rk4yrYLI+CjirnKLtPXTCgd+oMpAHagtDTzD9990/Hwi53MxfHsM+5X/W5b8cY88TLv1St+qzLigVsj1sSZv4q04hQbJUr3pu8PoiR9X1QWezlvruhe4Hx0N1sGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=McuDsixA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oDtnkQOFFXaBBcydWy+HJCqlvYjGohhSDpm5K00Ii34=; b=McuDsixAWCsW2dxHKgwKRQZgbx
	iamVKha/g2AZQmHce2TfImiUF54JuA/MQkteWPWMewkylMpOD+gBLxC5yLIkleXXUlYE97DNHY8OU
	eWdiQUSoMMCTBvHJVKQ3x1Qog/qdl8PmVeI3idWsfVLnT743zfNxEEZ93kJNBs/rgcKqkgeopGPFI
	f1X6mk2hxPpbmfQHsf4j2b1ZUiAXONCd9X7RJg+yxPdSugs271+sxG/uRg6IBJUxuVJJuGEeS0eYB
	8L4EaWDOhGEt2kG1VJqtJzHkLa9sFRYU691CSJByKxeF6fFydZ+ATsalJ9iYOJRf7aKAAgoZgHF4x
	tkSaVlJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redXd-000000000Pp-1FpX;
	Mon, 26 Feb 2024 16:09:21 +0000
Date: Mon, 26 Feb 2024 16:09:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm: remove total_mapcount()
Message-ID: <Zdy3sbqacjiq5mVS@casper.infradead.org>
References: <20240226141324.278526-1-david@redhat.com>
 <20240226141324.278526-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226141324.278526-3-david@redhat.com>

On Mon, Feb 26, 2024 at 03:13:24PM +0100, David Hildenbrand wrote:
> All users of total_mapcount() are gone, let's remove it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

