Return-Path: <linux-kernel+bounces-17778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E57682528B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A393C1F23D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433972AD38;
	Fri,  5 Jan 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSmrksRi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904462420A;
	Fri,  5 Jan 2024 11:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C639BC433C7;
	Fri,  5 Jan 2024 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704452714;
	bh=tAcY3Wc85Xssfc6xmX/zkSzf1A83qZCnAsYuhsInaUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSmrksRiIqN7GoUVkymQxoJ9nLsKvI9RfLoXRVVkksE1CO+ObSwFhyH/6v3DN/jMw
	 378Scwa1Da7fdmpRi4Is58HyL5Yg1OxC4B80mysdJJDsZ4ffNW84vPHT52f+0nHFuH
	 EeNbWXASg1LLRk6ZguzDvRZXR2DE7ZODlqfg180GBjGgmTNORAf4SqS+5r+5wC4OAZ
	 hvevt/jz542KojTCEBlyIIl4kFXTEKghd9okwxadLhAlszGIMqE3KRMnKcfoibahbN
	 aZp0+aKil7dQJ89nhS6Wt18il2m66loRu8Ux+VO6yLYw2ir6x7ammjeIaCvhQxtihr
	 7Qcwkv2uslEoQ==
Date: Fri, 5 Jan 2024 11:05:08 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Haseeb Gani <hgani@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	Sathesh B Edara <sedara@marvell.com>,
	"egallen@redhat.com" <egallen@redhat.com>,
	"mschmidt@redhat.com" <mschmidt@redhat.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"wizhao@redhat.com" <wizhao@redhat.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"konguyen@redhat.com" <konguyen@redhat.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v2 6/8] octeon_ep_vf: add Tx/Rx
 processing and interrupt support
Message-ID: <20240105110508.GU31813@kernel.org>
References: <20231223134000.2906144-1-srasheed@marvell.com>
 <20231223134000.2906144-7-srasheed@marvell.com>
 <20240104130016.47bc1071@kernel.org>
 <PH0PR18MB473450986CAA852218F225F0C7662@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB473450986CAA852218F225F0C7662@PH0PR18MB4734.namprd18.prod.outlook.com>

On Fri, Jan 05, 2024 at 07:26:14AM +0000, Shinas Rasheed wrote:
> Hi Jakub,
> 
> Thanks for the review!
> 
> > > +	rx_done = octep_vf_oq_process_rx(ioq_vector->oq, budget);
> > 
> > You should not call Rx processing if budget is 0 at all, please see
> > NAPI docs. Looks like the function may try to refill Rx buffers with
> > budget of 0.
> > 
> If budget is zero, octep_vf_oq_process_rx just wouldn't try to query hw for packets. Also since by then, the refill count should have been less than refill threshold, if not it only flushes free buffers back to the ring, (and tell hw that there are more free buffers available which have been processed from maybe previous calls - but this seems unlikely and should have been flushed at that time). 
> 
> > > @@ -114,8 +158,8 @@ static int octep_vf_setup_oq(struct octep_vf_device
> > *oct, int q_no)
> > >  		goto desc_dma_alloc_err;
> > >  	}
> > >
> > > -	oq->buff_info = (struct octep_vf_rx_buffer *)
> > > -			vzalloc(oq->max_count *
> > OCTEP_VF_OQ_RECVBUF_SIZE);
> > > +	oq->buff_info = vzalloc(oq->max_count *
> > OCTEP_VF_OQ_RECVBUF_SIZE);
> > > +
> > 
> > bad fixup squash?
> > 
> Sorry, I didn't understand. Can you explain?

I think he means that this change seems to make a minor update
to code introduced in a previous patch of this series, and thus should
be squashed into that previous patch.

