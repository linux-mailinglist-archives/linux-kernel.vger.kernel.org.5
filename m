Return-Path: <linux-kernel+bounces-107975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E0880455
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A887284C55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D099138F9C;
	Tue, 19 Mar 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZV2FhwDI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A18364C4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871446; cv=none; b=AVgfZXI1oK1Fe3szN48WrzIZVZEEe6G5imWh5rhl/uoZPbFoWaMPbsGbvFVAmBO10alpCCXzzxtD6sk8S852IqZOiE+qzsT5rPufIOOB5K8yDuATgV22/klL8wxjSYSfOKe6/cq+rhorEha+ssQH8rxn2sobjmAo++wPjo94IzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871446; c=relaxed/simple;
	bh=DFh9J+u2qXCj6UQ58/J1xPY8J+BLfhUgqiTlzbpfEoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebLFNCXnOEkOsGpbovQMF3qq6WSe3JERtHph8aGmMvKOWN1A9N+21vqfdppjxJEwaPgoG0pOGkcR8tslvn/ItOipFlwbVVb62XgP3yuTLqkUOIqE7GdsBZ3OjhEzf04rCWdXgZlNJZ4slD1M8FYogQLRnDGMrfA2CR4KsoUP50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZV2FhwDI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ba938de0so377842366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710871442; x=1711476242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EQCbsWamaqb8otc0jtHP79rNp7jzLPKKgSbrJldR67k=;
        b=ZV2FhwDIDYHWNIS0VbT4MdZeQYuxanr47czuHq13m+XI7tcD9egHUkToGYOTcafeGJ
         m1B+NF7Xy0S1a80pFPUX/uhheCqu18+De9U4JUb9FoEpH1XatxyL1NDXGjBO9VjY0pJ/
         wqaIIcaABk2BLyWU6K4LOT9xCpTHXLFazK+SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871442; x=1711476242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQCbsWamaqb8otc0jtHP79rNp7jzLPKKgSbrJldR67k=;
        b=oYkWn+ickAVZ+Us89dDclQNhRyHjwZS5UJk6wSk5uc/mw1dv/yXd6Mi374fs96efld
         rD9aYWApu6ZqvqXfJONa3Dt8oqTwfGA9VvttSBpYA3obHT5EYFeMx02vGL0KH6VcKYRM
         Y8jRZloQODEvdfRyUxmusDpg3YXbhkiH9yRVZrVlAneyXbUYHmXRZZmE5OHDJLMHfHTZ
         UD+uM8VSAgbUwRQ0ElosmTrzYoWfJLrmUZ1Q5OVj34kKQwNZzf1hW4DCILxvT5Gv8vJk
         wcTO4gsLIo01mSKv0GNk5xgEarQKvsV5UUyko6Q1ndf/UiXzvL88ieCUwdogm1/PJ1Yz
         /d4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+4devlLpJ+17s5EA4idX7TAVnsF7S2w5zglAe+PiniqeyZY0nbaPWlh7yKKceBpna6gtJmjwvbXbYXBZjI4NMC8H9V6uuwcgX852p
X-Gm-Message-State: AOJu0YwaCd3FeDysC0RQ+YpIwKZiW0BRDrtqIL/fzmJuLeubse1hpm9C
	WXIIQSbsi3WnSusWD8+N2y/cF+2UgfN+sAi7ktPaUpm6ekj/tMemV5JWrCbLyWKcaDHdHzlPU9I
	3ooW/7g==
X-Google-Smtp-Source: AGHT+IFWKoReSccRXbrEU88Hk76qQZsfSdjGrjqlw9EVL370EcjDV6mQrrPlGfP5SqrUZfIRvWcnAg==
X-Received: by 2002:a17:906:b109:b0:a46:cea5:5e7e with SMTP id u9-20020a170906b10900b00a46cea55e7emr3440878ejy.52.1710871442438;
        Tue, 19 Mar 2024 11:04:02 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id bf8-20020a170907098800b00a46bcfe4f16sm2724789ejc.37.2024.03.19.11.04.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:04:02 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ba938de0so377837666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:04:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCETGAY9Z74XrTshWyaab12ZLkSZ6x7YDGZ9yEaQbs6QeHwn5JucATQQZZ9K5Ji6F63kYVDzCnh9DwdfLwxlPbPaH2zfmxnx95JOQG
X-Received: by 2002:a17:906:1352:b0:a46:7ee2:f834 with SMTP id
 x18-20020a170906135200b00a467ee2f834mr9239613ejb.11.1710871440743; Tue, 19
 Mar 2024 11:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319034143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319034143-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 11:03:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Message-ID: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com, 
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com, 
	gregkh@linuxfoundation.org, jasowang@redhat.com, jean-philippe@linaro.org, 
	jonah.palmer@oracle.com, leiyang@redhat.com, lingshan.zhu@intel.com, 
	maxime.coquelin@redhat.com, ricardo@marliere.net, shannon.nelson@amd.com, 
	stable@kernel.org, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 00:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtio: features, fixes
>
> Per vq sizes in vdpa.
> Info query for block devices support in vdpa.
> DMA sync callbacks in vduse.
>
> Fixes, cleanups.

Grr. I thought the merge message was a bit too terse, but I let it slide.

But only after pushing it out do I notice that not only was the pull
request message overly terse, you had also rebased this all just
moments before sending the pull request and didn't even give a hit of
a reason for that.

So I missed that, and the merge is out now, but this was NOT OK.

Yes, rebasing happens. But last-minute rebasing needs to be explained,
not some kind of nasty surprise after-the-fact.

And that pull request explanation was really borderline even *without*
that issue.

                Linus

