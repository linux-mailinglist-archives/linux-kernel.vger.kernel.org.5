Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5BA7CEFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjJSF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjJSF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:57:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FE0D73
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:56:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97A2C433C7;
        Thu, 19 Oct 2023 05:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697695014;
        bh=uwIr5PLksnwLyxgqpvtx+QliRJtVX8iY9+2hAVOlS40=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Smj2XLAMaNBJ1/8/b0GDTW7Kox2CgBUOvlYD9PNeDgRBrWEmUCmfnRlP0oWmsR808
         08jm9ZKZUsbpARNM8oqluOYrjMFym4ezH8hzYoonUL0pc5bu8JWNdiogCMVuez5p7n
         0ENO7X9EDvNG7DkUGBce8+SzhBnmUiAmKALM6AGCI37CZTJJYQEWaJ0YY5y1zuXAWK
         HwWHZU8/x+39fDDSQy1cWs8iy5H0mM+AKle6dcGnMB6G9rHMgnPUoH34l/ymfxeFXq
         jzE4Vp6zgTmY4n9IsfO3MDrdoJ6HcN8idM2l6swOcRnXFT8Jlzlpp7SZMfTPtYRRYF
         5eKVn0U6y5prQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Conor Dooley <conor@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 0/2] riscv: Add remaining module relocations and tests
In-Reply-To: <20231018-confidant-frostily-e8f4dbdcd478@spud>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
 <20231018-smite-bungee-f46b15b4ce6f@spud> <ZTAWcX1qVhkC71BJ@ghost>
 <20231018-confidant-frostily-e8f4dbdcd478@spud>
Date:   Thu, 19 Oct 2023 07:56:51 +0200
Message-ID: <87y1fzxiho.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

> On Wed, Oct 18, 2023 at 10:31:29AM -0700, Charlie Jenkins wrote:
>> On Wed, Oct 18, 2023 at 12:35:55PM +0100, Conor Dooley wrote:
>> > Hey Charlie,
>> >=20
>> > On Tue, Oct 17, 2023 at 10:34:15PM -0700, Charlie Jenkins wrote:
>> > > A handful of module relocations were missing, this patch includes the
>> > > remaining ones. I also wrote some test cases to ensure that module
>> > > loading works properly. Some relocations cannot be supported in the
>> > > kernel, these include the ones that rely on thread local storage and
>> > > dynamic linking.
>> > >=20
>> > > ULEB128 handling is a bit special because SET and SUB relocations mu=
st
>> > > happen together, and SET must happen before SUB. A psABI proposal [1]
>> > > mandates that the first SET_ULEB128 that appears before a SUB_ULEB128
>> > > is the associated SET_ULEB128.
>> > >=20
>> > > This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, a=
nd
>> > > RISCV_MODULE_LINKING_KUNIT.
>> > >=20
>> > > [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/403
>> > >=20
>> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> > > ---
>> > > Changes in v4:
>> > > - Complete removal of R_RISCV_RVC_LUI
>> > > - Fix bug in R_RISCV_SUB6 linking
>> > > - Only build ULEB128 tests if supported by toolchain
>> > > - Link to v3: https://lore.kernel.org/r/20231016-module_relocations-=
v3-0-a667fd6071e9@rivosinc.com
>> >=20
>> > On patch 2/2:
>> >=20
>> > ../arch/riscv/kernel/tests/module_test/test_uleb128.S:18:17: error: un=
known relocation name
>> > ../arch/riscv/kernel/tests/module_test/test_uleb128.S:19:17: error: un=
known relocation name
>> >=20
>> > Same toolchain configuration in the patchwork automation as before.
>> >=20
>> > Cheers,
>> > Conor.
>>=20
>> Where do you see this error? On Patchwork I see a success [1].
>>=20
>> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20231017-modu=
le_relocations-v4-2-937f5ef316f0@rivosinc.com/
>
> It was a failure this morning!
> See
> <https://github.com/linux-riscv/linux-riscv/actions/runs/6549280771/job/1=
7785844013>
>
> I wonder if there is something wrong with the CI code, where it
> erroneously reports the state from previous patches and then runs the
> tests again with the new patches and re-pushes the results.
>
> Bjorn, any idea?

The PW syncher tries to reuse the Github PR branch for newer versions.
Say that v4 has some set of results, and v5 some set of results. Then,
it'll be a bit of flux until v5 is fully built.

Hmm, I'll try to improve that. The PW v4 should never get results from
PW v5...

FWIW, the v5 of the series
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D794521 has
a bunch of errors.


Bj=C3=B6rn
