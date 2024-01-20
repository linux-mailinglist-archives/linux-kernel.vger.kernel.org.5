Return-Path: <linux-kernel+bounces-31731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B5833315
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA6D1F2251D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DF2101;
	Sat, 20 Jan 2024 07:21:15 +0000 (UTC)
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAA1FD8;
	Sat, 20 Jan 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705735274; cv=none; b=PhGZ8RrnflpQEiN4pCuqegCm6uftAGaWHkuTQKvmmPq/Ju6gDDVU3cp+onUA5fScAZuLJ2gvqY+9LxriMJpSxMdMK3TydJmYv/2xG820CEGPf9rUZjPRzk2Yxw8v1gYamM8rD5bFT3itJQfLe+tj7DZHC8E6csF/Inw7ou+VTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705735274; c=relaxed/simple;
	bh=AUtMTHlxtutjYSVB+7qK1W4n0GnyCXxkh/HEIBxUCKg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P7Jq3N24luuQfkryNTVnmgao6/o7ZH431IzXyk5Ctdks1bRJ2gUJIr0fuVpho0eQrWGI7SNN+BVS8kXJzJCeXrxc6jolSk5Fx+SouVzwOA+7J2SRxLXqnru09M3UF0RQVeA2tenradpodFRVENqM4/t87cIhFc9n7LlCNuRDQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40K6wuil000662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Jan 2024 06:59:05 GMT
Date: Sat, 20 Jan 2024 06:58:56 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Peter Zijlstra <peterz@infradead.org>
cc: x86@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
In-Reply-To: <20210312115749.065275711@infradead.org>
Message-ID: <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Peter Zijlstra dixit:

>-/* generic versions from gas
[=E2=80=A6]
>-   3: leal 0x00(%esi),%esi
>-   4: leal 0x00(,%esi,1),%esi
>-   6: leal 0x00000000(%esi),%esi
>-   7: leal 0x00000000(,%esi,1),%esi

vs.

>+ * Generic 32bit nops from GAS:
[=E2=80=A6]
>+ * 3: leal 0x0(%esi),%esi
>+ * 4: leal 0x0(%esi,%eiz,1),%esi
>+ * 5: leal %ds:0x0(%esi,%eiz,1),%esi
>+ * 6: leal 0x0(%esi),%esi
>+ * 7: leal 0x0(%esi,%eiz,1),%esi
>+ * 8: leal %ds:0x0(%esi,%eiz,1),%esi

I think there=E2=80=99s some mistake introduced. The BYTES_* are
identical for e.g. #7, but %eiz must be wrong, it=E2=80=99s not
a register. Indeed, gas (on Debian bullseye) does not
assemble that either.

(Awful AT&T syntax aside=E2=80=A6)

bye,
//mirabilos
--=20
=E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.=E2=80=9C
=09-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every system=
=2E=E2=80=9D)

