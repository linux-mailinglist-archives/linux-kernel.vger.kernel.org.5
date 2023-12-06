Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F8807890
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379349AbjLFT1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378759AbjLFT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:27:47 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD0D51;
        Wed,  6 Dec 2023 11:27:51 -0800 (PST)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3B6JQkxV3836341
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 6 Dec 2023 11:26:47 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3B6JQkxV3836341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023111101; t=1701890808;
        bh=akiKjejgbWa4nCSIVifqNGjMe3xFffE8uHQIGGi+Tmg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=2+/t+vpuANyD6qq8PPN2cUrZovPTWNgYU0O/WPJnJZmoHDj1/j+I7qvQPyI0VaT6t
         PSnVYQWuzdVuA3b1kH6DsVHUrcR3wA4eYFygUFpjP6aXetHOqaKj15KkrtjTZRQYjQ
         YpeSTK34gwlSx1+XbnAcu4d4G2eIwbPWDJWdtlr3/PiZRjMHTTOX0+2Cs8ie+XZh5P
         rb1lNwWqo1U2evWTWEka2bZwFSzkGEwdpz7EEHUZnCLsHnPuJfMlIoc14jRDtlPBOO
         4/iZHfhzxHPxmpsW0gIv4oBh8cgpK3x+u+umIzkid2ELnJ9ZS9WB6TSHDQosiLbDrt
         svj+gr1RwqNRQ==
Date:   Wed, 06 Dec 2023 11:26:43 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Kang, Shan" <shan.kang@intel.com>
Subject: RE: [PATCH v13 26/35] x86/fred: FRED entry/exit and dispatch code
User-Agent: K-9 Mail for Android
In-Reply-To: <SA1PR11MB673472A25E72022F68882869A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231205105030.8698-1-xin3.li@intel.com> <20231205105030.8698-27-xin3.li@intel.com> <f260ddf9-be67-48e0-8121-6f58d46f7978@citrix.com> <SA1PR11MB67343544B0CEB6C82002790DA884A@SA1PR11MB6734.namprd11.prod.outlook.com> <4e41b658-f49e-424c-8a86-08c8ab8e384d@citrix.com> <SA1PR11MB673472A25E72022F68882869A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <F6CF8AB8-F5DB-44BD-B8A4-1A76E02CDCFA@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2023 11:19:26 AM PST, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wro=
te:
>> >>> +	case X86_TRAP_OF:
>> >>> +		exc_overflow(regs);
>> >>> +		return;
>> >>> +
>> >>> +	/* INT3 */
>> >>> +	case X86_TRAP_BP:
>> >>> +		exc_int3(regs);
>> >>> +		return;
>> >> =2E=2E=2E neither OF nor BP will ever enter fred_intx() because they=
're
>> >> type SWEXC not SWINT=2E
>> > Per FRED spec 5=2E0, section 7=2E3 Software Interrupts and Related In=
structions:
>> > INT n (opcode CD followed by an immediate byte): There are 256 such
>> > software interrupt instructions, one for each value n of the immediat=
e
>> > byte (0=E2=80=93255)=2E
>> >
>> > And appendix B Event Stack Levels:
>> > If the event is an execution of INT n (opcode CD n for 8-bit value n)=
,
>> > the event stack level is 0=2E The event type is 4 (software interrupt=
)
>> > and the vector is n=2E
>> >
>> > So int $0x4 and int $0x3 (use asm("=2Ebyte 0xCD, 0x03")) get here=2E
>> >
>> > But into (0xCE) and int3 (0xCC) do use event type SWEXC=2E
>> >
>> > BTW, into is NOT allowed in 64-bit mode but "int $0x4" is allowed=2E
>>=20
>> There is certainly fun to be had with CD 03 and CD 04 byte patterns, bu=
t if you
>> meant to mean those here, then the comments are wrong=2E
>>=20
>> Vectors 3 and 4 are installed with DPL3 because that is necessary to ma=
ke CC and
>> CE function in userspace=2E=C2=A0 It also suggests that the SWINT vs SW=
EXC distinction
>> was retrofitted to architecture after the 286, because exceptions don't=
 check DPL
>> and ICEBP delivers #DB from userspace even when Vector 1 has a DPL of 0=
=2E
>>=20
>> While CC is for most cases indistinguishable from CD 03, CE behaves ent=
irely
>> differently to CD 04=2E=C2=A0 CD 04 doesn't #UD in 64bit mode, and will=
 trigger
>> exc_overflow() irrespective of the state of EFLAGS=2EOF=2E
>>=20
>>=20
>> The SDM goes out of it's way to say not to use the CD 03 byte pattern (=
and it
>> does take effort to emit this byte pattern - e=2Eg=2E GAS will silently=
 translate "int $3"
>> to "int3"), and there's no plausible way software is using CD 04 in pla=
ce of CE=2E
>>=20
>> So why do we care about containing to make mistakes of the IDT era work=
 in a
>> FRED world?
>
>First, I agree with you because it makes things simple and neat=2E
>
>However, the latest SDM and FRED spec 5=2E0 both doesn't disallow it, so =
it
>becomes an OS implementation choice=2E
>
>>=20
>> Is there anything (other than perhaps the selftests) which would even n=
otice?
>
>I'm just conservative :)
>
>If a user app can do it with IDT, we should still allow it when FRED is
>enabled=2E  But if all key stakeholders don't care whatever gets broken
>due to the change and agree to change it=2E
>
>> >>> +		instrumentation_end();
>> >>> +		irqentry_exit(regs, state);
>> >>> +	} else {
>> >>> +		common_interrupt(regs, vector);
>> >>> +	}
>> >>> +}
>> >>> +
>> >>> +static noinstr void fred_exception(struct pt_regs *regs, unsigned
>> >>> +long error_code) {
>> >>> +	/* Optimize for #PF=2E That's the only exception which matters
>> >>> +performance
>> >> wise */
>> >>> +	if (likely(regs->fred_ss=2Evector =3D=3D X86_TRAP_PF)) {
>> >>> +		exc_page_fault(regs, error_code);
>> >>> +		return;
>> >>> +	}
>> >>> +
>> >>> +	switch (regs->fred_ss=2Evector) {
>> >>> +	case X86_TRAP_DE: return exc_divide_error(regs);
>> >>> +	case X86_TRAP_DB: return fred_exc_debug(regs);
>> >>> +	case X86_TRAP_BP: return exc_int3(regs);
>> >>> +	case X86_TRAP_OF: return exc_overflow(regs);
>> >> Depending on what you want to do with BP/OF vs fred_intx(), this may
>> >> need adjusting=2E
>> >>
>> >> If you are cross-checking type and vector, then these should be
>> >> rejected for not being of type HWEXC=2E
>> > You're right, the event type needs to be SWEXC for into and int3=2E
>> >
>> > However, would it be overkilling?  Assuming hardware and VMM are sane=
=2E
>>=20
>> You either care about cross checking, or not=2E=C2=A0 Right now, this p=
atch is a mix of the
>> two approaches=2E
>>=20
>> In my opinion, cross-checking is the better approach, because it means =
that
>> violations of the assumptions get noticed more quickly, and hopefully b=
y
>> whomever is working on the new feature which alters the assumptions=2E
>
>Yeah, I can make the change=2E
>
>Thanks!
>    Xin
>

The intent is to not break userspace even if userspace does something fund=
amentally stupid=2E
