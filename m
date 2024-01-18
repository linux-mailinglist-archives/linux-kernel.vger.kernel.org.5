Return-Path: <linux-kernel+bounces-30326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A25831D22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A1C1F23C85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF33A241E6;
	Thu, 18 Jan 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pA0p/dlO"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93D24B40
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593737; cv=none; b=gSa6cvmI40w6lWi+JpX4SzcgLdIADThNme6b4m+WbKITKs9T+vEsmOD4bfYnrSd1bEJw3Rva4VdGsy+ahteDh7Bq+Ei3bCROXEf0H24WZIfxB3LF3jHPVJQCXjLwIvcZb3EDZEIJOQ4yAptCQx/I6iMe3g89VpFaMxfmQzVwhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593737; c=relaxed/simple;
	bh=7/CWAjx5zfqKJ2XKGA+zCddsRmnknHYAn2kIAh+LnQ8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=OISIUNOkaYT/eJZ+qEGsy1kdxvAJPAd/anmnotxPivVBILVrOtJzwN82z5070t9rAVDCy6rtY26yJzTNt6DV0nteqPR0bY3+hxwp7CI4wU18mbPAsaGZa+1ME4fX/4yzeL1v35j0Q7qwQqHHQT/KLbTgDXGK0MBh+XmsCK0sFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pA0p/dlO; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35d374bebe3so9827755ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705593733; x=1706198533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hto2SU4R3yAYwp81hj4Efa1CV18LRXcWhBAicey50VM=;
        b=pA0p/dlOaP2FLSI44v0AjlgWAVOgEyKcTWu8IOUO2YH36DKCcbcsz6UKV7Jz56eAJQ
         lWB4G+eIglQweQQs9NCTkpgRtdD8ZWuSxRmjKxtsCZ7Z86oiv4GNkwhTarMlcOfb3ClU
         5djgNM3TKg+5fx7Sbxw5+SEF+tS1FaOipUaUhYQdL19XON7Sm6iNDBzXr1TF3S1Fls/z
         ijvpDFaeozNURh2Z3nw8cIczsu/kFMYHAYg14q/f/TI2Utx345vvNuTqcdLOlFurjmEF
         m+pro5/EmM0yjCAXPROBAsYybd4VDPBU+kfEYieY+zr6QGNtC2n+WfPEEeW65/FB/mjU
         WvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593733; x=1706198533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hto2SU4R3yAYwp81hj4Efa1CV18LRXcWhBAicey50VM=;
        b=JqD3gOQrtS9ESRncnJ6y3JQtVFOZM1Hud2urwnzzvz3v4dblJCag6WvlpEaB/3o+ag
         uS5ufHqmhHUSAJv0HgNiO5z3NJDfsQD6qMUly0Vfb8xBI8kyNXMkEekrQ6PSaOfXGS3X
         2V9pznsnL5votiJt0vP9mHo4Ii5tTvhj+UkGb2f1V3Ihhuyodj7L39pLshLO4mPhKQZ+
         PATHFRM9oBkBq5W7O6ncjuS68jWJN4hIQhxVa9Pe0147/1raAc8df5E/e433uz/LmZhI
         N8D5uo1MSoaKrhaREh4jTjvLTIHVgXK0oODlqgO7LgF/ObQn0axynUl2j+buo+DlPq+J
         iJdg==
X-Gm-Message-State: AOJu0YzcepE2k6gCm/Kvk/j+mfOd734GRjwzc9Aaf5Xe6hefIfA+Ourc
	uIn0G1e1H+yLQWoNkxvhtT+pnDnuMQuFMB4HVXDjYvSPg+EheHr1yiaOkKqX5qw=
X-Google-Smtp-Source: AGHT+IFnCgCMwuQLn+46tpajB2tVEuF0J1Am5tT3Fme1GmHSkQ6lEQkASyB/fJpRQd7Vv/I6DjrRlQ==
X-Received: by 2002:a05:6e02:20ef:b0:360:2a3:7e5f with SMTP id q15-20020a056e0220ef00b0036002a37e5fmr1936347ilv.2.1705593733508;
        Thu, 18 Jan 2024 08:02:13 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a02cc8b000000b0046e7578c703sm1061800jap.21.2024.01.18.08.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:02:12 -0800 (PST)
Message-ID: <fab1b4da-cbe6-49d6-9159-29fb405ca64f@kernel.dk>
Date: Thu, 18 Jan 2024 09:02:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
Content-Language: en-US
To: Rich Felker <dalias@libc.org>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Christian Brauner <brauner@kernel.org>
References: <20200831153207.GO3265@brightrain.aerifal.cx>
 <CAG48ez39WNuoxYO=RaW5OeVGSOy=uEAZ+xW_++TP7yjkUKGqkg@mail.gmail.com>
 <a9d26744-ba7a-2223-7284-c0d1a5ddab8a@kernel.dk>
 <20240118155735.GS22081@brightrain.aerifal.cx>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240118155735.GS22081@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 8:57 AM, Rich Felker wrote:
> On Mon, Aug 31, 2020 at 11:05:34AM -0600, Jens Axboe wrote:
>> On 8/31/20 9:46 AM, Jann Horn wrote:
>>> On Mon, Aug 31, 2020 at 5:32 PM Rich Felker <dalias@libc.org> wrote:
>>>> The pwrite function, originally defined by POSIX (thus the "p"), is
>>>> defined to ignore O_APPEND and write at the offset passed as its
>>>> argument. However, historically Linux honored O_APPEND if set and
>>>> ignored the offset. This cannot be changed due to stability policy,
>>>> but is documented in the man page as a bug.
>>>>
>>>> Now that there's a pwritev2 syscall providing a superset of the pwrite
>>>> functionality that has a flags argument, the conforming behavior can
>>>> be offered to userspace via a new flag. Since pwritev2 checks flag
>>>> validity (in kiocb_set_rw_flags) and reports unknown ones with
>>>> EOPNOTSUPP, callers will not get wrong behavior on old kernels that
>>>> don't support the new flag; the error is reported and the caller can
>>>> decide how to handle it.
>>>>
>>>> Signed-off-by: Rich Felker <dalias@libc.org>
>>>
>>> Reviewed-by: Jann Horn <jannh@google.com>
>>>
>>> Note that if this lands, Michael Kerrisk will probably be happy if you
>>> send a corresponding patch for the manpage man2/readv.2.
>>>
>>> Btw, I'm not really sure whose tree this should go through - VFS is
>>> normally Al Viro's turf, but it looks like the most recent
>>> modifications to this function have gone through Jens Axboe's tree?
>>
>> Should probably go through Al's tree, I've only carried them when
>> they've been associated with io_uring in some shape or form.
> 
> This appears to have slipped through the cracks. Do I need to send an
> updated rebase of it? Were there any objections to it I missed?

Let's add Christian.

-- 
Jens Axboe



