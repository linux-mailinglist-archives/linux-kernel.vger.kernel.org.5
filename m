Return-Path: <linux-kernel+bounces-86925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0886CCE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7A81F24DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B711420A5;
	Thu, 29 Feb 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thFtna3X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9F86275;
	Thu, 29 Feb 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220495; cv=none; b=PoFUfGG8H5LQucI7UbUn7kRd1JpYgB+oPaCCAmmTKEvoQPFSzHsuHk5KnR9wpRrvzkw+QLUJxoYgBqF6aRazq1aJ7UjzmOzVFX9w5dWd1snn3+2IZxlelCfRblCUEmHjeBYRWuOL8BWPJrJTErDn7DbIHVZ8i0N97GFwTJTv504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220495; c=relaxed/simple;
	bh=mBQXZyrRxgzNUolzhgxjlsuqSS7+yHr2XWDMdZUoF8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0Z+aNOxyUFo3Df5xWuEazDCNAxTqI7umTsfgQ1n13UrCikc+Ilx5keSwGnVq0CWtZ9dRneupiKUG24qW59Nf3TvMMcFLC8rEzvwRTkWyW8UYmVKlKi+yeJK4UPOzbNTR/EyJ9vE5pVjPycOkK5OA1cJUyHUSUWwuWl7SJteT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thFtna3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2A4C433F1;
	Thu, 29 Feb 2024 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709220495;
	bh=mBQXZyrRxgzNUolzhgxjlsuqSS7+yHr2XWDMdZUoF8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thFtna3XIf74IR8tJBbuB5/fLJRn8cAoY8FRSZp73ZENJF23ybG9GkALI0fbnxSHL
	 TlTNqyFiS/wWRH1GKf4Wx4nVitwEZ8gUAx7cyfZ9ViqQ33HSDZX9/uRch7fB3WVgAY
	 wOcEzvnbucsi0EU+Rpu1jQ/YtlDdps1cmB38pQ3ILD+Bq5MdnJxGtzzFP11C44afAD
	 ELBnWpinULqCORPnTdGK6rQsk8qoBVx98mONgIFfI0iWJ0qwWmHAwBngsS8P8Of3Cs
	 u3h+453um7Kw43U/9RT3YxGeVITfmT/vf+EMEUlSRjJZELbqG0mrxSSKakeAOVECd0
	 sexdu9ZX7IYEw==
Date: Thu, 29 Feb 2024 07:28:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mateusz Pacuszka
 <mateuszx.pacuszka@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Lukasz Plachno <lukasz.plachno@intel.com>, Jakub Buchocki
 <jakubx.buchocki@intel.com>, Pawel Kaminski <pawel.kaminski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pawel
 Chmielewski <pawel.chmielewski@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <20240229072813.5d7614c3@kernel.org>
In-Reply-To: <ZeBMRXUjVSwUHxU-@nanopsycho>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
	<20240228084745.2c0fef0e@kernel.org>
	<ZeBMRXUjVSwUHxU-@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 10:20:05 +0100 Jiri Pirko wrote:
> But isn't it a matter of eswitch configuration? I mean, the user should
> be free to configure filtering/forwarding of any packet, including LLDP
> ones.

This is an LLDP agent which runs as part of the NIC FW, AFAIU, not about
forwarding or filtering.

They already have the priv flag, so best to reuse that. If not possible
we can explore options, but as Larysa mentioned herself in the cover
letter sysfs is probably low on the preference list :(

