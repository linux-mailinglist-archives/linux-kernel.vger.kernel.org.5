Return-Path: <linux-kernel+bounces-40797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F883E5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7C11F24870
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9391F2563C;
	Fri, 26 Jan 2024 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Elzshj3+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9214595F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309388; cv=none; b=CiWX1wpc2eLhHBzbT2dAnm/lbVnjezh8s3nLdEZl8XVQMxI2t/GzKd3uZbzZGhlL7pwsYeqThCEFv/Hb+YudKJtY2UdVJgaFtq+r4LUyyoUxipzINjGICxqfqevsRslxVYVet08As+kSfv9keDcVymK8PpZqSquj/AaU+tq0lJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309388; c=relaxed/simple;
	bh=nrNcgKqKEthh661LXbilbwqQcwL+DlDRnFwg8jZPBIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwccDC9L9pArGIdcIWjlATxGm23qxNrKJQoI4NxMV3csTILygdZkvwz8wH2nIeSP2byw8yvDdYfMZWjXaday/cxrmKxyRehs5J/OKyL2JypOAWWzXIyNuOqe9JUnah3N9OzihjNAqEjqwQ6YuJmMDPozsIKNUe8xw0PCHMguWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Elzshj3+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so790357a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706309385; x=1706914185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mat57ocNjJ+2j0yfyUONN2djrK+fYcTcdMIfJXsJdeg=;
        b=Elzshj3+mtNXeaGiELhCIsZspMlq+JNzAmO+Dx8bMiTivsU5WSyxufsX0a2Hr9q7Bs
         mlV9MXE8vVm1B9TUQ4B3/2q8jGKUmF6ttTAmnT+LCFecEFpJuKsuYCWvIT9o+6peeK7m
         1fP1+kBrNncMRFRdDgA7sVxjjxcXbcHX2bs18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309385; x=1706914185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mat57ocNjJ+2j0yfyUONN2djrK+fYcTcdMIfJXsJdeg=;
        b=PWwcIeNt47MtjHZWDDgHi4PDjj378zQuLj/sGYcr+8i5La1I/6NR4OraYXxH+f6/6M
         F1Fp7ZZT1scOEEd3wMD6FiZJ7dB34YI403bXChBLvG/aaobvgLcSZJxllTB3wq5vO2tm
         VGPT8sl4iZri6q/d8UWG4rjWjQo3Pu+cbC73qolhd8UG/yOYhKqI0hT9/ZwWfq9GxZcI
         8YQNgO+WPYt41gn9gCKHpEUFnOv3KqGyGcMsK2nn1opNQu51n9YYokzTFsoxdEltarAT
         rJoS3hUM8SHdQ9RPY/gxlf3jx+gA4wLTBgNXmhhJXyCOkM2f9dW4GiVNjgSgOxEoNA6z
         RoRw==
X-Gm-Message-State: AOJu0YzuAIuCNAJl5v2qJFW2QrfYN6cCOslN/+/mFAofiowZ29OWDEeK
	91+Ysdxmf6mrVYavGXeVT55ICXrf+nNPrSxWq6453wGkW1KlzAbCefjHiKAPqTcBYdvPfU52Quh
	wuDYMzg==
X-Google-Smtp-Source: AGHT+IH1lEtrV59BC9lAjUoL9BfsGHbr7zNTj2D9nk3ATbkJqA06pLOgr88bPK5vPQniHGC7BmC9lg==
X-Received: by 2002:a17:906:ce33:b0:a35:368e:d5b1 with SMTP id sd19-20020a170906ce3300b00a35368ed5b1mr78131ejb.48.1706309385297;
        Fri, 26 Jan 2024 14:49:45 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906085300b00a30c4871712sm1071840ejd.202.2024.01.26.14.49.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:49:44 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so790344a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:44 -0800 (PST)
X-Received: by 2002:a05:6402:b51:b0:55d:37ed:c0f0 with SMTP id
 bx17-20020a0564020b5100b0055d37edc0f0mr256645edb.2.1706309384299; Fri, 26 Jan
 2024 14:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
 <29be300d-00c4-4759-b614-2523864c074b@efficios.com>
In-Reply-To: <29be300d-00c4-4759-b614-2523864c074b@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:49:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpyv+fhxzV+XEQgsC+-HaouKT7Ns8qT31jkpN_Jm84_g@mail.gmail.com>
Message-ID: <CAHk-=wjpyv+fhxzV+XEQgsC+-HaouKT7Ns8qT31jkpN_Jm84_g@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:41, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Yes, there is even a note about stat.st_size in inode(7) explaining
> this:

Good. Send a patch to do the same for st_ino.

             Linus

