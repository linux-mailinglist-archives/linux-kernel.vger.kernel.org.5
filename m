Return-Path: <linux-kernel+bounces-42262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5DC83FEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103011F217C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE784CE04;
	Mon, 29 Jan 2024 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehzIAW9Y"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE724CDE5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706510765; cv=none; b=ayoCQFgzAbL/RUxJVhWOPqpVuikWnge25ECUUT9lUIV4HR3TCHbmY9ktXWJv6KPP+ikFKezAk02tFQvQ1wnOMcY6o4caPzskdSxmy8FOQv2Eq1oS3zbkVMWqdt/PmDJU/3sFbzvql2abkKXZuc4bst8D66Uaz9MaW/3AFPY4JCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706510765; c=relaxed/simple;
	bh=zdtwYGDPA59xPWj3nkRJ583vlFrSRZrqABopEr96A18=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VZIQ3NdqX+4Hlo4y45LcQhTnXMw2qj6/rHmDh61VMQu+Fd9YqW9V2yDw70eroeiVcv5YXe3olb83ySuEcKOnxAHhfHIhw8mYbbmkYrskeCKwltV7BpXewgRqIEBkh1BiV6S0IQX+We2I9I7uSAlw36ApTUw9mRpyljA0pOOl4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehzIAW9Y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso12009a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706510762; x=1707115562; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+uwLwno0ysHUeOyeXN0Tg49yINU6nKDLQKT73H8xgU=;
        b=ehzIAW9YGBdbAV934wCWg3lJW4JOIGPqXPoGckfHld5w2muB/lEGbbnmOeFJn2Vx6T
         mrhJg3iRcRXiK9VOsSo6V6/SttIsEmDZPPEfHKHEsJAWj2mOLfKyu5m2jX7Asng2uQP0
         WCiAe5kfqaSAbgoNvkf5XucDD8MtCmmGvXigW4+ga3o8K4GCzzQLNqqMP70NjabjS+7/
         XUQDISY3yI4wxUgEosmJEJW0wxggqEJ23V//d8piiDL/boC7cKdmvJX03OAG7Mg/oM7V
         YhLUI0hvtlKOfERBGpw75f8ObAb2N1aolIgt8jEufxRzeNfTR8Ih0WqSk8LciRcpTH6+
         op/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706510762; x=1707115562;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+uwLwno0ysHUeOyeXN0Tg49yINU6nKDLQKT73H8xgU=;
        b=pJrut2Uo4+1F09qgb+gKcRTtjt4TTMSLxjpMmaLIwl7YSprlXPKZbGoJPoFZXBG449
         ieELTq3J3gy/P1w4RDMTMzzGh384w0UQ1qzI5AKb3Zz0+fsZlmse1+szNntWppZQIUAV
         rsXK2icsDZ6SeiWTMBfWuHYe1l/+R6YkdTFcT/KOYXkLnCyqKATmXeEhcDGwP/a1BsAo
         fwiDzN8AaDcXWP0k4AdBw2OhnrEDL5L7+K9+JoCfOeFluvU3M3Jw+LOdW8ojHhn4q08q
         2HOPkWQ/TgNdPQNpHwbG30bT9tXid0+5vjlWjruBtXdbHidzDxBeNAitU7TBGRH+r198
         HdSA==
X-Gm-Message-State: AOJu0YymBjTBFUM9EuISxl/0//JrKqMwC4+1Y6ZaFeDNzM193SgkL0iq
	oBmZvP9NbH27CKo87y1EpJ7gjFxrhRXsQyUnRfqobcwexNS9s3TG586yj6W+g5pMAfoucI/xXqM
	XEBMOXPeXRNxWddgg69SVH73idjHiRd9p4q5N5t/E+ihW5y5ImBAD
X-Google-Smtp-Source: AGHT+IHY+yc5lR0pYgdRmfR9jpOWpcJgaxvi6kVc5tUzMe9YKtuAWlnPOwyxzFDpmATz2X79yLLRZlVIVgNzjSHkW5Y=
X-Received: by 2002:a05:6402:228d:b0:55f:109b:1f6 with SMTP id
 cw13-20020a056402228d00b0055f109b01f6mr27655edb.0.1706510762089; Sun, 28 Jan
 2024 22:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Sun, 28 Jan 2024 22:45:50 -0800
Message-ID: <CANP3RGc3J+-SPgSbQKM12PhupyheKKeM2dcS_JqmVvby+W_XXQ@mail.gmail.com>
Subject: BLKDISCARD... off by -4kiB @ >=4GiB?
To: "Ted Ts'o" <tytso@google.com>, Kernel hackers <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On a personal machine with 6.6.13-200.fc39.x86_64 and a 2280 pcie nvme
SSD: Samsung MZ-VKW1T00 SSD
  blkdiscard -v /dev/nvme0n1
seems to issue (per strace):
  ioctl(3, BLKDISCARD, [0, 1024209543168])
but looking at the resulting block device (xxd -a < /dev/nvme0n1)...
it looks like exactly the last 4kiB of every 4GiB is not zero'ed.

Note: this is in spite of running it more than once.
(lsblk -D claims DISC-ALN 0, DISC-GRAN 512B, DISC-MAX 2T, DISC-ZERO 0)

So it seems like there's a bug either in the ssd firmware or in the kernel.=
.?

The issue (at the end of the first 4GiB) goes away if I:
  blkdiscard -v -o 0 -l $[2<<30] /dev/nvme0n1
  blkdiscard -v -o $[2<<30] -l $[2<<30] /dev/nvme0n1

or (for full drive):
  blkdiscard -v -p $[2<<30] /dev/nvme0n1

Looking (but not too deeply) at the kernel code, I don't see any
obvious red herring, but maybe something should just limit to 2GiB?

Although __blkdev_issue_discard's:
  bio->bi_iter.bi_size =3D req_sects << 9;
seems odd considering
  struct bvec_iter {
    sector_t bi_sector; /* device address in 512 byte sectors */
    unsigned int bi_size; /* residual I/O count */

which should imply 4GiB would need to be stored as a u32 bi_size of 0...
But I do networking, so maybe I'm missing some block/fs convention...
Or maybe this is already splitting into smaller pieces, and then
coallescing, or who knows what...

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

