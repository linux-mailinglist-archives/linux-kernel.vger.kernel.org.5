Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4A7B7EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjJDMHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJDMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:07:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4CBF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:07:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A32C433C7;
        Wed,  4 Oct 2023 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696421238;
        bh=jiwF/a0PTTygMSsmAPMD6cp4z/ZqdiLgziTxoP11oDg=;
        h=From:To:Cc:Subject:Date:From;
        b=rmhaw58iLsxW4Gr3byt0TNlCS8nNUD+lr00+679s8fRwqPTX1BzNVjyUNvRsAqOR6
         fjF0eI4lo/624C8zlX5D3Zn59FXHswT3peYewYJrafb9VvGNGSQmI+REoIsXYnoqyb
         NEhNkcuePwm7Z83wDdogWISAVjyqI4bgwj57rbO4PQtOsDOnPLNNXCa81O53IcqDVm
         fJb0uqHB8PtlbMQL2Au3r6YFBUidKXyOZWANR07KO+HGpK2Q1KkUuPDgNqWOw/MIgg
         S0HnKWDJzv3aau/5AlwR9cOlDztikig1jXfHsQnZQlQDFNG0vS62lp7hiYxTCQEgLa
         afMFOSqkw86jw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, linux-riscv@lists.infradead.org
Subject: [PATCH bpf 0/2] riscv, bpf: Properly sign-extend return values
Date:   Wed,  4 Oct 2023 14:07:04 +0200
Message-Id: <20231004120706.52848-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V architecture does not expose sub-registers, and hold all
32-bit values in a sign-extended format [1] [2]:

  | The compiler and calling convention maintain an invariant that all
  | 32-bit values are held in a sign-extended format in 64-bit
  | registers. Even 32-bit unsigned integers extend bit 31 into bits
  | 63 through 32. Consequently, conversion between unsigned and
  | signed 32-bit integers is a no-op, as is conversion from a signed
  | 32-bit integer to a signed 64-bit integer.

While BPF, on the other hand, exposes sub-registers, and use
zero-extension (similar to arm64/x86).

This has led to some subtle bugs, where a BPF JITted program has not
sign-extended the a0 register (return value in RISC-V land), passed
the return value up the kernel, e.g.:
    
  | int from_bpf(void);
  |
  | long foo(void)
  | {
  |    return from_bpf();
  | }

This series fixes this issue by keeping a pair of return value
registers; a0 (RISC-V ABI, sign-extended), a5 (BPF, zero-extended).

The following test_progs now pass, which were previously broken:

  | 13      bpf_cookie
  | 19      bpf_mod_race
  | 68      deny_namespace
  | 119     libbpf_get_fd_by_id_opts
  | 135     lookup_key
  | 137     lsm_cgroup
  | 284     test_lsm


Björn


Björn Töpel (2):
  riscv, bpf: Sign-extend return values
  riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values

 arch/riscv/net/bpf_jit_comp64.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)


base-commit: 9077fc228f09c9f975c498c55f5d2e882cd0da59
-- 
2.39.2

