Return-Path: <linux-kernel+bounces-68139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B7F857656
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4A1F24058
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697D614012;
	Fri, 16 Feb 2024 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlrJsITI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D8179AE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066737; cv=none; b=e1qUhKh8psF1XUUIOA9iwurWM9NTz4bbAnZ+dAU6xyrlqSB0p/KWMTvy1OrSTXvMu2B/3Ro/qb+qwmfaTPkPA5A22mMVMa6KRjCWF6v/ZiC5LkVN3BNg8w2cMyE5T2WSnkcvO/gRstWr1th71sTng1+QUQWu2CL49V+vdX/8iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066737; c=relaxed/simple;
	bh=YROb+eaJNu6/59TKOvdKSLmQg7w+kXyN6IwLF2JJH4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g03S8/ZeWoOBniL40JezqyLPCnvJJVxCkNvfeFvUzumr5Hso3W3vklg0nWWAYkVJf8/Fobl++XxknFKm89k1oceULMFX3+/zUefQj6z8FmvTdGigm2asROcDq6ZZ+KIRj4mW3zOe/I/cruRCSVWWp7FhAexoaPDXo5xNTR1/wOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlrJsITI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708066734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNMvTmeWJ1ziFBp7Mx8IpeakAHCa+fvWpYKZaRcTpWg=;
	b=BlrJsITIvMgsXd9YFdy2p2nydycBakcFo90DKTq+I3KNLnJibmzGRTzgDobwz9Hkl+wF2+
	9nMTb4Oy3zqbJPnElF0Ti0b/8zn4KgiEz8cmpv8xIUOhG0h0I3wvMc08BoV4XMkj9d2JnR
	v8yaYufstArdEL8xZ1ed0Y1FD3M0ue4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-J0ULQjgoPsaJiJdwdGEroQ-1; Fri, 16 Feb 2024 01:58:52 -0500
X-MC-Unique: J0ULQjgoPsaJiJdwdGEroQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e2f3e38f55so1719891a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708066732; x=1708671532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNMvTmeWJ1ziFBp7Mx8IpeakAHCa+fvWpYKZaRcTpWg=;
        b=PQ94xLD0v+bj6f80Xk6+1ext0QYWidQM/0nccYmlLc3GLm8/PMIIarEEotCq8/j1h4
         afX7ZWi5SzdB2P212S0r8WEnzjAnVFE9SrQpsZUv/lOfBRqoUpjZMZCMNmohpSKO0wWk
         l6mtUXBmHG2V2+5wzDgtzbtgL9WC3jgmZraHp/AAZIhff8e9nQg4QZN7dELCYWq4EyJF
         eM29WQTRr5Yj1s9DMG9yQ4D/t1gxtXjFxBzKp2iv7Rcf8k+lRJOGUF5+HYJcyzAhUxYP
         ciXuIKgSq91RlTjo3pyjaO1V64zpScWq65DzDoMwIcOkCLr7s2GDCSPhkWe2BlHzo8nC
         dqlw==
X-Forwarded-Encrypted: i=1; AJvYcCV8d1AKXVjav1sczL0E4vg2paAkMP/yej7B4deWToE0WCIoil08SSTE/2+b8v6nN2FJ0Bze5lU3fKSf4zI6DgSpSEEXbb4MA8eKFnSu
X-Gm-Message-State: AOJu0YzorcPdcaEvAydnG/KOBo1R2ECNZWVyYIbpS0WR9Q93aJJbFkgr
	BY7faOZODFIR1hyNO6oMd+LePwg60uz+n2uwJhZCPugi7uOfV3hxTSpvxby+LaJ5Vg64S0YWU9x
	LIpjbRMmFATqmAxd30mqb/zcvdYt7mYnw9Po4OSBrX+3oskjplLpxNtwZAUta2lwVMFrrR+9H1G
	n0rcfKKhlXZBV6eZSwWXoGIKgvKK4Au3ejApep
X-Received: by 2002:a05:6358:d04c:b0:178:7c7b:77bd with SMTP id jb12-20020a056358d04c00b001787c7b77bdmr4796303rwb.27.1708066732243;
        Thu, 15 Feb 2024 22:58:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIS1mWsDcddpPxFekpeD1h3hjt8dIDVsyUqaSy4AgJ7AmFMXEA/DB1AOZvjCvNo30ZSH6kg0YD0Di4qNWMKJg=
X-Received: by 2002:a05:6358:d04c:b0:178:7c7b:77bd with SMTP id
 jb12-20020a056358d04c00b001787c7b77bdmr4796292rwb.27.1708066731962; Thu, 15
 Feb 2024 22:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com> <20240201092559.910982-2-yukuai1@huaweicloud.com>
In-Reply-To: <20240201092559.910982-2-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Fri, 16 Feb 2024 14:58:40 +0800
Message-ID: <CALTww2-ZhRBJOD3jXs=xKFaD=iR=dtoC9h2rUQi5Stpi+tJ9Bw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in md_check_recovery()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, 
	akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> mddev_suspend() never stop sync_thread, hence it doesn't make sense to
> ignore suspended array in md_check_recovery(), which might cause
> sync_thread can't be unregistered.
>
> After commit f52f5c71f3d4 ("md: fix stopping sync thread"), following
> hang can be triggered by test shell/integrity-caching.sh:

Hi Kuai

After applying this patch, it's still stuck at mddev_suspend. Maybe
the deadlock can be fixed by other patches from the patch set. But
this patch can't fix this issue. If so, the comment is not right.

>
> 1) suspend the array:
> raid_postsuspend
>  mddev_suspend
>
> 2) stop the array:
> raid_dtr
>  md_stop
>   __md_stop_writes
>    stop_sync_thread
>     set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>     md_wakeup_thread_directly(mddev->sync_thread);
>     wait_event(..., !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>
> 3) sync thread done:
> md_do_sync
>  set_bit(MD_RECOVERY_DONE, &mddev->recovery);
>  md_wakeup_thread(mddev->thread);
>
> 4) daemon thread can't unregister sync thread:
> md_check_recovery
>  if (mddev->suspended)
>    return; -> return directly
>  md_read_sync_thread
>  clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>  -> MD_RECOVERY_RUNNING can't be cleared, hence step 2 hang;

I add some debug logs when stopping dmraid with lvremove command. The
step you mentioned are sequential but not async. The process is :
dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid_pos=
tsuspend)
-> dm_table_destroy(raid_dtr). It looks like mddev_suspend is waiting
for active_io to be zero.

Best Regards
Xiao

> This problem is not just related to dm-raid, fix it by ignoring
> suspended array in md_check_recovery(). And follow up patches will
> improve dm-raid better to frozen sync thread during suspend.
>
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Closes: https://lore.kernel.org/all/8fb335e-6d2c-dbb5-d7-ded8db5145a@redh=
at.com/
> Fixes: 68866e425be2 ("MD: no sync IO while suspended")
> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 2266358d8074..07b80278eaa5 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9469,9 +9469,6 @@ static void md_start_sync(struct work_struct *ws)
>   */
>  void md_check_recovery(struct mddev *mddev)
>  {
> -       if (READ_ONCE(mddev->suspended))
> -               return;
> -
>         if (mddev->bitmap)
>                 md_bitmap_daemon_work(mddev);
>
> --
> 2.39.2
>


