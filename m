Return-Path: <linux-kernel+bounces-80759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46571866C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962F5B24171
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256B1CD19;
	Mon, 26 Feb 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d4celLX0"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65E1CAA8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936052; cv=none; b=Eovj0erRwugdRJU7Ln5Rj1HY7PYgKwCogedgUshWilOCp3AcQyUXXn/ZsyyQ8L4orXxbnXevsY7m1X4HlSq3GuplptLn7SIWPSMKKN4AbqKLECqBQNKhUSUSGtm6c0IFzTp6raMh7/U0x1Z4LygPAOZc9ms82T0dokOWqc+lm9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936052; c=relaxed/simple;
	bh=OgPr33qeJxSN1ACFIn4rsbOwqQ7JzF96ye/o470bEHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKZ0y6wgyvv0inxU7PWjjfTNWlc15v9cPrPntLAvVKgk7B1GD4CM4zNaUMv8H4m6TKsC0u2OarKTndlgcroG5Q144ePB8N498Iyqzm31b6lv+qCw4V1H/ZJ4mJM9LLxPVakg6cMQhBvEeYiDtesas+A22/IvU9ETZlq6zmNgC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d4celLX0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so3082880a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708936049; x=1709540849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RG8h9HtTqCH0xD/0lp/MK6evwSHkizYp8Z0N+/dsPdM=;
        b=d4celLX0P6jBSCp8LLD68JLofuxG37dTOs9Ualsu0f/cldUauXiEPTNyDg3AqjrgTZ
         LUopENJZyRvP+kAYz7YvF0MQZ6X8NBE44orv5UzFr1LiOHPg1wRQuGomzQaDEAMTr6ux
         IBenw/kkiOuoxzX8uVX8BLHtRWbVz2y5JTW3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936049; x=1709540849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RG8h9HtTqCH0xD/0lp/MK6evwSHkizYp8Z0N+/dsPdM=;
        b=k3Tzr6nzp0CIScOS35IX1P6gVkV6qRE1LDN0mnNonOLFHdbDYZ9PG9tpLuVfjEfpVT
         w0vdn5878mlTm9BJ6ZFAEmjQ47MfrcNb+Poeg0sTT2yKX5Ue26nsMKxmU19D47dXtU2Y
         6TGKgIwvHVMwHFDTk9QfjJuIbcUj3kpVZmJYYSFCLjZgnZWWrpFb+34Ec/MLcdVyjF63
         6Tn/FNJXzxYOrCerEEtWjje8SN2lAIg0aKg17IXUzoETPBD0p7gsUB7x72MStTo+fEAX
         FUwb3HDcQ+EuvXlOsZ5bt+4kceKhRD90AIxsjv2kHEo9wUHVi0HwAjjzud/sPKMMFvOe
         AwdA==
X-Forwarded-Encrypted: i=1; AJvYcCVfTBM7D3gNUMxJAJzFUok7dgqvczqeYS8WmxrsOwpVPgj1NORS1II6rTmU1ALVfmLZdNle3w+ufWRDkqPTDPv6GlAvsFVvppasfXtZ
X-Gm-Message-State: AOJu0Yy+zexomjOwvBTQJL/UWHNZ9uDZDTRiBPWS6q/lzw+7wT6wttXG
	5YZwVO/Z1yoyVAjS0a6Ygjd3/ogak8KFFK4LbC4uB24qyfIRxXfkN31x79CxIWFvfvsQKO7nFDU
	gjNFJyHH7eILKdA2A3mQl0Gng3f0RpjHe7r4HEQ==
X-Google-Smtp-Source: AGHT+IG0pgMt4vUs7EtTrd5627D4m1+vfVpIva+Me50maxinT8JXAUNoW+2KDn+dpslvef9S4XuUmVkrbBD1zZuYPIw=
X-Received: by 2002:a17:906:3c7:b0:a3e:720a:b961 with SMTP id
 c7-20020a17090603c700b00a3e720ab961mr389723eja.34.1708936049011; Mon, 26 Feb
 2024 00:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3> <CAJfpegtUZ4YWhYqqnS_BcKKpwhHvdUsQPQMf4j49ahwAe2_AXQ@mail.gmail.com>
 <20240222160823.pclx6isoyaf7l64r@quack3>
In-Reply-To: <20240222160823.pclx6isoyaf7l64r@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Feb 2024 09:27:17 +0100
Message-ID: <CAJfpegvvuzXUDusbsJ1VO0CQf5iZO=TZ8kK7V3-k738oi5RM5w@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 17:08, Jan Kara <jack@suse.cz> wrote:

> > If we are going to start fixing userspace, then we better make sure to
> > use the right interfaces, that won't have issues in the future.
>
> I agree we should give this a good thought which identification of a
> filesystem is the best.

To find mount boundaries statx.stx_mnt_id (especially with
STATX_MNT_ID_UNIQUE) is perfect.

By supplying stx_mnt_id to statmount(2) it's possible to get the
device number associated with that filesystem (statmount.sb_dev_*).  I
think it's what Josef wants btrfs to return as st_dev.

And statx could return that in stx_dev_*, with an interface feature
flag, same as we've done with stx_mnt_id.  I.e. STATX_DEV_NOHACK would
force the vfs to replace anything the filesystem put in kstat.dev with
sb->s_dev.

Thanks,
Miklos

