Return-Path: <linux-kernel+bounces-123363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DD890722
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8034D297D61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90A81726;
	Thu, 28 Mar 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsQUQGBJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC142A9A;
	Thu, 28 Mar 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646670; cv=none; b=b5fv2JjuTjXlZNBfY2cXTj7CixVSEyiGU6hThORphPe++MlmIhUiJsMy6DmTNiSyDQEPULQwpnRj2ppV67bWn975Gi/Ln4I4nVEvOuG0/+oHYiQtI6anUjEeHpaYyT+ACZfRNtTHUSRO4xFomBDa0j66vUPhxRr1rGL1Dcq5NbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646670; c=relaxed/simple;
	bh=2siyeS6uzlQMyBU1hT15aszZzeb4J26W0sbBxAvcBso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlBVwdCWXaK2FD31GEhE5IyFmkk4X0FeBWKawBdoe8fn2ES7G93TsHX9JtlofzV8r5tzQPNfh27Xt6uBkyFvHdqYkNKny53gjKnyFE73SGRIlpwCfOjm5CmOtjvBDBORV9jyXvvbxEjGDsaPriL84yKVJYDyyadBfLVZDVlRp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsQUQGBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F12CC433C7;
	Thu, 28 Mar 2024 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646669;
	bh=2siyeS6uzlQMyBU1hT15aszZzeb4J26W0sbBxAvcBso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsQUQGBJqiyE5TBBV1xaMlo03QpVAjoKOs2v+yc9h3SArZNhlqDqOXHBukxqB1MXx
	 mSnrkDZwp1EJRG/GjTmvIuuZFgvtgDPb9iU4m9v7fEXuBOeqXBL0UpY9f+Z60FbZiu
	 Xx8jLPPfa1xXXjofs2s7fczcr9fEWhpQeSI329bsb1I7LJDipgT20fgmDesJxlTlZC
	 BbWF9m789tpHEeAvD4v5nA6YVBxNju9Y0EGeyzE/JURIUvw6s7i1F7SCMtBjJenKeo
	 sUh70/IgAKTKQ4w1h8tAR19+lwIYB8btXTAp3RwJpRc7u+AiLakViYUF3Hfq4PcIoU
	 p50lOWz5kcoWw==
Date: Thu, 28 Mar 2024 17:24:25 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v2 5/7] i40e: Consolidate checks whether given
 VSI is main
Message-ID: <20240328172425.GE651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-6-ivecera@redhat.com>

On Wed, Mar 27, 2024 at 08:57:31AM +0100, Ivan Vecera wrote:
> In the driver code there are 3 types of checks whether given
> VSI is main or not:
> 1. vsi->type ==/!= I40E_VSI_MAIN
> 2. vsi ==/!= pf->vsi[pf->lan_vsi]
> 3. vsi->seid ==/!= pf->vsi[pf->lan_vsi]->seid
> 
> All of them are equivalent and can be consolidated. Convert cases
> 2 and 3 to case 1.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


