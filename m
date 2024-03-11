Return-Path: <linux-kernel+bounces-99135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AA8783D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71943B224C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366F446D2;
	Mon, 11 Mar 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3GvtHSq"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593244371
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171210; cv=none; b=oEizwVdN/VfhnEbwQYUKDtlwnZHrBkFKUHPu9+RE1nIIrrBQ2xquGPHJ+rPYm5CRBjiNFQRhoUDJhwcovhRewLuvwIS1U9IZdqYJekvxmIkD34i5+ibYjBuwkmC4fpcVNzAKGDCbMOds6shKDSdhJqj6w7PHLrwLIQOaTr4DPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171210; c=relaxed/simple;
	bh=BgmEJ3rVgpfdYftpb1oT1hFKBsa+dHuEMI7KFS3YKKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZDhe3tp+ixK6ZSVM3Fl6HGoAmlwdShQhOP0sAPG1/HRstDc5kwePdbxiYaHo1Vw8Kr8PiMviKjT578rkRLGYgNd6PFeNwcHjHaTT8Tdsu8Z4zipOeC/sKupTGOzTAV41MJS7uT1qAq7FNlFmg9jwqg0zkiB+JN0A5QtLSPZFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3GvtHSq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e784060cso32258455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710171206; x=1710776006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgmEJ3rVgpfdYftpb1oT1hFKBsa+dHuEMI7KFS3YKKE=;
        b=x3GvtHSq0o7fqG7Js8UBDYyiGGmbvocSiat9Ce2dQlflT25D8h7ggz6S8+gASAuM0B
         ZcNxW7gGUOVAHN4yMSq63y+F16QTnDP3FUccCaH8FkRj/LeOysSud83iQawkCcPam07W
         9pfrThKEf4kFIKs8T5RoOYGkxT9TGmyp0FgeYQkCH/VilTVBUVi141DcdPWk/VbqOBCP
         mBtTfCXbvdRmTTgLT1xqdMQAN2KBxsgdLgQ5GfZHFCou5QYOaupFMGHF7m14yhvyw4XD
         mQG1UJm9T1tbfyRqvnecr48HAYdNZPG2tsPlOAd3NOT+NlM/F6RtR56tpLp1wZzvUFYz
         FvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171206; x=1710776006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgmEJ3rVgpfdYftpb1oT1hFKBsa+dHuEMI7KFS3YKKE=;
        b=LT4xqxJCeXaLq5ffmiyz4+Qg4nR/7A6zmc7brQu/xOztDRr9G1cczkD+voI6JpzP/N
         vIRx0FwGwC43/+yP2KHqnJoVdLDZa+WZ51A+qq6X/Ei7yqXmQbhzzuYxsTL0W0IJL48W
         YiSMheJmlgomWgs2g+HsA8IsM4obvCGRbrOplAzM/c1etwR2h+K7JyngcRLg1LrIqHa1
         U/aNcE7ieOCWqpKLSmadkP4pcd1pZbBfzbUq0rqtRWUEEXPI5T1fc+Z5WhIuHfUX0laq
         Ui+SXJTST7feRv068K/qW0fo5Js172QScwp3Ox9hYV92M/5S4Q8+G2k4+z6SkhvmPXwt
         YDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTCt5oncRvtM79Br4niZ0QrgOvpx5SeX5QuF954dLkwiaeVp1jmm5Fyky9alSAit1g9TRChkIQEyGs2F8pUUzKiQk3oEBpCoATHmTt
X-Gm-Message-State: AOJu0Yw9lXc6Jml231wNqXIuf0KitGtqXTQFpwZKi6y1MWYM5hEvhTmd
	M2MdM0oHMvwBwOOLQS3RsHae1WzGELAqjm8/A4Lx3hbFuByDlASyYWOtHw3bOekY/oZXCNGWggb
	SsEg7D6HEkTAUPX3LYxCZzyjKwBOJUhtZJOaa
X-Google-Smtp-Source: AGHT+IE/th4Pg/GBs04QnTLC4gySgD/Ced3Hwsh9xlJGW37qnBqN80Ztb15KeaRy40uSPOSKwYSAYx2WXmVslFbnrPM=
X-Received: by 2002:a5d:6751:0:b0:33e:1f2b:8cc5 with SMTP id
 l17-20020a5d6751000000b0033e1f2b8cc5mr6816452wrw.0.1710171205375; Mon, 11 Mar
 2024 08:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-14-irogers@google.com>
 <CANiq72=rgXk6oz65wb57ZP+jmSoD-a4SSVzU6s6SZLubV3cvBw@mail.gmail.com>
In-Reply-To: <CANiq72=rgXk6oz65wb57ZP+jmSoD-a4SSVzU6s6SZLubV3cvBw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Mar 2024 08:33:10 -0700
Message-ID: <CAKwvOdkMYnYO2hyJEFj-M_iur6BneEZjPHvsodZAGw=b7PmmzA@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] tools headers: Rename noinline to __noinline
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@aculab.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Christopher Di Bella <cjdb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 4:25=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Mar 10, 2024 at 3:06=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > [1] https://clang.llvm.org/docs/AttributeReference.html#noinline
> > Reported-by: Christopher Di Bella <cjdb@google.com>
>
> Out of curiosity, was this due to the `[[gnu::noinline]]` or similar
> in e.g. `src/string/memset_explicit.h`?

Yes, and in src/__support/threads/linux/thread.cpp's definition of
start_thread().

Thanks for the patch!

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

--=20
Thanks,
~Nick Desaulniers

