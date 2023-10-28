Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC197DA69C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjJ1K7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1K7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:59:44 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C6B8;
        Sat, 28 Oct 2023 03:59:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7A38960174;
        Sat, 28 Oct 2023 12:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698490775; bh=s2nEr6eUKVY+twc2vVLrmN4tDIBaIHU/ylDTAbwKZEc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=elEDU2anY1AEC37lwFDoZ1jR09xP8VxFSqFHGq1oVPUOfcr7+C6xil1qAsjqR4vSS
         Wl6K0N424h2LePE1nEOzu6PLG4vvg+2oinpTOgHKg9psTuPDMqf+y+YG0xLglwzcqI
         pr+5mXx0B8b+K67jvS9PIN6rM7MnLMTnlMXisWgmXg+8FGpk+Pu+CchgSO4v/G2AQH
         PwbkiO9jEGfu5M7h6+9DlmAOoC9F2QPK14cuJwrSOQ4ikzR/bXgoq2u/JKOR31yqMM
         C2531ZjB2Vun109T4RrCD55WKa7JVJulBu9cY04q3lGFDGdOMDzoD0XoGDhU1YfCCA
         aWLXCAujxRU/w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B5bGEJiipb7o; Sat, 28 Oct 2023 12:59:31 +0200 (CEST)
Received: from [192.168.1.6] (78-3-40-253.adsl.net.t-com.hr [78.3.40.253])
        by domac.alu.hr (Postfix) with ESMTPSA id D215E60173;
        Sat, 28 Oct 2023 12:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698490771; bh=s2nEr6eUKVY+twc2vVLrmN4tDIBaIHU/ylDTAbwKZEc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WTsi2NwfYPvOF04K7F1iC1mZn9H4VmBWDIU2LiFCBvXjbK0Dwscl/ddtAFxBCSjBf
         NbvbKeyZcqsRREXZKru7v5vCqfd0MZl8oxNf7P4h1cFoyUgLNun1d0Kv7cTYsuUkHb
         2KTDConyi0Jkot7KWCNc7y08mwLNjcATQLo93JtjM8NUHPLyiwVsK5wVC6ffhHOASF
         h6ivXcXrdbxkRCmf7Q4MrftX7AqHBCD+jnVrUeloIXPlKG0tciV/rSvpbhKwiYSKOz
         6juTcitvEYCbHxzE/hAyzXtlakAucq3WCMwwGX9yE0MiPAsmp5QPOT598htmyqs6+U
         T33G9A0UvlZaA==
Message-ID: <b1387ae2-3a9d-45f7-802b-d9121f5de12c@alu.unizg.hr>
Date:   Sat, 28 Oct 2023 12:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] r8169: Coalesce RTL8411b PHY power-down
 recovery programming instructions to reduce spinlock stalls (v2)
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr>
 <8d9a15ac-5d95-4267-bbf2-5820d0a71a4e@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <8d9a15ac-5d95-4267-bbf2-5820d0a71a4e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 09:50, Heiner Kallweit wrote:
> On 28.10.2023 02:51, Mirsad Goran Todorovac wrote:
>> On RTL8411b the RX unit gets confused if the PHY is powered-down.
>> This was reported in [0] and confirmed by Realtek. Realtek provided
>> a sequence to fix the RX unit after PHY wakeup.
>>
> v1 and 1/1 aren't needed. And that it's v2 you don't have to add
> to the patch title.
> 
>> A series of about 130 r8168_mac_ocp_write() calls is performed to
>> program the RTL registers for recovery.
>>
>> Each call looks like this:
>>
>>          static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>>          {
>>                  if (rtl_ocp_reg_failure(reg))
>>                          return;
>>
>>                  RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>>          }
>>
>>          static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>>          {
>>                  unsigned long flags;
>>
>>                  raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>                  __r8168_mac_ocp_write(tp, reg, data);
>>                  raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>          }
>>
>> Register programming is done through RTL_W32() macro which expands into
>>
>>          #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
>>
>> which is further:
>>
>>          extern inline void writel(u32 b, volatile void __iomem *addr)
>>          {
>>                  mb();
>>                  __raw_writel(b, addr);
>>          }
>>
>> mb() expands into this on x86_64:
>>
>>          #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
>>
>> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
>> memory barrier, writel(), and spin_unlock_irqrestore().
>>
>> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
>> a lock storm that will stall all of the cores and CPUs on the same memory controller
>> for certain time I/O takes to finish.

Hi, Heiner,

> Do you have a system with this NIC version and/or are you aware of any
> actual issue?

No, actually I have a r8215b. I came to this conclusion by the visual inspection
and what is exposed in the books:

[1] Paul McKenney, https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html
[2] https://docs.kernel.org/core-api/wrappers/memory-barriers.html

(I don't think I completed reading the referenced texts.)

By visual inspection of the code I that spin_lock_irqsave() evaluates to eventually
locking a lock through an atomic CHPXCHG  r/m(8|16|32|64), r(8|16|32|64) instruction:

[3] https://www.felixcloutier.com/x86/cmpxchg

To explain this better, let's go to the Source:

1) spin_lock_irqsave() ends up calling:

static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
{
	unsigned long flags;

	local_irq_save(flags);
	preempt_disable();
	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
	return flags;
}

local_irq_save() -> arch_local_irq_save() ->

static __always_inline unsigned long arch_local_irq_save(void)
{
	unsigned long flags = arch_local_save_flags();
	arch_local_irq_disable();
	return flags;
}

arch_local_save_flags() -> native_save_fl() ->

extern __always_inline unsigned long native_save_fl(void)
{
	unsigned long flags;

	/*
	 * "=rm" is safe here, because "pop" adjusts the stack before
	 * it evaluates its effective address -- this is part of the
	 * documented behavior of the "pop" instruction.
	 */
	asm volatile("# __raw_save_flags\n\t"
		     "pushf ; pop %0"
		     : "=rm" (flags)
		     : /* no input */
		     : "memory");

	return flags;
}

or "pushf; popq %rax" on CONFIG_X86_64.

arch_local_irq_disable() -> native_irq_disable() -> asm volatile("cli": : :"memory");

1b) "spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);" expands to

lock_acquire_exclusive(l, s, t, NULL, i)
then lock_acquire(l, s, t, 0, 1, n, i) which in the source does a call to

void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
			  int trylock, int read, int check,
			  struct lockdep_map *nest_lock, unsigned long ip)
{
	unisgned long flags;

	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);

	if (!debug_locks)
		return;
	...
}

Are you still with me?

1c) So, the trick must be in the

      LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);

evaluates to:

      static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock)
      {
	__acquire(lock);
	arch_spin_lock(&lock->raw_lock);
	mmiowb_spin_lock();
      }

arch_spin_lock() -> queued_spin_lock() which is

      static __always_inline void queued_spin_lock(struct qspinlock *lock)
      {
	int val = 0;

	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
		return;

	queued_spin_lock_slowpath(lock, val);
     }

This calls atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL) which is
evaluated to:

     static __always_inline bool
     atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
     {
	instrument_atomic_read_write(v, sizeof(*v));
	instrument_atomic_read_write(old, sizeof(*old));
	return raw_atomic_try_cmpxchg_acquire(v, old, new);
     }

and raw_atomic_try_cmpxchg_acquire(v, old, new) indeed calls

     arch_atomic_try_cmpxchg_acquire(v, old, new);
  
eventually calling

     #define arch_cmpxchg(ptr, old, new)					\
	__cmpxchg(ptr, old, new, sizeof(*(ptr)))

     #define __cmpxchg(ptr, old, new, size)					\
	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)

this __raw_cmpxchg() evaluates to:

/*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
#define __raw_cmpxchg(ptr, old, new, size, lock)			\
({									\
	__typeof__(*(ptr)) __ret;					\
	__typeof__(*(ptr)) __old = (old);				\
	__typeof__(*(ptr)) __new = (new);				\
	switch (size) {							\
	case __X86_CASE_B:						\
	{								\
		volatile u8 *__ptr = (volatile u8 *)(ptr);		\
		asm volatile(lock "cmpxchgb %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "q" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	case __X86_CASE_W:						\
	{								\
		volatile u16 *__ptr = (volatile u16 *)(ptr);		\
		asm volatile(lock "cmpxchgw %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "r" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	case __X86_CASE_L:						\
	{								\
		volatile u32 *__ptr = (volatile u32 *)(ptr);		\
		asm volatile(lock "cmpxchgl %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "r" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	case __X86_CASE_Q:						\
	{								\
		volatile u64 *__ptr = (volatile u64 *)(ptr);		\
		asm volatile(lock "cmpxchgq %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "r" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	default:							\
		__cmpxchg_wrong_size();					\
	}								\
	__ret;								\
})

Without quoting the entire Source ;-) we can see that there is always some
LOCK prefix involved in atomic testing of the spinlock contention.

CONCLUSION:

spin_lock_irqsave() roughly compiles as:

	"pushf ; pop %0" : "=rm" : : "memory"
	"cli": : : "memory"
	lock "cmpxchgq %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "r" (__new), "0" (__old)			\
			     : "memory"

The order is not preserved, as it would be too tedious.

In the worst case, we decrease the number of spin_lock_irqsave()/spin_lock_irqrestore()
pairs.

>> In a sequential case of RTL register programming, the writes to RTL registers
>> can be coalesced under a same raw spinlock. This can dramatically decrease the
>> number of bus stalls in a multicore or multi-CPU system:
>>
>>          static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>>                                                const struct recover_8411b_info *array)
>>          {
>>                  struct recover_8411b_info const *p = array;
>>
>>                  while (p->reg) {
>>                          if (!rtl_ocp_reg_failure(p->reg))
>>                                  RTL_W32(tp, OCPDR, OCPAR_FLAG | (p->reg << 15) | p->data);
>>                          p++;
>>                  }
>>          }
>>
>>          static void r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>>                                              const struct recover_8411b_info *array)
>>          {
>>                  unsigned long flags;
>>
>>                  raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>                  __r8168_mac_ocp_write_seq(tp, array);
>>                  raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>          }
>>
>>          static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>          {
>>
>>                  ...
>>
>>                  /* The following Realtek-provided magic fixes an issue with the RX unit
>>                   * getting confused after the PHY having been powered-down.
>>                   */
>>
>>                  static const struct recover_8411b_info init_zero_seq[] = {
>>                          { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
>>                          { 0xFC30, 0x0000 }, { 0xFC32, 0x0000 }, { 0xFC34, 0x0000 }, { 0xFC36, 0x0000 },
>>                          { 0x0000, 0x0000 },
>>                  };
>>
>>                  static const struct recover_8411b_info recover_seq[] = {
>>                          { 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
>>                          { 0xF808, 0xE027 }, { 0xF80A, 0xE04F }, { 0xF80C, 0xE05E }, { 0xF80E, 0xE065 },
>>                          { 0xF810, 0xC602 }, { 0xF812, 0xBE00 }, { 0xF814, 0x0000 }, { 0xF816, 0xC502 },
>>                          { 0xF818, 0xBD00 }, { 0xF81A, 0x074C }, { 0xF81C, 0xC302 }, { 0xF81E, 0xBB00 },
>>                          { 0xF820, 0x080A }, { 0xF822, 0x6420 }, { 0xF824, 0x48C2 }, { 0xF826, 0x8C20 },
>>                          { 0xF828, 0xC516 }, { 0xF82A, 0x64A4 }, { 0xF82C, 0x49C0 }, { 0xF82E, 0xF009 },
>>                          { 0xF830, 0x74A2 }, { 0xF832, 0x8CA5 }, { 0xF834, 0x74A0 }, { 0xF836, 0xC50E },
>>                          { 0xF838, 0x9CA2 }, { 0xF83A, 0x1C11 }, { 0xF83C, 0x9CA0 }, { 0xF83E, 0xE006 },
>>                          { 0xF840, 0x74F8 }, { 0xF842, 0x48C4 }, { 0xF844, 0x8CF8 }, { 0xF846, 0xC404 },
>>                          { 0xF848, 0xBC00 }, { 0xF84A, 0xC403 }, { 0xF84C, 0xBC00 }, { 0xF84E, 0x0BF2 },
>>                          { 0xF850, 0x0C0A }, { 0xF852, 0xE434 }, { 0xF854, 0xD3C0 }, { 0xF856, 0x49D9 },
>>                          { 0xF858, 0xF01F }, { 0xF85A, 0xC526 }, { 0xF85C, 0x64A5 }, { 0xF85E, 0x1400 },
>>                          { 0xF860, 0xF007 }, { 0xF862, 0x0C01 }, { 0xF864, 0x8CA5 }, { 0xF866, 0x1C15 },
>>                          { 0xF868, 0xC51B }, { 0xF86A, 0x9CA0 }, { 0xF86C, 0xE013 }, { 0xF86E, 0xC519 },
>>                          { 0xF870, 0x74A0 }, { 0xF872, 0x48C4 }, { 0xF874, 0x8CA0 }, { 0xF876, 0xC516 },
>>                          { 0xF878, 0x74A4 }, { 0xF87A, 0x48C8 }, { 0xF87C, 0x48CA }, { 0xF87E, 0x9CA4 },
>>                          { 0xF880, 0xC512 }, { 0xF882, 0x1B00 }, { 0xF884, 0x9BA0 }, { 0xF886, 0x1B1C },
>>                          { 0xF888, 0x483F }, { 0xF88A, 0x9BA2 }, { 0xF88C, 0x1B04 }, { 0xF88E, 0xC508 },
>>                          { 0xF890, 0x9BA0 }, { 0xF892, 0xC505 }, { 0xF894, 0xBD00 }, { 0xF896, 0xC502 },
>>                          { 0xF898, 0xBD00 }, { 0xF89A, 0x0300 }, { 0xF89C, 0x051E }, { 0xF89E, 0xE434 },
>>                          { 0xF8A0, 0xE018 }, { 0xF8A2, 0xE092 }, { 0xF8A4, 0xDE20 }, { 0xF8A6, 0xD3C0 },
>>                          { 0xF8A8, 0xC50F }, { 0xF8AA, 0x76A4 }, { 0xF8AC, 0x49E3 }, { 0xF8AE, 0xF007 },
>>                          { 0xF8B0, 0x49C0 }, { 0xF8B2, 0xF103 }, { 0xF8B4, 0xC607 }, { 0xF8B6, 0xBE00 },
>>                          { 0xF8B8, 0xC606 }, { 0xF8BA, 0xBE00 }, { 0xF8BC, 0xC602 }, { 0xF8BE, 0xBE00 },
>>                          { 0xF8C0, 0x0C4C }, { 0xF8C2, 0x0C28 }, { 0xF8C4, 0x0C2C }, { 0xF8C6, 0xDC00 },
>>                          { 0xF8C8, 0xC707 }, { 0xF8CA, 0x1D00 }, { 0xF8CC, 0x8DE2 }, { 0xF8CE, 0x48C1 },
>>                          { 0xF8D0, 0xC502 }, { 0xF8D2, 0xBD00 }, { 0xF8D4, 0x00AA }, { 0xF8D6, 0xE0C0 },
>>                          { 0xF8D8, 0xC502 }, { 0xF8DA, 0xBD00 }, { 0xF8DC, 0x0132 },
>>                          { 0x0000, 0x0000 },
>>                  };
>>
>>                  static const struct recover_8411b_info final_seq[] = {
>>                          { 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
>>                          { 0xFC32, 0x0C25 }, { 0xFC34, 0x00A9 }, { 0xFC36, 0x012D },
>>                          { 0x0000, 0x0000 },
>>                  };
>>
>>                  r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>                  mdelay(3);
>>                  r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>>                  r8168_mac_ocp_write_seq(tp, recover_seq);
>>                  r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>>                  r8168_mac_ocp_write_seq(tp, final_seq);
>>          }

> Putting the whole code sequence in the commit description isn't benefitial IMO.

Got it.
  
>> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
>> functions that only changed the function names and the ending of the line, so the actual
>> hex data is unchanged.
>>
>> Note that the original reason for the introduction of the commit fe4e8db0392a6
>> was to enable recovery of the RX unit on the RTL8411b which was confused by the
>> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
> 
> You state "amplifies the problem" which means that the original problem
> isn't solved. Is this what you want to say and is there evidence?
> Or did you mean that the original problem was replaced with a different problem?

No, the problems were LOCK-ed assembler instructions for mb() memory barrier in RTL_W32()
macro expansion and for the actual spin_lock_irqsave() / spin_lock_irqrestore().

RTL_W32() is defined as:

     #define RTL_W32(tp, reg, val32)	writel((val32), tp->mmio_addr + (reg))

writel now expands to:

     build_mmio_write(writel, "l", unsigned int, "r", :"memory")


--- NOTE -----------------------
The example from above expanding writel() into:

     extern inline void writel(u32 b, volatile void __iomem *addr)
     {
	mb();
	__raw_writel(b, addr);
     }

was errounously from Alpha.
--- END NOTE -------------------

So which makes writel() on x86_64:

     #define build_mmio_write(name, size, type, reg, barrier) \
     static inline void name(type val, volatile void __iomem *addr) \
     { asm volatile("mov" size " %0,%1": :reg (val), \
     "m" (*(volatile type __force *)addr) barrier); }

where barrier is:

     # define barrier() __asm__ __volatile__("": : :"memory")

mb() on i386 is:

     #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")

While for example, on x86_64 the Source expands mb() to

     #define mb()	asm volatile("mfence" ::: "memory")
     #define rmb()	asm volatile("lfence" ::: "memory")
     #define wmb()	asm volatile("sfence" ::: "memory")
     #define smp_rmb() barrier()
     #define smp_wmb() barrier()
     #define smp_mb()  asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")

These are already three instructions with LOCK prefix, plus the stall from writel() for
each of the roughly 130

     r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data);

calls.

This means spin_lock_irqsave(), spin_unlock_irqrestore(), mb() and writel() per
each of 130 r8168_mac_ocp_write() calls. And none of those calls are cheap.

We have partially improved the memory bus LOCK contention by grouping the operations
that needed locking together. But it is not a cure-all. mb() and writel() in RTL_W32 remain.

Obviously from the above said, these calls involve memory barriers and I/O and
maybe DMA barriers.

>> into a series of about 500+ memory bus locks, most waiting for the main memory read,
>> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
>> the programming sequence to reach RTL NIC registers.
>>
>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
>>
>> Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Cc: Marco Elver <elver@google.com>
>> Cc: nic_swsd@realtek.com
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>>   drivers/net/ethernet/realtek/r8169_main.c | 200 ++++++++--------------
>>   1 file changed, 74 insertions(+), 126 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 361b90007148..c0a1f08f7667 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -3085,6 +3085,31 @@ static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
>>   	rtl_ephy_init(tp, e_info_8168g_2);
>>   }
>>   
>> +struct recover_8411b_info {
>> +	u32	reg;
>> +	u32	data;
>> +};
>> +
>> +static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp, const struct recover_8411b_info *array)
>> +{
>> +	struct recover_8411b_info const *p = array;
>> +
>> +	while (p->reg) {
>> +		if (!rtl_ocp_reg_failure(p->reg))
>> +			RTL_W32(tp, OCPDR, OCPAR_FLAG | (p->reg << 15) | p->data);
> 
> Better use __r8168_mac_ocp_write() here. Duplicating the code of
> this function adds unnecessary complexity.

OK.

>> +		p++;
>> +	}
>> +}
>> +
>> +static void r8168_mac_ocp_write_seq(struct rtl8169_private *tp, const struct recover_8411b_info *array)
>> +{
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>> +	__r8168_mac_ocp_write_seq(tp, array);
>> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>> +}
>> +
> 
> Maybe sooner or later we use this in other places too. So we should:
> - put it before any usage of r8168_mac_ocp_write()
> - remove references to RTL8411b

Got it.

>>   static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>   {
>>   	static const struct ephy_info e_info_8411_2[] = {
>> @@ -3107,138 +3132,61 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>   	/* The following Realtek-provided magic fixes an issue with the RX unit
>>   	 * getting confused after the PHY having been powered-down.
>>   	 */
>> -	r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
>> +
>> +	static const struct recover_8411b_info init_zero_seq[] = {
>> +		{ 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
>> +		{ 0xFC30, 0x0000 }, { 0xFC32, 0x0000 }, { 0xFC34, 0x0000 }, { 0xFC36, 0x0000 },
>> +		{ 0x0000, 0x0000 },
> 
> The sentinel can be simply written as {}

OK. You will see a surprise there.

Best regards,
Mirsad

>> +	};
>> +
>> +	static const struct recover_8411b_info recover_seq[] = {
>> +		{ 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
>> +		{ 0xF808, 0xE027 }, { 0xF80A, 0xE04F }, { 0xF80C, 0xE05E }, { 0xF80E, 0xE065 },
>> +		{ 0xF810, 0xC602 }, { 0xF812, 0xBE00 }, { 0xF814, 0x0000 }, { 0xF816, 0xC502 },
>> +		{ 0xF818, 0xBD00 }, { 0xF81A, 0x074C }, { 0xF81C, 0xC302 }, { 0xF81E, 0xBB00 },
>> +		{ 0xF820, 0x080A }, { 0xF822, 0x6420 }, { 0xF824, 0x48C2 }, { 0xF826, 0x8C20 },
>> +		{ 0xF828, 0xC516 }, { 0xF82A, 0x64A4 }, { 0xF82C, 0x49C0 }, { 0xF82E, 0xF009 },
>> +		{ 0xF830, 0x74A2 }, { 0xF832, 0x8CA5 }, { 0xF834, 0x74A0 }, { 0xF836, 0xC50E },
>> +		{ 0xF838, 0x9CA2 }, { 0xF83A, 0x1C11 }, { 0xF83C, 0x9CA0 }, { 0xF83E, 0xE006 },
>> +		{ 0xF840, 0x74F8 }, { 0xF842, 0x48C4 }, { 0xF844, 0x8CF8 }, { 0xF846, 0xC404 },
>> +		{ 0xF848, 0xBC00 }, { 0xF84A, 0xC403 }, { 0xF84C, 0xBC00 }, { 0xF84E, 0x0BF2 },
>> +		{ 0xF850, 0x0C0A }, { 0xF852, 0xE434 }, { 0xF854, 0xD3C0 }, { 0xF856, 0x49D9 },
>> +		{ 0xF858, 0xF01F }, { 0xF85A, 0xC526 }, { 0xF85C, 0x64A5 }, { 0xF85E, 0x1400 },
>> +		{ 0xF860, 0xF007 }, { 0xF862, 0x0C01 }, { 0xF864, 0x8CA5 }, { 0xF866, 0x1C15 },
>> +		{ 0xF868, 0xC51B }, { 0xF86A, 0x9CA0 }, { 0xF86C, 0xE013 }, { 0xF86E, 0xC519 },
>> +		{ 0xF870, 0x74A0 }, { 0xF872, 0x48C4 }, { 0xF874, 0x8CA0 }, { 0xF876, 0xC516 },
>> +		{ 0xF878, 0x74A4 }, { 0xF87A, 0x48C8 }, { 0xF87C, 0x48CA }, { 0xF87E, 0x9CA4 },
>> +		{ 0xF880, 0xC512 }, { 0xF882, 0x1B00 }, { 0xF884, 0x9BA0 }, { 0xF886, 0x1B1C },
>> +		{ 0xF888, 0x483F }, { 0xF88A, 0x9BA2 }, { 0xF88C, 0x1B04 }, { 0xF88E, 0xC508 },
>> +		{ 0xF890, 0x9BA0 }, { 0xF892, 0xC505 }, { 0xF894, 0xBD00 }, { 0xF896, 0xC502 },
>> +		{ 0xF898, 0xBD00 }, { 0xF89A, 0x0300 }, { 0xF89C, 0x051E }, { 0xF89E, 0xE434 },
>> +		{ 0xF8A0, 0xE018 }, { 0xF8A2, 0xE092 }, { 0xF8A4, 0xDE20 }, { 0xF8A6, 0xD3C0 },
>> +		{ 0xF8A8, 0xC50F }, { 0xF8AA, 0x76A4 }, { 0xF8AC, 0x49E3 }, { 0xF8AE, 0xF007 },
>> +		{ 0xF8B0, 0x49C0 }, { 0xF8B2, 0xF103 }, { 0xF8B4, 0xC607 }, { 0xF8B6, 0xBE00 },
>> +		{ 0xF8B8, 0xC606 }, { 0xF8BA, 0xBE00 }, { 0xF8BC, 0xC602 }, { 0xF8BE, 0xBE00 },
>> +		{ 0xF8C0, 0x0C4C }, { 0xF8C2, 0x0C28 }, { 0xF8C4, 0x0C2C }, { 0xF8C6, 0xDC00 },
>> +		{ 0xF8C8, 0xC707 }, { 0xF8CA, 0x1D00 }, { 0xF8CC, 0x8DE2 }, { 0xF8CE, 0x48C1 },
>> +		{ 0xF8D0, 0xC502 }, { 0xF8D2, 0xBD00 }, { 0xF8D4, 0x00AA }, { 0xF8D6, 0xE0C0 },
>> +		{ 0xF8D8, 0xC502 }, { 0xF8DA, 0xBD00 }, { 0xF8DC, 0x0132 },
>> +		{ 0x0000, 0x0000 },
>> +	};
>> +
>> +	static const struct recover_8411b_info final_seq[] = {
>> +		{ 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
>> +		{ 0xFC32, 0x0C25 }, { 0xFC34, 0x00A9 }, { 0xFC36, 0x012D },
>> +		{ 0x0000, 0x0000 },
>> +	};
>> +
>> +	r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>   	mdelay(3);
>>   	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>>   
>> -	r8168_mac_ocp_write(tp, 0xF800, 0xE008);
>> -	r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
>> -	r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
>> -	r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
>> -	r8168_mac_ocp_write(tp, 0xF808, 0xE027);
>> -	r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
>> -	r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
>> -	r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
>> -	r8168_mac_ocp_write(tp, 0xF810, 0xC602);
>> -	r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF814, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xF816, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
>> -	r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
>> -	r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
>> -	r8168_mac_ocp_write(tp, 0xF820, 0x080A);
>> -	r8168_mac_ocp_write(tp, 0xF822, 0x6420);
>> -	r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
>> -	r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
>> -	r8168_mac_ocp_write(tp, 0xF828, 0xC516);
>> -	r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
>> -	r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
>> -	r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
>> -	r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
>> -	r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
>> -	r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
>> -	r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
>> -	r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
>> -	r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
>> -	r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
>> -	r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
>> -	r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
>> -	r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
>> -	r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
>> -	r8168_mac_ocp_write(tp, 0xF846, 0xC404);
>> -	r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
>> -	r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
>> -	r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
>> -	r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
>> -	r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
>> -	r8168_mac_ocp_write(tp, 0xF852, 0xE434);
>> -	r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
>> -	r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
>> -	r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
>> -	r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
>> -	r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
>> -	r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
>> -	r8168_mac_ocp_write(tp, 0xF860, 0xF007);
>> -	r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
>> -	r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
>> -	r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
>> -	r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
>> -	r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
>> -	r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
>> -	r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
>> -	r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
>> -	r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
>> -	r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
>> -	r8168_mac_ocp_write(tp, 0xF876, 0xC516);
>> -	r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
>> -	r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
>> -	r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
>> -	r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
>> -	r8168_mac_ocp_write(tp, 0xF880, 0xC512);
>> -	r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
>> -	r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
>> -	r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
>> -	r8168_mac_ocp_write(tp, 0xF888, 0x483F);
>> -	r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
>> -	r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
>> -	r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
>> -	r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
>> -	r8168_mac_ocp_write(tp, 0xF892, 0xC505);
>> -	r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF896, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
>> -	r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
>> -	r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
>> -	r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
>> -	r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
>> -	r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
>> -	r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
>> -	r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
>> -	r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
>> -	r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
>> -	r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
>> -	r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
>> -	r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
>> -	r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
>> -	r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
>> -	r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
>> -	r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
>> -	r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
>> -	r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
>> -	r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
>> -	r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
>> -	r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
>> -	r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
>> -	r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
>> -	r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
>> -	r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
>> -	r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
>> +	r8168_mac_ocp_write_seq(tp, recover_seq);
>>   
>>   	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>>   
>> -	r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
>> -	r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
>> -	r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
>> -	r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
>> -	r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
>> -	r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
>> -	r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
>> +	r8168_mac_ocp_write_seq(tp, final_seq);
>> +
>>   }
>>   
>>   static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
