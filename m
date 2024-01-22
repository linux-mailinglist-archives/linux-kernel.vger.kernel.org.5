Return-Path: <linux-kernel+bounces-34171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C28374F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1171C23F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484547F5B;
	Mon, 22 Jan 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5wjLa6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CF481A1;
	Mon, 22 Jan 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957852; cv=none; b=Xxfq/V8eY5q5/AtfuN9pfP6FUalxJYoJNzyIaDxcsZapIrNlCCEhGmuKD3tLrKgYm/qt0ZsKHkzMlDsfLpPfdT+GeYV/K4MyIsOOKeya8rmTnBRF3hZzaoax3LS2Y2DveBz6blcPALynA0+MTLk41ixwU667k1gAQpQjoo/bdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957852; c=relaxed/simple;
	bh=TDViGXXDF62YHlJpIBlrEc0F5ODj676gbujRwRqKUtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDqAOgtaqVrWTddbT1JaD5GuEKeu3re4NSiaNt4VCzpGedNOyX9f9vPTgksQ6xyL2kWONRp6MUbtopKvuiEuolovB4O6KaXY/JuijCL7YKbkR6AtVrKzvx2bVf9dO/gnXyUO1ihLToBXWFlahb+tp20IkseBoLzkcvXO6kyYF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5wjLa6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1D7C43390;
	Mon, 22 Jan 2024 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705957851;
	bh=TDViGXXDF62YHlJpIBlrEc0F5ODj676gbujRwRqKUtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5wjLa6gOcizqQtkvIgi2lycdDBDD1WQZBJR5QPDfYTBF5FHJKR4h3z+x1XnyxSHf
	 +gBBIrzMsUiibgEP7xUUXakoEbnrzasfK6DPRix7wfJbcGjoFHTHoqZWdHohsyMOfB
	 //BfYKXdio7Px8XckjFam7Ko0P2jas24o/UI4r93TPzx5Xxpaf8GtEvlU7ORdwWS/8
	 XoP4MYf+9KdSUYqMQzqPHazQK4/W7Fvn2R8i5lYJZzTrHWImGB0ANygxK16vYvn/nN
	 TS2OegnnyGrOMjjuhhj4S9BKTfpC6IEDUCjWRx5S/ZBaUzMPme2C61S4+102pwecXi
	 Hn3fMN+zHurKw==
Date: Mon, 22 Jan 2024 21:10:46 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Piotr Marczak <piotr.marczak@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i40e: fix a memleak in i40e_init_recovery_mode
Message-ID: <20240122211046.GK126470@kernel.org>
References: <20240122173633.3843715-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122173633.3843715-1-alexious@zju.edu.cn>

On Tue, Jan 23, 2024 at 01:36:33AM +0800, Zhipeng Lu wrote:
> In i40e_init_recovery_mode, pf->vsi is allocated without free, causing
> a memleak. This patch adds deallocation operations for pf->vsi in each
> and every error-handling paths after pf->vsi's.
> 
> Fixes: 4ff0ee1af016 ("i40e: Introduce recovery mode support")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


