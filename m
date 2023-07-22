Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0975DB4E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGVJYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56642D46
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C4F60C94
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 09:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AEFC433C7;
        Sat, 22 Jul 2023 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690017853;
        bh=A7F1zmUw4KPxRoXFXZ1pO5q/1gFrwvDuZVFBYVGEmXw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XcpBxqhEBeZsE22MmnIwHig0zXtwwyxQj7CLUw5rjbraL+O2OksMlQsPcgAWESJDj
         ufzwQWM2avduDQ8Uo/Bn3Y28mShJRp98o76oHCZyPZbBqVYYxiLsqtEOlQ0JB7T3mW
         HVXkNacF1dWMzFRTLab5FYRvoeBx3CAvqe+KpwBMxfvAEQW4VTRSenJec+xpHIhz2T
         IjSCmNAWrSEkaogfT3FrK7zI8lL/aeBP5rBngQIOt3lZHOTTx62e/MhzUuCxYd9AdW
         HJVoO2ru2XSLJqUUi7Qb8tmsZ5Ko6V2KYMm/ox3joXy0+R5XjHRh718NCyEnF4uZgx
         tvlnaEujfCGzg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in
 BPF JIT
In-Reply-To: <20230720154941.1504-1-puranjay12@gmail.com>
References: <20230720154941.1504-1-puranjay12@gmail.com>
Date:   Sat, 22 Jul 2023 11:24:10 +0200
Message-ID: <87fs5gguyt.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Puranjay Mohan <puranjay12@gmail.com> writes:

> BPF programs currently consume a page each on RISCV. For systems with man=
y BPF
> programs, this adds significant pressure to instruction TLB. High iTLB pr=
essure
> usually causes slow down for the whole system.
>
> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above =
issue.
> It packs multiple BPF programs into a single huge page. It is currently o=
nly
> enabled for the x86_64 BPF JIT.
>
> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed no=
w.
>
> This patch series enables the BPF prog pack allocator for the RISCV BPF J=
IT.
> This series needs a patch[3] from the ARM64 series to work.

Just a heads-up; I'm on vacation for 2 more weeks, so expect a somewhat
late review from my side!

Thank you for working on the RISC-V BPF JIT!


Bj=C3=B6rn
