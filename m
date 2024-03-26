Return-Path: <linux-kernel+bounces-119526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE5388CA52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6D1C656F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CF127B7C;
	Tue, 26 Mar 2024 16:56:38 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C91272DD;
	Tue, 26 Mar 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472198; cv=none; b=V3NNhc3V18/8GsgAMk56AFCYBIB939z/hbgoE35T5rag1Xk9RiPpayqRXeBiZvX80zyxLYpJTJeflMvAf6V9CHw+m6J1zrQxLbllkRdfgDat3WkFaWX4FztKDBHnylAN/Yx3O7Ha4wfARqDJmT6bogkiijxpzH8EbSEmB/X3kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472198; c=relaxed/simple;
	bh=IglCwu5f4Ix7p/tpI7GNTvVkN5XfpLJo32H+dnFeqR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JG4qWaRARaTelnOfrdcbRQxqgYoV7kFI9eDfpKyNu1eIu2DkJ7G5qbRI44gkFiUHDt5TIfFJcs9tvkJZcwNuglk6uyOxWyVszyOH6O+39Zz2MwzL6rX+eYuvJMxKOa+5TpJ6EhEJBdjNA9bjYSfz9eQ5Q9xnmQDOl7RneeDLi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000077355.000000006602FE42.0023D51D; Tue, 26 Mar 2024 17:56:34 +0100
Message-ID: <199a8f6e65ab07f48223bbd458683971d7156e55.camel@irl.hu>
Subject: Re: [PATCH] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix.
From: Gergo Koteles <soyer@irl.hu>
To: Ricardo Ribalda <ribalda@chromium.org>,
  johnebgood@securitylive.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Mauro Carvalho Chehab <mchehab@kernel.org>,
  linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
  linh.tp.vu@gmail.com
Date: Tue, 26 Mar 2024 17:56:33 +0100
In-Reply-To: <CANiDSCtdgQhAyeLm89W-zNsMsNAVY0Ey5tZ4XpemzaZHXf8ZFQ@mail.gmail.com>
References: 
	<20240326-uvc-relative-ptz-speed-fix-v1-1-453fd5ccfd37@securitylive.com>
	 <CANiDSCtdgQhAyeLm89W-zNsMsNAVY0Ey5tZ4XpemzaZHXf8ZFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ricardo,

On Tue, 2024-03-26 at 15:22 +0100, Ricardo Ribalda wrote:
> Thanks for your patch. If we confirm that there are no devices with
> ranges [-A,B], with A!=3DB, then it looks like the way to go
>=20

I tried looking for a device that has different speeds for the
positive/negative directions. I couldn't find any with the search
engines.

But I found that the Jabra Panacast (which is an "ePTZ" camera) needs
this patch also, it has the following controls:

pan_speed 0x009a0920 (int): min=3D0 max=3D10 step=3D1 default=3D5 value=3D0
tilt_speed 0x009a0921 (int): min=3D0 max=3D10 step=3D1 default=3D5 value=3D=
0

Regards,
Gergo


