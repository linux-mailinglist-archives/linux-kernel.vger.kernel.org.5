Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52FE7F9C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjK0JET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjK0JEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DB312D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701075859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=piML3Mid1NWxeF+rFETYzTPt2JomB1OniMRw7lokn98=;
        b=YFJP0TGhx2eEhignO2WOE2KdNZ5XvJXhJpcM47x7bAXiT/VdNC6ICvnDUx9L8lxonLcMOA
        xviifeGyDLTDmR9E32GfCC2xEvIqMKZ6qVG45Z9AYGJDPAgdDKDupfvKDrclfs07lMlP0+
        EGk4ibc+CH1ixUOQK8R3IVuiCtJixP4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-XqktnsTiM5WdgFevyW0t4Q-1; Mon,
 27 Nov 2023 04:04:15 -0500
X-MC-Unique: XqktnsTiM5WdgFevyW0t4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E68D1C06EC9;
        Mon, 27 Nov 2023 09:04:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20E47C1596F;
        Mon, 27 Nov 2023 09:04:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231122214447.675768-1-jannh@google.com>
References: <20231122214447.675768-1-jannh@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1508420.1701075853.1@warthog.procyon.org.uk>
Date:   Mon, 27 Nov 2023 09:04:13 +0000
Message-ID: <1508421.1701075853@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> +	/* same checks as in tls_sw_push_pending_record() */

Wouldn't it be better to say what you're checking rather than referring off to
another function that might one day disappear or be renamed?

David

