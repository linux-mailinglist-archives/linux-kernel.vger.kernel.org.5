Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88627DF53E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjKBOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKBOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047D8E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698936077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5I1DzcUHhKwPSxkAOkHHxlvZoj2yZczuR1JJ9+Hi2nY=;
        b=Vn0N2vh42J/huJmF8vNyTnkiuHRsUS8G9K3BrMyedaC9pCh0lSeW8uE1dG9kyjKzxreo8c
        Q2nDTrlTIzCvRsDv+1FokhiLEXZGBkPCQCDZKPmte9VypfCPleUAMVfLJ7NJMWP7MEgqaa
        c8IAYejnn/UhOyzTTVvODNPnVJJlkjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-WqPR65oLOEW_QjCZcMWSDw-1; Thu, 02 Nov 2023 10:41:16 -0400
X-MC-Unique: WqPR65oLOEW_QjCZcMWSDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96547101B048;
        Thu,  2 Nov 2023 14:41:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id B8DB42026D6E;
        Thu,  2 Nov 2023 14:41:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 Nov 2023 15:40:13 +0100 (CET)
Date:   Thu, 2 Nov 2023 15:40:11 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] cleanup: Add conditional guard support
Message-ID: <20231102144009.GA9680@redhat.com>
References: <20231102104429.025835330@infradead.org>
 <20231102110706.460851167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102110706.460851167@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02, Peter Zijlstra wrote:
>
>  include/linux/cleanup.h  |   52 ++++++++++++++++++++++++++++++++++++++++++++---

interesting... I don't know anything about cleanup.h, will
read this code and the patch later, but I guess I understand
the idea.

Stupid/offtopic question... Can't we change guard()

	-#define guard(_name) \
	-	CLASS(_name, __UNIQUE_ID(guard))
	+#define guard(_name, args...) \
	+	CLASS(_name, __UNIQUE_ID(guard))(args)

and update the current users?

To me

	guard(rcu);
	guard(spinlock, &lock);

looks better than

	guard(rcu)();
	// doesn't match scoped_guard(spinlock, &lock)
	guard(spinlock)(&lock);

And this will make guard() consistent with scoped_guard().

No?

Oleg.

