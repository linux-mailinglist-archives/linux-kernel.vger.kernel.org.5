Return-Path: <linux-kernel+bounces-4060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB3817762
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EFB1C2268C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72B49886;
	Mon, 18 Dec 2023 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekxTovEc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA2F51F;
	Mon, 18 Dec 2023 16:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4051C433C7;
	Mon, 18 Dec 2023 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916769;
	bh=SuOnhJkiF3f6Db2I3QvJoGtrtaXPHOvRBZiOzxpkX1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekxTovEc+q+OPul2U46zZoLe3d8F3rTaQS6fxQJZFxQGL8UZPpAbheMYFRBI3apEH
	 6LRhk+CCR4QeXTcT834qggJT2RcPxm9QEoDExkwQdMaVdYRdwRBMnyckBKpBz1yWLy
	 Wv17GSY8g8OYyHr5T03I0AE+AgZuV3C5DPg3DjDfQgjKIcwWbkrMBh1oAUbFjz9Ky9
	 PbcWrXyO+Iq/vpWF+MFgUCV3UFBzjnS7j/vB+7cVVteC0/E7v3SesrazhLhVyUOoI5
	 q3e8l9/Iv0ldRYX06xwvLUDwqq1/4aTof77jCZNJAIB/4ytDteGqJP9WjswFDh4PcF
	 qudCm8hmKlJOQ==
Date: Mon, 18 Dec 2023 16:26:04 +0000
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
Subject: Re: [EXT] Re: [net PATCH] octeontx2-pf: Fix graceful exit during PFC
 configuration failure
Message-ID: <20231218162604.GH6288@kernel.org>
References: <20231213181044.103943-1-sumang@marvell.com>
 <20231215125043.GJ6288@kernel.org>
 <SJ0PR18MB52169B706EB4F8F8D8FAB20CDB91A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB52169B706EB4F8F8D8FAB20CDB91A@SJ0PR18MB5216.namprd18.prod.outlook.com>

On Sun, Dec 17, 2023 at 06:26:24AM +0000, Suman Ghosh wrote:

...

> >Perhaps I am on the wrong track here, but if
> >1. otx2_pfc_txschq_stop() was called by otx2_pfc_txschq_update()
> >   (or otx2_pfc_txschq_config()) for relevant error cases; and
> >2. pfc_en was passed as a parameter to otx2_config_priority_flow_ctrl()
> >
> >Then I think that the unwind logic in the if condition above could
> >be expressed as unwind ladder with goto labels whereby the order
> >of unwinding is strictly the reverse of configuration.
> >
> >This is a subjective opinion, but the advantage of this approach is that
> >it
> >tends to lead to more maintainable code and fewer errors in... error
> >paths.
> >
> >(Completely untested!)
> >
> >	...
> >	if (err)
> >		goto err_pfc_en;
> >	...
> >	err = otx2_pfc_txschq_update(pfvf);
> >	if (err)
> >		goto err_config;
> >
> >	return 0;
> >
> >err_config:
> >	if (pfc->pfc_en)
> >		otx2_nix_config_bp(pfvf, false);
> >	otx2_config_priority_flow_ctrl(pfvf, old_pfc_en);
> >err_pfc_en:
> >	pfvf->pfc_en = old_pfc_en;
> >
> >	return err;
> [Suman] Let me think through it. I need to check if some cases will be missed, will update, and push a new patch in that case. Thanks for your feedback, Simon!!

Thanks, much appreciated.

