Return-Path: <linux-kernel+bounces-92650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737EF872382
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA351F25DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867ED12837E;
	Tue,  5 Mar 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMzYXEXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8058613F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654558; cv=none; b=YXkDIYp2wjU5xL1KnFYhMlA031IMjIFGeVoZTTeMv0wMZN3vQHlYMmtMHigD27CYHU9HdOQgSqsPoVywMOBbCJccIC9kMUdxOITPSXc4YPVoJc8FsMYo/HvjW4bJd68ewnqbn2OOvv2BAjjbKe6pDAgLLFXiJLqr/KNOjkbFsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654558; c=relaxed/simple;
	bh=sd1X9NjohTIT8JPXMT+kvr22Da/qRcIF6fgOwaI9i0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPmT9I1xTpC4FjOcuJzKT9d23icZyPpMi+Eu7laFf8jLw6cAZEqGd181I/MpkMzuF/u2H8rtMqBD9bX0OaWMqI+2RUlwUtpBldb/K+afL4KsTcZ0u/9NyY+rMD8v9Dura03LeXFBQfW+nC/Y/oEark0wA3ToGVtwVGy3HOInTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMzYXEXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB0C433F1;
	Tue,  5 Mar 2024 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709654558;
	bh=sd1X9NjohTIT8JPXMT+kvr22Da/qRcIF6fgOwaI9i0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMzYXEXLSD+QMgT1DW6CavkNZW0DoWPB/mA3YbWCYj4DKD+opHhPrk2jRRkZ8joiz
	 LwjMKRe5BVIlOL+EQOpq9IFuZNKEDiuoYKKzV5UIBmWhjQO+GSmd4yPZy2UJgTSZKD
	 Movnm0jcwvTbIIrDtSGdBZEg7lSimABLUbKBl+vp7f3abnTbgvtwJhm0RkdwuVH2nv
	 iLBccu8fF3m8OsOnk/3R57l+sHaSLzmN62qY4soNQGXbyJzfwl8Yf2fiopLhnOW3eS
	 1Z7R69p0uHVDcpYI5F1i/LBElN7XOyqmh15rNhe3T+EqnzKFqoXJVp5KO+io0BvLHg
	 +xSMmnePpIjDg==
Date: Tue, 5 Mar 2024 09:02:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Message-ID: <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305135125.GA2802@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305135125.GA2802@lst.de>

Thanks, applied to nvme-6.9.

For some reason this series didn't arrive to my inbox. I got the patches
from lore, but I probably wouldn't have noticed this series if Christoph
hadn't replied.

