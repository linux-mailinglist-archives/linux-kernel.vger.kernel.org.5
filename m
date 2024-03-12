Return-Path: <linux-kernel+bounces-100102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1988791CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1F51F22B69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A878663;
	Tue, 12 Mar 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w4mlrG9/"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7BAD53
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238967; cv=none; b=Uv2FsWpQOXKeuWSD222b29aTmnkUqBAg0IIykrMaSH/M231AmuK+fcFFhN5ZT7jALJMetmepnpWQnLJLI76ShNxHpZL/ULAXxav58OAf8Y3Tj/yBjLEyNC/hChp9kqDdSkugtmAgGEkfvg2O2gzXBL1TPfgxTwmNPUdC+vHmTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238967; c=relaxed/simple;
	bh=qwlSqCcmIQTp4qWBUcG0QiZl7XK3uVt9HTvZMCmPyho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXSgh2sFHDuA9+t+ed7AeTSe+RWxOZkG/RE2QRvuvawckV9HdSWU7hjp18XA4fMWv0qowiy58LbfMBPZCknrm+WppXd/MsYbZHEzRtdDRSqy+d3EboEuVrpE9mYGIVKEY0o404KBOYqYfXtNIxYEZnoldXLdeUEc5e6AgVPPNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w4mlrG9/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3122b70439so676709166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710238964; x=1710843764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwlSqCcmIQTp4qWBUcG0QiZl7XK3uVt9HTvZMCmPyho=;
        b=w4mlrG9/FbShqTEzG+kVSdJlEbboZoEe6uj0iWb6g/LS345+jbnSEtAKD3JQq4IArk
         Bd7m0CVoZx4PWjR1wODL1qDX8CgRD7aIczT2at9Vm2wDhBD11PXHYft2EdvcelgwOwHt
         phovQetwuIohc+kdCY6Yz/5NBVY4QeEdQFWf30xE2/bpQTbuPRMrfOdgcxPhhUDa0swU
         u74gjaV7q8t8uV5h00o12pwhCT3aClXHAHIIksb9jzD85VFAXmAN3aR857qBW7gmj+RB
         UGtOs9Spy3QMvKSG13SWnq+NeoY29rh0QQM0z2U/+W2GqSMF7PPpUFo3fXn6J8zLtzDP
         fOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710238964; x=1710843764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwlSqCcmIQTp4qWBUcG0QiZl7XK3uVt9HTvZMCmPyho=;
        b=RvOBOnCfyrB9Z5AY97FACXHFxKe+LsVIo9DhIFeMEmWWb3vv6B5bdUYKRmpSNAjU+P
         JB9Hqv6T3L3nJ89uSDfYOktm3kr8cuFETOtBPgJagPG7rVM/g5b83y2XQh794bjfb/7H
         S056DCY0QXeT67bSD45zCW76jOXNxjyjU8C9CtZl8OvlWIIwtX96aGB964vy9eO5q4bn
         aTyJNSzZp4ZGjM39RpXzuRWAp2R21K/sdoAjNvyWDw1R/Unoawyf+vC6O0ZmV1ZY4rms
         QXxKV6jyYKTRtOYl+MrLgDf8XuMQgOhWA6bvylDD05m7I1KMbXKv8X39VxXbgUf3bByz
         kVag==
X-Forwarded-Encrypted: i=1; AJvYcCU+p2IDbT0c2oAu3Z86kaS51/ccVnvjKRobqZcamhQeqBG9doYO8xEWL7BxqZoA+oUbmNOVBt1SwJIp2GEH3q5aU0bCvomV2KsDx1Mb
X-Gm-Message-State: AOJu0YyTFzxQLjB+z5YV78D94pP+0ABilriW1ZT8j+t7On4gnWG+c+XY
	uVsKA9phkej4QKc8s0wWQJZ3ZsheN6J8iAkAkdvNjJH8WnxYKI6qmJddHCtFEv4gp1S/1b1mqm1
	pu/U0I5GNnQ0ID/HWIzH78PMCfQyg7MGw5Huy
X-Google-Smtp-Source: AGHT+IG4zIJ6KPcEpowwL2eYULkssu/nf4WiRLsFrH81EeV4R1r9+XavkF2NcCG2sOIumI3K7s5YgsP2tGeXGk2Atts=
X-Received: by 2002:a17:906:13d5:b0:a44:2563:c5dd with SMTP id
 g21-20020a17090613d500b00a442563c5ddmr900504ejc.45.1710238964252; Tue, 12 Mar
 2024 03:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311235210.2937484-1-yosryahmed@google.com> <CAKEwX=Oaj=h-Lqk+ZdrB6LpksKF5xhNJkpgUuF-wQ0gk6+pgpg@mail.gmail.com>
In-Reply-To: <CAKEwX=Oaj=h-Lqk+ZdrB6LpksKF5xhNJkpgUuF-wQ0gk6+pgpg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Mar 2024 03:22:06 -0700
Message-ID: <CAJD7tkZSz6A2cEdHzMhJZpa8BwxH8iRUZQqKp6GfPaGzBZthRA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: remove unnecessary check in zswap_find_zpool()
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 2:35=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Mar 12, 2024 at 6:52=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > zswap_find_zpool() checks if ZSWAP_NR_ZPOOLS > 1, which is always true.
> > This is a remnant from a patch version that had ZSWAP_NR_ZPOOLS as a
> > config option and never made it upstream. Remove the unnecessary check.
>
> Do we need a Fixes: tag for this? I guess it's not a bug hmmm.

The compiler should be producing the exact same code either way, so I
would say no. It's just a cleanup.

>
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks!

