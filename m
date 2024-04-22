Return-Path: <linux-kernel+bounces-153595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8458AD01C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD291F22CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72079152511;
	Mon, 22 Apr 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOUGiB6P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05615250E;
	Mon, 22 Apr 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798176; cv=none; b=BdNwL95VjCxsLlmd7Pdk1GY1x+3eFHUO3WLJnarByDCjEwp+v8x9ya5i7oDmh3uxvyMQx0mI3BD29Bxgnx+vXGzIuhU+N2yGWxffNXh6V44kyvKTG0aC+4koXvysBJ7vvZg79MlHnjx+uu21AHbyYFMMorYOv6rQn0FfxETYG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798176; c=relaxed/simple;
	bh=H+cmYxi19/2R2Q4Mn59pR6my5w3kIoBumbkILG2+zEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPs2TBBUSCL2HHUEDVG2tQMM4KIbwIqvKmmlMV7WFRmKn5c6m2LXMcNckB/X+0kamJIWOKQ+5lUbR0rIzms231N8c/zFUNs1YOp2PJs1e6Hs9Krcq7E6q7aPrzFznPa1cX+xktdHHdoDWzyqxNZh6BzTsUXXk5sw6TLO98mCCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOUGiB6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F22C113CC;
	Mon, 22 Apr 2024 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713798176;
	bh=H+cmYxi19/2R2Q4Mn59pR6my5w3kIoBumbkILG2+zEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOUGiB6Pfz3524cIzvW1qzt5qXHNQKBJweL6J3xQyp+1nq1uyMko0+UdWcyvUD3KT
	 VlLdpgQXteXkIbmUSfd8XCqifA3pc2jLE1Sqdk0dBMfWtLtv+Lp2x81NC98feQ9g+t
	 gUIUTrUS7t5F8ONDrhvEGhkEqjrmSXxyuOP1BuGUXImMUsJkQWaHkHuEBKGJCtPJhZ
	 jm3zArhJGFfqKOb/9T0Mh5RBlSisHiBUrqLlOkiQ5rezOsQKUBm1J0KmcOf4ONytMZ
	 p4f6VOGJI8aUlv/wmjnNwNPYlL7eqaDcXme/iqEN1KyIPTNMsa4poKT95vjKmwmeY+
	 OGq7rYUnEvvvA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ryvBz-00000000700-3d48;
	Mon, 22 Apr 2024 17:02:51 +0200
Date: Mon, 22 Apr 2024 17:02:51 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Message-ID: <ZiZ8GzBXd9Re8EjZ@hovoldconsulting.com>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
 <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
 <472b9f60-d68e-47ee-9ca9-f71a9ba86a1a@quicinc.com>
 <ZiZpg4lyp-LcpV8l@hovoldconsulting.com>
 <3e170e40-c143-4e3b-8696-b661cac56f00@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e170e40-c143-4e3b-8696-b661cac56f00@quicinc.com>

On Mon, Apr 22, 2024 at 09:53:48PM +0800, quic_zijuhu wrote:
> On 4/22/2024 9:43 PM, Johan Hovold wrote:
> > On Mon, Apr 22, 2024 at 09:30:28PM +0800, quic_zijuhu wrote:
> >> On 4/22/2024 9:20 PM, Johan Hovold wrote:

> >> NAK for your [PATCH 1/2] since the null checking is redundant with your
> >> [PATCH 2/2].
> > 
> > I explained in the cover letter why it is split up like this. If you
> > don't bother reading, then we will not bother listening to you.
> > 
> >> NAK for your [PATCH 2/2], since it is same with my earlier fix
> >> https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com/
> >> my new patchset for btattach tool still has this change.
> > 
> > The fix does not depend on your btattach series, which has also been
> > rejected.
> > 
> these my v1 and v2 for this issue which are earlier then yours.
> they are not rejected but not responded.
> 
> https://lore.kernel.org/all/bf74d533-c0ff-42c6-966f-b4b28c5e0f60@molgen.mpg.de/
> https://lore.kernel.org/all/1704970181-30092-1-git-send-email-quic_zijuhu@quicinc.com/

Here is your *v3* as part of the rejected btattach series:

	https://lore.kernel.org/all/1713409913-13042-2-git-send-email-quic_zijuhu@quicinc.com/

Apparently you had earlier also sent it separately, I see now in lore.
It's all a big mess.

> > You clearly have some learning to do on how to interact with the kernel
> > community and to write proper commit messages and patches. If you start
> > listening to feedback and try not to piss everyone off perhaps you can
> > even get your patches merged one day. [1][2]

Johan

