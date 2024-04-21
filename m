Return-Path: <linux-kernel+bounces-152536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3C8AC03A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F19B20AAA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A7219FF;
	Sun, 21 Apr 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AVBJwZUA"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB128D527
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713719932; cv=none; b=tJ4xSZXOxt0/88nW0bWNNIAYtCikQ0W6IpjcQ5F0CQ2/8dChfEV8zUZ3bZVdSPcT0qofHUTo6ROPzud1hauPxulpW+NCGRwOc3Bwj6Dyr4+okabquec6x/CZzLddMc+zos7zV74FUVfA8Q2zJKIzxLiHKVW0wj+Xkp0UH1MlR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713719932; c=relaxed/simple;
	bh=DHLrs7TTGJjLWnwYgITKxlgY9EdVO1HEbdYy6RvIBH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta2SVc0jXU3O7NXydxzLA5/f6VltOpi3MQu1mqqaA+pq+9bR5x6UFjQ4Zfi0wlDoJCFr6yYi9eD+wcnJ1XFPCAQY+xKukD9GwFhTZzxUPQe4RHruVQrsgykDGc3yi1NjXDJz5uQQ88MTR9DX04kOirC2k0Vcqow2QRGjQlf/2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AVBJwZUA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso5940435a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713719929; x=1714324729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zE3htHHJkncdTmVNKk4IeQEENfnZVVKe/RHKrqQQIA4=;
        b=AVBJwZUABczdwL977gVg7aTqL7kN15cHq6JStPap5oe6qXjxsaHUnzpbdwYAN63biA
         0dk+0dz4Q0ELp0HpBjOEEprQBCPyB+W7IDsxtVpsrotO2dNvfNPgrJehEGwTAsW3ev9s
         ac78WTy7Z7uGCIBX/IfCKbxLKBmXHtzazQwKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713719929; x=1714324729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zE3htHHJkncdTmVNKk4IeQEENfnZVVKe/RHKrqQQIA4=;
        b=PrDqHUojZw+QJ562s9TBG1oHOfyVrLFqRvTXel+Ywhqg/RStc/ryEMCv8O8Vph1V/G
         9IN2dNx8r3475akQWJrrtrLhMp0yd9mFwaWySQP8FfUyaahj/iDpn/aCt4Y8cwWvVmm5
         uLO4DO1KFsx8Ccngwj/grYnEEntycHHKpjpRX9LHtLiF2+c5b4rC87YuMklYHKvqstpS
         iNdpBdAG65p9AyuIea84l6MjpWLc5zxCmNH9ZtTtJku5ATtqqFbq7cQAavFxtHu9s3yn
         E9TkPKwDRIpFExi7t2bRTKOo4mv2UJxp+xVF3c4muqk/PXi+dRuKSl4jNvvzyN1+3i3q
         vI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzvd6kUzChxnq5SFRmBTmDPx+y+Rp+taPu7L+LD2lZK9JG5oess7suwRphLIUfcV7FsKJtZMg2fUwkJeKAHUD1OD9xxTh0sUlRGyaL
X-Gm-Message-State: AOJu0YzrmUAkijCbAHlxLBto4gAMhaFP39Dxc/zunpmxQusCWaT7JGXw
	MBLKtS3gpLCB01XqJq08+WwSZsJwy+21YZwcwySE1Z3WpXiH7aBRPVrBXWxjzwEsFgp1BUJ1DJ8
	ava2i1A==
X-Google-Smtp-Source: AGHT+IENPykPJ+lYwLhYDZrkRCjiJu/LKF/XH0zBwHTuIhUvYZXkVVo62zMFmXt5DvnCl0OVvczxHg==
X-Received: by 2002:a50:c346:0:b0:568:c6a2:f427 with SMTP id q6-20020a50c346000000b00568c6a2f427mr4569907edb.27.1713719928939;
        Sun, 21 Apr 2024 10:18:48 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id p8-20020a05640243c800b00571fad0647csm1349184edc.74.2024.04.21.10.18.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 10:18:48 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4702457ccbso405389966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 10:18:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAnU/Snn2xnw0KTUKGOx1ndZ9oM6BoHQJj+cTZFkKFRYv9qoSJ7P4A0+Dt2j5ePj1lIDKmFynlku9lK9fgHJb3BmBpTJn/5KOcYtnB
X-Received: by 2002:a17:906:f21a:b0:a55:88b9:dabd with SMTP id
 gt26-20020a170906f21a00b00a5588b9dabdmr4386645ejb.63.1713719927899; Sun, 21
 Apr 2024 10:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
 <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
 <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
 <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp> <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
In-Reply-To: <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Apr 2024 10:18:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+hJ9Y8AKjp9qD7E_-pgBFdWGLiqzi1qth8LNpuST1cA@mail.gmail.com>
Message-ID: <CAHk-=wg+hJ9Y8AKjp9qD7E_-pgBFdWGLiqzi1qth8LNpuST1cA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008c371006169e83f6"

--0000000000008c371006169e83f6
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Apr 2024 at 09:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The only option is to *mark* the ones that are atomic. Which was my suggestion.

Actually, another option would be to just return an error at 'set_ldisc()' time.

Sadly, the actual "tty->ops->set_ldisc()" function not only returns
'void' (easy enough to change - there aren't that many of them), but
it's called too late after the old ldisc has already been dropped.
It's basically a "inform tty about new ldisc" and is not useful for a
"is this ok"?

But we could trivially add a "ldisc_ok()" function, and have the vt
driver say "I only accept N_TTY".

Something like this ENTIRELY UNTESTED patch.

Again - this is untested, and maybe there are other tty drivers that
have issues with the stranger line disciplines, but this at least
seems simple and fairly easy to explain why we do what we do..

And if pty's really need the same thing, that would be easy to add.
But I actually think that at least pty slaves should *not* limit
ldiscs, because the whole point of a pty slave is to look like another
tty. If you want to emulate a serial device over a network, the way to
do it would be with a pty.

Hmm?

                Linus

--0000000000008c371006169e83f6
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lv9siqw80>
X-Attachment-Id: f_lv9siqw80

IGRyaXZlcnMvdHR5L3R0eV9sZGlzYy5jICAgIHwgIDYgKysrKysrCiBkcml2ZXJzL3R0eS92dC92
dC5jICAgICAgICB8IDEwICsrKysrKysrKysKIGluY2x1ZGUvbGludXgvdHR5X2RyaXZlci5oIHwg
IDggKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3R0eV9sZGlzYy5jIGIvZHJpdmVycy90dHkvdHR5X2xkaXNjLmMKaW5k
ZXggM2Y2OGUyMTNkZjFmLi5kODBlOWQ0Yzk3NGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3R0
eV9sZGlzYy5jCisrKyBiL2RyaXZlcnMvdHR5L3R0eV9sZGlzYy5jCkBAIC01NDUsNiArNTQ1LDEy
IEBAIGludCB0dHlfc2V0X2xkaXNjKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGludCBkaXNjKQog
CQlnb3RvIG91dDsKIAl9CiAKKwlpZiAodHR5LT5vcHMtPmxkaXNjX29rKSB7CisJCXJldHZhbCA9
IHR0eS0+b3BzLT5sZGlzY19vayh0dHksIGRpc2MpOworCQlpZiAocmV0dmFsKQorCQkJZ290byBv
dXQ7CisJfQorCiAJb2xkX2xkaXNjID0gdHR5LT5sZGlzYzsKIAogCS8qIFNodXRkb3duIHRoZSBv
bGQgZGlzY2lwbGluZS4gKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Z0L3Z0LmMgYi9kcml2
ZXJzL3R0eS92dC92dC5jCmluZGV4IDliNWI5OGRmYzhiNC4uY2Q4N2UzZDEyOTFlIDEwMDY0NAot
LS0gYS9kcml2ZXJzL3R0eS92dC92dC5jCisrKyBiL2RyaXZlcnMvdHR5L3Z0L3Z0LmMKQEAgLTM1
NzYsNiArMzU3NiwxNSBAQCBzdGF0aWMgdm9pZCBjb25fY2xlYW51cChzdHJ1Y3QgdHR5X3N0cnVj
dCAqdHR5KQogCXR0eV9wb3J0X3B1dCgmdmMtPnBvcnQpOwogfQogCisvKgorICogV2UgY2FuJ3Qg
ZGVhbCB3aXRoIGFueXRoaW5nIGJ1dCB0aGUgTl9UVFkgbGRpc2MsCisgKiBiZWNhdXNlIHdlIGNh
biBzbGVlcCBpbiBvdXIgd3JpdGUoKSByb3V0aW5lLgorICovCitzdGF0aWMgaW50IGNvbl9sZGlz
Y19vayhzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBpbnQgbGRpc2MpCit7CisJcmV0dXJuIGxkaXNj
ID09IE5fVFRZID8gMCA6IC1FSU5WQUw7Cit9CisKIHN0YXRpYyBpbnQgZGVmYXVsdF9jb2xvciAg
ICAgICAgICAgPSA3OyAvKiB3aGl0ZSAqLwogc3RhdGljIGludCBkZWZhdWx0X2l0YWxpY19jb2xv
ciAgICA9IDI7IC8vIGdyZWVuIChBU0NJSSkKIHN0YXRpYyBpbnQgZGVmYXVsdF91bmRlcmxpbmVf
Y29sb3IgPSAzOyAvLyBjeWFuIChBU0NJSSkKQEAgLTM2OTUsNiArMzcwNCw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgdHR5X29wZXJhdGlvbnMgY29uX29wcyA9IHsKIAkucmVzaXplID0gdnRfcmVz
aXplLAogCS5zaHV0ZG93biA9IGNvbl9zaHV0ZG93biwKIAkuY2xlYW51cCA9IGNvbl9jbGVhbnVw
LAorCS5sZGlzY19vayA9IGNvbl9sZGlzY19vaywKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2RldiB2
YzBfY2RldjsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdHR5X2RyaXZlci5oIGIvaW5jbHVk
ZS9saW51eC90dHlfZHJpdmVyLmgKaW5kZXggNzM3MjEyNGZiZjkwLi5kZDRiMzFjZTZkNWQgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdHR5X2RyaXZlci5oCisrKyBiL2luY2x1ZGUvbGludXgv
dHR5X2RyaXZlci5oCkBAIC0xNTQsNiArMTU0LDEzIEBAIHN0cnVjdCBzZXJpYWxfc3RydWN0Owog
ICoKICAqCU9wdGlvbmFsLiBDYWxsZWQgdW5kZXIgdGhlIEB0dHktPnRlcm1pb3NfcndzZW0uIE1h
eSBzbGVlcC4KICAqCisgKiBAbGRpc2Nfb2s6IGBgaW50ICgpKHN0cnVjdCB0dHlfc3RydWN0ICp0
dHksIGludCBsZGlzYylgYAorICoKKyAqCVRoaXMgcm91dGluZSBhbGxvd3MgdGhlIEB0dHkgZHJp
dmVyIHRvIGRlY2lkZSBpZiBpdCBjYW4gZGVhbAorICoJd2l0aCBhIHBhcnRpY3VsYXIgQGxkaXNj
LgorICoKKyAqCU9wdGlvbmFsLiBDYWxsZWQgdW5kZXIgdGhlIEB0dHktPmxkaXNjX3NlbSBhbmQg
QHR0eS0+dGVybWlvc19yd3NlbS4KKyAqCiAgKiBAc2V0X2xkaXNjOiBgYHZvaWQgKCkoc3RydWN0
IHR0eV9zdHJ1Y3QgKnR0eSlgYAogICoKICAqCVRoaXMgcm91dGluZSBhbGxvd3MgdGhlIEB0dHkg
ZHJpdmVyIHRvIGJlIG5vdGlmaWVkIHdoZW4gdGhlIGRldmljZSdzCkBAIC0zNzIsNiArMzc5LDcg
QEAgc3RydWN0IHR0eV9vcGVyYXRpb25zIHsKIAl2b2lkICgqaGFuZ3VwKShzdHJ1Y3QgdHR5X3N0
cnVjdCAqdHR5KTsKIAlpbnQgKCpicmVha19jdGwpKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGlu
dCBzdGF0ZSk7CiAJdm9pZCAoKmZsdXNoX2J1ZmZlcikoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSk7
CisJaW50ICgqbGRpc2Nfb2spKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGludCBsZGlzYyk7CiAJ
dm9pZCAoKnNldF9sZGlzYykoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSk7CiAJdm9pZCAoKndhaXRf
dW50aWxfc2VudCkoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgaW50IHRpbWVvdXQpOwogCXZvaWQg
KCpzZW5kX3hjaGFyKShzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCB1OCBjaCk7Cg==
--0000000000008c371006169e83f6--

