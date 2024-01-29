Return-Path: <linux-kernel+bounces-43154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB651840C82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779CE28A265
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D7215699A;
	Mon, 29 Jan 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OdudcxDA"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E8157E6D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547295; cv=none; b=uYKCZnt1ZE9ouFExnxYkuXdfeCt5C+TVNCs1XYzKDmiEp7xYpdg5+H9n50d5rWJ4aSeGVk/th1ix+10ZwVCUWrN1bznJN9De3LOd2a68MtnxrGvG0sW7AmhQNbrfUjCLlnLJ+yFeUrZ2iQWTCAvFKyK5IwScYs4qB3RA/YkqNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547295; c=relaxed/simple;
	bh=Jt+LiN/noCq7Ty1uEN6t2Ox1ZFOSRbxHqFfobXnTMR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpwL//hGhOx2BVIUqjuwbDKz3eSq8r//g8Ph8h8IeYksccFFaF8yk0e4C5eG9a8Q3y3+7GoIoIxmJh4wURxuvN7ym56QoatO7QrKxmKs3Z0veXKJ6mttdTuPPGeH+vNL5a3ZES7bqxUeJoBWAU7/8VCuI4Y6IocFTUgRHvPMusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OdudcxDA; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc22ae44595so3256001276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706547292; x=1707152092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJSj/N6Zg4F+lG6KjfxIFFgsTp8LvTjrWxVd0svGSOQ=;
        b=OdudcxDAxsC7Mj+ANnAREQa3JXWVhMSMvTsaTJ0ZmrEDmnsL83FtAFQzCiMrtJ3NFs
         cPkUM3mJCixuqMtpTXa9KgsDJajEyMZqIpgVsW26djQ8a8BzLedTK01KGkAgggRid8zZ
         uqhsptsCIXemQGIkYeOMb7XMVr/ztzkYAl+6KHe8u2ucGQ+u25hCCNSyGTBXek8v7XOu
         gxDYSrKSBxZ3pXpNnXVOWtix5l5ejnVLrAsu8sW5gAlmiyLhlw5IkcaD1EpKKLT38MkO
         DrB+XXoY6wlIGWJVdJFCb3OdY4ijVcSTSvY+TaMXTzF1PFHu5DEbTtI9vzJAHLOhdWEW
         Celg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706547292; x=1707152092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJSj/N6Zg4F+lG6KjfxIFFgsTp8LvTjrWxVd0svGSOQ=;
        b=DjI290HnXxlG+ybkysD5Q/iCYmUtpMWbvzkCN5CyPcSQfv4n58rSs8ewF7U+yupSt7
         sYliGq3V2SHJpvEklFSeQb69iXgVwchrxikEnW09+bfGyl9DCtOiNkNQISv0did6F22V
         y1twPSoIwLL1bwJsNof34qM1cHenUSyoW8oBmsgvPMUFbJarCjo0mL7Bsi09C16OmkQe
         fXlO3VaQlMqBwXi2hqtNPSFKxuFfbc1cG2fWdvScx20j41/cya0Tun1wPkT9ZVr04/jF
         UP3ZgEhkOPW90KyHweD9Dvn+inE/mcyLVagFHjMfJHnfb/qC5FP4HFo4zJSphLZLVtL0
         XhSg==
X-Gm-Message-State: AOJu0YxRbebfIncFq5U81RGsFTARAYfpC3/PsgEkHunMCHYqKQh09P/X
	vpH0q+35PCH/BqSygvakEzCDJ/3NebyOHkjmXUrfeKWCK5eE+jKbaj8BHrXNB7IkLYD0HjR43lT
	kXnwHjcxAgGmS/DEmNdh2ScWY10NafYTQ2Clj
X-Google-Smtp-Source: AGHT+IF8X1D+bWyAPQJNFbX1ZiVwTlYzbSpwWMXDZMU7ADUl9sQfUKA8+DOt9TS5idgvImt1O8TW1U0zl1KsysUVJSw=
X-Received: by 2002:a25:ad99:0:b0:dc2:3f74:c507 with SMTP id
 z25-20020a25ad99000000b00dc23f74c507mr3318675ybi.33.1706547292625; Mon, 29
 Jan 2024 08:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbfMuAlUMRO9Hqa6@kernel.org>
In-Reply-To: <ZbfMuAlUMRO9Hqa6@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jan 2024 11:55:17 -0500
Message-ID: <CAHC9VhTX4k5YMLoqkkosB7_RVOT3-pC-e2kW5c3UjunFjooKMw@mail.gmail.com>
Subject: Re: [PATCH 1/1 fyi] tools headers UAPI: Sync unistd.h to pick
 {list,stat}mount, lsm_{[gs]et_self_attr,list_modules} syscall numbers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:05=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> tldr; Just FYI, I'm carrying this on the perf tools tree.

Thanks.

> So its important not to touch the copies in tools/ when doing changes in
> the original kernel headers, that will be done later, when
> check-headers.sh inform about the change to the perf tools hackers.

We had a chat with Linus about this during this past merge window and
I've made a mental note not to update any syscall numbers under tools/
in the future.  I apologize for any problems here, believe it or not
we were trying to be helpful ;)

--=20
paul-moore.com

