Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6169783E00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjHVKcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjHVKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:32:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A93BE59;
        Tue, 22 Aug 2023 03:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B191460C78;
        Tue, 22 Aug 2023 10:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E133EC433C7;
        Tue, 22 Aug 2023 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692700321;
        bh=t8rkJevFQ4OOqTerIVYgB4Zt4P94JQD0Ng1gKbsVikA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ZGLPUey3ITbIVd0krjWiQlmcHneP7vH96hkoNhpUvV1PKVs6g7WqSXNAGhpsTJ7GX
         a+ulObOI3Fol7trQvOU4Eo8ZKX1s/OLyVO74O2BghxK1IKFx/F0DEBfWDzrrhjVTKR
         ITiuFourPgs0xV4eyHiKhzDMhMXg7/ha0XaPJF2yZV76pvAHkWbs0LbC/r8Ta02xg7
         wJR6wRjCJkpFiTmanAhVwVCZE7tDGLHSJ0XXcP/jAS6vhLciJBc6iXZjZgljsyYE27
         gXi+aNfqWxqZOO2VC0lmHdnmRaJl9v+VpvWC5wfSsp0OxA15P/EoM9Q1YD6kRm3LlI
         yt1beGV46pRqQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:31:58 +0300
Message-Id: <CUZ06NE7G0YK.8WOBPAD6USMY@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 0/9] selftests/sgx: Fix compilation errors
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 19, 2023 at 12:43 PM EEST, Jo Van Bulck wrote:
> Hi,
>
> This is the third iteration of a patch series to ensure that all SGX self=
tests
> succeed when compiling with optimizations (as tested with -O{0,1,2,3,s} f=
or
> both gcc 11.3.0 and clang 14.0.0). The aim of the patches is to avoid rel=
iance
> on undefined, compiler-specific behavior that can make the test results
> fragile.
>
> If useful, I can also include an elementary wrapper shell script to compi=
le and
> run the tests for different compilers (gcc/clang) and optimization levels=
.
> Reference output below:
>
> .. Testing gcc   -O0    [OK]
> .. Testing gcc   -O1    [OK]
> .. Testing gcc   -O2    [OK]
> .. Testing gcc   -O3    [OK]
> .. Testing gcc   -Os    [OK]
> .. Testing gcc   -Ofast [OK]
> .. Testing gcc   -Og    [OK]
> .. Testing clang -O0    [OK]
> .. Testing clang -O1    [OK]
> .. Testing clang -O2    [OK]
> .. Testing clang -O3    [OK]
> .. Testing clang -Os    [OK]
> .. Testing clang -Ofast [OK]
> .. Testing clang -Og    [OK]
>
> Changelog
> ---------
>
> v3
>   - Refactor encl_op_array declaration and indexing (Jarkko)
>   - Annotate encl_buffer with "used" attribute (Kai)
>   - Split encl_buffer size and placement commits (Kai)
>
> v2
>   - Add additional check for NULL pointer (Kai)
>   - Refine to produce proper static-pie executable
>   - Fix linker script assertions
>   - Specify memory clobber for inline asm instead of volatile (Kai)
>   - Clarify why encl_buffer non-static (Jarkko, Kai)
>   - Clarify -ffreestanding (Jarkko)
>
> Best,
> Jo
>
> Jo Van Bulck (9):
>   selftests/sgx: Fix uninitialized pointer dereference in error path
>   selftests/sgx: Produce static-pie executable for test enclave
>   selftests/sgx: Handle relocations in test enclave
>   selftests/sgx: Fix linker script asserts
>   selftests/sgx: Include memory clobber for inline asm in test enclave
>   selftests/sgx: Ensure test enclave buffer is entirely preserved
>   selftests/sgx: Ensure expected location of test enclave buffer
>   selftests/sgx: Separate linker options
>   selftests/sgx: Specify freestanding environment for enclave
>     compilation
>
>  tools/testing/selftests/sgx/Makefile          | 14 ++--
>  tools/testing/selftests/sgx/defines.h         |  2 +
>  tools/testing/selftests/sgx/sigstruct.c       |  5 +-
>  tools/testing/selftests/sgx/test_encl.c       | 66 ++++++++++++-------
>  tools/testing/selftests/sgx/test_encl.lds     | 10 +--
>  .../selftests/sgx/test_encl_bootstrap.S       | 12 ++--
>  6 files changed, 68 insertions(+), 41 deletions(-)
>
> --=20
> 2.25.1

Looks "almost there" to me. Just had one query about freestanding.

BR, Jarkko
