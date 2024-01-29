Return-Path: <linux-kernel+bounces-42285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB0B83FF01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B841C21FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DD4E1DD;
	Mon, 29 Jan 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnZ7FnzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2564E1C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706513507; cv=none; b=pKdMR2jcH2GtOYUzucKwrpyK61nUzAJNXo2Br30pWHHI/CMmNquV5ZfQbGlZ1dBiO2El/IN8eSueri3jScwS1wAAIr8qOU1pmpwjqAWaZJIEmFKWJkh2jeaY2ov+dcdIrE/lPOU4kfrCBwArW4ZglqhRGuwPLeK+FvrbOYXVpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706513507; c=relaxed/simple;
	bh=zTvM8g7lJbOgeOXvTdMOMqRDVbbT0ywuK+IPSCKi1Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz06aVJQOhFDv7umekSF7pWfo62ddr7Z7Ok8a5YuBmvyRmSND99lSHYd/4Ec0kYo0sh0nBb7WpJPTMiREn0LjDIIIeki698WR342aFpGrWWARDrhCgncp29qp1LN+p9t7pzPDj0JlnwKkQE+/9C3QJA5dMdVN0aZltJTu0v1ibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnZ7FnzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E81C433C7;
	Mon, 29 Jan 2024 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706513506;
	bh=zTvM8g7lJbOgeOXvTdMOMqRDVbbT0ywuK+IPSCKi1Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnZ7FnzNWOIBlHZMlMp4TgGLjdRC09w96H6jwRXzQk+EWwKdbty2Aer11qqIwHBSU
	 KiWGgMe2Ui0ezstQ+Bve6xHeMlEh4bd3b6yV6NKezUCMXFQWZPACFAHEerWoeS0KRR
	 JLbU7PKoB+0XfOD96f/Cp2HIqtvzIenm/w/OtncW5kli+qSat59mw5a1C8ziziAke+
	 lpbEGAsG0Q6cxLWBXx3A9saO5OYEL8NcEpJmSNpPsIJOrc+6kNuMTb5G2v5yX3HnhB
	 C8G6RMgvswOzmRJ9zulhqbBM4uNvqs0NFLrjdMLmFkmQs5KTgo15WFaOZnb4dx0g2G
	 ytGSP9ul4qGug==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rUM7H-000000003Yl-1uxJ;
	Mon, 29 Jan 2024 08:31:39 +0100
Date: Mon, 29 Jan 2024 08:31:39 +0100
From: Johan Hovold <johan@kernel.org>
To: VAMSHI GAJJELA <vamshigajjela@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH v1 RESEND] spmi: hisi-spmi-controller: Fix kernel panic
 on rmmod
Message-ID: <ZbdUW3GYVu6zF9QQ@hovoldconsulting.com>
References: <20240126061153.2883199-1-vamshigajjela@google.com>
 <ZbNq9q5mM6kRq7c3@hovoldconsulting.com>
 <CAMTSyjqOj64z3-mDm1pdQ5bi9ZM3j_cr7iSdCtvo40RyJrh38Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMTSyjqOj64z3-mDm1pdQ5bi9ZM3j_cr7iSdCtvo40RyJrh38Q@mail.gmail.com>

On Mon, Jan 29, 2024 at 10:13:22AM +0530, VAMSHI GAJJELA wrote:
> On Fri, Jan 26, 2024 at 1:48 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Jan 26, 2024 at 11:41:53AM +0530, Vamshi Gajjela wrote:
> > > Ensure consistency in spmi_controller pointers between
> > > spmi_controller_remove/put and driver spmi_del_controller functions.
> > > The former requires a pointer to struct spmi_controller, while the
> > > latter passes a pointer of struct spmi_controller_dev, leading to a
> > > "Null pointer exception".
> > >
> > > 'nr' member of struct spmi_controller, which serves as an identifier
> > > for the controller/bus. This value is assigned a dynamic ID in
> > > spmi_controller_alloc, and overriding it from the driver results in an
> > > ida_free error "ida_free called for id=xx which is not allocated".
> >
> > No Fixes tag?

> There isn't a bug, I will remove word "Fix"

Both of the issues you point out above sounds like bugs that deserve a
Fixes tag.

> > > Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> > > ---
> > >  drivers/spmi/hisi-spmi-controller.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
> > > index 9cbd473487cb..af51ffe24072 100644
> > > --- a/drivers/spmi/hisi-spmi-controller.c
> > > +++ b/drivers/spmi/hisi-spmi-controller.c
> > > @@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
> > >
> > >       spin_lock_init(&spmi_controller->lock);
> > >
> > > -     ctrl->nr = spmi_controller->channel;

> This remains applicable, however, it could lead to a failure in the
> spmi_ctrl_release, I
> will refactor the patch to address this.
> also "spmi_del_controller" is removed from 6.7.2

No, this has not changed in 6.7.2, it has been removed from 6.8-rc1.

> > >       ctrl->dev.parent = pdev->dev.parent;
> > >       ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
> > >
> > > @@ -326,7 +325,8 @@ static int spmi_controller_probe(struct platform_device *pdev)
> > >
> > >  static void spmi_del_controller(struct platform_device *pdev)
> >
> > This function does not exist in mainline so presumably this is some bug
> > you've introduced in your downstream driver that you're trying to fix.
> >
> > So this patch looks all bogus.

> spmi_del_controller is present until in 6.7.2, I have made this patch
> in last week of Dec,
> I should have checked before resending, apologies.

The bug you found was apparently accidentally fixed by commit
490d88ef548d ("spmi: hisi-spmi-controller: Use
devm_spmi_controller_add()") in 6.8-rc1 but I don't see any record of it
having been backported yet.

As it depends on new helper function that will likely not happen either.

Perhaps you can split your patch in two separate fixes and ask the stable
team to backport the driver-data one.

> > >  {
> > > -     struct spmi_controller *ctrl = platform_get_drvdata(pdev);
> > > +     struct spmi_controller_dev *spmi_controller = platform_get_drvdata(pdev);
> > > +     struct spmi_controller *ctrl = spmi_controller->controller;
> > >
> > >       spmi_controller_remove(ctrl);
> > >       spmi_controller_put(ctrl);

Johan

