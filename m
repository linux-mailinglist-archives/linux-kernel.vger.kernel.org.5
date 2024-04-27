Return-Path: <linux-kernel+bounces-161078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E768B46C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBD9282784
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CC53AC;
	Sat, 27 Apr 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+iDpvyO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA939FE0;
	Sat, 27 Apr 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229838; cv=none; b=u0bbyRcboqB4qRhccFG8MnYBXfuC/0bcRoUccSOp1BW0l1E5vPMsz2TWttJcqww4qTz/E/C7KYf+ieSNpm3gverxnRP+jUGJdUEwnavHZM+SJhT5wSnmuofQ/CSC5ZBuDiQ255ig0z1VGGDHr1Fc72plbgr2GzgI4QiqwlnUM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229838; c=relaxed/simple;
	bh=Ri2PZ/2TkiGGwBNLhkri3Uu3MGu24uFF3tTfdAobHts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPKYYeGtS8bxpfZSqaRGTeFqRLVmzPhwMVHQEeOtCD/Fks7M+OoTru0muQrkQagfF0u74ceq6hfinur6TW2FWlxLd0uuJ0BONkSuzeQqgyGNevBIl5bzsZxDf2xdMtLlkFuqNXEAMiWQKKGji73qUT1/kgTNlNMlG5csAIlulko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+iDpvyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD1EC113CE;
	Sat, 27 Apr 2024 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229837;
	bh=Ri2PZ/2TkiGGwBNLhkri3Uu3MGu24uFF3tTfdAobHts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+iDpvyOfV0vHy5lLl3LVJycFy78hK5aHBOfAOqHEGGYnPrwU/lZBLZRaYyPbPsje
	 gFsmMJB7EYEMbKnKGqnNVRmasBRMZgPVn5w10tciYGKugyV7CrQPqvWtTihrRZdQ0t
	 kgx5dAiXBNDddx/6BcdrMkMHnIMGl7lecHRoceWca4fUBxfPZO9464RsDajCm2Wl9D
	 87O8UhEHEO2sjvKHzh7UzP0u2KjmXb36eBZk18ic7n9kR0OO66jmYmkHn8JwxnOPni
	 QmNTLaYJOLi+zFc3DJmX+giOgakNY6B0EGtqOwwKKkpcMCT/LxRDR6uKHv5pf8suIt
	 nX7VWvUjPl7uw==
Date: Sat, 27 Apr 2024 15:57:12 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 6/7] i40e: Add helper to access main VEB
Message-ID: <20240427145712.GS516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-7-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-7-ivecera@redhat.com>

On Sat, Apr 27, 2024 at 09:26:07AM +0200, Ivan Vecera wrote:
> Add a helper to access main VEB:
> 
> i40e_pf_get_main_veb(pf) replaces 'pf->veb[pf->lan_veb]'
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


