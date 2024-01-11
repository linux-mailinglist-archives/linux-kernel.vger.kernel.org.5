Return-Path: <linux-kernel+bounces-23966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A472882B498
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346BCB22B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69C53812;
	Thu, 11 Jan 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/cO3F36"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1E537E4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b400f08a4so4657996a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704996825; x=1705601625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q/8Soo+wEKDq7eYPc8t+IYgpbRZAsRM2amYkmZMpzg=;
        b=N/cO3F36YmS3aq/jRKxDFCLqmZJZnUe1iqMkts0N7drA1FZPwRWbcL5u8PoUBN/oU5
         vwJ926//PLZAewfjwZIGo81AF00RgWu4LuWd/jyv5zxkclPoce7u7djJDVu8j6jK3k5J
         eZ79CUqcD+Rv2pwU1NnxeudYq+9apyQXuV8N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704996825; x=1705601625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q/8Soo+wEKDq7eYPc8t+IYgpbRZAsRM2amYkmZMpzg=;
        b=D7SXISoDDGJvLJ7Lp6xXHBPaWLKrtetpXzLmAw5cikc+nIUe3bQlKTSr+EgXVUFYBp
         7TfaNiThivgJrcO1v0SATlfiIuCEYnf6khZS5l37sJmuzcVVkkxmvtSw/8uskgyq3kZ7
         kE5mmrAx9vYAf8gm2lUJSyC4cz7xuSAQ0POdyJyFoQAbW7AUYnUvPrz9ONJjD6RGcDiu
         9SlQkDg5buVt/wLU3dvk1loFwcnvmNveevajofaBY1Bp0r6cJyhpK2ld/hVEgQHtqYCF
         Xs8vVoduazPgNWmnRa9WZn5lHK9InCUHhIjHVz7EC4rt9aIrvFIwFydoA3u7CXXS3GWH
         3m3Q==
X-Gm-Message-State: AOJu0YwNtHLVTfYjvk3ixiGGk84unxJPJy9vkEb9ivDC7FR9W/MYmttx
	1C+UIHwBHkmPPAsfYr1fXgoDnlIWjcxi
X-Google-Smtp-Source: AGHT+IEqA+jBHfgllqO6iXTDhDycwgIlkmEw66FVSjukl5mRD1d1Qm4e8CVvwaS1Ndd5k321Lph+1A==
X-Received: by 2002:a17:90a:3da5:b0:28d:df02:447b with SMTP id i34-20020a17090a3da500b0028ddf02447bmr216438pjc.0.1704996825202;
        Thu, 11 Jan 2024 10:13:45 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001d4593a2e8fsm1465916plb.83.2024.01.11.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:13:44 -0800 (PST)
Date: Thu, 11 Jan 2024 10:13:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <202401111001.78284D8F@keescook>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
 <202401101601.30ED61A1A3@keescook>
 <8e527ade-fe49-4697-8e36-589775c63354@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e527ade-fe49-4697-8e36-589775c63354@moroto.mountain>

On Thu, Jan 11, 2024 at 10:15:40AM +0300, Dan Carpenter wrote:
> On Wed, Jan 10, 2024 at 04:03:28PM -0800, Kees Cook wrote:
> > 
> > Oops, yes, thanks for fixing my confusion. Right, this is a direct write
> > across members into the flex array, not a composite destination. Yay
> > all the corner cases. :P
> 
> Is there a document somewhere which explains what will trigger a runtime
> warning?  For example, if you write across members but it's not into a
> flex array does that cause an issue?  Or if you read across members?

There isn't a good place to find this. There are some code comments near
the memcpy macros, but that's not really sufficient.

At present FORTIFY is only being pedantic about _writes_, as that's
generally a higher priority problem. The implemented restriction is that
the destination buffer must be a single addressable struct member. That
destination can be a composite member (i.e. an entire substruct), but
going beyond a single member in a single memcpy() is no longer allowed
because the compiler cannot reason about whether such a copy is
"intentional".

> For example, this line reads from bulletin->vlan and
> bulletin->vlan_padding.  This causes a compiler warning in Clang and
> GCC depending on the options but does it also trigger a runtime warning?
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c#L2655

Right, the -Wstringop-overread and related compiler flags are doing the
source buffer size checking.

Note that for the compile-time warnings, GCC has the capacity to be much
more strict than the FORTIFY checks because it can perform value _range_
tracking, where as FORTIFY compile-time checks are limited to having the
copy size being a constant expression. (i.e. GCC may produce compile
time warnings for cases that FORTIFY will only warn about at runtime if
the range is violated.)

> (I wrote a patch for this a few months back but didn't send it because
> of the merge window.  I forgot about it until now that we're in a merge
> window again...  :P)

			memcpy(&ivi->vlan, &bulletin->vlan, VLAN_HLEN);

#define VLAN_HLEN 4
ivi->vlan is u32
bulletin has:
	u16 vlan;
	u8 vlan_padding[6];

yeah, ew. Should it even be reading padding? i.e. should this be:

		ivi->vlan = bulletin->vlan << 16;

?

Or should bulletin be:

	union {
		struct {
			u16 vlan;
			u8 vlan_padding[6];
		};
		struct {
			u32 vlan_header;
			u8 vlan_header_padding[4];
		};
	};

with:

		ivi->vlan = bulletin->vlan_header;

?

I've been finding that almost all memcpy()s and memset()s into non-array
types are better just rewritten as a direct assignment. :P

-- 
Kees Cook

