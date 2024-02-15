Return-Path: <linux-kernel+bounces-66344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF4855AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9E1F28DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACBD2E0;
	Thu, 15 Feb 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gcUTd+jI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0B2F32;
	Thu, 15 Feb 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980444; cv=none; b=lq4aNuFyLb+Uq/AnI4o904GJbQi7l4p4Y4+vXXTlwNjFA5An8nSg0k7n8Ay7neP8VOkaKe3tQKgQHUR1OdwyiaLf0HupgZj9hHFniGV2vzaXQ1iYBtS5uHh1mOepeX7726gDKy8UH7F8UEhXoEAQd0Ps6+WnWe3RT5DUbU+bJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980444; c=relaxed/simple;
	bh=51kI4vf8mLRuBzxKBKLdIfkxiXS4QuSnioV4j+USmLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcFZa1/dhbsRbFoOAqW8RyzYo57KBOw9WkKIKxd6Hky+0UB1br7AgUk+xnwCkYJNh/+gE9dbv3TYcT0EVeYDpoV4dtDU3BwQBypETgl42iiWBxQe8egH1/pld7xPnuhc+cDHRAowfbe23Utr5eBARiqj1Ofg8m1ze+ENeJVxOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gcUTd+jI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rY+aNYbaoTKYpPejKb34t5lhEOp9ES6fZIwUoDjUQZY=; b=gcUTd+jIL2EGDxISTUB0cLJtmi
	DiMXV/6Gm6ozcsAsbM6qWIRbz++D7P6d1tagz/2ficY6nKUxEba2Z1S/OBrDQjyl6jg1dgZhymw2E
	BCnvBjUvOz456edXApjpfXjKlbKSw1jRCyrB+LyUFqasudCOHMNCGVJhhoT9q5/EUTblyvpnzuAEH
	RrKsjE57kug36oQDkMv0+yv2H9EUH83TlLnYFH5VH+0ANR5LQMhIVPbb+j6JCKRgdoxUEG9vWPSk4
	5onn8T8NhqjvsS8rJiEhLEYm5pIBKn/qpFFWF9Ge325OjgUVb+yxn+qgGNThS6dLedBXimw6sBtca
	0nG3YFCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVjc-0000000FA1Q-0nry;
	Thu, 15 Feb 2024 07:00:40 +0000
Date: Wed, 14 Feb 2024 23:00:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <Zc22mMN2ovCadgRY@infradead.org>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <20240214074832.713ca16a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214074832.713ca16a@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 14, 2024 at 07:48:32AM -0800, Jakub Kicinski wrote:
> Overreach is unfortunate, I'd love to say "please do merge it as part 
> of RDMA". You probably don't trust my opinion but Jason admitted himself
> this is primarily for RDMA. RDMA is what it is in terms of openness and
> all vendors trying to sell their secret magic sauce.

Common.  RDMA has two important open standards, one of them even done
in IETF that most open of all standards organizations.

> > I think all maintainers can and should voice the
> > opinions, be those technical or political, but trying to block a useful
> > feature without lots of precedence because it is vaguely related to the
> > subsystem is not helpful. 
> 
> Not sure what you mean by "without lots of precedence" but you can ask

Should have been with.  Just about every subsystem with complex devices
has this kind of direct interface for observability and co in at least
some drivers.

