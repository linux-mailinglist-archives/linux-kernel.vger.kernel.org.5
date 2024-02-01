Return-Path: <linux-kernel+bounces-48667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B7845F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9DB1C27C53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC07429E;
	Thu,  1 Feb 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kv/Plj9Z"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC912FB23
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810910; cv=none; b=m8A1L133TV8oUqn6kdUunSs8gb+Bh2U9K1u9aFWrRmGAeRjv/hnsmd0DhSqwgYlV/iARVrj6ehLlSIUEudWqHRYGOrE5RMo3x9Vblz9K5JopEzi/1BMcO4ME8lZTi6qhjkf+42YmvJqj6+L3Hzm9+Q33fJwijfqs0Rqi1YG56K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810910; c=relaxed/simple;
	bh=Bd1XZbZLzxEkpAsi0qzzeglcf93dLiRpddkZTTy19hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6yWUQeLCyye4jJPvtrRysjJ4+iz6gB8W3agBeFqG28BE7p7Si4BQO1heXq6tuy9IqewA0ZCgpzRUcEqRR6NOtPW11/eDpv+R97L2ZU0EKKlkPeAj/NPwlikNqno0FvMcAgbLS8aFWq0a2CqiVdKd6rJHoXJKpA/r4FKX/SNxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kv/Plj9Z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29080973530so929511a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706810908; x=1707415708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Bc9O0i1Ze7/nmdnM6cLthDCGMlH+1F7pPRsecv4DWE=;
        b=kv/Plj9ZBBwEGtO0u79b2xEWN3YMXZOrUmdgVQXqhnagsVMAvKQXhxmEiX99SeckNG
         WYnKLO0xCup4ag8h9rLKEsqJMXtClUd6YlrmDJdKSLsXfov/oNosTJhHR9Z5Y2TKqOjN
         o5yFUHePJukdnpeV1Ji9USCVTFP7YiZ+VjevddtGA7aV/vj2jlCivWFI7+j6rXiLDDVA
         sjBkwePTT5VBp5QIMGxXJhod2tzSvoJfTA9QxQLpqWK7jc+VSjyJliaQe1CuCfCeiTgB
         e8GdaWYGNVlV//yVcwUvKmRl1LYq9A+a6xFMbpz4tUaOQkW/vsZy3rplszj+T1S32bP6
         oaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810908; x=1707415708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bc9O0i1Ze7/nmdnM6cLthDCGMlH+1F7pPRsecv4DWE=;
        b=gTwyf5KxLWjBdu0vG0dV6JO5Bf0czpnOxe5YYbnhC16tIReLvTIBNu8JdwyrhNXlEn
         ttEgk9KVMk4l7r1gNCZ1myCemx0Q6DmGoUmVY5IUFnXUiZmkmTR3PwImWnp4sQHhCOHR
         lt+z+PyUgYEkAigx4KNEddRLjDIddBqsLDlGyrIOxzabFR6qKGK60Brcdxh8nA/D9lXL
         AnNlq5yJ+psx/rO0/0SdDiv0agwbosz3XfVwkd3tLN0OyecZIkWssl7TL6WDpAsltCLX
         6rh6GqFxi3FzYPeH+VZVCilGaC6ihw6RDalLlDMQSjpXTvihCSUuSogIVSsMnQAktgM5
         iuXw==
X-Gm-Message-State: AOJu0YziwjfpOztuLRDw2Guic95WC+Lpi6NWFk/WpR+7+Nf0sHzQHcLG
	6nLBh89O28eBaexqUtGMSsJ4tFpxsqYTr3hBagsGZCY4tAPnArzRTxBb2gs0QQ==
X-Google-Smtp-Source: AGHT+IGMkP4WiKSJkibWXXMTZOUkyofNPh3rTVvoVv7GQTJsjVlGryczRqjT8ZVoJ8l6bjLChRCAbA==
X-Received: by 2002:a17:90b:ed2:b0:296:89c:1c2d with SMTP id gz18-20020a17090b0ed200b00296089c1c2dmr3486052pjb.7.1706810907806;
        Thu, 01 Feb 2024 10:08:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXo7l/w9pqoyrFqqJv60ytTKRavThIGePD98TwksZNFWZsIb+NDqTHgsy+9mU8/m4s9nBgGVrye/0dEOII4Y3GAT89ZbP0HPvAzxnTysxC3eld549hIJGUlTWuoqVoK2gPW3/mFKvnjKHmuMP3PneiYerJMtllj5dWUSw==
Received: from google.com ([2620:15c:2d3:205:c1e2:8dcb:e64a:6cac])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090a024d00b0028ce81d9f32sm158762pje.16.2024.02.01.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:08:27 -0800 (PST)
Date: Thu, 1 Feb 2024 10:08:22 -0800
From: Nick Desaulniers <ndesaulniers@google.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Tanzir Hasan <tanzhasanwork@gmail.com>,
	Kees Cook <keescook@google.com>
Subject: Re: [PATCH 00/28] Fast kernel headers: reduce header dependencies
Message-ID: <ZbveFuD2lpE7sJfA@google.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
 <28b1d750-fa74-4279-b292-e36cea995e80@infradead.org>
 <CAKPOu+8QQnMaZG33wyR1EzoifHD5kjSmjf2FQ9Y9gGdYN9dgJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8QQnMaZG33wyR1EzoifHD5kjSmjf2FQ9Y9gGdYN9dgJw@mail.gmail.com>

On Wed, Jan 31, 2024 at 11:00:27PM +0100, Max Kellermann wrote:
> On Wed, Jan 31, 2024 at 10:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > How were these (a) missing and (b) unnecessary includes
> > found or determined?
> > Did you use some tool for that? If so, which one?
> 
> No tool, just stgit to edit the patches (in arbitrary order). I
> reduced header dependencies, but got lots of build errors because
> symbols were missing in different sources, which were previously
> fulfilled by indirect includes that were now removed. I fixed all
> those build errors by adding missing includes to those headers, moving
> those changes to the first patch.
> 
> I found the unnecessary includes manually along the way by using "git
> grep" to find all include directives for a certain header; I checked
> the source for the reason why this header was included, and whether
> the include could be replaced with "X_types.h" instead. Sometimes, I
> found that not even "X_types.h" was necessary, but no include at all,
> so I removed the include completely and had those changes in the
> second patch.
> 
> The first two patches grew along the way. It was refreshed over and
> over (with stgit), while I was editing the other patches.
> 
> I know there's the "iwyu" tool, and it may be helpful eventually, but
> there's so much low-hanging fruit in the kernel, iwyu is not useful
> yet I think.

We just wrapped up an internship where Tanzir was looking into getting IWYU
working on the kernel.  He presented about it at Linux Plumbers Conf '23
recently.

https://youtu.be/eFq_oqLiXPM?si=0VhuMnwjHnMPJeaR
https://youtu.be/XMVLSEzbpQ8?si=_2DQpS7JBlEC4FK1
https://github.com/ClangBuiltLinux/IWYUScripts
https://lore.kernel.org/lkml/?q=f%3Atanzirh%40google.com

Some of his patches have landed, others had requests from maintainers that
weren't reasonable to satisfy in the short duration of an internship. But still
worth pursuing. Happy to chat more about the general problem sometime.

> 
> Max

