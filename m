Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452F77A4B84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjIRPSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjIRPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416CF138
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695050221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJqX1sGDZxCaO6XqvDak7bVSlywdTalhVTk58OTxlhc=;
        b=JtSI5WpmKF997NCEDeW9A8Yalptm6G6x371g8oELnCh9yFALOsLTlZN4NVLJ5WcFnwkgT+
        A3IEQ1lYfpp+fgdzX9yFHM1/8yy/6ag36Qao1JbZ/0kChHTGpBkV+X1h9v4cCFUQqW56TH
        YM1H68t+YLVhi8P2WXuqfm1cYQbv+gk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-fx8Km0DFOuGpnqu3F2U_Iw-1; Mon, 18 Sep 2023 10:46:18 -0400
X-MC-Unique: fx8Km0DFOuGpnqu3F2U_Iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B24FA802E5A;
        Mon, 18 Sep 2023 14:46:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCBF1005E27;
        Mon, 18 Sep 2023 14:46:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch>
References: <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch> <3793723.1694795079@warthog.procyon.org.uk> <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com> <0000000000001c12b30605378ce8@google.com> <3905046.1695031382@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4138873.1695048373.1@warthog.procyon.org.uk>
Date:   Mon, 18 Sep 2023 15:46:13 +0100
Message-ID: <4138874.1695048373@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> 
> An ipv6 packet can carry 64KB of payload, so maxnonfragsize of 65535 + 40
> sounds correct. But payload length passed of 65536 is not (ignoring ipv6
> jumbograms). So that should probably trigger an EINVAL -- if that is indeed
> what the repro does.

The problem is that on entry to __ip6_append_data(), the length includes
transhdrlen.  However, this is a problem if we already have something in the
packet.  At that point, this fails:

			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
				goto error;

because copy includes transhdrlen.

David

