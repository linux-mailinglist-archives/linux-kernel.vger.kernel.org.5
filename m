Return-Path: <linux-kernel+bounces-75582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCB85EB82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F478283F25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60B128804;
	Wed, 21 Feb 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpj48WmF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9B127B63
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552873; cv=none; b=EZ0c9HNZ00lyqpiut4bnYrGFeHsQyGDiVAMacKv3WR9fEmOkBnyQ0ZCVDxTx58QQk1W1z7p7DrdAVOtaTHzEHiU20VxtkSAGZDESifiuMyrPnp3X0AOrwaqMvSNPzWHaw4V07iFbwnyfwVm8AhS0rRqpZ9d+E0EB7v4XfOpGhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552873; c=relaxed/simple;
	bh=wqGWw9nOiid78rmVoNJpLAKogw9OxxtIINANjebVuns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3wqefXznFRvEyC+d0LhWgpbxe29T6yWwHs5ZfIiuViy4k7soe4+wwbb9PZIBQqImqpA92wE0Z/P4dZyokvlVhZCnkhGSnqFp3KJibtabhXXzE8elKJLctZG93cu78DryiMC/l3hCQ6xaWzk69BxDn/oMT+C9/2AHsTCbgt2+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bpj48WmF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dbd32cff0bso35464305ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708552871; x=1709157671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+6LHH2NPUzYokJHyaMeg6P0BHjKGeB4TbkarefmniY=;
        b=bpj48WmFS/Iv/Pl0hg7lOS8zJgnv0NSStFCNmbJ6KEpuG46kTUN/691glGTo/3Ussp
         p+NO4+VI9TFFxK1I1IpwAumuQPpNmQosA0O5VcsIoRgOfll/Zs90O7tq42+7asod3qYo
         QfauMBovnb/+K04a39tMMdP5sPWShkQq8NrPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552871; x=1709157671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+6LHH2NPUzYokJHyaMeg6P0BHjKGeB4TbkarefmniY=;
        b=v2yOfF0NxwJSxh1G0O+gK9VXSEsqsM/LBjawEhrLykL6hpnMi1hXUYljbwtTRx5Che
         AEVqg5Xep20+/tvTv8Y/0TRWNN/C0PR9noeyE7Eyd6ueCz91+SuFFYo91qoUSTu+c8h6
         21I67614wHVm6gvLrk7ypxoVKirbElkFU88WZdYyqKpGspfRbIFNymWKPgXTC/BxhzBu
         QXcyWXberwFZhep7h19P5ytn5kUQUT8SIqnc+PdMLAkkN7C9tmDckYR9TFOGVlRtDChK
         aAL6JIENfmg65aO0a43ojAR309fKdGn/wCrjCanB9Gke66YUmfAosKiMmjd+lSmushgw
         LKTw==
X-Forwarded-Encrypted: i=1; AJvYcCVJFDQ+qGp0+DAs9sw97zDBElcQXVCIMogo4qVVjcdzvGj09QsdV30X0BgZrEH+7XimWthl7sGvyFvZODRCzs5emdUOs/ftm+9hgiXR
X-Gm-Message-State: AOJu0YxTzd6XbxK/lw5FdFOXXP23wn8v5DzG7uib6SBfqVKnx5fE0I+C
	Oj6/rgWeSE6hCsx91LMSeUQVDq8WrDn0Zp3zgxmbTB3e95XA9J9n1VS5B5131A==
X-Google-Smtp-Source: AGHT+IEf5eKUQSWm+opFfaiF5eBQJmg0AXhYyA+h2y9jNbW7sOQuiyq0AM8mKQQVx25bJ6R/7Y4UCw==
X-Received: by 2002:a17:902:f70f:b0:1dc:4b04:13d4 with SMTP id h15-20020a170902f70f00b001dc4b0413d4mr60269plo.8.1708552870628;
        Wed, 21 Feb 2024 14:01:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902e90400b001dbba4c8289sm8533989pld.202.2024.02.21.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:01:10 -0800 (PST)
Date: Wed, 21 Feb 2024 14:01:09 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402211347.2AF2EC4621@keescook>
References: <20240220185421.it.949-kees@kernel.org>
 <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>

On Wed, Feb 21, 2024 at 05:39:55PM +0100, Daniel Borkmann wrote:
> The build in BPF CI is still broken, did you try to build selftests?

Okay, I give up. How is a mortal supposed to build these?

If I try to follow what I see in
https://github.com/libbpf/ci/blob/main/build-selftests/build_selftests.sh
I just get more and more kinds of errors:

In file included from progs/cb_refs.c:5:
progs/../bpf_testmod/bpf_testmod_kfunc.h:29:8: error: redefinition of 'prog_test_pass1'
   29 | struct prog_test_pass1 {
      |        ^
/srv/code/tools/testing/selftests/bpf/tools/include/vmlinux.h:106850:8: note: previous definition is
 here
 106850 | struct prog_test_pass1 {
        |        ^

Messing around with deleting vmlinux.h seems to get me further, but later:

/srv/code/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c: In function 'bpf_testmod_ops_is_valid_access':
/srv/code/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:535:16: error: implicit declaration of function 'bpf_tracing_btf_ctx_access' [-Werror=implicit-function-declaration]
  535 |         return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~

and then I'm stuck. It looks like the build isn't actually using
KBUILD_OUTPUT for finding includes. If I try to add -I flags to the
Makefile I just drown in new errors.

-- 
Kees Cook

