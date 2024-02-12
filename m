Return-Path: <linux-kernel+bounces-62486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D0852186
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED35A1C22FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7329945C08;
	Mon, 12 Feb 2024 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPy1wjLl"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA438F82
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777248; cv=none; b=CEu65tF/Wx+mCEDuaEHgwIlXFrdnxLNQP6YgDyvBlVLf5zVDEbj1iicONqzLG+cG8H0YliYfkkDLlUn1yH0F6A/3ya8t8J44mCK8EJ7+1dqR4MQEDznB9pp4+8L/G7EAqIkJhKkaUm5qsWkTvUq7Th0zjOsG9EAt1V8D+yBPoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777248; c=relaxed/simple;
	bh=N9klKbBBWrO6YDy/Y/gwHH76mhGijD+McU3oskZWhfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiwq2tmdNY+0H7NhlAGJumutPVDq9ehhhgZ9oZpCqgxDRNWXzG1ef7zVhK/+kglBun3imGJXn9PHl/YbPmeAACOA6fp9WWdDq07ftdrRhXjbc52BcS7gvESOyvkHevdIselGdZFfE0a89xiCZJ6cSUFImXkHcVl0GDvRia8oi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPy1wjLl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so3579311276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777246; x=1708382046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9klKbBBWrO6YDy/Y/gwHH76mhGijD+McU3oskZWhfs=;
        b=QPy1wjLldJJ3uGF7qngzcTmhcBJx27+TEnsdeigXds1/5zO/2ACv8F70T7qaHflMfg
         tSbnWLCoopZvz9pdtJGvQNYlbBcnMjW5xZIP+jyPbFpIrK+czljI1FKllDwRR/Z4RvuQ
         jSAqS4vyx59ZPre7/LvaDC7e2NzW8Z/YImssrU/R6qUHHYs6TbwSZ4rTJQl1XWPFHpmj
         +dQnbt7YAJqvS9qSdTHiH5gzC11O5ZJlx/cI7Fbb98YeSnaATdjprrb22R2EmIl4Ir3Z
         NTNrwbKvrJBd4bg7brvmNkL2DEuy5P0JzfGrtDEWHY+IMniywcZQO+zau6yWj4J7qhea
         60uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777246; x=1708382046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9klKbBBWrO6YDy/Y/gwHH76mhGijD+McU3oskZWhfs=;
        b=qHYqNGNgOIkiRS95PcsYFKRR56lScWgwCLacHXEb/5VWhcF5Nq7b/oWwHSf5Lzs44m
         niXRtaAKw5723T4MIAdAdnfyONkR6hb95iqAMMI7Oi0u7zH13PVhwz04RZJPhi0kaSjQ
         fYuKYnuIYJDNWRllagGq692+quRUTGFCBZmX+91j1d/ArN9dNROMDr8WbWvgzhbbYqDs
         /oCDVLqGrklUDHl64zBe9Zhub8+XHVVNmfBtf1+JuMG4E4Ye6c/9HVMFJNidanhBeTuQ
         HtBGlHT/Q0IS7TVLJnKmJ5sBy+nC3RdGYg3FRHSMiljYzMIZUoG9z4hOCUcLZOpV350Y
         sOfg==
X-Gm-Message-State: AOJu0Yy+0L/HkLAbVz6x6uT3jf/+FuzUTU/SSMo4+uFB0O/bt45pA0Kf
	5TpP9prIbyzzHlMiML28Zwh9X2DyGuU4sm0lme/sBpOCX4TIp5t14ZJvKp7sHU7MZIJeQCU8IJ2
	nsnwDNJNhmQAuyUzs6T5bKwxg3vc/fKvsCQs=
X-Google-Smtp-Source: AGHT+IForYoMHd5U4jrWBiSp9PAkMN2K2qdi5WR+NT1sF+FQpphbq9AMB0vkvbuHdsbjqyf2sltGvzzWyg3AiGr9ZHk=
X-Received: by 2002:a05:6902:150d:b0:dc2:6f92:2ec0 with SMTP id
 q13-20020a056902150d00b00dc26f922ec0mr8421208ybu.51.1707777246322; Mon, 12
 Feb 2024 14:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com> <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2024 23:33:55 +0100
Message-ID: <CANiq72nvp=QtgU=eb9EADqR45Zd5gxMfhWaZ9ZURgCDdtwHGoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I have no time for this, but since it looks like I'm the main
> contributor for the last few years to the subsystem, I'll take
> it for now. Geert agreed to help me with as a designated reviwer.
> Let's see how it will go...

Thanks Andy, I appreciate it:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

if you want to already take it yourself :)

Otherwise I can pick it up.

Cheers,
Miguel

