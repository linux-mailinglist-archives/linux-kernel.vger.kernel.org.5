Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588D17A2275
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjIOPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjIOPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 249C9E50
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694791950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RVB1hOIPfQpHaOi4Yk7qJuVpzOQ7elLy/nnGKg1a4U=;
        b=asIn1nS9/YqQeRzfllqq7EGfSjuEg+EGAVmDGCFVl+qxkbMnjzqATAy60t5mM8hZFa55re
        LoNo+c4lJLmYIXymwd1UNWlvfmKGMPzu/92n9NcLzbvWODRGQtyf+EnB6dba7yzHcvljaa
        9RwNjR9/sMvnl3NB0P16dmaAR70e//Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-G74hyFSSMxyKHRVlRWqTQA-1; Fri, 15 Sep 2023 11:32:23 -0400
X-MC-Unique: G74hyFSSMxyKHRVlRWqTQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2CEC94593E;
        Fri, 15 Sep 2023 15:32:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F91C40C6EA8;
        Fri, 15 Sep 2023 15:32:21 +0000 (UTC)
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
Content-ID: <3792061.1694791940.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 15 Sep 2023 16:32:20 +0100
Message-ID: <3792062.1694791940@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> > WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_d=
ata.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800

That would appear to be this:

			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
				goto error;

However, I have a problem that the repro program errors out at this point
before it gets that far:

	if (cork->length + length > maxnonfragsize - headersize) {
   emsgsize:
		pmtu =3D max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
		return -EMSGSIZE;
	}

Are you able to reproduce the issue?

The values in and around that point are:

	cork->length		0
	length			65540
	maxnonfragsize		65575
	headersize		40
	transhdrlen		4
	mtu			65536
	ip6_sk_ignore_df(sk)	true

with maxnonfragsize coming from 'sizeof(struct ipv6hdr) + IPV6_MAXPLEN'.  =
Is
that even viable for the size of a packet?

David

