Return-Path: <linux-kernel+bounces-58801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091ED84EBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A11285783
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1E4F882;
	Thu,  8 Feb 2024 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="EM8RDRPn"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288E50245;
	Thu,  8 Feb 2024 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433017; cv=none; b=AeCsWTjAoWwGkTOhR9sx3bzoRJiIVC5laYnwugarfcG94sDWy1w69xthHrBciIxMOiPWmdjy2HRhVETFXmJqwoU9y1bXnHG6uIAjF4pFJRwdSWm+cVnW9MgslUsARgwAmidGK9Y7X88c7XEVL71p91EQy3xRmiroVbSgXPOSBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433017; c=relaxed/simple;
	bh=0eQjwa9zvkiFOJuBX71aJOe+rSs/uQTgAJ1f49hA0Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN5esZGsN4SvPS9sQemF72uho1Zq6Z8SA3gpAwlX0soHFIVgQGKd1LxE60tk9dn0XooS7hIDmpRzNk6a0Fe6klJ3bfifjIzABQPfsyWy1KIn5H2Ur+64n6ok/mjhuzrUnq8cNSalc7ofze0JAzJvfEYWEp9SvJ/jdoPW6XEUyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=EM8RDRPn; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1707432984; x=1708037784; i=kernel@valentinobst.de;
	bh=0eQjwa9zvkiFOJuBX71aJOe+rSs/uQTgAJ1f49hA0Tw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=EM8RDRPn5nVlG3Q8CoNoc1RyRXXvlGTG1lXCJt00vFE8Ys9us6JjXMfn/Fnk7dwi
	 HZavgxOPqJgRGBEQ9BAGymlAOcrYXBvzpYwtsNrZSc3kE67D1pd1k91JUm/djg3Vk
	 SEXjhfEvMq9W19KqSCcnBnLX4XaPWZrPuQCKa4b4xivtFh0UNjRw40Gji2oJ+/ZAo
	 8ZBYuFZHhYT4f2COq/nofIxj1WAd6nudGCuxD1ucuRmubaJc4MgEvoVH36CT1jjvR
	 YOH2Z8KIt2LdtnYwV3TcBUp8xQXiHorZXNIlQYolbpWPromXOkPWh47KgDvZDNkIo
	 VM/nffRvHMZDW5XKVA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([217.149.163.107]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoNMu-1rEYtL3dwe-00opeV; Thu, 08 Feb 2024 23:56:24 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: a.hindborg@samsung.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	arnd@arndb.de,
	arve@android.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	cmllamas@google.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joel@joelfernandes.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maco@android.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	surenb@google.com,
	tkjos@android.com,
	viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v2 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
Date: Thu,  8 Feb 2024 23:56:08 +0100
Message-ID: <20240208225608.11987-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208-alice-mm-v2-2-d821250204a6@google.com>
References: <20240208-alice-mm-v2-2-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:vmiLC5pSr7/XxKjgOv06P8f8tm/G40jiKHheWjGEZiMLHB7Tg9W
 qYo+U9dL+JxVgMCz6r0OUYBMUuMgZlJ4yQUMjF9zV5xWROz8N5Qt4BRzxra23T+qNsR1xK4
 kjV0B2Ts0SRPag0xNpElaQ4Yn3SOyN8KPxaham1j/8ZUU/FdDuNRnXQHskl+ixfT/sceG/d
 bU1pv0GDitWHLKgDQE5Sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RvfhGNpkbug=;48u+x7VSak14HUhjLwhxBvAcG7I
 z7y7+0hdqTlwriOQGCtCPi5n2BWW/wbOlWy3c/PsuIeGmg+WsA/BIMJGsJNGrQEG3itItQ9H5
 nJcwwPVV5SCZkcczKWHOKMzTBBkfSHtrpIw9VQvcZT+FYGtN57zSBdDXF70Ip80fGmwdKUec6
 Y0aYSh45ytE+m88dCz8fZq9frNzgueBpS6tLSBgqutiem7qvcNAXJDrsjMGMFm7aLlb+eDwZI
 h1Kfl4uRjh10rzxXH1bvMxXJa5pyS2prQeT8ninZKMlVjdTBNZaWE8ZTO2A5GZjvpXPCortae
 rixYIVO74ZboC4OhH+B2QWHydPAIf2bAI3HNBV9WavKqwivu0TTv5lrXLf97obDIt43ThAJNF
 qYqgbHk6/bJRUR3CATIgNq2g7RKxPEEpLwDhgPOLVao51krqm1ak6ztlEzqgobtODRGNISnJ8
 FIWL6/CXkYYOKKsOQwZwQ5587pvjpDG+9Wm2+wr5pwWvvJTCsb5MOOlImch82S+mBrMLAB9fv
 53UPo1EexuLs8OxZVJzJ+x5wd/1K9zpx692zUL4Wvn2FH5t9bKMf/wj6pj2vcTrLZYDFlmxwj
 AZiIfi7KEzgQ2CJoMt8hueBND86OrRhwA5UtnCScGMNyxZFKC+0UrvvUmMqmV42V45hK4oozf
 BzmDe1LlyLlj9/52AbGRXF84Nu/GM7a4VRbD7m/ZcuH4+YvQxxHhRJ7ejvE4dO6SX742faVSg
 sOS7iaVKWcVi0+onc1Pn5ARWjTo+c/kOotfnSecY/YLnhkVHqCv4cg=

> -#else
>  extern __must_check unsigned long
>  _copy_from_user(void *, const void __user *, unsigned long);
> -#endif

This function is now unconditionally declared, but only defined if
`!defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)`, i.e., in the
common case where it is inlined and Rust is disabled this can lead to
link-time problems if someone decides to use it.

