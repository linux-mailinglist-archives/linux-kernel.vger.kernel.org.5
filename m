Return-Path: <linux-kernel+bounces-100464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08F8797D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9690285ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227A7C6E5;
	Tue, 12 Mar 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4m6k7XQ"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C67C0B1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258173; cv=none; b=bhLeRgdZX0brK8eZY2kYiZyL7vQNuo1jvMn1jRTCNPKBcfLSfHYyY3oZeGneQNfsssRFzAUg6hd/FClINqW3+HadvzTHRQL481QDra/tQlT1tQ9Ov6RMF4WWdR6ndXbRA1Sjmict17GvwP9RVkMqM04djYOTD88L205fRkgnyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258173; c=relaxed/simple;
	bh=D2tjCaFOD85nEnhCR05G4D9nbK1x8BdziW9THhyUTAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSA755jBywvWspmBnyn7hFlFJQY4TD0abtxW5hoGSFZTignlrIOqRl3wm/fVf5+BB5TdU1DuSLUDh2fbyk0JRyx4aXrXVbSPsJ0UWiO/bKvAp7UuszXzSUGrFHLYxINeG5i9RLMjLuZskCr/OZt9GUmVaJh18uciuQs8589yspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4m6k7XQ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3666ffc850eso51405ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710258170; x=1710862970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2tjCaFOD85nEnhCR05G4D9nbK1x8BdziW9THhyUTAY=;
        b=i4m6k7XQaNWFGX8iEZbaov2f1OT6TCHT/gCJoVXTr4qX/RkFx3iIp7LrIkwwJ/vb7q
         5dXYU9BXAbPSdyYY5RyqNRnfP2QKEMHSBGRzhri41H5avGIK8zm8dAi7YSoMc3oY8M3t
         5SSqGucfUhVwVIszA7SWs38sEZrrwHnIwxHY+0Sp4c5XayQfKhBTAi256vXh1/e6Jk+C
         vKx4TKBPyxDBFZyt4cpASIooQA/Vx21aMVHbQdjVKDrExO7QXvysoyD3N9qQItHq0Thb
         vKLnMlMV5XJ6REJwrDzjm8CdbEAGy54oaP8nXck687ZNRStjGXM9oC72bvA+PxWxuqe4
         3RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710258170; x=1710862970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2tjCaFOD85nEnhCR05G4D9nbK1x8BdziW9THhyUTAY=;
        b=THY+/6yvMXyTNYYVwMijaGdMTe9XMlfe+FQHTn+1sfb4uRq3dC0BHQyYYB53QKwgGO
         J4jY9tNkDtrKzTCySSLEEZrpHN/g+Vv/DaCrdWUnfAyPyQKE4gbPW+caszxeiBTDsYzd
         cD5jttvl+BSKUQe8/9jto8Rhn1wfSDposfTjSmVq41VS8zc0qZPKE7iJxkMvx1VFtVhT
         /jrj6G2+hs7zFAvbCIZfpC6ukVeMIpqYgr3f5mdbfiLWVyRWEP42TaqcM2GrBvdJZMet
         cyffJohny6zk9H2HyCHKLK/vRWAT4WQgnILtMxRFKX2eHTrTnwWHVsG9ZdEmC1akGjs1
         Z20w==
X-Forwarded-Encrypted: i=1; AJvYcCWVzQB6rRXCTLZzISyxBjV6Seie7n6Dz9QkppEN+ywIJAF5B7lZ35AQ1N8jBBB0A00z1yj2QWJul8RH08O82mVaqHg1tibAY47hzcdP
X-Gm-Message-State: AOJu0YxweX70W2Ne7Y+QlDs3njUNUn1x2OscHd6Yx3AIP65Ipf4SjmDh
	W/2NVwWdypDA5lGT9Z4HhV5nza6sJYJK5+eZuxPCtD5bT/pO5/FnRSfo0CMqS+Qp7ew4lQTcwaV
	wi+Ht9FT3hbYcyNXAXirFIBuIu+8LlQAyBHr/JqJ+DZlqDyoNfQ95lQk=
X-Google-Smtp-Source: AGHT+IGyr7fkPVmix7QIrcf09wKbqAG8ltOURX3fpz48z+SfwWPk4mdK5NdWsXlA1EfCdZ2UKlHIGUs11L92l22VPFs=
X-Received: by 2002:a05:6e02:1ca5:b0:365:fe08:6ec5 with SMTP id
 x5-20020a056e021ca500b00365fe086ec5mr259243ill.12.1710258170384; Tue, 12 Mar
 2024 08:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Ze9vjxv42PN_QGZv@x1> <Ze93VPYpegMMt5kk@x1>
In-Reply-To: <Ze93VPYpegMMt5kk@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Mar 2024 08:42:36 -0700
Message-ID: <CAP-5=fWw8qGB4Djm34_Apjf6jEk+LdhKP2pSkF2Z2q-qWW1UPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf beauty: Move uapi/linux/fs.h copy out of the
 directory used to build perf
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:27=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> It is mostly used only to generate string tables, not to build perf, so
> move it to the tools/perf/trace/beauty/include/ hierarchy, that is used
> just for scrapping.
>
> The only case where it was being used to build was in
> tools/perf/trace/beauty/sync_file_range.c, because some older systems
> doesn't have the SYNC_FILE_RANGE_WRITE_AND_WAIT define, just use the
> system's linux/fs.h header instead, defining it if not available.
>
> This is something that should've have been done already, as happened
> with the linux/socket.h scrapper, do it now as Ian suggested while doing
> an audit/refactor session in the headers used by perf.
>
> No other tools/ living code uses it, just <linux/fs.h> coming from
> either 'make install_headers' or from the system /usr/include/
> directory.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/CAP-5=3DfWZVrpRufO4w-S4EcSi9STXcTAN2ER=
LwTSN7yrSSA-otQ@mail.gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

