Return-Path: <linux-kernel+bounces-28429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D615A82FE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E1F2889FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128C1C11;
	Wed, 17 Jan 2024 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GHDA1Dtm"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885010F7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455219; cv=none; b=Y6uplQMxzqFmNlr7F70EoNoJ3bD+QEcQzhpYq7fBeJ3DOuBWdMt8aAtyYXmh+R0wex3MtOOm9LKdeiJ/M0upZbBSn9LTiLr3zRctuymDGhf3Th4XrgjrZXawJSf5P/CXQb9kaebcPygUnU2CaVveOH6p+u5QVKlnxpmMrW8D5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455219; c=relaxed/simple;
	bh=miuYmhy7ASQhkQRO0Qe+druGuKMeZzPPMGM1zmtiCRA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=mxp/QCnnGcp2RUMbC3qccEvzwgzt8mcHua9LMNMvRFN6wS5BR3ADXG4jJBNzoMcaTyzKNTZQJNXSIIbeUTzHlsHIf4nh8RcJ3O+R3mN3ylqSu/mJCEf+Bvs+k5uaQvoS7qjtcgm1lwGyP6UAhqa2+Q4RzjvR1l2RMh9dFVC0kEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHDA1Dtm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so11895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705455216; x=1706060016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miuYmhy7ASQhkQRO0Qe+druGuKMeZzPPMGM1zmtiCRA=;
        b=GHDA1DtmDc8O5m8mlxBUowG9Iw77R8fMnA5bomvJ6a36ZlT52DcZLElWmPoqOeGA8N
         /S8rm3AL1NEr544rPv5H1EBFBYMkJEInT66Y5LIkLgJQZt9HYh+AIX1UXOQWXvmXamzj
         eHJjoJqW+9lfAarNNdNFj2iOjoDdZEpoH5ggrXI2K6odIABAi/iSFyPwy2E3D25I53il
         eCLJ98nSL0ovMTl+tEAUjTJOE8LxF/dfBkcMnRC7O5uUUqdd6SGToAwd1IZyWXui7AJB
         lt4Zw+6rGkT301tlMfZVvIzGjqCgJ7ibGRi3VPPLQY0u7b97Y4nSRe3PNIGZpGNMjo4a
         ztGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705455216; x=1706060016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miuYmhy7ASQhkQRO0Qe+druGuKMeZzPPMGM1zmtiCRA=;
        b=JrFodM3DIALbMqIDfPSC2BbUdE7Og/ANPW/CtxyJVqMMOVjVkJeVVgKxPtLUc0GxMS
         hXLTkDC8MAfo97seVrZjf0rN8/B847jS2XLKOIbg7qYof++I/Ab+nKdXhh5m6OHWCTrS
         3HNCMY2lXdAcIHgRgd/aZ8D3PzvQsxTKwZKjh4hiikJYyoLWbbGXl2OyTllHWNSifRo9
         wDmStM2Hl1vilpP+o9CSYbnj9IfTHWLKEkMdl0qcgikhqrDQIKZe6w5Xc89Vw0n1gyMF
         l5Zg34GpCR5UmUncmCa4O143xEzd1WcDgnhq2B+KD/bZuBvBOfxohaGHwrmUiNcKBShd
         Po9A==
X-Gm-Message-State: AOJu0YwdhZBUVyonDhdRTTAs7IEtIbiUiRpCYEXV4/ff0rfZj7G7Z4WN
	5eSpM7TQge4TDAXWwsMsNFw94oLby+0bAqm9mFIZWDDbbHMyevkGM0/D/JE29Y49HKJxhFeVFx7
	wfw9uDhwkeENCw/HieJcsBLQ9BBHaRUVa9GPW
X-Google-Smtp-Source: AGHT+IEi6FH8OZ6MuIKSPEmoilpz7hxXnXwwqiqAhKxS4WLTX3fAKuQwdaDu9RycSYLVRxgYV77MIcAru/cJ2WJeXEQ=
X-Received: by 2002:a05:600c:3b97:b0:40d:5fee:130 with SMTP id
 n23-20020a05600c3b9700b0040d5fee0130mr22884wms.5.1705455215686; Tue, 16 Jan
 2024 17:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102073840.1579540-1-maurora@google.com> <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
 <CAJnM4-wew9b=Ge8QHLRiReNJAqgA0ngOW8WTVk4frta+y+9jYw@mail.gmail.com>
 <20231117015143.nzgqaes256lnz5ht@synopsys.com> <20240117011110.6yubmp4ysd2fit2p@synopsys.com>
In-Reply-To: <20240117011110.6yubmp4ysd2fit2p@synopsys.com>
From: Manan Aurora <maurora@google.com>
Date: Wed, 17 Jan 2024 07:03:22 +0530
Message-ID: <CAJnM4-wqHmvTtkSYbLXfNByPZL4zv-ATwkywK4g7DsAhMtBSZQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"manugautam@google.com" <manugautam@google.com>, "badhri@google.com" <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thinh,

I'm fine with reverting the change until it matches what the intended
use case is. I've added some notes:

On Wed, Jan 17, 2024 at 6:41=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
com> wrote:
>
> Hi Greg/Manan,
>
> On Fri, Nov 17, 2023, Thinh Nguyen wrote:
> > On Thu, Nov 16, 2023, Manan Aurora wrote:
> > > On Sat, Nov 11, 2023 at 4:39=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@sy=
nopsys.com> wrote:
> > > >
> > > > On Thu, Nov 02, 2023, Manan Aurora wrote:
> > > > > Support configuration and use of bulk endpoints in the so-called =
EBC
> > > > > mode described in the DBC_usb31 databook (appendix E)
> > > > >
> > > > > Added a bit fifo_mode to usb_ep to indicate to the UDC driver tha=
t a
> > > > > specific endpoint is to operate in the EBC (or equivalent) mode w=
hen
> > > > > enabled
> > > >
> > > > This should be unique to dwc3, and it's only for bulk. I don't thin=
k
> > > > usb_ep or the user of usb_ep should know this.
> > >
> > > In our use case we have a function driver that configures an allocate=
d bulk
> > > endpoint to operate as an EBC EP. So the function driver already depe=
nds on the
> > > feature.
> >
> > This should be abstracted from the function driver. The function driver
> > should not need to know about this feature.
> >
> > >
> > > dwc3_ep seems like the correct place to put this field but a function
> > > driver that allocates
> > > EPs and configures them for this use case would need to include dwc3 =
headers.
> > > If other vendors offer an equivalent feature this dependency would
> > > become an issue.
> > >
> > > Exporting a symbol from dwc3 is an easy option but dwc3 doesn't
> > > currently export symbols
> > > hence I tried to avoid that
> > >
> > > > Also since DWC3_DEPCFG_EBC_HWO_NOWB must be set, the controller doe=
s not
> > > > write back to the TRB. Did you handle how the driver would update t=
he
> > > > usb request on completion? (e.g. how much was transferred).
> > >
> > > In our use case, we intend to have a link TRB and issue a startXfer
> > > command. Completion
> > > handling and continuing the transfer will be offloaded to dedicated
> > > FIFO hardware.
> > > But we can definitely rework this to disable no-writeback mode by
> > > default and allow this to
> > > be separately enabled
> > >
> >
> > Ok.
> >
>
> Looks like this change was applied to Greg's branch. Unless I'm missing
> something, I don't think my concerns are addressed yet. Here are the
> reiteration of the concerns:
>
> 1) The gadget driver should not need to know the dwc3's FIFO mode. It's
> specific to dwc3 capability and should be handled in dwc3 driver only.
> Usually these properties are selected in device tree bindings and not
> specified through the gadget driver API.

I'm not sure how this will work when we have multiple functions and only
some of them use EBC.The other EPs are working as usual.
In terms of DT binding I can think of forcing certain EPs into EBC mode
and using them for any gadget that needs EBC but that will remove those
EPs from circulation for other functions. It would be great if you could
suggest a good alternative we can use.

>
> 2) This specific mode "EBC" doesn't write back to TRBs. It's not clear
> how this is handled when updating the request's status. It's also only
> applicable to bulk endpoint. If it's to be applied to the usb gadget
> API, it's not documented fully.

I will push a patch to remove the no-writeback bit based on the decision
above.

>
> Thanks,
> Thinh

