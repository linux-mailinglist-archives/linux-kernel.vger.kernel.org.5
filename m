Return-Path: <linux-kernel+bounces-161115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275FA8B474B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D188E1F2193D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABAF143884;
	Sat, 27 Apr 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpN2AFgs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A221848E;
	Sat, 27 Apr 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714239487; cv=none; b=VfyTuPKycIByE/DB6hXKZaRdKpz9qO+QAf8TRZfQALFdfU7iJbn0RzIUxtArirwXKUJZYvMn/4gKMgik+Fux35hMPvFBmQvgfi7vq8o1wtZ3dzMorOLNeC+v13ikR1W17rHmxGf73NBMBREF+tlTkDSDMb5PlkD2+nklzGIzuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714239487; c=relaxed/simple;
	bh=+Iogg6IcRbd91un/hw5tKpWfupvPLPRCSiVDSrd9EvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs5mPF5hgwHpuymHmZ0cdCvmQms/1lB9b6v8xw0vL0wZCUm+UQsNiWLBsajNFygiOBvJtI+TJaHvnnYDiw86fQPOI/DMJL2+J/oAs8n0qlNUfrLl6CG1v7CrP+912FQ1eJR4YheEh462/Y62iOybI5iUqiIlu4kYo6y0Ph1lLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpN2AFgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC9C2BD10;
	Sat, 27 Apr 2024 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714239486;
	bh=+Iogg6IcRbd91un/hw5tKpWfupvPLPRCSiVDSrd9EvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpN2AFgszXHVG3dlSDLZLz0dWT89PHf005q5ZWh7JInq5XMySohTYi0uel9eZng6Y
	 WAxW5dXteWMOmWSwReBiomGI9XsZGo660AteRVXncJt94bojaoKbVGBSvNhDjspfum
	 2tJQWUSO98qk2jtUg+FJ1UjahyJUp/ni7FxGhGXM/awD+pvvjnLfWs+I6Pbo1TyF9h
	 i7XGXc6YNTjHJImbZxL9GbS8RZcAt20mdZergHi7GRRksqPkPDd0MPKzq2pWE2pi5W
	 mzAKbEBGLZEovsFWdNQ2FB9BjrfMMVr1YG2lMyW7G5ZVr1oFIHcDCISB0geBwEGrns
	 M8MlQctbVGeMw==
Date: Sat, 27 Apr 2024 18:38:02 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net 4/4] net: qede: use return from qede_parse_actions()
Message-ID: <20240427173802.GD2323996@kernel.org>
References: <20240426091227.78060-1-ast@fiberby.net>
 <20240426091227.78060-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426091227.78060-5-ast@fiberby.net>

On Fri, Apr 26, 2024 at 09:12:26AM +0000, Asbjørn Sloth Tønnesen wrote:
> When calling qede_parse_actions() then the
> return code was only used for a non-zero check,
> and then -EINVAL was returned.
> 
> qede_parse_actions() can currently fail with:
> * -EINVAL
> * -EOPNOTSUPP
> 
> This patch changes the code to use the actual
> return code, not just return -EINVAL.
> 
> The blaimed commit broke the implicit assumption
> that only -EINVAL would ever be returned.
> 
> Only compile tested.
> 
> Fixes: 319a1d19471e ("flow_offload: check for basic action hw stats type")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


