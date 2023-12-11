Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9715480C10A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjLKF4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjLKF4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:56:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E0EEB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702274168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQMg/oQLQ+AfY0dgegoDtJ1iAm0snwYJkd6yvNpoSzg=;
        b=VSbA+yszQy7dpNWYN4YeY00czF7579j0XjPUAop3r2+nZF5jPGLF1FxJvRE2qaSjycqXan
        7vUlry3xpW4yV4+MG44MqtlRppQF6hrMPC+dMqeZTur8DL2E+1fVEXHRVOprndaFhk+mJX
        /zEXwES4kNlGOYJRACTSkf/kgYPdtxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-1DnNItMvMzGKeaaYkGtXLA-1; Mon, 11 Dec 2023 00:53:26 -0500
X-MC-Unique: 1DnNItMvMzGKeaaYkGtXLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65501185A78B;
        Mon, 11 Dec 2023 05:53:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AD063C27;
        Mon, 11 Dec 2023 05:53:15 +0000 (UTC)
Date:   Mon, 11 Dec 2023 13:53:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuntao Wang <ytcoode@gmail.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] crash_core: Fix the check for whether crashkernel is
 from high memory
Message-ID: <ZXajyFKrSp5oRKwf@MiWiFi-R3L-srv>
References: <20231209141438.77233-1-ytcoode@gmail.com>
 <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

On 12/09/23 at 02:34pm, Andrew Morton wrote:
> On Sat,  9 Dec 2023 22:14:38 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > If crash_base is equal to CRASH_ADDR_LOW_MAX, it also indicates that
> > the crashkernel memory is allocated from high memory. However, the
> > current check only considers the case where crash_base is greater than
> > CRASH_ADDR_LOW_MAX. Fix it.
> > 
> > This patch also includes some minor cleanups.
> 
> Can we please include a description of the runtime effects of this
> change?  ie, what happens now and under what circumstances, and how
> does the fix alter these things?

This is a good catch. Guess it's observed from code exploring.

The runtime effects is that crashkernel high memory is successfully
reserved, whereas the crashkernel low memory is bypassed in this
case, then kdump kernel bootup will fail because of no low memory
under 4G.

