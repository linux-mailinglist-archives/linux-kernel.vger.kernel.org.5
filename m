Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21F7E7E52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjKJRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKJRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A04431CC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699635990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NIZFwo+4TtJxX+MehT6Ekh0B/R7ATGmbr24QUTPhoNE=;
        b=NQ74hhpU0MkHkT6ZwBGjMlSN7UduupAGZQKDAMlaxcpxMG+d0JmVoiBdNLCGzMDYgXxyQf
        hQkc1kFswRskL3jbxHaAijB8YCOYUkBVl1VMcRJcNXoPrp2sa0IrxhPqvEdCqncdRmghfs
        bHj2NPMHYkjT/7PqkadLq6PMM8Zsp1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696--b21MyKUN3a1cwZoFSNvbQ-1; Fri, 10 Nov 2023 12:06:28 -0500
X-MC-Unique: -b21MyKUN3a1cwZoFSNvbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8751C85A59D;
        Fri, 10 Nov 2023 17:06:28 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.16.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B44D502C;
        Fri, 10 Nov 2023 17:06:28 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v1 0/1] fs: Consider capabilities relative to namespace for linkat permission check
Date:   Fri, 10 Nov 2023 12:06:14 -0500
Message-Id: <20231110170615.2168372-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a one line change that makes `linkat` aware of namespaces when
checking for capabilities.

As far as I can tell, the call to `capable` in this code dates back to
before the `ns_capable` function existed, so I don't think the author
specifically intended to prefer regular `capable` over `ns_capable`,
and no one has noticed or cared to change it yet... until now!

It is already hard enough to use `linkat` to link temporarily files
into the filesystem without the `/proc` workaround, and when moving
a program that was working fine on bare metal into a container,
I got hung up on this additional snag due to the lack of namespace
awareness in `linkat`.

Charles Mirabile (1):
  fs: Consider capabilities relative to namespace for linkat permission
    check

 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 89cdf9d556016a54ff6ddd62324aa5ec790c05cc
-- 
2.38.1

