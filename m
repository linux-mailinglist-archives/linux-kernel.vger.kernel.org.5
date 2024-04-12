Return-Path: <linux-kernel+bounces-142655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CEA8A2E65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9EBB218D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C305914B;
	Fri, 12 Apr 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="I2cTeQU7"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FD58AD3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925395; cv=none; b=jIEyWj1zbAEbkv5LT8qMxox7wQ6GVx/8ZA4/g9VaEgso6DOPKqy0IP/JJu7DNF54yUOj/+SakP/vV6PzAVmvjWkv4bFCSEybt0aY8nlAOXTyvYbS2OYqnc9bb7L7wuXlnup/AAjxo0pFhFi2LoCU0y3Em83Xm5pjcGQeH9mrZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925395; c=relaxed/simple;
	bh=q/zq68O6+sSBrl97NyQg0CjTsV0FrQQrptYSnKIK5qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYyum+uvQcBL+wXjBN9ZtacA87jXYDEwKDDX1znM3MJzSSs8i0ktM/2+uJdp2nobXmEm9bhuY80OXlzOkpJb9rJ+nXG6oLKtoKL3wPig1eym29aSWz45fLP/TPJ8ftvgqjfgmJHR6b26RY/KBWU5v9G0jQf9hdjg2oPrk7AJfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=I2cTeQU7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so725544a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712925392; x=1713530192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9BoxTR1JROCUR8SnlVHtABNOhFI4wAk1SS2lfIXdDc=;
        b=I2cTeQU7a/6nht7u7IlFLRW8F3L9jO5d/Bl4jCCshuKL+u57vSgP/Zp2EOz5JH2LUw
         VqWgpOJR3euy+da4CXbTUaWGX3f5IDN3HCtPBZmyANHYpqymjtb1mELL/fxCq/czYe4l
         J3XfyR6j8PigD24xvPiQFbHh2gmrSC+kBtBJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712925392; x=1713530192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9BoxTR1JROCUR8SnlVHtABNOhFI4wAk1SS2lfIXdDc=;
        b=eCmK/IIdknHqLtfa3+6hV84A0kWsIuEhUBxnJJ1Rt6h/DgALJxwtiDYyVbD8FVVhXg
         0awcRyg/O2ii4FrYdLrVJ/B9fnvA5One5m2n2iIBeHSnPnBPKk/d59RNWm3RApe5qSmk
         RTDGOaAawIgtDRaTX8hE+D6ER67CAZr2xCbfgHYAHt0lmCqEHwPOFEFb9rQN8vDBe7na
         tISiNej+DnyY+SYIKlx3zx8Mi/aixQVRfjjl+2v7eLm2kssRSFlStfkLk5BgRozb/0hK
         KziaF6tWtJg/b+H05wfEeIfgZS0iF/tlCtrfBH1ELLPEPFDjwplqyn2VsBWxOa8wjef3
         8oBg==
X-Forwarded-Encrypted: i=1; AJvYcCXhZ4eRmfxQNYrZb30RJnMKusnSOk58pA7ixyt7mC+LGo1zpUpHFFKXmU9S+N2ndaz2F3jv+pmH1kJx9zNrYBLSretIc43NgHesSFq9
X-Gm-Message-State: AOJu0YziCTE+hJHsesBQE4wMcHDCVaNuXxjJbBSYmyyFfBezJYw0UP1e
	0tXZP7jbtEHSyhew3g6XkAlbzHbz6b7rbE4wQP0dXreWTB5UP4oeWMIc25SFRHoTeVVdNConpz2
	PVO/7UafyBLV0eumppp2h/qcSqzVB+yYNJg/NjQ==
X-Google-Smtp-Source: AGHT+IF0OXEoT3ZY3zlYrIJBP9t60HKo5W88sTuoOTax+N/wQVoD3KFVgeyr2E2zTF30Vq1n1+Eqqz1nG3Ytmq9tODw=
X-Received: by 2002:a17:907:94c1:b0:a51:e5c7:55b7 with SMTP id
 dn1-20020a17090794c100b00a51e5c755b7mr1811230ejc.47.1712925392535; Fri, 12
 Apr 2024 05:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
In-Reply-To: <20240403021808.309900-1-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 12 Apr 2024 14:36:21 +0200
Message-ID: <CAJfpeguqW4mPE9UyLmccisTex_gmwq6p9_6_EfVm-1oh6CrEBA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 04:18, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:

>  - in ovl_rename() I had to manually call the "light" the overrides,
>    both using the guard() macro or using the non-light version causes
>    the workload to crash the kernel. I still have to investigate why
>    this is happening. Hints are appreciated.

Don't know.  Well, there's nesting (in ovl_nlink_end()) but I don't
see why that should be an issue.

I see why Amir suggested moving away from scoped guards, but that also
introduces the possibility of subtle bugs if we don't audit every one
of those sites carefully...

Maybe patchset should be restructured to first do the
override_creds_light() conversion without guards, and then move over
to guards.   Or the other way round, I don't have a preference.  But
mixing these two independent changes doesn't sound like a great idea
in any case.

Thanks,
Miklos

