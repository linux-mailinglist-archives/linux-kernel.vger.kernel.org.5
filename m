Return-Path: <linux-kernel+bounces-52829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05ED849D26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D5B1C22252
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDD2C19E;
	Mon,  5 Feb 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCIj2VQb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A242BB1F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143748; cv=none; b=H8xGf3sVLf/OJuR7vFqpjhSuZ63q+RSeZgCtr9suaxbB0qpeKE2j6yeXAmZIue7AHX6CbNgqwByhYKLeu2wRm8G+NjGnsDqDDctPZ0JV9PZ8kIwr6mhh8QlPD9KjswTXffvIKqUz1M+nLWDy5uI0/biSRYitZham7U13iNG35bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143748; c=relaxed/simple;
	bh=Z8SRYrvV4JZgQHuXnbU5u5fodN1hKThQZYfhVac4BLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJrkTFgT1gQl84JobybUC1QI/MljBrh6uf7JSDZjRXV945exrS/x+VQCCQDPrMpuoEzXG2A9YP/s6jepfnVQt0Wbmk9G6aZ8EUDcjIxMYvY1R9mmZxZD6OSDyJ7ZHLSJftJ1XhnahGy5MsJ/UwNwIFwHbxmt6+TKIqxZwLP7Xnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCIj2VQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445BBC433C7;
	Mon,  5 Feb 2024 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707143747;
	bh=Z8SRYrvV4JZgQHuXnbU5u5fodN1hKThQZYfhVac4BLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CCIj2VQbnsP8pGUX8XJomx4wB7Jcb6kfPo9ZQRGayljJfVs6PvfoaJn+E9KdyHG6p
	 036HGbBylrKcZxQNcXtLxmxpgl9a1fVFhA2HMl4iapCsAIelBmxSmJ0qr+JsDgon/F
	 o9Il2JJfB+aXtMBY/fRKJjWPkBtWyd9vcHsJC8/JkEGyJ0WvezxjLuhKLJ04AT6oV2
	 Wb3ptHRp72mWmwbkGazUUEi1O14PnOycFSzLzwvVPEXwtiyLvKEYiyF+A8yPsTWDj5
	 8/CheUDP8OwTvw5PMx/ErDz72wUSMMWFy+8+0jAv46+tLI++VhqAm8+n2N/1S53YG+
	 kbNEjKoHs6F0g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <anup@brainfault.org>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: Don't use IPIs in flush_icache_all() when
 patching text
In-Reply-To: <CAAhSdy08ocy2Ad96MdHdYN0fk5V0+0Kxc65m+mPQ6UnedFkckQ@mail.gmail.com>
References: <20240205042955.833752-1-apatel@ventanamicro.com>
 <d5e21238-89f4-444e-9c35-f4a28e01052e@ghiti.fr>
 <CAK9=C2XEmFBDB6R5f+L9++7ojhWb8rJK-e-vgFrDmsi2=DMOBw@mail.gmail.com>
 <87y1bzch0u.fsf@all.your.base.are.belong.to.us>
 <a3cb563b-5b41-4189-ac82-091d5cb3223e@ghiti.fr>
 <CAAhSdy08ocy2Ad96MdHdYN0fk5V0+0Kxc65m+mPQ6UnedFkckQ@mail.gmail.com>
Date: Mon, 05 Feb 2024 15:35:44 +0100
Message-ID: <87mssfx9kv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <anup@brainfault.org> writes:

> On Mon, Feb 5, 2024 at 7:38=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>>
>>
>> On 05/02/2024 12:00, Bj=C3=B6rn T=C3=B6pel wrote:
>> > Anup Patel <apatel@ventanamicro.com> writes:
>> >
>> >> On Mon, Feb 5, 2024 at 11:52=E2=80=AFAM Alexandre Ghiti <alex@ghiti.f=
r> wrote:
>> >>> Hi Anup,
>> >>>
>> >>> On 05/02/2024 05:29, Anup Patel wrote:
>> >>>> If some of the HARTs are parked by stop machine then IPI-based
>> >>>> flushing in flush_icache_all() will hang. This hang is observed
>> >>>> when text patching is invoked by various debug and BPF features.
>> >>>>
>> >>>> To avoid this hang, we force use of SBI-based icache flushing
>> >>>> when patching text.
>> >>>>
>> >>>> Fixes: 627922843235 ("RISC-V: Use IPIs for remote icache flush when=
 possible")
>> >>>> Reported-by: Bjorn Topel <bjorn@kernel.org>
>> >>>> Closes: https://gist.github.com/bjoto/04a580568378f3b5483af07cd9d22=
501
>> >>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> >>>> ---
>> >>>>    arch/riscv/include/asm/cacheflush.h | 7 ++++---
>> >>>>    arch/riscv/kernel/hibernate.c       | 2 +-
>> >>>>    arch/riscv/kernel/patch.c           | 4 ++--
>> >>>>    arch/riscv/mm/cacheflush.c          | 7 ++++---
>> >>>>    4 files changed, 11 insertions(+), 9 deletions(-)
>> >>>>
>> >>>> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/inclu=
de/asm/cacheflush.h
>> >>>> index a129dac4521d..561e079f34af 100644
>> >>>> --- a/arch/riscv/include/asm/cacheflush.h
>> >>>> +++ b/arch/riscv/include/asm/cacheflush.h
>> >>>> @@ -32,7 +32,8 @@ static inline void flush_dcache_page(struct page =
*page)
>> >>>>     * RISC-V doesn't have an instruction to flush parts of the inst=
ruction cache,
>> >>>>     * so instead we just flush the whole thing.
>> >>>>     */
>> >>>> -#define flush_icache_range(start, end) flush_icache_all()
>> >>>> +#define flush_icache_range(start, end) flush_icache_all(true)
>> >>>> +#define flush_icache_patch_range(start, end) flush_icache_all(fals=
e)
>> >>>>    #define flush_icache_user_page(vma, pg, addr, len) \
>> >>>>        flush_icache_mm(vma->vm_mm, 0)
>> >>>>
>> >>>> @@ -43,12 +44,12 @@ static inline void flush_dcache_page(struct pag=
e *page)
>> >>>>
>> >>>>    #ifndef CONFIG_SMP
>> >>>>
>> >>>> -#define flush_icache_all() local_flush_icache_all()
>> >>>> +#define flush_icache_all(want_ipi) local_flush_icache_all()
>> >>>>    #define flush_icache_mm(mm, local) flush_icache_all()
>> >>>>
>> >>>>    #else /* CONFIG_SMP */
>> >>>>
>> >>>> -void flush_icache_all(void);
>> >>>> +void flush_icache_all(bool want_ipi);
>> >>>>    void flush_icache_mm(struct mm_struct *mm, bool local);
>> >>>>
>> >>>>    #endif /* CONFIG_SMP */
>> >>>> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibe=
rnate.c
>> >>>> index 671b686c0158..388f10e187ba 100644
>> >>>> --- a/arch/riscv/kernel/hibernate.c
>> >>>> +++ b/arch/riscv/kernel/hibernate.c
>> >>>> @@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
>> >>>>        } else {
>> >>>>                suspend_restore_csrs(hibernate_cpu_context);
>> >>>>                flush_tlb_all();
>> >>>> -             flush_icache_all();
>> >>>> +             flush_icache_all(true);
>> >>>>
>> >>>>                /*
>> >>>>                 * Tell the hibernation core that we've just restore=
d the memory.
>> >>>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
>> >>>> index 37e87fdcf6a0..721e144a7847 100644
>> >>>> --- a/arch/riscv/kernel/patch.c
>> >>>> +++ b/arch/riscv/kernel/patch.c
>> >>>> @@ -182,7 +182,7 @@ int patch_text_set_nosync(void *addr, u8 c, siz=
e_t len)
>> >>>>        ret =3D patch_insn_set(tp, c, len);
>> >>>>
>> >>>>        if (!ret)
>> >>>> -             flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len=
);
>> >>>> +             flush_icache_patch_range((uintptr_t)tp, (uintptr_t)tp=
 + len);
>> >>>>
>> >>>>        return ret;
>> >>>>    }
>> >>>> @@ -217,7 +217,7 @@ int patch_text_nosync(void *addr, const void *i=
nsns, size_t len)
>> >>>>        ret =3D patch_insn_write(tp, insns, len);
>> >>>>
>> >>>>        if (!ret)
>> >>>> -             flush_icache_range((uintptr_t) tp, (uintptr_t) tp + l=
en);
>> >>>> +             flush_icache_patch_range((uintptr_t) tp, (uintptr_t) =
tp + len);
>> >>>>
>> >>>>        return ret;
>> >>>>    }
>> >>>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> >>>> index 55a34f2020a8..03cd3d4831ef 100644
>> >>>> --- a/arch/riscv/mm/cacheflush.c
>> >>>> +++ b/arch/riscv/mm/cacheflush.c
>> >>>> @@ -17,11 +17,12 @@ static void ipi_remote_fence_i(void *info)
>> >>>>        return local_flush_icache_all();
>> >>>>    }
>> >>>>
>> >>>> -void flush_icache_all(void)
>> >>>> +void flush_icache_all(bool want_ipi)
>> >>>>    {
>> >>>>        local_flush_icache_all();
>> >>>>
>> >>>> -     if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence=
())
>> >>>> +     if (IS_ENABLED(CONFIG_RISCV_SBI) &&
>> >>>> +         (!want_ipi || !riscv_use_ipi_for_rfence()))
>> >>>>                sbi_remote_fence_i(NULL);
>> >>>>        else
>> >>>>                on_each_cpu(ipi_remote_fence_i, NULL, 1);
>> >>>> @@ -87,7 +88,7 @@ void flush_icache_pte(pte_t pte)
>> >>>>        struct folio *folio =3D page_folio(pte_page(pte));
>> >>>>
>> >>>>        if (!test_bit(PG_dcache_clean, &folio->flags)) {
>> >>>> -             flush_icache_all();
>> >>>> +             flush_icache_all(true);
>> >>>>                set_bit(PG_dcache_clean, &folio->flags);
>> >>>>        }
>> >>>>    }
>> >>>
>> >>> Since patch_text_cb() is run on all cpus, couldn't we completely avo=
id
>> >>> any remote icache flush by slightly changing patch_text_cb() instead=
 as
>> >>> follows?
>> >> Unfortunately patch_text_cb() is not the only user of patch_text_nosy=
nc
>> >> since patch_text_nosync() and patch_text_set_nosync() are called dire=
ctly
>> >> from other places as well.
>> > Yeah. There is one more stop_machine() text patching user, and that's
>> > ftrace. ftrace is using stop_machine() with the last argument set to
>> > NULL, so only patching on *any* hart. Continuing on Alex' idea would be
>> > to place an IPI flush in ftrace_arch_code_modify_post_process(),
>> > unfortately that's too late since we're already moved on from
>> > stop_machine().
>>
>>
>> After discussion with Bjorn, we think the solution would be to
>> reimplement arch_ftrace_update_code() with stop_machine(...,
>> cpu_online_mask) and use the same barrier as the one in patch_text_cb()
>> (csky does just that
>> https://elixir.bootlin.com/linux/latest/source/arch/csky/kernel/ftrace.c=
#L224).
>> And then we can apply the same solution as I first proposed: no more
>> remote icache flushes, only local ones.
>>
>> What do you think Anup? I can come up with this patch if you want.
>
> Sounds good to me. You will need a special .config from Bjorn to test
> your patch.

I also (apparently ;-)) like this solution!

To clarify; "The special config" does ftrace patching in initcall phase,
but you can reproduce by exercising kprobe/ftrace with the IMSIC IPI
patches.


Cheers,
Bj=C3=B6rn

