Return-Path: <linux-kernel+bounces-27269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DBC82ECF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06CC1F2374F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F818E32;
	Tue, 16 Jan 2024 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXR7ZO6T"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB12175A0;
	Tue, 16 Jan 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=219PFu8SLZjkc7zCE0Stfq7JLlZFWgwGmWkDPkxlVv4=; b=GXR7ZO6TXEibvdGSHrIn6gJlEQ
	aDYRjew4d7OFIKelW0IrtB3OG0XOlgsBzOi3JK35nuY60APmFj7dDM6+M+yCj4PUbpImrcgwiNbpL
	yYqAPYKXdWn7yjNX8b9+7rb3WKFNbUesiHBP96GFazLp4BziL0/8ckM4OAhlKG7gqcPRQeCS/FUKA
	ZBJPhdZ/715MTyjmZrWtELl/CYNB1a5oXiAU/YeH4fOAzIdJq1e0QrfH0sp5VQMxwqAjP0JQqbxWh
	dQEbU06K0zocS8Tcxrfx4BOo1+Yki9CGSWWxU2VIo23FYqcJ2xg2eIK4E65o4iblCk+vLjjq2i1Sc
	I2+rP0+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPgyQ-00Bi1r-0Q;
	Tue, 16 Jan 2024 10:47:14 +0000
Date: Tue, 16 Jan 2024 02:47:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to
 return ENXIO, now returns EINVAL
Message-ID: <ZaZesiKpbMEiiTrf@infradead.org>
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Allison,

please try this minimal fix.  I need to double check if we historically
returned ENXIO or EINVAL for adding / resizing partitions, which would
make things more complicated.  Or maybe you already have data for that
at hand?

diff --git a/block/ioctl.c b/block/ioctl.c
index 9c73a763ef8838..f2028e39767821 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	sector_t start, length;
 
 	if (disk->flags & GENHD_FL_NO_PART)
-		return -EINVAL;
+		return -ENXIO;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))

