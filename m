Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769C6777E21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjHJQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjHJQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:23:42 -0400
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D68213B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1691684575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHgpc2yvaH3cx+hIFH5Da9fIQ8/pQvNfUhlxlMcCc+E=;
        b=l3KNNnot2aCtwvcOqK/g5wwKhO19AN5wLABypqzuNk9nsaBKlsdOZQjZRluIGnuKeOq2S5
        OyHux3Xn+loUCG0EhxaG+JNHMvorREGrUhLKUVlKvunira9fD3kixqpvIHJOwl5NkffAnq
        rKzCM5PrBixv5LHCbxk+mOzluuVSnaQ=
Received: from g7t14360s.inc.hp.com (g7t14360s.inc.hp.com [15.73.128.135])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-MKOFfla3Np2FCTU5nHI3EA-1; Thu, 10 Aug 2023 12:22:53 -0400
X-MC-Unique: MKOFfla3Np2FCTU5nHI3EA-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by g7t14360s.inc.hp.com (Postfix) with ESMTPS id 5D9AB40;
        Thu, 10 Aug 2023 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
        by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 137C814;
        Thu, 10 Aug 2023 16:22:50 +0000 (UTC)
From:   Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To:     stern@rowland.harvard.edu,
        Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc:     bjorn@mork.no, davem@davemloft.net, edumazet@google.com,
        eniac-xw.zhang@hp.com, hayeswang@realtek.com, jflf_kernel@gmx.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stable@vger.kernel.org, svenva@chromium.org
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is enabled
Date:   Thu, 10 Aug 2023 16:22:16 +0000
Message-Id: <20230810162216.13455-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
References: <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

On Wed, Aug 02, 2023 at 11:23:46AM -0400, Alan Stern wrote:
> On Wed, Aug 02, 2023 at 02:56:43PM +0000, Gagniuc, Alexandru wrote:
> > On Wed, Jul 19, 2023 at 02:36:25PM -0400, Alan Stern wrote:
> > > How do you know that the link will _remain_ in the correct state?
> >=20
> > The objective is to get to xhci_set_link_state() with the USB_SS_PORT_L=
S_U3
> > argument. This is achieved through usb_port_suspend() in drivers/usb/ho=
st/hub.c,
> > and the function is implemented in drivers/usb/host/xhci-hub.c.
> >=20
> > This is the only path in the kernel that I am aware of for setting the =
U3 link
> > state. Given that it is part of the USB subsystem, I am fairly confiden=
t it will
> > show consistent behavior across platforms.
>=20
> That does not answer my question.  I agree that making this change will=
=20
> put the link into the U3 state.  But I don't have any reason to think=20
> that some other software won't later put the link into some other state.

I don't have a rigurous proof that the link will remain in the correct stat=
e.
The only conjecture that I can make is that no other software besides the k=
ernel
will be running at this time. Thus, if the kernel manages to not break the =
link
state, things should work as intended.

> > > That is, how do you know that the shutdown processing for the USB hos=
t=20
> > > controller won't disable the link entirely, thereby preventing WoL fr=
om=20
> > > working?
> >=20
> > We are talking to the USB hub in order to set the link state. I don't s=
ee how
> > specifics of the host controller would influence behavior.
>=20
> Specifics of the host controller probably won't influence behavior. =20
> However, specifics of the _software_ can make a big difference.
>=20
> >  I do expect a
> > controller which advertises S4/S5 in /proc/acpi/wakeup to not do anythi=
ng that
> > would sabotage this capability. Disabling the link entirely would proba=
lby
> > violate that promise.
>=20
> Not if the kernel _tells_ the controller to disable the link.
>=20
> > Think of USB-C docks with a power button showing up as a HID class. The=
 scenario
> > herein would disable the power button. I would take that to be a bug in=
 the host
> > controller driver if the S4/S5 capability is advertised.
>=20
> Indeed.  And I am asking how you can be sure the host controller driver=
=20
> (or some other part of the software stack) doesn't have this bug.

The only way that I have to show that is empirical. I observe that WoL from=
 S5
does not work on a device with an r8153 chip. I apply the change, and verif=
y
that WoL from S5 now works in this scenario. What are you thinking of in te=
rms
of being sure no current or future bug exists?

Alex

