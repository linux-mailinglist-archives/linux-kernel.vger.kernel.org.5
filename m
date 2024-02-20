Return-Path: <linux-kernel+bounces-73629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C697485C54B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0B91F2183D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0214AD14;
	Tue, 20 Feb 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VSYrDd9P"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D614A0BF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459066; cv=none; b=axfcl1LEaDvymGHcSqiXhLTlVVHUd3YH6P9AZcpzlcoXesg/lm9tvgeQzLbd0RRbLeB2P2SPkXGQNb/P9e6chLF4oQwAuTjwsuq7U1keJqthGliXJYEkDEKXFJGEANzxlF9VPOCR2xvbvSe9rOKYsW6sgDkv4sAGNMWM2lE67eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459066; c=relaxed/simple;
	bh=Le8hcsec8oPnFJ48wZNId+Ds0IV1319YVdFwWsrifNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aK77AEdT7lADY4lOce6GY0/Ssb5MsTQt9W0s96f0GpheHChx8Cs4kG2+saK1upDBorPYxXzuExxno2L5MoGFICltvV1bnht+pOLouiN6rhbak87ev5hdVlY1vtolgC9JJb1xEuWZ1SrxiouoPHCwNJjWHyUzy2VmAn/Azk0Tt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VSYrDd9P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512be6fda52so2491452e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708459061; x=1709063861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tM3zSryKInLuLsr7URVNSkPqzm4t0QBdTylJ1borGg=;
        b=VSYrDd9P136WqSxCoG8xjt9J+gWE5IpQfzTEAflMLYRdQ3mjt0d+J7MKqRxzrSofn7
         MopKve8MyKKN1/MN7yS7cBb4iUPFzhimq2/lxzl01Qa+q/9bwRXOEMs8k627gi2slk5N
         16R2YgoRzzMKAoCdxNhJgCv9qLfs0RSKD5vNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708459061; x=1709063861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tM3zSryKInLuLsr7URVNSkPqzm4t0QBdTylJ1borGg=;
        b=FuW96u9dg1nlPEpAMdNoHgOXxIFaiyEoeuPma6sF2wKpLUWJhrISorWOXMCiF4tz2y
         u+mDOumrmdil1DkiFz44RBSq4vcCHDjFz9WV03R4ASVk7JBMoqY2B0gW02wM/uXgFtkw
         t2OkwHNzL6UIWf7/Nd+KJfMlgLtc8mmGU0nCX0pUEdttGEScjFCOm4HHgR4xYuXy3VP4
         flkx3ty9NgiXJPHG5rgyCQMLTkMna5lvcirKswjkb/un9gL7jGUHcgV9x3wdYJ6lkgkd
         TpoFKH4KI97LA8x82EYK9Sj30yNyC7vWV1drXa8t/s7UPVZFmrwPkuAZJcQMfmDdC10K
         bgNQ==
X-Gm-Message-State: AOJu0YxSjiM7LAgb0lI3DGzmDg6FE6R1E+Cf/UfHzObtRmyVCpd5eecr
	5L82tgkgpmcBalBCL+kSSppzUX08MGkKCDor4XJfLCH7TVlxJNQVM8+72afD7YopUSqhtcxyI3/
	+B3Uj3w==
X-Google-Smtp-Source: AGHT+IE/mJmzn2VTE79RYdor65bITbn6S70eySmMLTuglsyuk0hJOhNq71dpwWKtl9t53FGu9AK7bw==
X-Received: by 2002:a05:6512:4027:b0:512:b00f:a55d with SMTP id br39-20020a056512402700b00512b00fa55dmr6051096lfb.30.1708459061436;
        Tue, 20 Feb 2024 11:57:41 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651236c800b0051296788949sm1387622lfs.232.2024.02.20.11.57.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 11:57:40 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512be6fda52so2491406e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:57:40 -0800 (PST)
X-Received: by 2002:a05:6512:4027:b0:512:b00f:a55d with SMTP id
 br39-20020a056512402700b00512b00fa55dmr6051068lfb.30.1708459059910; Tue, 20
 Feb 2024 11:57:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net>
In-Reply-To: <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2024 11:57:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
Message-ID: <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
Subject: Re: Linux 6.8-rc5
To: Guenter Roeck <linux@roeck-us.net>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000062498a0611d59ff3"

--00000000000062498a0611d59ff3
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 11:09, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 155 pass: 151 fail: 4
> Failed builds:
>         csky:allmodconfig
>         openrisc:allmodconfig
>         parisc:allmodconfig
>         xtensa:allmodconfig
> Qemu test results:
>         total: 549 pass: 547 fail: 2

Grr, I was hoping things would improve, not go backwards.

> ERROR: modpost: "__umoddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
> ERROR: modpost: "__moddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
>
> Commit a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test"):
>
> +       u64 mm_size, ps = SZ_4K, i, n_pages, total;
> ...
> +       n_pages = mm_size / ps;

WTF? This code isn't lovely, but the build error indicates a complete
lack of compiler optimizations.

As far as I can tell, 'ps' is never modified, so the compiler should
be able to just treat it as a constant.

And 'mm_size' is a constant too in this context. It's a local variable
assigned once, with a compile-time constant value.

So that

        n_pages = mm_size / ps;

should be a constant value too (and that value should be 48).

Now, the __moddi3() is a *bit* more reasonable, because I assume it comes from

                int slot = i % 3;

where 'i' is marked as u64 too. For no good reason (it goes from 0 to
47), but it too does show a certain lack of basic optimizations (but
now it's at least a slightly more *complex* optimization because it
depends on the whole value range propagation).

None of this should be 'u64'. Even if the compiler has been unusually stupid.

The 'total' variable could possibly be considered validly be u64,
although even that is very very questinable.

> This patch breaks the build on all 32-bit systems since it introduces an
> unhandled direct 64-bit divide operation.

It turns out that that commit is buggy for another reason, but it's
hidden by the fact that apparently KUNIT_ASSERT_FALSE_MSG() doesn't
check the format string.

It randomly uses '%d' or '%llu' to print out various variations of
'ps'. All garbage.

Yes, yes, drm_buddy_init() takes u64 arguments. That in itself is a
bit questionable, but whatever. It does *NOT* mean that the variables
that don't need it should then be u64.

Suggested untested patch attached.

                  Linus

--00000000000062498a0611d59ff3
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lsusecpv0>
X-Attachment-Id: f_lsusecpv0

IGRyaXZlcnMvZ3B1L2RybS90ZXN0cy9kcm1fYnVkZHlfdGVzdC5jIHwgMTkgKysrKysrKysrLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9idWRkeV90ZXN0LmMgYi9k
cml2ZXJzL2dwdS9kcm0vdGVzdHMvZHJtX2J1ZGR5X3Rlc3QuYwppbmRleCBmZWU2YmVjNzU3ZDEu
LjNkYmZhMzA3ODQ0OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9idWRk
eV90ZXN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9idWRkeV90ZXN0LmMKQEAg
LTIxLDcgKzIxLDggQEAgc3RhdGljIGlubGluZSB1NjQgZ2V0X3NpemUoaW50IG9yZGVyLCB1NjQg
Y2h1bmtfc2l6ZSkKIAogc3RhdGljIHZvaWQgZHJtX3Rlc3RfYnVkZHlfYWxsb2NfY29udGlndW91
cyhzdHJ1Y3Qga3VuaXQgKnRlc3QpCiB7Ci0JdTY0IG1tX3NpemUsIHBzID0gU1pfNEssIGksIG5f
cGFnZXMsIHRvdGFsOworCWNvbnN0IHVuc2lnbmVkIGxvbmcgcHMgPSBTWl80SywgbW1fc2l6ZSA9
IDE2ICogMyAqIFNaXzRLOworCXVuc2lnbmVkIGxvbmcgaSwgbl9wYWdlcywgdG90YWw7CiAJc3Ry
dWN0IGRybV9idWRkeV9ibG9jayAqYmxvY2s7CiAJc3RydWN0IGRybV9idWRkeSBtbTsKIAlMSVNU
X0hFQUQobGVmdCk7CkBAIC0yOSw4ICszMCw2IEBAIHN0YXRpYyB2b2lkIGRybV90ZXN0X2J1ZGR5
X2FsbG9jX2NvbnRpZ3VvdXMoc3RydWN0IGt1bml0ICp0ZXN0KQogCUxJU1RfSEVBRChyaWdodCk7
CiAJTElTVF9IRUFEKGFsbG9jYXRlZCk7CiAKLQltbV9zaXplID0gMTYgKiAzICogU1pfNEs7Ci0K
IAlLVU5JVF9FWFBFQ1RfRkFMU0UodGVzdCwgZHJtX2J1ZGR5X2luaXQoJm1tLCBtbV9zaXplLCBw
cykpOwogCiAJLyoKQEAgLTU2LDMwICs1NSwzMCBAQCBzdGF0aWMgdm9pZCBkcm1fdGVzdF9idWRk
eV9hbGxvY19jb250aWd1b3VzKHN0cnVjdCBrdW5pdCAqdGVzdCkKIAkJS1VOSVRfQVNTRVJUX0ZB
TFNFX01TRyh0ZXN0LAogCQkJCSAgICAgICBkcm1fYnVkZHlfYWxsb2NfYmxvY2tzKCZtbSwgMCwg
bW1fc2l6ZSwKIAkJCQkJCQkgICAgICBwcywgcHMsIGxpc3QsIDApLAotCQkJCSAgICAgICAiYnVk
ZHlfYWxsb2MgaGl0IGFuIGVycm9yIHNpemU9JWRcbiIsCisJCQkJICAgICAgICJidWRkeV9hbGxv
YyBoaXQgYW4gZXJyb3Igc2l6ZT0lbHVcbiIsCiAJCQkJICAgICAgIHBzKTsKIAl9IHdoaWxlICgr
K2kgPCBuX3BhZ2VzKTsKIAogCUtVTklUX0FTU0VSVF9UUlVFX01TRyh0ZXN0LCBkcm1fYnVkZHlf
YWxsb2NfYmxvY2tzKCZtbSwgMCwgbW1fc2l6ZSwKIAkJCQkJCQkgICAzICogcHMsIHBzLCAmYWxs
b2NhdGVkLAogCQkJCQkJCSAgIERSTV9CVUREWV9DT05USUdVT1VTX0FMTE9DQVRJT04pLAotCQkJ
ICAgICAgICJidWRkeV9hbGxvYyBkaWRuJ3QgZXJyb3Igc2l6ZT0lZFxuIiwgMyAqIHBzKTsKKwkJ
CSAgICAgICAiYnVkZHlfYWxsb2MgZGlkbid0IGVycm9yIHNpemU9JWx1XG4iLCAzICogcHMpOwog
CiAJZHJtX2J1ZGR5X2ZyZWVfbGlzdCgmbW0sICZtaWRkbGUpOwogCUtVTklUX0FTU0VSVF9UUlVF
X01TRyh0ZXN0LCBkcm1fYnVkZHlfYWxsb2NfYmxvY2tzKCZtbSwgMCwgbW1fc2l6ZSwKIAkJCQkJ
CQkgICAzICogcHMsIHBzLCAmYWxsb2NhdGVkLAogCQkJCQkJCSAgIERSTV9CVUREWV9DT05USUdV
T1VTX0FMTE9DQVRJT04pLAotCQkJICAgICAgICJidWRkeV9hbGxvYyBkaWRuJ3QgZXJyb3Igc2l6
ZT0lbGx1XG4iLCAzICogcHMpOworCQkJICAgICAgICJidWRkeV9hbGxvYyBkaWRuJ3QgZXJyb3Ig
c2l6ZT0lbHVcbiIsIDMgKiBwcyk7CiAJS1VOSVRfQVNTRVJUX1RSVUVfTVNHKHRlc3QsIGRybV9i
dWRkeV9hbGxvY19ibG9ja3MoJm1tLCAwLCBtbV9zaXplLAogCQkJCQkJCSAgIDIgKiBwcywgcHMs
ICZhbGxvY2F0ZWQsCiAJCQkJCQkJICAgRFJNX0JVRERZX0NPTlRJR1VPVVNfQUxMT0NBVElPTiks
Ci0JCQkgICAgICAgImJ1ZGR5X2FsbG9jIGRpZG4ndCBlcnJvciBzaXplPSVsbHVcbiIsIDIgKiBw
cyk7CisJCQkgICAgICAgImJ1ZGR5X2FsbG9jIGRpZG4ndCBlcnJvciBzaXplPSVsdVxuIiwgMiAq
IHBzKTsKIAogCWRybV9idWRkeV9mcmVlX2xpc3QoJm1tLCAmcmlnaHQpOwogCUtVTklUX0FTU0VS
VF9UUlVFX01TRyh0ZXN0LCBkcm1fYnVkZHlfYWxsb2NfYmxvY2tzKCZtbSwgMCwgbW1fc2l6ZSwK
IAkJCQkJCQkgICAzICogcHMsIHBzLCAmYWxsb2NhdGVkLAogCQkJCQkJCSAgIERSTV9CVUREWV9D
T05USUdVT1VTX0FMTE9DQVRJT04pLAotCQkJICAgICAgICJidWRkeV9hbGxvYyBkaWRuJ3QgZXJy
b3Igc2l6ZT0lbGx1XG4iLCAzICogcHMpOworCQkJICAgICAgICJidWRkeV9hbGxvYyBkaWRuJ3Qg
ZXJyb3Igc2l6ZT0lbHVcbiIsIDMgKiBwcyk7CiAJLyoKIAkgKiBBdCB0aGlzIHBvaW50IHdlIHNo
b3VsZCBoYXZlIGVub3VnaCBjb250aWd1b3VzIHNwYWNlIGZvciAyIGJsb2NrcywKIAkgKiBob3dl
dmVyIHRoZXkgYXJlIG5ldmVyIGJ1ZGRpZXMgKHNpbmNlIHdlIGZyZWVkIG1pZGRsZSBhbmQgcmln
aHQpIHNvCkBAIC04OCwxMyArODcsMTMgQEAgc3RhdGljIHZvaWQgZHJtX3Rlc3RfYnVkZHlfYWxs
b2NfY29udGlndW91cyhzdHJ1Y3Qga3VuaXQgKnRlc3QpCiAJS1VOSVRfQVNTRVJUX0ZBTFNFX01T
Ryh0ZXN0LCBkcm1fYnVkZHlfYWxsb2NfYmxvY2tzKCZtbSwgMCwgbW1fc2l6ZSwKIAkJCQkJCQkg
ICAgMiAqIHBzLCBwcywgJmFsbG9jYXRlZCwKIAkJCQkJCQkgICAgRFJNX0JVRERZX0NPTlRJR1VP
VVNfQUxMT0NBVElPTiksCi0JCQkgICAgICAgImJ1ZGR5X2FsbG9jIGhpdCBhbiBlcnJvciBzaXpl
PSVkXG4iLCAyICogcHMpOworCQkJICAgICAgICJidWRkeV9hbGxvYyBoaXQgYW4gZXJyb3Igc2l6
ZT0lbHVcbiIsIDIgKiBwcyk7CiAKIAlkcm1fYnVkZHlfZnJlZV9saXN0KCZtbSwgJmxlZnQpOwog
CUtVTklUX0FTU0VSVF9GQUxTRV9NU0codGVzdCwgZHJtX2J1ZGR5X2FsbG9jX2Jsb2NrcygmbW0s
IDAsIG1tX3NpemUsCiAJCQkJCQkJICAgIDMgKiBwcywgcHMsICZhbGxvY2F0ZWQsCiAJCQkJCQkJ
ICAgIERSTV9CVUREWV9DT05USUdVT1VTX0FMTE9DQVRJT04pLAotCQkJICAgICAgICJidWRkeV9h
bGxvYyBoaXQgYW4gZXJyb3Igc2l6ZT0lZFxuIiwgMyAqIHBzKTsKKwkJCSAgICAgICAiYnVkZHlf
YWxsb2MgaGl0IGFuIGVycm9yIHNpemU9JWx1XG4iLCAzICogcHMpOwogCiAJdG90YWwgPSAwOwog
CWxpc3RfZm9yX2VhY2hfZW50cnkoYmxvY2ssICZhbGxvY2F0ZWQsIGxpbmspCg==
--00000000000062498a0611d59ff3--

