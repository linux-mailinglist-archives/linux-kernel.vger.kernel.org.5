Return-Path: <linux-kernel+bounces-5805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4CE818FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0064B1F26078
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085337D35;
	Tue, 19 Dec 2023 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jw6E2QpX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470D437D1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1ca24776c3so1149940266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703010077; x=1703614877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MEyPrJfFY8wsnlnRqNTI0PF/m1A8xGUMS6bKe4vqiaM=;
        b=Jw6E2QpXMrON01Jl0K7q4BmGiCuog1TLJln0M6O1foWA/nLnYD6UkmAQ9vpXfxoOPQ
         0qye3l3vV+v338DYamA6wRf/9Ej0JaCbm1wjjPB1c52uzb1dCUKaHTyNFqRY+nijPLus
         NryTwiqX2D1mkBpwctfUcNcuLU1wblQZP5ZH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010077; x=1703614877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEyPrJfFY8wsnlnRqNTI0PF/m1A8xGUMS6bKe4vqiaM=;
        b=MFIBAMKEusakXFPEWHqrUCmhNkJNSst8XgCKFUvi6ZFmVO9ty+uARkhdktkikGZ/Sl
         OE439Js+LKDh0OerS4rboD8isRBdpFVjDdcNH6oU+2Lx7x20+fV/FsQHmDk+4TU48AyS
         h9ZXi9NWMzrFbIZoaAxR3LhtchyxTvL9foijjTs2dx2pOuWjWMJh1uHbmUOkV66LLi/T
         aWlZxuF7T2f11tLnpyjNDom9ukJtqTj3D9bgXK5Wm6p/lyaxhe/Zrbcf6wq66wzrUh2I
         StcjFB9aCqkrT0dEPHic721ZdxUucjkfaqAblfAqNUukaAeK4rLXxYQUAJXkw5VuQdWB
         8fWg==
X-Gm-Message-State: AOJu0YwyzkzLk9lKhlOBaclExKgvCwqM2ph41jyb1aeVcZMQI0Id1Zbc
	rxQti0tDO5VWXGUP+VBLHO1mibu3DDrlRl1GIPJlh2e09FwYuBmE
X-Google-Smtp-Source: AGHT+IETKxQgGNggJD/V1FSQzrPSK8GcsdzRw0er8fQRZJRkrdf51D5Vk1UdvZYdBksamsuZbgx/fQ==
X-Received: by 2002:a17:906:e84:b0:a23:4998:7e6e with SMTP id p4-20020a1709060e8400b00a2349987e6emr1694331ejf.5.1703010077175;
        Tue, 19 Dec 2023 10:21:17 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id tb19-20020a1709078b9300b00a1cd30d06d1sm15992623ejc.14.2023.12.19.10.21.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 10:21:16 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a1ca24776c3so1149935866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:21:16 -0800 (PST)
X-Received: by 2002:a17:907:76f9:b0:a23:48d2:8314 with SMTP id
 kg25-20020a17090776f900b00a2348d28314mr1593362ejc.42.1703010076267; Tue, 19
 Dec 2023 10:21:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312191507.348721d2-oliver.sang@intel.com> <20231219095821.GAZYFpPUSKexZAcl05@fat_crate.local>
In-Reply-To: <20231219095821.GAZYFpPUSKexZAcl05@fat_crate.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 19 Dec 2023 10:20:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
Message-ID: <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
Subject: Re: [linus:master] [x86/entry] be5341eb0d: WARNING:CPU:#PID:#at_int80_emulation
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <oliver.sang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 01:58, Borislav Petkov <bp@alien8.de> wrote:
>
> Looking at the dmesg, I think you missed the most important part - the
> preceding line:
>
> [   13.480504][   T48] CFI failure at int80_emulation+0x67/0xb0 (target: sys_ni_posix_timers+0x0/0x70; expected type: 0xb02b34d9)
>                         ^^^^^^^^^^^

So I think the issue here is that sys_ni_posix_timers is just linker
alias that is used for any non-implemented posix timer system call.

See:

  #define __SYS_NI(abi, name)                                             \
        SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);

and this all worked fine when the actual call to this was done in
assembly code that happily just called that function directly and
didn't care about any argument types.

But commit be5341eb0d43 ("x86/entry: Convert INT 0x80 emulation to
IDTENTRY") moved that call from assembly into C, and in the process
ended up enabling CFI for it all, and now the compiler will check that
the function types match. Which they don't, because we use that dummy
function (I don't think they do in general).

I don't know what the best fix is. Either CFI should be turned off for
that call, or we should make sure to generate those NI system calls
with the proper types.

The asm didn't care - as long as the function put -ENOSYS in %rax, it
did the right thing - but the kCFI stuff means that the C code now
cares (and checks) that prototypes etc really match.

Maybe we should just get rid of SYS_NI() _entirely_.

I think the only user is the posix-timers stuff, and everything else
uses COND_SYSCALL(), which actually *generates* all the proper weak
functions with all the proper function signatures, instead of playing
around with linker aliases that don't have them.

Afaik, the only reason the posix timers do that odd alias is because
they want to have that

        pr_err_once("process %d (%s) attempted a POSIX timer syscall "
                    "while CONFIG_POSIX_TIMERS is not set\n",
                    current->pid, current->comm);

which I don't think is really worth it. It goes back to 2016 when the
posix timers subsystem became configurable, and I doubt it is worth it
any more (and it was probably of dubious use even at the time).

But I've not had anything to do with the low-level kCFI stuff, and
I'll leave it to Thomas whether that SYS_NI() mess should just be
removed.

I do like the notion of just removing SYS_NI entirely, replacing it
with the standard COND_SYSCALL() thing (and same for the COMPAT
variables, of course).

Thomas?

               Linus

