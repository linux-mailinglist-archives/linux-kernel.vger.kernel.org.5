Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502980AF64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574876AbjLHWHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjLHWHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:07:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279971FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702073235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1K9qQ8jUBWP1/yoc/0mZr7WMwlg05+6DFH8d8enhnls=;
        b=df0Buhmkud4pId72+5gbB5qcXyVpEPvpTIrMsKn3DzwZ/GDEXCcQs3ys1Qa7lpHh30fFBo
        0V/r1aXsmWzw2Atl7hYD9hEIIPhBmlcchWSf8kaSJ8InIJ6PIj/QhIufU1oBwbpPqreq4C
        qnXUCj13gc7nrPIUdXymCf4Zxuf1QPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-eI_zKEg0NmCiM5sK8cmCIg-1; Fri, 08 Dec 2023 17:07:11 -0500
X-MC-Unique: eI_zKEg0NmCiM5sK8cmCIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CE4485A58C;
        Fri,  8 Dec 2023 22:07:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E177492BE6;
        Fri,  8 Dec 2023 22:07:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Bill MacAllister <bill@ca-zephyr.org>,
        linux-afs@lists.infradead.org
cc:     David Howells <dhowells@redhat.com>,
        Jeffrey E Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix refcount underflow from error handling race
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2633991.1702073229.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 08 Dec 2023 22:07:09 +0000
Message-ID: <2633992.1702073229@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an AFS cell that has an unreachable (eg. ENETUNREACH) Volume Location
server listed, an asynchronous probe to one of its addresses may fail
immediately because sendmsg() returns an error.  When this happens, a
refcount underflow can happen if certain events hit a very small window.

The way this occurs is:

 (1) There are two levels of "call" object, the afs_call and the
     rxrpc_call.  Each of them can be transitioned to a "completed" state
     in the event of success or failure.

 (2) Asynchronous afs_calls are self-referential whilst they are active to
     prevent them from evaporating when they're not being processed.  This
     reference is disposed of when the afs_call is completed.

     Note that an afs_call may only be completed once; once completed
     completing it again will do nothing.

 (3) When a call transmission is made, the app-side rxrpc code queues a Tx
     buffer for the rxrpc I/O thread to transmit.  The I/O thread invokes
     sendmsg() to transmit it - and in the case of failure, it transitions
     the rxrpc_call to the completed state.

 (4) When an rxrpc_call is completed, the app layer is notified.  In this
     case, the app is kafs and it schedules a work item to process events
     pertaining to an afs_call.

 (5) When the afs_call event processor is run, it goes down through the
     RPC-specific handler to afs_extract_data() to retrieve data from rxrp=
c
     - and, in this case, it picks up the error from the rxrpc_call and
     returns it.

     The error is then propagated to the afs_call and that is completed
     too.  At this point the self-reference is released.

 (6) If the rxrpc I/O thread manages to complete the rxrpc_call within the
     window between rxrpc_send_data() queuing the request packet and
     checking for call completion on the way out, then
     rxrpc_kernel_send_data() will return the error from sendmsg() to the
     app.

 (7) Then afs_make_call() will see an error and will jump to the error
     handling path which will attempt to clean up the afs_call.

 (8) The problem comes when the error handling path in afs_make_call()
     tries to unconditionally drop an async afs_call's self-reference.
     This self-reference, however, may already have been dropped by
     afs_extract_data() completing the afs_call

 (9) The refcount underflows when we return to afs_do_probe_vlserver() and
     that tries to drop its reference on the afs_call.

Fix this by making afs_make_call() attempt to complete the afs_call rather
than unconditionally putting it.  That way, if afs_extract_data() manages
to complete the call first, afs_make_call() won't do anything.

The bug can be forced by making do_udp_sendmsg() return -ENETUNREACH and
sticking an msleep() in rxrpc_send_data() after the 'success:' label.

The error message looks something like:

    refcount_t: underflow; use-after-free.
    WARNING: CPU: 3 PID: 720 at lib/refcount.c:28 refcount_warn_saturate+0=
xba/0x110
    ...
    RIP: 0010:refcount_warn_saturate+0xba/0x110
    ...
    afs_put_call+0x1dc/0x1f0 [kafs]
    afs_fs_get_capabilities+0x8b/0xe0 [kafs]
    afs_fs_probe_fileserver+0x188/0x1e0 [kafs]
    afs_lookup_server+0x3bf/0x3f0 [kafs]
    afs_alloc_server_list+0x130/0x2e0 [kafs]
    afs_create_volume+0x162/0x400 [kafs]
    afs_get_tree+0x266/0x410 [kafs]
    vfs_get_tree+0x25/0xc0
    fc_mount+0xe/0x40
    afs_d_automount+0x1b3/0x390 [kafs]
    __traverse_mounts+0x8f/0x210
    step_into+0x340/0x760
    path_openat+0x13a/0x1260
    do_filp_open+0xaf/0x160
    do_sys_openat2+0xaf/0x170

or something like:

    refcount_t: underflow; use-after-free.
    ...
    RIP: 0010:refcount_warn_saturate+0x99/0xda
    ...
    afs_put_call+0x4a/0x175
    afs_send_vl_probes+0x108/0x172
    afs_select_vlserver+0xd6/0x311
    afs_do_cell_detect_alias+0x5e/0x1e9
    afs_cell_detect_alias+0x44/0x92
    afs_validate_fc+0x9d/0x134
    afs_get_tree+0x20/0x2e6
    vfs_get_tree+0x1d/0xc9
    fc_mount+0xe/0x33
    afs_d_automount+0x48/0x9d
    __traverse_mounts+0xe0/0x166
    step_into+0x140/0x274
    open_last_lookups+0x1c1/0x1df
    path_openat+0x138/0x1c3
    do_filp_open+0x55/0xb4
    do_sys_openat2+0x6c/0xb6

Fixes: 34fa47612bfe ("afs: Fix race in async call refcounting")
Reported-by: Bill MacAllister <bill@ca-zephyr.org>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1052304
Suggested-by: Jeffrey E Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rxrpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index ed1644e7683f..d642d06a453b 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -424,7 +424,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct =
afs_call *call, gfp_t gfp)
 	if (call->async) {
 		if (cancel_work_sync(&call->async_work))
 			afs_put_call(call);
-		afs_put_call(call);
+		afs_set_call_complete(call, ret, 0);
 	}
 =

 	ac->error =3D ret;

