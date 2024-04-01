Return-Path: <linux-kernel+bounces-126686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE4893B74
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6EC1F21BB9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A5A3F9C3;
	Mon,  1 Apr 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nN+Zhx0/"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE383FB1E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978163; cv=none; b=HrZKC+5kKh8bKAc2jXbNt7obznt9r0dVNp4xHqlQZ2K6dtoDzU8RmEWkw/vp9fl9RNXlbR0mCzmIvN+5utYVDer4y8bWDKBq426eacbSTpHbeBY1rMkrLJn6EEsjjmwOtR0Lc0teWkHs9MMCqvGP0qtsK1zqWxwUr6/kUpKZ1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978163; c=relaxed/simple;
	bh=4M4MuUubQSIRKLZKPgzJza5Yg3ff1EyhRlATBvU5lQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHm3k7Y1egug4mr7uqJjtBsH4yf17cnPpkjCEfrbcH0SO1uro++KbxWSWCqSLAeM9GaNTbf3Q0lPVHdVCV/sVuOdmyCIR8qDfQfbemEKqaJeNLk9kqJ1L+g24yT4RllcaYFzLI/dcCmfPhJHJTtpOd9dSiT5RiQIucYtmNokA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nN+Zhx0/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso2536734a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711978161; x=1712582961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igZz4DG2aBo5XlteLJPBb/+8rJIvsiKaHb3GZJV4VP8=;
        b=nN+Zhx0/mUn6v0AT9QHxjp28ti4s2HWrU1GY3x3O6yk3kbom7aBS0JBJmaZUdKufvq
         plthsoBvzFVyA1fjBxenWvAGQcHuPFofJ/5SnVlRBrp4bcQVQAumf+x7YytfShTko4O7
         tfLCI7uYjoJdfmdQY4UH1p29TlllMNdDB7njaPsRVwFqMR739RCsY/dHJysPBPKOLHqt
         8Nm+lIz00jhJrubxNWXrdSjJRol4pC+PN+gfjJvtg2prsamgDf88JOIM8E840Zmsd977
         DP305iCtsqhqA0/wvri0zzsuE1HTNZui9sLzQS0iONYnES5iTXJiJ9kLrOaPnx4z/NP5
         ++RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711978161; x=1712582961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igZz4DG2aBo5XlteLJPBb/+8rJIvsiKaHb3GZJV4VP8=;
        b=B41TO5xkDwvsAc7QBHIfFjVuMEONU3tNiN/j7CJ2yfoHJ5CjPD81N/XMavOicUktJG
         fla6bA6A4fsbXqnngMhG8Ph9pMmtWJXIGlBksWZM4PIDSbQx60JOWgegKGM/s9lQhXyf
         X/Xewujyu4u3/BNaZkIr000AL/5T9IwHW9WpyTA/vDExUlBxVOmV9eu2Xqb2ylaj4UI0
         bVru3COUVZP0k/9qs5SQpBKrx7Fhuwh6L1tyVPPsWCwv841i5mB0757DROYNOGzkHzBG
         XRHB7BOoJPRElsyPxq7jW5VLcMNA2o/gOmZq4DTD/th9uORhOq0wqNZ1DF0dcER0v2mE
         rXVg==
X-Forwarded-Encrypted: i=1; AJvYcCUTLagTeDIYVRPN5X1/L39wWS/jmxQJ4X+KskFSKVBFOP4YKYTlRhUjaTbwFja56kej/+wnJfDTbO0yPQn/821rDbWwszM8DI9XBFxY
X-Gm-Message-State: AOJu0Yz0//JIfs0ks2IJr4c/R+q887nQEOpNycsZuh4N5xT917Gz6j88
	qxBpm2PleeV6AIgfhyKjToSfbuZdZOpAS+aoNJUzji0UDNy9eGICRL7+SJzPFZmj1s5tHaYc/na
	RvTGYYFx6D/fXeIMR6/j27r4jaafGRnFNoBeS
X-Google-Smtp-Source: AGHT+IEBPxB5PgFKwWlCsDWhkUrlsbgYprPrx312H7gGuiVcbcCCEQOB9REDtm9NTjOiD8q99cvt+KkK7MiZtFt0GOM=
X-Received: by 2002:a17:90b:4b04:b0:2a2:2dad:8026 with SMTP id
 lx4-20020a17090b4b0400b002a22dad8026mr3558868pjb.20.1711978160771; Mon, 01
 Apr 2024 06:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094050.2815699-1-senozhatsky@chromium.org>
In-Reply-To: <20240329094050.2815699-1-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 1 Apr 2024 09:28:42 -0400
Message-ID: <CADyq12weZHtQaV_muEOe-gggu07hiun+xDuMJmqaxv8oyz9pLA@mail.gmail.com>
Subject: Re: [PATCHv2] zram: add max_pages param to recompression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:40=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Introduce "max_pages" param to recompress device attribute
> which sets an upper limit on the number of entries (pages)
> zram attempts to recompress (in this particular recompression
> call). S/W recompression can be quite expensive so limiting
> the number of pages recompress touches can be quite helpful.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Brian Geffon <bgeffon@google.com>

>
> ---
>  Documentation/admin-guide/blockdev/zram.rst |  5 ++++
>  drivers/block/zram/zram_drv.c               | 31 +++++++++++++++++++--
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/=
admin-guide/blockdev/zram.rst
> index ee2b0030d416..091e8bb38887 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -466,6 +466,11 @@ of equal or greater size:::
>         #recompress idle pages larger than 2000 bytes
>         echo "type=3Didle threshold=3D2000" > /sys/block/zramX/recompress
>
> +It is also possible to limit the number of pages zram re-compression wil=
l
> +attempt to recompress:::
> +
> +       echo "type=3Dhuge_idle max_pages=3D42" > /sys/block/zramX/recompr=
ess
> +
>  Recompression of idle pages requires memory tracking.
>
>  During re-compression for every page, that matches re-compression criter=
ia,
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index f0639df6cd18..4cf38f7d3e0a 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1568,7 +1568,8 @@ static int zram_bvec_write(struct zram *zram, struc=
t bio_vec *bvec,
>   * Corresponding ZRAM slot should be locked.
>   */
>  static int zram_recompress(struct zram *zram, u32 index, struct page *pa=
ge,
> -                          u32 threshold, u32 prio, u32 prio_max)
> +                          u64 *num_recomp_pages, u32 threshold, u32 prio=
,
> +                          u32 prio_max)
>  {
>         struct zcomp_strm *zstrm =3D NULL;
>         unsigned long handle_old;
> @@ -1645,6 +1646,15 @@ static int zram_recompress(struct zram *zram, u32 =
index, struct page *page,
>         if (!zstrm)
>                 return 0;
>
> +       /*
> +        * Decrement the limit (if set) on pages we can recompress, even
> +        * when current recompression was unsuccessful or did not compres=
s
> +        * the page below the threshold, because we still spent resources
> +        * on it.
> +        */
> +       if (*num_recomp_pages)
> +               *num_recomp_pages -=3D 1;
> +
>         if (class_index_new >=3D class_index_old) {
>                 /*
>                  * Secondary algorithms failed to re-compress the page
> @@ -1710,6 +1720,7 @@ static ssize_t recompress_store(struct device *dev,
>         struct zram *zram =3D dev_to_zram(dev);
>         unsigned long nr_pages =3D zram->disksize >> PAGE_SHIFT;
>         char *args, *param, *val, *algo =3D NULL;
> +       u64 num_recomp_pages =3D ULLONG_MAX;
>         u32 mode =3D 0, threshold =3D 0;
>         unsigned long index;
>         struct page *page;
> @@ -1732,6 +1743,17 @@ static ssize_t recompress_store(struct device *dev=
,
>                         continue;
>                 }
>
> +               if (!strcmp(param, "max_pages")) {
> +                       /*
> +                        * Limit the number of entries (pages) we attempt=
 to
> +                        * recompress.
> +                        */
> +                       ret =3D kstrtoull(val, 10, &num_recomp_pages);
> +                       if (ret)
> +                               return ret;
> +                       continue;
> +               }
> +
>                 if (!strcmp(param, "threshold")) {
>                         /*
>                          * We will re-compress only idle objects equal or
> @@ -1788,6 +1810,9 @@ static ssize_t recompress_store(struct device *dev,
>         for (index =3D 0; index < nr_pages; index++) {
>                 int err =3D 0;
>
> +               if (!num_recomp_pages)
> +                       break;
> +
>                 zram_slot_lock(zram, index);
>
>                 if (!zram_allocated(zram, index))
> @@ -1807,8 +1832,8 @@ static ssize_t recompress_store(struct device *dev,
>                     zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
>                         goto next;
>
> -               err =3D zram_recompress(zram, index, page, threshold,
> -                                     prio, prio_max);
> +               err =3D zram_recompress(zram, index, page, &num_recomp_pa=
ges,
> +                                     threshold, prio, prio_max);
>  next:
>                 zram_slot_unlock(zram, index);
>                 if (err) {
> --
> 2.44.0.478.gd926399ef9-goog
>

