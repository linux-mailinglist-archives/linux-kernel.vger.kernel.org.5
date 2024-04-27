Return-Path: <linux-kernel+bounces-161072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B38B46B8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC24B21621
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A417D2;
	Sat, 27 Apr 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoeVlFHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA91DA23;
	Sat, 27 Apr 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229770; cv=none; b=aqL5Teizo6bSys1hDvm2NOpdqEmolJh9SMiCHmNBl4FwXL4p4D4GvpNSinLorShApDaLTVs6kfB17Ez/Fgcg1kHErt9TplEeqv6RUUIXsvTDdA0It6e2bXA7CmKBxT1TKcs9INoE8DlYF7teC73ML1ibuZzzsmic8c6gePx0gHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229770; c=relaxed/simple;
	bh=2keqNmf75GCNlX26W+pv3/N2abISiBK9T2meqhf2yKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgn7KdRXfiaqfKCMcDAiLN++fydkQKnSSqWcPoGSupS30T0ueLkNHQ1ToBjAOwLvGEnwZ6oWArP4Rs2VtbVQyR6ToA6VjtwrArSG9sDcBSuaN4h0H262OZDobE7ImNTVcXkedx3FZltwwzSEHNgEcsBBFRU79smMS3Jhw4c0it0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoeVlFHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D69C2BD10;
	Sat, 27 Apr 2024 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229769;
	bh=2keqNmf75GCNlX26W+pv3/N2abISiBK9T2meqhf2yKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoeVlFHNBZ1r3y6yxNU4E/Hi+JX5xDfuX2bMA2Z2yHHFQVq6+XPTkAgZHkGdvftDY
	 bEBW9Ly4Vqjd7B+SYCATvDD0knr1Pk66jqHaJKim51SZxaS3XcT6LDC3odoMKB/SX+
	 zaZagQvoxCbPRraKYaZHQ/l+hWACXSdXjWF1lup19D+/JjQFIp7+YHZYCC5IsxpmOF
	 /sLhWPSGikiCaJnRcVtxDsX7pQHtDvLXMqR5Yk101eXX9Q+jzn0mn/VcqyVJeRVTMs
	 WPYSC1XkmjXEwhCdsd/OFnrLTrB5ONySIWeYsxRuEUE7BDzMBP2mX2+FrFx7M/2sDz
	 b30hkhzYDOX+Q==
Date: Sat, 27 Apr 2024 15:56:04 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/7] i40e: Remove flags field from i40e_veb
Message-ID: <20240427145604.GN516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-2-ivecera@redhat.com>

On Sat, Apr 27, 2024 at 09:26:02AM +0200, Ivan Vecera wrote:
> The field is initialized always to zero and it is never read.
> Remove it.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


