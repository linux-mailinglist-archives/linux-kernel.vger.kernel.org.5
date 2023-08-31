Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E689278E445
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbjHaBRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbjHaBRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E785CE0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693444554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odZnguih+1sKH7RU7hZzlw1XKvfaTqNPqIZZXjyDxXQ=;
        b=E+BaU+/DrR+NI1GiR8VvDyThGUWsIs7fxMiw4RcoW+v1GsUcMR70IJFoVBjvog3n/QWyFm
        bmYvqSEqkzJ2KayGGSOc8ZBq+UN6ZGobJP4hzxN2M3OgaaEj8H64DjV7+F5GzdI+7XkP7s
        ydN1+f9NscpEyKQu/lTW+I5B6jzHsDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-Lq1zLEZwMbye5ne76NqVkQ-1; Wed, 30 Aug 2023 21:15:52 -0400
X-MC-Unique: Lq1zLEZwMbye5ne76NqVkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B882E8028B2;
        Thu, 31 Aug 2023 01:15:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F11642026D35;
        Thu, 31 Aug 2023 01:15:50 +0000 (UTC)
Date:   Thu, 31 Aug 2023 09:15:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Message-ID: <ZO/pwqWyxEoluNXv@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829081142.3619-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> Hello, folk!
> 
> This is the v2, the series which tends to minimize the vmap
> lock contention. It is based on the tag: v6.5-rc6. Here you
> can find a documentation about it:
> 
> wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf

Seems the wget command doesn't work for me. Not sure if other people can
retrieve it successfully.

--2023-08-30 21:14:20--  ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf
           => ‘Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf’
Resolving vps418301.ovh.net (vps418301.ovh.net)... 37.187.244.100
Connecting to vps418301.ovh.net (vps418301.ovh.net)|37.187.244.100|:21... connected.
Logging in as anonymous ... Logged in!
==> SYST ... done.    ==> PWD ... done.
==> TYPE I ... done.  ==> CWD (1) /incoming ... done.
==> SIZE Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf ... done.

==> PASV ... done.    ==> RETR Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf ... 
No such file ‘Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf’.

