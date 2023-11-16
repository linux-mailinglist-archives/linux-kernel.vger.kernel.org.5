Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA67EE3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjKPPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbjKPPDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1E93
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700146987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5BIrNHr+7LsQlEelkvUxuM/ROYOUGHN6QZSqtuj1rRc=;
        b=WFFIoiVbYrfjyZ/7PNb08cPbp/dKfJfw2MVDcnU9977I+C47yCFVenAb/EZ23Gr3PnIwrY
        xxEtonvtrUMAevR6DYXatzupIwriQ5wdfVsfDkkA0DLo6jORb1ZGAYT77CEh1Er+lAoL2A
        Axfp7jeNL8NPJcLHxFY4ROq3sO0dlpI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-Qi3ZhHIZNuC-syAMsHYkgw-1; Thu,
 16 Nov 2023 10:03:02 -0500
X-MC-Unique: Qi3ZhHIZNuC-syAMsHYkgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9304F1C07556;
        Thu, 16 Nov 2023 15:02:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CCB8C15881;
        Thu, 16 Nov 2023 15:02:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231116141951.GE18748@redhat.com>
References: <20231116141951.GE18748@redhat.com> <20231116131849.GA27763@redhat.com> <20231027095842.GA30868@redhat.com> <104932.1700142106@warthog.procyon.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather than read_seqbegin_or_lock()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <112161.1700146930.1@warthog.procyon.org.uk>
Date:   Thu, 16 Nov 2023 15:02:10 +0000
Message-ID: <112162.1700146930@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> wrote:

> > > 	- the usage of read_seqbegin_or_lock/need_seqretry in
> > > 	  this code makes no sense because read_seqlock_excl()
> > > 	  is not possible
> >
> > Not exactly.  I think it should take a lock on the second pass.
> 
> OK, then how about the patch below?

That seems to work.

David

