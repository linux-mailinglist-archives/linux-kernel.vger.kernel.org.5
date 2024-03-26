Return-Path: <linux-kernel+bounces-120138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39D88D2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90643B21E51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEAD13E051;
	Tue, 26 Mar 2024 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LCt7wlNS"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78913D8AA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496097; cv=none; b=KRlHlKOdjmpeYt1eMReIJmkjaFCFc1YBQMMuf0AhEJHRbOLLMgVpsU0jasyFMS/69hcm/Hrho5sEiBBZX86Hmeav+ahJ8uVnfCw/wejoDnsMQZHRQvXpvfkZz7X0J/tk6E66K2w5wA8uAogRu4YedGIPEfp9ZyfNQ3cKFCVkOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496097; c=relaxed/simple;
	bh=EwMlcl8PIzr8RhdfN5ZZNNfvQw7deC+B3FnxlLEVjfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/Wap0kgBbslv59M2tt2YOereHfMzgfVMV3YgdAaPz4BLgro8sTgWwRpwb6eXjOpASdDMcS8g3+IzQcIFh+8JYIbjBoflKxPLL92DjGYzviBMgauH/e8iQpTbmlCzckk9FG+mWSjWcf1plE683wh+AF/GXAAyMREbiTd2oFmaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LCt7wlNS; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e101b8fed9so1115516241.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711496095; x=1712100895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYmdJQpGAyKoO561dC+ojA6XOTgi5Uts09PCMGhkelE=;
        b=LCt7wlNSOzFOXmkyYZmXHFTn4zUtiQyDgCI0wHIF/7tiHLja0NtA4n3bib2Aqv6Dbt
         9Sg0ziXuGxWgjpYIjzgT965+2rbjLPeHDcA9scB+WtXg3H1DyeTKd4njse7UNMgjUYFy
         M06DALQ141QmnxHetfMalV2kBcv+FCZen3Jdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711496095; x=1712100895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYmdJQpGAyKoO561dC+ojA6XOTgi5Uts09PCMGhkelE=;
        b=M8yK/1Bnpc4wrqO8f5fXyaBbz8zGgekv4bQpNT/Ghn9H4wZsxgcczgv1VlkMptQY3L
         NqE04AHpkKGY/L4cFsHF50Ydbe2Y8PQ/Z9KhCN6wNTGq/Q25svGPIWeU/09mzqYvGuj1
         EbBLp/fZHuloGzUXCGFmYY2e2enfm8Li9w5FJYgvpEJBamRYhbwVdWWafA6lH3eI5qK8
         RYkpuAOhjYOGEhvxLWFoqdiuM3BGiq7TGMjnTrXTWcBXVDQzsGg+Tj0Xyzk4bB4bR5w/
         zRv1E6e/yZd2YNrpcGJ1QmhIsBLqOQ7rZl12tCwzBegMvlpmXwNpgP8/C4qvyGZrnLRH
         b0nA==
X-Forwarded-Encrypted: i=1; AJvYcCXAAABKwM0eoMUIrHiaQdiqGFziumPhQCgf9jErSiYar7oPM/zl9Y/8dKVzmtL1Yz5xIpcvi+tznBmzO3AXRGRX676je10Ak8Pal6yH
X-Gm-Message-State: AOJu0Ywuyyc4BVlcJ4OZpzF9IpD6J+ZPUkp+xC37uKDojMBLhJut/A1X
	RvIDkbl5+2RW2oGyvDWnbVUUf970mNwCLKgZG1MFgri6OcyXSI2/xr4kxCKtceqXY7VT8wUN5z7
	rYv3njEJbEOLatz2G/wMAeJj2vGt8Vb9Ah0in
X-Google-Smtp-Source: AGHT+IGYjBc3zq6N8dmZwkyInQNpMvNhTO0c5xOyM/NeGeB0s1vCmPFyPTk3a/bFYwoBzpSUv1XpLGY9L5izz4Bk1kk=
X-Received: by 2002:a67:e246:0:b0:476:cf52:e1b7 with SMTP id
 w6-20020a67e246000000b00476cf52e1b7mr2432676vse.28.1711496094788; Tue, 26 Mar
 2024 16:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org> <2024032624-subtitle-crisped-f4f1@gregkh>
In-Reply-To: <2024032624-subtitle-crisped-f4f1@gregkh>
From: Pavan Holla <pholla@chromium.org>
Date: Tue, 26 Mar 2024 16:34:44 -0700
Message-ID: <CAB2FV=4Z1W1HSba50KaB3rR4=Ussb5RWPwUArr0_=3pFwxpAhA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: Wait 20ms before retrying reset
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:29=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 25, 2024 at 09:19:43PM +0000, Pavan Holla wrote:
> > The PPM might take time to process reset. Allow 20ms for the reset to
> > complete before issuing another reset.
> What commit id does this fix?  Does it need to go to older kernels?

This does not fix any commit. However, the time taken by a CCI read is
insufficient for a ChromeOS EC and PDC to perform a reset.

> > There is a 20ms delay for a reset retry to complete. However, the first
> > reset attempt is expected to complete immediately after an async write
> > of the reset command. This patch adds 20ms between the async write and
> > the CCI read that expects the reset to be complete. The additional dela=
y
> > also allows the PPM to settle after the first reset, which seems to be
> > the intention behind the original 20ms delay ( kernel v4.14 has a comme=
nt
> > regarding the same )
>
> Why was the comment removed in newer kernels?

The comment was removed when the old UCSI API was removed in
2ede55468ca8cc236da66579359c2c406d4c1cba

> Where does the magic 20ms number come from?  What about systems that do
> not need that time delay, did things just slow down for them?

I am not sure how 20ms was decided upon. However, UCSI v1.2 has
MIN_TIME_TO_RESPOND_WITH_BUSY=3D10ms. So, we need to provide at least
10ms for the PPM to respond with CCI busy. Indeed, this patch slows down ot=
her
implementations by 20ms. UCSIv3 also defines a 200ms timeout for PPM_RESET.

Hi Heikki,

Do you think the right thing to do here is:
1) poll CCI ( poll duration TBD) for 20ms until busy is set or reset
is complete.
2) poll CCI ( poll duration TBD) for 180ms until reset is complete if
busy was set.
3) If either 1) or 2) timeout, retry the reset.

If you agree with the approach, please advise a poll duration as well ( 20m=
s? )

Thanks,
Pavan

