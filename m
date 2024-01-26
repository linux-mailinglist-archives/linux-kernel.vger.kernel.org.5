Return-Path: <linux-kernel+bounces-40470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD883E109
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1343C282E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD58208CA;
	Fri, 26 Jan 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQnPfg3o"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF51E881
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292510; cv=none; b=ofmJ9wvUGQ0p85O9xS618h2WttW24aRNxlI9CF41ylysBVQ2qE8Fo3t843OZOmlC3TIUWWPOiU5bymoAaPqOTHNrbp8s6DCz1ORBEYhjuA0FIFkk3Y/wxd6QbFT9BelCKTxFZCU/SgFlwUiEv76O2OU9SB4cGfSDnxxuzxlOYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292510; c=relaxed/simple;
	bh=RTDzr3fJVfMJCa++vJLfjU9JHOuKeluJLhNwk7bkkRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWnIRJ2KpU3/GvCpXmvRspOc3tIImmFnCurPVfXBTBF3rOr74ABs5sJKXhLsRvdECcf9crTu6bgM/UHJ7/7uiz61kqAUDJ1IlhU/13zz3+y8wpyQryK4cABm039HbpyiyWoxPzO6o/Q4DU4yE5/4TF0rKXdFFLGIB94kzq6nDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XQnPfg3o; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so584460276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706292508; x=1706897308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F82Q8YvPyRDi4gXasX8jFdBaqk++UOO164AJI4gTB5s=;
        b=XQnPfg3oIEoZKA7ShgpvUykr4+0WKkJJRSPKidgZ82inXyxxS8f2FnvutpWkhA9hfW
         fFzDlrfwy2Aky3T4doJVj0KGmZpIoDBEEzqt22ydttvySD03DysQxsZhu0+MpEPaS8Ea
         pdkCYW3m7muFwHSIdy91auq8PWzxcum/FQORM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292508; x=1706897308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F82Q8YvPyRDi4gXasX8jFdBaqk++UOO164AJI4gTB5s=;
        b=OMfFOIqCrpavZ5e8cBp+WLmLhLJaacAbr2M0CIgOMDboHL48yL32hc/fVW/dhPgoZR
         XE0ftgaemBKAdFCMD6vzxXURU4VelUPI4TIdakq8U2B/xljMCobzkqQFtlgh0SLiVL7H
         EhqxQGfoAh6TAgZn8dZf5I84TkVpxw/i8HeRLNqZCWU2BsZsO+cU2IRUVVk2AeOG8Qlm
         Lz+QfcaNQVE+XHxQJnjIEZ4Oe5fcLIXo6lHgpTnE1aawZc5vjIDcY1ms7jYt7wUW3rH0
         Kxs/Cv/G4SOQdfkPJ7WwsQdSeQDOfDTxOG+nsS7Bf2uPc1R80UsnmqGvsPyCmbBo21NU
         8n5w==
X-Gm-Message-State: AOJu0Yzgt9L76jb2BiUhqGfaTR1wLuPEMBv/3zFmBbx4dDoNj4feXwaz
	09HmGL0OTbpdrjlCiYAmYjZcUxGyoWXVNkZVR4JCizLBUyXJjzWZHAx84q8NphSLVhVaAUa7BQh
	hE4nNO9qLHUNzG2JhuMdnoFr4Xd9zzyBkmsl4
X-Google-Smtp-Source: AGHT+IFvEs5hgMn/PzaxkpWzH5UAqbnTn5LCulqNqr7LKVIWLpOrEaeIfiUQ1C+BnU6VWUJLzkE/mJ8DmLNJNNF2At4=
X-Received: by 2002:a5b:dcf:0:b0:dc6:4b5a:410a with SMTP id
 t15-20020a5b0dcf000000b00dc64b5a410amr276184ybr.12.1706292507700; Fri, 26 Jan
 2024 10:08:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125004456.575891-1-abhishekpandit@google.com>
 <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
 <2024012512-haphazard-mobster-f566@gregkh> <CANFp7mWzA5df9iFpCWFRpXuOP06yDmBehYDYNACjrW2fPvp_Ow@mail.gmail.com>
 <2024012555-nuclear-chummy-6079@gregkh>
In-Reply-To: <2024012555-nuclear-chummy-6079@gregkh>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 26 Jan 2024 10:08:16 -0800
Message-ID: <CANFp7mVPahm+6MjD_+MWMNUz=RViNh777h=Q2dW0UVVDK6dA0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Update connector cap and status
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, pmalani@chromium.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:50=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 25, 2024 at 04:21:47PM -0800, Abhishek Pandit-Subedi wrote:
> > On Thu, Jan 25, 2024 at 3:03=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 24, 2024 at 04:44:53PM -0800, Abhishek Pandit-Subedi wrot=
e:
> > > > diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi=
/ucsi.h
> > > > index bec920fa6b8a..94b373378f63 100644
> > > > --- a/drivers/usb/typec/ucsi/ucsi.h
> > > > +++ b/drivers/usb/typec/ucsi/ucsi.h
> > > > @@ -3,6 +3,7 @@
> > > >  #ifndef __DRIVER_USB_TYPEC_UCSI_H
> > > >  #define __DRIVER_USB_TYPEC_UCSI_H
> > > >
> > > > +#include <asm-generic/unaligned.h>
> > >
> > > Do you really need to include a asm/ include file?  This feels very
> > > wrong.
> >
> > I didn't see any header in include/linux that already had these
> > unaligned access functions so I opted to include
> > asm-generic/unaligned.h. Is there a reason not to use an asm/ include
> > file?
>
> Yes, you should never need to include a asm/ file, unless you are
> arch-specific code.
>
> But the big issue is that you don't really need this, right?

The UCSI struct definitions have lots of unaligned bit ranges (and I
will be refactoring <linux/bitfield.h> to support this but that's
coming later). As an example, the GET_CONNECTOR_STATUS data structure
has unaligned fields from bit 88-145.
Rather than define my own macro, it was suggested I use the
get_unaligned_le32 functions (see
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
5195032/3..4/drivers/usb/typec/ucsi/ucsi.h#b183).

I did a quick ripgrep on the drivers folder -- it looks like the "You
should never need to include a asm/ file unless you are arch specific"
isn't being followed for this file:
  $ (cd drivers && rg -g '*.h' "unaligned\.h" -l) | wc -l
  22

The unaligned access functions (get_unaligned_le16,
get_unaligned_le32, etc) are really useful and widely used. Maybe they
SHOULD be exposed from a <linux/unaligned.h> since they are so useful?
I can send a follow-on patch that creates <linux/unaligned.h> (that
simply just includes <asm/unaligned.h>) and moves all includes of
<asm/unaligned.h> outside of "arch" to the linux header instead (this
will also create a checkpatch warning now as you are expecting).

>
> > > It's also in the wrong place, AND why "asm-generic"?  That also feels
> > > wrong.
> >
> > asm-generic is definitely wrong; I misunderstood how these headers are
> > supposed to be used (should be just asm/unaligned.h).
>
> Why?  What are you requiring this .h file for?
>
> > For ordering, I took a look at some other files and it looks like
> > <asm/...> goes below the <linux/...> includes. This also probably
> > deserves documenting in the style guide.
>
> It is somewhere, checkpatch should complain about it.

Checkpatch only complains if there exists a <linux/foo.h> and you call
<asm/foo.h>: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
git/tree/scripts/checkpatch.pl?h=3Dv6.8-rc1#n5882
That's the only relevant check I found when searched for "asm" in checkpatc=
h.pl

>
> thanks,
>
> greg k-h

