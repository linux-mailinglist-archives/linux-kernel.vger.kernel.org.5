Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172887E7E51
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbjKJRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjKJRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BEB446C9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699637147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oM2mXDeA3Wf82Oz0QJWRHggvqKfyd3kHZcBXsRiuhQg=;
        b=TfSR4+U+vukNTA5byyoGWj5YMw9cfbkyslFv8GsKU52eeqSpmDNbaczFHkX2ffcbftD52s
        FyAWVcuF5WiMuZNjQhA6hgtLPw2dLXjYZmWHmrhEfu8A5QoBx62mufQZn/PRb+SSSOHR2g
        GAtu8wKPX2X/iBpaa52aYZXlhpU9bYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-pjuAe0pPOSO1_br2upm_yw-1; Fri, 10 Nov 2023 12:25:44 -0500
X-MC-Unique: pjuAe0pPOSO1_br2upm_yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00A4185A5BD;
        Fri, 10 Nov 2023 17:25:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB18502A;
        Fri, 10 Nov 2023 17:25:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c19af528-1aad-412c-8362-275c791dd76f@auristor.com>
References: <c19af528-1aad-412c-8362-275c791dd76f@auristor.com> <6fadc6aa-4078-4f12-a4c7-235267d6e0b1@auristor.com> <20231109154004.3317227-1-dhowells@redhat.com> <20231109154004.3317227-2-dhowells@redhat.com> <3327953.1699567608@warthog.procyon.org.uk>
To:     Jeffrey E Altman <jaltman@auristor.com>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/41] rxrpc: Fix RTT determination to use PING ACKs as a source
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3399755.1699637142.1@warthog.procyon.org.uk>
Date:   Fri, 10 Nov 2023 17:25:42 +0000
Message-ID: <3399756.1699637142@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey E Altman <jaltman@auristor.com> wrote:

> > I do ignore ack.serial == 0 for this purpose.
> 
> Zero has the special meaning - this ACK is not explicitly in response to a
> received packet.
> 
> However, as mentioned, the serial number counter wraps frequently and most
> RxRPC implementations
> do not transition from serial 0xffffffff -> 0x00000001 when wrapping.

I don't skip zero serial numbers either.  I'm not sure whether it would be
better to do so.

> Otherwise, acked_serial = 0x01 will be considered smaller than orig_serial =
> 0xfffffffe and the slot will not be marked available.

As you mentioned in your follow up email, after() deals with that by casting
to signed, subtracting and then examining the result.

David


