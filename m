Return-Path: <linux-kernel+bounces-118229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C488B6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F777B23E33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E622E1CA87;
	Tue, 26 Mar 2024 01:07:47 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794681B285;
	Tue, 26 Mar 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415267; cv=none; b=MZatSkcLION8mBwF2I+biSLeXHzG3iLIhTt10h+zeQNE2vzopxCGPL/xN20WUXU/gbZM2v/etykBzjc7r5acpUxTPNH91mWas6WauvVhB5OxgMB/0qtmp60l23hykV9SZ/8UsjSeU8pL4ddT/lGr5PpCjuGh9QbyiM5vRc2vRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415267; c=relaxed/simple;
	bh=0sFGD6xlUDUpJANNoNCrnXm2HMedIdT9s1Q0TnST8Lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYIxNtXmTsEnu/fbWOi2QxYN+Ck+KAACzyizdS2PZ039NyUMdtgFEgn/XUEx9/ZydRQMNvZaQsaoBiHAnZRId2miRHyCEln0BSo6Y+hecb6kbNsvRn85sa7dzfX8X+UBV1myYboqP8ssBO93qNVmcWA103KEsFAP51a7sr2Xl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076AFF.0000000066021FDF.0023B398; Tue, 26 Mar 2024 02:07:43 +0100
Message-ID: <6e6b75a15cdc6a1239edc4d49b927b187ed20054.camel@irl.hu>
Subject: Re: [PATCH] uvcvideo: Remo OBSBOT quirk fix for incorrect relative
 min pan/tilt/zoom speeds
From: Gergo Koteles <soyer@irl.hu>
To: johnebgood@securitylive.com,
  Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
  linh.tp.vu@gmail.com, ribalda@chromium.org, John Bauer <john@oxt.co>
Date: Tue, 26 Mar 2024 02:07:42 +0100
In-Reply-To: <20240325-obsbot-quirk-fix-relative-ptz-speed-v1-1-0eb1387d98c7@securitylive.com>
References: 
	<20240325-obsbot-quirk-fix-relative-ptz-speed-v1-1-0eb1387d98c7@securitylive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi John,

On Mon, 2024-03-25 at 19:38 -0500, John Bauer via B4 Relay wrote:
> From: John Bauer <johnebgood@securitylive.com>
>=20
> The OBSBOT series of cameras misreports the minimum relative
> pan_speed, tilt_speed and zoom_continuous v4l2 controls resulting
> in the inability to control the camera with finesse with an analog
> stick or other programmatic methods. This patch applies to all
> Remo (OBSBOT) vendor cameras with the vendor ID of 0x3564. If the
> vendor fixes the firmware this behavior should still remain valid.
> With this broad vendor fix when new devices are released the kernel
> module won't need to be modified. When the vendor fixes the firmware the
> device list can be modified with finer grained device filters.

I don't think they misreports the values.

The UVC 1.5 spec says:

The bPanRelative field is used to specify the pan direction to move. A
value of 0 indicates to stop the pan, a value of 1 indicates to start
moving clockwise direction, and a value of 0xFF indicates to start
moving counterclockwise direction. <<The GET_DEF, GET_MIN, GET_MAX and
GET_RES requests will return zero for this field.>>

The bTiltRelative field is used to specify the tilt direction to move.
A value of zero indicates to stop the tilt, a value of 1 indicates that
the camera point the imaging plane up, and a value of 0xFF indicates
that the camera point the imaging plane down. <<The GET_DEF, GET_MIN,
GET_MAX and GET_RES requests will return zero for this field.>>

The bZoom field indicates whether the zoom lens group is stopped or the
direction of the zoom lens. A value of 1 indicates that the zoom lens
is moved towards the telephoto direction. A value of zero indicates
that the zoom lens is stopped, and a value of 0xFF indicates that the
zoom lens is moved towards the wide-angle direction. <<The GET_MIN,
GET_MAX, GET_RES and GET_DEF requests will return zero for this
field.>>

So they can't report negative values for GET_MIN, therefore the GET_MIN
of bPanSpeed, bTiltSpeed, b(Zoom)Speed will be the minimum speed of any
direction.

I think it will work with any PTZ camera without the quirk.

Regards,
Gergo



