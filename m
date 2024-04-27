Return-Path: <linux-kernel+bounces-161077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A308B46C7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8731C22FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3985420317;
	Sat, 27 Apr 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNQhn2Js"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17521103;
	Sat, 27 Apr 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229824; cv=none; b=Gzn76jeUw843xBFD+vLRKD8mOZZwA8MCBY1W8lgo+AsLK6B+OmCHMJ3GuTK9k7O0H4MR8cdi+061fToKSPFU2nJH3wYKcpcc8guEgN1ghlGfJlg5QV+hRvq0Q6b2nDIffwvFtTkG/co6iCLAdCc632Mka3LUf3f4brikrqsObio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229824; c=relaxed/simple;
	bh=K4QCWgAmyq0Z4+G37rNkynaf997NYbREZ5JXgdP6914=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uafFyE40aVfTGUrw3gpkKqb6VJZ+U7L9lVNQdMOTqvlXBAP8QKu+gBVQ7rLPEBXnJZjy5ydRl4iqxuLyvWYtlq6CgqSE9OWjwlJA0lyXxaZZSQpbNiCMack2lMAsEBivXVyk9LMJnwAx+H5reUasRLgPlD2looRw0NzYv7OJqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNQhn2Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA0CC113CE;
	Sat, 27 Apr 2024 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229824;
	bh=K4QCWgAmyq0Z4+G37rNkynaf997NYbREZ5JXgdP6914=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNQhn2Jsy7wB+sE+VebZBos/3NRCjysrC5+NKet5g0O6hYwmIXCNc9TFqgBtT5m0C
	 5/qTXHS4R+XzVizEzvb93jQL8c3Fwsc0q4Ct03107MeFTvNUn7Za0Je54k0qktTr0m
	 YQVwxXdnk7xAqAq6wIY9sZtTAeD49YAQVJU3yYWyEyjw86Sbi1C3rQoy6pj1cIk8wy
	 tJsOQaJGGdbCyYFfl93fM6NDKVum7q5wwP3CEiP2/vj/XdW8zf+4a1abwyI5bzoXJG
	 xf1w7TQqAwaYsrDYpxxLnGheHp+lC15Zi4GSLo+aaFz+ZPOz2RrGHNAssgsXTO4rDV
	 f52yK880XFNRA==
Date: Sat, 27 Apr 2024 15:56:59 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/7] i40e: Add helper to access main VSI
Message-ID: <20240427145659.GR516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-5-ivecera@redhat.com>

On Sat, Apr 27, 2024 at 09:26:05AM +0200, Ivan Vecera wrote:
> Add simple helper i40e_pf_get_main_vsi(pf) to access main VSI
> that replaces pattern 'pf->vsi[pf->lan_vsi]'
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


