Return-Path: <linux-kernel+bounces-145644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85A8A58E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A5B234A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02BB82C63;
	Mon, 15 Apr 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lF6aWn3W"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270498288A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201247; cv=none; b=Z5W7+wn1WaK5ZIaaxQdByDz5xPsJ4qkVC5KsvG7sqUkvDowLFd5y/FBh3qocUE+Bah1sFwMU9hbAoIZ0Ibs1zNq0Q8mVL6RWPSoAdxhS5DdnLuSzC9JUMIpgBCuJFnduk1CHuhrxY/2b8CMRIZ+eu+BJCG05eLqIapP78m86/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201247; c=relaxed/simple;
	bh=XcuUAmh5zJlhMzspZkNQEeYA/TjKS7buoHnMTlPwaPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdaoms0IOJJdO7OY0LYYckYmABX8o4GAOsb7R/3OFOKKVVgZQeeu+ujuz10ao/6JgoVV6RZfTMFQoSxwYZNB7MrxlpdBhJnt5uKjzfRGkAnQ+K5Z0YdZHfhHZiC14XlUHuPIrNKoZiXpGfmtYWOzDBMCPueRQQjKzXobIyC9y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lF6aWn3W; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e782e955adso3484914b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713201244; x=1713806044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qectELHxULGP8f3N10tQDQeblgf58cUTMxAcWlcdZeM=;
        b=lF6aWn3WosIfNyjvhW+WsB2DSL0vhUN6DRiXpmbts3XUQnHSQVlkFtEp/HJ0vLOV5q
         nGYDag94nCia9VpjUKSFZnj6qtxrf2vdBxzdRd2gHk14Wfaakx8BZn8Tz5NATg+yFIaI
         Bs18pE6g12v2GJEmCQkD5RrcCmQQrcedH1zZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201244; x=1713806044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qectELHxULGP8f3N10tQDQeblgf58cUTMxAcWlcdZeM=;
        b=cuQ8nZ1feH6MSQt/W7HVcrL6J2HQOT1Ow/ihKPYpIkT9ENJjHVgNgUCQsJmVVL0KNB
         +4K5SaJTnslwZGTFEFDgDpq8UkepJmaze1FQLunNMWlnHH4jxAJqp3y8yY1iXoQWpGjc
         w+XpzihPofLWNTwGGp6SX2KtQxnb4d2C9e+mN/Sht6wrEKeDgqmT6qMooyK95X3rtYFQ
         GWubzcDRf1Og7Z3nyP/BC1ez2NvWyI6Qaa2NLCd4FiSoD3klWkIPbQ9dQjApF9HA7FDZ
         E7HrACY5PAIWv0sH5mgW9gkJ9P0N3poQTc1qJew3tPVejN2igxQGnecG+X2zKdPj+TlR
         TwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFv+pUCkAyA0fSnki3gwxZAgFJylT2o5VAZbJImoIg2LGPEmBqyahbaSpocmhIwSAO5JlYnwU4bp2wSaKTNPHi6IObZdPBFrDRbfzu
X-Gm-Message-State: AOJu0YxDO8bxpRZKv8cns+fK9RNmfxejOkbszHwCSAh39ceq+Uz7UXMU
	mxlZ8G/0bKPLaKYcrh7CB/lsh2iBgYjv1GquLgHfMpVq40sHWlZtis8GLKhHXg==
X-Google-Smtp-Source: AGHT+IFX3lKRFmR1Eb35Honu4cAQuoMyVRDRqy8xmGu11fvvOl8LSiCv122sTz0qgd90NbbzmuNvoA==
X-Received: by 2002:a05:6a00:4f94:b0:6e6:8df5:f77a with SMTP id ld20-20020a056a004f9400b006e68df5f77amr12937175pfb.31.1713201244424;
        Mon, 15 Apr 2024 10:14:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c9-20020a056a000ac900b006e647716b6esm7720644pfl.149.2024.04.15.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:14:03 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:14:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 __apply_fineibt+0x566 (section: .text) -> poison_endbr (section: .init.text)
Message-ID: <202404151010.75DC9B8@keescook>
References: <202404151042.vATlNGmU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404151042.vATlNGmU-lkp@intel.com>

On Mon, Apr 15, 2024 at 10:15:48AM +0800, kernel test robot wrote:
> Hi Peter,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0bbac3facb5d6cc0171c45c9873a2dc96bea9680
> commit: 04505bbbbb15da950ea0239e328a76a3ad2376e0 x86/fineibt: Poison ENDBR at +0
> date:   9 months ago
> config: x86_64-buildonly-randconfig-001-20240415 (https://download.01.org/0day-ci/archive/20240415/202404151042.vATlNGmU-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404151042.vATlNGmU-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404151042.vATlNGmU-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x12e (section: .text) -> text_poke_early (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x1f2 (section: .text) -> text_poke_early (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x2e6 (section: .text) -> text_poke_early (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x381 (section: .text) -> text_poke_early (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x3a4 (section: .text) -> text_poke_early (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x44d (section: .text) -> text_poke_early (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x50d (section: .text) -> text_poke_early (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x532 (section: .text) -> text_poke_early (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x566 (section: .text) -> poison_endbr (section: .init.text)

test_poke_early() already marked __init_or_module, so shouldn't these
warnings not happen? (I assume the same is for true poison_endbr)

-- 
Kees Cook

