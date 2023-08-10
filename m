Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BAE7783D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHJWwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHJWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:52:35 -0400
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF42D43
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1691707908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdN5At1lK1yQ6mtkPI5LWolmrULbcIojF+miizbUjIw=;
        b=RUusJdm+by5GeXdf+RImvhW9iEg6zCZeeZT6D5Qp71KIYpCgv9N4FTorpE34sLWwSDb2gR
        sH9L6fDMM5RRyN+EJPgdDyljSR3MxL/YBQwWRs4OrfNHVxoBzOPbMcAzxIfa57c7GUQFGb
        mS7fpVng93hTT4wv/40RSe+iTSSXiDA=
Received: from g8t01560s.inc.hp.com (g8t01560s.inc.hp.com [15.72.64.154]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-6L6-oMhJN3uud6nvKbImSA-1; Thu, 10 Aug 2023 18:51:47 -0400
X-MC-Unique: 6L6-oMhJN3uud6nvKbImSA-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g8t01560s.inc.hp.com (Postfix) with ESMTPS id 7A03C201FF;
        Thu, 10 Aug 2023 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
        by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 20AE414;
        Thu, 10 Aug 2023 22:51:43 +0000 (UTC)
From:   Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To:     stern@rowland.harvard.edu
Cc:     alexandru.gagniuc@hp.com, bjorn@mork.no, davem@davemloft.net,
        edumazet@google.com, eniac-xw.zhang@hp.com, hayeswang@realtek.com,
        jflf_kernel@gmx.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stable@vger.kernel.org, svenva@chromium.org
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is enabled
Date:   Thu, 10 Aug 2023 22:51:09 +0000
Message-Id: <20230810225109.13973-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <78e3aade-2a88-42f4-9991-8e245f3eb9b9@rowland.harvard.edu>
References: <78e3aade-2a88-42f4-9991-8e245f3eb9b9@rowland.harvard.edu>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:34:39PM -0400, Alan Stern wrote:
> On Thu, Aug 10, 2023 at 04:22:16PM +0000, Alexandru Gagniuc wrote:
> > On Wed, Aug 02, 2023 at 11:23:46AM -0400, Alan Stern wrote:
> > >=20
> > > Indeed.  And I am asking how you can be sure the host controller driv=
er=20
> > > (or some other part of the software stack) doesn't have this bug.
> >=20
> > The only way that I have to show that is empirical. I observe that WoL =
from S5
> > does not work on a device with an r8153 chip. I apply the change, and v=
erify
> > that WoL from S5 now works in this scenario. What are you thinking of i=
n terms
> > of being sure no current or future bug exists?
>=20
> I was thinking that the host controller driver's shutdown method might=20
> turn off power to all of the ports.
>=20
> For example, in the ehci-hcd driver, ehci_shutdown() calls=20
> ehci_silence_controller(), which calls ehci_turn_off_all_ports().  I=20
> don't know if xhci-hcd does anything similar.

EHCI is a different beast. I don't think EHCI (USB2.0) has the U3 link stat=
e.

The equivalent for would be xhci_shutdown(). It makes a call to
usb_disable_xhci_ports() for XHCI_SPURIOUS_REBOOT quirk. As I have not
encountered it, I don't know how it will affect the link state of other por=
ts.
The quirk appears to switch ports to EHCI mode, rather than turn off power.

Alex

