Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF947EE291
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjKPOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjKPOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:18:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB83698
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700144304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=greVKMKfr76MqoUq6gz6BvckYAphWjbfLaTerpqXr4c=;
        b=daSBYZXmz5F9RLls8F2NFpB5EZXfQU3YryFEZYfEatSbxDEH8nrBFQ3i1JWwihMsYbF8Ua
        z5yFUgduVMchPDPdPGlqoFvzPqKCHdtaJ8L0y6pic/ViQ4bnNNxuIF8DMgrn+JZsr77EYD
        EN/YJhOMAxh0zZueclNeGx2jGmEKgMw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-C0cl4XhrPL2OSimzHsOHDw-1; Thu,
 16 Nov 2023 09:18:20 -0500
X-MC-Unique: C0cl4XhrPL2OSimzHsOHDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E9D1C06909;
        Thu, 16 Nov 2023 14:18:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A12A81121306;
        Thu, 16 Nov 2023 14:18:17 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     pabeni@redhat.com
Cc:     davem@davemloft.net, edumazet@google.com, jtornosm@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        weihao.bj@ieisystem.com
Subject: Re: [PATCH 2/2] net: usb: ax88179_178a: avoid two consecutive device resets
Date:   Thu, 16 Nov 2023 15:18:15 +0100
Message-ID: <20231116141816.21950-1-jtornosm@redhat.com>
In-Reply-To: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
References: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 10:42 AM Paolo Abeni <pabeni@redhat.com> wrote:
> We need a suitable Fixes tag even here ;)
Ok, I will add it in my next version.

> > ---
> >  drivers/net/usb/ax88179_178a.c | 13 -------------
> >  1 file changed, 13 deletions(-)
> >
> > diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> > index 4ea0e155bb0d..864c6fc2db33 100644
> > --- a/drivers/net/usb/ax88179_178a.c
> > +++ b/drivers/net/usb/ax88179_178a.c
> > @@ -1678,7 +1678,6 @@ static const struct driver_info ax88179_info = {
> >       .unbind = ax88179_unbind,
> >       .status = ax88179_status,
> >       .link_reset = ax88179_link_reset,
> > -     .reset = ax88179_reset,
> >       .stop = ax88179_stop,
> >       .flags = FLAG_ETHER | FLAG_FRAMING_AX,
> >       .rx_fixup = ax88179_rx_fixup,
>
> This looks potentially dangerous, as the device will not get a reset in
> down/up cycles; *possibly* dropping the reset call from ax88179_bind()
> would be safer.
Ok, I had the doubt about which reset would be the best, because it seemed 
to me that reset would be better as soon as possible.
I will try what you say to avoid down/up cycles.

> In both cases touching so many H/W variant with testing available on a
> single one sounds dangerous. Is the unneeded 2nd reset causing any
> specific issue?
Actually, this double reboot somewhat masked the first problem, because the
probability of getting a successful initialization, if there is a previous
problem seems to be higher. So, it is not strictly needed but I think it is 
better to avoid a second unnecessary reset.
Ok, if I modify the call from ax88179_bind() I will be respecting the reset
operation of all devices.

Thanks

Best regards
José Ignacio

