Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC07EE120
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjKPNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345077AbjKPNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B519D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700140387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=56qEDo8yIqTUJHP8P2HT8aLUWZCphDYXUxLI2O0HehM=;
        b=dkZ/VoiflATUq+cxHyx1+BGhmqRVgAa60JfOqxBiBsM0lg6OmqteHA37tpAJBRGRI3eKWD
        xVqYRIq/V4d9a2gyH/3kArHL2GOPCfaBhg5lWl+bsoSk/z6K/In8QuswXMH4rJ7LTB258X
        vX7OP7Nzibc8TKVu9nVC1aIslWHpjaw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-Ddy73NA3Nwaye6z-spbp7g-1; Thu,
 16 Nov 2023 08:13:04 -0500
X-MC-Unique: Ddy73NA3Nwaye6z-spbp7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E3E51C05193;
        Thu, 16 Nov 2023 13:13:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35F5F2166B27;
        Thu, 16 Nov 2023 13:13:02 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] rxrpc: ACK handling fixes
Date:   Thu, 16 Nov 2023 13:12:57 +0000
Message-ID: <20231116131259.103513-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a couple of patches to fix ACK handling in AF_RXRPC:

 (1) Allow RTT determination to use an ACK of any type as the response from
     which to calculate RTT, provided ack.serial matches the serial number
     of the outgoing packet.

 (2) Defer the response to a PING ACK packet (or any ACK with the
     REQUEST_ACK flag set) until after we've parsed the packet so that we
     carry up to date information if the Tx or Rx rings are advanced.

David

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (2):
  rxrpc: Fix RTT determination to use any ACK as a source
  rxrpc: Defer the response to a PING ACK until we've parsed it

 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/input.c            | 61 +++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 33 deletions(-)

