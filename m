Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147627A2390
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjIOQ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjIOQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FC66BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694795095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=328Jdrb2fZ5ZeD++O6N1acm+mpPXCsp0leB/sLzqYjY=;
        b=VcBRbq9kH/6va+cf6Axea8Rt5GDnSqD5MpI1lrLS12lkk9TpukRl6J5Io3P+Wh0V6yYn5P
        mJ1P+nTgjDzEtpAfEgRlqEeNKO/Rtzb/hGr4k6KFBB9Or0GZzyBSUErEh494F0J4dF0FBN
        F2TkF6Hgjl37ts4D1XBd5Bto42C8Yz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-c4PbsJe8Oy6116Keg8z8zg-1; Fri, 15 Sep 2023 12:24:42 -0400
X-MC-Unique: c4PbsJe8Oy6116Keg8z8zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53FAF811E86;
        Fri, 15 Sep 2023 16:24:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 137D840C2070;
        Fri, 15 Sep 2023 16:24:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
References: <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com> <0000000000001c12b30605378ce8@google.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3793722.1694795079.1@warthog.procyon.org.uk>
Date:   Fri, 15 Sep 2023 17:24:39 +0100
Message-ID: <3793723.1694795079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the attached is probably an equivalent cleaned up reproducer.  Note
that if the length given to sendfile() is less than 65536, it fails with
EINVAL before it gets into __ip6_append_data().

David
---
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/sendfile.h>
#include <sys/uio.h>
#include <netinet/ip6.h>
#include <netinet/in.h>

#define IPPROTO_L2TP 115

#define OSERROR(R, S) \
	do { if ((long)(R) == -1L) { perror((S)); exit(1); } } while(0)

static char buffer[16776960];

int main()
{
	struct sockaddr_in6 sin6;
	int ffd, dfd, sfd;

	ffd = openat(AT_FDCWD, "cgroup.controllers",
		     O_RDWR | O_CREAT | O_TRUNC, 0);
	OSERROR(ffd, "cgroup.controllers/f");

	OSERROR(write(ffd, buffer, sizeof(buffer)), "write");

	dfd = openat(AT_FDCWD, "cgroup.controllers",
		     O_RDONLY | O_NONBLOCK | O_DIRECT);
	OSERROR(dfd, "cgroup.controllers/d");

	sfd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
	OSERROR(dfd, "socket");

	memset(&sin6, 0, sizeof(sin6));
	sin6.sin6_family = AF_INET6;
	sin6.sin6_port = htons(0);
	sin6.sin6_addr.s6_addr32[0] = htonl(0);
	sin6.sin6_addr.s6_addr32[1] = htonl(0);
	sin6.sin6_addr.s6_addr32[2] = htonl(0);
	sin6.sin6_addr.s6_addr32[3] = htonl(1);
	OSERROR(bind(sfd, (struct sockaddr *)&sin6, 32),
		"bind");

	memset(&sin6, 0, sizeof(sin6));
	sin6.sin6_family = AF_INET6;
	sin6.sin6_port = htons(7);
	sin6.sin6_addr.s6_addr32[0] = htonl(0);
	sin6.sin6_addr.s6_addr32[1] = htonl(0);
	sin6.sin6_addr.s6_addr32[2] = htonl(0);
	sin6.sin6_addr.s6_addr32[3] = htonl(1);
	OSERROR(connect(sfd, (struct sockaddr *)&sin6, 32),
		"connect");

	OSERROR(sendfile(sfd, dfd, NULL, 65536), "sendfile");
	return 0;
}

