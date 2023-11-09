Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE527E7436
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbjKIWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjKIWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:07:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3AF1FF6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699567614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTCrETe33lMmrS3iamQBvHr88tXqZxqdutyVeBzQWY0=;
        b=ESjqQoMuZEf4gIxXEiaJJ7sDoiAjo3l2NFYmB83eQfXGW0kOGaKi/i+rtfg/vKlKLvh/Lv
        1uufcebAc91N8Jcf6rO7HnWbHtRNITJzsJdi5/KPuu5vjaijuQzWxCjruJIUZB0zrMfPAf
        slrxZiH9Ut3Tm+dfxFaCYvRy8oIGMLk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Goh8HWQaMEyXDt1PmNGdJw-1; Thu,
 09 Nov 2023 17:06:50 -0500
X-MC-Unique: Goh8HWQaMEyXDt1PmNGdJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CE3C1C068C1;
        Thu,  9 Nov 2023 22:06:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38367C1290F;
        Thu,  9 Nov 2023 22:06:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6fadc6aa-4078-4f12-a4c7-235267d6e0b1@auristor.com>
References: <6fadc6aa-4078-4f12-a4c7-235267d6e0b1@auristor.com> <20231109154004.3317227-1-dhowells@redhat.com> <20231109154004.3317227-2-dhowells@redhat.com>
To:     Jeffrey E Altman <jaltman@auristor.com>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/41] rxrpc: Fix RTT determination to use PING ACKs as a source
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3327952.1699567608.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 09 Nov 2023 22:06:48 +0000
Message-ID: <3327953.1699567608@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to drop this patch from this series for now and send it separate=
ly.

> I do not believe the ack_reason matters within rxrpc_input_ack(). As lon=
g as
> the acked_serial is non-zero,
> rxrpc_complete_rtt_probe() can be called to attempt to compute an RTT.  =
 If
> there is an exact match for the
> acked_serial then an RTT can be computed and if acked_serial is later th=
an the
> pending rtt probe, the probe
> can be abandoned with the following caveats.
> =

> 1. Receiving an acked_serial that is later than the serial of the
>    transmitted probe indicates that a packet
>    transmitted after the probe was received first.  Or that reordering
>    of the transmitted packets occurred.
>    Or that the probe was never received by the peer; or that the peer's
>    response to the probe was lost in
>    transit.
> 2. The serial number namespace is unsigned 32-bit shared across all of
>    the call channels of the associated
>    rx connection.  As the serial numbers will wrap the use of after()
>    within rxrpc_complete_rtt_probe to
>    compare their values is questionable.   If serial numbers will be
>    compared in this manner then they
>    need to be locally tracked and compared as unsigned 64-bit values
>    where only the low 32-bits are
>    transmitted on the wire and any wire serial number equal to zero is
>    ignored.

I do ignore ack.serial =3D=3D 0 for this purpose.

I'm not sure how expanding it internally to 64-bits actually helps since t=
he
upper 32 bits is not visible to the peer.

David

