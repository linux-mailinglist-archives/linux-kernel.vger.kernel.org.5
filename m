Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317B1808BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443512AbjLGPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443479AbjLGPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C810E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701963177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rO0LOvSsYUy+BXiNU5frBHIkiTV2KkiJuS/MBqYnFgM=;
        b=Pq2l/XDAfChKBJWXGX+Y+tGw97V0nvkN8FbwmNmRnDU+IehDC7KRdcg30neclWDVYl7oPT
        8uDC38FKqzcnp0HOf/oeAoNfsLL7dJ8l0Yl6pNval0fbsb2GPu+SE35+sdPLtzIbswr9jE
        zewQ2JWigbmdLS57MPwxyOlE3MKKokU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-haFiz_prNXKDzFwaWDEU7g-1; Thu, 07 Dec 2023 10:32:54 -0500
X-MC-Unique: haFiz_prNXKDzFwaWDEU7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1694910334AA;
        Thu,  7 Dec 2023 15:32:54 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEA77111E400;
        Thu,  7 Dec 2023 15:32:52 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
        <87v89dvuxg.fsf@oldenburg.str.redhat.com>
        <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
        <202312061236.DE847C52AA@keescook>
        <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
Date:   Thu, 07 Dec 2023 16:32:51 +0100
In-Reply-To: <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183> (Alexey Dobriyan's
        message of "Thu, 7 Dec 2023 17:57:05 +0300")
Message-ID: <8734wehvto.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexey Dobriyan:

> On Wed, Dec 06, 2023 at 12:47:27PM -0800, Kees Cook wrote:
>> On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
>> > Report available page shifts in arch independent manner, so that
>> > userspace developers won't have to parse /proc/cpuinfo hunting
>> > for arch specific strings:
>> > 
>> > Note!
>> > 
>> > This is strictly for userspace, if some page size is shutdown due
>> > to kernel command line option or CPU bug workaround, than is must not
>> > be reported in aux vector!
>> 
>> Given Florian in CC, I assume this is something glibc would like to be
>> using? Please mention this in the commit log.
>
> glibc can use it. Main user is libhugetlbfs, I guess:
>
> 	https://github.com/libhugetlbfs/libhugetlbfs/blob/master/hugeutils.c#L915
>
> Loop inside getauxval() can run faster than opendir().

Is libhugetlbfs still maintained?  Last commit was three years ago?

Thanks,
Florian

