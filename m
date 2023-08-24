Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F429786A99
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjHXIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjHXIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F61991
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C27C66692
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D557C433C8;
        Thu, 24 Aug 2023 08:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692866801;
        bh=XDddRmzIKkYqEuz8kl983GzVIYWy/vD+zwVKZEhKP2k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DQ7dli6mYgIhSksQ3KibQRXYJ9ICqwsGFeJe2NhE9giEOlOOs8nk+Rjqwpab0o724
         0givHuxrlp7/G1s60bvbTttOd7Ln9/sO3WMZD3nbplYfTtzlm+zMZOWinbDJCagSfU
         tSEydsO9k/rNJo4xj5s+pgV2tLJjRTSFoVrY6/IUCx411VreqwPJva/pe536Dm+nzb
         v1eVRespUfgvAxddCmTda7TWCjXOesS+/cZzR+OTBGrGWcDRrfm7fGUB4laGwYX9qD
         VQDoLRr7fmVARSWOWXS7t6g7j7k0WGMGLjRppI26LGuH5rfLDzGq48CcBrkI1wykzi
         7yAMsI5mtgV8Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
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
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 0/7] Add support cpu v4 insns for RV64
In-Reply-To: <20230824095001.3408573-1-pulehui@huaweicloud.com>
References: <20230824095001.3408573-1-pulehui@huaweicloud.com>
Date:   Thu, 24 Aug 2023 10:46:38 +0200
Message-ID: <87r0nshlox.fsf@all.your.base.are.belong.to.us>
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

Pu Lehui <pulehui@huaweicloud.com> writes:

> Add support cpu v4 instructions for RV64. The relevant tests have passed =
as show bellow:
>
> # ./test_progs-cpuv4 -a ldsx_insn,verifier_sdiv,verifier_movsx,verifier_l=
dsx,verifier_gotol,verifier_bswap

[...]

> Summary: 6/166 PASSED, 0 SKIPPED, 0 FAILED
>
> NOTE: ldsx_insn testcase uses fentry and needs to rely on ftrace direct c=
all [0].
> [0] https://lore.kernel.org/all/20230627111612.761164-1-suagrfillet@gmail=
.com/
>
> v2:
> - Use temporary reg to avoid clobbering the source reg in movs_8/16 insns=
. (Bj=C3=B6rn)
> - Add Acked-by

Thanks for getting the cpuv4 RISC-V support out so quickly!

For the series:
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
