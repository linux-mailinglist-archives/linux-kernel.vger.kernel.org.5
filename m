Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963B79C1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjILBfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjILBfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7324C21F86
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694481375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LndbGk9Tq34zPmQVev5k5AT8KIrme9LRtl6RtbBDZn0=;
        b=eHmYRMisfHWslgfjLptnvX940aFlMWa3Ip6XB1Ch1UohuH49VaXWp6bHn4gVugumc4hA1K
        D4JdKLJN+uQxfDSvq1a2G4f4n/+DoRUtk8uJcPdIW8QVioyXkGy+OnamasFggPG+wj6roO
        83apI/VhGkR15G3FDrQuS44mYds59rg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-GpelxvecNu62UxAy92gbag-1; Mon, 11 Sep 2023 21:03:21 -0400
X-MC-Unique: GpelxvecNu62UxAy92gbag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66B788A437D;
        Tue, 12 Sep 2023 01:03:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D2E44407D;
        Tue, 12 Sep 2023 01:03:19 +0000 (UTC)
Date:   Tue, 12 Sep 2023 09:03:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhelgaas@google.com, bluca@debian.org,
        lennart@poettering.net, prudo@redhat.com
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <ZP+41JvEFjsnEG19@MiWiFi-R3L-srv>
References: <20230911052535.335770-1-kernel@jfarr.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911052535.335770-1-kernel@jfarr.cc>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Philipp to CC as he is also investigating UKI

On 09/11/23 at 07:25am, Jan Hendrik Farr wrote:
> Hello,
> 
> this patch (v2) implements UKI support for kexec_file_load. It will require
> support in the kexec-tools userspace utility. For testing purposes the
> following can be used: https://github.com/Cydox/kexec-test/
> 
> Creating UKIs for testing can be done with ukify (included in systemd),
> sbctl, and mkinitcpio, etc.

This is awesome work, Jan, thanks.

By the way, could you provide detailed steps about how to test this
patchset so that people interested can give it a shot?

> 
> There has been discussion on this topic in an issue on GitHub that is linked
> below for reference.
> 
> Changes for v2:
> - .cmdline section is now optional
> - moving pefile_parse_binary is now in a separate commit for clarity
> - parse_pefile.c is now in /lib instead of arch/x86/kernel (not sure if
>   this is the best location, but it definetly shouldn't have been in an
>   architecture specific location)
> - parse_pefile.h is now in include/kernel instead of architecture
>   specific location
> - if initrd or cmdline is manually supplied EPERM is returned instead of
>   being silently ignored
> - formatting tweaks
> 
> 
> Some links:
> - Related discussion: https://github.com/systemd/systemd/issues/28538
> - Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/
> 
> Jan Hendrik Farr (2):
>   move pefile_parse_binary to its own file
>   x86/kexec: UKI support
> 
>  arch/x86/include/asm/kexec-uki.h       |   7 ++
>  arch/x86/kernel/Makefile               |   1 +
>  arch/x86/kernel/kexec-uki.c            | 126 +++++++++++++++++++++++++
>  arch/x86/kernel/machine_kexec_64.c     |   2 +
>  crypto/asymmetric_keys/mscode_parser.c |   2 +-
>  crypto/asymmetric_keys/verify_pefile.c | 110 +++------------------
>  crypto/asymmetric_keys/verify_pefile.h |  16 ----
>  include/linux/parse_pefile.h           |  32 +++++++
>  lib/Makefile                           |   3 +
>  lib/parse_pefile.c                     | 109 +++++++++++++++++++++
>  10 files changed, 292 insertions(+), 116 deletions(-)
>  create mode 100644 arch/x86/include/asm/kexec-uki.h
>  create mode 100644 arch/x86/kernel/kexec-uki.c
>  create mode 100644 include/linux/parse_pefile.h
>  create mode 100644 lib/parse_pefile.c
> 
> -- 
> 2.40.1
> 

