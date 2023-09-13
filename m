Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1079EA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbjIMOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241182AbjIMOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B50081BE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694613669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xS4/fTwaJzoinJru6fqZ1bq4iwGN/D53z+FVXXr+H7M=;
        b=Mkb38tvedVPWLVvhtB9K/0ri8VmQshXCN//mFgHCO6+OBKF5X2Va0Q1lKk4cOkeS2ZKrch
        YVZBSEB0v4WTXxJpiwDMbvETC9uyiV4Y1PhlTXROuT9bqLspvCJWABZ60/KwhVNp5zsUbZ
        g/4wiJneEZm2tWE+T27zY5uNgG6NRuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-TQukLfSvNPe2LCPAt8_LrA-1; Wed, 13 Sep 2023 10:01:03 -0400
X-MC-Unique: TQukLfSvNPe2LCPAt8_LrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4E27939A78;
        Wed, 13 Sep 2023 14:00:48 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9BCF1008807;
        Wed, 13 Sep 2023 14:00:46 +0000 (UTC)
Date:   Wed, 13 Sep 2023 16:00:45 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        bluca@debian.org, lennart@poettering.net
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230913160045.40d377f9@rotkaeppchen>
In-Reply-To: <20230911052535.335770-1-kernel@jfarr.cc>
References: <20230911052535.335770-1-kernel@jfarr.cc>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

All in all the code looks fine to me. Nevertheless I don't think UKI support
should be added at the moment. This is because IMHO you basically reinterpret
the kexec_file systemcall and thus add a new uapi to the kernel. Once
introduced it is extremely hard to remove or change an uapi again. The problem
I see is that the spec you based your work on is in such a poor shape that I
don't feel comfortable to add any new uapi based on it.

For example there are two definitions for the UKI which contradict each other.
The dedicated one [1] you have cited earlier and the one in the BLS for type #2
entries [2]. In [1] the .linux and .initrd sections are mandatory and the
.osrel and .cmdline sections are optional while in [2] it is the other way
round. Which definition should the kernel follow?

Furthermore, I absolutely don't understand how the spec should be read. All
the spec does is defining some file formats. There is no word about which
component in the boot chain is supposed to handle them and what exactly this
component is supposed to do with it. But that is crucial if we want to add UKI
support for kexec as the kexec systemcall will replace the stub. So we need to
know what tasks the stub is supposed to perform. Currently this is only some
implementation detail of the systemd-stub [3] that can change any moment and I
strongly oppose to base any uapi on it.

In the end the only benefit this series brings is to extend the signature
checking on the whole UKI except of just the kernel image. Everything else can
also be done in user space. Compared to the problems described above this is a
very small gain for me.

Until the spec got fixed I don't see a chance to add UKI support for kexec.

Thanks
Philipp

[1] https://uapi-group.org/specifications/specs/unified_kernel_image/
[2] https://uapi-group.org/specifications/specs/boot_loader_specification/#type-2-efi-unified-kernel-images
[3] https://www.freedesktop.org/software/systemd/man/systemd-stub.html

On Mon, 11 Sep 2023 07:25:33 +0200
Jan Hendrik Farr <kernel@jfarr.cc> wrote:

> Hello,
> 
> this patch (v2) implements UKI support for kexec_file_load. It will require
> support in the kexec-tools userspace utility. For testing purposes the
> following can be used: https://github.com/Cydox/kexec-test/
> 
> Creating UKIs for testing can be done with ukify (included in systemd),
> sbctl, and mkinitcpio, etc.
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

