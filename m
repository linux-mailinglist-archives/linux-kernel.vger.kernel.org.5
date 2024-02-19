Return-Path: <linux-kernel+bounces-71137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7B85A131
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B371C218DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2EF28DD1;
	Mon, 19 Feb 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aOUsX6hq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265D286AE;
	Mon, 19 Feb 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339244; cv=none; b=jQA68sUbdQqDPxwjjvCK6dvJjGpDfOAr7zz2BoHBnZighyBOa16M5p/9I59pkuhpUTuueBLUUQbxFqi3nfYMynPGXIv9R+YmoHPFQOaKTJ8Kq+/jSPX4GyBa/hjGBsV/K2TWJCbnLPpnsrYkTH/CF1xhHvSiIKtZlIiOfkj9dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339244; c=relaxed/simple;
	bh=EsN/+7thfuLmfHd8qe3dlDirPQrVnNo5wOQUpPckTFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FabHMd3KcNF6w9/2RdrYcY4Ia48o8vi3K6I+3a8gl0dWSF71flLOT1pL4j8ZNr8z2Vv7c1WxqgZqb5zylCSn9ynoe85NyCJUYe6A/MX9wulxqsmXy3ZEPbwFyif1Lpsbcf7PKjI1PxWfLTSlPySpyDJCx63Lzn92jLo3HC/SQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aOUsX6hq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 05DB966F;
	Mon, 19 Feb 2024 11:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708339235;
	bh=EsN/+7thfuLmfHd8qe3dlDirPQrVnNo5wOQUpPckTFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOUsX6hqtRgcpJKKdJwVdfS6Ke3wRdZUpyPOpuis7GGI4TmZqH6I59LTyWOyjwwR8
	 kgqZRghP3W7mVOE0ua09idjToY1KmSNjwqx9R5dHkBaXpEFjqmgZsSoqAHTsMn3e3F
	 jydIgBCvZHEBy85R1g3PNuZVpNS++Q07MAOVjKas=
Date: Mon, 19 Feb 2024 12:40:46 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 1/6] media: uvcvideo: Fix negative modulus calculation
Message-ID: <20240219104046.GB13043@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-1-55a89f46f6be@chromium.org>
 <20240212225940.GA19316@pendragon.ideasonboard.com>
 <CANiDSCuoskaERyyzuLen+ReGHBNnOrFducbWYAvFQ6HfbUCPcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCuoskaERyyzuLen+ReGHBNnOrFducbWYAvFQ6HfbUCPcg@mail.gmail.com>

Hi Ricardo,

On Mon, Feb 19, 2024 at 11:28:03AM +0100, Ricardo Ribalda wrote:
> On Mon, 12 Feb 2024 at 23:59, Laurent Pinchart wrote:
> > On Wed, Mar 15, 2023 at 02:30:12PM +0100, Ricardo Ribalda wrote:
> > > If head is 0, last will be addressing the index 0 instead of clock->size
> > > -1. Luckily clock->head is unsiged, otherwise it would be addressing
> > > 0xffffffff.
> >
> > I'm not following you. In the expression
> >
> >         (clock->head - 1) % clock->size
> >
> > clock->head is an unsigned int, and 1 as a signed int, so the result of
> > the subtraction is promoted to an unsigned int. When clock->head is 0, the expression evaluates to
> >
> >         0xffffffff % clock->size
> >
> > clock->size is a power of two (hardcoded to 32 at the moment), so the
> > expression evaluates to 31, as intended.
> >
> > Am I missing something ?
> 
> Take a look to: https://godbolt.org/z/xYeqTx6ba
> 
> The expression only works because the size is a power of two. In this
> set I am allowing sizes that are not powers of two.

Could you then update the commit message to explain that ?

I'll review the rest of the series this week.

> > > Nontheless, this is not the intented behaviour and should be fixed.
> > >
> > > Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_video.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index d4b023d4de7c..4ff4ab4471fe 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
> > >               goto done;
> > >
> > >       first = &clock->samples[clock->head];
> > > -     last = &clock->samples[(clock->head - 1) % clock->size];
> > > +     last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
> > >
> > >       /* First step, PTS to SOF conversion. */
> > >       delta_stc = buf->pts - (1UL << 31);

-- 
Regards,

Laurent Pinchart

