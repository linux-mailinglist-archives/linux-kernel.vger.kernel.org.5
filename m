Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C9F807A17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379736AbjLFVFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379748AbjLFVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E05AD5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701896746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZutLjg4ZrXSy0kTMsgMWzWoflkvk2VdU4Om/vjd4igU=;
        b=LEVwRCyCYEMIldC9oYQXg/DQQWdSagM322xsK+PapOgsC18oMiKEuWfVuhlQN2Sz7TQRF0
        /Okb54yIjfaAZMOwukJ+e5ngPdwBzLWhVqPzUFX16yv79JPDaTSetm2QsAqmMy+SL9liFV
        1XOSURfR+/ehrZTrRKTd3IpvHH0qSU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ys5jfklFPL-HBOzOC9AXQg-1; Wed, 06 Dec 2023 16:05:41 -0500
X-MC-Unique: ys5jfklFPL-HBOzOC9AXQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EBB48493EA;
        Wed,  6 Dec 2023 21:05:40 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B06728174;
        Wed,  6 Dec 2023 21:05:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
        <87v89dvuxg.fsf@oldenburg.str.redhat.com>
        <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
        <202312061236.DE847C52AA@keescook>
Date:   Wed, 06 Dec 2023 22:05:36 +0100
In-Reply-To: <202312061236.DE847C52AA@keescook> (Kees Cook's message of "Wed,
        6 Dec 2023 12:47:27 -0800")
Message-ID: <87edfzavof.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

* Kees Cook:

> On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
>> Report available page shifts in arch independent manner, so that
>> userspace developers won't have to parse /proc/cpuinfo hunting
>> for arch specific strings:
>> 
>> Note!
>> 
>> This is strictly for userspace, if some page size is shutdown due
>> to kernel command line option or CPU bug workaround, than is must not
>> be reported in aux vector!
>
> Given Florian in CC, I assume this is something glibc would like to be
> using? Please mention this in the commit log.

Nope, I just wrote a random drive-by comment on the first version.

>> x86_64 machine with 1 GiB pages:
>> 
>> 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
>> 	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00
>> 
>> x86_64 machine with 2 MiB pages only:
>> 
>> 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
>> 	00000040  1d 00 00 00 00 00 00 00  00 10 20 00 00 00 00 00
>> 
>> AT_PAGESZ is always 4096 which is not that interesting.
>
> That's not always true. For example, see arm64:
> arch/arm64/include/asm/elf.h:#define ELF_EXEC_PAGESIZE  PAGE_SIZE

I'm pretty sure the comment refers to the x86-64 situation. 8-)

> I'm not actually sure why x86 forces it to 4096. I'd need to go look
> through the history there.

On x86-64, page size 4096 is architectural.  Likewise on s390x and a few
other architectures.

Thanks,
Florian

