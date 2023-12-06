Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF7806FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378380AbjLFMic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378326AbjLFMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B412F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701866316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZQQ6BqHEI6hRsDFbv1/FW96mENZWMKFWNl0n0AGdhw=;
        b=jVISvmAWQCxftrAgR0WXMbr1r6rJPZTLPh+0On0WaSzV0TF+5AC94pV5915Rdo2BQzapDM
        cwKFcu1T5PfsT3CrbxqwW4cSxbPygJm+jUpFozoldVhTfjO06nz5gJlBir/BEgNtOezbB9
        vdN1SacXazgaHvpQo4j7FFmz7y/D3Gk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-thj-CJ5vMACQz1wZWLOP9w-1; Wed,
 06 Dec 2023 07:38:31 -0500
X-MC-Unique: thj-CJ5vMACQz1wZWLOP9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F74F29AB3F3;
        Wed,  6 Dec 2023 12:38:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C252E3C2E;
        Wed,  6 Dec 2023 12:38:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <447324.1701860432@warthog.procyon.org.uk>
References: <447324.1701860432@warthog.procyon.org.uk>
To:     fstests@vger.kernel.org, samba-technical@lists.samba.org,
        linux-cifs@vger.kernel.org
Cc:     dhowells@redhat.com, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Dave Chinner <david@fromorbit.com>,
        Filipe Manana <fdmanana@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Issues with FIEMAP, xfstests, Samba, ksmbd and CIFS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <449657.1701866309.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 06 Dec 2023 12:38:29 +0000
Message-ID: <449658.1701866309@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> So:
> =

>  - Should Samba and ksmbd be using FALLOC_FL_ZERO_RANGE rather than
>    PUNCH_HOLE?
> =

>  - Should Samba and ksmbd be using FIEMAP rather than SEEK_DATA/HOLE?

 - Should Samba and ksmbd report 'unwritten' extents as being allocated?

>  - Should xfstests be less exacting in its FIEMAP analysis - or should t=
his be
>    skipped for cifs?  I don't want to skip generic/009 as it checks some
>    corner cases that need testing, but it may not be possible to make th=
e
>    exact extent matching work.

