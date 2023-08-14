Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5C77B8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHNMbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHNMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:31:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCBFCC;
        Mon, 14 Aug 2023 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692016271;
        bh=CfjLGRNDjQ2wfBPrTce9v4Y5ovLDKc2Td8U4k4EEWXw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sHpaqgkpaP54Siurk4UI0Qr+zOKMeBAJyZQOSG5g0/bC/sMMqK8p7uUjzplFp8AVF
         LQZxg8SJhhh8nJp2tRP+WIGyphQtpubxRJU9eVBqfao+nC2lHpernYv9A2eKAF3hAc
         oEhLYUDrbstezKYBk5QD1nfUBS6Ag8bX7DQOMvlLIwO0z2l6V28t9ulOeeLlBc7/08
         1RBk5gyv+ZHCZsq+hkPi/L1Xv6y4GUcVq+8fyVV+p5YhuXJDMcZDmFbJqcp4Af6ssj
         2sc3nmRSolh+F85iyN+ao8hgewfoy0NJ4ZM5MMlY4b5uIB3l/uQu7Sii398N/V9g/1
         wFQkLbj0vNEmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPYfR2WVPz4wb8;
        Mon, 14 Aug 2023 22:31:11 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Justin Stitt <justinstitt@google.com>,
        Geoff Levand <geoff@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] powerpc/ps3: refactor strncpy usage
In-Reply-To: <CAFhGd8oZLTaFNg3pQSi=zX121HPfY9_v-H5e3_+27W3=1fXxmw@mail.gmail.com>
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
 <CAFhGd8oZLTaFNg3pQSi=zX121HPfY9_v-H5e3_+27W3=1fXxmw@mail.gmail.com>
Date:   Mon, 14 Aug 2023 22:31:10 +1000
Message-ID: <87cyzperg1.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> writes:
> On Fri, Aug 11, 2023 at 2:19=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
>>
>> Within this RFC-series I want to get some comments on two ideas that I
>> have for refactoring the current `strncpy` usage in repository.c.
>>
>> When looking at `make_first_field` we see a u64 is being used to store
>> up to 8 bytes from a literal string. This is slightly suspect to me but
>> it works? In regards to `strncpy` here, it makes the code needlessly
>> complex imo.
>>
>> Please see my two ideas to change this and let me know if any other
>> approaches are more reasonable.
>>
>> Link: https://github.com/KSPP/linux/issues/90
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>> ---
>> Justin Stitt (3):
>>       [RFC] powerpc/ps3: refactor strncpy usage attempt 1
>>       [RFC] powerpc/ps3: refactor strncpy usage attempt 2
>>       [RFC] powerpc/ps3: refactor strncpy usage attempt 2.5
> Errhm, It looks like the diffs after attempt 1 came out poorly and
> probably won't apply cleanly because they were inter-diffed with the
> first patch. Is there a way to let b4 know I wanted each patch diff'd
> against the same SHA and not each other sequentially?

I don't think there is. It always assumes they're a series.

cheers
