Return-Path: <linux-kernel+bounces-89058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6034F86EA13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEF128219E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548E3C06A;
	Fri,  1 Mar 2024 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbhQTC98"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642523BB52
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323857; cv=none; b=kFV2603ZwIG7fN1M1ssC8ChXCCOFNaTycVqRDGEqLnC7AtR8T/yBjrzKVNuS1mPogdMG5frZJzDYFwHYU0gDzgmoBpm88FGN8M8h+X48UxLsJCyYeYxZmPoEyFjRvQSThievuFJNnZoJxCAitNLqiyAAvFxUsBO0M00GnaIbUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323857; c=relaxed/simple;
	bh=eIlmeeWJ+q21jvedK7al42fEAfG42vJONf3MXPx/cRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vxl7T4Emi3CmhYrkMoQGIi+GxuOpJUQ3wmbsFIKoBdh4fCXbxwncAfWNDMR8s6Ygb8+g+M/Uw4gEVvNqP0/Cu9hH9cfpEDhIK085P+Yph0yWTBwDksWY44iKNoEbz6ggP017DaHts9AwFat6GTBADOXvKUMwKgjbfeQ1BZJ7nng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbhQTC98; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so459806566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709323853; x=1709928653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GjHlLe8ifOuwGHIPhGu9Px14t+AYIlwm+A28Gp3fNW8=;
        b=JbhQTC98JdHfGNFyO4r5pc4+JyvgS0jT/zfZ2tHv8dMGxTKBWofqfG0sIlp9FVjyym
         YkPbFern0AxJT78q08PcRbeXB4TVeLLNHa42/QAJNyIcvN3gPH3UMLRHe8ltEiyVzvTr
         YhW8i9epCHCzcb62oIk8PlyBXhC7DFtYGNwfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709323853; x=1709928653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjHlLe8ifOuwGHIPhGu9Px14t+AYIlwm+A28Gp3fNW8=;
        b=cBdHmoD3jxi1lfVvOjTIaHfmLMunC9Dn1neACAZk8gk0kfX/UoapllI9pIGmFc5fca
         rxs3vquaS76tM6Fblyu9ePPI77zq59Bo0bRXUsfq4+YQi7t86OGSbMTzXquXu6ukUVfK
         99J6+SIjsWin5qJxtI7rGRN1fngadSGL/6mYGPbn/k9lCGm52xpvlBITQBR86mmQpmWV
         I6j7dyXp0iDiilhmXkAPKvjYwfSqGopQogQ2nrHapEZI9dXRWwZI8ZQeR13B8Ro0d2GS
         IPDICc/xrXSebAfZFGt0oZZ3b4sv7MokSXtLGYlgbejSpY4rcPXzy2ACyRhkQzcLfpTf
         5CMw==
X-Forwarded-Encrypted: i=1; AJvYcCVxZfpsesxLVBVcbVUYtldURBh9SDr0STv6Xs7VsCzaww9iPedcE0HJEQXMeWKy8AaqHx/hs7sHMX7E0cYCcYx2Ut5EvS8mQWK+JlYI
X-Gm-Message-State: AOJu0Yy0EWMJ1IiOEIDFHOkOz5LTzYcCvQHgsrdHtyWY6Fa2/jvm9sP3
	60g9LCun8xhWdzcb1P7AUEQEWhzDd5ui2f1Mt5NGBJsLw3k9T+aixdc719BD+HBg3l4ORGrPIaY
	Jya60FQ==
X-Google-Smtp-Source: AGHT+IFkglEHRXmwFw5poY/bev1oCscuuPULiQOtJhKY8HaEi1Ofp/F6I2SixbuLrOlPzuWuiZkyuQ==
X-Received: by 2002:a17:906:ecea:b0:a44:6c90:fe80 with SMTP id qt10-20020a170906ecea00b00a446c90fe80mr2028903ejb.68.1709323853748;
        Fri, 01 Mar 2024 12:10:53 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id ss11-20020a170907c00b00b00a446498b96fsm1405766ejc.191.2024.03.01.12.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 12:10:52 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so459803566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:10:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd84XRGVHqMYj8BKvFT7GOHOoWHLOMKT4nRPTo8+yVmjmoITnh/sqRJNTB+HE4lucp5g7TJ+GN5R039vfVkcn1wJbNRnZv7nfmwa2Y
X-Received: by 2002:a17:906:e08d:b0:a44:731c:bace with SMTP id
 gh13-20020a170906e08d00b00a44731cbacemr2324717ejb.35.1709323852310; Fri, 01
 Mar 2024 12:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
In-Reply-To: <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 1 Mar 2024 12:10:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
Message-ID: <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Helen Koike <helen.koike@collabora.com>, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 02:27, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>
> I agree, it's hard to imagine even a simple majority agreeing on how GitLab CI
> should be done. Still, we would like to help people, who are interested in
> this kind of thing, to set it up. How about we reframe this contribution as a
> sort of template, or a reference for people to start their setup with,
> assuming that most maintainers would want to tweak it? We would also be glad
> to stand by for questions and help, as people try to use it.

Ack. I think seeing it as a library for various gitlab CI models would
be a lot more palatable. Particularly if you can then show that yes,
it is also relevant to our currently existing drm case.

So I'm not objecting to having (for example) some kind of CI helper
templates - I think a logical place would be in tools/ci/ which is
kind of alongside our tools/testing subdirectory.

(And then perhaps have a 'gitlab' directory under that. I'm not sure
whether - and how much - commonality there might be between the
different CI models of different hosts).

Just to clarify: when I say "a logical place", I very much want to
emphasize the "a" - maybe there are better places, and I'm not saying
that is the only possible place. But it sounds more logical to me than
some.

            Linus

