Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07C87A1E48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjIOMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjIOMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C09F72119
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694780101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ACgwXt5WGrX2j4PYTtUkL9OiFfodaBbXHcP278ZXTG8=;
        b=SLlzPpE2gZkEtXp5VCb2x8TgXAyEt5N0+IwSnR+j6b8eWY9N1fqHlbgtyWt9KXYF7BeJdb
        hFRawPsgLh2duIT+/6wzi+94DX7KkjRgmSxm0btPSYCKLr2KznLlZbt6e+lWHt5d7ez3tU
        c2Of6O1ZfkNFIwkMZzqgitA2umsvBEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-4nVovntiNzWNMyYKgoc7XA-1; Fri, 15 Sep 2023 08:14:57 -0400
X-MC-Unique: 4nVovntiNzWNMyYKgoc7XA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40474c03742so10919885e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780096; x=1695384896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACgwXt5WGrX2j4PYTtUkL9OiFfodaBbXHcP278ZXTG8=;
        b=AMr2HRj7IDPSToPClgvqkSJQN8QbMYlSOSpZ00Qw62iPmltAyTRGS1yLGLopsQVNcl
         u0g0hz6v5QfeRVdNNy36KI7/bTguvb+bhS6iIrk0uHXBwfvNT+nJjaodexqWlPPF8W4p
         ZG3va3Pw2T0UIZ0mWYLb5YKqi/uFTA3UZkh1NSBx3dTe+ZFxazRXgjey1CCwnQa2V1/C
         Jnixmv3NWPB7R4N23dgfHxjqY6UPCCa7WzhoqqUv+VzpT3swSw+ZdI82RNFVO6q7ligK
         2laAMPaJkCGrwKsFLM2lraM/VvH3M7sNGmeXo+Se94SlqvWB8cuDVd4ae48/XLLsxN6K
         rNzw==
X-Gm-Message-State: AOJu0YyBlyGI1W9TmLB6lJMmADXxgUCAnIC5P7ye/aO85Ka7lgTV5rgE
        QNtvuXVEpZ3Pdw6QjV9YLtB0EZjJ7oUdQJd9MurLY4tZt1K5YzGSMJkeKqfeJV+0+vrBV0jHos8
        zimM7ocLOTr55tEoT3/p4SZLV
X-Received: by 2002:a1c:f204:0:b0:401:73b2:f04d with SMTP id s4-20020a1cf204000000b0040173b2f04dmr1397141wmc.14.1694780096483;
        Fri, 15 Sep 2023 05:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExJPtI+IYCLPfbbQVatowLO2RRsokfIvzSgGwESxjINV6nsoe3beRRdwbN8e/jUfKrdJ6G9Q==
X-Received: by 2002:a1c:f204:0:b0:401:73b2:f04d with SMTP id s4-20020a1cf204000000b0040173b2f04dmr1397124wmc.14.1694780096124;
        Fri, 15 Sep 2023 05:14:56 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm7333595wmi.18.2023.09.15.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:14:55 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 0/5] vsock/test: add recv_buf()/send_buf() utility functions and some improvements
Date:   Fri, 15 Sep 2023 14:14:47 +0200
Message-ID: <20230915121452.87192-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently found that some tests were failing [1].

The problem was that we were not waiting for all the bytes correctly,
so we had a partial read. I had initially suggested using MSG_WAITALL,
but this could have timeout problems.

Since we already had send_byte() and recv_byte() that handled the timeout,
but also the expected return value, I moved that code to two new functions
that we can now use to send/receive generic buffers.

The last commit is just an improvement to a test I found difficult to
understand while using the new functions.

@Arseniy a review and some testing are really appreciated :-)

[1] https://lore.kernel.org/netdev/63xflnwiohdfo6m3vnrrxgv2ulplencpwug5qqacugqh7xxpu3@tsczkuqgwurb/

Stefano Garzarella (5):
  vsock/test: add recv_buf() utility function
  vsock/test: use recv_buf() in vsock_test.c
  vsock/test: add send_buf() utility function
  vsock/test: use send_buf() in vsock_test.c
  vsock/test: track bytes in MSG_PEEK test for SOCK_SEQPACKET

 tools/testing/vsock/util.h       |   3 +
 tools/testing/vsock/util.c       | 124 ++++++++++++--------
 tools/testing/vsock/vsock_test.c | 187 ++++++-------------------------
 3 files changed, 117 insertions(+), 197 deletions(-)

-- 
2.41.0

