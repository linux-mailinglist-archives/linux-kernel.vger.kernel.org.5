Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78F77A124
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjHLQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHLQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:44:44 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D710D0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:44:45 -0700 (PDT)
Date:   Sat, 12 Aug 2023 16:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1691858683; x=1692117883;
        bh=bTzoFxrlHH2cDQUfoco5sqOK11g/mVuswhnPAsuj0oQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=AZ3N9Y/W5RIhHwGLCvse6MWN59N03msJseYBuHcW63piDR+ebPzOe3Cs4WcOLaImg
         T2jnz1WtNEKnHIXbY5JuV/tjvhSSAzn+uPlMPevvBxLAmyjt+yabI9rDHJEM1it8gV
         87Rrjh3TWSSaA1ySxCBGG6cN0OJ4hSDFJGZQ15+z2TuIzkN5oEJ6QC3Nr69ROt0sed
         IV0Gh3v0JyNkVW2bYrB8KmCU7nlLnYwIRZP7qo2Vti1sp8O+N/MqPiBzWpDx6wdjat
         JuHWIMHrxhnSUKiFO1cmXzUcmUFmuZ/ZrzEw3dMtVhfJiYwZiARxH2UeppLVMnDHRK
         XyZIRiiQcF/Lw==
To:     Masahiro Yamada <masahiroy@kernel.org>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: merge_config: Add flag to prevent unsetting config option
Message-ID: <871qg8cirv.fsf@protonmail.com>
In-Reply-To: <CAK7LNAS2XKRisvMkB+dw3ZnExYuy9U8xB9BXnXy2FvqZWrRk-g@mail.gmail.com>
References: <20230729214138.79902-1-sergeantsagara@protonmail.com> <CAK7LNAR_Egr+G9_HmGfrmFAEQ0Tznmbff0w9cJ=1biV5P4PmNQ@mail.gmail.com> <875y5rsd6c.fsf@protonmail.com> <CAK7LNAS2XKRisvMkB+dw3ZnExYuy9U8xB9BXnXy2FvqZWrRk-g@mail.gmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Aug, 2023 04:04:37 +0900 "Masahiro Yamada" <masahiroy@kernel.org=
> wrote:
> On Mon, Aug 7, 2023 at 1:13=E2=80=AFPM Rahul Rameshbabu
> <sergeantsagara@protonmail.com> wrote:
>>
>>
>> On Sun, 06 Aug, 2023 23:19:55 +0900 "Masahiro Yamada" <masahiroy@kernel.=
org> wrote:
>> > On Sun, Jul 30, 2023 at 6:42=E2=80=AFAM Rahul Rameshbabu
>> > <sergeantsagara@protonmail.com> wrote:
>> >>
>> >> Overriding a previously defined entry for a config option with 'is no=
t set'
>> >> may be undesirable in some fragment configuration setups.
>> >
>> > Then, you should remove the 'is not set' entry from the fragment.
>>
>> I had a feeling that was the expectation. Just for reference, my flow
>> for generating fragments looks like the following.
>>
>>   1. make allnoconfig
>>   2. make menuconfig   # select the options that I desire for the fragme=
nt
>
>
> Sorry, I could not understand
> how these steps generate a fragment file.
>
> You will get a full .config file
> after 'make menuconfig'.

Yep, this is right. I am not really generating a fragment this way but
rather full configs with minimal options that I end up wanting to merge
together. What's your process for generating fragments you need? Just
dumping the options you want in fragment files and letting make properly
select the dependencies?

>
>
>
>
>
>> We can drop this patch if this is the expected developer flow. I
>> realized that overriding with 'is not set' entries in a fragment is
>> likely desirable, so I made this behavior change as part of a flag that
>> can be set by the user.
>>
>> --
>> Thanks,
>>
>> Rahul Rameshbabu
>>


--
Thanks,

Rahul Rameshbabu

