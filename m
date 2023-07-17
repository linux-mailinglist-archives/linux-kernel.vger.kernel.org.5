Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28060756201
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGQLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGQLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39771E63
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689594452;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XoC2G0nnA2kPHHcStH+QyclfRSBxpdO+zzyK3ACzr3I=;
        b=C3viNnYZCjM27/J6uTxQ+9NGfhhdQEhFGP/DGdVyv6kRZscZhgzWuMK6RoR9jDSxaRmJKh
        gXue+zRr/xFe7IBuoABZ4hDRfjLsioqUCigQr0e6u05gzN7Jnc4W1dz4gBDcx0GdHjjRAq
        qMG6o/avvAIYzFkCkt/kLkDtINBXzuw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-oBBrPLdqMGKcD0j4TgAThg-1; Mon, 17 Jul 2023 07:47:27 -0400
X-MC-Unique: oBBrPLdqMGKcD0j4TgAThg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 746C928237C7;
        Mon, 17 Jul 2023 11:47:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F73C1454143;
        Mon, 17 Jul 2023 11:47:24 +0000 (UTC)
Date:   Mon, 17 Jul 2023 12:47:21 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Luca Boccassi <bluca@debian.org>,
        Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <ZLUqSf1AwN9tC8S8@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
 <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh>
 <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
 <2023071643-broiler-level-afbf@gregkh>
 <ZLUIViihakhyPV1N@redhat.com>
 <20230717110631.GH4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717110631.GH4253@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:06:31PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 17, 2023 at 10:22:51AM +0100, Daniel P. Berrangé wrote:
> > I'm not aware of any kernel CVEs since that point in time that
> > would have implied SBAT changes, but admittedly I've not paid
> > close enough attention to be entirely confident. Is going back
> > through 2 years of kernel CVEs (to the point where SBAT was
> > invented) a long enough timeframe to satisfy this request for
> > info on the frequency of changes ?
> 
> Many *MANY* security bugs never get a CVE. CVE is meaningless when it
> comes to kernel bugs. Why does it make sense to review CVEs ?

Yes, I know many security bugs gets fixed without a CVE being
assigned, but in the context of the question that doesn't
matter.

The SBAT version number will be incremented in response to an
identified security bug. Even if upstream has not assigned a
CVE to an issue, downstream vendors are likely to have done
so *if* they identified the security issue.

If neither upstream, nor downstream, publically identified a
fix as a security issue, then by extension they would also
not have identified a need to change to the SBAT version info
either.

Thus looking at publically identified security issues via
CVEs is a reasonable proxy to guage how many times SBAT
would have been incremented, which is what Greg asked for.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

