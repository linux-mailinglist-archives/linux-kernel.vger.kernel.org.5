Return-Path: <linux-kernel+bounces-160161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80FB8B3A07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6231F24190
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7234148FF3;
	Fri, 26 Apr 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC4/NKyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6661487F2;
	Fri, 26 Apr 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141778; cv=none; b=bwSsokwvcWOVJ5R0675PJjJv09wIeplSq83aXUIstm1xyFFtvuLsIXLTZWVHJt3ozvgic946Ebqe/X7oPfYgN1zFMmCgm8VnoausDaAh6gKqu2zPU+fkNNmCjMiRvkJbSH9lVUw5qdXvkxaGek7ZxlOpiXo6OsVYooabm9uI+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141778; c=relaxed/simple;
	bh=D3wKqM03L7wKjDEPdv4b0+dxrNwGKgX3ntMzPx9bXCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+Tzm2Pw1oo/kWIZs9fC1V/jSts7nDGW6d99wXTXxRcilBkj4hJE8LEWpkGyieQcbNyiO6kE1A2qPvWvHcWwm8U8Fq4ivw4zEOkPJervoI4UykxJXMWscKmxQKKOeSmMHKRSd+b00p1nQ/L3ceyrzodVYV57DKugC8RLb3c5yLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC4/NKyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6B9C113CD;
	Fri, 26 Apr 2024 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141777;
	bh=D3wKqM03L7wKjDEPdv4b0+dxrNwGKgX3ntMzPx9bXCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jC4/NKyPtYBapka0fEDWLEC+l8sFcA8lrkKpQ4+IBz5j3DoHvd12xkr4IZl3Gu9Mm
	 pi0Mr4hMYvA9ajOcMreC5jOkf7IllNBsmBzSIlXEF4vJmQzzB4OWN1dbCkEdQ0lzjj
	 BLzVkvqIIXy80MpHe5kjbzUbbmiVBuUYeg92zMjUUd/Wyu3DDE3qmUgeLcS6o4hXTG
	 17Ctw4aZRuj97Desn+YWKTaaNo2q3RPFfOgBCEPQiJsMBiwk5qoIs8GNtPGPPD0ZE2
	 Xxhy3jfy5o90qR8UsvuaWAWlvtf3V9dmcEhA6sz2eNLwvZrKzyQxt2NHEp4JeaY5pG
	 hgNVTuUjUHzjw==
Date: Fri, 26 Apr 2024 07:29:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, Rasesh Mody <rmody@marvell.com>, Sudarsana
 Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Anil
 Gurumurthy <anil.gurumurthy@qlogic.com>, Sudarsana Kalluru
 <sudarsana.kalluru@qlogic.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Fabian Frederick <fabf@skynet.be>, Saurav
 Kashyap <skashyap@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>,
 Manish Rangankar <manish.rangankar@cavium.com>, Vineeth Vijayan
 <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, Saurav Kashyap <saurav.kashyap@cavium.com>,
 linux-s390@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 5/6] cio: ensure the copied buf is NUL terminated
Message-ID: <20240426072934.776f7b4d@kernel.org>
In-Reply-To: <Zit9myOJp0SYFL1F@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
	<20240424-fix-oob-read-v2-5-f1f1b53a10f4@gmail.com>
	<ZikiZsSTGUUM69GE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	<Zit9myOJp0SYFL1F@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 12:10:35 +0200 Alexander Gordeev wrote:
> On Wed, Apr 24, 2024 at 05:16:56PM +0200, Alexander Gordeev wrote:
> > Applied, thanks!  
> 
> Hi Jakub,
> 
> I just want to make sure you do not have plans to pull this patch
> via the net tree, right? (I schedulled it for the s390 tree already).

Yes, go for it. I picked 1, 2 and 6, no interest in the other 3 :)

