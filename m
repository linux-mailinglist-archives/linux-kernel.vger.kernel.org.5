Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F68009F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378580AbjLALeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355DF1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701430452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H76S5nJm1jWqRaGejCWH6ccm2LOJtZaVxPslQ1jiKOQ=;
        b=LawP4yJWUzcM15gb2Ek8ZbJItc1tk9luuih3SlKfYX6qVtI12F2SwCVnDPDKs089Rb9t6Y
        4img4nygG1BAdGUY3NPZnBaKsgQ8K3J1KBC1asiIjtosm8atUvcusbGc0mb1RiviT/X8PA
        iLMm/NOoAOP0R2hZFyS7H0gH/zum/Zw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-B9N1asX_MoOt3O0iCcnc5Q-1; Fri, 01 Dec 2023 06:34:09 -0500
X-MC-Unique: B9N1asX_MoOt3O0iCcnc5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5FEF811E7D;
        Fri,  1 Dec 2023 11:34:08 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93FF32166B26;
        Fri,  1 Dec 2023 11:34:07 +0000 (UTC)
Date:   Fri, 1 Dec 2023 12:34:04 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231201123404.49a46a64@rotkaeppchen>
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Hi Jiri,

I'd really love to see something like this to work. Although I also
share the concerns about shitty device drivers corrupting the CMA.
Please see my other mail for that.

Anyway, one more comment below.

On Fri, 24 Nov 2023 20:54:36 +0100
Jiri Bohac <jbohac@suse.cz> wrote:

[...]
 
> Now, specifying
> 	crashkernel=100M craskhernel=1G,cma
> on the command line will make a standard crashkernel reservation
> of 100M, where kexec will load the kernel and initrd.
> 
> An additional 1G will be reserved from CMA, still usable by the
> production system. The crash kernel will have 1.1G memory
> available. The 100M can be reliably predicted based on the size
> of the kernel and initrd.

I doubt that the fixed part can be predicted "reliably". For sure it
will be more reliable than today but IMHO we will still be stuck with
some guessing. Otherwise it would mean that you already know during
boot which initrd the user space will be loading later on. Which IMHO is
impossible as the initrd can always be rebuild with a larger size.
Furthermore, I'd be careful when you are dealing with compressed kernel
images. As I'm not sure how the different decompressor phases would
handle scenarios where the (fixed) crashkernel memory is large enough
to hold the compressed kernel (+initrd) but not the decompressed one.

One more thing, I'm not sure I like that you need to reserve two
separate memory regions. Personally I would prefer it if you could
reserve one large region for the crashkernel but allow parts of it to
be reused via CMA. Otherwise I'm afraid there will be people who only
have one ,cma entry on the command line and cannot figure out why they
cannot load the crash kernel.

Thanks
Philipp
 
> When no crashkernel=size,cma is specified, everything works as
> before.
> 

