Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08780D234
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbjLKQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:40:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38A8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702312816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6fINjgYzDp4pT6EiKMHp9CdMk4eAHEGQUt/Jxjj7L0=;
        b=hb+GfAuFHhkj0nt2CwGtPJjihMxYYaXz6jnaPVFIwMTHnQmsp6Ebj5bync5TwzAhgbtFEY
        c0VtzvGeJrZcFd9ClzwHJEY6nwt41KGbJ1wMYV0Cj6/Cd3Cgagk/wt9AgQf0QrPyYjNVP4
        j+kjWPS2FCqxFrdEvzvUgf9i7lXJBLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-66pKNrKKPKGDcqdc3R7j0Q-1; Mon, 11 Dec 2023 11:40:14 -0500
X-MC-Unique: 66pKNrKKPKGDcqdc3R7j0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFFAC88D7A1;
        Mon, 11 Dec 2023 16:40:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C80432166B32;
        Mon, 11 Dec 2023 16:40:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231211163412.2766147-1-dhowells@redhat.com>
References: <20231211163412.2766147-1-dhowells@redhat.com>
To:     Markus Suvanto <markus.suvanto@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2766463.1702312811.1@warthog.procyon.org.uk>
Date:   Mon, 11 Dec 2023 16:40:11 +0000
Message-ID: <2766464.1702312811@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216637

