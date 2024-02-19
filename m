Return-Path: <linux-kernel+bounces-71175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43585A1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED1B1C212FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DD29408;
	Mon, 19 Feb 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdMc/Mcb"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64D2AD39
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341152; cv=none; b=MjWa9w6Ai9pKJx59sowrkxYZT4fZmJ2OYTjLqHXVq6DhHA+doHdt6+DWADXugLgC9CwG0P4FIfO310vGUg90wmog2D1aHK2jZ8ysLzUmGKbxItBFJG2hSZI6mTSdnHOCdjPCYrW8Exwj/JyvXbwICYcozHUjYAY78oJHxa1XfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341152; c=relaxed/simple;
	bh=wtUXsOPdRcR9ceMZSYyVlPOgSE3YKBQ5v6cj1iovINY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBFK33bFvO/3BEWeZtQVkmr2KKvXHCsbeu58kX1EGmL1K82A5Ji4F6U5ZKOg9BNY0WdHrcJYelcvNJ2gCfIdIpdqAS9qF5KpPpJDym22+gjiVbgNtzsq4sMRZ96ag1kQkA2bT/mOqnJQdhIE7Y12D9QF287OwywnvY+arV1Nbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdMc/Mcb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607f94d0b7cso30105797b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708341150; x=1708945950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtUXsOPdRcR9ceMZSYyVlPOgSE3YKBQ5v6cj1iovINY=;
        b=CdMc/McbGRsI0pT5Pv28fWhyZkDSqelHCBKLLpZS32fV3oyhcfylpatBgU36VYnfeg
         ct/zaZ3BmHHnV/Uo0Zae9vTrwc+q4PLzDXepBFhl8mELHb14YNDYOD+ddjhgg8nKj9Ve
         /FIKCTZyjqJb5W1UHFcOqZDNSlvJtVJDuCpkhvWRvL3WV1ip6Wu8U3if3m6FLygMvYOJ
         PNOjlaTK2zd3b/s3L88jr3TrA0VathD8618qAevDBDYiKjp7UknNGEXX4khDn8ZYp/Ca
         sTNNgcwmOXS821b9zmKktHh766RVzS6WTVZB/kXafPTcGyAfm1NvFIE3L7o9iYOXclwU
         jD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341150; x=1708945950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtUXsOPdRcR9ceMZSYyVlPOgSE3YKBQ5v6cj1iovINY=;
        b=E1jCCr8AaDWncVsBw/dTbmLCVdDz8ZjELxewmzHhR8diNlhAMn2uPp6URGb6jFuWux
         j2gvtttfZ1rvrz0WdfjSjAk+t1Bz5jUhAYQrGZR8HQ2EtgBU/P1tbrIr7FwBB+wA5H1g
         KYw/6GlRxJvLuEosoCPmxghmyBG9tIl7oOSYf3J22pioRwhR/AkVBhFTr74opHdFW+Jx
         fzBcLpJI2eNih190Oyv5mmANafKWwvLQlaym0E/ERUQ1mHsjxBGojOlXFNCgjCdWRlR6
         RpRD5zkihs9EDNoynvRqWzSRpPBhoLzw/qR1IAFdEUa4JDn5QgSwtxMMuleMZZDOLXYh
         gTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWobKAm695m/C1XwaWTbDsq+jgpmuPG0+7j8Xy3vjvYxigNjASrZRVoxlYZOX63CENNKxXqsE10j/sReq3la0UwlkNGaQhAKe6yL2E/
X-Gm-Message-State: AOJu0YzbCYdZlNa11LakuC1AC4hh3O560FjpKQc0CtrQMn0X6v7PG9zX
	CbjBzXIty1CAHKJCClEIrGp/rRVkPSpqMxDtUnS/5pE6+m41VreXpRlN05JvZN90SdHJtOLvNdT
	u0/Ywhq0lBVv54QIHLL4y200b3BI4+M0iWBCT
X-Google-Smtp-Source: AGHT+IFULDqCDrcjS4TprptID6BJoQo2zNTcSGt/cTpMvyAWR54MLnD28lbpdsUa7q87zM7LGe1fXbZHWfZP+xtxH2U=
X-Received: by 2002:a0d:cb0e:0:b0:607:ce8d:8839 with SMTP id
 n14-20020a0dcb0e000000b00607ce8d8839mr11569382ywd.25.1708341149610; Mon, 19
 Feb 2024 03:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com> <20240213055426.GA22451@lst.de>
In-Reply-To: <20240213055426.GA22451@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Mon, 19 Feb 2024 19:12:18 +0800
Message-ID: <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
> > Add support for multiple coherent rmems per device.
>
> Why?

I tried to upload the patch to support multiple coherent rmems per device
because in some system, the primary memory space for the device might
be limited, so that add multiple coherent rmems support per device to satis=
fy
the scenario.

--=20
Regards,

Howard

