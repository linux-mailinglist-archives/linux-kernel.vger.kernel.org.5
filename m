Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8BF80734C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442317AbjLFPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379092AbjLFPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:05:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E89A;
        Wed,  6 Dec 2023 07:05:31 -0800 (PST)
Received: from pobox.suse.cz (unknown [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD63A21E79;
        Wed,  6 Dec 2023 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701875129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fstuDZ14CDhTICiRMQLamJBK2hLQCM7gMcsouHhAvwM=;
        b=hOL1GB2JqM+RxoEgucs2Mtl+ULTAf1pQwKnnG9598uf6Zfr42KnHp9WO3RNYqrYXMHcTOU
        8EzJNJsA5uZBa0EdcEgvGDuAIlSJNypjZHq7zlrLJ/BiQb0zYLj9gEtYPqlSPsbNdZB+DZ
        yjtvbpV3rJ6WUCreof6tVEwsSxTWRwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701875129;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fstuDZ14CDhTICiRMQLamJBK2hLQCM7gMcsouHhAvwM=;
        b=3gIZ75ZflKLKWgKzYBM1YF9Y48YEi9Zx9CWqFeq6zUvczbTdDW86IyTxLNSD3RgAcvK2IN
        GzAvFvWXGguoJfDw==
Date:   Wed, 6 Dec 2023 16:05:30 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
In-Reply-To: <ZWn7dEzVWoKxycmy@redhat.com>
Message-ID: <alpine.LSU.2.21.2312061543280.13051@pobox.suse.cz>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com> <20231031-send-lp-kselftests-v3-2-2b1655c2605f@suse.com> <ZWn7dEzVWoKxycmy@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.26
X-Spamd-Result: default: False [-3.26 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_MATCH_FROMTLD(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.16)[-0.816];
         RCPT_COUNT_TWELVE(0.00)[17];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[99.99%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023, Joe Lawrence wrote:

> On Tue, Oct 31, 2023 at 06:10:52PM -0300, Marcos Paulo de Souza wrote:
> > The modules are being moved from lib/livepatch to
> > tools/testing/selftests/livepatch/test_modules.
> > 
> > This code moving will allow writing more complex tests, like for example an
> > userspace C code that will call a livepatched kernel function.
> > 
> > The modules are now built as out-of-tree
> > modules, but being part of the kernel source means they will be maintained.
> > 
> > Another advantage of the code moving is to be able to easily change,
> > debug and rebuild the tests by running make on the selftests/livepatch directory,
> > which is not currently possible since the modules on lib/livepatch are
> > build and installed using the "modules" target.
> > 
> > The current approach also keeps the ability to execute the tests manually by
> > executing the scripts inside selftests/livepatch directory, as it's currently
> > supported. If the modules are modified, they needed to be rebuilt before running
> > the scripts though.
> > 
> > The modules are built before running the selftests when using the
> > kselftest invocations:
> > 
> > 	make kselftest TARGETS=livepatch
> > or
> > 	make -C tools/testing/selftests/livepatch run_tests
> > 
> 
> Quick question:
> 
> - We have been building with CONFIG_LIVEPATCH_TEST=m to generate the
>   test modules at kernel build time
> 
> - Our packaging filters out the selftest scripts and supporting modules
>   from the general kernel RPM package into their subpackages
> 
> - Tests are run as part of CKI or other manual tests by installing the
>   pre-built packages from the previous step
> 
> 
> After this patch, we would need to add something like the following to
> our kernel build, before packaging:
> 
>   $ make KDIR=$(pwd) -C tools/testing/selftests/livepatch/
>          ^^^^
> 
> If this is the correct way to build the test modules for *this* tree and
> /lib/modules/$(shell uname -r)/build... it might be useful to document
> in the commit message as an alternative use case.

So if I understand it correctly, you would like to stick to pre-building 
the modules (not in-tree but now after the kernel is build using the 
proposed way), package them and then install everything on a system 
running the respective kernel. A valid use case in my opinion.

My idea is to abandon this way completely, take the selftests and build 
and run them on the system right away.

Both should be doable, hopefully, if we wire it all correctly... and 
document it.

Miroslav


