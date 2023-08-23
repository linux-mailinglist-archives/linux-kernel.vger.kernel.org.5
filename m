Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7A785E97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjHWRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbjHWRbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1D10CE;
        Wed, 23 Aug 2023 10:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C053641C9;
        Wed, 23 Aug 2023 17:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED32C433C7;
        Wed, 23 Aug 2023 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692811895;
        bh=vy1HguPEhdDUNYEeFhIUoKkEhkwru59pROu+eclhmqU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=PRVUUlAk3Qzo8MLIccC6M3oygpY6WpCwC0TgZeTH/Zkmf+bBT0vZL54eaYYNuKrU5
         zSA8hnbkIsAc70J6dEGqUHiKfbWJWpUbNN/iFI2k+P0rQ3ugYexePJykkDCxW3Tx+v
         jh+kvywvVnF+MKQV0GTbb+D0qtp45refjMft+WOheg0ZhqidPWCt9WFac39KE2ILnX
         1AdpGEMMuLmFcKHWMog+s4a9+/FV4LoekZOsEqdNo4PqumyYGkVIyQRWopQ3CS7zVN
         qt2OggpSL8vyGObtckB9qM5xNREFa1LjvTBhOtB/rQq860FZwulOBD69l2seQkWnGe
         z2NuLlVjK2KsA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 23 Aug 2023 20:31:32 +0300
Message-Id: <CV03QFOJR0PY.8QYY51SMOAO2@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 9/9] selftests/sgx: Specify freestanding environment
 for enclave compilation
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-10-jo.vanbulck@cs.kuleuven.be>
 <CUYZSZWSDUHC.2QB1Z9GD76HF6@suppilovahvero>
 <819a5450-127b-ecd2-ac01-c58e848fba1d@cs.kuleuven.be>
In-Reply-To: <819a5450-127b-ecd2-ac01-c58e848fba1d@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 23, 2023 at 3:57 PM EEST, Jo Van Bulck wrote:
> On 22.08.23 12:14, Jarkko Sakkinen wrote:
> > Do you still need nostdfiles and nostartfiles with freestanding?
>
> Thanks, good question. I tested that compiling with only -ffreestanding=
=20
> yields:
>
> /* snipped */
> /usr/local/bin/ld:=20
> /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/rcrt1.o: in=20
> function `_start':
> (.text+0x24): undefined reference to `main'
> /* snipped */
>
> So we definitely still need -nostartfiles to prevent the compiler/linker=
=20
> from introducing the standard system startup functions. However, in my=20
> understanding, -nostdlib (which is what I assume you mean with=20
> nostdfiles) already implies the individual options -nodefaultlibs and=20
> -nostartfiles.
>
> Thus, we definitely still need -nostartfiles and I'm not 100% sure we=20
> don't need -nostdlib (though it compiles fine for me with only=20
> -nostartfiles). Gcc only specifies:
>
> -ffreestanding
> Assert that compilation targets a freestanding environment.  This=20
> implies -fno-builtin. A freestanding environment is one in which the=20
> standard library may not exist, and program startup may not necessarily=
=20
> be at "main".
>
> Bottom line: I suggest to keep -nostdlib to be sure and remove=20
> -nostartfiles (as it is redundant). I'll include this in the next  patch=
=20
> iteration.
>
> Best,
> Jo

OK, cool, sounds like plan.

BR, Jarkko
