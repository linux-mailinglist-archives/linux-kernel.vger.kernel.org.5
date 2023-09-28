Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654297B183A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjI1K0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjI1K0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498E126
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695896756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AJu1zUMjVZ+lx0EEl0IqbzumrKDe4gTjJqCGJOtK7tM=;
        b=EAxyDW7Fp7I5C795p7SD9bqaHW8BexJVQ9tAvvC2vVI0zC9lf38ajToQVL1Am/oFI9aJbP
        Iu8A72xFHLe7JuZxJE26RoAjXOMk0b5g6o2BVnx8o/hRra7L0DVX3ogTYo0yRzkkl+A9vQ
        jB+kEAdA05W37T6jUsRR7B9ooryg8u0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-NZW55hpLN0K6FJOvmhO7Rg-1; Thu, 28 Sep 2023 06:25:50 -0400
X-MC-Unique: NZW55hpLN0K6FJOvmhO7Rg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 600CB18811FB;
        Thu, 28 Sep 2023 10:25:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4770492B16;
        Thu, 28 Sep 2023 10:25:47 +0000 (UTC)
Date:   Thu, 28 Sep 2023 18:25:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        stanislav.kinsburskii@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
        wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        graf@amazon.de, pbonzini@redhat.com, david@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <58146.123092712145601339@us-mta-73.us.mimecast.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58146.123092712145601339@us-mta-73.us.mimecast.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/23 at 09:13am, Stanislav Kinsburskii wrote:
> On Wed, Sep 27, 2023 at 01:44:38PM +0800, Baoquan He wrote:
> > Hi Stanislav,
> > 
> > On 09/25/23 at 02:27pm, Stanislav Kinsburskii wrote:
> > > This patch introduces a memory allocator specifically tailored for
> > > persistent memory within the kernel. The allocator maintains
> > > kernel-specific states like DMA passthrough device states, IOMMU state, and
> > > more across kexec.
> > 
> > Can you give more details about how this persistent memory pool will be
> > utilized in a actual scenario? I mean, what problem have you met so that
> > you have to introduce persistent memory pool to solve it?
> > 
> 
> The major reason we have at the moment, is that Linux root partition
> running on top of the Microsoft hypervisor needs to deposit pages to
> hypervisor in runtime, when hypervisor runs out of memory.
> "Depositing" here means, that Linux passes a set of its PFNs to the
> hypervisor via hypercall, and hypervisor then uses these pages for its
> own needs.
> 
> Once deposited, these pages can't be accessed by Linux anymore and thus
> must be preserved in "used" state across kexec, as hypervisor state is
> unware of kexec. In the same time, these pages can we withdrawn when
> usused. Thus, an allocator persistent across kexec looks reasonable for
> this particular matter.

Thanks for these details.
 
The deposit and withdraw remind me the Balloon driver, David's virtio-mem,
DLPAR on ppc which can hot increasing or shrinking phisical memory on guest
OS. Can't microsoft hypervisor do the similar thing to reclaim or give
back the memory from or to the 'Linux root partition' running on top of
the hypervisor?

Thanks
Baoquan

