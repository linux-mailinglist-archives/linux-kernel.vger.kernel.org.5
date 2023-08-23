Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D950786104
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjHWTux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbjHWTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5710CF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 12:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3AD614E1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F4C433C7;
        Wed, 23 Aug 2023 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692820248;
        bh=xUP8Aao2vUba1hN7Bnt0t6crXDnohGolTg985mKMKdQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZuhIPkP4CUsDGiKsOw1+HxLQGXZ3YTAWFNprtH9vVrl5/Qw4zQzzpc7LN2Uhe5P38
         n4sJnMcOKXZ4Dibb3GYiZ3x4yZQ+CeXJAGdmE0Mfn6c4zlb0rDzr776/rHhnqXomT8
         PGx1H4DfgF/ul1OhKJMwWUU5Jbpleqxx5Gaf+hz1aK5uBsEgOtC8jXcv0wB+ML4SyI
         qXmVdf9SyuWd/eEn4r3IRVOdEKtPAFjtomQu/7QpHHxi2trZDJ5eBjXndUBPWy/YBD
         GD1MeLqAXSE5rpWrQuf6M2UjBwScWXM6ITjebQ9eG1Bjdwex2rcUUa2NgU8UNnuDeH
         bTE7/+NhO2eUA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Pu Lehui <pulehui@huaweicloud.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for RV64
In-Reply-To: <CAADnVQLu5twbe_UpiJrD0wKq1YyHzZbfzYhsW-mte7vDmyna5g@mail.gmail.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-8-pulehui@huaweicloud.com>
 <87zg2hk44i.fsf@all.your.base.are.belong.to.us>
 <CAADnVQLu5twbe_UpiJrD0wKq1YyHzZbfzYhsW-mte7vDmyna5g@mail.gmail.com>
Date:   Wed, 23 Aug 2023 21:50:44 +0200
Message-ID: <875y55tu5n.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Aug 23, 2023 at 11:25=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>
>> > From: Pu Lehui <pulehui@huawei.com>
>> >
>> > Enable cpu v4 tests for RV64, and the relevant tests have passed.
>> >
>> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>
>> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> Bjorn,
>
> Thanks a lot for the quick review!
> Could you give it a spin as well and hopefully add Tested-by ?
>
> We still have time to get it into bpf-next for the upcoming merge window.

I'll kick a run! But I'd like a change to mov 8/16b patch (#3) prior
pulling.

> We still have time to get it into bpf-next for the upcoming merge window.

@Lehui Do you have time to cook a v2?


Bj=C3=B6rn
