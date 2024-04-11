Return-Path: <linux-kernel+bounces-140484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260578A154E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2445FB25B64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1914AD3B;
	Thu, 11 Apr 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwZdG/k3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CF149C7F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840912; cv=none; b=PDGX29uoG8+fZSJtK37zsid8AO2TOP8HT/a6QqqZMaS9F5AkL6u3J0r9IxCReTpLGMGJu38/VYI5yAELhPtknmpw15paJ/hYJpdWKan+L9vzVMnpVQDdRvKa+dRuWhqcab1IgIKMX1vSFCJs0PvWKIfcTE7QTAYdUbePngU+MjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840912; c=relaxed/simple;
	bh=bFpB7CjdyxbHBi3wk8bYZCHC5r/SoLdaY1Md6Y4Pnww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izEUcsdNYmBbIKPWjLZVR9Bpw8NlsH06aF7zZmqO+Msdmt2mzyKtquFxhSe7coZjgmLi51OtzjgBPxLwP2GB3iRq9HR/LJk4HJKCASslySS1f7pJjZc0UNQiy0vk+QhcRTswXp4TY9ppFNmT4mSAfkIhMnNGJEiTtBIqGHgEm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwZdG/k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64251C433C7;
	Thu, 11 Apr 2024 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712840910;
	bh=bFpB7CjdyxbHBi3wk8bYZCHC5r/SoLdaY1Md6Y4Pnww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwZdG/k3VvzOyEZQDJISQWZsQx46KwVYYPdFPjiOXBPLs+Bq3nvjJe13/SuUszHlM
	 cDibYKrs0b9bApshafKnGNXqb+Xn3n9OT99m0h/9T35OJyr8qCAjQJqSh3ACMGQPk5
	 KNoeccftA47doxzyc3xrGO32oAYINY+74DPmRlFI=
Date: Thu, 11 Apr 2024 15:08:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v4 1/2] devcoredump: Add dev_coredump_put()
Message-ID: <2024041121-flirt-chill-5356@gregkh>
References: <20240409200206.108452-1-jose.souza@intel.com>
 <ZhW_5Yctai75qvT2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhW_5Yctai75qvT2@intel.com>

On Tue, Apr 09, 2024 at 06:23:33PM -0400, Rodrigo Vivi wrote:
> On Tue, Apr 09, 2024 at 01:02:05PM -0700, José Roberto de Souza wrote:
> > It is useful for modules that do not want to keep coredump available
> > after its unload.
> > Otherwise, the coredump would only be removed after DEVCD_TIMEOUT
> > seconds.
> > 
> > v2:
> > - dev_coredump_put() documentation updated (Mukesh)
> > 
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> > Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> 
> Greg, can I have you ack to merge this through the drm-next?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

