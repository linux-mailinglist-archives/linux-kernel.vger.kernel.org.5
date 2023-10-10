Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415567BFAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjJJMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjJJMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:12:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65994;
        Tue, 10 Oct 2023 05:12:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D317BC433C7;
        Tue, 10 Oct 2023 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939922;
        bh=2cpo158e2dohOh/JDmxhWwMUWOjqXgzWNqXCxYsXd6Y=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=LN6cBXrPPaqFiu8NESjJnpdprW8vYMQUC36ENibodthQwf+1k+zAxuufdOxW8cmJW
         MA/9PUWjv7nKGr1qcu8gkEPosVrNT4XaB8Cow9mcIavD3pIHSBcPV7qQ6j3j2me3zD
         iZjiDVaM8Ai8vR3CINSj7X6ncQCRy/eMyu0jeY5677qrs9etX5XQnkmhgyFrEewboo
         n3VqZMiRXKq5HX2eB3aTNeCGwr9mD7SWo4KE4xEEom5ptL/jKD6KmTHNG7Fu9v690/
         jc3K/zLHGXhAozq3HeBY1fgY6u7HOr6XiGf62M6qoXLLeCu0Ld9no3dpBwzC/O03+C
         1hmcvXgzfCqhQ==
Message-ID: <4124e803b340fc23e74fc5afe1343b1a7940c82f.camel@kernel.org>
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Oct 2023 15:11:58 +0300
In-Reply-To: <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
         <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
         <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
         <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, since there was already sort of talk about detaching this
code from kernel tree so that Jo could work on "pure C" runtime
would it make sense to dual-license this first in the kernel tree?

E.g. Jo could send a patch once this is merged with a new SPDX
platter and we can then ack that?

Just a proposal, with the emphasis on minimal amount of work
required from each party. Also this would help with possible
(and likely) bug fixes, i.e. minimal friction on fixing the same
bug.

Later on of course, we can consider adding "libsgx-dev" as depedency
similarly as today there's a few dependencies like libelf-dev.

I'm open for alternative proposals, just throwing something that
came up mind.

BR, Jarkko

On Tue, 2023-10-10 at 12:44 +0300, Jarkko Sakkinen wrote:
> Folks (sorry for top posting): I've now taken my old NUC7 out of the
> dust and tested the series :-)
>=20
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> Off-topic: I wish both Intel and AMD straighten up and deliver some=C2=A0
> "home friendly" development hardware for the=C2=A0 latest stuff. Just my
> stance but the biggest quality risk I see in both TDX and SNP is that
> the patches are made by an enterprise and reviewed (properly) *only*
> by other huge enterprises.
>=20
> I skim status of both from time to time but yeah not much attachment
> or motivation to do more than that as you either need a cloud access
> or partnership with Intel or AMD. "Indie" style seems to be disliked
> these days... You can extrapolate from this that there must be a bunch
> of maintainers around the Linux kernel that feel the same. Not saying
> that particularly my contribution would be that important.
>=20
> Sort of even if let's say Intel would provide me a partner access I
> might not be that interested because I prefer my own (physical)
> computers.
>=20
> BR, Jarkko
>=20
> On Fri, 2023-10-06 at 11:51 +0200, Jo Van Bulck wrote:
> > Thank you, Kai! I'm not familiar with any next steps to get this merged=
=20
> > upstream, but atm all commits in this series have been reviewed by at=
=20
> > least Jarkko. Let me know if anything further is needed from my side!
> >=20
> > Best,
> > Jo
> >=20
> > On 05.10.23 23:25, Huang, Kai wrote:
> > > Hi Jo,
> > >=20
> > > Just FYI I won't review the rest patches in this series.=C2=A0 One of=
 the reasons is
> > > I am not that familiar with the rest.=C2=A0 Jarkko has reviewed anywa=
y :-).
> > >=20
> > > On Thu, 2023-10-05 at 17:38 +0200, Jo Van Bulck wrote:
> > > > Hi,
> > > >=20
> > > > This patch series ensures that all SGX selftests succeed when compi=
ling with
> > > > optimizations (as tested with -O{0,1,2,3,s} for both gcc 11.3.0 and=
 clang
> > > > 14.0.0). The aim of the patches is to avoid reliance on undefined,
> > > > compiler-specific behavior that can make the test results fragile.
> > > >=20
> > > > As far as I see, all commits in this series now have an explicit re=
viewed-by
> > > > tag, so hopefully this can get merged upstream? Please let me know =
if any
> > > > concerns remain and I'd happily address them.
> > > >=20
> > > > Reference output below:
> > > >=20
> > > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O0=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O1=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O2=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O3=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -Os=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -Ofast [OK]
> > > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -Og=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 clang -O0=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 clang -O1=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 clang -O2=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 clang -O3=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 clang -Os=C2=A0=C2=A0=C2=A0 [OK]
> > > > .. Testing=C2=A0=C2=A0 clang -Ofast [OK]
> > > > .. Testing=C2=A0=C2=A0 clang -Og=C2=A0=C2=A0=C2=A0 [OK]
> > > >=20
> > > > Changelog
> > > > ---------
> > > >=20
> > > > v7
> > > > =C2=A0=C2=A0 - Add reviewed-by tag (Jarkko)
> > > >=20
> > > > v6
> > > > =C2=A0=C2=A0 - Collect final ack/reviewed-by tags (Jarkko, Kai)
> > > >=20
> > > > v5
> > > > =C2=A0=C2=A0 - Reorder patches (Jarkko, Kai)
> > > > =C2=A0=C2=A0 - Include fixes tag for inline asm memory clobber patc=
h (Kai)
> > > > =C2=A0=C2=A0 - Include linker error in static-pie commit message (K=
ai)
> > > > =C2=A0=C2=A0 - Include generated assembly in relocations commit (Ka=
i)
> > > >=20
> > > > v4
> > > > =C2=A0=C2=A0 - Remove redundant -nostartfiles compiler flag (Jarkko=
)
> > > > =C2=A0=C2=A0 - Split dynamic symbol table removal in separate commi=
t (Kai)
> > > > =C2=A0=C2=A0 - Split redundant push/pop elimination in separate com=
mit (Kai)
> > > > =C2=A0=C2=A0 - Remove (incomplete) register cleansing on enclave ex=
it
> > > > =C2=A0=C2=A0 - Fix possibly uninitialized pointer dereferences in l=
oad.c
> > > >=20
> > > > v3
> > > > =C2=A0=C2=A0 - Refactor encl_op_array declaration and indexing (Jar=
kko)
> > > > =C2=A0=C2=A0 - Annotate encl_buffer with "used" attribute (Kai)
> > > > =C2=A0=C2=A0 - Split encl_buffer size and placement commits (Kai)
> > > >=20
> > > > v2
> > > > =C2=A0=C2=A0 - Add additional check for NULL pointer (Kai)
> > > > =C2=A0=C2=A0 - Refine to produce proper static-pie executable
> > > > =C2=A0=C2=A0 - Fix linker script assertions
> > > > =C2=A0=C2=A0 - Specify memory clobber for inline asm instead of vol=
atile (Kai)
> > > > =C2=A0=C2=A0 - Clarify why encl_buffer non-static (Jarkko, Kai)
> > > > =C2=A0=C2=A0 - Clarify -ffreestanding (Jarkko)
> > > >=20
> > > > Best,
> > > > Jo
> > > >=20
> > > > Jo Van Bulck (13):
> > > > =C2=A0=C2=A0 selftests/sgx: Fix uninitialized pointer dereference i=
n error path
> > > > =C2=A0=C2=A0 selftests/sgx: Fix uninitialized pointer dereferences =
in
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 encl_get_entry
> > > > =C2=A0=C2=A0 selftests/sgx: Include memory clobber for inline asm i=
n test enclave
> > > > =C2=A0=C2=A0 selftests/sgx: Separate linker options
> > > > =C2=A0=C2=A0 selftests/sgx: Specify freestanding environment for en=
clave
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 compilation
> > > > =C2=A0=C2=A0 selftests/sgx: Remove redundant enclave base address s=
ave/restore
> > > > =C2=A0=C2=A0 selftests/sgx: Produce static-pie executable for test =
enclave
> > > > =C2=A0=C2=A0 selftests/sgx: Handle relocations in test enclave
> > > > =C2=A0=C2=A0 selftests/sgx: Fix linker script asserts
> > > > =C2=A0=C2=A0 selftests/sgx: Ensure test enclave buffer is entirely =
preserved
> > > > =C2=A0=C2=A0 selftests/sgx: Ensure expected location of test enclav=
e buffer
> > > > =C2=A0=C2=A0 selftests/sgx: Discard unsupported ELF sections
> > > > =C2=A0=C2=A0 selftests/sgx: Remove incomplete ABI sanitization code=
 in test enclave
> > > >=20
> > > > =C2=A0 tools/testing/selftests/sgx/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++--
> > > > =C2=A0 tools/testing/selftests/sgx/defines.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> > > > =C2=A0 tools/testing/selftests/sgx/load.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++-
> > > > =C2=A0 tools/testing/selftests/sgx/sigstruct.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 5 +-
> > > > =C2=A0 tools/testing/selftests/sgx/test_encl.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 67 +++++++++++++------
> > > > =C2=A0 tools/testing/selftests/sgx/test_encl.lds=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 +--
> > > > =C2=A0 .../selftests/sgx/test_encl_bootstrap.S=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 28 +++-----
> > > > =C2=A0 7 files changed, 77 insertions(+), 56 deletions(-)
> > > >=20
> > >=20
>=20

