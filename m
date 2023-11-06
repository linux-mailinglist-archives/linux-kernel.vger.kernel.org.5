Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA207E2CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjKFT0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:26:47 -0500
Received: from domac.alu.hr (unknown [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92DFA;
        Mon,  6 Nov 2023 11:26:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5A7F760171;
        Mon,  6 Nov 2023 20:26:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699298799; bh=t8EZ2rnhPwd4D4mYaXsE7KlwujfdLTH6+jvI9zR1TWY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dYG2V7bS8i/gjP61eLCxQ3lHviLnSlj1kZfBRVNTe3kQ4PEvoKK4d0ATyYECrJcFQ
         cKEoB4dB6yL+qOa9/3pSpY+xVFZi1NwBGsA3mbu0+Oz3t56iP9JotM+VMVnNvZgf9v
         xzXZbZE4gKLFsQeW8gn7Z3Bz/MLncAF5XLyajUIntYKjPfpMxmEVNpvOXQ5LK1xz0k
         S5SKS+XTG3ZhqpgtsWyaXPKQL4352v0yKaIqoeKC4uKsLyXKwk7IQ4izABxudw5MK4
         gC4Cv42JvUzaCNbYL4Sl/kaX249bIpX6js97uKIg+H6ybAcZy3lYTN3je7HNYuaSGV
         T2qZmEFsRfPmw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZFzkyIb4R5my; Mon,  6 Nov 2023 20:26:36 +0100 (CET)
Received: from [192.168.1.6] (78-2-88-169.adsl.net.t-com.hr [78.2.88.169])
        by domac.alu.hr (Postfix) with ESMTPSA id AC0A86016E;
        Mon,  6 Nov 2023 20:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699298796; bh=t8EZ2rnhPwd4D4mYaXsE7KlwujfdLTH6+jvI9zR1TWY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mpJ3kyMNO1ihAc2m9Ug4V7lVQcW+3NUV9altqmPSqGdp5W4kS9XasBqCe5moXY2E6
         6XoUps174nFMItI0pQwprfimZD6MJlRHHqaT9GJf+4l3zrKCoAd+JOwJmtc0ik+WXs
         KL3w2GTKqEP8jBF5+1/idPKMLpQZPn5t8ANh30KD7j/6QyOfP4D0qtdcvWDZ69qajf
         v2+NAJUKDH2Hq/jfXT9pCguRbe/CbUyGgWEgNHcQilBp4OUPXwR6O07G/QtRyRg/+k
         mX6hR7Q2K87VXD7Cf1yU0vBuxzBWE1U6BJBiFNohTFaZnpuqhRnocpLbGVsAzD+8yy
         EUa0WjCtaMbnQ==
Message-ID: <4fb3a356-7639-4622-81be-0a1ba91588e9@alu.unizg.hr>
Date:   Mon, 6 Nov 2023 20:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] Coalesce mac ocp write/modify calls to
 reduce spinlock contention
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
 <da4409f3-d509-413b-8433-f222acbbb1be@gmail.com>
 <edee64f4-442d-4670-a91b-e5b83117dd40@alu.unizg.hr>
 <344fc5c2-4447-4481-843f-9d7720e55a77@lunn.ch>
 <b9573c0e-3cdb-4444-b8f2-579aa699b2e1@alu.unizg.hr>
 <7f0e29b4-a34d-4e38-bba3-b179d0484942@lunn.ch>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <7f0e29b4-a34d-4e38-bba3-b179d0484942@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/23 21:36, Andrew Lunn wrote:
>> The command used for generating the assembly was taken from .o.cmd file and
>> added -save-temps as the only change:
> 
> make drivers/net/ethernet/realtek/r8169_main.lst
> 
> is simpler. You get the C and the generated assembler listed together.
> 
>     Andrew

Here, Sir:

----------------------------------------------------------------------------------------------
0000000000001950 <r8168_mac_ocp_write>:
{
     1950:       e8 00 00 00 00          call   1955 <r8168_mac_ocp_write+0x5>
                         1951: R_X86_64_PLT32    __fentry__-0x4
     1955:       55                      push   %rbp
     1956:       48 89 e5                mov    %rsp,%rbp
     1959:       41 57                   push   %r15
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     195b:       4c 8d bf 24 1a 00 00    lea    0x1a24(%rdi),%r15
{
     1962:       41 56                   push   %r14
     1964:       41 89 d6                mov    %edx,%r14d
     1967:       41 55                   push   %r13
     1969:       41 54                   push   %r12
     196b:       49 89 fc                mov    %rdi,%r12
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     196e:       4c 89 ff                mov    %r15,%rdi
{
     1971:       53                      push   %rbx
     1972:       89 f3                   mov    %esi,%ebx
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     1974:       e8 00 00 00 00          call   1979 <r8168_mac_ocp_write+0x29>
                         1975: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
         if (rtl_ocp_reg_failure(reg))
     1979:       89 df                   mov    %ebx,%edi
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     197b:       49 89 c5                mov    %rax,%r13
         if (rtl_ocp_reg_failure(reg))
     197e:       e8 1d f2 ff ff          call   ba0 <rtl_ocp_reg_failure>
     1983:       84 c0                   test   %al,%al
     1985:       75 16                   jne    199d <r8168_mac_ocp_write+0x4d>
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     1987:       c1 e3 0f                shl    $0xf,%ebx
     198a:       49 8b 04 24             mov    (%r12),%rax
     198e:       44 09 f3                or     %r14d,%ebx
     1991:       81 cb 00 00 00 80       or     $0x80000000,%ebx
build_mmio_write(writel, "l", unsigned int, "r", :"memory")
     1997:       89 98 b0 00 00 00       mov    %ebx,0xb0(%rax)
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     199d:       4c 89 ee                mov    %r13,%rsi
     19a0:       4c 89 ff                mov    %r15,%rdi
     19a3:       e8 00 00 00 00          call   19a8 <r8168_mac_ocp_write+0x58>
                         19a4: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
----------------------------------------------------------------------------------------------

Actually, this time rtl_hw_start_8411_2() has r8169_mac_ocp_write mostly() inlined
without an explicit "inline".

I cannot explain why the r8169_main.s looked different with the same .config.

----------------------------------------------------------------------------------------------
0000000000008370 <rtl_hw_start_8411_2>:
{
     8370:       e8 00 00 00 00          call   8375 <rtl_hw_start_8411_2+0x5>
                         8371: R_X86_64_PLT32    __fentry__-0x4
     8375:       55                      push   %rbp
     8376:       48 89 e5                mov    %rsp,%rbp
     8379:       41 56                   push   %r14
     837b:       41 55                   push   %r13
     837d:       49 89 fd                mov    %rdi,%r13
     8380:       41 54                   push   %r12
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     8382:       4d 8d a5 24 1a 00 00    lea    0x1a24(%r13),%r12
         rtl_hw_start_8168g(tp);
     8389:       e8 02 c7 ff ff          call   4a90 <rtl_hw_start_8168g>
         rtl_ephy_init(tp, e_info_8411_2);
     838e:       ba 0a 00 00 00          mov    $0xa,%edx
     8393:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi
                         8396: R_X86_64_32S      .rodata+0x440
     839a:       4c 89 ef                mov    %r13,%rdi
     839d:       e8 be 9d ff ff          call   2160 <__rtl_ephy_init>
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     83a2:       4c 89 e7                mov    %r12,%rdi
     83a5:       e8 00 00 00 00          call   83aa <rtl_hw_start_8411_2+0x3a>
                         83a6: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     83aa:       ba 00 00 14 fe          mov    $0xfe140000,%edx
     83af:       48 89 c6                mov    %rax,%rsi
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     83b2:       49 8b 45 00             mov    0x0(%r13),%rax
     83b6:       89 90 b0 00 00 00       mov    %edx,0xb0(%rax)
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     83bc:       4c 89 e7                mov    %r12,%rdi
     83bf:       e8 00 00 00 00          call   83c4 <rtl_hw_start_8411_2+0x54>
                         83c0: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     83c4:       4c 89 e7                mov    %r12,%rdi
     83c7:       e8 00 00 00 00          call   83cc <rtl_hw_start_8411_2+0x5c>
                         83c8: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     83cc:       ba 00 00 15 fe          mov    $0xfe150000,%edx
     83d1:       48 89 c6                mov    %rax,%rsi
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     83d4:       49 8b 45 00             mov    0x0(%r13),%rax
     83d8:       89 90 b0 00 00 00       mov    %edx,0xb0(%rax)
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     83de:       4c 89 e7                mov    %r12,%rdi
     83e1:       e8 00 00 00 00          call   83e6 <rtl_hw_start_8411_2+0x76>
                         83e2: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
     83e6:       31 d2                   xor    %edx,%edx
     83e8:       be 2c fc 00 00          mov    $0xfc2c,%esi
     83ed:       4c 89 ef                mov    %r13,%rdi
     83f0:       e8 5b 95 ff ff          call   1950 <r8168_mac_ocp_write>
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     83f5:       4c 89 e7                mov    %r12,%rdi
     83f8:       e8 00 00 00 00          call   83fd <rtl_hw_start_8411_2+0x8d>
                         83f9: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     83fd:       ba 00 00 17 fe          mov    $0xfe170000,%edx
     8402:       48 89 c6                mov    %rax,%rsi
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     8405:       49 8b 45 00             mov    0x0(%r13),%rax
     8409:       89 90 b0 00 00 00       mov    %edx,0xb0(%rax)
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     840f:       4c 89 e7                mov    %r12,%rdi
     8412:       e8 00 00 00 00          call   8417 <rtl_hw_start_8411_2+0xa7>
                         8413: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     8417:       4c 89 e7                mov    %r12,%rdi
     841a:       e8 00 00 00 00          call   841f <rtl_hw_start_8411_2+0xaf>
                         841b: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     841f:       ba 00 00 18 fe          mov    $0xfe180000,%edx
     8424:       48 89 c6                mov    %rax,%rsi
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     8427:       49 8b 45 00             mov    0x0(%r13),%rax
     842b:       89 90 b0 00 00 00       mov    %edx,0xb0(%rax)
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     8431:       4c 89 e7                mov    %r12,%rdi
     8434:       e8 00 00 00 00          call   8439 <rtl_hw_start_8411_2+0xc9>
                         8435: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     8439:       4c 89 e7                mov    %r12,%rdi
     843c:       e8 00 00 00 00          call   8441 <rtl_hw_start_8411_2+0xd1>
                         843d: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     8441:       ba 00 00 19 fe          mov    $0xfe190000,%edx
     8446:       48 89 c6                mov    %rax,%rsi
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     8449:       49 8b 45 00             mov    0x0(%r13),%rax
     844d:       89 90 b0 00 00 00       mov    %edx,0xb0(%rax)
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     8453:       4c 89 e7                mov    %r12,%rdi
     8456:       e8 00 00 00 00          call   845b <rtl_hw_start_8411_2+0xeb>
                         8457: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     845b:       4c 89 e7                mov    %r12,%rdi
     845e:       e8 00 00 00 00          call   8463 <rtl_hw_start_8411_2+0xf3>
                         845f: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     8463:       ba 00 00 1a fe          mov    $0xfe1a0000,%edx
     8468:       48 89 c6                mov    %rax,%rsi
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     846b:       49 8b 45 00             mov    0x0(%r13),%rax
     846f:       89 90 b0 00 00 00       mov    %edx,0xb0(%rax)
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     8475:       4c 89 e7                mov    %r12,%rdi
     8478:       e8 00 00 00 00          call   847d <rtl_hw_start_8411_2+0x10d>
                         8479: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
     847d:       31 d2                   xor    %edx,%edx
     847f:       be 36 fc 00 00          mov    $0xfc36,%esi
     8484:       4c 89 ef                mov    %r13,%rdi
     8487:       e8 c4 94 ff ff          call   1950 <r8168_mac_ocp_write>
         mdelay(3);
----------------------------------------------------------------------------------------------


With the patch applied, and an explicit "inline" on:

static inline bool rtl_ocp_reg_failure(u32 reg);
static inline void __r8168_mac_ocp_write_seqlen(struct rtl8169_private *tp, ...);
static inline void r8168_mac_ocp_write_seqlen(struct rtl8169_private *tp, ...);

the code looks like:

----------------------------------------------------------------------------------------------
0000000000004d60 <rtl_hw_start_8411_2>:
{
     4d60:       e8 00 00 00 00          call   4d65 <rtl_hw_start_8411_2+0x5>
                         4d61: R_X86_64_PLT32    __fentry__-0x4
     4d65:       55                      push   %rbp
     4d66:       48 89 e5                mov    %rsp,%rbp
     4d69:       41 57                   push   %r15
     4d6b:       41 56                   push   %r14
         for (p = array; len--; p++)
     4d6d:       49 c7 c6 00 00 00 00    mov    $0x0,%r14
                         4d70: R_X86_64_32S      .rodata+0x820
{
     4d74:       41 55                   push   %r13
     4d76:       41 54                   push   %r12
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     4d78:       41 bc 28 fc 00 00       mov    $0xfc28,%r12d
{
     4d7e:       53                      push   %rbx
     4d7f:       48 89 fb                mov    %rdi,%rbx
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     4d82:       4c 8d ab 24 1a 00 00    lea    0x1a24(%rbx),%r13
{
     4d89:       48 83 ec 08             sub    $0x8,%rsp
         rtl_hw_start_8168g(tp);
     4d8d:       e8 3e fe ff ff          call   4bd0 <rtl_hw_start_8168g>
         rtl_ephy_init(tp, e_info_8411_2);
     4d92:       ba 0a 00 00 00          mov    $0xa,%edx
     4d97:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi
                         4d9a: R_X86_64_32S      .rodata+0x860
     4d9e:       48 89 df                mov    %rbx,%rdi
     4da1:       e8 fa d4 ff ff          call   22a0 <__rtl_ephy_init>
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     4da6:       4c 89 ef                mov    %r13,%rdi
     4da9:       e8 00 00 00 00          call   4dae <rtl_hw_start_8411_2+0x4e>
                         4daa: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     4dae:       31 c9                   xor    %ecx,%ecx
     4db0:       49 89 c7                mov    %rax,%r15
         for (p = array; len--; p++)
     4db3:       eb 07                   jmp    4dbc <rtl_hw_start_8411_2+0x5c>
                 __r8168_mac_ocp_write(tp, p->reg, p->data);
     4db5:       41 8b 4e 04             mov    0x4(%r14),%ecx
     4db9:       45 8b 26                mov    (%r14),%r12d
         return WARN_ONCE(reg & 0xffff0001, "Invalid ocp reg %x!\n", reg);
     4dbc:       41 f7 c4 01 00 ff ff    test   $0xffff0001,%r12d
     4dc3:       0f 85 9b 01 00 00       jne    4f64 <rtl_hw_start_8411_2+0x204>
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     4dc9:       41 c1 e4 0f             shl    $0xf,%r12d
     4dcd:       48 8b 03                mov    (%rbx),%rax
     4dd0:       41 09 cc                or     %ecx,%r12d
     4dd3:       41 81 cc 00 00 00 80    or     $0x80000000,%r12d
build_mmio_write(writel, "l", unsigned int, "r", :"memory")
     4dda:       44 89 a0 b0 00 00 00    mov    %r12d,0xb0(%rax)
         for (p = array; len--; p++)
     4de1:       49 83 c6 08             add    $0x8,%r14
     4de5:       49 81 fe 00 00 00 00    cmp    $0x0,%r14
                         4de8: R_X86_64_32S      .rodata+0x860
     4dec:       75 c7                   jne    4db5 <rtl_hw_start_8411_2+0x55>
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     4dee:       4c 89 fe                mov    %r15,%rsi
     4df1:       4c 89 ef                mov    %r13,%rdi
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     4df4:       41 bc 00 f8 00 00       mov    $0xf800,%r12d
         for (p = array; len--; p++)
     4dfa:       49 c7 c6 00 00 00 00    mov    $0x0,%r14
                         4dfd: R_X86_64_32S      .rodata+0x4a0
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     4e01:       e8 00 00 00 00          call   4e06 <rtl_hw_start_8411_2+0xa6>
                         4e02: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         mdelay(3);
     4e06:       bf 08 9c c4 00          mov    $0xc49c08,%edi
     4e0b:       e8 00 00 00 00          call   4e10 <rtl_hw_start_8411_2+0xb0>
                         4e0c: R_X86_64_PLT32    __const_udelay-0x4
         r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
     4e10:       31 d2                   xor    %edx,%edx
     4e12:       be 26 fc 00 00          mov    $0xfc26,%esi
     4e17:       48 89 df                mov    %rbx,%rdi
     4e1a:       e8 71 d0 ff ff          call   1e90 <r8168_mac_ocp_write>
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     4e1f:       4c 89 ef                mov    %r13,%rdi
     4e22:       e8 00 00 00 00          call   4e27 <rtl_hw_start_8411_2+0xc7>
                         4e23: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     4e27:       b9 08 e0 00 00          mov    $0xe008,%ecx
     4e2c:       49 89 c7                mov    %rax,%r15
         for (p = array; len--; p++)
     4e2f:       eb 07                   jmp    4e38 <rtl_hw_start_8411_2+0xd8>
                 __r8168_mac_ocp_write(tp, p->reg, p->data);
     4e31:       41 8b 4e 04             mov    0x4(%r14),%ecx
     4e35:       45 8b 26                mov    (%r14),%r12d
         return WARN_ONCE(reg & 0xffff0001, "Invalid ocp reg %x!\n", reg);
     4e38:       41 f7 c4 01 00 ff ff    test   $0xffff0001,%r12d
     4e3f:       0f 85 eb 00 00 00       jne    4f30 <rtl_hw_start_8411_2+0x1d0>
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     4e45:       41 c1 e4 0f             shl    $0xf,%r12d
     4e49:       48 8b 03                mov    (%rbx),%rax
     4e4c:       41 09 cc                or     %ecx,%r12d
     4e4f:       41 81 cc 00 00 00 80    or     $0x80000000,%r12d
     4e56:       44 89 a0 b0 00 00 00    mov    %r12d,0xb0(%rax)
         for (p = array; len--; p++)
     4e5d:       49 83 c6 08             add    $0x8,%r14
     4e61:       49 81 fe 00 00 00 00    cmp    $0x0,%r14
                         4e64: R_X86_64_32S      .rodata+0x818
     4e68:       75 c7                   jne    4e31 <rtl_hw_start_8411_2+0xd1>
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     4e6a:       4c 89 fe                mov    %r15,%rsi
     4e6d:       4c 89 ef                mov    %r13,%rdi
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     4e70:       41 bc 2a fc 00 00       mov    $0xfc2a,%r12d
         for (p = array; len--; p++)
     4e76:       49 c7 c6 00 00 00 00    mov    $0x0,%r14
                         4e79: R_X86_64_32S      .rodata+0x460
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     4e7d:       e8 00 00 00 00          call   4e82 <rtl_hw_start_8411_2+0x122>
                         4e7e: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
         r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
     4e82:       ba 00 80 00 00          mov    $0x8000,%edx
     4e87:       be 26 fc 00 00          mov    $0xfc26,%esi
     4e8c:       48 89 df                mov    %rbx,%rdi
     4e8f:       e8 fc cf ff ff          call   1e90 <r8168_mac_ocp_write>
         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
     4e94:       4c 89 ef                mov    %r13,%rdi
     4e97:       e8 00 00 00 00          call   4e9c <rtl_hw_start_8411_2+0x13c>
                         4e98: R_X86_64_PLT32    _raw_spin_lock_irqsave-0x4
     4e9c:       b9 43 07 00 00          mov    $0x743,%ecx
     4ea1:       49 89 c7                mov    %rax,%r15
         for (p = array; len--; p++)
     4ea4:       eb 07                   jmp    4ead <rtl_hw_start_8411_2+0x14d>
                 __r8168_mac_ocp_write(tp, p->reg, p->data);
     4ea6:       41 8b 4e 04             mov    0x4(%r14),%ecx
     4eaa:       45 8b 26                mov    (%r14),%r12d
         return WARN_ONCE(reg & 0xffff0001, "Invalid ocp reg %x!\n", reg);
     4ead:       41 f7 c4 01 00 ff ff    test   $0xffff0001,%r12d
     4eb4:       75 4d                   jne    4f03 <rtl_hw_start_8411_2+0x1a3>
         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
     4eb6:       41 c1 e4 0f             shl    $0xf,%r12d
     4eba:       48 8b 03                mov    (%rbx),%rax
     4ebd:       41 09 cc                or     %ecx,%r12d
     4ec0:       41 81 cc 00 00 00 80    or     $0x80000000,%r12d
     4ec7:       44 89 a0 b0 00 00 00    mov    %r12d,0xb0(%rax)
         for (p = array; len--; p++)
     4ece:       49 83 c6 08             add    $0x8,%r14
     4ed2:       49 81 fe 00 00 00 00    cmp    $0x0,%r14
                         4ed5: R_X86_64_32S      .rodata+0x498
     4ed9:       75 cb                   jne    4ea6 <rtl_hw_start_8411_2+0x146>
         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
     4edb:       4c 89 fe                mov    %r15,%rsi
     4ede:       4c 89 ef                mov    %r13,%rdi
     4ee1:       e8 00 00 00 00          call   4ee6 <rtl_hw_start_8411_2+0x186>
                         4ee2: R_X86_64_PLT32    _raw_spin_unlock_irqrestore-0x4
}
     4ee6:       48 83 c4 08             add    $0x8,%rsp
     4eea:       5b                      pop    %rbx
     4eeb:       41 5c                   pop    %r12
     4eed:       41 5d                   pop    %r13
     4eef:       41 5e                   pop    %r14
     4ef1:       41 5f                   pop    %r15
     4ef3:       5d                      pop    %rbp
     4ef4:       31 c0                   xor    %eax,%eax
     4ef6:       31 d2                   xor    %edx,%edx
     4ef8:       31 c9                   xor    %ecx,%ecx
     4efa:       31 f6                   xor    %esi,%esi
     4efc:       31 ff                   xor    %edi,%edi
     4efe:       e9 00 00 00 00          jmp    4f03 <rtl_hw_start_8411_2+0x1a3>
                         4eff: R_X86_64_PLT32    __x86_return_thunk-0x4
         return WARN_ONCE(reg & 0xffff0001, "Invalid ocp reg %x!\n", reg);
     4f03:       0f b6 05 00 00 00 00    movzbl 0x0(%rip),%eax        # 4f0a <rtl_hw_start_8411_2+0x1aa>
                         4f06: R_X86_64_PC32     .data.once-0x2
     4f0a:       3c 01                   cmp    $0x1,%al
     4f0c:       0f 87 00 00 00 00       ja     4f12 <rtl_hw_start_8411_2+0x1b2>
                         4f0e: R_X86_64_PC32     .text.unlikely+0xd0
     4f12:       a8 01                   test   $0x1,%al
     4f14:       75 b8                   jne    4ece <rtl_hw_start_8411_2+0x16e>
     4f16:       44 89 e6                mov    %r12d,%esi
     4f19:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                         4f1c: R_X86_64_32S      .rodata.str1.1+0x53
     4f20:       c6 05 00 00 00 00 01    movb   $0x1,0x0(%rip)        # 4f27 <rtl_hw_start_8411_2+0x1c7>
                         4f22: R_X86_64_PC32     .data.once-0x3
     4f27:       e8 00 00 00 00          call   4f2c <rtl_hw_start_8411_2+0x1cc>
                         4f28: R_X86_64_PLT32    __warn_printk-0x4
     4f2c:       0f 0b                   ud2
     4f2e:       eb 9e                   jmp    4ece <rtl_hw_start_8411_2+0x16e>
     4f30:       0f b6 05 00 00 00 00    movzbl 0x0(%rip),%eax        # 4f37 <rtl_hw_start_8411_2+0x1d7>
                         4f33: R_X86_64_PC32     .data.once-0x2
     4f37:       3c 01                   cmp    $0x1,%al
     4f39:       0f 87 00 00 00 00       ja     4f3f <rtl_hw_start_8411_2+0x1df>
                         4f3b: R_X86_64_PC32     .text.unlikely+0x106
     4f3f:       a8 01                   test   $0x1,%al
     4f41:       0f 85 16 ff ff ff       jne    4e5d <rtl_hw_start_8411_2+0xfd>
     4f47:       44 89 e6                mov    %r12d,%esi
     4f4a:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                         4f4d: R_X86_64_32S      .rodata.str1.1+0x53
     4f51:       c6 05 00 00 00 00 01    movb   $0x1,0x0(%rip)        # 4f58 <rtl_hw_start_8411_2+0x1f8>
                         4f53: R_X86_64_PC32     .data.once-0x3
     4f58:       e8 00 00 00 00          call   4f5d <rtl_hw_start_8411_2+0x1fd>
                         4f59: R_X86_64_PLT32    __warn_printk-0x4
     4f5d:       0f 0b                   ud2
     4f5f:       e9 f9 fe ff ff          jmp    4e5d <rtl_hw_start_8411_2+0xfd>
     4f64:       0f b6 05 00 00 00 00    movzbl 0x0(%rip),%eax        # 4f6b <rtl_hw_start_8411_2+0x20b>
                         4f67: R_X86_64_PC32     .data.once-0x2
     4f6b:       3c 01                   cmp    $0x1,%al
     4f6d:       0f 87 00 00 00 00       ja     4f73 <rtl_hw_start_8411_2+0x213>
                         4f6f: R_X86_64_PC32     .text.unlikely+0xeb
     4f73:       a8 01                   test   $0x1,%al
     4f75:       0f 85 66 fe ff ff       jne    4de1 <rtl_hw_start_8411_2+0x81>
     4f7b:       44 89 e6                mov    %r12d,%esi
     4f7e:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                         4f81: R_X86_64_32S      .rodata.str1.1+0x53
     4f85:       c6 05 00 00 00 00 01    movb   $0x1,0x0(%rip)        # 4f8c <rtl_hw_start_8411_2+0x22c>
                         4f87: R_X86_64_PC32     .data.once-0x3
     4f8c:       e8 00 00 00 00          call   4f91 <rtl_hw_start_8411_2+0x231>
                         4f8d: R_X86_64_PLT32    __warn_printk-0x4
     4f91:       0f 0b                   ud2
     4f93:       e9 49 fe ff ff          jmp    4de1 <rtl_hw_start_8411_2+0x81>
     4f98:       0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
     4f9f:       00
     4fa0:       90                      nop
     4fa1:       90                      nop
     4fa2:       90                      nop
     4fa3:       90                      nop
     4fa4:       90                      nop
     4fa5:       90                      nop
     4fa6:       90                      nop
     4fa7:       90                      nop
     4fa8:       90                      nop
     4fa9:       90                      nop
     4faa:       90                      nop
     4fab:       90                      nop
     4fac:       90                      nop
     4fad:       90                      nop
     4fae:       90                      nop
     4faf:       90                      nop
----------------------------------------------------------------------------------------------

Best regards,
Mirsad Todorovac

