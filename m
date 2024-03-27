Return-Path: <linux-kernel+bounces-122142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4A88F2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B061C25CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E415445B;
	Wed, 27 Mar 2024 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzM5YKFv"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AD5338C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581210; cv=none; b=E7sO2Kienzah69Ye9WWOT/v8kWmpt1Dq4T0kRtoj8uFX9zbPLG4NAwJBOSYi5WLghxahUTfiYp3cGWIOfulmYPOjBQqlN9N0Fg6IbPwswiV5imdH9yGwtMaSkkMBavDxciVANhzNPzBomR7qAcTxEm4AYWnrNP7UIXEBBeq6TaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581210; c=relaxed/simple;
	bh=x8cE07s1UqGRQsBqsU0zimnFISfZSQU9RFeRK3ngzHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBQRRcsFAu8CT4JBSIhFfOShForqUbwfUaGY9tbCXeLbCE6p/2F5MtVNSV5CxW9qOb1n73icsGYzMyL34SqF75wPJkBQY5llIBdomgLqM528X7R24+DCLIbcXX88wJyUSY6ImKp81zcoTFnF7YYjMTWWCELdadI/KfnNIHXRlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kzM5YKFv; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d47000f875so140648e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711581207; x=1712186007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DrxLRBZT/LUI/LSfZvqLhgDZX5TOENkmG0pV3Ea5ME=;
        b=kzM5YKFvD84pbEzyvePPgw7ekcnrKBuJAmZ46vu72CNBCeXwMGXtInckL+cpK62Muv
         +bje5gDFTVyzVNcEeNd51RFxateg+83qiplgBIn8wUgso1kTlc7ymojTiFXb/QTpye6P
         uheZoPoOOVqsvtHFJdrQdEkGP/SNP2c/PFm0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581207; x=1712186007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DrxLRBZT/LUI/LSfZvqLhgDZX5TOENkmG0pV3Ea5ME=;
        b=UjGToByN0WSGI3iVyNmQ+NdRUQKdR9DdOiAPoQ0CckaWieo+HhSheS2ewgLRZXH59F
         lyUmsTy0N6ETwbouJW0eLek/bwl3FR+m9VTcTwJCelHsAQq6XXX4ZVuU2rbfTCU6TktX
         7UXmJqdlCf3tFOMLtVgBspp11uSdXnQP4ayCibm9oeta7Yp/dZbLOs4BCHS+uDfjo8BH
         PtahznXFt/6H0E3+KwUOEyK05GPFlr/P4fSDy7B5gBQdfvy6jtvIHFW7o5H+H5VDX6LD
         MmroUzDPEE/5o/K3FOtBHwdN56ry0SdUaf1cuIUCApknoaDkIWrUP8mK8FwXcEWowcwT
         LWBg==
X-Forwarded-Encrypted: i=1; AJvYcCUADkN0iT7RbPLPZN6JfcADk3VrPNH4yjjFDcLD4TPYajG0PieIUh6JK2EKumCKH02SWDqCExKbUKnnnRt/1BRq95ajkN+1kcmKdjN3
X-Gm-Message-State: AOJu0YxTun1wTm/MDA5k6Jm5fm4kXFkwML5VU4/Hcq0vC1EzvCt/e75u
	pbsb2LB8TDnB617k6sZJwPMtUG+2gTv5uHXGsYrM1IoxHm4SaQbsF1RH7BvoQC+JUrkY1iZZtA3
	Z+D0kuAUX4t+3tI9VwJXtFXhmcemgoYsgWkNj5vtEb5vjNx8=
X-Google-Smtp-Source: AGHT+IFNiTAiPVrSygmnNPlwiJgtimKuTEmusjzbeSDhBYufdOAyoFEM7oP0Kv5BqWoVO+VD72xZ24UVX9gpOzuhzoc=
X-Received: by 2002:a05:6122:180c:b0:4d4:ef9:719d with SMTP id
 ay12-20020a056122180c00b004d40ef9719dmr1826914vkb.5.1711581207623; Wed, 27
 Mar 2024 16:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org>
 <2024032624-subtitle-crisped-f4f1@gregkh> <CAB2FV=4Z1W1HSba50KaB3rR4=Ussb5RWPwUArr0_=3pFwxpAhA@mail.gmail.com>
 <ZgP8hqNXuMdkp7A5@kuha.fi.intel.com>
In-Reply-To: <ZgP8hqNXuMdkp7A5@kuha.fi.intel.com>
From: Pavan Holla <pholla@chromium.org>
Date: Wed, 27 Mar 2024 16:12:51 -0700
Message-ID: <CAB2FV=5pDxSiAGtYDUEbRLb-OtGP8d6duAP6+yD6eFdcRsC1Fg@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: Wait 20ms before retrying reset
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 4:01=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> Normally the driver does not retry the reset, so maybe you should just
> say "wait 20ms before reading the CCI after reset", or something like
> that.
>
> The idea here is to give the PPM time to actually update that field
> before reading it, right?

Yes, that's the idea. I will change the commit message in v2.

> On Tue, Mar 26, 2024 at 04:34:44PM -0700, Pavan Holla wrote:
> > On Tue, Mar 26, 2024 at 1:29=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Mar 25, 2024 at 09:19:43PM +0000, Pavan Holla wrote:
> > > > The PPM might take time to process reset. Allow 20ms for the reset =
to
> > > > complete before issuing another reset.
> > > What commit id does this fix?  Does it need to go to older kernels?
> >
> > This does not fix any commit. However, the time taken by a CCI read is
> > insufficient for a ChromeOS EC and PDC to perform a reset.
>
> Perhaps you could put that to the commit message.

Will do.

> > > > There is a 20ms delay for a reset retry to complete. However, the f=
irst
> > > > reset attempt is expected to complete immediately after an async wr=
ite
> > > > of the reset command. This patch adds 20ms between the async write =
and
> > > > the CCI read that expects the reset to be complete. The additional =
delay
> > > > also allows the PPM to settle after the first reset, which seems to=
 be
> > > > the intention behind the original 20ms delay ( kernel v4.14 has a c=
omment
> > > > regarding the same )
> > >
> > > Why was the comment removed in newer kernels?
> >
> > The comment was removed when the old UCSI API was removed in
> > 2ede55468ca8cc236da66579359c2c406d4c1cba
> >
> > > Where does the magic 20ms number come from?  What about systems that =
do
> > > not need that time delay, did things just slow down for them?
> >
> > I am not sure how 20ms was decided upon. However, UCSI v1.2 has
> > MIN_TIME_TO_RESPOND_WITH_BUSY=3D10ms. So, we need to provide at least
> > 10ms for the PPM to respond with CCI busy. Indeed, this patch slows dow=
n other
> > implementations by 20ms. UCSIv3 also defines a 200ms timeout for PPM_RE=
SET.
>
> It does not slow down other implementations. The delay has always been
> there before the RESET_COMPLETE bit is actually checked.

Ah, maybe other PPM's don't set CCI.busy, and that is probably why a
reset isn't retried for them. The UCSIv1 spec itself might have a typo
in Table 4-2 whereCCI.busy is only allowed to be 0 for a PPM_RESET.
However, figure 4-1 shows that a transition to busy is allowed from
PPM Idle (Notification disabled). Moving the msleep(20) before the CCI
read is probably a good idea anyway since it gives enough time for
CCI.busy to be set. Should we also skip the retry if busy is set?

> The change here makes sense to me. Just rewrite the commit message.

Will do in v2 if I don't receive further feedback.

Thanks,
Pavan

