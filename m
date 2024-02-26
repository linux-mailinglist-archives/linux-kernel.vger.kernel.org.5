Return-Path: <linux-kernel+bounces-81457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D409E867630
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E6282FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD218527F;
	Mon, 26 Feb 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hc3rG1yg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9580037;
	Mon, 26 Feb 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953220; cv=none; b=KSEwofR6QJHVBpJLcQmlFcqsu4LFnCNdKEsZDK7i+0gGASAG2Vb03zoWMiOuHzkYCCWalbe3OpCdd+mygCJI1QNLkPVf66Od8eUpOHC4h0pFgWLw0K/x3reB9sOBOb1yELn/4jmer8x/RsUNXu4BmHYtjdALmkdsQ3DjxsZUXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953220; c=relaxed/simple;
	bh=5d8tuwRD3hnn1I/Q5u9fzmp1C7q+UTW7gVYHJW8kmrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krIQiO7OIUqoHxhB5YZ9QOkfwoN3UG1OWPSzhlyhXQo251cthAhA8QAu9VZZI08KWAa2xvj16cJTNVqooqbNMS1FO3LEmGFmheIe3ve2OVHnQ9FPFZk1zCDPx97RTvOijQ7P1QpGVeiM9NPpRKy2v8hefN947e8nfaAexG4Rt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hc3rG1yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64FAC433F1;
	Mon, 26 Feb 2024 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708953220;
	bh=5d8tuwRD3hnn1I/Q5u9fzmp1C7q+UTW7gVYHJW8kmrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hc3rG1yg2BT8VqE8Z4ZwK4KtS8Lwnpl4TmaFs/SYKt8drW1WeIAbd8KPilt2BRNPX
	 sanWLnB4FwMlOzwk4BB3yfkdfNRBnjz3LVsgFBxamgyzw4OswEu9u08JmXoLxAOq/t
	 oVfQcxbKs2kKClI8Dpi2ezGeuwkYW8fj4uiH2lAg=
Date: Mon, 26 Feb 2024 14:13:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [RFC PATCH] usb: gadget: ncm: Fix handling of zero block length
 packets
Message-ID: <2024022602-each-tropical-9459@gregkh>
References: <20240226112816.2616719-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226112816.2616719-1-quic_kriskura@quicinc.com>

On Mon, Feb 26, 2024 at 04:58:16PM +0530, Krishna Kurapati wrote:
> While connecting to a Linux host with CDC_NCM_NTB_DEF_SIZE_TX
> set to 65536, it has been observed that we receive short packets,
> which come at interval of 5-10 seconds sometimes and have block
> length zero but still contain 1-2 valid datagrams present.
> 
> According to the NCM spec:
> 
> "If wBlockLength = 0x0000, the block is terminated by a
> short packet. In this case, the USB transfer must still
> be shorter than dwNtbInMaxSize or dwNtbOutMaxSize. If
> exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent,
> and the size is a multiple of wMaxPacketSize for the
> given pipe, then no ZLP shall be sent.
> 
> wBlockLength= 0x0000 must be used with extreme care, because
> of the possibility that the host and device may get out of
> sync, and because of test issues.
> 
> wBlockLength = 0x0000 allows the sender to reduce latency by
> starting to send a very large NTB, and then shortening it when
> the sender discovers that there’s not sufficient data to justify
> sending a large NTB"
> 
> However, there is a potential issue with the current implementation,
> as it checks for the occurrence of multiple NTBs in a single
> giveback by verifying if the leftover bytes to be processed is zero
> or not. If the block length reads zero, we would process the same
> NTB infintely because the leftover bytes is never zero and it leads
> to a crash. Fix this by bailing out if block length reads zero.
> 
> Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> 
> PS: Although this issue was seen after CDC_NCM_NTB_DEF_SIZE_TX
> was modified to 64K on host side, I still believe this
> can come up at any time as per the spec. Also I assumed
> that the giveback where block length is zero, has only
> one NTB and not multiple ones.

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

