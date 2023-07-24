Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0341875F89C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGXNhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGXNhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940582D46
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690205681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nlp127bLQT9/IdMnc0IeGz9d5IiRzXNJt1iTm1vMsCQ=;
        b=fT4B+HCITtFsN/rA4tpE+CdsuUN0KWU4l8ImsZ45O0uE/+3I7p7zRBXkajKz0vL/g+YO6k
        sZNhMlJMPMTDaz++nPYn8nNvRHAUrSU8M/JDsf51Tw1WgoTSt+JFycSu1TDFiVb6dbHHbr
        7YkwNh3S7jML7FGPP1f563goemstelc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-7njwa9GAOLizVthp8haMkg-1; Mon, 24 Jul 2023 09:34:36 -0400
X-MC-Unique: 7njwa9GAOLizVthp8haMkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F2DB8030AC;
        Mon, 24 Jul 2023 13:34:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E6540C6F4F;
        Mon, 24 Jul 2023 13:34:33 +0000 (UTC)
Date:   Mon, 24 Jul 2023 21:34:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     thunder.leizhen@huaweicloud.com
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 0/3] arm64: kdump: Restore the write protection for the
 crashkernel memory region
Message-ID: <ZL595WtNlLnvtnJl@MiWiFi-R3L-srv>
References: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/21/23 at 04:17pm, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Unlike in the past, the low memory allocation direction of the crashkernel is
> changed from top-down to bottom-up. As long as the DMA zone has sufficient
> continuous free memory, the allocated crashkernel low memory must meet the
> requirements. The allocation direction of crashkernel high memory remains
> unchanged, that is, top-down. As long as the high memory(above DMA zone) has
> sufficient continuous free memory, the allocated crashkernel high memory must
> meet the requirements. In this way, with the restoration of the original
> page-level mapping and the implementation of the arch_kexec_protect_crashkres()
> function, write protection for the crashkernel memory region can be supported.
> 
> Of course, if the high memory or low memory cannot meet the initial requirements,
> that is, fall back is required. In this case, write protection is not supported
> because the newly allocated memory is not page-level mapped.
> 
> Because the original retry process is eliminated, the new process looks clearer
> and is a simple sequential flow.

Thanks, but no.

The pure semantics and the corresponding implementation have been 
complicated, it's not worth adding so much more complication to it
just because of one inessential feature.

If stomp really happened and destroy the loaded kdump kernel, the write
protection truly can save kdump to make vmcore dumping succeed. While
without write protection, we at least know that stomp happened by the
later checksum verifycation. That's an advantage over write protection
which silently ignores the stomp, right?

So, due to the low cost performance, from people maintaining and
understanding the code point of view, I would like to NACK this series.
BUT since all these code changes are added into arm64 arch, I won't
object if arm64 maintainers wants to pikc them up.

By the way, as we have talked before, arm64 lacks the loaded kernel
checksum storing and verifying, would you like to add that?

Thanks
Baoquan

