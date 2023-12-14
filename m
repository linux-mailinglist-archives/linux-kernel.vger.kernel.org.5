Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01278126C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443135AbjLNFJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjLNFJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:09:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F9F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702530572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xO88RRkOEho8UJ2yjNCpaLd/VuL7Hge2PfB6GXsL1SM=;
        b=KSp2JqdXgRHbgxq+8l6Vqe0ZrUtq0Bli18i3wI6mhEeNCUopkIh29YCKUOlRDOtDU6Gd/z
        SYkCiihGi6gNiXkG0gNibs8OL3kFieAR6Dpz+GWZ9dXr5c2ZIXy9zZ/0+EqE7JLg1J8cpl
        a01moqixES6v3COVAdDVE5tFK4nEWv8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-LNZKp_IdOrOD9FEURlOzVQ-1; Thu, 14 Dec 2023 00:09:29 -0500
X-MC-Unique: LNZKp_IdOrOD9FEURlOzVQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28ae02b0752so1250159a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702530568; x=1703135368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO88RRkOEho8UJ2yjNCpaLd/VuL7Hge2PfB6GXsL1SM=;
        b=e7kp8Xe05K1XrxZAt71BKhqHOy6QrvA64SvauW436GcQ9Ro8G0uPKF6M6dL+iX/Uqz
         9GXoyZM74A+c7KMnmNZU3BIzHelF3l3ElPDljgivhGOpfXRcX+46heTplQp4EP1Sbv99
         zjmjNApx0bqKw8rgtoAIaUAydXIcsbQxprWesSSa/Tuw3uUWKuP+00s2MQdn6UQcy5jl
         Ndy4E2Gm+irvhhjNEL4e/NaRSK80+mYTzC6GL1YQuOHNiOZhTNRlPtSSLB/LkPQ7aSQQ
         m9QutqPh1T8T8hgmTkQ14BAXQr7Uq+//6CKWjWr8ca4v02ViJUoA2MDCyZBuRaAVrSoc
         M4dw==
X-Gm-Message-State: AOJu0YzjmRsXZGxnxtsrG5kE7qD9UfFjlv43ERxdPSpsjnZ1V/Iu5e+G
        pW3WaFOCIBUTA+KQP5HycaTlPWXh6RhyaSkFphpsBcy6F30YAgiHqKNCuWw+YfJ2nKQxbDzKpGa
        ksFXgUENZ7s3SsjMHDEDkh/i5
X-Received: by 2002:a17:902:dacf:b0:1d3:5084:e9f3 with SMTP id q15-20020a170902dacf00b001d35084e9f3mr1318157plx.57.1702530568264;
        Wed, 13 Dec 2023 21:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMxc/J25XfrysCEgFd0ZBPUbjJL5FfnrcIXQwa/DjXelYmb771MD7ewSwlMUHHTX0ORVI0ag==
X-Received: by 2002:a17:902:dacf:b0:1d3:5084:e9f3 with SMTP id q15-20020a170902dacf00b001d35084e9f3mr1318152plx.57.1702530567949;
        Wed, 13 Dec 2023 21:09:27 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001d0c641d220sm11485771pls.257.2023.12.13.21.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:09:27 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] net: Return error from sk_stream_wait_connect() if sk_wait_event() fails
Date:   Thu, 14 Dec 2023 14:09:22 +0900
Message-ID: <20231214050922.3480023-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following NULL pointer dereference issue occurred:

BUG: kernel NULL pointer dereference, address: 0000000000000000
<...>
RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
<...>
Call Trace:
 <TASK>
 dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
 inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x83/0xe0 net/socket.c:745
 ____sys_sendmsg+0x443/0x510 net/socket.c:2558
 ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
 __sys_sendmsg+0xa6/0x120 net/socket.c:2641
 __do_sys_sendmsg net/socket.c:2650 [inline]
 __se_sys_sendmsg net/socket.c:2648 [inline]
 __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
socket waiting for the event. However, sk_stream_wait_connect() returns
success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
that waits for a connection with sk_stream_wait_connect() may misbehave.

In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
connection. If disconnect() is called in concurrently, the above issue
occurs.

This patch fixes the issue by returning error from sk_stream_wait_connect()
if sk_wait_event() fails.

Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/core/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index 96fbcb9bbb30..b16dfa568a2d 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -79,7 +79,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
 		remove_wait_queue(sk_sleep(sk), &wait);
 		sk->sk_write_pending--;
 	} while (!done);
-	return 0;
+	return done < 0 ? done : 0;
 }
 EXPORT_SYMBOL(sk_stream_wait_connect);
 
-- 
2.41.0

