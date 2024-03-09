Return-Path: <linux-kernel+bounces-97972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F278787729B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D711F21FB7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4AA2C1BA;
	Sat,  9 Mar 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="axulDVbW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF823741
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007544; cv=none; b=YAtuVq87KtK0cGtOIlVwVPYAmN/RgXGz4wYp3+Py5fSqvcbWG0xaGaUdSd6uslwOpkLN60Lc9pYxovAwLosbgXWMOSyKljzjeyJp/B3MudCfS7M+KP6KIfhkQX25Z5mhQX4ui8VjIAe36iygqFtWvkio7WMMGTq0pmvdJjfafpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007544; c=relaxed/simple;
	bh=/PtZj1THudgmWXg55mQ9XJrnkglTEegrHaESQa9gBFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDdguZK/7Njx27kVT0NgaXxx/GfWhKBY2TEeJk/+x5q2GqpllT2lRtEVVEMxNBe0mwKQ7OwQ/Cm359T9yYgsUoVK0YJJrz5o8Q1tfjW+cxnF7LU7//oc24YFkfPgs0TEBi7w0YJQ/tyIfakNiIQ7p8W9ifSICgawGERTik8jgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=axulDVbW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-568307fe62eso2040384a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710007540; x=1710612340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ITjBMAYZbjYo7OABjVqPiHGlJq6tqTY9J1maIuyk9g=;
        b=axulDVbW/tDc/D7TG7PSTPnl9Xui3OchqCkM73ZRnmnOv5IRc469alZ5v9ZFoTSpcp
         +FFzztrB39goA5QqtDDBHfHkTH2TcjRNGBdPVGii23PTpMsvx9PqQzwKtP9pnXoOOhnK
         3GU6tU+YdNk3ZXLE8sJiXrVSnRFgn+q9gHZRd3mcNsxoVebULScKXFPtJCNdIa/lCKh6
         QJMrFH09fbLogXOPT8xRYYF+P0MXeb3yejjTb0eY020BLskkRyiQ+twotwZvUrZ8o2x1
         lc6x834HnT2YwTsRPVgwzOmScPuVvqki9kCvtAZuv8Be7S5XsnCUGJmsapn9Cc1xcnnB
         tsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710007540; x=1710612340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ITjBMAYZbjYo7OABjVqPiHGlJq6tqTY9J1maIuyk9g=;
        b=N4zXy9E5n3V293MJR0LYPNT0DI6ExjgOdPE0sMsdVhe4qv+tqT1wrfNGr11SL/LO1s
         pNKGgvVGGhHOpPIwTbSaQpNYq0rx5ycgUHIyKfDD5LLB5DN0GOz3xVqV6EMeSBqCA8Qb
         qrXElNSxqVpsdZf5V2jEoYyx/UwLCuj/v+LH0c1fAGcK3eB/2W4R3xPcQeHKURyjKfWa
         IxUEYbueQ1Bk/YQn9JZytfz3nFFCmfftPJ0B7Ucwz2WmoIX3biimS8KoInPjHsk1GWZo
         AvKoYvLplcypp/OCow4F1ukaI9TvSHt4O7dJ+DF+hvkjfWHu4j1lUJ6UohbGv9bn2H0q
         bIzg==
X-Forwarded-Encrypted: i=1; AJvYcCUIN865MVTaXYldqsiA2V8dIbg491shO0T0tite98aaoGOfITL/6ZeqIPC313Aw/CdFbcWpZVLjMVITyqUL+lQLPxGOByU6kOVPfZ/v
X-Gm-Message-State: AOJu0YxmQMgScUaLuF09OBaltSECV6VVHBNbcBAVEs3oMKhFfDkJ3GBm
	IZAJwMGq1kxMJze2XANMQOUrOiLGBK35EdLYWB5hNiUJSDk9RIiQPbRfyrIrCohBlAFuKJC44bg
	n2iCTdjO3/g5z6SykhueuVUkxV8aohRYdq19Jag==
X-Google-Smtp-Source: AGHT+IHvRfRvVdOpSqga2VG+TMQSk8gbq3W0T+xahiDiFkVNTHojG2kqWZT3iOcIpvoLdLnWdwXVoH7BCpXTdklDjPY=
X-Received: by 2002:a50:8d51:0:b0:567:b54f:86b3 with SMTP id
 t17-20020a508d51000000b00567b54f86b3mr1426814edt.20.1710007540217; Sat, 09
 Mar 2024 10:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701540918.git.lduncan@suse.com> <437f863520874ee386b6882ef749bf8d988839ca.1701540918.git.lduncan@suse.com>
In-Reply-To: <437f863520874ee386b6882ef749bf8d988839ca.1701540918.git.lduncan@suse.com>
From: Lee Duncan <lduncan@suse.com>
Date: Sat, 9 Mar 2024 10:05:29 -0800
Message-ID: <CAPj3X_UKdC_sXG=qm5w=BeufDC0p_88xF2nvkBAB0SXzJfo3xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: target: iscsi: don't warn of R/W when no data
To: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, dbond@suse.com, 
	hare@suse.de, cleech@redhat.com, michael.christie@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I didn't see any objections to this patch.

Are there any issues?

On Sat, Dec 2, 2023 at 10:45=E2=80=AFAM lduncan@suse.com <lduncan@suse.com>=
 wrote:
>
> From: Lee Duncan <lduncan@suse.com>
>
> The LIO target code has a warning about setting the
> read and/or write header bits with a PDU that has zero
> transfer length, even though the code mentions that the
> SPEC (RFC 3720) allows this, and that some initiators
> set these bits. But in practice such initiators end up
> flooding the logs with thousands of warning messages for
> IO that is allowed.
>
> So change this to a debug message, and clean up the wording
> just a little bit while at it.
>
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> Reviewed-by: David Bond <dbond@suse.com>
> ---
>  drivers/target/iscsi/iscsi_target.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/i=
scsi_target.c
> index f246e5015868..c82dc2cd08b3 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -1039,9 +1039,10 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn=
, struct iscsit_cmd *cmd,
>                 hdr->flags &=3D ~ISCSI_FLAG_CMD_READ;
>                 hdr->flags &=3D ~ISCSI_FLAG_CMD_WRITE;
>
> -               pr_warn("ISCSI_FLAG_CMD_READ or ISCSI_FLAG_CMD_WRITE"
> +               pr_debug("ISCSI_FLAG_CMD_READ or ISCSI_FLAG_CMD_WRITE"
>                         " set when Expected Data Transfer Length is 0 for=
"
> -                       " CDB: 0x%02x, Fixing up flags\n", hdr->cdb[0]);
> +                       " CDB: 0x%02x, cleared READ/WRITE flag(s)\n",
> +                       hdr->cdb[0]);
>         }
>
>         if (!(hdr->flags & ISCSI_FLAG_CMD_READ) &&
> --
> 2.43.0
>

