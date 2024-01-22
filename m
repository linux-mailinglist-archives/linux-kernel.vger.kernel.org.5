Return-Path: <linux-kernel+bounces-32418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F278835B79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E0F288AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801AEF500;
	Mon, 22 Jan 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL5tGsNW"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD9F4EB;
	Mon, 22 Jan 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907799; cv=none; b=Pm7UWHSVLkdbK2wSgDtSmeckA6sztVp7hbN2xlzYi+MRLWiJ/kkq+weUCwlj5+BqkWECM/C4zhgL/KrADvA9S52tuXzNuex/9Vk7XyKWYR/SDwGHL+/A8qJO97yUsZmsgDPzpMdyouI94AcZpAg/01K/ZibcNdag6+vi9b5B/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907799; c=relaxed/simple;
	bh=NkAADOM7nb3nJHV0kE9YVtfOI0rFBMbB2vTpVb+wdVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNQQVWJMAbOzLeA9bfApZVm8hi8fDQOIsUjbXlSoNSRixmO66RYORvextsFvAvNkWQZFJ1IOPCMf9/BEYgVry3SWinoyLEmjYDnGwZR0F7zLQ3GXkJ6JWKLjsHUONa0MfiArfbgMLGMiSm4mz3XiVD9lseW88LMY/IW3vASwhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL5tGsNW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-429af318342so25663301cf.0;
        Sun, 21 Jan 2024 23:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907795; x=1706512595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFrY6G60Aj2NUWP7R4VEsp/j/Y7W4OPZlVPvuZYRf7U=;
        b=CL5tGsNWaSOg/Ls/nRuIjpQ9221Ah4OyeBq1zx+F8iLgBovI0tPj1usenLTvL0dFeC
         ckaoFRwSjWtgJ0pPHy03EW7s+uVVMtI0LaahByBcOklh/CmJYnQ4Hg3hj3xlbfaCHE6w
         pKEiE0G/sxSMo9p7f++oCS+xj13o7suzRRm+v3K8MqGac5PcTMOE2JzV26a6hJpCTHU8
         4hRAbibHmUmpEID4ggmWgxJ7OTHa90flHLi+tsNewwe/6uiKUsW/amJgVFeopwjjy7HB
         w4qNkySl/ITKAIHNrJhKi9Nx7yL0xND6HunnxvoSU7JZu2cgMXpVjntLHol4Ug7ikP7p
         Vn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907795; x=1706512595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFrY6G60Aj2NUWP7R4VEsp/j/Y7W4OPZlVPvuZYRf7U=;
        b=sxKPuNumMdMiXAIlIOyP+dossHiMjz6AkAzH43HXVUU6F5HrsfFHrzrz+V3uI15ysY
         Mq/QNQp8QFqymG/14OU0QWFIcgb37F90L5yFtsYUT/Iac4MKjRu9GsVUiVNcXkmpo0ju
         HLOlQlJtKY3LIRe3M+R3Z++p+CupTimaZnA7fnyQC7lHj4hAqIlIeZrtP2GWe13/9d/N
         e/tvHe+TENaHyc3tYfm1HRvQLQdLIsm8/2joR5WLbiBdoPaSNJzO/tPebIAMfhe/sn1F
         3PWAUPixixZoR2z6+jj+8mgplOzjBzAx7KTxeeGJKBKdih4wORERtuE7LiQUN24R6pwi
         lFvQ==
X-Gm-Message-State: AOJu0Yxs8GDUn+4SqdqQSDGB7wXOthBfGmPTQzpR0KokUsBWUuLKIG6s
	5zwqFxq6lIH97km1f2+JSu2h6j3gPVPhc0hykosg9/LHtjB4LTaCgwiEvWGSJQJvdumlqxPbWIl
	rXc48BAkgmuYm7hlSgqTNF7Xynm4=
X-Google-Smtp-Source: AGHT+IFHvFLh501PK0oM3jZ/eFsDEQtqlc7uSmHrZDLn2DY/iKWvCWJ0cNpZSeapYK4yQqc6ua1md893fN8t9VeOsL0=
X-Received: by 2002:ac8:5a50:0:b0:42a:159d:a955 with SMTP id
 o16-20020ac85a50000000b0042a159da955mr6553070qta.12.1705907795270; Sun, 21
 Jan 2024 23:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1703556550-2858-1-git-send-email-dongliang.cui@unisoc.com>
In-Reply-To: <1703556550-2858-1-git-send-email-dongliang.cui@unisoc.com>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Mon, 22 Jan 2024 15:16:24 +0800
Message-ID: <CAPqOJe0H2h+ObwpP=05OtwOTE254kV3LZTVXE6jdNawT1EVzFQ@mail.gmail.com>
Subject: Re: [PATCH] block: Add ioprio to block_rq tracepoint
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Hongyu Jin <hongyu.jin@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Can this submission be uploaded=EF=BC=8Cor is there anything that needs to =
be modified=EF=BC=9F

On Tue, Dec 26, 2023 at 10:10=E2=80=AFAM Dongliang Cui <dongliang.cui@uniso=
c.com> wrote:
>
> Sometimes we need to track the processing order of
> requests with ioprio set, especially when using
> mq-deadline. So the ioprio of request can be useful
> information.
>
> Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> ---
>  include/trace/events/block.h | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 0e128ad..e84ff93 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -82,6 +82,7 @@
>                 __field(  dev_t,        dev                     )
>                 __field(  sector_t,     sector                  )
>                 __field(  unsigned int, nr_sector               )
> +               __field(  unsigned int, ioprio                  )
>                 __array(  char,         rwbs,   RWBS_LEN        )
>                 __dynamic_array( char,  cmd,    1               )
>         ),
> @@ -90,16 +91,17 @@
>                 __entry->dev       =3D rq->q->disk ? disk_devt(rq->q->dis=
k) : 0;
>                 __entry->sector    =3D blk_rq_trace_sector(rq);
>                 __entry->nr_sector =3D blk_rq_trace_nr_sectors(rq);
> +               __entry->ioprio    =3D rq->ioprio;
>
>                 blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>                 __get_str(cmd)[0] =3D '\0';
>         ),
>
> -       TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> +       TP_printk("%d,%d %s (%s) %llu + %u 0x%x [%d]",
>                   MAJOR(__entry->dev), MINOR(__entry->dev),
>                   __entry->rwbs, __get_str(cmd),
>                   (unsigned long long)__entry->sector,
> -                 __entry->nr_sector, 0)
> +                 __entry->nr_sector, __entry->ioprio, 0)
>  );
>
>  DECLARE_EVENT_CLASS(block_rq_completion,
> @@ -112,6 +114,7 @@
>                 __field(  dev_t,        dev                     )
>                 __field(  sector_t,     sector                  )
>                 __field(  unsigned int, nr_sector               )
> +               __field(  unsigned int, ioprio                  )
>                 __field(  int   ,       error                   )
>                 __array(  char,         rwbs,   RWBS_LEN        )
>                 __dynamic_array( char,  cmd,    1               )
> @@ -121,17 +124,19 @@
>                 __entry->dev       =3D rq->q->disk ? disk_devt(rq->q->dis=
k) : 0;
>                 __entry->sector    =3D blk_rq_pos(rq);
>                 __entry->nr_sector =3D nr_bytes >> 9;
> +               __entry->ioprio    =3D rq->ioprio;
>                 __entry->error     =3D blk_status_to_errno(error);
>
>                 blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>                 __get_str(cmd)[0] =3D '\0';
>         ),
>
> -       TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> +       TP_printk("%d,%d %s (%s) %llu + %u 0x%x [%d]",
>                   MAJOR(__entry->dev), MINOR(__entry->dev),
>                   __entry->rwbs, __get_str(cmd),
>                   (unsigned long long)__entry->sector,
> -                 __entry->nr_sector, __entry->error)
> +                 __entry->nr_sector, __entry->ioprio,
> +                 __entry->error)
>  );
>
>  /**
> @@ -180,6 +185,7 @@
>                 __field(  sector_t,     sector                  )
>                 __field(  unsigned int, nr_sector               )
>                 __field(  unsigned int, bytes                   )
> +               __field(  unsigned int, ioprio                  )
>                 __array(  char,         rwbs,   RWBS_LEN        )
>                 __array(  char,         comm,   TASK_COMM_LEN   )
>                 __dynamic_array( char,  cmd,    1               )
> @@ -190,17 +196,19 @@
>                 __entry->sector    =3D blk_rq_trace_sector(rq);
>                 __entry->nr_sector =3D blk_rq_trace_nr_sectors(rq);
>                 __entry->bytes     =3D blk_rq_bytes(rq);
> +               __entry->ioprio    =3D rq->ioprio;
>
>                 blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>                 __get_str(cmd)[0] =3D '\0';
>                 memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>         ),
>
> -       TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
> +       TP_printk("%d,%d %s %u (%s) %llu + %u 0x%x [%s]",
>                   MAJOR(__entry->dev), MINOR(__entry->dev),
>                   __entry->rwbs, __entry->bytes, __get_str(cmd),
>                   (unsigned long long)__entry->sector,
> -                 __entry->nr_sector, __entry->comm)
> +                 __entry->nr_sector, __entry->ioprio,
> +                 __entry->comm)
>  );
>
>  /**
> --
> 1.9.1
>

