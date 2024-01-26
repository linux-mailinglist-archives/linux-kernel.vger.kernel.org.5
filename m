Return-Path: <linux-kernel+bounces-40488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C683E18F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A02B24F87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718801EF1E;
	Fri, 26 Jan 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WlvmUiCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D81EEEB;
	Fri, 26 Jan 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293808; cv=none; b=Lv/6fkfrB6w4C+TpFba3iV26VCKvJSpvHt/sn64dDtxvcOQss5g3+l3ifcVGf+tP12vMz4Zy05jVJ1DZhJXX8XUsiklBpmMAXWHhhjAVrbdygGc9xzt6JxB4uYZlqIPPUd4OOGKiAyALHIKinM4ZynqgqRjJ3Gg1Ocumz1sL7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293808; c=relaxed/simple;
	bh=r1iPO4/p+KdP7aPbKTayCFQZhZLES9QOQB3w1XgWTXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WngqTGemjKwVQHw+KovQo5PgC6lAi9PC5cHXE8Qc5iYtC5X06KgH7eLM+ts9gAdyRLrvufX7NRTNbSSFWZmQqrFJ96NUp5ky7CfEqyfhBnaBuFGTXs7kHtUL+tjifu1YVuISKb+N/HXGdzA9DrEESCcylFPk1hz5P14jtGphnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WlvmUiCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7F4C43390;
	Fri, 26 Jan 2024 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706293808;
	bh=r1iPO4/p+KdP7aPbKTayCFQZhZLES9QOQB3w1XgWTXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlvmUiCRvLDQ2vd/wm+2tWCovlZu3J+4cFGiL23t0nJUYLOkJYwIzoy98o6X5hHH0
	 ZOwzZeFIcwm9E4vpA3n663/CykU4pJn+2Ke3TpGkpbLm8cCcGe7rJeguPJ4XP5z279
	 A0+gdwXU7EsOgDP8rueGyEhcusDL7z/YjIL+5Ing=
Date: Fri, 26 Jan 2024 10:30:07 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, jthies@google.com, pmalani@chromium.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Update connector cap and status
Message-ID: <2024012612-giggling-diabetes-3a74@gregkh>
References: <20240125004456.575891-1-abhishekpandit@google.com>
 <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
 <2024012512-haphazard-mobster-f566@gregkh>
 <CANFp7mWzA5df9iFpCWFRpXuOP06yDmBehYDYNACjrW2fPvp_Ow@mail.gmail.com>
 <2024012555-nuclear-chummy-6079@gregkh>
 <CANFp7mVPahm+6MjD_+MWMNUz=RViNh777h=Q2dW0UVVDK6dA0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mVPahm+6MjD_+MWMNUz=RViNh777h=Q2dW0UVVDK6dA0A@mail.gmail.com>

On Fri, Jan 26, 2024 at 10:08:16AM -0800, Abhishek Pandit-Subedi wrote:
> On Thu, Jan 25, 2024 at 5:50 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 25, 2024 at 04:21:47PM -0800, Abhishek Pandit-Subedi wrote:
> > > On Thu, Jan 25, 2024 at 3:03 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jan 24, 2024 at 04:44:53PM -0800, Abhishek Pandit-Subedi wrote:
> > > > > diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> > > > > index bec920fa6b8a..94b373378f63 100644
> > > > > --- a/drivers/usb/typec/ucsi/ucsi.h
> > > > > +++ b/drivers/usb/typec/ucsi/ucsi.h
> > > > > @@ -3,6 +3,7 @@
> > > > >  #ifndef __DRIVER_USB_TYPEC_UCSI_H
> > > > >  #define __DRIVER_USB_TYPEC_UCSI_H
> > > > >
> > > > > +#include <asm-generic/unaligned.h>
> > > >
> > > > Do you really need to include a asm/ include file?  This feels very
> > > > wrong.
> > >
> > > I didn't see any header in include/linux that already had these
> > > unaligned access functions so I opted to include
> > > asm-generic/unaligned.h. Is there a reason not to use an asm/ include
> > > file?
> >
> > Yes, you should never need to include a asm/ file, unless you are
> > arch-specific code.
> >
> > But the big issue is that you don't really need this, right?
> 
> The UCSI struct definitions have lots of unaligned bit ranges (and I
> will be refactoring <linux/bitfield.h> to support this but that's
> coming later). As an example, the GET_CONNECTOR_STATUS data structure
> has unaligned fields from bit 88-145.
> Rather than define my own macro, it was suggested I use the
> get_unaligned_le32 functions (see
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5195032/3..4/drivers/usb/typec/ucsi/ucsi.h#b183).
> 
> I did a quick ripgrep on the drivers folder -- it looks like the "You
> should never need to include a asm/ file unless you are arch specific"
> isn't being followed for this file:
>   $ (cd drivers && rg -g '*.h' "unaligned\.h" -l) | wc -l
>   22
> 
> The unaligned access functions (get_unaligned_le16,
> get_unaligned_le32, etc) are really useful and widely used. Maybe they
> SHOULD be exposed from a <linux/unaligned.h> since they are so useful?
> I can send a follow-on patch that creates <linux/unaligned.h> (that
> simply just includes <asm/unaligned.h>) and moves all includes of
> <asm/unaligned.h> outside of "arch" to the linux header instead (this
> will also create a checkpatch warning now as you are expecting).

This is being worked on, see:
	https://lore.kernel.org/r/20231212024920.GG1674809@ZenIV

thanks,

greg k-h

