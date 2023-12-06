Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B3806F87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378057AbjLFMRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377846AbjLFMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E419A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701865061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB959rdqwj3McpopDWbd2KITPsbXVjh5QYy/Nwyj7gY=;
        b=LDNy3lDAHufF7P/X1ceFVZHDVENsTsJorh751Y3eJ4noh/SvPFgGhyPLj7hcB2enuOKChh
        3GNQiHevgnCrHUcdkerBmhcyX69vI/Po5z/li3tG4ooPkF/bh8ht6GqgEZj7QTsuGy2Ubj
        oXz6EbFriVdCXwaYgB7V7NQxMF1s6rg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-oRHB5hP9Ot2hTUPZpvAgvg-1; Wed, 06 Dec 2023 07:17:38 -0500
X-MC-Unique: oRHB5hP9Ot2hTUPZpvAgvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CCD685CBA5;
        Wed,  6 Dec 2023 12:17:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4998D111E3EE;
        Wed,  6 Dec 2023 12:17:34 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     stern@rowland.harvard.edu
Cc:     davem@davemloft.net, edumazet@google.com, greg@kroah.com,
        jtornosm@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Wed,  6 Dec 2023 13:17:32 +0100
Message-ID: <20231206121732.7154-1-jtornosm@redhat.com>
In-Reply-To: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
References: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

> The __ax88179_read_cmd() and __ax88179_write_cmd() routines are 
> asynchronous with respect to ax88179_disconnect(), right?  Or at least, 
> they are if they run as a result of the user closing the network 
> interface.  Otherwise there wouldn't be any memory ordering issues.
Yes, I think so, they could be asynchronous regarding ax88179_disconnect.

> But the memory barriers you added are not the proper solution.  What you 
> need here is _synchronization_, not _ordering_.  As it is, the memory 
> barriers you have added don't do anything; they shouldn't be in the 
> patch.
Ok, thank you for the helpful clarification, let me check it better,
I understood it in a wrong way.

> If you would like a more in-depth explanation, let me know.
Thank you for your help, I will try first, I really appreciate this.

Best regards
José Ignacio

