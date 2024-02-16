Return-Path: <linux-kernel+bounces-68935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D5858215
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18321F21284
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708312FB05;
	Fri, 16 Feb 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du12MZCc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC012F39F;
	Fri, 16 Feb 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099317; cv=none; b=rnWc8Z4t3z6AOOO7xn4D8Bhs5VScp74O73VF9/q/wXZ/Zu2P4cOXz8MMTvZJtKdXl7ie7rUjJFwKoRge1jyg4xCOmeSs35To7kBm1xFfMPLMBTPzmKlg1L2yaJSh+5XhbvWZKbdHxV6AUisN6i5y1ZVo8k8f6c082cdfeUnBq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099317; c=relaxed/simple;
	bh=ulmHmF5cD5oOk/vU3Fp+wOpcyv8389AhjaaESJZX2l0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lC2c9g7ktLe+LzRiICMo+6enOZDUrC7SWWzYnQX2pZFRA/W5q3kvxCE/2brKkGNmQW5AAVi+vSzn2dxm9X/ZnUrk+gdxDThuCT1GgW3aGr2ImZhr66dghR3fBRmsglBCi91VUtyQRFLnOV+2bxySE4Sk7qfQrx/qM+cuFPxs3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du12MZCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D767DC433F1;
	Fri, 16 Feb 2024 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708099316;
	bh=ulmHmF5cD5oOk/vU3Fp+wOpcyv8389AhjaaESJZX2l0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=du12MZCc+hUEhyruKbxOOkV1IAKJ99fa+Joqd30VDg3C0Hvg2zGtPEs8FwD7KmT37
	 mDVzCxevKrO0YCGDiUD8Ko9h3TYilXw2APfKUUwHf8x5vu6y7LK7+5zrsHnjJgNpJR
	 s/VWu1D9MCwInZ96KSukzv2RbhdtoUWxJhftaMPTrh1SJmKdsHmO9/1kaXd5NbkPhj
	 v9I8PcMIgzzZ0x+YuRQ5Umg9T9Q3yKL4WAduVdV72SHmwnR7lm91acGvgpkpB9J4MU
	 65dkEurZGOfB1uvUKh9cNUnIK9MtD8Zh2MjROMwlms/53pJj1u87M9lYhV9YEQY/Nt
	 96ul2C7snomwg==
From: Kalle Valo <kvalo@kernel.org>
To: <Ajay.Kathat@microchip.com>
Cc: <alexis.lothore@bootlin.com>,  <davidm@egauge.net>,
  <linux-wireless@vger.kernel.org>,  <claudiu.beznea@tuxon.dev>,
  <thomas.petazzoni@bootlin.com>,  <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
	<2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
	<081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
	<aac398e4-d870-4ba2-8877-b98afecb8d1b@microchip.com>
Date: Fri, 16 Feb 2024 18:01:52 +0200
In-Reply-To: <aac398e4-d870-4ba2-8877-b98afecb8d1b@microchip.com> (Ajay
	Kathat's message of "Thu, 15 Feb 2024 04:35:46 +0000")
Message-ID: <877cj4o0sv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Adding devicetree list for comments)

<Ajay.Kathat@microchip.com> writes:

> On 2/13/24 09:58, Alexis Lothor=C3=A9 wrote:
>>=20
>> On 2/13/24 17:42, David Mosberger-Tang wrote:
>>> On Tue, 2024-02-13 at 16:22 +0100, Alexis Lothor=C3=A9 wrote:
>>>> When using a wilc1000 chip over a spi bus, users can optionally define=
 a
>>>> reset gpio and a chip enable gpio. The reset line of wilc1000 is active
>>>> low, so to hold the chip in reset, a low (physical) value must be appl=
ied.
>>>>
>>>> The corresponding device tree binding documentation was introduced by
>>>> commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gpios
>>>> properties") and correctly indicates that the reset line is an active-=
low
>>>> signal. However, the corresponding driver part, brought by commit
>>>> ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver")=
, is
>>>> misusing the gpiod APIs and apply an inverted logic when powering up/d=
own
>>>> the chip (for example, setting the reset line to a logic "1" during po=
wer
>>>> up, which in fact asserts the reset line when device tree describes the
>>>> reset line as GPIO_ACTIVE_LOW).
>>>
>>> Note that commit ec031ac4792c is doing the right thing in regards to an
>>> ACTIVE_LOW RESET pin and the binding documentation is consistent with t=
hat code.
>>>
>>> It was later on that commit fcf690b0 flipped the RESET line polarity to=
 treat it
>>> as GPIO_ACTIVE_HIGH.  I never understood why that was done and, as you =
noted, it
>>> introduced in inconsistency with the binding documentation.
>>=20
>> Ah, you are right, and I was wrong citing your GPIOs patch as faulty
>> (git-blaming too fast !), thanks for the clarification. I missed this pa=
tch from
>> Ajay (fcf690b0) flipping the reset logic. Maybe he had issues while miss=
ing
>> proper device tree configuration and then submitted this flip ?
>
> Indeed, it was done to align the code as per the DT entry suggested in
> WILC1000/3000 porting guide[1 -page 18], which is already used by most
> of the existing users. This change has impact on the users who are using
> DT entry from porting guide. One approach is to retain the current code
> and document this if needed.

So if I'm understanding the situation correctly Microchip's porting
guide[1] doesn't match with kernel.org documentation[2]? I'm not the
expert here but from my point of view the issue is clear: the code needs
to follow kernel.org documentation[2], not external documentation.

I'll add devicetree list so hopefully people there can comment also,
full patch available in [3].

Alexis, if there are no more comments I'm in favor submitting the revert
you mentioned.


[1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATWILC1000-ATWILC3000-=
ATWILC-Devices-Linux-Porting-Guide-User-Guide-DS70005329C.pdf

[2] Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml

[3] https://patchwork.kernel.org/project/linux-wireless/patch/20240213-wilc=
_1000_reset_line-v1-1-e01da2b23fed@bootlin.com/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

