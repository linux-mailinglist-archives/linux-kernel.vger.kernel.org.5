Return-Path: <linux-kernel+bounces-120648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718888DAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3271F29C74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96147F7E;
	Wed, 27 Mar 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMrpGXFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE432C9C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534198; cv=none; b=DbIZvK+m5LYPPd8PfVi9sTVSHZTf6ezfs/Az6v8K2W3Bd/HpWCDf9Uh34z3nDPOpdzk+oAWFsA06/lbRzKTKi+jxV2fYSsKK0etBK9H3lP2qff+MOa4pRKAFKQjJHYL8Dcg8ls0jVEEqIzk0877d6NQ+QCi+KLAQ437XiuXcFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534198; c=relaxed/simple;
	bh=a8qoaCpIZD3yXDALgnLRxPwRj4kb7hgsQJ8wxUhgink=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLISCnN5IoT+ptDbvhFCgbZSg9L5lX9BJp/81SswLdS6teqtxXZWGnsRoXcZtEmXq915MtUIeX0ZCi8naa80lyPv1ARH3ao87Sf6upO7V5OaWc7M7iLaX19rUVe1XT748tV/6MWhGp4QK+7JZ1Mr8gCQ/M3MCGAaQkxmK5QNCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMrpGXFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC8DC43399
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711534198;
	bh=a8qoaCpIZD3yXDALgnLRxPwRj4kb7hgsQJ8wxUhgink=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hMrpGXFjVlM++2XvItu/cWR/ETtyMY3jK0Wt7Sr6RAskDlCYFx0Zqz4vd/7p/vAPR
	 1yOgAMWpooqD20Lyj+Y/KpowxUxvo+LCnq8rPg89x+fIjgIWaurlJOtGjlyULzS9SC
	 EV2Hgc6pQV8dm6GRKW+WOOjSRGMD+y7w0sERd6xTJy6h8aTNEbNkvEEp0JQKkh0yfb
	 mx0DzlbVqT9NN12jYYzNwvBqJCcs4MXQaQ3lobKIK3BzIgRQCAOL1z35Y9CrpSs6aW
	 z0ouAVCFCpKadVl89FffJrjie3PRYwBjplB2tK5PWwD5ANDqWftokbFS/fZmJtYodG
	 /4MiBmIgUQglg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513dc9d6938so8391538e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:09:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgsWe3HjoqvobWjHPV0IM8+wSZvK16HsbKYvf1NcL/3HsDLCOWfRFOD42usbFusZ4PwwNYihug3OP5J9RdY7SXMug/cuXZw73ErxjH
X-Gm-Message-State: AOJu0YyL1X9/y1sva+pxnZleubOXSX7NQEcS8W6zASbE7du5OKruvcdc
	ruaNkj8yJFjUX5tCCZP/v5HQABhw1HaDd0YxKUvK6RlFu93WEAFJ16lR+rZFWVrDZccE0BfpOHt
	CmaRvQX+aZN6UX2IokOU+YOzHxww=
X-Google-Smtp-Source: AGHT+IH7olPGccdlqP6DCC+P4DYaQayrUz3cgBb2AN93SJgPbm/LKMxs/jEsJxuK1FHk/kfUtWTme1+tHuKFaz8eVxg=
X-Received: by 2002:a2e:2c18:0:b0:2d6:f545:5e13 with SMTP id
 s24-20020a2e2c18000000b002d6f5455e13mr1419674ljs.46.1711534196403; Wed, 27
 Mar 2024 03:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
In-Reply-To: <20240326101448.3453626-1-ryan.roberts@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 27 Mar 2024 12:09:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEEi2ZXs+1qwR97zod5Z+TerPKcKZBN8LGZ5XTRV0_-rg@mail.gmail.com>
Message-ID: <CAMj1kXEEi2ZXs+1qwR97zod5Z+TerPKcKZBN8LGZ5XTRV0_-rg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ryan,

On Tue, 26 Mar 2024 at 12:15, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> Hi All,
>
> It turns out that creating the linear map can take a significant proportion of
> the total boot time, especially when rodata=full. And a large portion of the
> time it takes to create the linear map is issuing TLBIs. This series reworks the
> kernel pgtable generation code to significantly reduce the number of TLBIs. See
> each patch for details.
>
> The below shows the execution time of map_mem() across a couple of different
> systems with different RAM configurations. We measure after applying each patch
> and show the improvement relative to base (v6.9-rc1):
>
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
> no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
> no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
> lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)
>
> This series applies on top of v6.9-rc1. All mm selftests pass. I haven't yet
> tested all VA size configs (although I don't anticipate any issues); I'll do
> this as part of followup.
>

These are very nice results!

Before digging into the details: do we still have a strong case for
supporting contiguous PTEs and PMDs in these routines?

