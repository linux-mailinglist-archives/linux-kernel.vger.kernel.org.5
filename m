Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D1811726
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442391AbjLMPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442203AbjLMPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3AB1BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702481552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hdM+h7N6TwHGhwIbks4CvwZuKV0xOWmxmNCull4QN4=;
        b=U5MSrkOoV5RgvqQDMAWTx0L/at2KIbSkXbJTnlNUaY/SpcJakGre2r7P0sFPI2q7f7Zl9e
        pvLI+7CaTwvLG+RW2ZZBI1PYvPlRJwFimoIy40k6hh2A1r70zHrUzzryvcjYshFmRpaSO/
        IfNTASSPFxuvwPT9CWMa1nyYijjgs7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Oq2jS38dPZ6RKRmzjwJH1A-1; Wed, 13 Dec 2023 10:32:30 -0500
X-MC-Unique: Oq2jS38dPZ6RKRmzjwJH1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 232C088D01D;
        Wed, 13 Dec 2023 15:32:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EA702026D66;
        Wed, 13 Dec 2023 15:32:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3bf4a5126f84b56a28dbc5e8e643b24945578bbd.camel@kernel.org>
References: <3bf4a5126f84b56a28dbc5e8e643b24945578bbd.camel@kernel.org> <20231207212206.1379128-1-dhowells@redhat.com> <20231207212206.1379128-5-dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/59] netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <432337.1702481544.1@warthog.procyon.org.uk>
Date:   Wed, 13 Dec 2023 15:32:24 +0000
Message-ID: <432338.1702481544@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> 
>    1. Are there known userland tools that rely on this path? I suppose
>       this is harmless either way though, and /proc is supposedly part
>       of the ABI.

I know various people have sent copies of the file in case of crashes, so it
feels like it should still be accessible by the old path.

David

