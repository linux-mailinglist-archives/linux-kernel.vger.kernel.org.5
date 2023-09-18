Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952487A469F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbjIRKEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbjIRKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7F12D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695031386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHQ1/UuyBZLpfUL6czplgqv9YFzz7xn0PsYaq4PItgo=;
        b=Ba1yaAcaroRpJDJYaGfg9tXRcpohLqvasWH451/8/vOdbtqkERGPDX1QJRvFeQa3PFPr8I
        gZPfvUB32un3ROsE50rKRbN0zIad0WtOGG93Y5h8geGt56B3pz/CeIbBp/vg4ElI7DKWhU
        j+55PsgKeaBrOg1M6JWx8V3QLVuqRis=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-7I-FY3CRN5Wqikm7tOozwQ-1; Mon, 18 Sep 2023 06:03:04 -0400
X-MC-Unique: 7I-FY3CRN5Wqikm7tOozwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC910101A550;
        Mon, 18 Sep 2023 10:03:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8044C15BB8;
        Mon, 18 Sep 2023 10:03:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3793723.1694795079@warthog.procyon.org.uk>
References: <3793723.1694795079@warthog.procyon.org.uk> <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com> <0000000000001c12b30605378ce8@google.com>
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
Content-ID: <3905045.1695031382.1@warthog.procyon.org.uk>
Date:   Mon, 18 Sep 2023 11:03:02 +0100
Message-ID: <3905046.1695031382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I think the attached is probably an equivalent cleaned up reproducer.  Note
> that if the length given to sendfile() is less than 65536, it fails with
> EINVAL before it gets into __ip6_append_data().

Actually, it only fails with EINVAL if the size is not a multiple of the block
size of the source file because it's open O_DIRECT so, say, 65536-512 is fine
(and works).

But thinking more on this further, is this even a bug in my code, I wonder?
The length passed is 65536 - but a UDP packet can't carry that, so it
shouldn't it have errored out before getting that far?  (which is what it
seems to do when I try it).

I don't see how we get past the length check in ip6_append_data() with the
reproducer we're given unless the MTU is somewhat bigger than 65536 (is that
even possible?)

David

