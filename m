Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A6807F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjLGEXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGEXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:23:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6478CA9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701923000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ulgd6APR6tJoXOtI6Z0BNkxh6DNgXO1Xqt99EIAg7hA=;
        b=KLIoyKuIwXDp1WSzW+Ay/qKvfR/JVILpaWuBGlN/LmC63j7SRsIaHOnyErHtD1oAy0wFkK
        LBL3SfoDeC2LHPiinxtH3tYB1v7yRo4bNKwBhkh/YrQeDvrppkDEe0Hvvi5YDJwiaCos9a
        gnm8baq5SvKm7OkJWqe2woSLL0w7Rn8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-SiG50LfSPIKl9dSEpEVupw-1; Wed,
 06 Dec 2023 23:23:17 -0500
X-MC-Unique: SiG50LfSPIKl9dSEpEVupw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37C781C05AE8;
        Thu,  7 Dec 2023 04:23:17 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C10C8CD0;
        Thu,  7 Dec 2023 04:23:16 +0000 (UTC)
Date:   Thu, 7 Dec 2023 12:23:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
References: <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXCRF-bvm8ijXxr4@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/23 at 04:19pm, Michal Hocko wrote:
> On Wed 06-12-23 14:49:51, Michal Hocko wrote:
> > On Wed 06-12-23 12:08:05, Philipp Rudo wrote:
> [...]
> > > If I understand Documentation/core-api/pin_user_pages.rst correctly you
> > > missed case 1 Direct IO. In that case "short term" DMA is allowed for
> > > pages without FOLL_LONGTERM. Meaning that there is a way you can
> > > corrupt the CMA and with that the crash kernel after the production
> > > kernel has panicked.
> > 
> > Could you expand on this? How exactly direct IO request survives across
> > into the kdump kernel? I do understand the RMDA case because the IO is
> > async and out of control of the receiving end.
> 
> OK, I guess I get what you mean. You are worried that there is 
> DIO request
> program DMA controller to read into CMA memory
> <panic>
> boot into crash kernel backed by CMA
> DMA transfer is done.
> 
> DIO doesn't migrate the pinned memory because it is considered a very
> quick operation which doesn't block the movability for too long. That is
> why I have considered that a non-problem. RDMA on the other might pin
> memory for transfer for much longer but that case is handled by
> migrating the memory away.
> 
> Now I agree that there is a chance of the corruption from DIO. The
> question I am not entirely clear about right now is how big of a real
> problem that is. DMA transfers should be a very swift operation. Would
> it help to wait for a grace period before jumping into the kdump kernel?

On system with hardware IOMMU of x86_64, people finally had fixed it
after very long history of trying, arguing. Until 2014, HPE's engineer came
up with a series to copy the 1st kernel's iommu page table to kdump
kernel so that the on-flight DMA from 1st kernel can continue
transferring. Later, these attempts and discussions were converted codes
into mainline kernel. Before that, people even tried to introduce
reset_devices() before jumping to kdump kernel. But that was denied
immediately because any extra unnecessary actions could cause uncertain
failure of kdump kernel, given 1st kernel has been in an unpredictable
unstable situation.

We can't guarantee how swift the DMA transfer could be in the cma, case,
it will be a venture.

[3]
[PATCH v9 00/13] Fix the on-flight DMA issue on system with amd iommu
https://lists.openwall.net/linux-kernel/2017/08/01/399

[2]
[PATCH 00/19] Fix Intel IOMMU breakage in kdump kernel
https://lists.openwall.net/linux-kernel/2015/06/13/72

[1]
[PATCH 0/8] iommu/vt-d: Fix crash dump failure caused by legacy DMA/IO
https://lkml.org/lkml/2014/4/24/836

> 
> > Also if direct IO is a problem how come this is not a problem for kexec
> > in general. The new kernel usually shares all the memory with the 1st
> > kernel.
> 
> This is also more clear now. Pure kexec is shutting down all the devices
> which should terminate the in-flight DMA transfers.

Exactly. That's what I have been noticing in this thread.

