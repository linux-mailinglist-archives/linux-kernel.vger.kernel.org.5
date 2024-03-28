Return-Path: <linux-kernel+bounces-123362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029589071F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF677283701
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2357F7C9;
	Thu, 28 Mar 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe7HPGj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5638004F;
	Thu, 28 Mar 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646651; cv=none; b=kgB7kAX8FzUsiX3W/jIgImpzAMNlnFdm5tkfXMLaWGZQJlM3MwLAu0GRnfld+SZ4IvV1PG+VWJLjk2KezjLwVIk+OTxZi86dIrcWdiSS3iHThqBLJnX9VKqd1z/oYj78CQ5G7iipUqOz2RFyOTfJz0A/W6ACPlR2+a3J1oKUo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646651; c=relaxed/simple;
	bh=YzeAtMUDtiWRpYydJqQhcSkYUuXxZ7hxJ+EVoQxmPHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACfEY0zjpF/tFctqTuofM0iBZGikvFoaBXt0PmJpjHS4MVLwsSaGHMKXMl2jketAp0i5fVuRAcK9olM+LYBuFhAZjtGTKi5arf5poCUqEfW91pWfE+z8p8HZRgpNS5rUd+KADeBrnwojiIDNISp70baGTk5gx3rCToXwZOxb5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe7HPGj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4989EC433C7;
	Thu, 28 Mar 2024 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646651;
	bh=YzeAtMUDtiWRpYydJqQhcSkYUuXxZ7hxJ+EVoQxmPHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pe7HPGj3dxopONjHyHuIMiZjtUTba8xpYRf45nZDoMUa97DqIE+fUXqpgGV2KyTHg
	 Wj0es5p6BKOpqDD0+9bhR/t1qxP3zwwcB25RHujxRrBBspViYuFLjepRbeIRfOAUo9
	 Toct6F328tdDl413Bv0TwoYfpujbi1KEB66HhnbBvUU5D6BQwdH3/a+SqOsX6RyYkm
	 XLQcvnfCxYhEYllqYErD/dF/YcEHjgImcxC+RXB962UoVAHy26/I6/veHSZf784PQB
	 3EMadqPEjZIgNP8/JqmZ05CXwaEj/NCye+Z17U/WRhPvV5uhU3kDVPF0AY50JYR+8w
	 hvpzOCw+qvz8Q==
Date: Thu, 28 Mar 2024 17:24:07 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v2 4/7] i40e: Add helper to access main VSI
Message-ID: <20240328172407.GD651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-5-ivecera@redhat.com>

On Wed, Mar 27, 2024 at 08:57:30AM +0100, Ivan Vecera wrote:
> Add simple helper i40e_pf_get_main_vsi(pf) to access main VSI
> that replaces pattern 'pf->vsi[pf->lan_vsi]'
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


