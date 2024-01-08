Return-Path: <linux-kernel+bounces-20191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CF827BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86991284458
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38635647C;
	Mon,  8 Jan 2024 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYah3iZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC9611A;
	Mon,  8 Jan 2024 23:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AAFC433A6;
	Mon,  8 Jan 2024 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704757137;
	bh=O3RdfilGcrGZ4KUQFADcPBBu77P7ASqCUFMp09ah60A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZYah3iZgaBzUvPXExfCgs7qO4qhqij/8ybf6JmCOIZ3ILw9TCDOUbFnzmtMHjrjFP
	 T4pXUq/SBX8lZYs6cOG62PmQ3UMqCuXSRBSX7nh++rBogZniJienSfmw6zNXhl9W15
	 LNq5lC4smK1B3z/od9YYWVPPG3O9k4eClNs5r93GHKVoDurcME2hyEGJm//1vAehdx
	 G7jUIxgLsDaMRvHEH+Fc4U6JdboNsO2yOpvXrOnc6f0TtQ7cYzE/uTBh0uEfPx9+Z5
	 ixO16Q22+IQFKE2Cu/E/vpPCuiz9QwW09/8lA8QGgbYa8xQsEG7hwtGvYGSmjJwhHf
	 8vrtJHSx0HJGQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so2612590e87.1;
        Mon, 08 Jan 2024 15:38:56 -0800 (PST)
X-Gm-Message-State: AOJu0YyYTXZ/yWb/Jh+L37aQZSAtQFD4ykEMzPGObboDGvBr+abTEv+q
	lMql5UItvim7pb9CPtGwCe8V3y13KGxYno556Jg=
X-Google-Smtp-Source: AGHT+IEjKzJzesoM5Y0ZY3bx3g9U1c07w0OsfFR9W3ZFvTl4s5Uiy8mr7o9s/LidF+0Ofj7TvfldNIm6EVB53SK521o=
X-Received: by 2002:a05:6512:219:b0:50e:9c17:24d2 with SMTP id
 a25-20020a056512021900b0050e9c1724d2mr1756873lfo.18.1704757135177; Mon, 08
 Jan 2024 15:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com> <20230927061241.1552837-3-yukuai1@huaweicloud.com>
In-Reply-To: <20230927061241.1552837-3-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 8 Jan 2024 15:38:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6sdnJYtE+iy+x=C2qVKzeN18zibx+qQBF4Y=KRsAmTTg@mail.gmail.com>
Message-ID: <CAPhsuW6sdnJYtE+iy+x=C2qVKzeN18zibx+qQBF4Y=KRsAmTTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] md: simplify md_seq_ops
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mariusz.tkaczyk@linux.intel.com, xni@redhat.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:19=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Before this patch, the implementation is hacky and hard to understand:
>
> 1) md_seq_start set pos to 1;
> 2) md_seq_show found pos is 1, then print Personalities;
> 3) md_seq_next found pos is 1, then it update pos to the first mddev;
> 4) md_seq_show found pos is not 1 or 2, show mddev;
> 5) md_seq_next found pos is not 1 or 2, update pos to next mddev;
> 6) loop 4-5 until the last mddev, then md_seq_next update pos to 2;
> 7) md_seq_show found pos is 2, then print unused devices;
> 8) md_seq_next found pos is 2, stop;
>
> This patch remove the magic value and use seq_list_start/next/stop()
> directly, and move printing "Personalities" to md_seq_start(),
> "unsed devices" to md_seq_stop():
>
> 1) md_seq_start print Personalities, and then set pos to first mddev;
> 2) md_seq_show show mddev;
> 3) md_seq_next update pos to next mddev;
> 4) loop 2-3 until the last mddev;
> 5) md_seq_stop print unsed devices;
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Just realized this introduced a behavior change:

When there is not md devices, before this patch, we have

[root@eth50-1 ~]# cat /proc/mdstat
Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
unused devices: <none>

After this patch, "cat /proc/mdstat" returns nothing. This causes
some confusion for users who want to read "Personalities" line,
for example, the mdadm test suite reads it.

I haven't figured out the best fix yet.

Thanks,
Song

