Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1680CF55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjLKPVZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 10:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjLKPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:21:23 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF419DC;
        Mon, 11 Dec 2023 07:21:28 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54dccf89cfdso5950445a12.0;
        Mon, 11 Dec 2023 07:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308087; x=1702912887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V/QyVp20sRTGALaesW9AkK6phzk9B8NcFWzyoFDK4I=;
        b=eNXqRo0w76I2I3wT0P/sfyaT9KvEtupUECavsd27ftdxS8ENZx061F0NcJ4VQmyQLr
         BGoXnGq6vW7/SA360S7xKoGkGZnCj84Gmq+w0DHxOnDKYuQPbgL3wMJAQzfFnF/Sg52l
         j88uhj/3NccIq/7CMxx8KWb9uc18gTqp7wqoZOerWRvQR5DuBfnR8WKR9zA0bQKpil7N
         cKWvQXioaAFhIbU4fsd93wO/XVZWTHxndh8mR9jzC1kk43S5GNfHhyOp9MR8fOr/YOgu
         gsF0WVtpAG3vjv+1AFIp+A2k9dM+DpFop1s76yfTUlaz57RtdXilYGAUFbZIyy8foWXK
         cFeg==
X-Gm-Message-State: AOJu0YzXG7U7jGRBf+9oSvm490TVP0l0dYrg4aDVa0cUFz2UoNSEyFpa
        1ZRZHZ+iBfsl5V031RuXJMu1Gdas/Udx+w==
X-Google-Smtp-Source: AGHT+IEFRB4R+dj4xGP4tpjDKTPi1cEF9jtHgRro3Gsd13xcoey7+8J0MLLMKLfKq9h642sRPyk7Rg==
X-Received: by 2002:a17:906:a843:b0:a1b:763c:b382 with SMTP id dx3-20020a170906a84300b00a1b763cb382mr2029522ejb.115.1702308086825;
        Mon, 11 Dec 2023 07:21:26 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1b6d503e7esm4936745ejc.157.2023.12.11.07.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 07:21:26 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1ef2f5ed02so490251966b.1;
        Mon, 11 Dec 2023 07:21:26 -0800 (PST)
X-Received: by 2002:a17:906:74cf:b0:9ff:53b6:f951 with SMTP id
 z15-20020a17090674cf00b009ff53b6f951mr2295900ejl.23.1702308086468; Mon, 11
 Dec 2023 07:21:26 -0800 (PST)
MIME-Version: 1.0
References: <2633992.1702073229@warthog.procyon.org.uk>
In-Reply-To: <2633992.1702073229@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Mon, 11 Dec 2023 11:21:15 -0400
X-Gmail-Original-Message-ID: <CAB9dFdtXuzrhog3qcPKseSH8j0B6JcL-LJL6e-=Xhtb6wPAseg@mail.gmail.com>
Message-ID: <CAB9dFdtXuzrhog3qcPKseSH8j0B6JcL-LJL6e-=Xhtb6wPAseg@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix refcount underflow from error handling race
To:     David Howells <dhowells@redhat.com>
Cc:     Bill MacAllister <bill@ca-zephyr.org>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
>
> If an AFS cell that has an unreachable (eg. ENETUNREACH) Volume Location
> server listed, an asynchronous probe to one of its addresses may fail
> immediately because sendmsg() returns an error.  When this happens, a
> refcount underflow can happen if certain events hit a very small window.
>
> The way this occurs is:
>
>  (1) There are two levels of "call" object, the afs_call and the
>      rxrpc_call.  Each of them can be transitioned to a "completed" state
>      in the event of success or failure.
>
>  (2) Asynchronous afs_calls are self-referential whilst they are active to
>      prevent them from evaporating when they're not being processed.  This
>      reference is disposed of when the afs_call is completed.
>
>      Note that an afs_call may only be completed once; once completed
>      completing it again will do nothing.
>
>  (3) When a call transmission is made, the app-side rxrpc code queues a Tx
>      buffer for the rxrpc I/O thread to transmit.  The I/O thread invokes
>      sendmsg() to transmit it - and in the case of failure, it transitions
>      the rxrpc_call to the completed state.
>
>  (4) When an rxrpc_call is completed, the app layer is notified.  In this
>      case, the app is kafs and it schedules a work item to process events
>      pertaining to an afs_call.
>
>  (5) When the afs_call event processor is run, it goes down through the
>      RPC-specific handler to afs_extract_data() to retrieve data from rxrpc
>      - and, in this case, it picks up the error from the rxrpc_call and
>      returns it.
>
>      The error is then propagated to the afs_call and that is completed
>      too.  At this point the self-reference is released.
>
>  (6) If the rxrpc I/O thread manages to complete the rxrpc_call within the
>      window between rxrpc_send_data() queuing the request packet and
>      checking for call completion on the way out, then
>      rxrpc_kernel_send_data() will return the error from sendmsg() to the
>      app.
>
>  (7) Then afs_make_call() will see an error and will jump to the error
>      handling path which will attempt to clean up the afs_call.
>
>  (8) The problem comes when the error handling path in afs_make_call()
>      tries to unconditionally drop an async afs_call's self-reference.
>      This self-reference, however, may already have been dropped by
>      afs_extract_data() completing the afs_call
>
>  (9) The refcount underflows when we return to afs_do_probe_vlserver() and
>      that tries to drop its reference on the afs_call.
>
> Fix this by making afs_make_call() attempt to complete the afs_call rather
> than unconditionally putting it.  That way, if afs_extract_data() manages
> to complete the call first, afs_make_call() won't do anything.
>
> The bug can be forced by making do_udp_sendmsg() return -ENETUNREACH and
> sticking an msleep() in rxrpc_send_data() after the 'success:' label.
>
> The error message looks something like:
>
>     refcount_t: underflow; use-after-free.
>     WARNING: CPU: 3 PID: 720 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
>     ...
>     RIP: 0010:refcount_warn_saturate+0xba/0x110
>     ...
>     afs_put_call+0x1dc/0x1f0 [kafs]
>     afs_fs_get_capabilities+0x8b/0xe0 [kafs]
>     afs_fs_probe_fileserver+0x188/0x1e0 [kafs]
>     afs_lookup_server+0x3bf/0x3f0 [kafs]
>     afs_alloc_server_list+0x130/0x2e0 [kafs]
>     afs_create_volume+0x162/0x400 [kafs]
>     afs_get_tree+0x266/0x410 [kafs]
>     vfs_get_tree+0x25/0xc0
>     fc_mount+0xe/0x40
>     afs_d_automount+0x1b3/0x390 [kafs]
>     __traverse_mounts+0x8f/0x210
>     step_into+0x340/0x760
>     path_openat+0x13a/0x1260
>     do_filp_open+0xaf/0x160
>     do_sys_openat2+0xaf/0x170
>
> or something like:
>
>     refcount_t: underflow; use-after-free.
>     ...
>     RIP: 0010:refcount_warn_saturate+0x99/0xda
>     ...
>     afs_put_call+0x4a/0x175
>     afs_send_vl_probes+0x108/0x172
>     afs_select_vlserver+0xd6/0x311
>     afs_do_cell_detect_alias+0x5e/0x1e9
>     afs_cell_detect_alias+0x44/0x92
>     afs_validate_fc+0x9d/0x134
>     afs_get_tree+0x20/0x2e6
>     vfs_get_tree+0x1d/0xc9
>     fc_mount+0xe/0x33
>     afs_d_automount+0x48/0x9d
>     __traverse_mounts+0xe0/0x166
>     step_into+0x140/0x274
>     open_last_lookups+0x1c1/0x1df
>     path_openat+0x138/0x1c3
>     do_filp_open+0x55/0xb4
>     do_sys_openat2+0x6c/0xb6
>
> Fixes: 34fa47612bfe ("afs: Fix race in async call refcounting")
> Reported-by: Bill MacAllister <bill@ca-zephyr.org>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1052304
> Suggested-by: Jeffrey E Altman <jaltman@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/rxrpc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index ed1644e7683f..d642d06a453b 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -424,7 +424,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
>         if (call->async) {
>                 if (cancel_work_sync(&call->async_work))
>                         afs_put_call(call);
> -               afs_put_call(call);
> +               afs_set_call_complete(call, ret, 0);
>         }
>
>         ac->error = ret;

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
