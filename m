Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1605B80867D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjLGLNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378965AbjLGLNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2EA10D4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701947618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEnLporZicOdwXzovzLImpcCBG07E/v0woo+yYuLxfQ=;
        b=bk0a1NWSWKhpRq4SN2lSpj5DY3reCh7TMF6R6FBcF3swKyIAFfqGoisK1L1SZV7Sr21VnL
        adjn2bfnxJ6bOxZwseNBKB3C4k3XQitNBKOuACo4bnG+oovqSP7ZKPEngVQoyeSKQK9h+6
        K268YmTH51UFhbk72Da4Swq7nuV/oIY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-ZijdJiQQOamHdkna9Z4FVw-1; Thu, 07 Dec 2023 06:13:35 -0500
X-MC-Unique: ZijdJiQQOamHdkna9Z4FVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1270862FDF;
        Thu,  7 Dec 2023 11:13:34 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25BAD40C6EB9;
        Thu,  7 Dec 2023 11:13:33 +0000 (UTC)
Date:   Thu, 7 Dec 2023 12:13:31 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231207121331.59c7e370@rotkaeppchen>
In-Reply-To: <ZXCRF-bvm8ijXxr4@tiehlicka>
References: <ZWhg_b3O6piZtkQ-@tiehlicka>
        <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
        <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
        <ZWiQ-II9CvGv8EWK@tiehlicka>
        <20231201123353.2b3db7fa@rotkaeppchen>
        <ZWnJyArAmFo_uYPA@tiehlicka>
        <20231201165113.43211a48@rotkaeppchen>
        <ZWoQ1k2AikSiMjys@tiehlicka>
        <20231206120805.4fdcb8ab@rotkaeppchen>
        <ZXB7_rbC0GAkIp7p@tiehlicka>
        <ZXCRF-bvm8ijXxr4@tiehlicka>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 16:19:51 +0100
Michal Hocko <mhocko@suse.com> wrote:

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

Right that is the scenario we need to prevent.

> Now I agree that there is a chance of the corruption from DIO. The
> question I am not entirely clear about right now is how big of a real
> problem that is. DMA transfers should be a very swift operation. Would
> it help to wait for a grace period before jumping into the kdump kernel?

Please see my other mail.

> > Also if direct IO is a problem how come this is not a problem for kexec
> > in general. The new kernel usually shares all the memory with the 1st
> > kernel.  
> 
> This is also more clear now. Pure kexec is shutting down all the devices
> which should terminate the in-flight DMA transfers.

Right, it _should_ terminate all transfers. But here we are back at the
shitty device drivers that don't have a working shutdown method. That's
why we have already seen the problem you describe above with kexec. And
please believe me that debugging such a scenario is an absolute pain.
Especially when it's a proprietary, out-of-tree driver that caused the
mess.

Thanks
Philipp

