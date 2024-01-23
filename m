Return-Path: <linux-kernel+bounces-34651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB48385BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C9B24E74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6B20E4;
	Tue, 23 Jan 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZpqN2Yw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E91FBE;
	Tue, 23 Jan 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978291; cv=none; b=TDtkeqvEF3P0h3SrY3wQ4XoufE1v92mfMVXmOa58ybgqNkdJx97t45+ITNbFPiIS2L4la21Fr7l594q4C90UHca3V1SrElyQa2Qolrsh6DKrhYmEmm6KNDRWELoON6Nqa8xnsC6R3UpYQX/0UVaD0w9qYMupFFxvvAuprwt5X6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978291; c=relaxed/simple;
	bh=wCFAGCdjL92EtlxtfRHKDG0JhlIQGFfhuL4KcJbBF7s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iY1l22pP86MEfM1s4GbTE209ryTTSD16CLHmPsJcCI/Gq9tq0uI28txVCMLxtQhu+cUxKcRhxDFFXskNdWjyFNq/su7qLbfZ7/gJBChev/8UPx8kbdZuLtb6Jq71oOaENgLt40hE+8afoFN6CHrMAJM3wlU87GE29UKTAnzP+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZpqN2Yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0C8C43390;
	Tue, 23 Jan 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705978291;
	bh=wCFAGCdjL92EtlxtfRHKDG0JhlIQGFfhuL4KcJbBF7s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KZpqN2YwaFhawn6OAzQ07gadVTQA7uH7DtXfJEgLrYrqobaOfXhUukReonuopvHEj
	 EdyDuEvSoE29JvwcRnq7KvGeGhmVNu8idXygYTd3GFnhEnA3fN3fSbrpZixpnBoqoI
	 AmWOqsZIunA7fj61+Y1cVW5GSaK+769XlLPthc1+GJXkn96hvG8Qv6fs/4BkYGdBQJ
	 fD2Tstf84JVngzAZ4VpAl60/dChtoOjOWCRZi2rF9vTdQFWtppRJJNTVNn+Vq3zySY
	 uwIFpkdBAXhZgWFLiSPR5gL3JM8LSZtQ/WPWsk0IU5GlMsf/LcQjwt3rvfTKoTsn9K
	 JoLsS4VL5QWEw==
Date: Mon, 22 Jan 2024 18:51:29 -0800
From: Kees Cook <kees@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Kees Cook <keescook@chromium.org>
CC: linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_00/82=5D_overflow=3A_Refacto?= =?US-ASCII?Q?r_open-coded_arithmetic_wrap-around?=
User-Agent: K-9 Mail for Android
In-Reply-To: <337u2jcp3s2vrvotj4jppgpr7zas5fod6k3mhe263ghpux7s5x@knz6eibm2jis>
References: <20240122235208.work.748-kees@kernel.org> <337u2jcp3s2vrvotj4jppgpr7zas5fod6k3mhe263ghpux7s5x@knz6eibm2jis>
Message-ID: <4DE92BD2-50FE-4634-ACF3-E0CC735EDAEB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 22, 2024 6:22:13 PM PST, Kent Overstreet <kent=2Eoverstreet@lin=
ux=2Edev> wrote:
>On Mon, Jan 22, 2024 at 04:26:35PM -0800, Kees Cook wrote:
>> In our continuing effort to eliminate root causes of flaws in the kerne=
l,
>> this series is the start to providing a way to have sensible coverage
>> for catching unexpected arithmetic wrap-around=2E
>>=20
>This all seems fine, but=2E=2E=2E Rust already has this at the type syste=
m
>level=2E=2E=2E=2E
>
>I know you're not one of the people bringing bickering into the Rust
>threads, so I'm wondering if perhaps your secret plan is to annoy the
>die hard "I want everything to be fast with razor blades everywhere" C
>programmers enough to finally get onboard the "let's just switch to a
>language with less razor wire" train=2E

I don't want to annoy anyone, but yeah, in the process of getting rid of d=
angerous stuff we do end up asking people to make changes they're not used =
to=2E I hope to make it as easy as possible, though=2E

I'm a big fan of Rust, but I know it's not going to happen over night; the=
re is a LOT of C code in Linux=2E :) I look at making the kernel safer by r=
emoving as many C foot-guns as possible=2E As we remove the ambiguities in =
C that lead to vulnerabilities, we'll eventually meet halfway with the new =
Rust code=2E

-Kees

--=20
Kees Cook

