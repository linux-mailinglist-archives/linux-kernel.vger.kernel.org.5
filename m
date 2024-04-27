Return-Path: <linux-kernel+bounces-161074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5948B46BE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34891F21A83
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C77E4A02;
	Sat, 27 Apr 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+gkPOmo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79163B9;
	Sat, 27 Apr 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229798; cv=none; b=T0dDthPGF7N4Zqc822CSL/BK4ptFLce/zQwNfZWCqr4ti3PC1ZgpdeZj3OlQsJbv4TcjbT38Gi5V1LcEvGTy9/mK+o4PmYk9NAbLy/iBsjWOk5dORbU77x4mk+EgE2Ms25ts24M4K9VHUmJPkkO0YlgHLPr5kgIcwTVQS5HcBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229798; c=relaxed/simple;
	bh=XaHCWpGnqlOtaZfd0mWDaLKojE0ezGxRoa1K+QsaIOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg/nEBDlny2eqnt6YguktRDk7Gbbng08AmuSwowlVW736JvHdiQPFRcEtA22D+8dwdWVpQ2PiDTZxHQ1MYoOGwGUJmx26ZJWufjwGGPuM+Tkg/JBfewu4dPfbU1U7wwJwRbMkgDkVyA98jQ+0s927IpcyNtlj5LMl+SkY9c082o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+gkPOmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA7CC113CE;
	Sat, 27 Apr 2024 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229798;
	bh=XaHCWpGnqlOtaZfd0mWDaLKojE0ezGxRoa1K+QsaIOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+gkPOmovTz5xDJ++JX9m799anC7gLp/RKhc7sv0Ky7MYC5MevSgamU42eK8wnMWM
	 ozjY7aGJ7JLhfwwzHhZGbji2IvbabrnlgUW5uhKTcO7xwPdPNA5IkksD6mx/COsYj9
	 nyb+VDZprcNz16TSc5cFsTz3Nbe4P5c3YCZjec39l/vBHZdPYQcVjZlhsWPlahDHqo
	 KoBqSyQjKWZUUo5ehSSab1CPMY43Gi2MOgpcpnfZTYM/bV+zBM3ol9g4sv0GHTKIGd
	 PMFS9xogfdToC1GjenAyaji31yCf04Tt6u7JMy/7OLXhh88JT0SCQAlwJ+nXctUSa0
	 rfeKnvx2B1+XQ==
Date: Sat, 27 Apr 2024 15:56:33 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/7] i40e: Refactor argument of
 i40e_detect_recover_hung()
Message-ID: <20240427145633.GP516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-4-ivecera@redhat.com>

On Sat, Apr 27, 2024 at 09:26:04AM +0200, Ivan Vecera wrote:
> Commit 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
> scenario") changes i40e_detect_recover_hung() argument type from
> i40e_pf* to i40e_vsi* to be shareable by both i40e and i40evf.
> Because the i40evf does not exist anymore and the function is
> exclusively used by i40e we can revert this change.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


