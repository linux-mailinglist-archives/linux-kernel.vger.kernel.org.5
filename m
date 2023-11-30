Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781667FEE56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjK3L4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjK3L4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226010F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701345410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1BMf/h/mprcajTUDf9CS5Q2XsPHkiomChP9RT4mxMkI=;
        b=CDbD2e6MoVEB6qpLzmKWahEB5yQz4x2RhlbiK0y2hDVByEBvh94nKxk/KcRsFJ/nCeeEkT
        jWz+7DEDQgrob8WEipMxYeQit6gIlQLF98Hh9esuzw2bmiftI6MF6rOcmLXgurRIzGt6U8
        i8TuIVCSYtmhg1sBXLAwp4fcasLBA+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-T49i8cjLPJKRiqfOJL6pRg-1; Thu, 30 Nov 2023 06:56:46 -0500
X-MC-Unique: T49i8cjLPJKRiqfOJL6pRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45CE7185A783;
        Thu, 30 Nov 2023 11:56:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA8D42026D4C;
        Thu, 30 Nov 2023 11:56:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 Nov 2023 12:55:39 +0100 (CET)
Date:   Thu, 30 Nov 2023 12:55:37 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] afs: fix the usage of read_seqbegin_or_lock()
Message-ID: <20231130115537.GA21550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Hello,

Every usage of read_seqbegin_or_lock() in fs/afs is wrong, the counter is
always even so read_seqbegin_or_lock() can never take the lock.

The users should either make it odd on the 2nd pass, or use read_seqbegin()
instead.

Oleg.
---

 fs/afs/callback.c |  3 ++-
 fs/afs/inode.c    | 15 ++++++---------
 fs/afs/server.c   |  7 ++++---
 3 files changed, 12 insertions(+), 13 deletions(-)

