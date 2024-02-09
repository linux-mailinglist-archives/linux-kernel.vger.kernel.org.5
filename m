Return-Path: <linux-kernel+bounces-58949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329AA84EF0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E398628CF58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9731879;
	Fri,  9 Feb 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkKAThUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E714C6F;
	Fri,  9 Feb 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447092; cv=none; b=riTfFbA2lbvt653HMYBk4es+uyZji4nYUk+HzMyoRB7bYoLZFsEbwuPWHN81l7e5eWkjXQhlR72HAlTdfSvr59SWq1wAQHkh4yUkSWjeH8AuLFzDxuTu2HD9KAkCWTRUViw544043Y378DpSMblY3u2f37EuO47TUUs0h4TBw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447092; c=relaxed/simple;
	bh=kAs+fQHGu51PFltWzHgpULib2IZu/SWvcdqHx+ctRi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNHzknpdfkZhoGiEfHuHQ0//4PzFpiw8mSq3Y3bzK9OmWdkx0CLn5YLCDPc2cJpxo0A9hKkTKNxuJKD5w7PxnY8/1MrFZwYKPsTdEPawkICss1zOiaKoaDvPYHPBLSGgy51smhHcbHK1YjUuBlt4WCSwXST7ZsD/ttwAKUcORVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkKAThUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E043C433C7;
	Fri,  9 Feb 2024 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447092;
	bh=kAs+fQHGu51PFltWzHgpULib2IZu/SWvcdqHx+ctRi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VkKAThUJPgAn/VpLn68mJ1jmRfOfpL2F/NMYsZLwveU/Ds7TIXz0S+huIjMgsKj8A
	 kCdvchSRbv0YXJQZarBpYe7+h6Gf4hxvls/uYG22CBcPPUEDpFmPkcI49DNQl1jFga
	 Zi8IV9wWLUrzdDkdJKeznXUHki/036+Nb2nAzD1fpn23QGJEWFrKt3CWPkOLGgUTFi
	 kBjOVpCPOSANhxJSBonJj6o+djU+L9wgaKoAOh4qOb22Ik1HkSjaOOy0tgrmRQFwTl
	 Stvfw3Hdf6u+es0cnMdEauzKbJpcUJRg9FI3kbCMm6NLRuV1z/LHjFSQgdQ7HqaKpp
	 IZtCReopNio5g==
Date: Thu, 8 Feb 2024 18:51:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <richardcochran@gmail.com>, <horms@kernel.org>,
 <vinicius.gomes@intel.com>, <vadim.fedorenko@linux.dev>,
 <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
 <gakula@marvell.com>, <lcherian@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>, Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for Octeon
 PTM clock.
Message-ID: <20240208185130.23509cb3@kernel.org>
In-Reply-To: <20240206181009.1143910-1-saikrishnag@marvell.com>
References: <20240206181009.1143910-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 23:40:09 +0530 Sai Krishna wrote:
> The PCIe PTM(Precision time measurement) protocol provides precise
> coordination of events across multiple components like PCIe host
> clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> support for ptp clock based PTM clock. We can use this PTP device
> to sync the PTM time with CLOCK_REALTIME or other PTP PHC
> devices using phc2sys.

A bit of an odd driver, somewhat similar to what Amazon described.
You register a PTP clock but there's no PTP involved. Also you call
pci_get_device() instead of binding to a proper bus.

Please repost this, add linux-pci and the PCI maintainers to the CC.
It'd be great to get their acks (in addition to Richard's).
-- 
pw-bot: cr

