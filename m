Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19380E6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346059AbjLLJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:03:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0DBB7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702371793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXfjl/vlm5PNTtLk2bLz+UFG60aKKQyTeA8UKaXlhT4=;
        b=Isvf/VxA/tK3Sgy5pctSlSMLB4lRkdE4F5k0qekMKF363ughSy5VVmWGX8p2FrsekrETee
        3pvnUERkj37+82cEQztWjdDJsdoqgcWRySORNhCC8cPjtxPXnBoXggqI7oIxfkixMWrj+a
        ZAXf/JnkFQhL+Z9TUqTVMES5o9uKUDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-tvCXtk4aNqyFcX2GvVdYhw-1; Tue, 12 Dec 2023 04:03:08 -0500
X-MC-Unique: tvCXtk4aNqyFcX2GvVdYhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 859B788B789;
        Tue, 12 Dec 2023 09:03:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F79440C6EBA;
        Tue, 12 Dec 2023 09:03:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com>
References: <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com> <20231211163412.2766147-1-dhowells@redhat.com>
To:     markus.suvanto@gmail.com
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2810522.1702371786.1@warthog.procyon.org.uk>
Date:   Tue, 12 Dec 2023 09:03:06 +0000
Message-ID: <2810523.1702371786@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

markus.suvanto@gmail.com wrote:

> Reproduce:
> 1) kinit ....
> 2) aklog....
> 3) keyctl show 
> Session Keyring
>  347100937 --alswrv   1001 65534  keyring: _uid_ses.1001
> 1062692655 --alswrv   1001 65534   \_ keyring: _uid.1001
>  698363997 --als-rv   1001   100   \_ rxrpc: afs@station.com
> 
> klist 
> Ticket cache: KEYRING:persistent:1001:1001
> Default principal: .....

Can you "grep rxrpc /proc/keys" at this point?

> 4) ls /afs/notfound
> 5) keyctl show   
> Session Keyring
>  709308533 --alswrv   1001 65534  keyring: _uid_ses.1001
>  385820479 --alswrv   1001 65534   \_ keyring: _uid.1001
> 
> klist
> klist: Credentials cache keyring 'persistent:1001:1001' not found

David

