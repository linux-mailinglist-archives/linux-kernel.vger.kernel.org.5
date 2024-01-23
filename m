Return-Path: <linux-kernel+bounces-36192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093EB839D57
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E51E1F22CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409335467D;
	Tue, 23 Jan 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M46sjmWU"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4E1A27C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053545; cv=none; b=Cq1qPA12gtZW5G4EYqDBBZ8JhyhCXuWGzyK005MsR2C4Rlq8OnotudqR433EjuwVN9tsLUFbIBqwvOdNONiRsEt9LzcAsWS/FfmBD9p/YQlEhrFFw9zEWSFsryTZYyhh4kdQL9e855eiv3VU4fOWF5VlmVBnGbIGw9JzqppJqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053545; c=relaxed/simple;
	bh=j1CrBJz2L1DRJzsB2gKW/vfIAdOvL4D8ktKZk6tykvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBkfs/XuFUbkyI66d4tI8z3PCpgQmIKQpuASv7FgBx6+r4iPBD5om7PAlcLrvfowagRDqzNhqgeI3eGmENUUQI+bbIu6Tma+z1VQ9fu0jrYeIzQyYd3Nq47HnVX5/GIWDZrnMRwnL2CnzQJBZvoaTYbogiG7NfplBCeKajRqDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M46sjmWU; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21424f34003so1413622fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706053543; x=1706658343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1CrBJz2L1DRJzsB2gKW/vfIAdOvL4D8ktKZk6tykvg=;
        b=M46sjmWULxTUsneMZ/vipoOQFYFTk2w2hgeZfuIWzdnT0PkPmW4maQdOr/svCn5cFb
         fP8CgYThICcmLmxBXdqsDoOobVcwIG/h7kYTGZj3cw7MPrEPk0C7K5BrG5fhPpTaeRNz
         f4xcvE6URpmBU9U2Gawv5Y2BjyUqlwC44tcHn9LjAzXI9o/LHlM1uAiJ0mc1+TOqWYFO
         B7VO1jmPP1xcMnUBsTKLnKUKJZrwCza7oMhEfLh85bfKVouPKJZqHPsKYamhPMeSCqjO
         ac9iDgw53rppV158UK66KcwbRyIaORrQGd43WT/ihgM2K1goJtbq1uoqacMnEmmEZUTN
         j6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706053543; x=1706658343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1CrBJz2L1DRJzsB2gKW/vfIAdOvL4D8ktKZk6tykvg=;
        b=oWg+ueftRF0izX6rRf6WCX7J1EmxQqW8EQV9oHR8x6mPcb1uuwPU8CH9oYP8HOya6O
         MlkdabvS0tmrF+FaKmg4oeeb2FgkoISXQmVDd/Mzk6rC4DXx3kErreZoxWBpqosdbW4o
         M+wjvZyPluhyp5bXZQ2Y2DWMtOYrmaOKj67q84kAWQ+HbTqW45LjpvfaaZVJ1/0JzXOc
         gVg/jAsR7qZz8lswQio2Bz0mK7vTBE9mu3SYbA4KFuZKrxAsqYAnSNBVJSWSv3n3PXMu
         lSHJtHrh4f8M0HGnI31eIoU3ZOz1QWyse8KYnz8BBXtOjPV2wehB279FTLHLQ0aUYfYb
         NK7Q==
X-Gm-Message-State: AOJu0Yxy+JlTaJSMJdoQBFMMVnhhFKquyJTSDem5Zv4XBDfdmFGYC1qM
	YLVWn00/8CT4231OGJNyWZcJuJAojFmWM9JLXlwaxLWl+l7/frSua08CJVrIgnEhnTHOeT6qYhB
	plkVSAotNsBQD6SbRu2tJa0c/E2bv30GOQo2j
X-Google-Smtp-Source: AGHT+IGvzfSbHNzjk7FgOJtSb4oWcEzwNdZ36vFtb85PuXY0lFCIGgC6oCHTP5NzniWRvjmRh7qSjzNhJUncH3IalrA=
X-Received: by 2002:a05:6871:341d:b0:203:2192:d738 with SMTP id
 nh29-20020a056871341d00b002032192d738mr2198209oac.92.1706053543032; Tue, 23
 Jan 2024 15:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122155023.GA26169@redhat.com>
In-Reply-To: <20240122155023.GA26169@redhat.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Tue, 23 Jan 2024 15:45:31 -0800
Message-ID: <CADBMgpxNUoaermXsEj0Hs0KT=Q0xRpz5y+Px=oAGDP2Efg8yyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] getrusage: use sig->stats_lock
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Dylan, do you have something to add?
>
> Oleg.
>

I have one last question -- is there possibly an edge case in which
the hard lockup
can still happen? How likely is it for many writers to force enough
readers to do a
retry on the seqlock, disabling irq and causing the lockup? Is this
not a concern
because there aren't many writers?

Thanks,
Dylan

