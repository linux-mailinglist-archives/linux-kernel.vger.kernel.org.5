Return-Path: <linux-kernel+bounces-103048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F8D87BA61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CAC1F22500
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBADE6CDC7;
	Thu, 14 Mar 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZSEWrNwG"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111A6BB45
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408447; cv=none; b=KHPcBKGZyWO54qlHesDyft/kdo8BuE5DZJVx+8M9qS+IQMvhsm+YUuP8CWr1LlGQm3Fw9SCnxNtRwbO7cel9e8M41jWDtpTiNE8WMXVkStBBPtz7EVP/W2WSL1cPKv0SQSrHjureZiIaA8I7P2el9OsjSkrLDwvG/Fc/VyoKLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408447; c=relaxed/simple;
	bh=OBMOgQm2JqMMB2lopZ6dLV4hKACv0lHz0FcYOf1y1Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0jV+KP0AU0QhCYO8GOCk+fTduJNcvS6+m7urPkTYNdBRp8lPFXo2Fpan9S3lnNoBSKV/IRlqZL4hxw1N7vt7U6nJSscdsdhQkgYsS91K4AqujyU/umLiYGA8ESgmzXChjqnCkGOFe0bnY8hgpfNPvw57FoPyFQpvK0NRsQo/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZSEWrNwG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so326169566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710408443; x=1711013243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwIUIDarsV7ESSt3w5nAJOv8KAEl9jUo5NAlBXlY4TA=;
        b=ZSEWrNwGmkqgI2bPfXNWp2ba5/6qhjPW2oShv6cHkGPqRcgyiRI3OLluJLNslTPE8m
         QZLaFfdsqwBv5FknIywyNq9p7Uc7jfn+t+YysGxVUec5LkIqq1ZdsjIZgKI/6ZHuTBw1
         1CsfKJayEI4aP4g+LvSOOt3IeAPdISFJLokLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408443; x=1711013243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwIUIDarsV7ESSt3w5nAJOv8KAEl9jUo5NAlBXlY4TA=;
        b=XNfuvYkwnpO1xAqGLrzx4ZPGRjPVg3EszPiPT8UG5MvfwXEpjGJdA2zyYatSnsflvs
         yHzt76KfFIhyKF31o7YY5E/Qslf0Ui34FqwvzpxG5qjTZqfR07oW13ri3uiSsXMS/jpq
         ylyhy8euM0FHyBcdzsIW2T2fnNU6aRZiQqCGkp2JFBGAl66CWoOWp+zO8B8aVT46ADHj
         jGR8aX1n5i4lvaRTT7wUxbB8TevYx4T0QRueA1uFW/3YAwcTwCx2LZF32gz9H332YRmR
         9q7cWvdY58zksXoHEs8MrmrNvuYlTrLrxwyfrhfrFOxJKBg8+o1EFUul8wLSEJ/831AM
         KmYg==
X-Forwarded-Encrypted: i=1; AJvYcCU/rFYDkL9EWy0KO0yM34DowphPVmQ/W+58Iemv9RPRV5tVNzha4YAhjEK9+evl2AZOAhqNbR3l7meZ7DZnLDAkDcl2JkqwaFKN7bBV
X-Gm-Message-State: AOJu0YzoP8nK8LzYhGhETRMv2d/TpwuA4QTvY+fjE1xfaTv3COosDBWo
	w/eg2ZefClYkZWPjYqtjXMTVOE4aaJGyqd3NtFVEEVgyIgWS22COM3+30ztWMbQ8nsVl1hcqVcX
	xyWUOKocBqXHI+Pv7uj+ta3SKQVs3cHtPNQzT1w==
X-Google-Smtp-Source: AGHT+IG9tD8CTtuCAlV6cIOBe248EyyGlWLXTZiDIe13U6BkGzprg3jxR3h7gCKqYLgyibmLVEujy2gDWnOYr+xGuvU=
X-Received: by 2002:a17:906:fe44:b0:a3e:4d7c:9ce1 with SMTP id
 wz4-20020a170906fe4400b00a3e4d7c9ce1mr1156151ejb.21.1710408443295; Thu, 14
 Mar 2024 02:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bb26fd061392e1a9@google.com>
In-Reply-To: <000000000000bb26fd061392e1a9@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Mar 2024 10:27:11 +0100
Message-ID: <CAJfpegs9LQqzMLPc7Urw15sj9bHUmMe1CES6iPADrF-YP-_amg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in iter_file_splice_write (3)
To: syzbot <syzbot+e525d9be15a106e48379@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 00:10, syzbot
<syzbot+e525d9be15a106e48379@syzkaller.appspotmail.com> wrote:

> -> #3 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:814 [inline]
>        lookup_slow+0x45/0x70 fs/namei.c:1709
>        walk_component+0x2e1/0x410 fs/namei.c:2005
>        lookup_last fs/namei.c:2462 [inline]
>        path_lookupat+0x16f/0x450 fs/namei.c:2486
>        filename_lookup+0x255/0x610 fs/namei.c:2515
>        kern_path+0x35/0x50 fs/namei.c:2623

This is what ultimately closes the locking loop: doing path lookup
(taking directory i_mutex) with kernfs of->mutex held.

#syz dup possible deadlock in seq_read_iter (3)

Thanks,
Miklos

