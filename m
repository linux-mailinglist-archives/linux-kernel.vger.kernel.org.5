Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F17EB4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjKNQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjKNQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A5AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699979603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tzfSnDUwga1tSh876/MWCFEyzy4dmGr84sjeijPXpA0=;
        b=FKfK0QBWtLMd32SKVFtX0lqjPqkbVISFwNkk4103Cy4OVd+Fjv4zxZe4fqmRpn/2Ddf8cu
        nBYTkxvXfYy1VFFTOwdDwDEl4BnUS/RX8TnAX8cE5TVeMHoIvBc/wDG36+nRaq9gONLgdG
        5B38OuOAvKvtnOP54y/xN6a9K26qOSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-X_-LwZLeNp2U6b5NRUTECQ-1; Tue, 14 Nov 2023 11:33:19 -0500
X-MC-Unique: X_-LwZLeNp2U6b5NRUTECQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E97A8185A7A8;
        Tue, 14 Nov 2023 16:33:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
        by smtp.corp.redhat.com (Postfix) with SMTP id 17A771121306;
        Tue, 14 Nov 2023 16:33:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 14 Nov 2023 17:32:14 +0100 (CET)
Date:   Tue, 14 Nov 2023 17:32:11 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse next_thread()
Message-ID: <20231114163211.GA874@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

Compile tested.

Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
the last user and is no exception.

Oleg.
---

 kernel/bpf/task_iter.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

