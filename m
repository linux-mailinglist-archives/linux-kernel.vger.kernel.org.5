Return-Path: <linux-kernel+bounces-58802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E884EBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D54B2686E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78450254;
	Thu,  8 Feb 2024 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="cIipms13"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700F50252;
	Thu,  8 Feb 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433106; cv=none; b=BWVVv53xgUEHvfknIoUlOldeB9Uoxu00hYYEDfhaQ+Kzn8LsBOxuhl7FsnJXK2xIrdmqC+bxPMcmSIVjOLdE9ZuZYx21qDXO7TKPewUQMdUDSuNSPs1BA5tHkcDdJfuGXBOrnmlzEjPEmXTr/2aLqEa6LOYoRAvYYjFFnqNqUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433106; c=relaxed/simple;
	bh=vDtQPHKXvI4tfvO1m2ylW8yoE2nCucmoXqiOvm7GDjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9JgdcKzAX7DTZQzxNT32l4Xak3NpGuiJon/pXV8PaQNF7SmF1QjJlWt55WpwwrEJCkkbB1vCZBVTIR7e1RbH90tP2gXmOztvlO2fryhrz4megKTuHGoCzL4tLMhCqezZKEXKie4eTELomQV4x5z1ZI8wRhmMqE13v/aTU3C8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=cIipms13; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1707433072; x=1708037872; i=kernel@valentinobst.de;
	bh=vDtQPHKXvI4tfvO1m2ylW8yoE2nCucmoXqiOvm7GDjI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=cIipms1356DvPCYNJWOY+ms7RSQjNAk1Oyed2E1GpOCY838UTZ76SEI7PwXTXxfe
	 Aa9b5DS9LkRDnCaFPUvi7b/oW0tzqNMOlvQBwvVLRtGXcY7nly4HtEd6Am0o83kVL
	 gGsFaXqsnpn9NS2AK0G+Dy5c8gprgP8NhrMd3sSlYOLDj1WdA8omHsw6hfhMz4PQ4
	 KzyAzY+JDTX54EU0kjwsFHPj3IjCf94fo6UmCnUfPyoP8C055wtuNJOJLrCqT0atB
	 iN7Mfp/bcT3UqZCeVcJAD99l3ztsu7Vll9VfyaNn9bij02munsv3e7hqPyfW6TCzT
	 LmXk5ZFaU2R3BAuDWA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([217.149.163.107]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MK3BO-1rIBYP31tG-00LYDx; Thu, 08 Feb 2024 23:57:51 +0100
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
Subject: Re: [PATCH v2 3/4] rust: uaccess: add typed accessors for userspace pointers
Date: Thu,  8 Feb 2024 23:57:48 +0100
Message-ID: <20240208225748.12031-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208-alice-mm-v2-3-d821250204a6@google.com>
References: <20240208-alice-mm-v2-3-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:OQenII82s2YbpRIrnGGoCAihMPowFipeN/OhrfJxNwvMlkj/tJY
 2FKTaA6coAyQc3dYKSFX/8UAPWeiNcEhu+Il4ZhrR8RrWguuUmcz7DwCVhn6/UbcJXA9vGe
 68vcP6fVle3E/g5n+1dlf9Ypwiiszdu4n7l94/kJ1fN00sH66tGNMgR5jau7csD+YjqX7eA
 ZluteIhxds53pa22VFXnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JeE0MJLO5g4=;QYl3ENKI9UZfpQq/P5YUuUdBhDk
 CHaqbuWqRbjB/K+gI8E39rZOnEEQaZOiJr1iHfN8YFkIeO2nYgMz/Miol9SXLlv98JMWwROaI
 pU8wNQSxhNUUBkU1uqvwYa1HNW2Tk0d4hK9Aaa3U0ry0tR3iDEbGSta/vhebSN4Bi489H4sc1
 s2tQse4tkYpmihgK2s3UNyRmAkuUtRbeS9DK+GprFtXOEvORBWdAPjuEg5kLIHUfIVPWsAIXD
 gG5AfMlhYqOe0bHOqBxnkGW3+IFsC0+CMA2j2Wy2ESzlM5sh/EQvmn6aAzOnBg+Vo9sTi88br
 3QTvy0+l+RGmu6Z842cJIghRPSOMDcwp0Zb/dawvoYbFl5habYIGJybhNR/MsPIs+l8oNEHW7
 wg4NrmbTssxgmTwOH21l+thRZtRzFygZ8VKdPl5Hjo6E80c0ubuG5v2Fv3aGyAr3njOVzTI0T
 Wj9S9pzH1RL3FDbIrpuJXwyfMLElSNg8SWEd0WMSTTDtbkPO6/ePONogL6yEbZ90z5LSwq1SW
 FCbsRq7RnOZxFg4Seaa28UT9oN2o/HYkmnRMxt6aXRX9Sm2p2otbFp6KpzYCihymNLcF7SimK
 XT7mt2xiNBPf2IzQ6Q+P5LWigBNrA4W0Q3ekU1SuBqyvWCLXGtIjx06xZkgYZuIIEdyqafW6q
 xakPq80+bEGnomh2p9+nNfNx2FwVejkuvPS7emCH4KEh4EItxUpgkmFLcW1SXYAnNY4RrstMg
 Jblkt3HHcI66NLlI/4upFX9J92a2HYzfHk6SLrB0h71LKJt0ETlfLo=

> +/// If a struct implements this trait, then it is okay to copy it byte-for-byte
> +/// to userspace. This means that it should not have any padding, as padding
> +/// bytes are uninitialized. Reading uninitialized memory is not just undefined
> +/// behavior, it may even lead to leaking sensitive information on the stack to
> +/// userspace.

This feels a bit too restrictive to me. Isn't it okay to copy types with
padding if it is ensured that the padding is always initialized?

I recall that in C one occasionally does a `memset` for structs that are
copied to user space. I imagine that one could have a Rust
abstraction/macro that makes it easy to define custom types that can
always guarantee that all padding bytes are initialized. Such types
would then qualify for being copied to user space if all field do so as
well.

This could be a significant quality-of-life improvement for drivers
as it can be tedious to define struct without padding.

	- Best Valentin

