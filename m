Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2B78BC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjH2B6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjH2B5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:57:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8051418B;
        Mon, 28 Aug 2023 18:57:35 -0700 (PDT)
X-QQ-mid: bizesmtp71t1693274211tjl8wicz
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 29 Aug 2023 09:56:48 +0800 (CST)
X-QQ-SSF: 01200000000000001000000A0000000
X-QQ-FEAT: 7jw2iSiCazqI7U4uceorTTx0096PogHcGE52Ti7rBOKg4E61hjgGGFvoFvrik
        CZc8rNK4FQdIHnYnZnqFywrsoV2A1294l+rtabAX+1vj+r6vgTjBroPtQlgxPFpcWgsUEml
        MxX9XHnWeHAA+nrXmdfPvWjVAnKw236Ddi9w39LiVIdiEkX7xHe7w2n1FW3S8WpuAh9bLc0
        LpKkLU4pJh//tp8PMwpN0rJfEE78br6ZsYerxcypWK7NQ5+HSNJjFgzwBx5bvaQMHwWfbfF
        R36QqVbXNz2oJvpf9OuRdNEmQ4/RoBLgOITnagkA6u39a7hJ1E6enXuMJwd1EeaooOOmlRo
        ql1Q4gxxcDeMOagSu3qAyNS7WjxkJSaKVpHsecNOl3KiwvReMI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5466448991023989807
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     jszhang@kernel.org
Cc:     adrian.hunter@intel.com, aou@eecs.berkeley.edu,
        conor+dt@kernel.org, conor@kernel.org, devicetree@vger.kernel.org,
        dfustini@baylibre.com, guoren@kernel.org, jkridner@beagleboard.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        robertcnelson@beagleboard.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, wangjiexun@tinylab.org, wefu@redhat.com
Subject: Re: [PATCH RFC v2 0/4] RISC-V: Add basic eMMC support for BeagleV Ahead
Date:   Tue, 29 Aug 2023 09:56:47 +0800
Message-Id: <20230829015647.115757-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZOy3v+YgZgU1NrWx@xhacker>
References: <ZOy3v+YgZgU1NrWx@xhacker>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Mon, 28 Aug 2023 23:05:35 +0800, Jisheng Zhang wrote:
>On Mon, Aug 28, 2023 at 12:40:16PM +0800, Jiexun Wang wrote:
>> Hello,
>> I tested the patch on my LicheePi 4A board.
>> It can successfully boot with eMMC, but when I use the eMMC more frequently - for instance:
>> 
>> $ while true; do /bin/dd if=/dev/zero of=bigfile bs=1024000 count=1024; done &
>> 
>> I encounter the following error:
>> 
>> sbi_trap_error: hart1: illegal instruction handler failed (error -2)
>
>> sbi_trap_error: hart1: mcause=0x0000000000000002 mtval=0x0000000060e2de4f
>> sbi_trap_error: hart1: mepc=0x000000000001897c mstatus=0x0000000a00001820
>> sbi_trap_error: hart1: ra=0x00000000000170f8 sp=0x000000000004adc8
>> sbi_trap_error: hart1: gp=0xffffffff8136ea90 tp=0xffffffd900228000
>> sbi_trap_error: hart1: s0=0x0000000000000000 s1=0x000000000004ae08
>> sbi_trap_error: hart1: a0=0x000000003f9aa9bc a1=0x0000000000000004
>> sbi_trap_error: hart1: a2=0x0000000000000000 a3=0x0000000000000000
>> sbi_trap_error: hart1: a4=0x0000000000042248 a5=0x00000000000170e5
>> sbi_trap_error: hart1: a6=0x0000000000000000 a7=0x0000000054494d45
>> sbi_trap_error: hart1: s2=0x000000000004aee8 s3=0x0000000000000000
>> sbi_trap_error: hart1: s4=0x000000000004ae08 s5=0x0000000000000000
>> sbi_trap_error: hart1: s6=0xffffffff813aa240 s7=0x0000000000000080
>> sbi_trap_error: hart1: s8=0xffffffff80a1b5f0 s9=0x0000000000000000
>> sbi_trap_error: hart1: s10=0xffffffd9fef5d380 s11=0xffffffff81290a80
>> sbi_trap_error: hart1: t0=0x0000000a00000820 t1=0x0000000000000000
>> sbi_trap_error: hart1: t2=0xffffffff80c00318 t3=0x0000000000000001
>> sbi_trap_error: hart1: t4=0x0000000000000330 t5=0x0000000000000001
>> sbi_trap_error: hart1: t6=0x0000000000040000
>> 
>> My kernel version is v6.5-rc3.
>> My OpenSBI version is 1.3.
>> I tried to use other versions of OpenSBI, yet the problem persists. 
>> Is there a possibility of any underlying bug? Your insights into this would be greatly appreciated.
>
>
>Can you plz try below opensbi?

I tried the OpenSBI you provided and the issue didn't recur.
I conducted stress test about 30 minutes and the system appears to be functioning very well.
Thank you so much for helping me resolve this problem.

Best regards,
Jiexun Wang

