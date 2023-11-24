Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44677F86B0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjKXX1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKXX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F365D10DE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700868429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RrwbTeSbC5XCVA4N2cHN28MMNgejQdbSfaWFJUoo78=;
        b=LKj/QL9jF4YVVz/BSaOKk+qIMfZ1H0iIjryiBbsu8typISLR37790DGDOYv0QEvHPii54q
        oKh4Nk8zROL7bn4lFlbEEa/ZMsbv1KYiGrCEA+3+hIyFOACfnCFJvlWXAEaOBQ42UgMrUL
        ljbnc1iCO+XMmh4oTrVlPj+FVPLkJKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-RHCueqjrPQOc_2qATkB3tQ-1; Fri, 24 Nov 2023 18:27:07 -0500
X-MC-Unique: RHCueqjrPQOc_2qATkB3tQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 047CA101A529;
        Fri, 24 Nov 2023 23:27:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6EA1C060B0;
        Fri, 24 Nov 2023 23:27:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1297339.1700862676@warthog.procyon.org.uk>
References: <1297339.1700862676@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Set the file size after doing copychunk_range
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1335876.1700868425.1@warthog.procyon.org.uk>
Date:   Fri, 24 Nov 2023 23:27:05 +0000
Message-ID: <1335877.1700868425@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +	truncate_inode_pages_range(&target_inode->i_data, destoff, len);

That should actually be:

	truncate_inode_pages_range(&target_inode->i_data, destoff, destoff + len);

David

