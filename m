Return-Path: <linux-kernel+bounces-105630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B187E1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D6BB21646
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780712032C;
	Mon, 18 Mar 2024 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sKHOh7Vt"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830451EB20;
	Mon, 18 Mar 2024 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725688; cv=none; b=OneRAhpVxFW+pBjdFstcC64wkJ1WGuH1mwi18wlWcx2ugsOvAuJeydvTWLoy8BVc1gDk2yZQ7JSWvgGfTkQWajtg4w/NXoNPyH/JhL5wfoe1juDrEDySkSM9oc9MUa1dfu9++ZkzWtMIhjVSAD66bUDfMAdP/9mf9AA8NQTvuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725688; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhmIcR2nTbsLPY9FjZ+GfTb9cXQrYK4e7G69ysXe7sKk4MycDHd6RATEYLIT2QTCQBgSvvo5Dq0lQEkwqomacBlTJH8i608n0x2UcyoaCbKYjd4HbJrkxrPqki5p3XMtMYfViZurRIHoConp6z0vlykmD9cunnzLTZznCnXDXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sKHOh7Vt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sKHOh7VtwDT5jltiCI3fbuQM/J
	SEaBELaHMuBR2gC6cxw6qBEL2tL80axfnHZ7OP8dHr2RKl6IwNLc3sDyTLJ2JMEdWILAJtoubF5kn
	OZZfY3nLUkIwp65u7mihdbFHjOJVVqK+Dgx080U6daDHmFexGTG5yoaLeZo77Gvq01rS4UZQmzfgj
	typKSDGJ5OxHzAnodocF27Gu3zl31lBmgVqceWnrr3HBzFdWC8DNJdzJtWav7KD70Vrzg9/+8bXyb
	2Ejoe64vevReZGdsW60llg/dIKBabYRNJOtXB8Qm3nOwrnFl0hCcpg8pbg+aIdiT0ZupVPx6BihbE
	JU+nyLfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1tm-00000006wJ0-3hHX;
	Mon, 18 Mar 2024 01:34:46 +0000
Date: Sun, 17 Mar 2024 18:34:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 06/10] iomap: drop the write failure handles when
 unsharing and zeroing
Message-ID: <ZfeaNhlWAouoG_k_@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-7-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


