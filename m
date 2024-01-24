Return-Path: <linux-kernel+bounces-36729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A783A5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C26B2EAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D751802A;
	Wed, 24 Jan 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6TMOfiC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543CE17C70;
	Wed, 24 Jan 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089136; cv=none; b=XUyx9WYDY0nn0zLoxKm2+cGqFjFWLaiP7McoWbxLx3SluGQ5WblCYgDNLziLocZ6OZtE6V3a0DEdSQdBGUJ/UIFlDlh5em4inXMMxpwv/aCYSvuMshSP7Z3nklozChTPqSs0VlPnauIPswFS5HKwILupI8QSA6rz67sleapxNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089136; c=relaxed/simple;
	bh=fNhhqm+G3nroxKDtOtA3vT26oCb4gT2b9hO812U8L1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgL98IDzE+Nwj7CmkiFdxoarLqrXfyug0L9nQMdvZg2ORWIr9fqiQ2+fErJnWTM+xoSgrs4UOogsxfN4e8fFJ6MVwDkWn5FEmcfKmM6fFl804au/pMkiY8bZNDoKVAjOVMxNfe3RlLHLawcuh1VFNzUnG5IzpEDimBytTS4BkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E6TMOfiC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h1rRnTLYHHyGjDYfE80jFeJYwxpGt8nf+h9LKgpN5SY=; b=E6TMOfiCzsGAkDDtCC5fTTbTJx
	GyyxsXMcwrpqq3JHXx7R09m36Xrz9sQIQBvc2dacZHCrhYnFF4XgR3Y4jGYOIXb09Y/m01hPtGK9c
	iut7Y1XNWtRDSBO8wGjOgD8gGpYfEq7HMUeD4o1ycIpehSUtXavHK1ITJYIGpP0enXwwBG4eGHGhv
	v9AC/SkAGPiPpOiube9QyDKoSTMEHbc5SciEl7s7H5PkrUxXV8rSHIxAiU2iHfi4LLPeVowy0kSCX
	tgqCmVivmuiQZYnoVba8aeddqXGLZ8i0nzU8pcVAhdKZ8yerjyHCHzIoIXQFzBHSOw7q2U7r7p7dk
	f/tUCzPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZid-002Hrc-0N;
	Wed, 24 Jan 2024 09:38:51 +0000
Date: Wed, 24 Jan 2024 01:38:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCHv2 1/1] block: introduce content activity based ioprio
Message-ID: <ZbDaq+iI/8ZQWRxF@infradead.org>
References: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com>
 <ZbDWSUkT/OjHTe0t@infradead.org>
 <CAGWkznHAi_U5erM0s8vFWwwucRKPoSzimNr9tdsPvs_sApGxgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHAi_U5erM0s8vFWwwucRKPoSzimNr9tdsPvs_sApGxgQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The I/O priority can be explicitly set by the submitter, task and
blkcg arre jut fallbacks.

And as said multiple times now bio_add_page must just treat the page
as a physical address container.  It must never look at MM-internal
flags.


