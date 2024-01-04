Return-Path: <linux-kernel+bounces-17201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD928249AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7ACB24BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5F28E0D;
	Thu,  4 Jan 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="serrNK0u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65631E503;
	Thu,  4 Jan 2024 20:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068EAC433C7;
	Thu,  4 Jan 2024 20:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704400838;
	bh=wfKfnH7YLdSwjVnqaoKaRKpcS4tFflrKLF1bSoIVlwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=serrNK0urNmROd5qJ+kO4+UwWgxa+6ka/RPhkgLxXQHzVriygEOQXFv9sbdvtk+fX
	 rgNw2YV7FFrfwqtYZLOoMvdVWODN/LvnnZtnu2jZ7smKDicT02FhqMHxr/fmEeAZYv
	 V5TBQacG6XFc1uDnzuY9g66djqTTOLwXoU7fpzT3ZzKP2bpmXWW04ba8bMTG5plsIM
	 XBPoAdJVkr1VVR99DSpzkPLvK3V6ASHOze3gAgZpxoIArFYZyoGGDYCgEhrl9UdPLm
	 jtXA38azvMaZaPJn8u9dSLq2K59Yv+OE+PLBS1lDl313YI9QFIG8Tbrkn92idNehYn
	 hfUiryATznPNg==
Date: Thu, 4 Jan 2024 20:40:32 +0000
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [0/2] net/smc: Adjustments for two function implementations
Message-ID: <20240104204032.GN31813@kernel.org>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>
 <46fe66f7-dc3b-4863-96e8-7a855316e8bd@web.de>
 <b2ee4680-72e9-56a1-e0dd-9cbbe64a7dac@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2ee4680-72e9-56a1-e0dd-9cbbe64a7dac@linux.alibaba.com>

On Tue, Jan 02, 2024 at 07:33:18PM +0800, Wen Gu wrote:
> 
> 
> On 2024/1/2 16:51, Markus Elfring wrote:
> > …
> > > > A few update suggestions were taken into account
> > > > from static source code analysis.
> > …
> > > >     Return directly after a failed kzalloc() in smc_fill_gid_list()
> > > >     Improve exception handling in smc_llc_cli_add_link_invite()
> > > > 
> > > >    net/smc/af_smc.c  |  2 +-
> > > >    net/smc/smc_llc.c | 15 +++++++--------
> > > >    2 files changed, 8 insertions(+), 9 deletions(-)
> > …
> > > I see you want to fix the kfree(NULL) issues in these two patches.
> > 
> > I propose to avoid redundant function calls at various source code places.
> > 
> > 
> > > But I am wondering if this is necessary, since kfree() can handle NULL correctly.
> > 
> > Would you prefer only required data processing in affected function implementations?
> > 
> 
> Thank you Markus. I understood that you want to avoid redundant function calls.
> 
> But it is not very attractive to me since the calls occur on low-frequency paths
> or unlikely condition, resulting in limited performance loss and the current
> kfree() usage is fine and common. So what is the benfit?
> 
> I noticed that some other discussions are on-going. It seems like you are trying
> to change other similiar places. Let's collect more opinions.
> 
> https://lore.kernel.org/netdev/828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de/
> https://lore.kernel.org/netdev/90679f69-951c-47b3-b86f-75fd9fde3da3@web.de/
> https://lore.kernel.org/netdev/dc0a1c9d-ceca-473d-9ad5-89b59e6af2e7@web.de/
> https://lore.kernel.org/netdev/cde82080-c715-473c-97ac-6ef66bba6d64@web.de/

As as been explained to Markus many times recently,
calling kfree(NULL) is not only perfectly fine,
it is the preferred way of handling things.

Markus, please stop posting patches of this nature to Netdev.

-- 
pw-bot: rejected

