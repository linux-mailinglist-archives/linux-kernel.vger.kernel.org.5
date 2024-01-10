Return-Path: <linux-kernel+bounces-21824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CA8294DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD5928878C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24623E460;
	Wed, 10 Jan 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQlp1VWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065753EA70;
	Wed, 10 Jan 2024 08:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB37C433F1;
	Wed, 10 Jan 2024 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704874326;
	bh=R1kRyvFyie9bKSVcbmLw40Yht8pGWPEU2b8QAHOxWHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQlp1VWrNtN5sqOM/Q21XGCkCRIJ51Cm9y4InIlGy6zFI1LtK9h1hKXQuIZu+Aknu
	 Mqp6WcYpif4RMZi3CvhSAL/4fsysfOi6Cif/njrdgAcgti+OxL1uBZ2Ls8AJTUhzMy
	 e6uDISvtKraYM7U/8/kLuIPoPKFSs/KOUdqA6ndeQH6P+PJRUBHspDEyUJ74MpKhTi
	 j7wmFeZUJR9WBt7KMIP/l0BOjqjhYP21f43dOxOSx+Nf8T7jP1F5abcPxRBhkSo655
	 KzM0FNx4SD5wIW2Gy2CoWr9kNyZjtZhAvTC3S03bs0SC8kpy5TEP/Ja/JZ0kRdLn5x
	 LzMJi9ttPpf7w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rNTh0-0007J5-21;
	Wed, 10 Jan 2024 09:12:07 +0100
Date: Wed, 10 Jan 2024 09:12:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Doug Anderson <dianders@google.com>,
	Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com>
 <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
 <ZZ2IOQEekFffJoHQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ2IOQEekFffJoHQ@google.com>

On Tue, Jan 09, 2024 at 05:54:01PM +0000, Matthias Kaehlcke wrote:
> On Tue, Jan 09, 2024 at 06:12:26PM +0100, Johan Hovold wrote:

> > That depends on in what way the current devices are broken.
> > 
> > Any machines that correctly specify their address in little-endian order
> > in the devicetree would no longer be configured using the wrong address.
> > So no problem there (except requiring users to re-pair their gadgets).
> > 
> > And tools like btgmt is broken on all of these Qualcomm machine in any
> > case and would now start working as expected. So no problem there either
> > (unless user space had adapted an inverted the addresses to btmgmt).
> > 
> > So the first question is whether there actually is any boot firmware out
> > there which passes the BD_ADDR in reverse order?
> 
> Yes, (at least) the boot firmware for sc7180-trogdor devices.
> 
> hexdump -C /proc/device-tree/soc\@0/geniqup\@8c0000/serial\@88c000/bluetooth/local-bd-address
> 00000000  8c fd f0 40 15 dc

Indeed, this should have been LE order.

> hciconfig
> hci0:   Type: Primary  Bus: UART
>         BD Address: 8C:FD:F0:40:15:DC  ACL MTU: 1024:8  SCO MTU: 240:8
>         UP RUNNING 
>         RX bytes:1700 acl:0 sco:0 events:95 errors:0
>         TX bytes:128949 acl:0 sco:0 commands:578 errors:0

And any user space tool overriding the address would currently need to
provide the address in reverse order on Qualcomm platforms like this
one (e.g. if generating the address for privacy reasons).
 
> > > I suggest adding a quirk like 'local-bd-address-msb-quirk' or
> > > 'qcom,local-bd-address-msb-quirk' to make sure existing devices keep
> > > working properly.
> > 
> > I don't think that would work. If this is something that we really need
> > to handle, then there's probably no way around introducing new
> > compatible strings for boot firmware that isn't broken while maintaining
> > the current broken behaviour with respect to 'local-bd-address' for some
> > of the current ones.
> 
> I think it should work for sc7180-trogdor. For these devices the device tree
> is bundled with the kernel image and can be updated. That might not be true
> for other devices though.

Thanks for confirming.

I'm still hoping we can get away with not having to add quirks to
Bluetooth core for broken Qualcomm boot firmware. Let's see if anyone
knows of a use case that makes that impossible to avoid.

Johan

