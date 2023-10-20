Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2E47D13F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377837AbjJTQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:28:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9EAD57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:28:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507973f3b65so1518916e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697819286; x=1698424086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97Ne1RJP4pw4GszjpVk51BTUsCG1MALd+JeCrnEPXbI=;
        b=jwrSSxsopwf2yPaBFcFdTV6WLqEATBmTsWKNCQb0xNgKRFfjeHg95jjo73fYPiE+ic
         5aikq0uMW1NtvUCyb3Dv2/nKGs/TV7vO00kOKJe1sRR3LfAinsWb/qWpX0lQaQvtcoI8
         i6qeDgdEHD0UohitmVOUKYPaNYrKFkJJz98xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819286; x=1698424086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97Ne1RJP4pw4GszjpVk51BTUsCG1MALd+JeCrnEPXbI=;
        b=q662uaMDPoK9k+yTUZfhVXztfRAhTKslMI6eml85cQvR/AIdXzzpVCJCoqb0bagb3s
         d3re3VjPk7YWKRiEBJR+OiDnvMo/7d9kEGAUKwitQ29cqtacEsOj7PLx1UiaoxJrnXL1
         1e9F7xUFvV7dduXBtlev4F1B89acO3LgjE7bogAPdEByFuM5Z6+6mQi9wMbWN+wTDt4K
         n7UXilzElm69iy9s/6ImGU1xMGxkf3Iks4ISaWv/DX8qu5787kRGxbN7gLkmBOdXd15t
         3dJqd97DNAHVvGv1726qkdQOC4u9FbDK/pj9FBbUrbk7WEa1NJRwNdBgAK5uGU4XMJJv
         aG5Q==
X-Gm-Message-State: AOJu0YzkTyhyR3pSEhKTrlJ7mtvssbdPQfE7ebS1YhPV2U4S2sctOzhs
        VeV8YBvYYQP5sjjVt0WvAJxdA4QyE1gvnr/dp5/PXMjv
X-Google-Smtp-Source: AGHT+IELKlLtvna3fkS+4dlrEvghFve3plG7bL3YsXZxYMyFIKPNT9yZiJnKbIs6LcD2sYTUY86K6A==
X-Received: by 2002:a05:6512:4005:b0:503:7dd:7ebc with SMTP id br5-20020a056512400500b0050307dd7ebcmr2228579lfb.18.1697819285831;
        Fri, 20 Oct 2023 09:28:05 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id la5-20020a170906ad8500b009adce1c97ccsm1763928ejb.53.2023.10.20.09.28.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 09:28:05 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40837124e1cso77615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:28:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3488:b0:400:c6de:6a20 with SMTP id
 a8-20020a05600c348800b00400c6de6a20mr118680wmq.3.1697819284470; Fri, 20 Oct
 2023 09:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231020083125.1.I3e5f7abcbf6f08d392e31a5826b7f234df662276@changeid>
 <60a358c9-b44b-4d25-9a20-aa9e00c65ab6@rowland.harvard.edu>
 <CAD=FV=VQ22p7iDdzK-CXOBEqpu0b3J=LKRZuPcajQWFUmr=1cA@mail.gmail.com> <2b6352b1-e192-47d6-bdce-b63216ab674b@rowland.harvard.edu>
In-Reply-To: <2b6352b1-e192-47d6-bdce-b63216ab674b@rowland.harvard.edu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Oct 2023 09:27:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vv+xiJu0MwEgF9VpdzcQVmmCE+m2Msa09QXB_gh4U=Hg@mail.gmail.com>
Message-ID: <CAD=FV=Vv+xiJu0MwEgF9VpdzcQVmmCE+m2Msa09QXB_gh4U=Hg@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Prevent infinite loops when usb_reset_device() unbinds/binds
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ray Chi <raychi@google.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Rob Herring <robh@kernel.org>, Roy Luo <royluo@google.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 20, 2023 at 9:23=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Oct 20, 2023 at 08:59:42AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Oct 20, 2023 at 8:46=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Fri, Oct 20, 2023 at 08:31:38AM -0700, Douglas Anderson wrote:
> > > > When we call usb_reset_device() and a driver doesn't implement
> > > > pre_reset() and post_reset() methods then the USB core will attempt=
 to
> > > > unbind and rebind the driver in order to make reset work. This is a
> > > > great general solution, but it has the potential to loop forever.
> > > > Specifically, if the USB device is in a state that the USB device
> > > > driver issues another usb_reset_device() after each rebind then we'=
ll
> > > > just continually unbind and rebind with no end.
> > > >
> > > > It's difficult to address this condition in a USB device driver
> > > > because it's hard for the driver to keep state across each
> > > > unbind/bind.
> > >
> > > How about just adding appropriate pre_reset() and post_reset() method=
s?
> > > This is precisely what they are meant for.  Then the the unbind/rebin=
d
> > > loop wouldn't ever get started.
> >
> > Right, and we have pre_reset() and post_reset() in the r1852 driver.
> > The issue is that we are seeing occasional control transfer errors
> > while the r8152 driver is still running its probe() routine and we
> > want to reset in response to those. It is relatively difficult to have
> > the pre_reset() and post_reset() methods work properly if failures
> > happen and probe() hasn't finished yet.
>
> Why is that?
>
> >  The current proposal I have
> > for the r8152 driver is to have the pre_reset() routine return -EIO if
> > we saw errors during probe, which tells the USB core to unbind/rebind
> > us. This gets us to a known good state.
>
> Don't you also get to a known good state if pre_reset() and post_reset()
> both return 0?  Then there's no unbinding, so the driver can just jump
> back to the start of its probe() routine.  Or fail the probe, if there
> have been too many errors.
>
> >  If we need to do a reset later
> > on (after probe finished successfully) then pre_reset() and
> > post_reset() can avoid the unbind/bind.
> >
> > The worry was that this could cause an infinite loop. Hence this patch.=
 ;-)
>
> With no unbinding/rebinding, any loops that occur will be entirely under
> the driver's control.  Then it should easily be able to avoid looping
> forever.

Hmmm, OK. Let's see. I guess the most annoying thing would be dealing
with anything "devm". I guess in the case of the r8152 driver, though,
there is no use of devm. Thus I should be able to do this. Let me give
it a shot and see how it looks.

-Doug
