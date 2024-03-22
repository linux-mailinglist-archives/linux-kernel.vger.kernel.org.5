Return-Path: <linux-kernel+bounces-111735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C843887017
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006FC1F21D41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD556B61;
	Fri, 22 Mar 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dfip3h9f"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC955C0A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123062; cv=none; b=BJDUPDLuiBMYMkH2+OZxBsvHEHjtUhgrbNQiumYaetoo9FbjUHUoM2/0e3oxE5Ux1WUUHKF3SM2Z1AzDAvWNK5JBTGFyCOgPSHX1Cr7418Occ1kTxgD+zV9iSr7Vcg4LiCZgrs6Naxd/l605g7gU2RX9Zume1NZZDP3qgvXmI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123062; c=relaxed/simple;
	bh=OOqRWLCwcMBctaUSCEcveKG+6vyWUvCuuApGjdYgoeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcRcuJckTO24YJ6IzUgBTGxcfF0XUNhF03fVysH06+WSF4v67e1hgpp7GNBtJeGXrhLpeuRyWMd6XEpHj4N8Q+0p9zUDsZHDUhz/gi0QDuIz5t55TJShVtGr4to0qS3swclarrEzw8qryqTIKXlHqO0Xp6Gc6QVrnnPbL1VMwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dfip3h9f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/oQUXIBl53Mlil81fCqMW0brlHyo5VL3xpRRddwKmb8=; b=Dfip3h9f5/k0lWKkF1ww8fpTV3
	bCMypAP8UClKRcLyeJVSWZGvIzPtfVBu4HnSFG7loJHHQQaO2XfczYPNzps7ExwUQGNN0UfUED2Xv
	3KFusmZyHloi45rJNxFvk2M8poTv2wvl4Io1bNgeRh5CKH/28mMlxHQFHPATVTknJaUie7LomR+AB
	YoOfHSobuCyquO/pow5Ba7Xqj46OnNMGrSVLmoYGVGSzivv2Lsvt8rrrtJxurm66/hL+/eDDVzeeq
	aOhkE83l0giNxVTzF6fHRqk7AAis8A/5NKAP9157seT2YrE3Qh3dT6yuAi9lMogyuTAeXqFgNi7eJ
	2c/P6X6g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnhGy-00000009j4x-1CCr;
	Fri, 22 Mar 2024 15:57:36 +0000
Date: Fri, 22 Mar 2024 15:57:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>, david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH v2 05/14] mm/ksm: use folio in stable_node_dup
Message-ID: <Zf2qcH-bDEgLAP7d@casper.infradead.org>
References: <20240322083703.232364-1-alexs@kernel.org>
 <20240322083703.232364-6-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322083703.232364-6-alexs@kernel.org>

On Fri, Mar 22, 2024 at 04:36:52PM +0800, alexs@kernel.org wrote:
> -static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
> -				    struct ksm_stable_node **_stable_node,
> -				    struct rb_root *root,
> -				    bool prune_stale_stable_nodes)
> +static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
> +			     struct ksm_stable_node **_stable_node,
> +			     struct rb_root *root,
> +			     bool prune_stale_stable_nodes)

Do we really have to go through this void * stage?

Also, please stop reindenting the arguments.  I tend to just switch to
two tabs, but lining them up with the opening bracket leads to extra
churn.  Either leave them alone for the entire series or switch _once_.


