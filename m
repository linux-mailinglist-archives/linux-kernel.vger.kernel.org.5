Return-Path: <linux-kernel+bounces-137370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C9D89E11E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B807B1C22CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D915539E;
	Tue,  9 Apr 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iBzYfnWv"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78B153BD8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682644; cv=none; b=EtpUWQKZlfXKEal/oaCA/oqElh6fF6bOc8PjS24JohZfNTBXtIrEpDNZfmZSCBvpTZ81BJCfGqbQAYlW5na+wBkQ9Ub4OUXGWB5hhZ8/eDxTalwIEjSQ1FbLZMw2C3cJGN69NEftFU/SsrHCXnzGDR7zSZMpDwzsRCR1CNOvlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682644; c=relaxed/simple;
	bh=DaPCXUGC5SI+VvCrK6iY6VKR70jtnLy+38KfZddgl/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggkikmI/2lo8IPMAzYjF0q6NO2uIGu6lAWwmy80BOyAyS7Mf0m5YdW+QOSXk5tJIR/Eatwvnb4LzP05cbxzkGJUgImjahW/tzWg7rTYODxIaGJa2Rb+dqRO9ZJFJAlPxyLNKFedLgx3lONyM1bsctgUQs1gh0pins/2FNLpZ4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iBzYfnWv; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa34ec9a54so76983eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712682640; x=1713287440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCF4brmK1xna8X9dl4JbyVl4tAdSfSlHlPsOdrXYGDA=;
        b=iBzYfnWvTTgUTCdTUIKYJcav2CXcE99UyyXqPEFifHVrBSQNBC+wDwuPXNyuR9FGEP
         /UfI+b4bmsZdxJpOE1wKPvvGFiForg+zpX6Gv3ZP0EJd239nTI/GrYAKi5TfZX1pQXny
         r4mMlAoMaB87vKLH8H/xjCt0x140+VvoQHB9vF6HQGuK/27Z/vrlp03HG6coqqqd5xXm
         SxosxqAYJtmI0NfPgSbYLhrBSQqQXz9MsithjCwyzGOBYU6E36exuhkOsd5wJ9aUgyS7
         4oAcZ4l82d50odbKdEDGZ2KRC0WPK89VMcEl7H1wqbyyYPBnADO7CbdG8ZMegtPjkVT0
         w0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712682640; x=1713287440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCF4brmK1xna8X9dl4JbyVl4tAdSfSlHlPsOdrXYGDA=;
        b=PGwuuCx76CG2XUMeUrY+ongcCTZzIuuvyTrdnDK2BJuqivO1+bfKiKk5GdgD1ODW4o
         EsS764YL1kKbOX9ymCmxLh9mlIE9lb5G/Ppzhjn8lqE3/hAtqQemIWysOnVNySCUcH5l
         56vdS/JwopkgqnoLpFqf0vjTxsey3k7MEfB3DWgaMh4BSlCicslceYI4GeQxreqI89dw
         VBBl8E7vZJpCQk0VEOyNcwnGFQ6a4k0PLU9qIFUuuG3oGvX/oNUjvMX+U5vUkuN92L3T
         j/xRgNWxBkocPlnqmhIGbPUKfApaGIONCr26XIV8sLy/dYLcgG1mGkvw0CD2+OYriKz3
         VszA==
X-Forwarded-Encrypted: i=1; AJvYcCUGWvdNadFXHzHZ3DdYddIYKqKN7okDFTFvi0mMsLSdSgMnRL2AyXE57Ej8vKZCkA7C92J/2CY7C75O2RCtAvWx0Q9mFl+1tWUGpAzQ
X-Gm-Message-State: AOJu0YzBKQ5ukd7OEpJ6gzmmMo9Fn+gQyeQ0/S+jfx+xOKosLhcnNQX1
	4DX9mc/q12i1rMwnKPaVS+6LxAhrtGS9fWCdSQz00k6WFTGhInN9ZP34twRiU4o=
X-Google-Smtp-Source: AGHT+IG0Q+2GTIz4xzJKQZb4/LaRz7TK4ronqVobmO/AKkEHPaGT79eQEbnXx4hY8yxj2ScSHCLFlA==
X-Received: by 2002:a05:6359:2ea3:b0:186:10ee:b04 with SMTP id rp35-20020a0563592ea300b0018610ee0b04mr431149rwb.1.1712682640194;
        Tue, 09 Apr 2024 10:10:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w9-20020a63fb49000000b005bd980cca56sm8397770pgj.29.2024.04.09.10.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:10:39 -0700 (PDT)
Message-ID: <8187c490-b1e1-4c7d-9f7c-590ade4777c4@kernel.dk>
Date: Tue, 9 Apr 2024 11:10:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iov_iter: add copy_to_iter_full()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240409152438.77960-1-axboe@kernel.dk>
 <20240409152438.77960-2-axboe@kernel.dk> <20240409170644.GE2118490@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240409170644.GE2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 11:06 AM, Al Viro wrote:
> On Tue, Apr 09, 2024 at 09:22:15AM -0600, Jens Axboe wrote:
>> Add variant of copy_to_iter() that either copies the full amount asked
>> for and return success, or ensures that the iov_iter is back to where
>> it started on failure and returns false.
> 
> FWIW, see git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.iov_iter
> 
> There was an open-coded instance (skb_copy_linear()) that I'd converted to
> that helper in the same commit; I can split it, of course, but I don't
> see much point in that.

No reason to split it, I'll have a dependency regardless. I'll just pull
your branch in, so ignore patch 1 here, 2-4 will remain the same.

-- 
Jens Axboe


