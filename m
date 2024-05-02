Return-Path: <linux-kernel+bounces-166850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C28BA0D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A1C1C22481
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40326161304;
	Thu,  2 May 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1Q7Ifr4"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4625F874;
	Thu,  2 May 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676497; cv=none; b=X1Ao8sJ0rHNu+1BVLZH7x5iOHR8MKYJGhxnvqy3cQh5v2jYlzRuxGQdlwbCczfwQCsxjPXiED06WkadZQOcYSShc4YVJObwLRJxb85H7MPmN28hDBeTQkfgfUp0qeTOTR3X1mbR8uTv7HoPWc+txeo4PiiJ3ELU1wwS9LdP6nLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676497; c=relaxed/simple;
	bh=mu8rfKXOAdKbFd++Ire3kxBFhX7hIRUh9vpX9hFf9wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFseJhbc1k6GQUqkbf7YP/TSnNiwctsXZTWNwyccIfzdS5qGLcOco4fvW06su+gmfb7/2moBsOE6GUAeqFwfQThWglygOkCvH5mmuqP+d1zyiJ5TeLM7it1S1fuFencqEZVqiX1ptQLNjMvSkPmqQzoEWVz/c0q5n2xHPBoy+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1Q7Ifr4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so1316089e87.1;
        Thu, 02 May 2024 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714676494; x=1715281294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh35CEGjyQd/KulzELdyVZbVY0fU4Acs6q0cwM1JL4g=;
        b=G1Q7Ifr4bQw98VGvFijQU/llKeSTHwbc7S44+ItGOZ5h2Nw6i34ziFggzplplcUaDq
         BE70owmo3/C1JR/XlUQ+96auNhlCjSrq81WvZrh8+Eun1DnfLohWhiPK6IB4Ni7jpVND
         FKQm1C9lf1A8XdM1zEVAkHU2izqLqritb4ItioOC+ETojYj8lB0t3ifbUaG+Uo5M3drD
         Dyg9d75Y/jU9O8T7YAaK9U5joL/GL5iV9LPcWDJkTvWKysPQPMyPVZaq2xM63YlxfgI1
         yWKEjF8vbnQL8FoPRK6fU/uND6rjHE0aTeaRlG5eAQnJwCp/Fg6PEFhWHHnsJygVhtlp
         0usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714676494; x=1715281294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh35CEGjyQd/KulzELdyVZbVY0fU4Acs6q0cwM1JL4g=;
        b=vIqXTYeZz9w+ndjSvZzWB6DMAy7UMK8q258GjLy0XngFsyLG6mMfo6aWz2GYTGtpF/
         0CPBFP08Z00W8vKN//7TbfWjN5G7eJiJ7a4hW12jdSKZ2OKyK30SqXsS7rZ8fnBWftBy
         lbUrpYH8huCdZ59XkzV2VfgtDsqZshB09oOLeaq7uCllsft/dNN89inTR9s2dz2Ga3cK
         N66J3F9Hk6m/iXXWRKWvRuTjW5Ewfb38sURxS6w92HTpc32zf5ibkPrxKum9nnw+/IlG
         YZGyGT33tBmvAdi3pVGtzaNax/gzwxcSmB/v8+U4NIdHHNyk9rdOtV5iEvYysxs0sAux
         1D5g==
X-Forwarded-Encrypted: i=1; AJvYcCWd1Yt4HvGX44Fxh+BlvP/gzuFSpgeI58PGgyLNrsrlGCDu/yv0BuO/wcz1RM0SF4yjJHSP00WkwNM6Y4EkaUWiRrjFGTGejQmXLrHSSluGIvq8TKemd6j2DLLCAk6ZrqdoA1c+ABvNmg0=
X-Gm-Message-State: AOJu0Yx/4oN/monWdWhegwkRLfX2JA0d512QDVnaWYosYLIfXFZWfYju
	9RWXZBfh1XzUdIROYueLwZihAI96/pOO1qLPAHicgbe8r3dRUPw+ptpFTDcXTo6hW6RhktgJOzn
	EGG5P1iVxrzkiQ/J8tgY5y7kAWdM=
X-Google-Smtp-Source: AGHT+IFtdKlZWuM1wsaGzBv6v0w3MPzrm4tdeztfDeMWx9KsDau87uqaZLeguIyMdvA7lu+3GnzFmJ0hvz3cCht3hGs=
X-Received: by 2002:ac2:5dd3:0:b0:51e:ef7f:4e89 with SMTP id
 x19-20020ac25dd3000000b0051eef7f4e89mr457732lfq.6.1714676493797; Thu, 02 May
 2024 12:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430080019.4242-1-konishi.ryusuke@gmail.com>
 <20240430080019.4242-2-konishi.ryusuke@gmail.com> <650ed9f6-fa50-4a3b-939d-633f9e389137@acm.org>
 <CAKFNMomCzNMU0tjLkEchr=GQwSVW1zr1GAq7vUToeOvX-M3eVg@mail.gmail.com>
In-Reply-To: <CAKFNMomCzNMU0tjLkEchr=GQwSVW1zr1GAq7vUToeOvX-M3eVg@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 3 May 2024 04:01:17 +0900
Message-ID: <CAKFNMo=rkHF6urydfDbcvTbGzUEHmsTudVMm517pTE32vzqiwA@mail.gmail.com>
Subject: Re: [PATCH -mm 1/2] nilfs2: use integer type instead of enum req_op
 for event tracing header
To: Bart Van Assche <bvanassche@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 12:30=E2=80=AFAM Ryusuke Konishi wrote:
>
> On Wed, May 1, 2024 at 11:42=E2=80=AFPM Bart Van Assche wrote:
> >
> > On 4/30/24 10:00, Ryusuke Konishi wrote:
> > >       trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
> > > -                                   opf & REQ_OP_MASK);
> > > +                                   (__force int)(opf & REQ_OP_MASK))=
;
> >
> > Please keep the enum req_op type instead of casting that type away with
> > "__force int".
> >
> > Thanks,
> >
> > Bart.
>
> Hi Bart,
>
> No, this type cast is necessary to prevent the following sparse warning:
>
>   CC [M]  fs/nilfs2/mdt.o
>   CHECK   fs/nilfs2/mdt.c
> fs/nilfs2/mdt.c:155:43: warning: incorrect type in argument 4
> (different base types)
> fs/nilfs2/mdt.c:155:43:    expected int mode
> fs/nilfs2/mdt.c:155:43:    got restricted blk_opf_t
>
> What we're doing here is just changing the event tracing type back to
> int, and keeping blk_opf_t and enum req_op in the rest of the code.
>
> I understand if you have enough reason to ignore the warnings, but
> Why do you have to keep enum req_op type instead of int for event tracing=
?
>
> Regards,
> Ryusuke Konishi

Hi Bart,

Sorry, I didn't realize you were digging into the issue and talking
with the sparse and kbuild teams to resolve the issue.

Is there any hope for a solution?

If you haven't given up yet on solving the underlying problem, I would
like to withdraw this patch.

Thanks,
Ryusuke Konishi

