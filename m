Return-Path: <linux-kernel+bounces-139587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CA8A04D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121951C23348
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981ED8BE7;
	Thu, 11 Apr 2024 00:31:00 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADDA48;
	Thu, 11 Apr 2024 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712795460; cv=none; b=l7L5sMF8sJ9j9x+7HipdbItsduq7WXa7XToGts8taFdgve0gGDptRnMWh/A2dxN0vtkUVQKNLhOQ6DecSZIhHNxgPiG7Vs4E97EV321FNjS6iz5HXoymTXpVvTrbswOtcqo0YpqjyDgkI8DmTegFnU35kxx649dq7aU06ebNNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712795460; c=relaxed/simple;
	bh=8OkLeX6L0u/KEaGRQJ+X3tCW5fywwq58y3T54hErp0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkVDuL6ZzgpNBz8hrEpr0KwM3KzLZotICI1itaaCU1n2KOMI6DDWWWVZNRzOZ1FFAt9kOpITyZexUCpm9t2Qcp7PpUIFb/zFyvM21rmj/0EDGUiC7Fdbu2vHL99XWgDyjClBsSw6vuqsLgkr83foa87gFbyPnBQfJy+CwLIPBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a52c544077so2669676a91.1;
        Wed, 10 Apr 2024 17:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712795458; x=1713400258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suv3ipWFwE695qY+oEWHhKuh1Qf07FjcpBu2cm2rvPQ=;
        b=Or1QEsBrX7drn/pW6BCsYZNWFrJtT8NzKRhVVCdRNvGWJZ7PBjFAATsQq2kLSl/uHh
         lUH+xKGylGthmO6lWBBz4/Fg/3ufxKyiMoI35t6jbEg3L4gmqVq2SEeledu1NvvCzPhs
         HuSsqp5p5OlC37cH6OYWQ/pQQLkmqvVQuqItAr0w40ery6h5UBOcEjXkdaIvTGoHEQgv
         AqrXTQNzXgwZsjz48k1PHHOYGU1EJcvwlEJOTc+Z1ZeaZyEZRsvowPPLV7JM3HP4L/Bc
         PVFL3UNDnAk0EEt5UfeYRifI5yHmR4CDMNFfyxvVB48OntxaJBWTXmgkwcDB6aqLnZdn
         brIg==
X-Forwarded-Encrypted: i=1; AJvYcCVyP1/RmE7eXmBiWakXsvOcIWbYPC5mx/g6vnbvN3Uum5oFqTRkIqiW7VaMo7JtNBtHDYVi+CK4t7r03bmHSD2eMRrk1ffAXb6K0XEHuUXfKd02yQoZLlPBqXTJoh2blzYsn9F91/FTTKtnBIs+2Q==
X-Gm-Message-State: AOJu0YwtoWDbjMKqKPKQMEs/TfrFxTM6BMkKn2HbfkcJpfY/C6uMddnH
	tYBJ0DuFjHCznRO9J0xd6xw3dggEyCBRVpd9uM1634+CWaBtN5GUygoosGXxdXnu6xE6z8fYO6b
	GO5zkjkpPJ03Ha4TUCq1MLdydggl8eA==
X-Google-Smtp-Source: AGHT+IGAepPRcEAw0tCTCBOk+Lxlg4YemB/CwiIl/9ioHDLg44dm6R72zXqrr8iK53EX+DI3iWRt7fSpALvbG+C7mrQ=
X-Received: by 2002:a17:90a:7781:b0:2a5:379a:e2c with SMTP id
 v1-20020a17090a778100b002a5379a0e2cmr3813848pjk.7.1712795457898; Wed, 10 Apr
 2024 17:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409235000.1893969-1-namhyung@kernel.org> <20240409235000.1893969-6-namhyung@kernel.org>
 <Zhb6jJneP36Z-or0@x1> <Zhb7pPySSGnIU3bO@x1>
In-Reply-To: <Zhb7pPySSGnIU3bO@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 10 Apr 2024 17:30:46 -0700
Message-ID: <CAM9d7choZ7WQXa_+RWm-eODjah+k_A5T3eSFXWFYRqTO5euyxg@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf report: Add a menu item to annotate data type in TUI
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 1:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> (gdb) bt
> #0  0x00007ffff6ebd385 in __GI___libc_free (mem=3D0x69647225202c3866) at =
malloc.c:3368                                                              =
                                            =E2=96=92
> #1  0x000000000066c2c0 in delete_data_type_histograms (adt=3D0x8dedf0c0) =
at util/annotate-data.c:1655                                               =
                                            =E2=96=92
> #2  0x000000000066c363 in annotated_data_type__tree_delete (root=3D0xe6bc=
68) at util/annotate-data.c:1669                                           =
                                            =E2=96=92
> #3  0x0000000000553bc5 in dso__delete (dso=3D0xe6bbd0) at util/dso.c:1376=
                                                                           =
                                            =E2=96=92
> #4  0x0000000000553d63 in dso__put (dso=3D0xe6bbd0) at util/dso.c:1409   =
                                                                           =
                                            =E2=96=92
> #5  0x000000000057ed76 in __dso__zput (dso=3D0xf5b540) at util/dso.h:262 =
                                                                           =
                                            =E2=96=92
> #6  0x000000000058027e in map__exit (map=3D0xf5b520) at util/map.c:300   =
                                                                           =
                                            =E2=96=92
> #7  0x00000000005802bc in map__delete (map=3D0xf5b520) at util/map.c:305c=
ord -b ... ; perf report --total-cycles                                    =
                                            =E2=96=92
> #8  0x0000000000580325 in map__put (map=3D0xf5b520) at util/map.c:312
> #9  0x00000000005818aa in __map__zput (map=3D0xf3e300) at util/map.h:196
> #10 0x0000000000582241 in maps__exit (maps=3D0xf5aee0) at util/maps.c:246
> #11 0x000000000058233c in maps__delete (maps=3D0xf5aee0) at util/maps.c:2=
68
> #12 0x00000000005823fd in maps__put (maps=3D0xf5aee0) at util/maps.c:285
> #13 0x000000000055c4ca in __maps__zput (map=3D0x47856d8) at util/maps.h:3=
2
> #14 0x000000000055c55f in map_symbol__exit (ms=3D0x47856d8) at util/map_s=
ymbol.c:8
> #15 0x00000000005c36bf in hist_entry__delete (he=3D0x4785660) at util/his=
t.c:1319
> #16 0x00000000005c1049 in hists__delete_entry (hists=3D0xe68fe0, he=3D0x4=
785660) at util/hist.c:382
> #17 0x00000000005c1197 in hists__delete_entries (hists=3D0xe68fe0) at uti=
l/hist.c:410
> #18 0x00000000005c7a4d in hists__delete_all_entries (hists=3D0xe68fe0) at=
 util/hist.c:2872
> #19 0x00000000005c7ac7 in hists_evsel__exit (evsel=3D0xe68d70) at util/hi=
st.c:2884
> #20 0x0000000000531928 in evsel__exit (evsel=3D0xe68d70) at util/evsel.c:=
1489
> #21 0x000000000053196d in evsel__delete (evsel=3D0xe68d70) at util/evsel.=
c:1497
> #22 0x0000000000526a70 in evlist__purge (evlist=3D0xe67a00) at util/evlis=
t.c:163
> #23 0x0000000000526b7d in evlist__delete (evlist=3D0xe67a00) at util/evli=
st.c:185
> #24 0x0000000000585fd8 in perf_session__delete (session=3D0xe670a0) at ut=
il/session.c:313
> #25 0x0000000000434503 in cmd_report (argc=3D0, argv=3D0x7fffffffe430) at=
 builtin-report.c:1828
> #26 0x00000000005062c3 in run_builtin (p=3D0xe3f160 <commands+288>, argc=
=3D3, argv=3D0x7fffffffe430) at perf.c:350
> #27 0x0000000000506532 in handle_internal_command (argc=3D3, argv=3D0x7ff=
fffffe430) at perf.c:403
> #28 0x0000000000506681 in run_argv (argcp=3D0x7fffffffe21c, argv=3D0x7fff=
ffffe210) at perf.c:447
> #29 0x0000000000506978 in main (argc=3D3, argv=3D0x7fffffffe430) at perf.=
c:561
> (gdb)
>

Thanks for the report.  I think I missed stack canary not handling
histogram updates.  The data file I tested with TUI didn't have an
entry for stack canary so I didn't catch this.  For some reason, I
still cannot reproduce it on my box.  Anyway I will fix in v2.

For the verification, it'd be nice if you can print the type name
in the delete_data_type__histogram().

  (gdb) p adt->self.type_name


Thanks,
Namhyung

