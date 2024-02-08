Return-Path: <linux-kernel+bounces-58800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A546384EBEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609ED28A762
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2875F41C7C;
	Thu,  8 Feb 2024 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="zCiRV+cy"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CD4F603;
	Thu,  8 Feb 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432925; cv=none; b=AXduFu6SiV8doreO4QklUmm21KRKvsBK6kNmtCjVgZ6z2LfzNTjZmhq8QC0ZX3eaVPEUIkdDbKHFQMBdY6Vo2Nz9hahsrmkiWac305Io6wgOndQo9d2oFG0eUNa8AMv/UQM+IuYCYk7zyIKOEKyZz/8kBjpjri2rFbaM8uymOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432925; c=relaxed/simple;
	bh=e+MFB3XZAq9GFafBngfM90xut0vO6IkDIPYDubemxVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVGuTjBiQiHn1/86HWCACWcb/+gsxqv+9u/dicmBeAKLFnWxcBkQcS0qgxoOAwh2hpWRyaYy7Zf06UlRO3AWBlP/Opgjqag96TsC9EMVM2f2D81sQq0DWFE+En814pWgZDzRi2ff9noJypGPoWkqd0Lr4S36oZmLxEp5lUZVsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=zCiRV+cy; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1707432886; x=1708037686; i=kernel@valentinobst.de;
	bh=e+MFB3XZAq9GFafBngfM90xut0vO6IkDIPYDubemxVg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=zCiRV+cy6zuur2CXcS8b6/spqGAfMlbIdvYb/z/6NCVsCXAUUSqvKMJPn356W5qu
	 IGaaJbdoittkjnqXIQJ5BYeqaoq7c4jCVBSSXEC4i+hkI/IdVZXa9+k/ernd6V+N1
	 v2+tsPIoQd5iY3B9lF7kt0j+3KIM0qSEPsdxfz8ZGnx5uwl3WYH44DAkI/AW4FQxr
	 ZIlVhwsUTSpjuFubtUCqyoOL0n/+Q/7SMNsLVCCStLuOz0eXbyrZ6oktEpyYmvdTf
	 0j1oUCD8ES5/E1YW3wnyVP6DaZaqR1RkWUSb4imprQ57pBjjmB0TM93FFC9oABRkc
	 +fNURJPSQWPWd4JooA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([217.149.163.107]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N4A1h-1qq2id2Ohd-0105qW; Thu, 08 Feb 2024 23:54:46 +0100
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
Subject: Re: [PATCH v2 1/4] rust: uaccess: add userspace pointers
Date: Thu,  8 Feb 2024 23:54:07 +0100
Message-ID: <20240208225407.11951-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208-alice-mm-v2-1-d821250204a6@google.com>
References: <20240208-alice-mm-v2-1-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:c3KgsHDte+YYH7c1f2niFI8o4D1CssfnYZbqlLxRwIzgZlV1m65
 1v+5LpTs0C45KrSXwq/XbwLAJyIk3blTzGXfeL3Mnh07bZ2CvceAW9v+EE07z83Lrkp/AKr
 ABHwcTm8b2pMVasBQXP6G2032obiZSmZBzVqnyNj6tOdnFZF5Uo231GEQ7Wg9brVtFrdEsZ
 pdb1HmRnnrTtxtfXypukw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KYCs2emiKW8=;K18jqxUd3/8AJwUpPierWZAqHDc
 dEw+/3PzbaX7olGqnUAxVQIfFtYjFRNUhFOTpO/0AxMFQ530MoNbMFZF1d6QLW2KyjUF69Gv2
 NEu8LRblExRRKFGfUsWvxRiTB391W54u38qktQdpgfUobuKc7Abjc4IFc3AYB3XnYym/r6pKv
 Rzz66fZ4GpcZak2akShmYvB73hp4OazEJ31FwuEhG2nIs8E4HNYdFjAWUiPhkHwqcppwRZuiD
 WzuB3U3Eq4Udx4kpPY7vFKDnk3+sxoCyqqLFN1uymBe3NP7SmsZoXsDsZgsGLw7FqNRUfhJMi
 vD6ncfSRAW9KYgA6GWlxeeTlOamwAtFPecjFLvXRdkS4pV/UtHU9RJov45VjVd+9zZmn4wvcv
 sWO8eQOSZhbTXJXgwQXQQPqqDjgxVdOMZ79aVcQ9Ygp5QO20rm3DA8kXSjPai00ByE+SZj8z3
 7yylVcHnwfFF4tbtHTeBcIbMu7tiVAYxWSBPfiO+GW14ToOURtIf4rGYcu7ej1dCXM0x8aZxV
 l18+fflSjQeCEj94Po9ceNIKKCH4PrP2DvS+EANQmPL3bGuDJldsP45z6w1k2HloXVZVH27bj
 ALU02viAHi3M4Lqmrw/5fsU1RyHP4lsQSN0mhpX6Itgh6zfBwt/cc9qFCs2W1ir+mQuLnLU76
 PPQbQ1iVm5ylROWyrEk4/2mP0EUcKRLjoW91zDrkIjf7nv1e0nYbsQKSE6ThNJfj+yJGnbxPu
 6GE1jj9j1acKmRW+qLkkaLifdUrCcpXbnExS97bXFzJT/Ax02hkE9s=

> +    /// Reads the entirety of the user slice, appending it to the end of the
> +    /// provided buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.
> +    pub fn read_all(self, buf: &mut Vec<u8>) -> Result<()> {
> +        self.reader().read_all(buf)
> +    }

I think there is also no need to give an explicit `()` for the
generic type parameter here as it is the default (applies to some
other methods in this patch as well).

