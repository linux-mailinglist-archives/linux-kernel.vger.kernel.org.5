Return-Path: <linux-kernel+bounces-137078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F289DC0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD381C229BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC4112F5BD;
	Tue,  9 Apr 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiIqJQHe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299812FB2A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672371; cv=none; b=AFUHMsaaXhCQmLejtuUfLT3+EsRd94Y4qiS456hf3QNAYNpTuKxpcwpCiSGkN2JljYLmmex85yS9PdG06uGlmZ9VWNqSMgTIi4LlkZZqbBlHPXOEUr7TdJ1QczLBOaT0sTanqUISBUvNNBAWLbPTfE8wnnVcUe5BO0GAW8Aip0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672371; c=relaxed/simple;
	bh=ipvByJlQbMhDIHncEeYM0+ZGZ3uJPApzqK6ZIuhrZWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0paJHGN9nhNiufG12qWFMk3o6O/G9qzO/zSDcKFC45j7Zrh0buuCYOQ2EfWy2uHZNmlV9/1r9r1Y8fbrQGFB7dBR4gnezniYF5A4Z0zmmvEVlXU2ByOnn1aG/4jsqke0cCU3jQKHVw1W9tgWVljH54ixIBN8dFFiIdbFL6cEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiIqJQHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C28C433C7;
	Tue,  9 Apr 2024 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712672371;
	bh=ipvByJlQbMhDIHncEeYM0+ZGZ3uJPApzqK6ZIuhrZWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiIqJQHerCE3M6RqEE96Og7LHjZkKeO54nm5ubNaTSm3YwvZKkUoTpiSprROk8ZSU
	 ShQ1kvTWDOT/EEPALQdUDv7APbePy3vRdvww257LtufpucuqGkeF20slopnz2vJNjD
	 aRb1giqwkJfnN4pk1HsjV7kRjdelSgmv6IjZ4BQuZgdZnABgVTS/fNiYKqxYPtP/jV
	 DjRvXxmWKpo/9C+/FDZiNJ3O9ZWJhImgHI2W7s8fVDuXsZCrBALEFADg6cUzpejxsk
	 20A/l4PwG6LyTO4zwmBKUYF7VT2Ux/4SphV4qCtIAYHgK8D620sfOKu0/OT3v149J7
	 RKx9gx/8Kynjg==
Date: Tue, 9 Apr 2024 08:19:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
Message-ID: <ZhVOcGMuBzC3nyMB@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de>
 <20240409140054.GC20883@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140054.GC20883@lst.de>

On Tue, Apr 09, 2024 at 04:00:54PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 09, 2024 at 11:35:08AM +0200, Daniel Wagner wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
> 
> Shouldn't this an be an a based on my highschool english.  Or does
> Eeenvme count as a vowel?

It depends on how you hear it when you read it. If you automatically
expand the acronym, "Non-Volatile ...", then it should get the "a"
article.

If you instead try to pronounce "nvme" directly, it sounds like you're
saying "envy me", like commanding everyone to acknowledge your
awesomeness. Not sure if they had that in mind when deciding on the
name, but it's kind of amusing. Anyway, pronounce it that way, it gets
an "an". :)

