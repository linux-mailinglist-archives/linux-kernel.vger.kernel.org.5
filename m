Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B18880A3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjLHMoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjLHMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:44:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF71D1710;
        Fri,  8 Dec 2023 04:44:09 -0800 (PST)
Received: from pobox.suse.cz (unknown [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A52821C42;
        Fri,  8 Dec 2023 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702039448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0n4maJTA6v/hJg+qYTmGFfPnnHUi3IlrWUXV9a2Jkcw=;
        b=La9eDmjEtgE1tfkDvO3LLp4mDRDaXF3xKrwIFJFiMwHFHb6xlr+pMiycxsNkusq58GMart
        zjFdME5/0AFg9O/qizY6ctZoB2A/swvLAc5NRKIjICjPPnPDaGDIPmvx9HaOiosY59X2lu
        BwmBQP5W4xXRVQZkwGn2RykgTOiSKJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702039448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0n4maJTA6v/hJg+qYTmGFfPnnHUi3IlrWUXV9a2Jkcw=;
        b=9hZ8iyq8cl3swcssNyUm+DJlQP4sGp3Bm2m2sorlyfHdav5kl+tzMKuwFr1duEX0Ch98Ps
        Cw79OFkvi7si5oCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702039448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0n4maJTA6v/hJg+qYTmGFfPnnHUi3IlrWUXV9a2Jkcw=;
        b=La9eDmjEtgE1tfkDvO3LLp4mDRDaXF3xKrwIFJFiMwHFHb6xlr+pMiycxsNkusq58GMart
        zjFdME5/0AFg9O/qizY6ctZoB2A/swvLAc5NRKIjICjPPnPDaGDIPmvx9HaOiosY59X2lu
        BwmBQP5W4xXRVQZkwGn2RykgTOiSKJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702039448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0n4maJTA6v/hJg+qYTmGFfPnnHUi3IlrWUXV9a2Jkcw=;
        b=9hZ8iyq8cl3swcssNyUm+DJlQP4sGp3Bm2m2sorlyfHdav5kl+tzMKuwFr1duEX0Ch98Ps
        Cw79OFkvi7si5oCA==
Date:   Fri, 8 Dec 2023 13:44:09 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files
 are not yet built
In-Reply-To: <20230606071637.267103-12-jhubbard@nvidia.com>
Message-ID: <alpine.LSU.2.21.2312081323570.19664@pobox.suse.cz>
References: <20230606071637.267103-1-jhubbard@nvidia.com> <20230606071637.267103-12-jhubbard@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 1.79
X-Spamd-Result: default: False [2.34 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(2.44)[0.814];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_MATCH_FROMTLD(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[13];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.00)[15.61%]
X-Spam-Flag: NO
X-Spam-Score: 2.34
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Muhammad,

On Tue, 6 Jun 2023, John Hubbard wrote:

> As per a discussion with Muhammad Usama Anjum [1], the following is how
> one is supposed to build selftests:
> 
>     make headers && make -C tools/testing/selftests/mm
> 
> Change the selftest build system's lib.mk to fail out with a helpful
> message if that prerequisite "make headers" has not been done yet.
> 
> [1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/

could you, please, elaborate more on that one is supposed to build 
selftests with 'make headers'? Yes, Documentation/dev-tools/kselftest.rst 
mentions that because you might need headers but...

The common way how we test the kernel is to build the kernel, install it 
somewhere and run selftests on top. The sequence basically being "make 
rpm-pkg; rpm -ivh; cd tools/testing/selftest/livepatch/ in source tree; 
sudo make run_tests" (or a similar variation of the procedure). The point 
is that we want to test the running kernel with its respective environment 
installed in /lib/modules/`uname -r`/ (if needed). This way we can run 
newer selftests from the current mainline tree on older kernels among 
others.

The commit breaks the use case which worked for a long long time.

It also breaks what Marcos proposed for livepatch selftests in 
https://lore.kernel.org/all/20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com/

I guess we can always work around it by letting subsystem selftests to 
override KHDR_DIR but I am not comfortable with the behaviour that your 
commit introduced in the first place to be honest.

Thank you,
Miroslav
