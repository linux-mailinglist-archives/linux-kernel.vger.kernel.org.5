Return-Path: <linux-kernel+bounces-100275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35178794CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CC0285837
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389F6997E;
	Tue, 12 Mar 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqJ5nOW1"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A758112
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710248990; cv=none; b=ZWbluQLWPKNncBylF8a+R40dRTAmc1ms8xemkHgBvwlPpqcQTGXCEbxNeaxt4LHfb20SC4WSvhww0sa4JcM7sdhp+7lKvOKfMKV0vCJIazMkjQ5Ccq556RGCtDLTQ62rHcxAh6l5Og6KMUCst9GIyIzv3e1RN5gos9ThmaP9aIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710248990; c=relaxed/simple;
	bh=z3Krd6PYBcsF/RiHX60uQhCJAD+W/Ot4T/9sQ/BX0mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEpYnmPY90NzAHy67s+GtaKpz1aHcsxHGx1oLNhMa/J3NpFLOGnZ60DYxGhup9YCvHBFiVQu4FRAdm+/U4QXGw4Ab/i/sDdVRZQSdBvtFjXa4+hZVfojA5WqvZJowIvg2nDg4axPZ8UptNI/2JgairY5QqAXbt7QhcGbMBZPsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqJ5nOW1; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so3773541276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710248988; x=1710853788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+48G+vRsg7+lgPK5qgS5JPtHJWZ7UC5Q8Af8HqedyCE=;
        b=AqJ5nOW1DE7ZqU9Gf70IjT+GZCdq+OY8ObvzbqUWE/meC5rVIvRVDrbFyMCcNDytaD
         N3OpiWtYms+5WPkFw5UeMGZp1BgECDQpSd+hxT54YcNDMnufeVzrhj1vxED2A5t6kVSU
         xwhaO0+MDzaPQeoVuWlqi95mPRepZhDyB08JFSqZyIwzEEp+jcZocSCYal4aEe9dc2X4
         J4SMDWdmm+YF/g3TDGu2fhwS+tYe2PsMJJBCgH38iMUxvAiQc0a9AK9K92NyyVEhiTG7
         NRt5zAuW1P154xUt3rI+ipcPWbLM0xg2bLJfHDibfzBk/HfAKQ6zHKYpQJNkWFNnzdD9
         FH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710248988; x=1710853788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+48G+vRsg7+lgPK5qgS5JPtHJWZ7UC5Q8Af8HqedyCE=;
        b=K11fbWYxFKhF0h6bFeoIcbqckujNUcodOgnkQouGwav/SUuG1d/SpmDJo6rX/C/SAr
         HnDazFURftL/gCB/3SqWLxvCrf0rL4ldnYAkrTCMpTUa2b9v0NSf6VqqzrO7/FoMZgb6
         uLBwt0IM7sXM7QQUErLwEtzR+PwTFqmF8tOVHRlTzLxbgyMMmMqX7liYmYKaLELtoE00
         ZZb+17VIvI4xnYtstHY80UR2j8kEyqnOwt3MqN439mBUYuJjbhLjKBH6ceBVUjCbxLW8
         fJskOmPrH74k8K5dPCXhGm4LR9rcBrOqUBmPXv0T9VqAxgUqvu5GrjspqdGZ7EchcjxX
         WJFA==
X-Forwarded-Encrypted: i=1; AJvYcCVhpcpTSCe2B1m7Ct/1RA37IqOQgdPWX0Dcymap6kOYBmjsxGygjNHkrkqGRvkIFIg6Dp2uhfoCIDXJm5B9KviqgXHTObkhrZ6SnCzM
X-Gm-Message-State: AOJu0Yw5LCjD4tWNkzysyDbA3OaoXMSvIrgruBPmHKiEyIprzCnFSU+D
	d2jewMVYG5668YNznv2RinhE1qrF4n+tBD+z0gYKQLIuam4g5HkAyOdD7+jQE0U9IciGKQmZu7c
	f1D3Uxat0hDel69xGHWH2qThPO/s=
X-Google-Smtp-Source: AGHT+IFnO0pN11NYUrGM946wzMKaXTqTxPNQY42/zJlOr91aUkRgRbcbVrsHkueI/v7rrSkhiWcUFRRT7bDYPw3TcS8=
X-Received: by 2002:a25:f621:0:b0:dc6:d093:8622 with SMTP id
 t33-20020a25f621000000b00dc6d0938622mr6648021ybd.15.1710248987491; Tue, 12
 Mar 2024 06:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308074921.45752-1-ioworker0@gmail.com> <ef409d5e-5652-4fff-933c-49bda6d75018@redhat.com>
In-Reply-To: <ef409d5e-5652-4fff-933c-49bda6d75018@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 12 Mar 2024 21:09:35 +0800
Message-ID: <CAK1f24k_+qAqxKGMpKziouuds=PQ6kfKyQ8D3SYEyW7cQOAJWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: reduce process visible downtime by
 pre-zeroing hugepage
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, songmuchun@bytedance.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks for taking time to review!

On Tue, Mar 12, 2024 at 12:19=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 08.03.24 08:49, Lance Yang wrote:
> > The patch reduces the process visible downtime during hugepage
> > collapse. This is achieved by pre-zeroing the hugepage before
> > acquiring mmap_lock(write mode) if nr_pte_none >=3D 256, without
> > affecting the efficiency of khugepaged.
> >
> > On an Intel Core i5 CPU, the process visible downtime during
> > hugepage collapse is as follows:
> >
> > | nr_ptes_none  | w/o __GFP_ZERO | w/ __GFP_ZERO  |  Change |
> > --------------------------------------------------=E2=80=94----------
> > |      511      |     233us      |      95us      |  -59.21%|
> > |      384      |     376us      |     219us      |  -41.20%|
> > |      256      |     421us      |     323us      |  -23.28%|
> > |      128      |     523us      |     507us      |   -3.06%|
> >
> > Of course, alloc_charge_hpage() will take longer to run with
> > the __GFP_ZERO flag.
> >
> > |       Func           | w/o __GFP_ZERO | w/ __GFP_ZERO |
> > |----------------------|----------------|---------------|
> > | alloc_charge_hpage   |      198us     |      295us    |
> >
> > But it's not a big deal because it doesn't impact the total
> > time spent by khugepaged in collapsing a hugepage. In fact,
> > it would decrease.
>
> It does look sane to me and not overly complicated.
>
> But, it's an optimization really only when we have quite a bunch of
> pte_none(), possibly repeatedly so that it really makes a difference.
>
> Usually, when we repeatedly collapse that many pte_none() we're just
> wasting a lot of memory and should re-evaluate life choices :)

Agreed! It seems that the default value of max_pte_none may be set too
high, which could result in the memory wastage issue we're discussing.

>
> So my question is: do we really care about it that much that we care to
> optimize?

IMO, although it may not be our main concern, reducing the impact of
khugepaged on the process remains crucial. I think that users also prefer
minimal interference from khugepaged.

>
> But again, LGTM.

Thanks again for your time!

Best,
Lance
>
> --
> Cheers,
>
> David / dhildenb
>

