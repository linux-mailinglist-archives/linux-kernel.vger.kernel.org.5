Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9617F616E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345826AbjKWO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9FD44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700749641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPYmWVJiio69jB+wuetIWO6yNFF7oZKH/nujKKk+JfY=;
        b=LO0GdyeDpC5N5eHNYYrNvQyiAXtKoZTlQ6AoFeBMW9lxzzzb9TxTYo6KU3WiHFe83h4AOt
        OOxaKgX5F/5MkliGvdW04nebw2sZUZsYOxsrvLSF1FnqHLG8MmjBMpmhLeRNMDKmRgiaWg
        XJGgVWn/UbLCMrp2QY6z+I7T5HpppJk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-uwyJZVJuNfucj7yT_WV1hg-1; Thu,
 23 Nov 2023 09:27:18 -0500
X-MC-Unique: uwyJZVJuNfucj7yT_WV1hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78228280CFA4;
        Thu, 23 Nov 2023 14:27:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C20F4C1596F;
        Thu, 23 Nov 2023 14:27:16 +0000 (UTC)
Date:   Thu, 23 Nov 2023 22:27:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, ignat@cloudflare.com,
        eric_devolder@yahoo.com
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZV9hQfugDw2gDTRy@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 at 03:13pm, Alexander Gordeev wrote:
> On Thu, Nov 23, 2023 at 03:36:51PM +0800, Baoquan He wrote:
> > When below kernel config items are set, compiling error are triggered.
> > 
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_CRASH_DUMP=y
> > CONFIG_CRASH_HOTPLUG=y
> > 
> > ------------------------------------------------------
> > drivers/base/cpu.c: In function ‘crash_hotplug_show’:
> > drivers/base/cpu.c:309:40: error: implicit declaration of function ‘crash_hotplug_cpu_support’; did you mean ‘crash_hotplug_show’? [-Werror=implicit-function-declaration]
> >   309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
> >       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                                        crash_hotplug_show
> > cc1: some warnings being treated as errors
> > ------------------------------------------------------
> > 
> > CONFIG_KEXEC is used to enable kexec_load interface, the
> > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > 
> > Fix it now.
> 
> If this error introduced with the prevous patch?
> If so, the patches need to be swapped I guess.

From the phenomenon, yes. In fact it's the patch 1 which exposes
the wrong ifdeffery. I can shift the order in v2. Thanks.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 

