Return-Path: <linux-kernel+bounces-4282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE88817ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712D21C23702
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C10774E14;
	Mon, 18 Dec 2023 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9WUM6Mx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301F49891;
	Mon, 18 Dec 2023 19:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E72C433C8;
	Mon, 18 Dec 2023 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702926657;
	bh=EmeKqQ9l5hZEjaLsVkMcEH3YJG0MBMg0v2Q0/eeSbRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9WUM6MxKBOvSwq5/zTDBiDqyt2i7LOpkhq6r7PYE3+UNDLyrKEtyvNTtgBDRSAcj
	 7KJ/Tw5+YoihTxs8Lz/8TqFuySQaR9QI+Zw03wYDRp7BvzWtQTYTgvJ+/HWZp4un0k
	 P39f+MDRsOMgua1IB4MhhsZrPDsqrA2Jo4O3c5R8QpzY2tlo8alGNtB4reRDn2owa2
	 GylBGaltxrIOyALBt4SYIBAOuW0t+y+m/UxFBLAJ19WvRX9G5xhHkIdY49nepykodN
	 g8bBBzB7osLnA9XIf7JVxc3tY2csPyweFtYoYbNR0IQxBSkXZw7NNoSlPDzY17P/7b
	 a6CvHTBf0L2sA==
Date: Mon, 18 Dec 2023 19:10:51 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [net-next PATCH] octeontx2-af: Add new devlink param
 to configure maximum usable NIX block LFs
Message-ID: <20231218191051.GL6288@kernel.org>
References: <20231215120149.160122-1-sumang@marvell.com>
 <20231218162316.GG6288@kernel.org>
 <SJ0PR18MB521600A9A06C7306FE28E014DB90A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB521600A9A06C7306FE28E014DB90A@SJ0PR18MB5216.namprd18.prod.outlook.com>

On Mon, Dec 18, 2023 at 06:03:53PM +0000, Suman Ghosh wrote:
> >Hi Suman,
> >
> >I realise that this patch has been accepted.
> >But I believe there is a double-free problem above as mcam-
> >>counters.bmap may be freed twice.
> >And mcam->bmap seems to be leaked.
> >
> >Perhaps the last part of the unwind ladder should be:
> >
> >free_bmap:
> >	kfree(mcam->bmap);
> >
> >Double-free flagged by Smatch and Coccinelle.
> [Suman] Thanks Simon for finding it. I have pushed a follow-up patch as a fix.

Likewise, thanks. The fix patch looks good.

