Return-Path: <linux-kernel+bounces-139837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178288A084C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E232282035
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7F13CAAC;
	Thu, 11 Apr 2024 06:17:27 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249D13BC35;
	Thu, 11 Apr 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816246; cv=none; b=tmBUNQMLwQsxjPIKyepPLIJv1VuPZHqoaNSmVR1suKC8gOG6mhtDuxFYCTR9qVDr4y/XGGy7V4S7b3gBMh214B52S8s95KcT1cM/Ug/eVvE0drXCuj/xt8jRcr6Z/zOeGn5t6hLYs8kG4zhrCVzaOCkj74e2eF7Hpfs9iSsShAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816246; c=relaxed/simple;
	bh=/wHBBom/L2Wj0douxGIcITeM114VTKnN34fxebR3uuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te0OtTT8zwv48f6sCTNjwzVnXkTsETYcq8H5ROgXdfxbmQKk5dzQbkwH/5d2dS8mow49WfwV/Q5Sp6L2/N+cxlWj2k721QanNGSND543qGNS5PxaaoxeIWHVCBJTl+3x6Q85183f1URFQAGVel+QRSKYw6twIcBs31i/vt6PpEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id DC3E9140562; Thu, 11 Apr 2024 08:17:14 +0200 (CEST)
Date: Thu, 11 Apr 2024 08:17:14 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: ucsi_glink: drop special handling for
 CCI_BUSY
Message-ID: <ZheAahcOoGemxGgw@cae.in-ulm.de>
References: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
 <20240409-qcom-ucsi-fixes-bis-v2-3-6d3a09faec90@linaro.org>
 <ZhWWYQMluJCvYFKF@cae.in-ulm.de>
 <CAA8EJprTbtTSkZ18dejEgvhJOEQKQiwpE+6JkbHiO4H-yeKuhg@mail.gmail.com>
 <ZhZCsyeXa093OZnR@cae.in-ulm.de>
 <s2w7qfrbm3lq46hp4r4grmljg7cs24d6lmpiqr2mllxszte6wc@w7rh47o3z6rc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2w7qfrbm3lq46hp4r4grmljg7cs24d6lmpiqr2mllxszte6wc@w7rh47o3z6rc>


Hi Dmitry,

On Thu, Apr 11, 2024 at 12:09:31AM +0300, Dmitry Baryshkov wrote:
> On Wed, Apr 10, 2024 at 09:41:39AM +0200, Christian A. Ehrhardt wrote:
> > 
> > Hi Dmitry,
> > 
> > On Wed, Apr 10, 2024 at 01:58:58AM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 9 Apr 2024 at 22:26, Christian A. Ehrhardt <lk@c--e.de> wrote:
> > > >
> > > >
> > > > Hi Dmitry,
> > > >
> > > > On Tue, Apr 09, 2024 at 06:29:18PM +0300, Dmitry Baryshkov wrote:
> > > > > Newer Qualcomm platforms (sm8450+) successfully handle busy state and
> > > > > send the Command Completion after sending the Busy state. Older devices
> > > > > have firmware bug and can not continue after sending the CCI_BUSY state,
> > > > > but the command that leads to CCI_BUSY is already forbidden by the
> > > > > NO_PARTNER_PDOS quirk.
> > > > >
> > > > > Follow other UCSI glue drivers and drop special handling for CCI_BUSY
> > > > > event. Let the UCSI core properly handle this state.
> > > > >
> > > > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > >  drivers/usb/typec/ucsi/ucsi_glink.c | 10 ++++------
> > > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> > > > > index 9ffea20020e7..fe9b951f5228 100644
> > > > > --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> > > > > +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> > > > > @@ -176,7 +176,8 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
> > > > >       left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
> > > > >       if (!left) {
> > > > >               dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
> > > > > -             ret = -ETIMEDOUT;
> > > > > +             /* return 0 here and let core UCSI code handle the CCI_BUSY */
> > > > > +             ret = 0;
> > > > >       } else if (ucsi->sync_val) {
> > > > >               dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
> > > > >       }
> > > > > @@ -243,11 +244,8 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
> > > > >               ucsi_connector_change(ucsi->ucsi, con_num);
> > > > >       }
> > > > >
> > > > > -     if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
> > > > > -             ucsi->sync_val = -EBUSY;
> > > > > -             complete(&ucsi->sync_ack);
> > > > > -     } else if (ucsi->sync_pending &&
> > > > > -                (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
> > > > > +     if (ucsi->sync_pending &&
> > > > > +         (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
> > > > >               complete(&ucsi->sync_ack);
> > > > >       }
> > > > >  }
> > > >
> > > > This handling of the command completion turned out to be racy in
> > > > the ACPI case: If a normal command was sent one should wait for
> > > > UCSI_CCI_COMMAND_COMPLETE only. In case of an UCSI_ACK_CC_CI
> > > > command the completion is indicated by UCSI_CCI_ACK_COMPLETE.
> > > >
> > > > While not directly related, a port of this
> > > >     https://lore.kernel.org/all/20240121204123.275441-3-lk@c--e.de/
> > > > would nicely fit into this series.
> > > 
> > > Ack, I'll take a look.
> > 
> > Thanks.
> > 
> > > However... I can not stop but notice that CCG and STM32 glue drivers
> > > use the same old approach as we do. Which probably means that they
> > > might have the same issue.
> > 
> > I did ping the ccg people wrt. this but they have a different
> > workaround that saves them at least most of the time, so I let
> > this drop.
> > 
> > > Could you please consider pulling up that
> > > code into the UCSI driver? Maybe the low-level code really should just
> > > read/write the messages, leaving all completions and CCI parsing to
> > > the core layer?
> > 
> > I did consider that but one of the ideas behind the new API for
> > UCSI backends was that backends can send commands (e.g. as part of
> > a quirk) even in the middle of a ->sync_write() call. Currently,
> > I don't really see how to combine this with completion handling
> > in the UCSI core.
> > 
> > > > I don't have the hardware to do this myself.
> > 
> > I did propose other changes to the API with little respone here:
> >     https://lore.kernel.org/all/20240218222039.822040-1-lk@c--e.de/
> > That could possibly be extended to achieve this. But again, that
> > would require testers for all the backends.
> 
> Well, I think that the patchset is too intrusive and (from the
> pmic-glink perspective) is too low-level.

Point taken.

> I'd start by pulling the sync_write() into the core layer, leaving just
> async_write in the glue layer. The async_write() then can be renamed to
> something like send_cmd(). Once required we can add the data pointer to
> this callback.

Fine with me.

However, this basically looks to me what we had before the transition
from the old to the new API wrt. command completion. So it basically
used to be that way and it was changed bei Heikki for a reason.
See below.

> I liked the idea of getting the CCI from the notification (in case of
> pmic-glink it works this way on all platforms except sc8180x).

Yeah. ACPI has a quirk to do just this for some platforms that won't
work properly otherwise. Additionally, strange things can happen if
CCI changes between command completion and the re-read in the UCSI
core. E.g. a command that ran into a timeout could be completed by
then or a busy flag seen in the event handler could be gone.

What's also nagging at me is the not so obvious fact that the
notification handling can but doesn't have to happen under the PPM
lock. So whatever we do there may still happend in the middle of a
->sync_write(). But maybe we should think about this later.

> So what about having a really simple interface:
> 
> sruct ucsi_operations {
> 	/*
> 	 * send the command without waiting for the result
> 	 * can be extended with u8 *data, size_t data_len once
> 	 * necessary.
> 	 * maybe use u8 control[8] instead of u64 control.
> 	 */
> 	int send_command(struct ucsi *, u64 control);
> 
> 	int read_data(struct ucsi *, void *buf, size_t len);
> 	int read_version(struct ucsi *, u16 *version);
> 	/* to be used only for reset handling */
> 	int read_cci(struct ucsi *, u32 cci);
> 
> 	// other ops like update_altmode, as is
> };

In the Dell quirk for ACPI the ->sync_write operation (at one point)
did the following (simplified):

- Send the command to the PPM and wait for the result
- If the command was an ACK for a connector change send another
  ack and wait for the result.
- Report the result of the original command to the UCSI core.

I.e. the quirk post-processes the result of the original command,
possibly sending other commands in the process.

The command completion was pushed into the backends when the new
API was introduced to allow this type of thing and keep it contained
in the backends and not in the UCSI core. See
   https://lore.kernel.org/all/20190926100727.71117-10-heikki.krogerus@linux.intel.com/
or the commit message of bdc62f2bae8fb0e8e99574de5232f0a3c54a27df
in mainline.

> /* to be called by the glue driver once it gets the notification from
>  * PPM */
> void ucsi_notify(struct ucsi *ucsi, u32 cci);
> 
> This way we can pull all the common ACK/connection_changed/completion
> code into the core, while keeping glue layers flexible enough.

I'm not saying that we shouldn't do this. But I'm pointing out that
doing it differently seems to have been a deliberate decision...


Best regards,
Christian

