Return-Path: <linux-kernel+bounces-50798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8257847DFF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D137B24F04
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2E1FAD;
	Sat,  3 Feb 2024 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzvW/Kmf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA1136F;
	Sat,  3 Feb 2024 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921790; cv=none; b=MsxgRrD1VDEK+kCqPl073nlACgi9ja7g09TB3PauqOB4hXqZkkPdUN3E2UpwVdkwttUnIlTDErNWGnlSdP42yCzOTd00Hn+9LtxgdcMQggSwn0ax0PMKUPF7KrKhUQ2qX22yUOHnG5DWdKYglOLFOTdHFxraO1RgSS0BgEK4E6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921790; c=relaxed/simple;
	bh=OxV8pHXLyySJ/zKHrQvTD77VkTpEJB95ybnLcz5aFYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKUmr6tO5pM9ES7n7ON44OCSf+D95csb3UCVgW19e0ZECJa8HVy9QrjAZ3Mvzl1Q9OivYMkQgnwwHzbPF/RDxFWzx6KNpmDbXxS1BpH5ECc2kdWLLWTQHoWQHPT/jd4I7TG4L16zFjteUjQqdcjpUOWfLKoPTcR+JbnVwSxCP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzvW/Kmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F059CC433C7;
	Sat,  3 Feb 2024 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706921789;
	bh=OxV8pHXLyySJ/zKHrQvTD77VkTpEJB95ybnLcz5aFYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LzvW/KmfUHM2tC7qzBRm8VaPKKrC7PEZKBXOmjUzSZNyyfCWYtgxF+4u9Hcohv+n+
	 EBw95y1P/JIEphKYUT+sOhT9Nsi1iPphughPrl0sxsPX9qd+ip3miQszSEhf303NrW
	 xN9atWmEbVE29RvGDzlgslKcjtoXIPrw6Rc+UoybggFq70Hp4qfKSadKm5EH9spr08
	 kOOFMEpnpvzeFOy79GUyobBVyq8mTKQW1Jm6QukAtrTUqUi8yXttQGeck25FGPtU6x
	 At3Od31DgR7g/FsTQ84olBQ0DkjnKlw8BQLizQX1GUvH/CHXAy6rpa8VIBPePU7/QA
	 cfj1wECU56oFg==
Date: Fri, 2 Feb 2024 16:56:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Furong Xu <0x1207@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao
 Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net v3] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
Message-ID: <20240202165627.64e0a628@kernel.org>
In-Reply-To: <ksfs7uag4yukqbeygch7pxvr5axyrqz4gunq2xes3ppmtrgm5b@hwh5yx5qz3wl>
References: <20240131020828.2007741-1-0x1207@gmail.com>
	<ksfs7uag4yukqbeygch7pxvr5axyrqz4gunq2xes3ppmtrgm5b@hwh5yx5qz3wl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Feb 2024 00:58:39 +0300 Serge Semin wrote:
> If so, David/Jakub, is it possible to rebase the branch with the macro
> fixed in the commit or a new cleanup patch is the only option?

Cleanup patch is the only option :(

