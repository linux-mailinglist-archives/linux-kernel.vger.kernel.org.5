Return-Path: <linux-kernel+bounces-57037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E084D31C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6117B1C251A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61A1EB55;
	Wed,  7 Feb 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmQdgAB1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE11EB5D;
	Wed,  7 Feb 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338572; cv=none; b=r/sMFKq0rXdFLrTeFawIs3w8y5jTzCWh7lgZ+Qngy48reeYy1+0KlsYkMJy0zarG9/0d5SnkOOMtHlNwJY0hticak4kcxzgjq/GXhZ1m9nVEgfVsqTZQLYNYyKcmks/5s3/y/7AQJCqeGq0MdFcGOFxEZSwoytI5u3rW78HbzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338572; c=relaxed/simple;
	bh=3rj3qEOxo3SZWFKz2NeS+OCdillq3OqzrNRe400U8v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axANJzYMAP8YGindOmj4Ijb4BeoF5zQgiRoad1KAvCXJuWjYrjmVkzkC5MXJnEO0AuQIU1nNI/faMovQ3AKsGnv7I0TMztgHG00gM1YgyulnxbhTilcSjf0mikkmX8K8r/hIyuDwIzymvTCThQVksWFf8MXXZzeNxuJco+Cz57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmQdgAB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39135C433F1;
	Wed,  7 Feb 2024 20:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707338572;
	bh=3rj3qEOxo3SZWFKz2NeS+OCdillq3OqzrNRe400U8v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmQdgAB1JIA7mBSOI3VfjkNUV7Ya/6sImN0l7R+K9szRLFV4M8HNYzBNVbiEGuwOk
	 x7jBIM7HAi31cQkN5b4oxS/dybLEWBMzdPHbAkrsaaWai+kntrpY3C9NocvsDn86QV
	 42c+cWNIrNpV8JtvZt/Xvp4vzFxUXMwV4Aedsv6RcA+Xe15tLS/IBgg6eR+UhxWdUl
	 0MOVjRpC1U5rFdMso0jQKVMfL6pDVB0gKOa77k0FSlopsV+wH89CKJ57hZNvWPzydw
	 6VelQcG9Rc/vp5duyCiEvrXK2LW/5mQ46bN52TZv7vX3wvXeqvxWeFj/DRfi1Vi/cJ
	 0dIpbon5fhq1w==
Date: Wed, 7 Feb 2024 21:42:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"Simek, Michal" <michal.simek@amd.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>, "Mehta, Piyush" <piyushm@amd.com>
Subject: Re: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Message-ID: <ZcPrRcpAtOoz2vIf@x1-carbon>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>
 <Za5neDYN9Dh+GwRG@x1-carbon>
 <MN0PR12MB5953C87B0932909BBCE89873B7452@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB5953C87B0932909BBCE89873B7452@MN0PR12MB5953.namprd12.prod.outlook.com>

Hello Radhey,

On Wed, Feb 07, 2024 at 06:28:25PM +0000, Pandey, Radhey Shyam wrote:

(snip)

> However for single controller IP programming sequence
> deviation I am less inclined to make modification in
> generic enable_resources() API . But if you strongly
> feel we should go ahead and make changes to the generic
> enable_resources API, please suggest your thoughts
> and then we can get started.

My first suggestion was to try to add a reset_control_assert() + msleep(1)
before the reset_control_deassert() in ahci_platform_enable_resources().
This should be safe for all platforms as in order to trigger a reset,
you actually need to pulse it. It is possible that your platform has
reset deasserted from boot, and in that case, since the generic version
currently only does a deassert, it is possible that no reset was done
at all on your platform.

If my first suggestion did not work, then my second suggestion was to
add a new flag which your platform driver sets
(e.g. HOLD_RESET_DURING_PHY_INIT), and implement that in a new function
in libahci_platform.c. The generic version could check for this flag at
the start of the function, and return the result from your new function
in libahci_platform.c instead.


However, since you have a TRM, let's ignore these two proposals and instead
re-spin your existing series, addressing the other outstanding issues:
1) The new kernel test robot build warnings introduced by your patch.

- The other review comments that are still applicable:
2) Your patch format is strange... There is one too many "---" line here.
3) Use goto disable_phys so you don't need to loop twice.
4) If you jump to disable_resources, you will call phy_power_off()
  and phy_exit() twice, which the PHY lib does not handle.
5) Please be a bit more specific in your commit message.
6) Describe your changes in imperative mood.
7) A new comment that I see when looking at your driver just now,
you should simply remove:

"""
	if (!cevapriv->rst) {
		rc = ahci_platform_enable_resources(hpriv);
		if (rc)
			return rc;
	} else {
"""

Either you want to use ahci_platform_enable_resources(),
or your own way, but you don't get to do both.

You call devm_reset_control_get_optional_exclusive(), which will
return NULL for platforms that do not supply a reset.

Both reset_control_assert() and reset_control_deassert() are no-ops
if you send in a NULL pointer. The are designed this way to work
with devm_reset_control_get_optional_exclusive() which will return
NULL for platforms that do not provide a reset, such that drivers,
such as yours, should not need
if () {
} else {
depending on if get_reset() returned non-NULL or not.

Just always call reset_control_assert()/reset_control_deassert(),
even for the !cevapriv->rst case, as they will be no-ops anyway.


Kind regards,
Niklas

