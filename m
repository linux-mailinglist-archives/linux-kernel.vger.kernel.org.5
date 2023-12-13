Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF380E821
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjLLJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:49:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E354D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702374575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqHDA3enYyDm9+orwRX3ZL56upwXmxhtRXNULm36dzE=;
        b=Xzhzri5iNwrCnaPWhk2nwmsLKH3UVjGLZUsPgE+CNErUhmVIt30AfcPBDEugqTTSGlEyC5
        4eKWWhXh8HTmihXOEnsfYrMC0RoDuklBXrkqEPHSEX5yncyC0fglGkqwHNOBhaQVJlEQEp
        bBsq471/AkFyX5H5OTf+JPCLuafIVtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-XhY6sUdRMPqMxl8h6TStQg-1; Tue, 12 Dec 2023 04:49:31 -0500
X-MC-Unique: XhY6sUdRMPqMxl8h6TStQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ED1088D588;
        Tue, 12 Dec 2023 09:49:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1380B40C6EB9;
        Tue, 12 Dec 2023 09:49:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d523ca40916a8c17ea8ab6d980265e2985e094b3.camel@gmail.com>
References: <d523ca40916a8c17ea8ab6d980265e2985e094b3.camel@gmail.com> <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com> <20231211163412.2766147-1-dhowells@redhat.com> <2810523.1702371786@warthog.procyon.org.uk>
To:     markus.suvanto@gmail.com
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2812151.1702374569.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 12 Dec 2023 09:49:29 +0000
Message-ID: <2812152.1702374569@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

markus.suvanto@gmail.com wrote:

> > Can you "grep rxrpc /proc/keys" at this point?
> > =

> different cell though...
> =

> masu@t470 ~ % grep rxrpc /proc/keys
> 23e16cda I--Q---     1   3d 3b010000  1001   100 rxrpc     afs@movesole.=
com: ka

Okay, I see the persistent keyring disappear, but I don't see a key linked
into my session keyring vanish.

David

