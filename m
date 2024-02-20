Return-Path: <linux-kernel+bounces-73751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDBB85CA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85322B2211D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E7152E05;
	Tue, 20 Feb 2024 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TYZa+R7U"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16923152DF8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467133; cv=none; b=QbzMoYSgL4z2Y3XXcNT/Sh4PfHjQt8Ke06YE7KDCAnOvnPKMy9p5cwerOpdHAvLAUgRQQnXZKqRbHFQoqQuWUCrMG79vbdTrVAnFAPGxFlmh50z9O4jjbFiTeuqV+3aeU1l+kpLFj+Kl2QaQPJOzQ7oiw7RTE5Jk4v/eBZ+1AYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467133; c=relaxed/simple;
	bh=LUbJlvJuIV7XYM0rbCvTM0VLK0c4K1LguGjYBMqYRAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJCWHc38G+eRMu6IPBVOW06jWOOvhVl98usf/OEHJWmyeliKVr2TKvOpFXPXrEobLRAD005uyD3qlUQ2PbZaVy7WmdwMRPce5FnOyCdHwp64/zMTN+OlyQu5s2WbFdDcjWpXQhiLRRFYG7kpJ9U54GD8kHIU003oqEn1flX6xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TYZa+R7U; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512b84bdaf1so3221618e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708467130; x=1709071930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRo/+/dQVV/a/ImMPl3aMRQaGyZPvODzniivdVj3xis=;
        b=TYZa+R7U0MyTU+kK9fQGfUicHJXN6SDOuSvyU3Y5vFCcb6Nw7T/Q7obtVT5CaJBfO4
         4mqto7xAmGJdjs8yQPcLDzWysDIQ9IMyFQVQALWoW/NsKpRdvmGn9sFSHzuM2/XF4a85
         p82HH8uuzNZXPNXgcDmvwkZgy4NjBBe1AhwwV49PYKk+C1cADpyUf8/03yY89xQhgth/
         HoVNc1RxH9VokglN5c5wLpFTVaMx5B9s55ziFyU8cJEaUkPeeusyA1R9wXYXPFA6uB85
         kLku5fhSsvhhiHOIs/PFm9oUc8igE5uk7c9cjKnZHvAInoDWWUALpLspeBZQddDOIYcJ
         QYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467130; x=1709071930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRo/+/dQVV/a/ImMPl3aMRQaGyZPvODzniivdVj3xis=;
        b=taVgz/KMSx0y4Ju+xyNPYE3jlPdivn379uiUBWWePLdxWjmo0flid2eMG6q9ZMveOE
         ffoneGJOwa2TRrfQBXYgx2NhQmnjP5KtD5YueZC3MizFVwCMMbxgp5ym1Q0ZyhVJNF/4
         8u7yUb0YBAgKL7lXFwLIGbAbd8T7BtQ4/gv4gde8ExI4n4sajWKoKwYF+Nhtxy4e59S3
         eRV5XXtF1GKy1x4yiOS+xhGzCYbEwYO0jDwIJdvlun5HhrVo9vFhTEsx7tqo9vCTtWJF
         Ob3ocBfwd9tn/xhYqfkF9tjtQoPigXJun4NkEer+J9VE8K+C3fGQROcAV+vXyegpLkCV
         1gpw==
X-Forwarded-Encrypted: i=1; AJvYcCVPB7zWHmfjb3+Yn4I9kPJoN6ZAC/+Z0nM/BDpUIQkcbddgQ/DEtM7GbEIs5wQxkNSHQRsPbkWth3ztnb1cFO6UB4Pwcwmb5Sym5t0M
X-Gm-Message-State: AOJu0YxEhCfR+EPIv9aiOwku8iPH/aGJzZ39EDmvmQUA4hCkwVfvE1QA
	pkKvEK6pCN4exTvL9Gn//PHUAQcBN1qnuMSL71q4AfeRgxgay14jseO84K4ZDOdzy6kBrngFUTA
	TKAoeHgisdmkCRTy0i06+x0K+yfp0MsYD4DANUqLwiCca5WDW
X-Google-Smtp-Source: AGHT+IF41cHVf8ZA8jWjXcqW2BbWtC3Rb1Ku6snBa4xpJmFc8WxJcGwU0ffhbradvu2yDnKUnM01mRzJI37t9np6kYY=
X-Received: by 2002:a05:6512:159c:b0:512:ca2f:4b2 with SMTP id
 bp28-20020a056512159c00b00512ca2f04b2mr2540948lfb.44.1708467130344; Tue, 20
 Feb 2024 14:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <ZctnfZWWO3HCiXe5@andrea> <87msrwfxpa.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msrwfxpa.fsf@all.your.base.are.belong.to.us>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 20 Feb 2024 23:11:54 +0100
Message-ID: <CAHVXubjdpFER1v54dAD-Bg=Ya4NkDxn=v+9bug0Xng2Ta=Nz8Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] riscv: Various text patching improvements
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 1:25=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Andrea Parri <parri.andrea@gmail.com> writes:
>
> > Hi Samuel,
> >
> > On Sun, Feb 11, 2024 at 06:55:11PM -0800, Samuel Holland wrote:
> >> Here are a few changes to minimize calls to stop_machine() and
> >> flush_icache_*() in the various text patching functions, as well as
> >> to simplify the code.
> >>
> >>
> >> Samuel Holland (7):
> >>   riscv: jump_label: Batch icache maintenance
> >>   riscv: jump_label: Simplify assembly syntax
> >>   riscv: kprobes: Use patch_text_nosync() for insn slots
> >>   riscv: Simplify text patching loops
> >>   riscv: Pass patch_text() the length in bytes
> >>   riscv: Use offset_in_page() in text patching functions
> >>   riscv: Remove extra variable in patch_text_nosync()
> >
> > This does look like a nice clean-up.  Just curious (a "teach me"-like q=
uestion),
> > how did you test these changes? kselftests, micro-benchmarks, other?
> >
> > BTW, I recall a parallel work from Alex and Bjorn [1] that might have s=
ome minor
> > conflict with these changes; + both of them to Cc: for further sync.
>
> Indeed! I think Alex is still working on the v2.

Actually I was blocked by Andrea's comment about patch_map(), but it's
not related so I can spin another version soon. I'd say mine should
land first because AIA support may get into 6.9 (?) and then this
patch would be needed. In case you re-spin another version, can you
rebase on top of it? Unless you have another solution of course.

Thanks,

Alex

