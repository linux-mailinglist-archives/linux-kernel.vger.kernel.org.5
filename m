Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76BB809DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573385AbjLHIG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573364AbjLHIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:06:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924501720;
        Fri,  8 Dec 2023 00:06:31 -0800 (PST)
Received: from pobox.suse.cz (unknown [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD49322132;
        Fri,  8 Dec 2023 08:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702022789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALVNWxPwFjvkc8k9VJ00CfPBD03Zhd6OwJyUcqfFfZw=;
        b=OgAwToEi9qRQ81Nbr+dUaE3OssJkOCDpsl8aNgKYzgPU05VA2spDsKu+1vrnNGRcDSODxj
        CV5C86Xn6+WlykbM4fQXiS8uJP4EhLHgjcLO7hLWwppflcG8ZZPxjM8WmW/Ovd6QC/u4Z2
        5ieeupze36HMj7INPypy2aQ0jv3itYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702022789;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALVNWxPwFjvkc8k9VJ00CfPBD03Zhd6OwJyUcqfFfZw=;
        b=9ejqWHIhjdcWNavQ0rt86JqlNtnwaAFa7Vx+QSAj50MRpGTEl8tK2iUi5J6ulZhSxD+9VN
        ALOnvXz698heDRAQ==
Date:   Fri, 8 Dec 2023 09:06:30 +0100 (CET)
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
In-Reply-To: <273a86d6-d220-fdcf-3c2f-70516c519ff9@redhat.com>
Message-ID: <alpine.LSU.2.21.2312080854100.14729@pobox.suse.cz>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com> <20231031-send-lp-kselftests-v3-2-2b1655c2605f@suse.com> <ZWn7dEzVWoKxycmy@redhat.com> <alpine.LSU.2.21.2312061543280.13051@pobox.suse.cz>
 <273a86d6-d220-fdcf-3c2f-70516c519ff9@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.58
X-Spamd-Result: default: False [0.58 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(1.68)[0.559];
         MID_RHS_MATCH_FROMTLD(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[17];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.00)[16.41%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > My idea is to abandon this way completely, take the selftests and build 
> > and run them on the system right away.
> > 
> > Both should be doable, hopefully, if we wire it all correctly... and 
> > document it.
> > 
> I can't think of why it shouldn't continue to work, even in a future
> where newer livepatching selftests support older kernels.  (We would
> just have newer selftests sources backported to test older kernel sources.)
> 
> Are there any test cases which truly need to be build on-the-fly?  Aside
> from testing different toolchain pieces?

https://github.com/SUSE/qa_test_klp is what we would like to migrate to 
selftests to have just one place for all tests.

There is basically just one live patch template and one supporting kernel 
module template which is livepatched. The final result is driven by a set 
of macros and function parameters. In some cases more modules are compiled 
as parts of a test in a loop.

However, I do not think there is anything which truly needs to be built 
on-the-fly in the end. Everything can be worked around. Templates may be 
abandoned and we would have a live patch and a module(s) per test. Some 
tests are probably not worth it and may be removed. So it is a question of 
convenience and maintainability. When we, for example, simplified API and 
klp_register_patch() was removed, only one place needed to be amended. 
Also, the current state in lib/livepatch/ could be simplified with the 
proposed infrastructure as some files could be merged together.

Miroslav
