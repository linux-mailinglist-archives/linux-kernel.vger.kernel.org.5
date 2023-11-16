Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119457EE3E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjKPPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjKPPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018EA9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700147280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5wxMBvbthLauuE7a3pZ8/SsXV3V5MFqmp1hCTliRys=;
        b=ZvH+GTJ/3Y+UcEJ8msVw5iMxTrbZRuSmkLAqN0Pf5u8hngBoXgD9Bv1TS4ZSIZwOMRBkgt
        CpmYidXCWkHqRFIUPweI9yUEIEg2HIqgK93gvIFl4cvDviAic5scLuVbKl+biR454Yf8me
        YwMxw+U2EEzt+aqpXctGbJSMGD4Tbt4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-zChOR5FXNHK8oL95YJQJSg-1; Thu, 16 Nov 2023 10:07:58 -0500
X-MC-Unique: zChOR5FXNHK8oL95YJQJSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43A278007B3;
        Thu, 16 Nov 2023 15:07:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id AF40540C6EBB;
        Thu, 16 Nov 2023 15:07:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 Nov 2023 16:06:53 +0100 (CET)
Date:   Thu, 16 Nov 2023 16:06:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231116150650.GF18748@redhat.com>
References: <20231116141951.GE18748@redhat.com>
 <20231116131849.GA27763@redhat.com>
 <20231027095842.GA30868@redhat.com>
 <104932.1700142106@warthog.procyon.org.uk>
 <112162.1700146930@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112162.1700146930@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16, David Howells wrote:
>
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > > 	- the usage of read_seqbegin_or_lock/need_seqretry in
> > > > 	  this code makes no sense because read_seqlock_excl()
> > > > 	  is not possible
> > >
> > > Not exactly.  I think it should take a lock on the second pass.
> >
> > OK, then how about the patch below?
>
> That seems to work.

OK, I'll send V2 tomorrow.

Should I change fs/afs the same way?

Oleg.

