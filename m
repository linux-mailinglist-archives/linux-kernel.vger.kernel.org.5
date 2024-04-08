Return-Path: <linux-kernel+bounces-135880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96689CC8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F48B25A96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E514600B;
	Mon,  8 Apr 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PRn0pKzD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058171448D9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605374; cv=none; b=AzZwrG8W2U6iIFhmt2sthinaFwwSl3tdMhMOut8wpJiwzPGOiGatqIugZCsRfSGPgc4SGsqrwHyiuXdzl5SJAQlcLzwrKcRlygPLwUuUToRW6haRrTzkX0ZZRPPUCq437pMAqbIqaB1aOZdwnlsAHKQzlcMiSFvHEwJ/t+fo360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605374; c=relaxed/simple;
	bh=Sq0cmgG8aKfgwLftzVqC3+XG1CoRT7bcO5yWoXyphug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgrLU2cJk354Cb3nYC0t4RsagCVsbQnNOSKnvMFtNc2vb8TMs+SDkcG4pQzaXQELKrN435fqXxsP5MnyADksB9QSGT+CR5hKKltOMFIkD28oLn0sJuTDNLcFS931mtpCFPMgWUGTAN37mmeQhUTa31U6AnHL4/c2jqQoA5QV4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PRn0pKzD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so3566493a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712605370; x=1713210170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=72YscVDTvewIRtuloqTpCeA9z6Qw+3vcSaBx0vBmhBs=;
        b=PRn0pKzDhdA1AqwkzrXI51rowi6/PVwaGTVSd8dJd5yiS06hubB/QJj52ijqwqCBE4
         FfT9ab+AqO4w+FkqsrjYsxaBfR4fAodNP7e35JTtpQejPLT1JdYwTpTs5CbgN74rcvgZ
         F1YOnSCAqGZ/xA3nOuo+c9GzfRWkr0ZsB3ZBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605370; x=1713210170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72YscVDTvewIRtuloqTpCeA9z6Qw+3vcSaBx0vBmhBs=;
        b=p76T4JBf/NOfrNp7UqTpAMrFPIn9KnTPGjA4YpQKWl51SC0EIpUe/bNcLvnNE4g001
         MpJJ/lNLz2WK44nZBtzstE5u9V3fEo6nWsChBBIwZiS49ftW89Bb85FjMSmG9QfchQ1d
         YsB4Uppxr6qd8B/YTeGsUmzbUuZtv7Y558iH7babzHJ9ZVuQXnKuaKCc6VtgLTjLVX4j
         tz+QVzkFKf4TtbIZe8D6lpwsjvlMCFJx9QvwIep9kX9Ycz7B9bPQCmzIjB/eMuIxDyuO
         BWbaQh+DVaCe0yWPLmIUiTM885ZSZEr/4wv4MlKSepsvTfvaRj9+ZKoTiDT8Q1ofjwPE
         Y4wA==
X-Forwarded-Encrypted: i=1; AJvYcCUlEOvjVM70VyaeAeMbrQBSUCSMCUVcPywQNSyvsyb2ao1DSnE6JNQQLn1UAEAGk+TQfNHUbpgKuoi2n2diepKQrUOzsxL3Rk5FUYQ8
X-Gm-Message-State: AOJu0YwqTS8bYP164/nLyvO1MDSRdkyLUMNca94L54sHYNNqTJFU0BEg
	6eQONDap+Y+OmEKm+5AIQ/pdCicFO4sUVGpYl5ff/3l3GDsv6M8STEBaCVyw7ew20wHgmxMia6Q
	zbPwJyg==
X-Google-Smtp-Source: AGHT+IEvLbE6RFrPKYh03BanBFuEJSzqO5nboHnOB3mEIdaTzSh8pgDsdy0hkMZLCUoT+kFCu/+60w==
X-Received: by 2002:a50:d694:0:b0:56c:522f:53e1 with SMTP id r20-20020a50d694000000b0056c522f53e1mr6855679edi.17.1712605370110;
        Mon, 08 Apr 2024 12:42:50 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7d452000000b0056e247de8e3sm4423923edr.1.2024.04.08.12.42.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 12:42:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so3566441a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 12:42:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWevADIxCXt4m4lrPUNY6Uzaw98GKtLfwCanalf1C+o0wn0vMSsXR0jEgThuksHkGsDv4jSwpz0jOBJybmRX4XQ05MHLH58roWgWcPO
X-Received: by 2002:a17:907:36c7:b0:a51:de95:f592 with SMTP id
 bj7-20020a17090736c700b00a51de95f592mr2335175ejc.63.1712605368692; Mon, 08
 Apr 2024 12:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <20240408084934.GC21904@noisy.programming.kicks-ass.net> <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
In-Reply-To: <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 12:42:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com>
Message-ID: <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com>
Subject: Re: More annoying code generation by clang
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a469e806159b0245"

--000000000000a469e806159b0245
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 11:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's been reported long ago, it seems to be hard to fix.
>
> I suspect the issue is that the inline asm format is fairly closely
> related to the gcc machine descriptions (look at the machine
> descriptor files in gcc, and if you can ignore the horrid LISP-style
> syntax you see how close they are).

Actually, one of the github issues pages has more of an explanation
(and yes, it's tied to impedance issues between the inline asm syntax
and how clang works):

      https://github.com/llvm/llvm-project/issues/20571#issuecomment-980933442

so I wrote more of a commit log and did that "ASM_SOURCE_G" thing
(except I decided to call it "input" instead of "source", since that's
the standard inline asm language).

This version also has that output size fixed, and the commit message
talks about it.

This does *not* fix other inline asms to use "ASM_INPUT_G/RM".

I think it's mainly some of the bitop code that people have noticed
before - fls and variable_ffs() and friends.

I suspect clang is more common in the arm64 world than it is for
x86-64 kernel developers, and arm64 inline asm basically never uses
"rm" or "g" since arm64 doesn't have instructions that take either a
register or a memory operand.

Anyway, with gcc this generates

        cmp (%rdx),%ebx; sbb %rax,%rax  # _7->max_fds, fd, __mask

IOW, it uses the memory location for "max_fds". It couldn't do that
before, because it used to think that it always had to do the compare
in 64 bits, and the memory location is only 32-bit.

With clang, this generates

        movl    (%rcx), %eax
        cmpl    %eax, %edi
        sbbq    %rdi, %rdi

which has that extra register use, but is at least much better than
what it used to generate with crazy "load into register, spill to
stack, then compare against stack contents".

               Linus

--000000000000a469e806159b0245
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-x86-improve-array_index_mask_nospec-code-generation.patch"
Content-Disposition: attachment; 
	filename="0001-x86-improve-array_index_mask_nospec-code-generation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lurcy5bz0>
X-Attachment-Id: f_lurcy5bz0

RnJvbSA3Nzc5ZDI4NTA0MGJhYjY4NTI5NmRhMmNkMGFmZTlkMmQ3YjU4OTY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgOCBBcHIgMjAyNCAxMTozODozMCAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIHg4NjogaW1wcm92ZSBhcnJheV9pbmRleF9tYXNrX25vc3BlYygpIGNvZGUgZ2VuZXJh
dGlvbgoKRG9uJ3QgZm9yY2UgdGhlIGlucHV0cyB0byBiZSAndW5zaWduZWQgbG9uZycsIHdoZW4g
dGhlIGNvbXBhcmlzb24gY2FuCmVhc2lseSBiZSBkb25lIGluIDMyLWJpdCBpZiB0aGF0J3MgbW9y
ZSBhcHByb3ByaWF0ZS4KCk5vdGUgdGhhdCB3aGlsZSB3ZSBjYW4gbG9vayBhdCB0aGUgaW5wdXRz
IHRvIGNob29zZSBhbiBhcHByb3ByaWF0ZSBzaXplCmZvciB0aGUgY29tcGFyZSBpbnN0cnVjdGlv
biwgdGhlIG91dHB1dCBpcyBmaXhlZCBhdCAndW5zaWduZWQgbG9uZycuClRoYXQncyBub3QgdGVj
aG5pY2FsbHkgb3B0aW1hbCBlaXRoZXIsIHNpbmNlIGEgMzItYml0ICdzYmJsJyB3b3VsZCBvZnRl
bgpiZSBzdWZmaWNpZW50LgoKQnV0IGZvciB0aGUgb3V0Z29pbmcgbWFzayB3ZSBkb24ndCBrbm93
IGhvdyB0aGUgbWFzayBlbmRzIHVwIGJlaW5nIHVzZWQKKGllIHdlIGhhdmUgdXNlcyB0aGF0aGF2
ZSBhbiBpbmNvbWluZyAzMi1iaXQgYXJyYXkgaW5kZXgsIGJ1dCBlbmQgdXAKdXNpbmcgdGhlIG1h
c2sgZm9yIG90aGVyIHRoaW5ncykuICBUaGF0IHNhaWQsIGl0IG9ubHkgY29zdHMgdGhlIGV4dHJh
ClJFWCBwcmVmaXggdG8gYWx3YXlzIGdlbmVyYXRlIHRoZSA2NC1iaXQgbWFzay4KClsgQSAnc2Ji
bCcgYWxzbyBhbHdheXMgdGVjaG5pY2FsbHkgZ2VuZXJhdGVzIGEgNjQtYml0IG1hc2ssIGJ1dCB3
aXRoIHRoZQogIHVwcGVyIDMyIGJpdHMgY2xlYXI6IHRoYXQncyBmaW5lIGZvciB3aGVuIHRoZSBp
bmNvbWluZyBpbmRleCB0aGF0IHdpbGwKICBiZSBtYXNrZWQgaXMgYWxyZWFkeSAzMi1iaXQsIGJ1
dCBub3QgaWYgeW91IHVzZSB0aGUgbWFzayB0byBtYXNrIGEKICBwb2ludGVyIGFmdGVyd2FyZHMs
IGxpa2UgdGhlIGZpbGUgdGFibGUgbG9va3VwIGRvZXMgXQoKQWxzbywgd29yayBhcm91bmQgY2xh
bmcgcHJvYmxlbXMgd2l0aCBhc20gY29uc3RyYWludHMgdGhhdCBoYXZlIG11bHRpcGxlCnBvc3Np
YmlsaXRpZXMsIHBhcnRpY3VsYXJseSAiZyIgYW5kICJybSIuICBDbGFuZyBzZWVtcyB0byB0dXJu
IGlucHV0cwpsaWtlIHRoYXQgaW50byB0aGUgbW9zdCBnZW5lcmljIGZvcm0sIHdoaWNoIGlzIHRo
ZSBtZW1vcnkgaW5wdXQgLSBidXQgdG8KbWFrZSBtYXR0ZXJzIHdvcnNlLCBjbGFuZyB3b24ndCBl
dmVuIHVzZSBhIHBvc3NpYmxlIG9yaWdpbmFsIG1lbW9yeQpsb2NhdGlvbiwgYnV0IHdpbGwgc3Bp
bGwgdGhlIHZhbHVlIHRvIHN0YWNrLCBhbmQgdXNlIHRoZSBzdGFjayBmb3IgdGhlCmFzbSBpbnB1
dC4KClNlZQoKICBodHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3QvaXNzdWVzLzIw
NTcxI2lzc3VlY29tbWVudC05ODA5MzM0NDIKCmZvciBzb21lIGV4cGxhbmF0aW9uIG9mIHdoeSBj
bGFuZyBoYXMgdGhpcyBzdHJhbmdlIGJlaGF2aW9yLCBidXQgdGhlIGVuZApyZXN1bHQgaXMgdGhh
dCAiZyIgYW5kICJybSIgcmVhbGx5IGVuZCB1cCBnZW5lcmF0aW5nIGhvcnJpZCBjb2RlLgoKTGlu
azogaHR0cHM6Ly9naXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0L2lzc3Vlcy8yMDU3MQpDYzog
UGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgpDYzogSC4gUGV0ZXIgQW52aW4g
PGhwYUB6eXRvci5jb20+CkNjOiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4KQ2M6IFRo
b21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBU
b3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0tLQogYXJjaC94ODYvaW5j
bHVkZS9hc20vYmFycmllci5oIHwgMjQgKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiBpbmNsdWRl
L2xpbnV4L2NvbXBpbGVyLWNsYW5nLmggfCAxMiArKysrKysrKysrKysKIGluY2x1ZGUvbGludXgv
Y29tcGlsZXJfdHlwZXMuaCB8ICA5ICsrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNl
cnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9iYXJyaWVyLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9iYXJyaWVyLmgKaW5kZXggNjZl
NTdjMDEwMzkyLi4yMzRmZDg5MmUzOWUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2JhcnJpZXIuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9iYXJyaWVyLmgKQEAgLTMzLDIw
ICszMywxNiBAQAogICogUmV0dXJuczoKICAqICAgICAwIC0gKGluZGV4IDwgc2l6ZSkKICAqLwot
c3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25nIGFycmF5X2luZGV4X21hc2tfbm9z
cGVjKHVuc2lnbmVkIGxvbmcgaW5kZXgsCi0JCXVuc2lnbmVkIGxvbmcgc2l6ZSkKLXsKLQl1bnNp
Z25lZCBsb25nIG1hc2s7Ci0KLQlhc20gdm9sYXRpbGUgKCJjbXAgJTEsJTI7IHNiYiAlMCwlMDsi
Ci0JCQk6Ij1yIiAobWFzaykKLQkJCToiZyIoc2l6ZSksInIiIChpbmRleCkKLQkJCToiY2MiKTsK
LQlyZXR1cm4gbWFzazsKLX0KLQotLyogT3ZlcnJpZGUgdGhlIGRlZmF1bHQgaW1wbGVtZW50YXRp
b24gZnJvbSBsaW51eC9ub3NwZWMuaC4gKi8KLSNkZWZpbmUgYXJyYXlfaW5kZXhfbWFza19ub3Nw
ZWMgYXJyYXlfaW5kZXhfbWFza19ub3NwZWMKKyNkZWZpbmUgYXJyYXlfaW5kZXhfbWFza19ub3Nw
ZWMoaWR4LHN6KSAoewlcCisJdHlwZW9mKChpZHgpKyhzeikpIF9faWR4ID0gKGlkeCk7CVwKKwl0
eXBlb2YoX19pZHgpIF9fc3ogPSAoc3opOwkJXAorCXVuc2lnbmVkIGxvbmcgX19tYXNrOwkJCVwK
Kwlhc20gdm9sYXRpbGUgKCJjbXAgJTEsJTI7IHNiYiAlMCwlMCIJXAorCQkJOiI9ciIgKF9fbWFz
aykJCVwKKwkJCTpBU01fSU5QVVRfRyAoX19zeiksCVwKKwkJCSAiciIgKF9faWR4KQkJXAorCQkJ
OiJjYyIpOwkJCVwKKwlfX21hc2s7IH0pCiAKIC8qIFByZXZlbnQgc3BlY3VsYXRpdmUgZXhlY3V0
aW9uIHBhc3QgdGhpcyBiYXJyaWVyLiAqLwogI2RlZmluZSBiYXJyaWVyX25vc3BlYygpIGFzbSB2
b2xhdGlsZSgibGZlbmNlIjo6OiJtZW1vcnkiKQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9j
b21waWxlci1jbGFuZy5oIGIvaW5jbHVkZS9saW51eC9jb21waWxlci1jbGFuZy5oCmluZGV4IDQ5
ZmVhYzAxNjJhNS4uMGRlZTA2MWZkN2E2IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBp
bGVyLWNsYW5nLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlci1jbGFuZy5oCkBAIC0xMTgs
MyArMTE4LDE1IEBACiAKICNkZWZpbmUgX19kaWFnX2lnbm9yZV9hbGwob3B0aW9uLCBjb21tZW50
KSBcCiAJX19kaWFnX2NsYW5nKDEzLCBpZ25vcmUsIG9wdGlvbikKKworLyoKKyAqIGNsYW5nIGhh
cyBob3JyaWJsZSBiZWhhdmlvciB3aXRoICJnIiBvciAicm0iIGNvbnN0cmFpbnRzIGZvciBhc20K
KyAqIGlucHV0cywgdHVybmluZyB0aGVtIGludG8gc29tZXRoaW5nIHdvcnNlIHRoYW4gIm0iLiBB
dm9pZCB1c2luZworICogY29uc3RyYWludHMgd2l0aCBtdWx0aXBsZSBwb3NzaWJsZSB1c2VzIChi
dXQgImlyIiBzZWVtcyB0byBiZSBvayk6CisgKgorICoJaHR0cHM6Ly9naXRodWIuY29tL2xsdm0v
bGx2bS1wcm9qZWN0L2lzc3Vlcy8yMDU3MQorICoJaHR0cHM6Ly9naXRodWIuY29tL2xsdm0vbGx2
bS1wcm9qZWN0L2lzc3Vlcy8zMDg3MworICoJaHR0cHM6Ly9naXRodWIuY29tL2xsdm0vbGx2bS1w
cm9qZWN0L2lzc3Vlcy8zNDgzNworICovCisjZGVmaW5lIEFTTV9JTlBVVF9HICJpciIKKyNkZWZp
bmUgQVNNX0lOUFVUX1JNICJyIgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jb21waWxlcl90
eXBlcy5oIGIvaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oCmluZGV4IDJhYmFhM2E4MjVh
OS4uZTUzYWNkMzEwNTQ1IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVz
LmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oCkBAIC0zODAsNiArMzgwLDE1
IEBAIHN0cnVjdCBmdHJhY2VfbGlrZWx5X2RhdGEgewogI2RlZmluZSBhc21fZ290b19vdXRwdXQo
eC4uLikgYXNtIHZvbGF0aWxlIGdvdG8oeCkKICNlbmRpZgogCisvKgorICogQ2xhbmcgaGFzIHRy
b3VibGUgd2l0aCBjb25zdHJhaW50cyB3aXRoIG11bHRpcGxlCisgKiBhbHRlcm5hdGl2ZSBiZWhh
dmlvcnMgKG1haW5seSAiZyIgYW5kICJybSIpLgorICovCisjaWZuZGVmIEFTTV9JTlBVVF9HCisg
ICNkZWZpbmUgQVNNX0lOUFVUX0cgImciCisgICNkZWZpbmUgQVNNX0lOUFVUX1JNICJybSIKKyNl
bmRpZgorCiAjaWZkZWYgQ09ORklHX0NDX0hBU19BU01fSU5MSU5FCiAjZGVmaW5lIGFzbV9pbmxp
bmUgYXNtIF9faW5saW5lCiAjZWxzZQotLSAKMi40NC4wLjMzMC5nNGQxOGM4ODE3NQoK
--000000000000a469e806159b0245--

