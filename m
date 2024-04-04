Return-Path: <linux-kernel+bounces-131776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896D898BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA9A1F222D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A412AAE2;
	Thu,  4 Apr 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA16JkkM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553F12A16A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246247; cv=none; b=fgUpmLTR5x9Lfw3PzThi23usq5xBSsv4E1gHLZkPc9yUd2hRLJ4uIX6aPQdd4VDOQeJz+cp7Y1oSxwT6HL0x7q/HeFo2aU86XE2i0+fhHAio9fCygaaz/wqZaF+q7hHvcReUx7e+5LHc91NgB32DQMC2ZqsvT/k4geMeFMTea8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246247; c=relaxed/simple;
	bh=iW9MM1LvgGJibefScguGSjJ52qiSh4BE7XUHOu3GLig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYUGXJhEIwriKoANvwjhGujeBPTWzNFA+BpGnDgCghVnZSjnYsP+s8pCOFVXzysEBT+12LUfwl7R3EawcVw4tQjfNpxkwSgUEFUPOJpni0ZNWK+N//hklkd65Tczvy/vPNkLJe52SR4Z+cB84FFcfzQR0o0QQJ3rUXcHEd0H+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA16JkkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B39CC433F1;
	Thu,  4 Apr 2024 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246246;
	bh=iW9MM1LvgGJibefScguGSjJ52qiSh4BE7XUHOu3GLig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YA16JkkMHVhzKcoED7ovfb7RxL1kCK9GfwNtR9kiE6zzbN/T67Wzo0r/tuvresa52
	 D/kFtgkvjjunnEo85FTMb+2C+eOnLea0eZFQV6I1Hv2AFRpc9WNHVBh44a3tRUt2dm
	 xPjvTCXwUdtgq7abT1+/oYjU5mA0Omg+TpwqSz7hNUJZyXquP6teL1/7ClHQSGt7nj
	 A0EQZ5snWwja3Fl/u4eO0H3WnsiVY9l/mL4s4hqCS/XujtYxoBZRJNzs9xxEvFvzoh
	 YCa/58FDKUckrltBUTi9rOUj/zrYzTAMZVYYEIhDnGBLAzGGfGAvMUn1S8ZYggNYeO
	 UMe2rrIYsmEcg==
Date: Thu, 4 Apr 2024 09:57:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme(t)-fc: couple of fixes/cleanups
Message-ID: <Zg7N43asYRbIwLxb@kbusch-mbp.dhcp.thefacebook.com>
References: <20240404144131.17988-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404144131.17988-1-dwagner@suse.de>

On Thu, Apr 04, 2024 at 04:41:29PM +0200, Daniel Wagner wrote:
> Both patches are just a rebased to the current nvme-6.9 head.
> 
> Daniel Wagner (2):
>   nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
>   nvme-fc: rename free_ctrl callback to match name pattern

Thanks, applied to nvme-6.9.

